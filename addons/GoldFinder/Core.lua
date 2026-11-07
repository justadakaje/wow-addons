-- GoldFinder -- Core
-- Namespace and chat output. No game API is called at file scope beyond
-- reading this addon's own metadata.

local ADDON, ns = ...

ns.addonName = ADDON
local getMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata
ns.version   = (getMetadata and getMetadata(ADDON, "Version")) or "unknown"

local LABEL = "|cffffd100GoldFinder|r"

local function emit(colour, msg, ...)
    if select("#", ...) > 0 then
        msg = msg:format(...)
    end
    print(("%s: %s%s|r"):format(LABEL, colour, msg))
end

function ns.Print(msg, ...) emit("|cffffffff", msg, ...) end
function ns.Good(msg, ...)  emit("|cff40ff40", msg, ...) end
function ns.Warn(msg, ...)  emit("|cffff9900", msg, ...) end
function ns.Bad(msg, ...)   emit("|cffff4040", msg, ...) end

function ns.Money(copper, height)
    copper = math.floor(copper or 0)
    if C_CurrencyInfo and C_CurrencyInfo.GetCoinTextureString then
        return C_CurrencyInfo.GetCoinTextureString(math.max(0, copper), height or 12)
    end
    local g = math.floor(copper / 10000)
    local s = math.floor((copper % 10000) / 100)
    local c = copper % 100
    if g > 0 then return ("%dg %ds %dc"):format(g, s, c) end
    if s > 0 then return ("%ds %dc"):format(s, c) end
    return ("%dc"):format(c)
end
function ns.ParseMoneyString(str)
    if not str or str == "" then return nil end
    str = str:lower():gsub("%s+", "")
    if str == "0" or str == "none" or str == "off" then return 0 end

    local g = tonumber(str:match("(%d+)g")) or 0
    local s = tonumber(str:match("(%d+)s")) or 0
    local c = tonumber(str:match("(%d+)c")) or 0

    if g > 0 or s > 0 or c > 0 then
        return (g * 10000) + (s * 100) + c
    end

    local plainNum = tonumber(str)
    if plainNum then
        -- Default numeric values without unit suffix to gold (e.g. '10' -> 10 gold)
        return math.floor(plainNum * 10000)
    end
    return nil
end


-- Settings accessors with safe defaults
function ns.GetDealRatio()
    local s = ns.db and ns.db.settings
    return (s and s.dealRatio) or 0.70
end

function ns.SetDealRatio(ratio)
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.dealRatio = ratio
    end
end

function ns.GetMinPrior()
    local s = ns.db and ns.db.settings
    return (s and s.minPrior) or 3
end

function ns.SetMinPrior(n)
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.minPrior = n
    end
end

function ns.GetSortBy()
    local s = ns.db and ns.db.settings
    return (s and s.sortBy) or "profit"
end

function ns.SetSortBy(mode)
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.sortBy = mode
    end
end

ns.SOUND_CHOICES = {
    auction = { name = "Auction Window", id = 888 },
    coins   = { name = "Coin Chime",      id = 895 },
    whisper = { name = "Whisper Ping",    id = 3081 },
    raid    = { name = "Raid Warning",    id = 8959 },
    loot    = { name = "Loot Coin",       id = 120 },
}

function ns.GetSoundChoice()
    local s = ns.db and ns.db.settings
    local key = (s and s.soundName) or "auction"
    return key, ns.SOUND_CHOICES[key] or ns.SOUND_CHOICES.auction
end

function ns.SetSoundChoice(key)
    key = key and key:lower() or "auction"
    if not ns.SOUND_CHOICES[key] then key = "auction" end
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.soundName = key
    end
    local info = ns.SOUND_CHOICES[key]
    if info and type(PlaySound) == "function" then
        pcall(PlaySound, info.id)
    end
    return key, info
end

function ns.GetSoundThrottle()
    local s = ns.db and ns.db.settings
    if s and s.soundThrottle ~= nil then return s.soundThrottle end
    return 30  -- 30 seconds default
end

function ns.SetSoundThrottle(sec)
    sec = math.max(0, math.floor(tonumber(sec) or 0))
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.soundThrottle = sec
    end
end

function ns.PlayDealSound()
    if not ns.IsSoundAlertEnabled() then return end
    local now = GetServerTime()
    local throttle = ns.GetSoundThrottle()
    if ns.lastSoundTime and (now - ns.lastSoundTime) < throttle then
        return
    end
    ns.lastSoundTime = now
    local _, choice = ns.GetSoundChoice()
    local soundID = (choice and choice.id) or 888
    if type(PlaySound) == "function" then
        pcall(PlaySound, soundID)
    end
end

function ns.IsSoundAlertEnabled()
    local s = ns.db and ns.db.settings
    if s and s.soundAlert ~= nil then return s.soundAlert end
    return true
end

function ns.SetSoundAlert(val)
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.soundAlert = val
    end
end

function ns.IsChatAlertEnabled()
    local s = ns.db and ns.db.settings
    if s and s.chatAlert ~= nil then return s.chatAlert end
    return true
end

function ns.SetChatAlert(val)
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.chatAlert = val
    end
end

function ns.IsTooltipEnabled()
    local s = ns.db and ns.db.settings
    if s and s.tooltip ~= nil then return s.tooltip end
    return true
end

function ns.SetTooltipEnabled(val)
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.tooltip = val
    end
end

function ns.GetMinProfit()
    local s = ns.db and ns.db.settings
    return (s and s.minProfit) or 0
end

function ns.SetMinProfit(copper)
    copper = math.max(0, math.floor(copper or 0))
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.minProfit = copper
    end
end

