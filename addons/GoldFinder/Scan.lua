-- GoldFinder -- Scan
-- Records auction house prices for crafting materials. GoldFinder never queries
-- the auction house itself. It listens for results that are already arriving
-- -- from Auctionator's scans, from Blizzard's Buy tab, from anything -- and
-- records what it sees. One query feeds every addon; GoldFinder never spends
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
local LE_TRADEGOODS = (Enum and Enum.ItemClass and Enum.ItemClass.Tradegoods) or LE_ITEM_CLASS_TRADEGOODS or 7
local LE_REAGENT    = (Enum and Enum.ItemClass and Enum.ItemClass.Reagent) or LE_ITEM_CLASS_REAGENT or 12

local MATERIAL_CLASSES = {
    [LE_TRADEGOODS] = true,
    [LE_REAGENT]    = true,
}

local CHUNK              = 250  -- snapshot listings read per frame
local SETTLE_SECONDS     = 2    -- quiet time before a browse capture closes
local HISTORY_PER_ITEM   = 30   -- price points kept per item
local CAPTURES_KEPT      = 100
local SAME_POINT_SECONDS = 600  -- two sightings this close are one data point
local ANNOUNCE_ROWS      = 200  -- only scan-sized captures get a chat line

ns.diag = { replicate = 0, browseUpdated = 0, browseAdded = 0, duplicates = 0, skip = nil }
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

local itemCategoryCache = {}
function ns.GetItemCategory(itemID)
    if not itemID then return "other" end
    local cat = itemCategoryCache[itemID]
    if cat ~= nil then return cat end

    local _, _, subType, _, _, classID, subClassID = C_Item.GetItemInfoInstant(itemID)
    local subLower = subType and subType:lower() or ""

    if subClassID == 9 or subLower:find("herb") then
        cat = "herbs"
    elseif subClassID == 7 or subLower:find("metal") or subLower:find("stone") or subLower:find("ore") or subLower:find("mining") then
        cat = "mining"
    elseif subClassID == 5 or subLower:find("cloth") then
        cat = "cloth"
    elseif subClassID == 6 or subLower:find("leather") or subLower:find("hide") or subLower:find("scale") then
        cat = "leather"
    else
        cat = "other"
    end

    itemCategoryCache[itemID] = cat
    return cat
end

---------------------------------------------------------------------------
-- A capture collects rows, then folds them into per-item history.

local function NewCapture(source)
    return { source = source, rows = {}, nRows = 0, materials = 0,
             seen = {}, distinct = 0,          -- every row key, material or not
             seenItems = {}, distinctItems = 0, -- every itemID, material or not
             noInfo = 0, unknownClass = 0, noPrice = 0, noItem = 0, skipped = 0 }
end

-- key: unique per row within this capture (item key for browse, listing
-- index for snapshots). A browse row seen twice replaces itself.
local function AddRow(c, key, itemID, price, qty, name, itemKey)
    -- Count distinct rows and distinct items before any filtering. Browse
    -- rows are per item *key* (item + level + suffix), so one item can have
    -- several rows. Measured on 70009: ~4571 distinct rows per Full Scan
    -- where Auctionator reports ~2088 "items" -- NOT repeats, as first
    -- assumed (de-duplicating rows moved the count by 5). Both counts are
    -- shown so the relationship can be read rather than guessed.
    if not c.seen[key] then
        c.seen[key] = true
        c.distinct = c.distinct + 1
        -- Fingerprint inputs, over every distinct row (see Finish).
        c.fpPrice = (c.fpPrice or 0) + (price or 0)
        c.fpQty = (c.fpQty or 0) + (qty or 0)
    end
    if itemID and not c.seenItems[itemID] then
        c.seenItems[itemID] = true
        c.distinctItems = c.distinctItems + 1
    end
    if not itemID then c.noItem = c.noItem + 1; return end
    if not price or price == 0 then c.noPrice = c.noPrice + 1; return end
    local class = ClassID(itemID)
    if class == false then c.unknownClass = c.unknownClass + 1; return end
    if not MATERIAL_CLASSES[class] then return end
    if not c.rows[key] then
        c.nRows = c.nRows + 1
        c.materials = c.materials + 1
    end
    c.rows[key] = { itemID = itemID, price = price, qty = qty or 0, name = name, itemKey = itemKey }
end

