-- GoldFinder -- Scan
-- Records auction house prices for crafting materials. GoldFind never queries
-- the auction house itself. It listens for results that are already arriving
-- -- from Auctionator's scans, from Blizzard's Buy tab, from anything -- and
-- records what it sees. One query feeds every addon; GoldFind never spends
-- the AH throttle.
--
-- Two sources, both measured-or-documented, neither assumed to be the one in
-- use:
--   * Browse results (AUCTION_HOUSE_BROWSE_RESULTS_UPDATED / _ADDED): one row
--     per item with its lowest price and total quantity. Auctionator's
--     "Full Scan (summary mode)" did NOT fire REPLICATE_ITEM_LIST_UPDATE on
--     build 70009 -- observed 2026-09-27 -- so this is the likely feed.
--   * Full snapshots (REPLICATE_ITEM_LIST_UPDATE): one row per listing.
--
-- Index base for GetReplicateItemInfo: typed `number`, where every other
-- C_AuctionHouse index is `luaIndex`. Suggests 0-based; unmeasured. An
-- out-of-range native call can crash this client and pcall will not catch
-- it, so we read 1..total-1, in range under either base, at the cost of one
-- listing per snapshot.
--
-- Every early exit records its reason in ns.diag, and the panel says it.
-- Nothing is ever skipped silently.

local ADDON, ns = ...

-- Trade goods (cloth, herbs, ore, leather...) and reagents.
local MATERIAL_CLASSES = {
    [Enum.ItemClass.Tradegoods] = true,
    [Enum.ItemClass.Reagent]    = true,
}

local CHUNK              = 250  -- snapshot listings read per frame
local SETTLE_SECONDS     = 2    -- quiet time before a browse capture closes
local HISTORY_PER_ITEM   = 30   -- price points kept per item
local CAPTURES_KEPT      = 100
local SAME_POINT_SECONDS = 600  -- two sightings this close are one data point
local ANNOUNCE_ROWS      = 200  -- only scan-sized captures get a chat line

ns.diag = { replicate = 0, browseUpdated = 0, browseAdded = 0, skip = nil }
local diag = ns.diag

local classOf = {}  -- itemID -> classID, or false when unknown
local function ClassID(itemID)
    local c = classOf[itemID]
    if c == nil then
        c = select(6, C_Item.GetItemInfoInstant(itemID)) or false
        classOf[itemID] = c
    end
    return c
end

---------------------------------------------------------------------------
-- A capture collects rows, then folds them into per-item history.

local function NewCapture(source)
    return { source = source, rows = {}, nRows = 0, materials = 0,
             noInfo = 0, unknownClass = 0, noPrice = 0, noItem = 0, skipped = 0 }
end

-- key: unique per row within this capture (item key for browse, listing
-- index for snapshots). A browse row seen twice replaces itself.
local function AddRow(c, key, itemID, price, qty, name)
    if not itemID then c.noItem = c.noItem + 1; return end
    if not price or price == 0 then c.noPrice = c.noPrice + 1; return end
    local class = ClassID(itemID)
    if class == false then c.unknownClass = c.unknownClass + 1; return end
    if not MATERIAL_CLASSES[class] then return end
    if not c.rows[key] then
        c.nRows = c.nRows + 1
        c.materials = c.materials + 1
    end
    c.rows[key] = { itemID = itemID, price = price, qty = qty or 0, name = name }
end