function ns.GetMaxQuickBuySpend()
    local s = ns.db and ns.db.settings
    if s and s.maxQuickBuySpend ~= nil then
        return s.maxQuickBuySpend
    end
    return 500000  -- 50g default
end

function ns.SetMaxQuickBuySpend(copper)
    copper = math.max(0, math.floor(copper or 0))
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.maxQuickBuySpend = copper
    end
end

function ns.GetMinConfidence()
    local s = ns.db and ns.db.settings
    return (s and s.minConfidence) or "any"
end

function ns.SetMinConfidence(lvl)
    lvl = lvl and lvl:lower() or "any"
    if lvl ~= "high" and lvl ~= "med" and lvl ~= "moderate" then lvl = "any" end
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.minConfidence = lvl
    end
end

ns.VALUATION_MODELS = {
    median = {
        id = "median",
        name = "Standard Median",
        shortName = "Median",
        desc = "Immune to single-listing 1c bait and 999g spikes. Standard statistical baseline.",
    },
    trimmed = {
        id = "trimmed",
        name = "Trimmed Mean (10%)",
        shortName = "Trimmed",
        desc = "Discards top & bottom 10% outlier prices, averaging the middle 80%.",
    },
    ema = {
        id = "ema",
        name = "7-Day EMA",
        shortName = "7d EMA",
        desc = "7-period Exponential Moving Average. Weights recent auction scans higher for volatile markets.",
    },
}

function ns.GetValuationModel()
    local s = ns.db and ns.db.settings
    local model = (s and s.valuationModel) or "median"
    if not ns.VALUATION_MODELS[model] then model = "median" end
    return model
end

function ns.SetValuationModel(model)
    model = model and model:lower() or "median"
    if not ns.VALUATION_MODELS[model] then model = "median" end
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.valuationModel = model
        ns.db.valuationModel = model
    end
    return model, ns.VALUATION_MODELS[model]
end


---------------------------------------------------------------------------
-- Database maintenance & export

function ns.PruneHistory(maxDays)
    maxDays = tonumber(maxDays) or 30
    local maxAge = maxDays * 86400
    local db = ns.db
    if not db then return 0 end
    local now = GetServerTime()
    local removedItems = 0

    if type(db.items) == "table" then
        for itemID, rec in pairs(db.items) do
            local h = rec.history
            local last = h and h[#h]
            if not last or (now - (last.seen or last.t) > maxAge) then
                db.items[itemID] = nil
                removedItems = removedItems + 1
            end
        end
    end

    local keptScans = {}
    if type(db.scans) == "table" then
        for _, s in ipairs(db.scans) do
            if now - (s.t or 0) <= maxAge then
                keptScans[#keptScans + 1] = s
            end
        end
        db.scans = keptScans
    end

    if ns.RefreshPanel then ns.RefreshPanel() end
    return removedItems
end

function ns.ResetItem(itemID)
    local db = ns.db
    if not db or not db.items then return false end
    if db.items[itemID] then
        db.items[itemID] = nil
        if ns.RefreshPanel then ns.RefreshPanel() end
        return true
    end
    return false
end

local exportFrame = nil
function ns.ShowExportDialog()
    if not exportFrame then
        local template = BackdropTemplateMixin and "BackdropTemplate" or nil
        exportFrame = CreateFrame("Frame", "GoldFinderExportDialog", UIParent, template)
        exportFrame:SetSize(640, 420)
        exportFrame:SetPoint("CENTER")
        exportFrame:SetFrameStrata("DIALOG")
        exportFrame:EnableMouse(true)
        exportFrame:SetMovable(true)
        exportFrame:RegisterForDrag("LeftButton")
        exportFrame:SetScript("OnDragStart", exportFrame.StartMoving)
        exportFrame:SetScript("OnDragStop", exportFrame.StopMovingOrSizing)

        exportFrame:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true, tileSize = 32, edgeSize = 32,
            insets = { left = 8, right = 8, top = 8, bottom = 8 }
        })

        local title = exportFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
        title:SetPoint("TOP", 0, -18)
        title:SetText("GoldFinder Deals Export")

        local hint = exportFrame:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        hint:SetPoint("TOP", title, "BOTTOM", 0, -4)
        hint:SetText("Press Ctrl+C to copy CSV data, then paste into Google Sheets or Excel.")

        local scroll = CreateFrame("ScrollFrame", "GoldFinderExportScroll", exportFrame, "UIPanelScrollFrameTemplate")
        scroll:SetPoint("TOPLEFT", 20, -56)
        scroll:SetPoint("BOTTOMRIGHT", -36, 48)

        local eb = CreateFrame("EditBox", nil, scroll)
        eb:SetMultiLine(true)
        eb:SetFontObject("GameFontHighlightSmall")
        eb:SetWidth(570)
        eb:SetAutoFocus(false)
        eb:SetScript("OnEscapePressed", function() exportFrame:Hide() end)
        scroll:SetScrollChild(eb)
        exportFrame.editBox = eb

        local closeBtn = CreateFrame("Button", nil, exportFrame, "UIPanelButtonTemplate")
        closeBtn:SetSize(90, 24)
        closeBtn:SetPoint("BOTTOM", 0, 16)
        closeBtn:SetText("Close")
        closeBtn:SetScript("OnClick", function() exportFrame:Hide() end)

        tinsert(UISpecialFrames, "GoldFinderExportDialog")
    end

    local deals = (ns.FindDeals and ns.FindDeals()) or {}
    local lines = { "ItemID,Material,LowestNowCopper,TypicalCopper,DiscountPct,EstUnitProfitCopper,EstTotalProfitCopper,Quantity" }
    for _, d in ipairs(deals) do
        local name = (d.name or (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(d.itemID)) or ("Item " .. d.itemID)):gsub(",", "")
        local pct = math.floor(d.below * 100 + 0.5)
        lines[#lines + 1] = ("%d,%s,%d,%d,%d,%d,%d,%d"):format(
            d.itemID, name, d.now or 0, d.typical or 0, pct,
            d.netUnitProfit or 0, d.totalNetProfit or 0, d.qty or 0
        )
    end

    local text = table.concat(lines, "\n")
    exportFrame.editBox:SetText(text)
    exportFrame:Show()
    exportFrame.editBox:SetFocus()
    exportFrame.editBox:HighlightText()