local function Finish(c, totalRows)
    local db = ns.db
    if not db then
        diag.skip = "A capture finished before saved data was ready, so it was not recorded."
        return
    end
    local now = GetServerTime()

    -- The client re-delivers its cached browse list without a new query:
    -- observed on build 70009, where each click in Auctionator's Selling tab
    -- fired AUCTION_HOUSE_BROWSE_RESULTS_UPDATED and GetBrowseResults()
    -- returned the previous Full Scan (248 materials, every click). Recording
    -- that again would stamp old prices as current. A result set identical
    -- to the last one recorded carries no new information, so it is counted
    -- and dropped. Saved, so a /reload cannot replay it either.
    local fingerprint = ("%d:%d:%.0f:%.0f"):format(
        totalRows, c.distinctItems, c.fpPrice or 0, c.fpQty or 0)
    local isDuplicate = false
    if fingerprint == db.lastFingerprint then
        if c.source == "browse" then
            -- Client re-delivers cached browse results on tab clicks; drop if within the sighting window (10 min)
            if not db.lastScanTime or (now - db.lastScanTime < SAME_POINT_SECONDS) then
                isDuplicate = true
            end
        elseif c.source == "replicate" then
            -- Full snapshots with identical fingerprints within 60s are debounced
            if db.lastScanTime and (now - db.lastScanTime < 60) then
                isDuplicate = true
            end
        end
    end

    if isDuplicate then
        diag.duplicates = diag.duplicates + 1
        if ns.RefreshPanel then ns.RefreshPanel() end
        return
    end

    db.lastFingerprint = fingerprint
    db.lastScanTime = now

    local perItem = {}
    for _, r in pairs(c.rows) do
        local a = perItem[r.itemID]
        if not a then
            a = { min = r.price, qty = 0, itemKey = r.itemKey }
            perItem[r.itemID] = a
        end
        if r.price < a.min then a.min, a.itemKey = r.price, r.itemKey end
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
        -- The exact key (item + level + suffix) of the cheapest variant, so a
        -- click can open precisely those listings. Plain fields only: this
        -- table is saved, and the save path takes nothing it cannot write.
        local k = a.itemKey
        if type(k) == "table" and k.itemID then
            rec.itemKey = { itemID = k.itemID, itemLevel = k.itemLevel or 0,
                            itemSuffix = k.itemSuffix or 0,
                            battlePetSpeciesID = k.battlePetSpeciesID or 0 }
        end
        local h = rec.history
        local last = h[#h]
        -- One point per sighting window. The window is anchored at the
        -- point's FIRST sighting (t) and never moves: before v0.0.5 it was
        -- measured from the latest sighting and slid forward on every
        -- merge, so scans a few minutes apart never produced a new point
        -- (measured: 21:50..22:04, seven scans, one point). Within the
        -- window the newest prices win; `seen` records when.
        if last and now - last.t < SAME_POINT_SECONDS then
            last.min, last.qty, last.src, last.seen = a.min, a.qty, c.source, now
        else
            h[#h + 1] = { t = now, seen = now, min = a.min, qty = a.qty, src = c.source }
        end
        while #h > HISTORY_PER_ITEM do table.remove(h, 1) end
    end

    local summary = { t = now, source = c.source, rows = totalRows,
                      distinctItems = c.distinctItems,
                      materials = c.materials, items = items,
                      noInfo = c.noInfo, unknownClass = c.unknownClass,
                      noPrice = c.noPrice, noItem = c.noItem, skipped = c.skipped }
    db.scans[#db.scans + 1] = summary
    while #db.scans > CAPTURES_KEPT do table.remove(db.scans, 1) end
    db.lifetimeScans = (db.lifetimeScans or #db.scans) + 1
    diag.skip = nil

    if totalRows >= ANNOUNCE_ROWS then
        ns.Good("Recorded prices for %d materials.", items)
    end

    -- Trigger deal alerts if qualifying deals are detected
    local deals = ns.FindDeals and ns.FindDeals()
    if deals and #deals > 0 then
        local top = deals[1]
        local tier = top.tier or (ns.GetDealTier and ns.GetDealTier(top))
        local isMegaSnipe = (tier and tier.id == "mega") or (ns.IsSnipeMode and ns.IsSnipeMode())

        if isMegaSnipe and ns.PlaySnipeAlarm then
            ns.PlaySnipeAlarm(top)
        elseif ns.PlayDealSound then
            ns.PlayDealSound()
        end

        if ns.IsChatAlertEnabled and ns.IsChatAlertEnabled() then
            local topName = top.name or (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(top.itemID)) or ("Item " .. top.itemID)
            local pct = math.floor(top.below * 100 + 0.5)
            local profitStr = top.totalNetProfit and top.totalNetProfit > 0 and (", est. net +" .. ns.Money(top.totalNetProfit)) or ""
            local tierPrefix = (tier and tier.id == "mega") and "|cffa335ee[MEGA SNIPE]|r "
                            or ((tier and tier.id == "great") and "|cff0070dd[GREAT DEAL]|r " or "")
            ns.Good("%sFound %d deal(s)! Top deal: %s (%d%% off%s)", tierPrefix, #deals, topName, pct, profitStr)
        end
    end

    if ns.RefreshPanel then ns.RefreshPanel() end
    if ns.UpdateBrokerText then ns.UpdateBrokerText() end
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
        AddRow(browse, key or ("?" .. browseRows), itemID, r.minPrice, r.totalQuantity, nil, k)
    end
    lastBrowse = GetServerTime()
end

local function Settle()
    if GetServerTime() - lastBrowse < SETTLE_SECONDS then
        C_Timer.After(SETTLE_SECONDS, Settle)  -- still arriving; check once more
        return
    end
    settleArmed = false
    local c = browse
    browse, browseRows = nil, 0
    if c then Finish(c, c.distinct) end
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
            local localName = (itemID and C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or (itemID and GetItemInfo and GetItemInfo(itemID)) or name
            AddRow(c, idx, itemID, unit, count, localName)
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
        return "Since login, no auction house results have reached GoldFinder. Open the auction house and run a scan or a search."
    end
    local s = ("Since login GoldFinder has seen %d full snapshot(s), %d browse update(s) and %d page(s) of browse results."):format(
        diag.replicate, diag.browseUpdated, diag.browseAdded)
    if diag.duplicates > 0 then
        s = s .. (" %d repeat(s) of already-recorded results were ignored."):format(diag.duplicates)
    end
    return s
end

-- Short footer text plus tooltip detail. Each detail is either a
-- { label, value } pair or a plain sentence string; warn marks anything
-- the player should act on.
function ns.GetScanDiag()
    return DiagSentence()
end

function ns.ScanStatus()
    local db = ns.db
    local st = { lines = {}, warn = false }
    local L = st.lines

    if not db or #db.scans == 0 then
        st.footer = "No scans recorded yet"
        st.status = "No scans recorded yet"
        st.count = 0
        st.lifetime = 0
        L[#L + 1] = "Run a Full Scan (Auctionator's works) or search the Buy tab. GoldFinder records what comes back."
    else
        local s = db.scans[#db.scans]
        local count = #db.scans
        local lifetime = db.lifetimeScans or count
        st.count = count
        st.lifetime = lifetime
        st.lastTime = s.t

        local countLabel = (lifetime > count)
            and ("%d scans (%d retained)"):format(lifetime, count)
            or ("%d scan%s recorded"):format(count, count == 1 and "" or "s")
        st.footer = ("%s, last %s"):format(countLabel, date("%H:%M", s.t))

        st.status = ("%s (%s, %d materials, %d rows)"):format(
            date("%Y-%m-%d %H:%M", s.t),
            s.source == "browse" and "Browse" or "Snapshot",
            s.items or s.materials or 0,
            s.rows or 0
        )

        L[#L + 1] = { "Last scan", date("%Y-%m-%d %H:%M", s.t) }
        L[#L + 1] = { "Source", s.source == "browse" and "Browse results" or "Full snapshot" }
        if s.distinctItems then
            L[#L + 1] = { "Results", ("%d, covering %d items"):format(s.rows, s.distinctItems) }
        else
            L[#L + 1] = { "Results", tostring(s.rows) }
        end
        L[#L + 1] = { "Materials", tostring(s.items or s.materials or 0) }
        if s.noInfo > 0 then
            L[#L + 1] = ("%d listing(s) had not finished loading and may show without a name."):format(s.noInfo)
        end
        if s.unknownClass > 0 then
            L[#L + 1] = ("%d result(s) could not be classified and were left out."):format(s.unknownClass)
        end
        if s.noPrice > 0 then
            L[#L + 1] = ("%d result(s) had no buyout price and were left out."):format(s.noPrice)
        end
        if s.source == "browse" then
            L[#L + 1] = "Prices are each item's lowest listing. Per unit or per stack is not yet measured on this client."
        elseif s.skipped > 0 then
            L[#L + 1] = ("%d listing per snapshot is not read, until the index numbering is measured."):format(s.skipped)
        end
    end

    L[#L + 1] = DiagSentence()
    if diag.skip then
        st.warn = true
        L[#L + 1] = { warn = diag.skip }
    end
    return st
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
    if ns.UpdateBrokerText then ns.UpdateBrokerText() end
end)