local function Finish(c, totalRows)
    local db = ns.db
    if not db then
        diag.skip = "A capture finished before saved data was ready, so it was not recorded."
        return
    end
    local now = GetServerTime()

    local perItem = {}
    for _, r in pairs(c.rows) do
        local a = perItem[r.itemID]
        if not a then
            a = { min = r.price, qty = 0 }
            perItem[r.itemID] = a
        end
        if r.price < a.min then a.min = r.price end
        a.qty = a.qty + r.qty
        if r.name then a.name = r.name end
    end

    local items = 0
    for itemID, a in pairs(perItem) do
        items = items + 1
        local rec = db.items[itemID]
        if not rec then
            rec = { history = {} }
            db.items[itemID] = rec
        end
        if a.name then rec.name = a.name end
        local h = rec.history
        local point = { t = now, min = a.min, qty = a.qty, src = c.source }
        if #h > 0 and now - h[#h].t < SAME_POINT_SECONDS then
            h[#h] = point      -- same sighting window: keep the newest
        else
            h[#h + 1] = point
        end
        while #h > HISTORY_PER_ITEM do table.remove(h, 1) end
    end

    local summary = { t = now, source = c.source, rows = totalRows,
                      materials = c.materials, items = items,
                      noInfo = c.noInfo, unknownClass = c.unknownClass,
                      noPrice = c.noPrice, noItem = c.noItem, skipped = c.skipped }
    db.scans[#db.scans + 1] = summary
    while #db.scans > CAPTURES_KEPT do table.remove(db.scans, 1) end
    diag.skip = nil

    if totalRows >= ANNOUNCE_ROWS then
        ns.Good("Recorded %d material prices across %d items (%s).", c.materials, items,
            c.source == "browse" and "from browse results" or "from a full snapshot")
    end
    if ns.RefreshPanel then ns.RefreshPanel() end
end

---------------------------------------------------------------------------
-- Browse results: arrive in batches; close the capture once they go quiet.

local browse, browseRows, lastBrowse, settleArmed = nil, 0, 0, false

local function AddBrowseResults(results)
    if type(results) ~= "table" then return end
    browse = browse or NewCapture("browse")
    for _, r in ipairs(results) do
        browseRows = browseRows + 1
        local k = r.itemKey
        local itemID = k and k.itemID
        local key = k and (tostring(k.itemID) .. ":" .. tostring(k.itemLevel) .. ":" .. tostring(k.itemSuffix))
        AddRow(browse, key or ("?" .. browseRows), itemID, r.minPrice, r.totalQuantity, nil)
    end
    lastBrowse = GetServerTime()
end

local function Settle()
    if GetServerTime() - lastBrowse < SETTLE_SECONDS then
        C_Timer.After(SETTLE_SECONDS, Settle)  -- still arriving; check once more
        return
    end
    settleArmed = false
    local c, rows = browse, browseRows
    browse, browseRows = nil, 0
    if c then Finish(c, rows) end
end

local function ArmSettle()
    if not settleArmed then
        settleArmed = true
        C_Timer.After(SETTLE_SECONDS, Settle)
    end
end

---------------------------------------------------------------------------
-- Full snapshots: read in chunks, one frame at a time.

local pending, running = false, false

local function ProcessSnapshot()
    pending = false
    if running then
        diag.skip = "A full snapshot arrived while the previous one was still being read, so it was not read again."
        return
    end
    local total = C_AuctionHouse.GetNumReplicateItems()
    if total < 2 then
        diag.skip = ("A full snapshot was announced but held %d listing(s), too few to read safely."):format(total)
        return
    end

    running = true
    local c = NewCapture("replicate")
    c.skipped = 1

    local i = 1
    local function step()
        local stop = math.min(i + CHUNK - 1, total - 1)
        for idx = i, stop do
            local name, _, count, _, _, _, _, _, _, buyout,
                  _, _, _, _, _, _, itemID, hasAllInfo = C_AuctionHouse.GetReplicateItemInfo(idx)
            if not hasAllInfo then c.noInfo = c.noInfo + 1 end
            local unit = (buyout and count and count > 0) and buyout / count or nil
            AddRow(c, idx, itemID, unit, count, name)
        end
        i = stop + 1
        if i <= total - 1 then
            C_Timer.After(0, step)  -- next chunk next frame; ends when done
        else
            running = false
            Finish(c, total)
        end
    end
    step()
end

---------------------------------------------------------------------------
-- Panel text.

local function DiagSentence()
    if diag.replicate + diag.browseUpdated + diag.browseAdded == 0 then
        return "Since login, no auction house results have reached GoldFind. Open the auction house and run a scan or a search."
    end
    return ("Since login GoldFind has seen %d full snapshot(s), %d browse update(s) and %d page(s) of browse results."):format(
        diag.replicate, diag.browseUpdated, diag.browseAdded)
end

function ns.ScanSummary()
    local db = ns.db
    local lines = {}
    if not db or #db.scans == 0 then
        lines[#lines + 1] = "No auction prices have been recorded yet. Run a full scan (Auctionator's works) or search the Buy tab; GoldFind records what comes back."
    else
        local s = db.scans[#db.scans]
        lines[#lines + 1] = ("Last recorded %s, %s: %d result rows, of which %d are materials across %d items."):format(
            date("%Y-%m-%d %H:%M", s.t),
            s.source == "browse" and "from browse results" or "from a full snapshot",
            s.rows, s.materials, s.items)
        lines[#lines + 1] = ("%d capture(s) recorded so far."):format(#db.scans)
        if s.noInfo > 0 then
            lines[#lines + 1] = ("%d listing(s) had not finished loading their details. They are counted by item ID and may show without a name."):format(s.noInfo)
        end
        if s.unknownClass > 0 then
            lines[#lines + 1] = ("%d row(s) could not be classified and were left out."):format(s.unknownClass)
        end
        if s.noPrice > 0 then
            lines[#lines + 1] = ("%d row(s) had no buyout price and were left out."):format(s.noPrice)
        end
        if s.source == "browse" then
            lines[#lines + 1] = "Browse prices are each item's lowest listing. Whether that is per unit or per stack has not been measured on this client yet."
        elseif s.skipped > 0 then
            lines[#lines + 1] = ("%d listing per snapshot is not read yet, until this client's index numbering has been measured."):format(s.skipped)
        end
    end
    lines[#lines + 1] = DiagSentence()
    if diag.skip then lines[#lines + 1] = "|cffff9900" .. diag.skip .. "|r" end
    return table.concat(lines, "\n")
end

---------------------------------------------------------------------------

local events = CreateFrame("Frame")
events:RegisterEvent("REPLICATE_ITEM_LIST_UPDATE")
events:RegisterEvent("AUCTION_HOUSE_BROWSE_RESULTS_UPDATED")
events:RegisterEvent("AUCTION_HOUSE_BROWSE_RESULTS_ADDED")
events:SetScript("OnEvent", function(_, event, payload)
    if event == "REPLICATE_ITEM_LIST_UPDATE" then
        diag.replicate = diag.replicate + 1
        if not pending then
            pending = true
            C_Timer.After(1, ProcessSnapshot)
        end
    elseif event == "AUCTION_HOUSE_BROWSE_RESULTS_UPDATED" then
        -- The whole list was replaced: start this capture over from it.
        diag.browseUpdated = diag.browseUpdated + 1
        browse, browseRows = nil, 0
        AddBrowseResults(C_AuctionHouse.GetBrowseResults())
        ArmSettle()
    else -- AUCTION_HOUSE_BROWSE_RESULTS_ADDED
        diag.browseAdded = diag.browseAdded + 1
        AddBrowseResults(payload)
        ArmSettle()
    end
    if ns.RefreshPanel then ns.RefreshPanel() end
end)