end

-- SavedVariables format version. Bump when the persisted shape changes and
-- migrate; never discard a stored table.
ns.DB_SCHEMA = 4

-- Each migration takes the db from schema n-1 to n. Plain table work only.
local MIGRATIONS = {
    -- 1 -> 2: before v0.0.4 the client's re-delivered browse lists were
    -- recorded as new scans (see Scan.lua, Finish). A re-record is identical
    -- to the point before it -- same lowest price, same quantity -- with a
    -- later timestamp. Collapse each such run to its EARLIEST point, which
    -- carries the true observation time. Conservative: a genuinely unchanged
    -- market loses a point and is judged one scan later; nothing becomes
    -- falsely fresh.
    [2] = function(db)
        local removed = 0
        for _, rec in pairs(db.items) do
            local h, kept = rec.history, {}
            if type(h) == "table" then
                for _, p in ipairs(h) do
                    local last = kept[#kept]
                    if last and last.min == p.min and last.qty == p.qty then
                        removed = removed + 1
                    else
                        kept[#kept + 1] = p
                    end
                end
                rec.history = kept
            end
        end
        return removed, "repeated price point(s) recorded from re-delivered results"
    end,

    -- 2 -> 3: the same re-deliveries also appended scan summaries (seen as
    -- runs of identical 4465-row "scans" a minute apart), so the footer's
    -- scan count overstated. Collapse consecutive summaries with the same
    -- source, row, material and item counts to the earliest.
    [3] = function(db)
        local kept, removed = {}, 0
        for _, s in ipairs(db.scans) do
            local last = kept[#kept]
            if last and last.source == s.source and last.rows == s.rows
               and last.materials == s.materials and last.items == s.items then
                removed = removed + 1
            else
                kept[#kept + 1] = s
            end
        end
        db.scans = kept
        return removed, "repeated scan record(s)"
    end,

    -- 3 -> 4: partition stored market pricing by realm so characters across
    -- different servers do not share prices, while alts on the same realm
    -- share complete scan history and tooltips (#27).
    [4] = function(db)
        if type(db.realms) ~= "table" then db.realms = {} end
        local realm = (GetNormalizedRealmName and GetNormalizedRealmName()) or (GetRealmName and GetRealmName()) or "Default"
        if not db.realms[realm] then
            db.realms[realm] = {
                items = db.items or {},
                scans = db.scans or {},
                factions = {},
            }
        end
        return 0, "partitioned price database by realm"
    end,
}

-- Nothing here can crash: plain table checks only. The save path stays that way.
local boot = CreateFrame("Frame")
boot:RegisterEvent("ADDON_LOADED")
boot:SetScript("OnEvent", function(self, _, name)
    if name ~= ADDON then return end
    self:UnregisterEvent("ADDON_LOADED")

    if type(GoldFinderDB) ~= "table" then GoldFinderDB = {} end
    local db = GoldFinderDB
    db.schema = db.schema or ns.DB_SCHEMA
    if type(db.scans) ~= "table" then db.scans = {} end  -- one summary per full scan
    if type(db.items) ~= "table" then db.items = {} end  -- [itemID] = { name, history }

    while db.schema < ns.DB_SCHEMA do
        local to = db.schema + 1
        local removed, what = MIGRATIONS[to](db)
        db.schema = to
        if removed and removed > 0 then
            ns.Print("Cleaned saved data (schema %d to %d): removed %d %s.", to - 1, to, removed, what)
        end
    end

    if type(db.settings) ~= "table" then db.settings = {} end
    if db.settings.dealRatio == nil then db.settings.dealRatio = 0.70 end
    if db.settings.minPrior == nil then db.settings.minPrior = 3 end
    if db.settings.soundAlert == nil then db.settings.soundAlert = true end
    if db.settings.chatAlert == nil then db.settings.chatAlert = true end
    if db.settings.soundName == nil then db.settings.soundName = "auction" end
    if db.settings.soundThrottle == nil then db.settings.soundThrottle = 30 end
    if db.settings.sortBy == nil then db.settings.sortBy = "profit" end
    if db.settings.tooltip == nil then db.settings.tooltip = true end
    if db.settings.minProfit == nil then db.settings.minProfit = 0 end
    if db.settings.maxQuickBuySpend == nil then db.settings.maxQuickBuySpend = 500000 end
    if db.settings.minConfidence == nil then db.settings.minConfidence = "any" end
    if db.settings.valuationModel == nil then db.settings.valuationModel = "median" end
    if db.settings.factionShare == nil then db.settings.factionShare = true end
    if type(db.watchlist) ~= "table" then db.watchlist = {} end
    if type(db.shoppingLists) ~= "table" then db.shoppingLists = {} end
    if type(db.blacklist) ~= "table" then db.blacklist = {} end
    if type(db.realms) ~= "table" then db.realms = {} end

    -- Active realm and faction partition binding
    local realm = (GetNormalizedRealmName and GetNormalizedRealmName()) or (GetRealmName and GetRealmName()) or "Default"
    if not db.realms[realm] then
        db.realms[realm] = {
            items = db.items or {},
            scans = db.scans or {},
            factions = {},
        }
    end

    local rData = db.realms[realm]
    if db.settings.factionShare == false then
        local fKey = (UnitFactionGroup and UnitFactionGroup("player")) or "Neutral"
        rData.factions = rData.factions or {}
        if not rData.factions[fKey] then
            rData.factions[fKey] = { items = {}, scans = {} }
        end
        db.items = rData.factions[fKey].items
        db.scans = rData.factions[fKey].scans
    else
        db.items = rData.items
        db.scans = rData.scans
    end

    ns.db = db
end)

---------------------------------------------------------------------------
-- Cross-Character & Realm Market Sharing (#27)

function ns.GetActiveRealm()
    return (GetNormalizedRealmName and GetNormalizedRealmName()) or (GetRealmName and GetRealmName()) or "Default"
end

function ns.GetActiveFaction()
    return (UnitFactionGroup and UnitFactionGroup("player")) or "Neutral"
end

function ns.IsFactionShareEnabled()
    local s = ns.db and ns.db.settings
    if s and s.factionShare ~= nil then return s.factionShare end
    return true
end

function ns.SetFactionShareEnabled(val)
    if not ns.db then return end
    ns.db.settings = ns.db.settings or {}
    ns.db.settings.factionShare = val

    local realm = ns.GetActiveRealm()
    ns.db.realms = ns.db.realms or {}
    local rData = ns.db.realms[realm] or { items = {}, scans = {}, factions = {} }
    ns.db.realms[realm] = rData

    if val == false then
        local fKey = ns.GetActiveFaction()
        rData.factions = rData.factions or {}
        rData.factions[fKey] = rData.factions[fKey] or { items = {}, scans = {} }
        ns.db.items = rData.factions[fKey].items
        ns.db.scans = rData.factions[fKey].scans
    else
        db = ns.db
        db.items = rData.items
        db.scans = rData.scans
    end

    if ns.RefreshPanel then ns.RefreshPanel() end
end

---------------------------------------------------------------------------
-- Category & Watchlist State

ns.activeCategory = "all"

function ns.GetActiveCategory()
    return ns.activeCategory or "all"
end

function ns.SetActiveCategory(cat)
    cat = cat and cat:lower() or "all"
    if cat == "crafts" then cat = "conversions" end
    local valid = { all = true, herbs = true, mining = true, cloth = true, leather = true, conversions = true, undercuts = true, shopping = true, watchlist = true }
    ns.activeCategory = valid[cat] and cat or "all"
end

function ns.IsWatched(itemID)
    if not itemID or not ns.db or not ns.db.watchlist then return false end
    return ns.db.watchlist[itemID] == true
end

function ns.SetWatched(itemID, state)
    if not itemID or not ns.db then return end
    ns.db.watchlist = ns.db.watchlist or {}
    if state then
        ns.db.watchlist[itemID] = true
    else
        ns.db.watchlist[itemID] = nil
    end
end

function ns.ToggleWatchlist(itemID)
    if not itemID then return false end
    local newState = not ns.IsWatched(itemID)
    ns.SetWatched(itemID, newState)
    return newState
end

function ns.GetWatchlistCount()
    local count = 0
    if ns.db and ns.db.watchlist then
        for _ in pairs(ns.db.watchlist) do count = count + 1 end
    end
    return count
end

---------------------------------------------------------------------------
-- Item Blacklist / Ignore Filter (#35)

function ns.IsBlacklisted(itemID)
    if not itemID or not ns.db or not ns.db.blacklist then return false end
    return ns.db.blacklist[itemID] == true
end

function ns.SetBlacklisted(itemID, state)
    if not itemID or not ns.db then return end
    ns.db.blacklist = ns.db.blacklist or {}
    if state then
        ns.db.blacklist[itemID] = true
    else
        ns.db.blacklist[itemID] = nil
    end
end

function ns.ToggleBlacklist(itemID)
    local cur = ns.IsBlacklisted(itemID)
    ns.SetBlacklisted(itemID, not cur)
    return not cur
end

function ns.GetBlacklistCount()
    local count = 0
    if ns.db and ns.db.blacklist then
        for _ in pairs(ns.db.blacklist) do count = count + 1 end
    end
    return count
end

---------------------------------------------------------------------------
-- Shopping Lists & Material Quota Tracking (#22)

function ns.GetShoppingList()
    return (ns.db and ns.db.shoppingLists) or {}
end

function ns.GetShoppingItem(itemID)
    if not itemID or not ns.db or not ns.db.shoppingLists then return nil end
    return ns.db.shoppingLists[itemID]
end

function ns.SetShoppingItem(itemID, targetQty, maxUnitPrice)
    if not ns.db or not itemID then return end
    ns.db.shoppingLists = ns.db.shoppingLists or {}
    targetQty = tonumber(targetQty) or 0
    if targetQty <= 0 then
        ns.db.shoppingLists[itemID] = nil
    else
        ns.db.shoppingLists[itemID] = {
            target = targetQty,
            targetQty = targetQty,
            maxUnitPrice = maxUnitPrice and maxUnitPrice > 0 and maxUnitPrice or nil,
        }
    end
end

function ns.RemoveShoppingItem(itemID)
    if ns.db and ns.db.shoppingLists and itemID then
        ns.db.shoppingLists[itemID] = nil
    end
end

function ns.GetItemInventoryCount(itemID)
    if not itemID then return 0 end
    if C_Item and C_Item.GetItemCount then
        return C_Item.GetItemCount(itemID, true, false, true, true) or 0
    elseif GetItemCount then
        return GetItemCount(itemID, true) or 0
    end
    return 0
end

---------------------------------------------------------------------------
-- Slash commands

SLASH_GOLDFINDER1 = "/goldfinder"
SLASH_GOLDFINDER2 = "/gf"
SlashCmdList["GOLDFINDER"] = function(msg)
    msg = (msg or ""):match("^%s*(.-)%s*$")
    local cmd, arg = msg:match("^(%S+)%s*(.*)$")
    cmd = cmd and cmd:lower() or ""

    if cmd == "config" or cmd == "options" or cmd == "opt" or cmd == "settings" then
        if ns.OpenConfig then
            ns.OpenConfig()
        elseif ns.ToggleConfig then
            ns.ToggleConfig()
        end
    elseif cmd == "ratio" or cmd == "discount" then
        local num = tonumber(arg)
        if num and num >= 5 and num <= 95 then
            local ratio = (100 - num) / 100
            ns.SetDealRatio(ratio)
            ns.Good("Deal threshold set to %d%% discount (ratio %.2f).", num, ratio)
            if ns.RefreshPanel then ns.RefreshPanel() end
        else
            ns.Warn("Usage: /gf ratio <5-95> (e.g. /gf ratio 30 for 30%% off typical)")
        end
    elseif cmd == "minscans" or cmd == "scans" then
        local num = tonumber(arg)
        if num and num >= 1 and num <= 20 then
            ns.SetMinPrior(math.floor(num))
            ns.Good("Minimum prior scans required set to %d.", math.floor(num))
            if ns.RefreshPanel then ns.RefreshPanel() end
        else
            ns.Warn("Usage: /gf minscans <1-20> (e.g. /gf minscans 3)")
        end
    elseif cmd == "sort" then
        arg = arg and arg:lower() or ""
        if arg == "profit" or arg == "discount" then
            ns.SetSortBy(arg)
        else
            ns.SetSortBy(ns.GetSortBy() == "profit" and "discount" or "profit")
        end
        ns.Good("Sorting deals by %s.", ns.GetSortBy() == "profit" and "Estimated Net Profit" or "Discount %")
        if ns.RefreshPanel then ns.RefreshPanel() end
    elseif cmd == "sound" then
        arg = arg and arg:lower() or ""
        if arg == "on" or arg == "1" or arg == "true" then
            ns.SetSoundAlert(true)
            ns.Good("Deal audio chime enabled.")
        elseif arg == "off" or arg == "0" or arg == "false" then
            ns.SetSoundAlert(false)
            ns.Good("Deal audio chime disabled.")
        elseif ns.SOUND_CHOICES[arg] then
            ns.SetSoundAlert(true)
            local _, info = ns.SetSoundChoice(arg)
            ns.Good("Deal audio chime set to: %s (enabled).", info.name)
        elseif arg == "" then
            local val = not ns.IsSoundAlertEnabled()
            ns.SetSoundAlert(val)
            ns.Good("Deal audio chime %s.", val and "enabled" or "disabled")
        else
            ns.Warn("Usage: /gf sound [on|off|auction|coins|whisper|raid|loot]")
        end
    elseif cmd == "soundthrottle" or cmd == "throttle" then
        local sec = tonumber(arg)
        if sec ~= nil and sec >= 0 and sec <= 300 then
            ns.SetSoundThrottle(sec)
            if sec > 0 then
                ns.Good("Audio alert throttle window set to %d seconds.", sec)
            else
                ns.Good("Audio alert throttle disabled (chime on every deal find).")
            end
        else
            ns.Print("Current audio throttle window: %d seconds.", ns.GetSoundThrottle())
            ns.Warn("Usage: /gf soundthrottle <seconds> (e.g. /gf soundthrottle 30, /gf soundthrottle 0)")
        end
    elseif cmd == "chat" then
        arg = arg and arg:lower() or ""
        local val
        if arg == "on" or arg == "1" or arg == "true" then val = true
        elseif arg == "off" or arg == "0" or arg == "false" then val = false
        else val = not ns.IsChatAlertEnabled() end
        ns.SetChatAlert(val)
        ns.Good("Deal chat summary notification %s.", val and "enabled" or "disabled")
    elseif cmd == "minprofit" or cmd == "profit" then
        arg = arg and arg:match("^%s*(.-)%s*$") or ""
        if arg == "" then
            local current = ns.GetMinProfit()
            if current > 0 then
                ns.Print("Current minimum profit threshold: %s", ns.Money(current))
            else
                ns.Print("Minimum profit threshold is currently disabled (0c).")
            end
            ns.Print("Usage: /gf minprofit <amount> (e.g. /gf minprofit 5g, /gf minprofit 50s, /gf minprofit 0)")
        else
            local copper = ns.ParseMoneyString(arg)
            if copper ~= nil then
                ns.SetMinProfit(copper)
                if copper > 0 then
                    ns.Good("Minimum net profit threshold set to %s.", ns.Money(copper))
                else
                    ns.Good("Minimum net profit threshold disabled (showing all deals).")
                end
                if ns.RefreshPanel then ns.RefreshPanel() end
            else
                ns.Warn("Invalid amount. Usage: /gf minprofit <amount> (e.g. /gf minprofit 5g, /gf minprofit 10, /gf minprofit 0)")
            end
        end
    elseif cmd == "maxspend" or cmd == "quickbuy" then
        arg = arg and arg:match("^%s*(.-)%s*$") or ""
        if arg == "" then
            local current = ns.GetMaxQuickBuySpend()
            if current > 0 then
                ns.Print("Current Quick-Buy max spend cap: %s", ns.Money(current))
            else
                ns.Print("Quick-Buy max spend cap is disabled (no limit).")
            end
            ns.Print("Usage: /gf maxspend <amount> (e.g. /gf maxspend 50g, /gf maxspend 100g, /gf maxspend 0)")
        else
            local copper = ns.ParseMoneyString(arg)
            if copper ~= nil then
                ns.SetMaxQuickBuySpend(copper)
                if copper > 0 then
                    ns.Good("Quick-Buy max spend cap set to %s.", ns.Money(copper))
                else
                    ns.Good("Quick-Buy max spend cap disabled (no limit).")
                end
            else
                ns.Warn("Invalid amount. Usage: /gf maxspend <amount> (e.g. /gf maxspend 50g, /gf maxspend 0)")
            end
        end
    elseif cmd == "tooltip" then
        arg = arg and arg:lower() or ""
        local val
        if arg == "on" or arg == "1" or arg == "true" then val = true
        elseif arg == "off" or arg == "0" or arg == "false" then val = false
        else val = not ns.IsTooltipEnabled() end
        ns.SetTooltipEnabled(val)
        ns.Good("Item tooltip price integration %s.", val and "enabled" or "disabled")
    elseif cmd == "sellhelper" or cmd == "helper" then
        arg = arg and arg:lower() or ""
        local val
        if arg == "on" or arg == "1" or arg == "true" then val = true
        elseif arg == "off" or arg == "0" or arg == "false" then val = false
        else val = not (ns.IsSellHelperEnabled and ns.IsSellHelperEnabled()) end
        if ns.SetSellHelperEnabled then ns.SetSellHelperEnabled(val) end
        ns.Good("Sell tab market helper %s.", val and "enabled" or "disabled")
    elseif cmd == "minconf" or cmd == "confidence" or cmd == "minconfidence" then
        arg = arg and arg:lower():match("^%s*(.-)%s*$") or ""
        if arg == "high" or arg == "med" or arg == "moderate" or arg == "any" then
            ns.SetMinConfidence(arg)
            ns.Good("Minimum sighting confidence filter set to: %s.", arg:upper())
            if ns.RefreshPanel then ns.RefreshPanel() end
        else
            ns.Print("Current minimum confidence filter: %s", ns.GetMinConfidence():upper())
            ns.Warn("Usage: /gf minconf <any | med | high>")
        end
    elseif cmd == "valuation" or cmd == "baseline" or cmd == "model" then
        arg = arg and arg:lower():match("^%s*(.-)%s*$") or ""
        if arg == "median" or arg == "trimmed" or arg == "ema" then
            local model, info = ns.SetValuationModel(arg)
            ns.Good("Valuation baseline engine set to: %s.", info.name)
            ns.Print("  %s", info.desc)
            if ns.RefreshPanel then ns.RefreshPanel() end
        else
            local curModel = ns.GetValuationModel()
            local curInfo = ns.VALUATION_MODELS[curModel]
            ns.Print("Current valuation engine: %s (%s)", curInfo.name, curInfo.desc)
            ns.Warn("Usage: /gf valuation <median | trimmed | ema>")
        end
    elseif cmd == "factionshare" or cmd == "crossfaction" then
        arg = arg and arg:lower() or ""
        local val
        if arg == "on" or arg == "1" or arg == "true" then val = true
        elseif arg == "off" or arg == "0" or arg == "false" then val = false
        else val = not ns.IsFactionShareEnabled() end
        ns.SetFactionShareEnabled(val)
        ns.Good("Cross-faction market sharing %s on %s.", val and "enabled" or "disabled", ns.GetActiveRealm())
    elseif cmd == "minimap" or cmd == "icon" then
        arg = arg and arg:lower() or ""
        local val
        if arg == "on" or arg == "1" or arg == "true" then val = true
        elseif arg == "off" or arg == "0" or arg == "false" then val = false
        else val = not (ns.IsMinimapButtonShown and ns.IsMinimapButtonShown()) end
        if ns.SetMinimapButtonShown then ns.SetMinimapButtonShown(val) end
        ns.Good("Minimap coin button %s.", val and "enabled" or "disabled")
    elseif cmd == "sync" or cmd == "realms" then
        local realm = ns.GetActiveRealm()
        local faction = ns.GetActiveFaction()
        local shared = ns.IsFactionShareEnabled()
        local rData = ns.db and ns.db.realms and ns.db.realms[realm]
        local itemCount = 0
        if rData and rData.items then
            for _ in pairs(rData.items) do itemCount = itemCount + 1 end
        end
        local realmCount = 0
        if ns.db and ns.db.realms then
            for _ in pairs(ns.db.realms) do realmCount = realmCount + 1 end
        end
        ns.Print("GoldFinder Database Scope:")
        ns.Print("  - Active Realm: %s", realm)
        ns.Print("  - Active Faction: %s", faction)
        ns.Print("  - Cross-Faction Sharing: %s", shared and "ON (realm-wide shared data)" or "OFF (partitioned by faction)")
        ns.Print("  - Realm Items Tracked: %d item(s)", itemCount)
        ns.Print("  - Total Realms in Database: %d", realmCount)
    elseif cmd == "export" then
        ns.ShowExportDialog()
    elseif cmd == "prune" then
        local days = tonumber(arg) or 30
        local count = ns.PruneHistory(days)
        ns.Good("Pruned %d item(s) not seen in the last %d days.", count, days)
    elseif cmd == "resetitem" then
        local itemID = tonumber(arg) or tonumber(arg and arg:match("item:(%d+)"))
        if itemID and ns.ResetItem(itemID) then
            ns.Good("Reset price history for item %d.", itemID)
        elseif itemID then
            ns.Warn("No price history found for item %d.", itemID)
        else
            ns.Warn("Usage: /gf resetitem <itemID or item link>")
        end
    elseif cmd == "watch" then
        local itemID = tonumber(arg) or tonumber(arg and arg:match("item:(%d+)"))
        if itemID then
            ns.SetWatched(itemID, true)
            local name = C_Item.GetItemNameByID(itemID) or ("Item " .. itemID)
            ns.Good("Added %s to watchlist.", name)
            if ns.RefreshPanel then ns.RefreshPanel() end
        else
            ns.Warn("Usage: /gf watch <itemID or item link>")
        end
    elseif cmd == "unwatch" then
        local itemID = tonumber(arg) or tonumber(arg and arg:match("item:(%d+)"))
        if itemID then
            ns.SetWatched(itemID, false)
            local name = C_Item.GetItemNameByID(itemID) or ("Item " .. itemID)
            ns.Good("Removed %s from watchlist.", name)
            if ns.RefreshPanel then ns.RefreshPanel() end
        else
            ns.Warn("Usage: /gf unwatch <itemID or item link>")
        end
    elseif cmd == "watchlist" then
        local count = ns.GetWatchlistCount()
        ns.Print("Watchlist contains %d item(s):", count)
        if ns.db and ns.db.watchlist then
            for id in pairs(ns.db.watchlist) do
                local name = C_Item.GetItemNameByID(id) or ("Item " .. id)
                ns.Print("  - %s (ID: %d)", name, id)
            end
        end
    elseif cmd == "ignore" or cmd == "blacklist" then
        local itemID = tonumber(arg) or tonumber(arg and arg:match("item:(%d+)"))
        if itemID then
            ns.SetBlacklisted(itemID, true)
            local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or ("Item " .. itemID)
            ns.Good("Added %s to blacklist. It will no longer appear in deals or alerts.", name)
            if ns.RefreshPanel then ns.RefreshPanel() end
        else
            local count = ns.GetBlacklistCount()
            ns.Print("Blacklist / Ignored Items (%d):", count)
            if count == 0 then
                ns.Print("  No items currently ignored. Add one with: /gf ignore <link|id>")
            else
                for id in pairs(ns.db.blacklist) do
                    local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(id)) or ("Item " .. id)
                    ns.Print("  - %s (ID: %d)", name, id)
                end
            end
        end
    elseif cmd == "unignore" or cmd == "unblacklist" then
        local itemID = tonumber(arg) or tonumber(arg and arg:match("item:(%d+)"))
        if itemID then
            ns.SetBlacklisted(itemID, false)
            local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or ("Item " .. itemID)
            ns.Good("Removed %s from blacklist.", name)
            if ns.RefreshPanel then ns.RefreshPanel() end
        else
            ns.Warn("Usage: /gf unignore <itemID or item link>")
        end
    elseif cmd == "buy" then
        local itemID = tonumber(arg:match("item:(%d+)"))
        local rest = arg
        if itemID then
            rest = rest:gsub("|c%x+|Hitem:%d+:[^|]+|h%[[^%]]+%]|h|r", "")
        else
            local idStr
            idStr, rest = rest:match("^(%d+)%s*(.*)$")
            itemID = tonumber(idStr)
        end
        local qtyStr, maxStr = rest and rest:match("^%s*(%d+)%s*(.*)$")
        local qty = tonumber(qtyStr)
        if itemID and qty and qty > 0 then
            local maxPrice = (maxStr and maxStr ~= "") and ns.ParseMoneyString(maxStr) or nil
            ns.SetShoppingItem(itemID, qty, maxPrice)
            local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or ("Item " .. itemID)
            local acquired = ns.GetItemInventoryCount(itemID)
            if maxPrice and maxPrice > 0 then
                ns.Good("Added %s to shopping list: target %d (have %d), max price %s.", name, qty, acquired, ns.Money(maxPrice))
            else
                ns.Good("Added %s to shopping list: target %d (have %d, no price cap).", name, qty, acquired)
            end
            if ns.RefreshPanel then ns.RefreshPanel() end
        else
            ns.Warn("Usage: /gf buy <itemID or item link> <targetQty> [maxUnitPrice]")
            ns.Print("Examples: /gf buy [Thorium Ore] 200 50s  OR  /gf buy 10620 100")
        end
    elseif cmd == "unbuy" or cmd == "removebuy" then
        local itemID = tonumber(arg:match("item:(%d+)")) or tonumber(arg:match("^(%d+)"))
        if itemID then
            local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or ("Item " .. itemID)
            ns.RemoveShoppingItem(itemID)
            ns.Good("Removed %s from shopping list.", name)
            if ns.RefreshPanel then ns.RefreshPanel() end
        else
            ns.Warn("Usage: /gf unbuy <itemID or item link>")
        end
    elseif cmd == "shopping" or cmd == "buylist" then
        local list = ns.GetShoppingList()
        local count = 0
        for _ in pairs(list) do count = count + 1 end
        ns.Print("Shopping List (%d item%s):", count, count == 1 and "" or "s")
        if count == 0 then
            ns.Print("  No active shopping targets. Add one with: /gf buy <link> <qty> [maxPrice]")
        else
            for id, req in pairs(list) do
                local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(id)) or ("Item " .. id)
                local target = req.target or req.targetQty or 0
                local acquired = ns.GetItemInventoryCount(id)
                local remaining = math.max(0, target - acquired)
                local maxStr = req.maxUnitPrice and (" (max: " .. ns.Money(req.maxUnitPrice) .. ")") or ""
                local statusStr = (remaining == 0) and "|cff40ff40[COMPLETE]|r" or ("|cffffd100%d/%d|r (%d remaining)"):format(acquired, target, remaining)
                ns.Print("  - %s: %s%s", name, statusStr, maxStr)
            end
        end
    elseif cmd == "cat" or cmd == "category" then
        arg = arg and arg:lower() or ""
        if arg == "all" or arg == "herbs" or arg == "mining" or arg == "cloth" or arg == "leather" or arg == "conversions" or arg == "crafts" or arg == "undercuts" or arg == "shopping" or arg == "watchlist" then
            ns.SetActiveCategory(arg)
            ns.Good("Active category filter set to: %s", arg:upper())
            if ns.RefreshPanel then ns.RefreshPanel() end
        else
            ns.Warn("Usage: /gf cat <all|herbs|mining|cloth|leather|conversions|undercuts|shopping|watchlist>")
        end
    elseif cmd == "preset" then
        arg = arg and arg:lower() or ""
        if arg == "snipe" then
            ns.SetDealRatio(0.50)  -- 50% discount
            ns.SetMinPrior(3)
            ns.SetSortBy("profit")
            ns.Good("Applied 'Snipe' preset: 50%% discount threshold, 3 min scans.")
        elseif arg == "standard" then
            ns.SetDealRatio(0.70)  -- 30% discount
            ns.SetMinPrior(3)
            ns.SetSortBy("profit")
            ns.Good("Applied 'Standard' preset: 30%% discount threshold, 3 min scans.")
        elseif arg == "volume" then
            ns.SetDealRatio(0.85)  -- 15% discount
            ns.SetMinPrior(2)
            ns.SetSortBy("profit")
            ns.Good("Applied 'Volume Flip' preset: 15%% discount threshold, 2 min scans.")
        else
            ns.Warn("Usage: /gf preset <snipe | standard | volume>")
        end
        if ns.RefreshPanel then ns.RefreshPanel() end
    else
        local ratio = ns.GetDealRatio()
        local pct = math.floor((1 - ratio) * 100 + 0.5)
        ns.Print("Version %s status:", ns.version)
        ns.Print("  - Threshold: %d%% below typical (ratio %.2f)", pct, ratio)
        ns.Print("  - History needed: %d prior scans", ns.GetMinPrior())
        ns.Print("  - Sort order: %s", ns.GetSortBy() == "profit" and "Estimated Net Profit" or "Discount %")
        local soundKey, soundInfo = ns.GetSoundChoice()
        ns.Print("  - Audio chime: %s (%s, throttle %ds)", ns.IsSoundAlertEnabled() and "on" or "off", soundInfo.name, ns.GetSoundThrottle())
        ns.Print("  - Chat notification: %s", ns.IsChatAlertEnabled() and "on" or "off")
        ns.Print("  - Item tooltip pricing: %s", ns.IsTooltipEnabled() and "on" or "off")
        ns.Print("  - Sell tab market helper: %s", (ns.IsSellHelperEnabled and ns.IsSellHelperEnabled()) and "on" or "off")
        ns.Print("  - Min sighting confidence: %s", (ns.GetMinConfidence and ns.GetMinConfidence():upper()) or "ANY")
        ns.Print("  - Cross-faction sharing: %s (Realm: %s)", ns.IsFactionShareEnabled() and "on" or "off", ns.GetActiveRealm())
        ns.Print("  - Minimap button: %s", (ns.IsMinimapButtonShown and ns.IsMinimapButtonShown()) and "on" or "off")
        local minProfit = ns.GetMinProfit()
        local minProfitStr = (minProfit > 0) and ns.Money(minProfit) or "none (0c)"
        ns.Print("  - Min profit floor: %s", minProfitStr)
        local maxSpend = ns.GetMaxQuickBuySpend()
        local maxSpendStr = (maxSpend > 0) and ns.Money(maxSpend) or "none (no limit)"
        ns.Print("  - Quick-Buy max spend cap: %s", maxSpendStr)
        ns.Print("Commands:")
        ns.Print("  /gf config           - open graphical options & configuration panel")
        ns.Print("  /gf ratio <5-95>     - set discount percentage threshold")
        ns.Print("  /gf minscans <1-20>  - set minimum prior scans required")
        ns.Print("  /gf minconf <any|med|high> - filter deals by sighting confidence rating")
        ns.Print("  /gf factionshare [on|off] - toggle cross-faction market sharing")
        ns.Print("  /gf sync             - view database realm and faction sharing status")
        ns.Print("  /gf minimap [on|off] - toggle minimap coin icon")
        ns.Print("  /gf sort             - toggle sort: profit vs discount")
        ns.Print("  /gf sound [on|off|auction|coins|whisper|raid|loot] - select alert sound kit")
        ns.Print("  /gf soundthrottle <sec> - set audio alert cooldown throttle (e.g. 30, 0)")
        ns.Print("  /gf chat [on|off]    - toggle chat summary on deal find")
        ns.Print("  /gf minprofit <amt>  - set minimum net profit filter (e.g. 5g, 50s, 0)")
        ns.Print("  /gf maxspend <amt>   - set Quick-Buy spend cap (e.g. 50g, 100g, 0)")
        ns.Print("  /gf tooltip [on|off] - toggle item tooltip market pricing")
        ns.Print("  /gf helper [on|off]  - toggle Blizzard Sell tab market helper card")
        ns.Print("  /gf export           - open CSV data export window")
        ns.Print("  /gf prune [days]     - prune items not seen in [days] (default 30)")
        ns.Print("  /gf resetitem <link> - clear price history for a specific item")
        ns.Print("  /gf preset <snipe|standard|volume> - apply preset trading profile")
        ns.Print("  /gf cat <all|herbs|mining|cloth|leather|crafts|undercuts|shopping|watchlist> - switch active category")
        ns.Print("  /gf watch <link|id>   - add item to watchlist")
        ns.Print("  /gf unwatch <link|id> - remove item from watchlist")
        ns.Print("  /gf watchlist         - view all starred watchlist items")
        ns.Print("  /gf buy <link|id> <qty> [max] - set quota target and optional max unit price")
        ns.Print("  /gf unbuy <link|id>   - remove material from shopping list")
        ns.Print("  /gf shopping          - view active shopping list fulfillment progress")
    end
end
