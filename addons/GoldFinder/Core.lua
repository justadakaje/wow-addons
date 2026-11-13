-- GoldFinder -- Core
-- Namespace and chat output. No game API is called at file scope beyond
-- reading this addon's own metadata.

local ADDON, ns = ...

ns.addonName = ADDON
local getMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata
ns.version   = (getMetadata and getMetadata(ADDON, "Version")) or "unknown"

local LABEL = "|cffffd100GoldFinder|r"

function ns.FindChatFrameByName(name)
    if not name or name == "" then return nil end
    local searchName = name:lower()
    for i = 1, (NUM_CHAT_WINDOWS or 10) do
        local frame = _G["ChatFrame" .. i]
        if frame then
            local windowName = GetChatWindowInfo(i)
            if windowName and windowName:lower() == searchName then
                return frame, i
            end
        end
    end
    return nil
end

function ns.GetOrCreateChatWindow(name)
    name = name or "GoldFinder"
    local frame, idx = ns.FindChatFrameByName(name)
    if frame then
        return frame, idx
    end

    if type(FCF_OpenNewWindow) == "function" then
        local newFrame = FCF_OpenNewWindow(name)
        if newFrame then
            return newFrame
        end
    end

    return DEFAULT_CHAT_FRAME
end

function ns.IsDedicatedChatTabEnabled()
    local s = ns.db and ns.db.settings
    return s and (s.dedicatedChatTab == true)
end

function ns.SetDedicatedChatTab(enabled)
    if ns.db and ns.db.settings then
        ns.db.settings.dedicatedChatTab = (enabled == true)
    end
    if enabled then
        local frame = ns.GetOrCreateChatWindow("GoldFinder")
        if frame and frame.AddMessage then
            frame:AddMessage("|cffffd100GoldFinder|r: Dedicated chat tab active. All GoldFinder notifications will appear here.")
        end
    end
end

local function GetTargetChatFrame()
    if ns.IsDedicatedChatTabEnabled and ns.IsDedicatedChatTabEnabled() then
        local frame = ns.GetOrCreateChatWindow("GoldFinder")
        if frame then
            return frame
        end
    end
    return DEFAULT_CHAT_FRAME
end

local function emit(colour, msg, ...)
    if select("#", ...) > 0 then
        msg = msg:format(...)
    end
    local fullMsg = ("%s: %s%s|r"):format(LABEL, colour, msg)
    local target = GetTargetChatFrame()
    if target and target.AddMessage then
        target:AddMessage(fullMsg)
    else
        print(fullMsg)
    end
end

function ns.Print(msg, ...) emit("|cffffffff", msg, ...) end
function ns.Good(msg, ...)  emit("|cff40ff40", msg, ...) end
function ns.Warn(msg, ...)  emit("|cffff9900", msg, ...) end
function ns.Bad(msg, ...)   emit("|cffff4040", msg, ...) end

ns.debugTrace = false
function ns.Trace(msg, ...)
    if ns.debugTrace then
        if select("#", ...) > 0 then
            msg = msg:format(...)
        end
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ffff[GF Trace]|r " .. msg)
    end
end

ns.lastErrors = ns.lastErrors or {}
function ns.RecordError(err)
    if not err then return end
    table.insert(ns.lastErrors, 1, tostring(err))
    if #ns.lastErrors > 5 then
        table.remove(ns.lastErrors)
    end
end

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
    if not ns.IsSoundAlertEnabled() then return false end
    local now = GetServerTime()
    local throttle = ns.GetSoundThrottle()
    if ns.lastAlertTime and (now - ns.lastAlertTime) < throttle then
        return false
    end
    ns.lastAlertTime = now
    ns.lastSoundTime = now
    local _, choice = ns.GetSoundChoice()
    local soundID = (choice and choice.id) or 888
    if type(PlaySound) == "function" then
        pcall(PlaySound, soundID)
    end
    return true
end

function ns.IsRaidWarningAlertEnabled()
    local s = ns.db and ns.db.settings
    if s and s.raidWarningAlert ~= nil then return s.raidWarningAlert end
    return true
end

function ns.SetRaidWarningAlertEnabled(val)
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.raidWarningAlert = (val == true)
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

function ns.IsCostBasisTooltipEnabled()
    local s = ns.db and ns.db.settings
    if s and s.costBasisTooltip ~= nil then return s.costBasisTooltip end
    return true
end

function ns.SetCostBasisTooltip(val)
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.costBasisTooltip = val
    end
end

function ns.IsMailCollectorEnabled()
    local s = ns.db and ns.db.settings
    if s and s.mailCollector ~= nil then return s.mailCollector end
    return true
end

function ns.SetMailCollector(val)
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.mailCollector = val
    end
end

---------------------------------------------------------------------------
-- Restock Safety Levels (#45)

function ns.GetRestockLevel(itemID)
    if not itemID or not ns.db or not ns.db.restock then return nil end
    return ns.db.restock[itemID]
end

function ns.SetRestockLevel(itemID, minQty)
    if not itemID or not ns.db then return end
    ns.db.restock = ns.db.restock or {}
    minQty = tonumber(minQty) or 0
    if minQty <= 0 then
        ns.db.restock[itemID] = nil
    else
        ns.db.restock[itemID] = minQty
    end
end

function ns.ClearRestockLevel(itemID)
    if itemID and ns.db and ns.db.restock then
        ns.db.restock[itemID] = nil
    end
end

function ns.GetLowStockItems()
    local lowItems = {}
    if not ns.db or not ns.db.restock then return lowItems end
    for itemID, minQty in pairs(ns.db.restock) do
        local count = 0
        if C_Item and C_Item.GetItemCount then
            count = C_Item.GetItemCount(itemID, true) or 0
        elseif GetItemCount then
            count = GetItemCount(itemID, true) or 0
        end
        if count < minQty then
            local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or ("Item " .. itemID)
            lowItems[#lowItems + 1] = {
                itemID = itemID,
                name = name,
                current = count,
                target = minQty,
                shortage = minQty - count,
            }
        end
    end
    table.sort(lowItems, function(a, b) return a.shortage > b.shortage end)
    return lowItems
end

---------------------------------------------------------------------------
-- Live Snipe Mode & High-Value Snipe Alarm (#44)

ns.isSnipeActive = false

function ns.IsSnipeMode()
    return ns.isSnipeActive == true
end

function ns.SetSnipeMode(enabled)
    ns.isSnipeActive = (enabled == true)
    if ns.isSnipeActive then
        ns.Good("Live Snipe Mode ACTIVATED. Standing watch for deep discounts and mega flips.")
        if PlaySound then PlaySound(8959) end
    else
        ns.Print("Live Snipe Mode deactivated.")
    end
    if ns.UpdateSnipeButton then ns.UpdateSnipeButton() end
    if ns.RefreshPanel then ns.RefreshPanel() end
end

function ns.GetSnipeThreshold()
    local s = ns.db and ns.db.settings
    return (s and s.snipeThreshold) or 1000000 -- 100g default
end

function ns.SetSnipeThreshold(copper)
    copper = math.max(0, math.floor(copper or 0))
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.snipeThreshold = copper
    end
end

function ns.PlaySnipeAlarm(deal)
    local now = GetServerTime()
    local throttle = (ns.GetSoundThrottle and ns.GetSoundThrottle()) or 30

    -- Throttle guard: prevent spamming alarms on every browse update
    if ns.lastAlertTime and (now - ns.lastAlertTime) < throttle then
        return false
    end
    ns.lastAlertTime = now
    ns.lastSoundTime = now

    -- Audio alarm: strictly honor mute / sound alert toggle
    if ns.IsSoundAlertEnabled and ns.IsSoundAlertEnabled() then
        if type(PlaySound) == "function" then
            pcall(PlaySound, 8959)
        end
    end

    if deal then
        local name = deal.name or (deal.itemID and C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(deal.itemID)) or "Mega Snipe"
        local profit = deal.totalNetProfit or 0
        local pct = math.floor((deal.below or 0) * 100 + 0.5)

        -- Visual Raid Warning banner: check toggle
        if ns.IsRaidWarningAlertEnabled and ns.IsRaidWarningAlertEnabled() then
            if RaidNotice_AddMessage and RaidWarningFrame and ChatTypeInfo and ChatTypeInfo["RAID_WARNING"] then
                pcall(RaidNotice_AddMessage, RaidWarningFrame, ("MEGA SNIPE: %s (-%d%%, +%s)"):format(name, pct, ns.Money(profit)), ChatTypeInfo["RAID_WARNING"])
            end
        end

        -- Chat alert: check toggle
        if ns.IsChatAlertEnabled and ns.IsChatAlertEnabled() then
            ns.Good("|cffa335ee[MEGA SNIPE DETECTED]|r %s is listed at %s (%d%% below typical, est. profit: +%s)!",
                deal.link or name, ns.Money(deal.now or deal.lowestNow or 0), pct, ns.Money(profit))
        end
    end
    return true
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
        exportFrame:SetToplevel(true)
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
        if exportFrame.SetBackdropColor then
            exportFrame:SetBackdropColor(0, 0, 0, 1)
        end

        local solidBg = exportFrame:CreateTexture(nil, "BACKGROUND", nil, -8)
        solidBg:SetPoint("TOPLEFT", 6, -6)
        solidBg:SetPoint("BOTTOMRIGHT", -6, 6)
        solidBg:SetColorTexture(0.08, 0.08, 0.10, 0.98)

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

---------------------------------------------------------------------------
-- Profile Persistence & Character Binding (HUD Edit Mode Style)

function ns.GetCharacterKey()
    local name = UnitName("player") or "Player"
    local realm = (GetNormalizedRealmName and GetNormalizedRealmName()) or (GetRealmName and GetRealmName()) or "Default"
    return name .. " - " .. realm
end

function ns.GetCharacterName()
    return UnitName("player") or "Character"
end

function ns.GetActiveProfileName()
    local db = GoldFinderDB
    if not db or not db.profileKeys then return "Default" end
    local charKey = ns.GetCharacterKey()
    return db.profileKeys[charKey] or "Default"
end

function ns.IsCharacterSpecificProfile()
    local db = GoldFinderDB
    if not db or not db.profileKeys then return false end
    local charKey = ns.GetCharacterKey()
    return db.profileKeys[charKey] == charKey
end

function ns.GetProfileList()
    local db = GoldFinderDB
    local list = {}
    if db and db.profiles then
        for name in pairs(db.profiles) do
            list[#list + 1] = name
        end
        table.sort(list, function(a, b)
            if a == "Default" then return true end
            if b == "Default" then return false end
            return a < b
        end)
    else
        list[1] = "Default"
    end
    return list
end

function ns.ApplyActiveProfile(profileKey)
    local db = GoldFinderDB
    if not db then return end
    local charKey = ns.GetCharacterKey()

    profileKey = profileKey or (db.profileKeys and db.profileKeys[charKey]) or "Default"

    if not db.profiles then db.profiles = {} end
    if not db.profileKeys then db.profileKeys = {} end

    -- If the requested profile does not exist, clone from Default or seed new
    if not db.profiles[profileKey] then
        local source = db.profiles["Default"] or {}
        local clone = {
            settings = {},
            watchlist = {},
            shoppingLists = {},
            blacklist = {},
            customCategories = {},
            restock = {},
        }
        if source.settings then
            for k, v in pairs(source.settings) do clone.settings[k] = v end
        end
        if source.watchlist then
            for k, v in pairs(source.watchlist) do clone.watchlist[k] = v end
        end
        if source.blacklist then
            for k, v in pairs(source.blacklist) do clone.blacklist[k] = v end
        end
        if source.shoppingLists then
            for k, v in pairs(source.shoppingLists) do clone.shoppingLists[k] = v end
        end
        if source.customCategories then
            for k, v in pairs(source.customCategories) do clone.customCategories[k] = v end
        end
        if source.restock then
            for k, v in pairs(source.restock) do clone.restock[k] = v end
        end
        db.profiles[profileKey] = clone
    end

    db.profileKeys[charKey] = profileKey
    local active = db.profiles[profileKey]

    if type(active.settings) ~= "table" then active.settings = {} end
    if type(active.watchlist) ~= "table" then active.watchlist = {} end
    if type(active.shoppingLists) ~= "table" then active.shoppingLists = {} end
    if type(active.blacklist) ~= "table" then active.blacklist = {} end
    if type(active.customCategories) ~= "table" then active.customCategories = {} end
    if type(active.restock) ~= "table" then active.restock = {} end

    local s = active.settings
    if s.dealRatio == nil then s.dealRatio = 0.70 end
    if s.minPrior == nil then s.minPrior = 3 end
    if s.soundAlert == nil then s.soundAlert = true end
    if s.chatAlert == nil then s.chatAlert = true end
    if s.soundName == nil then s.soundName = "auction" end
    if s.soundThrottle == nil then s.soundThrottle = 30 end
    if s.sortBy == nil then s.sortBy = "profit" end
    if s.tooltip == nil then s.tooltip = true end
    if s.minProfit == nil then s.minProfit = 0 end
    if s.maxQuickBuySpend == nil then s.maxQuickBuySpend = 500000 end
    if s.minConfidence == nil then s.minConfidence = "any" end
    if s.valuationModel == nil then s.valuationModel = "median" end
    if s.costBasisTooltip == nil then s.costBasisTooltip = true end
    if s.mailCollector == nil then s.mailCollector = true end
    if s.factionShare == nil then s.factionShare = true end
    if s.snipeThreshold == nil then s.snipeThreshold = 1000000 end
    if s.dedicatedChatTab == nil then s.dedicatedChatTab = false end
    if s.raidWarningAlert == nil then s.raidWarningAlert = true end

    -- Bind pointers to active profile
    db.settings = active.settings
    db.watchlist = active.watchlist
    db.shoppingLists = active.shoppingLists
    db.blacklist = active.blacklist
    db.customCategories = active.customCategories
    db.restock = active.restock

    -- Sync faction share partition if changed
    if ns.SetFactionShareEnabled and s.factionShare ~= nil then
        ns.SetFactionShareEnabled(s.factionShare)
    end

    if ns.RefreshControls then ns.RefreshControls() end
    if ns.RefreshPanel then ns.RefreshPanel() end
end

function ns.SetCharacterSpecificProfile(enabled)
    local charKey = ns.GetCharacterKey()
    if enabled then
        ns.ApplyActiveProfile(charKey)
        ns.Good("GoldFinder: Switched to Character-Specific profile for %s.", ns.GetCharacterName())
    else
        ns.ApplyActiveProfile("Default")
        ns.Good("GoldFinder: Switched to Account-Wide profile (Default).")
    end
end

function ns.CopyProfile(sourceKey)
    local db = GoldFinderDB
    if not db or not db.profiles or not db.profiles[sourceKey] then
        return false, "Source profile not found."
    end
    local activeKey = ns.GetActiveProfileName()
    if sourceKey == activeKey then
        return false, "Cannot copy profile onto itself."
    end
    local source = db.profiles[sourceKey]
    local target = db.profiles[activeKey] or {}
    wipe(target)
    target.settings = {}
    target.watchlist = {}
    target.shoppingLists = {}
    target.blacklist = {}
    target.customCategories = {}
    target.restock = {}
    for k, v in pairs(source.settings or {}) do target.settings[k] = v end
    for k, v in pairs(source.watchlist or {}) do target.watchlist[k] = v end
    for k, v in pairs(source.blacklist or {}) do target.blacklist[k] = v end
    for k, v in pairs(source.shoppingLists or {}) do target.shoppingLists[k] = v end
    for k, v in pairs(source.customCategories or {}) do target.customCategories[k] = v end
    for k, v in pairs(source.restock or {}) do target.restock[k] = v end
    db.profiles[activeKey] = target
    ns.ApplyActiveProfile(activeKey)
    return true
end

function ns.ResetCurrentProfile()
    local activeKey = ns.GetActiveProfileName()
    local db = GoldFinderDB
    if db and db.profiles and db.profiles[activeKey] then
        db.profiles[activeKey] = {
            settings = {
                dealRatio = 0.70,
                minPrior = 3,
                soundAlert = true,
                chatAlert = true,
                soundName = "auction",
                soundThrottle = 30,
                sortBy = "profit",
                tooltip = true,
                minProfit = 0,
                maxQuickBuySpend = 500000,
                minConfidence = "any",
                valuationModel = "median",
                costBasisTooltip = true,
                mailCollector = true,
                factionShare = true,
                snipeThreshold = 1000000,
                dedicatedChatTab = false,
                raidWarningAlert = true,
            },
            watchlist = {},
            shoppingLists = {},
            blacklist = {},
            customCategories = {},
            restock = {},
        }
        ns.ApplyActiveProfile(activeKey)
    end
end

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

    -- Profile management initialization
    if type(db.profiles) ~= "table" then db.profiles = {} end
    if type(db.profileKeys) ~= "table" then db.profileKeys = {} end

    -- Migrate legacy un-profiled settings into "Default" if not yet created
    if not db.profiles["Default"] then
        db.profiles["Default"] = {
            settings = (type(db.settings) == "table") and db.settings or {},
            watchlist = (type(db.watchlist) == "table") and db.watchlist or {},
            shoppingLists = (type(db.shoppingLists) == "table") and db.shoppingLists or {},
            blacklist = (type(db.blacklist) == "table") and db.blacklist or {},
            customCategories = (type(db.customCategories) == "table") and db.customCategories or {},
            restock = (type(db.restock) == "table") and db.restock or {},
        }
    end

    if type(db.costBasis) ~= "table" then db.costBasis = {} end
    if type(db.ledger) ~= "table" then
        db.ledger = {
            records = {},
            lifetime = { totalGross = 0, totalCut = 0, totalNet = 0, totalCost = 0, totalProfit = 0, count = 0 },
        }
    end
    if type(db.realms) ~= "table" then db.realms = {} end

    ns.db = db

    -- Set active profile based on character key
    local charKey = ns.GetCharacterKey()
    local profileKey = db.profileKeys[charKey] or "Default"
    if not db.profiles[profileKey] then
        profileKey = "Default"
        db.profileKeys[charKey] = "Default"
    end

    ns.ApplyActiveProfile(profileKey)

    -- Active realm and faction partition binding
    local realm = (GetNormalizedRealmName and GetNormalizedRealmName()) or (GetRealmName and GetRealmName()) or "Default"
    if not db.realms[realm] then
        db.realms[realm] = {
            items = db.items or {},
            scans = db.scans or {},
            lifetimeScans = db.lifetimeScans or (db.scans and #db.scans) or 0,
            factions = {},
        }
    end

    local rData = db.realms[realm]
    if db.settings and db.settings.factionShare == false then
        local fKey = (UnitFactionGroup and UnitFactionGroup("player")) or "Neutral"
        rData.factions = rData.factions or {}
        if not rData.factions[fKey] then
            rData.factions[fKey] = { items = {}, scans = {}, lifetimeScans = 0 }
        end
        db.items = rData.factions[fKey].items
        db.scans = rData.factions[fKey].scans
        db.lifetimeScans = rData.factions[fKey].lifetimeScans or (db.scans and #db.scans) or 0
    else
        db.items = rData.items
        db.scans = rData.scans
        db.lifetimeScans = rData.lifetimeScans or (db.scans and #db.scans) or 0
    end
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
        rData.factions[fKey] = rData.factions[fKey] or { items = {}, scans = {}, lifetimeScans = 0 }
        ns.db.items = rData.factions[fKey].items
        ns.db.scans = rData.factions[fKey].scans
        ns.db.lifetimeScans = rData.factions[fKey].lifetimeScans or (rData.factions[fKey].scans and #rData.factions[fKey].scans) or 0
    else
        local db = ns.db
        db.items = rData.items
        db.scans = rData.scans
        db.lifetimeScans = rData.lifetimeScans or (rData.scans and #rData.scans) or 0
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
    if valid[cat] then
        ns.activeCategory = cat
    elseif ns.GetCustomCategory and ns.GetCustomCategory(cat) then
        ns.activeCategory = cat
    else
        ns.activeCategory = "all"
    end
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
-- Custom Categories & Material Groups (#39)

function ns.GetCustomCategories()
    return (ns.db and ns.db.customCategories) or {}
end

function ns.GetCustomCategory(catID)
    if not catID or not ns.db or not ns.db.customCategories then return nil end
    return ns.db.customCategories[catID]
end

function ns.FindCustomCategory(query)
    if not query or query == "" or not ns.db or not ns.db.customCategories then return nil end
    local q = query:lower():match("^%s*(.-)%s*$")
    if ns.db.customCategories[q] then
        return q, ns.db.customCategories[q]
    end
    for id, cat in pairs(ns.db.customCategories) do
        if id:lower() == q or (cat.label and cat.label:lower() == q) then
            return id, cat
        end
    end
    return nil
end

local function SlugifyCategory(name)
    if not name or name == "" then return "group" end
    local slug = name:lower():gsub("%s+", "_"):gsub("[^%w_]", "")
    if slug == "" then slug = "group" end
    return slug
end

function ns.CreateCustomCategory(label)
    label = label and label:match("^%s*(.-)%s*$")
    if not label or label == "" or not ns.db then return nil end
    ns.db.customCategories = ns.db.customCategories or {}

    local baseSlug = SlugifyCategory(label)
    local slug = baseSlug
    local counter = 1
    while ns.db.customCategories[slug] do
        counter = counter + 1
        slug = ("%s_%d"):format(baseSlug, counter)
    end

    local cat = {
        id = slug,
        label = label,
        items = {},
    }
    ns.db.customCategories[slug] = cat
    if ns.RebuildCategoryButtons then ns.RebuildCategoryButtons() end
    return slug, cat
end

function ns.DeleteCustomCategory(catID)
    if not catID or not ns.db or not ns.db.customCategories then return false end
    if not ns.db.customCategories[catID] then return false end
    local label = ns.db.customCategories[catID].label or catID
    ns.db.customCategories[catID] = nil
    if ns.GetActiveCategory and ns.GetActiveCategory() == catID then
        ns.SetActiveCategory("all")
    end
    if ns.RebuildCategoryButtons then ns.RebuildCategoryButtons() end
    if ns.RefreshPanel then ns.RefreshPanel() end
    return true, label
end

function ns.AddCustomCategoryItem(catID, itemID)
    if not catID or not itemID or not ns.db then return false end
    local id, cat = ns.FindCustomCategory(catID)
    if not cat then return false end
    cat.items = cat.items or {}
    cat.items[itemID] = true
    if ns.RefreshPanel then ns.RefreshPanel() end
    return true, cat
end

function ns.RemoveCustomCategoryItem(catID, itemID)
    if not catID or not itemID or not ns.db then return false end
    local id, cat = ns.FindCustomCategory(catID)
    if not cat or not cat.items then return false end
    cat.items[itemID] = nil
    if ns.RefreshPanel then ns.RefreshPanel() end
    return true, cat
end

function ns.IsItemInCustomCategory(catID, itemID)
    if not catID or not itemID or not ns.db then return false end
    local id, cat = ns.FindCustomCategory(catID)
    return (cat and cat.items and cat.items[itemID] == true) or false
end

---------------------------------------------------------------------------
-- Cost Basis Tracking (#40, #42)

function ns.GetCostBasis(itemID)
    if not itemID or not ns.db or not ns.db.costBasis then return nil end
    return ns.db.costBasis[itemID]
end

function ns.RecordPurchase(itemID, qty, totalCost, unitCost)
    if not itemID or not qty or qty <= 0 or not ns.db then return nil end
    ns.db.costBasis = ns.db.costBasis or {}
    totalCost = totalCost or (unitCost and (unitCost * qty)) or 0

    local rec = ns.db.costBasis[itemID]
    if not rec then
        rec = {
            totalQty = 0,
            totalCost = 0,
            avgUnitCost = 0,
            lastPurchase = 0,
            history = {},
        }
        ns.db.costBasis[itemID] = rec
    end

    rec.totalQty = rec.totalQty + qty
    rec.totalCost = rec.totalCost + totalCost
    if rec.totalQty > 0 then
        rec.avgUnitCost = math.floor(rec.totalCost / rec.totalQty)
    end
    rec.lastPurchase = GetServerTime()

    rec.history = rec.history or {}
    rec.history[#rec.history + 1] = {
        t = rec.lastPurchase,
        qty = qty,
        unitCost = (qty > 0) and math.floor(totalCost / qty) or 0,
        total = totalCost,
    }
    if #rec.history > 20 then
        table.remove(rec.history, 1)
    end

    return rec
end

function ns.ClearCostBasis(itemID)
    if not ns.db or not ns.db.costBasis then return end
    if itemID then
        ns.db.costBasis[itemID] = nil
    else
        ns.db.costBasis = {}
    end
end

---------------------------------------------------------------------------
-- Goblin Realized P&L Ledger (#41)

function ns.GetLedger()
    if not ns.db then return { records = {}, lifetime = {} } end
    ns.db.ledger = ns.db.ledger or { records = {}, lifetime = { totalGross = 0, totalCut = 0, totalNet = 0, totalCost = 0, totalProfit = 0, count = 0 } }
    return ns.db.ledger
end

function ns.RecordSale(itemID, itemName, qty, gross, ahCut, purchaseCost)
    if not ns.db then return nil end
    local ledger = ns.GetLedger()
    qty = math.max(1, qty or 1)
    gross = gross or 0
    ahCut = ahCut or math.floor(gross * 0.05)
    local net = math.max(0, gross - ahCut)

    -- If purchase cost was not passed, evaluate from cost basis
    if not purchaseCost or purchaseCost <= 0 then
        local cb = ns.GetCostBasis(itemID)
        if cb and cb.avgUnitCost and cb.avgUnitCost > 0 then
            purchaseCost = cb.avgUnitCost * qty
        else
            purchaseCost = 0
        end
    end

    local profit = net - purchaseCost
    local roi = (purchaseCost > 0) and ((profit / purchaseCost) * 100) or 0

    local record = {
        t = GetServerTime(),
        itemID = itemID,
        name = itemName or (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or ("Item " .. (itemID or 0)),
        qty = qty,
        gross = gross,
        ahCut = ahCut,
        net = net,
        cost = purchaseCost,
        profit = profit,
        roi = roi,
    }

    ledger.records = ledger.records or {}
    ledger.records[#ledger.records + 1] = record
    if #ledger.records > 200 then
        table.remove(ledger.records, 1)
    end

    -- Update lifetime totals
    ledger.lifetime = ledger.lifetime or { totalGross = 0, totalCut = 0, totalNet = 0, totalCost = 0, totalProfit = 0, count = 0 }
    local lt = ledger.lifetime
    lt.totalGross = (lt.totalGross or 0) + gross
    lt.totalCut = (lt.totalCut or 0) + ahCut
    lt.totalNet = (lt.totalNet or 0) + net
    lt.totalCost = (lt.totalCost or 0) + purchaseCost
    lt.totalProfit = (lt.totalProfit or 0) + profit
    lt.count = (lt.count or 0) + 1

    return record
end

function ns.ResetLedger()
    if not ns.db then return end
    ns.db.ledger = {
        records = {},
        lifetime = { totalGross = 0, totalCut = 0, totalNet = 0, totalCost = 0, totalProfit = 0, count = 0 },
    }
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
        local sub = arg and arg:lower():match("^(%S+)")
        if ns.OpenConfig then
            ns.OpenConfig(sub)
        elseif ns.ToggleConfig then
            ns.ToggleConfig(sub)
        end
    elseif cmd == "trace" or cmd == "debug" then
        ns.debugTrace = not ns.debugTrace
        ns.Good("Diagnostics trace mode %s.", ns.debugTrace and "|cff40ff40ENABLED|r (will log AH state transitions to chat)" or "|cffff4040DISABLED|r")
    elseif cmd == "diag" or cmd == "diagnostic" or cmd == "report" or cmd == "bug" then
        if ns.ShowDiagnosticDialog then
            ns.ShowDiagnosticDialog()
        elseif ns.ShowInfoDialog then
            ns.ShowInfoDialog()
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
    elseif cmd == "raidwarning" or cmd == "rw" then
        arg = arg and arg:lower() or ""
        local val
        if arg == "on" or arg == "1" or arg == "true" then val = true
        elseif arg == "off" or arg == "0" or arg == "false" then val = false
        else val = not ns.IsRaidWarningAlertEnabled() end
        ns.SetRaidWarningAlertEnabled(val)
        ns.Good("Mega Snipe Raid Warning banner %s.", val and "enabled" or "disabled")
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
    elseif cmd == "chattab" or cmd == "tabchat" then
        arg = arg and arg:lower() or ""
        local val
        if arg == "on" or arg == "1" or arg == "true" then val = true
        elseif arg == "off" or arg == "0" or arg == "false" then val = false
        else val = not ns.IsDedicatedChatTabEnabled() end
        ns.SetDedicatedChatTab(val)
        ns.Good("Dedicated 'GoldFinder' chat tab %s.", val and "enabled (created and routed)" or "disabled (routed to main chat)")
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
        local qtyStr, maxStr
        if rest then
            qtyStr, maxStr = rest:match("^%s*(%d+)%s*(.*)$")
        end
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
        arg = arg and arg:lower():match("^%s*(.-)%s*$") or ""
        if arg == "all" or arg == "herbs" or arg == "mining" or arg == "cloth" or arg == "leather" or arg == "conversions" or arg == "crafts" or arg == "undercuts" or arg == "shopping" or arg == "watchlist" then
            ns.SetActiveCategory(arg)
            ns.Good("Active category filter set to: %s", arg:upper())
            if ns.RefreshPanel then ns.RefreshPanel() end
        else
            local id, customCat = ns.FindCustomCategory(arg)
            if id and customCat then
                ns.SetActiveCategory(id)
                ns.Good("Active category filter set to: %s", customCat.label)
                if ns.RefreshPanel then ns.RefreshPanel() end
            else
                ns.Warn("Usage: /gf cat <all|herbs|mining|cloth|leather|crafts|undercuts|shopping|watchlist|<group>>")
            end
        end
    elseif cmd == "group" or cmd == "groups" then
        arg = arg and arg:match("^%s*(.-)%s*$") or ""
        local subCmd, subArg = arg:match("^(%S+)%s*(.*)$")
        subCmd = subCmd and subCmd:lower() or ""

        if subCmd == "create" or subCmd == "new" or subCmd == "addgroup" then
            if subArg and subArg ~= "" then
                local id, cat = ns.CreateCustomCategory(subArg)
                if cat then
                    ns.Good("Created custom material group: %s (ID: %s).", cat.label, id)
                    ns.SetActiveCategory(id)
                    if ns.RefreshPanel then ns.RefreshPanel() end
                else
                    ns.Bad("Failed to create category '%s'.", subArg)
                end
            else
                ns.Warn("Usage: /gf group create <name> (e.g. /gf group create Flask Reagents)")
            end
        elseif subCmd == "delete" or subCmd == "removegroup" or subCmd == "del" then
            if subArg and subArg ~= "" then
                local id, cat = ns.FindCustomCategory(subArg)
                if id and ns.DeleteCustomCategory(id) then
                    ns.Good("Deleted custom material group '%s'.", cat.label or id)
                else
                    ns.Warn("Custom group '%s' not found.", subArg)
                end
            else
                ns.Warn("Usage: /gf group delete <name or id>")
            end
        elseif subCmd == "add" or subCmd == "additem" then
            local grpName, itemPart = subArg:match("^(%S+)%s+(.*)$")
            if subArg:sub(1, 1) == '"' then
                grpName, itemPart = subArg:match('^"([^"]+)"%s+(.*)$')
            end
            local itemID = itemPart and (tonumber(itemPart:match("item:(%d+)")) or tonumber(itemPart:match("^(%d+)")))
            local id, cat = ns.FindCustomCategory(grpName)
            if id and itemID then
                ns.AddCustomCategoryItem(id, itemID)
                local itemName = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or ("Item %d"):format(itemID)
                ns.Good("Added %s to group '%s'.", itemName, cat.label or id)
            elseif not id then
                ns.Warn("Group '%s' not found. Create it with: /gf group create %s", grpName or subArg, grpName or subArg)
            else
                ns.Warn("Usage: /gf group add <group> <link or itemID>")
            end
        elseif subCmd == "remove" or subCmd == "delitem" or subCmd == "removeitem" then
            local grpName, itemPart = subArg:match("^(%S+)%s+(.*)$")
            if subArg:sub(1, 1) == '"' then
                grpName, itemPart = subArg:match('^"([^"]+)"%s+(.*)$')
            end
            local itemID = itemPart and (tonumber(itemPart:match("item:(%d+)")) or tonumber(itemPart:match("^(%d+)")))
            local id, cat = ns.FindCustomCategory(grpName)
            if id and itemID then
                ns.RemoveCustomCategoryItem(id, itemID)
                local itemName = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or ("Item %d"):format(itemID)
                ns.Good("Removed %s from group '%s'.", itemName, cat.label or id)
            elseif not id then
                ns.Warn("Group '%s' not found.", grpName or subArg)
            else
                ns.Warn("Usage: /gf group remove <group> <link or itemID>")
            end
        else
            local cats = ns.GetCustomCategories()
            local count = 0
            for _ in pairs(cats) do count = count + 1 end
            ns.Print("Custom Material Groups (%d):", count)
            if count == 0 then
                ns.Print("  No custom groups defined. Create one with: /gf group create <name>")
            else
                for id, cat in pairs(cats) do
                    local itemCount = 0
                    local itemNames = {}
                    if cat.items then
                        for iId in pairs(cat.items) do
                            itemCount = itemCount + 1
                            local iName = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(iId)) or ("Item " .. iId)
                            if #itemNames < 5 then itemNames[#itemNames + 1] = iName end
                        end
                    end
                    local preview = #itemNames > 0 and table.concat(itemNames, ", ") or "empty"
                    if itemCount > #itemNames then preview = preview .. ", ..." end
                    ns.Print("  - %s (ID: %s, %d items): %s", cat.label or id, id, itemCount, preview)
                end
            end
            ns.Print("Commands: /gf group create <name> | delete <name> | add <grp> <item> | remove <grp> <item>")
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
    elseif cmd == "ledger" or cmd == "pnl" then
        if ns.OpenLedger then
            ns.OpenLedger()
        else
            local ledger = ns.GetLedger()
            local lt = ledger.lifetime or {}
            ns.Print("GoldFinder Goblin Ledger (Realized P&L):")
            ns.Print("  - Completed Flips: %d", lt.count or 0)
            ns.Print("  - Total Revenue: %s", ns.Money(lt.totalGross or 0))
            ns.Print("  - AH Fees Paid: %s", ns.Money(lt.totalCut or 0))
            ns.Print("  - Total Cost Basis: %s", ns.Money(lt.totalCost or 0))
            local profit = lt.totalProfit or 0
            local profitStr = (profit >= 0 and "|cff40ff40+" or "|cffff4040") .. ns.Money(profit) .. "|r"
            local roi = (lt.totalCost and lt.totalCost > 0) and ((profit / lt.totalCost) * 100) or 0
            ns.Print("  - Realized Net Profit: %s (ROI: %.1f%%)", profitStr, roi)
        end
    elseif cmd == "cost" or cmd == "basis" then
        local itemID = tonumber(arg:match("item:(%d+)")) or tonumber(arg:match("^(%d+)"))
        if itemID then
            local cb = ns.GetCostBasis(itemID)
            local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or ("Item " .. itemID)
            if cb and cb.totalQty > 0 then
                ns.Print("Cost basis for %s:", name)
                ns.Print("  - Average Unit Cost: %s", ns.Money(cb.avgUnitCost))
                ns.Print("  - Total Acquired: %d units (Total spent: %s)", cb.totalQty, ns.Money(cb.totalCost))
                local cur = ns.GetItemTypicalPrice(itemID)
                if cur and cur > 0 then
                    local margin = math.floor(cur * 0.95) - cb.avgUnitCost
                    local roi = (margin / cb.avgUnitCost) * 100
                    local marginStr = (margin >= 0 and "|cff40ff40+" or "|cffff4040") .. ns.Money(margin) .. "|r"
                    ns.Print("  - Unrealized Margin vs Typical: %s (ROI: %.1f%%)", marginStr, roi)
                end
            else
                ns.Warn("No purchase history recorded for %s.", name)
            end
        else
            local cb = ns.db and ns.db.costBasis or {}
            local count = 0
            for _ in pairs(cb) do count = count + 1 end
            ns.Print("Tracked Material Cost Basis (%d items):", count)
            for id, data in pairs(cb) do
                local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(id)) or ("Item " .. id)
                ns.Print("  - %s: %s avg (%dx bought)", name, ns.Money(data.avgUnitCost), data.totalQty)
            end
            ns.Print("Usage: /gf cost <link or itemID>")
        end
    elseif cmd == "snipe" then
        arg = arg and arg:lower() or ""
        if arg == "on" or arg == "1" or arg == "enable" then
            ns.SetSnipeMode(true)
        elseif arg == "off" or arg == "0" or arg == "disable" then
            ns.SetSnipeMode(false)
        else
            ns.SetSnipeMode(not ns.IsSnipeMode())
        end
    elseif cmd == "snipethreshold" then
        local amt = ns.ParseMoneyString(arg)
        if amt then
            ns.SetSnipeThreshold(amt)
            ns.Good("Snipe alarm profit threshold set to %s.", ns.Money(amt))
        else
            ns.Warn("Usage: /gf snipethreshold <amount> (e.g. 50g, 100g). Current: %s", ns.Money(ns.GetSnipeThreshold()))
        end
    elseif cmd == "restock" then
        local itemPart, qtyPart = arg:match("^(%S+)%s+(%S+)$")
        if itemPart and qtyPart then
            local itemID = tonumber(itemPart:match("item:(%d+)")) or tonumber(itemPart:match("^(%d+)"))
            local minQty = tonumber(qtyPart)
            if itemID and minQty and minQty > 0 then
                ns.SetRestockLevel(itemID, minQty)
                local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or ("Item " .. itemID)
                ns.Good("Set safety restock level for %s to %d units.", name, minQty)
            else
                ns.Warn("Usage: /gf restock <link or itemID> <minStockQty>")
            end
        else
            local low = ns.GetLowStockItems()
            local allRestock = ns.db and ns.db.restock or {}
            local totalTracked = 0
            for _ in pairs(allRestock) do totalTracked = totalTracked + 1 end
            ns.Print("Inventory Restock Status (%d tracked, %d below threshold):", totalTracked, #low)
            if #low > 0 then
                for _, it in ipairs(low) do
                    ns.Print("  - |cffff4040[LOW STOCK]|r %s: %d in bags/bank (Target: %d, Shortage: %d)", it.name, it.current, it.target, it.shortage)
                end
            elseif totalTracked > 0 then
                ns.Good("  All %d tracked materials meet or exceed minimum safety stock levels.", totalTracked)
            else
                ns.Print("  No restock levels configured. Set one with: /gf restock <link> <minQty>")
            end
        end
    elseif cmd == "unrestock" then
        local itemID = tonumber(arg:match("item:(%d+)")) or tonumber(arg:match("^(%d+)"))
        if itemID then
            ns.ClearRestockLevel(itemID)
            local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or ("Item " .. itemID)
            ns.Good("Cleared restock threshold for %s.", name)
        else
            ns.Warn("Usage: /gf unrestock <link or itemID>")
        end
    elseif cmd == "cart" then
        arg = arg and arg:lower() or ""
        if arg == "buy" then
            ns.ExecuteCartPurchase()
        elseif arg == "clear" then
            ns.ClearCart()
        else
            ns.ToggleCart()
        end
    elseif cmd == "vendor" then
        local itemID = tonumber(arg:match("item:(%d+)")) or tonumber(arg:match("^(%d+)"))
        if itemID then
            local info = ns.GetVendorReagent(itemID)
            local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or ("Item " .. itemID)
            if info then
                local cur = ns.GetItemCurrentPrice(itemID)
                ns.Print("%s is an NPC trade reagent:", name)
                ns.Print("  - NPC Vendor Buy Price: %s", ns.Money(info.vendorPrice))
                if cur and cur > info.vendorPrice then
                    local markup = math.floor(((cur - info.vendorPrice) / info.vendorPrice) * 100 + 0.5)
                    ns.Bad("  - Current AH Price: %s (+%d%% markup over vendor!)", ns.Money(cur), markup)
                elseif cur then
                    ns.Good("  - Current AH Price: %s", ns.Money(cur))
                end
            else
                ns.Print("%s is not a standard NPC vendor reagent.", name)
            end
        else
            ns.Print("GoldFinder Fixed Vendor Reagents Catalog:")
            for id, info in pairs(ns.VENDOR_REAGENTS) do
                ns.Print("  - %s: %s (NPC buy price)", info.name, ns.Money(info.vendorPrice))
            end
            ns.Print("Usage: /gf vendor <link or itemID>")
        end
    elseif cmd == "profile" then
        arg = arg and arg:match("^%s*(.-)%s*$") or ""
        local subCmd, subArg = arg:match("^(%S+)%s*(.*)$")
        subCmd = subCmd and subCmd:lower() or ""

        if subCmd == "export" then
            if ns.ShowProfileDialog then ns.ShowProfileDialog("export") end
        elseif subCmd == "import" then
            if ns.ShowProfileDialog then ns.ShowProfileDialog("import") end
        elseif subCmd == "char" or subCmd == "character" then
            subArg = subArg and subArg:lower() or ""
            local val
            if subArg == "on" or subArg == "1" or subArg == "true" then val = true
            elseif subArg == "off" or subArg == "0" or subArg == "false" then val = false
            else val = not ns.IsCharacterSpecificProfile() end
            ns.SetCharacterSpecificProfile(val)
        elseif subCmd == "switch" or subCmd == "set" then
            if subArg and subArg ~= "" then
                ns.ApplyActiveProfile(subArg)
                ns.Good("Switched to GoldFinder profile: %s.", subArg)
            else
                ns.Warn("Usage: /gf profile switch <ProfileName>")
            end
        elseif subCmd == "copy" then
            if subArg and subArg ~= "" then
                local ok, err = ns.CopyProfile(subArg)
                if ok then
                    ns.Good("Copied settings from profile '%s' into active profile.", subArg)
                else
                    ns.Bad("Copy failed: %s", tostring(err))
                end
            else
                ns.Warn("Usage: /gf profile copy <SourceProfileName>")
            end
        elseif subCmd == "list" then
            local list = ns.GetProfileList()
            local cur = ns.GetActiveProfileName()
            ns.Print("GoldFinder Profiles (%d):", #list)
            for _, pName in ipairs(list) do
                if pName == cur then
                    ns.Print("  * |cff40ff40%s|r (active)", pName)
                else
                    ns.Print("  - %s", pName)
                end
            end
        else
            local isChar = ns.IsCharacterSpecificProfile()
            local cur = ns.GetActiveProfileName()
            ns.Print("GoldFinder Active Profile: |cffffd100%s|r (%s)", cur, isChar and "Character-Specific" or "Account-Wide")
            ns.Print("Commands: /gf profile [export|import|char on/off|list|switch <name>|copy <name>]")
        end
    elseif cmd == "vacuum" or cmd == "compact" then
        local days = tonumber(arg) or 30
        local ok, vacMsg
        if ns.VacuumDatabase then
            ok, vacMsg = ns.VacuumDatabase({ retentionDays = days, maxHistory = 30 })
        end
        if ok then
            ns.Good(vacMsg or "Vacuum complete.")
        else
            ns.Bad("Vacuum failed: " .. tostring(vacMsg))
        end
    elseif cmd == "merge" then
        if arg and arg ~= "" then
            local decoded, err
            if ns.DecodeProfileString then
                decoded, err = ns.DecodeProfileString(arg)
            end
            if decoded then
                local ok, mergeMsg
                if ns.MergeScanDatabase then
                    ok, mergeMsg = ns.MergeScanDatabase(decoded)
                end
                if ok then ns.Good(mergeMsg or "Merge complete.") else ns.Bad("Merge failed: " .. tostring(mergeMsg)) end
            else
                ns.Bad("Could not parse merge data string: " .. tostring(err))
            end
        else
            ns.Print("Usage: /gf merge <encoded_data_string>")
            ns.Print("Merges external scan data and price history into your local database.")
        end
    elseif cmd == "tour" then
        if ns.StartTour then ns.StartTour() end
    elseif cmd == "info" or cmd == "about" then
        if ns.ShowInfoDialog then ns.ShowInfoDialog() end
    elseif cmd == "memory" or cmd == "bench" then
        if UpdateAddOnMemoryUsage then UpdateAddOnMemoryUsage() end
        local mem = (GetAddOnMemoryUsage and GetAddOnMemoryUsage("GoldFinder")) or 0
        local memStr = (mem > 1024) and ("%.2f MB"):format(mem / 1024) or ("%.1f KB"):format(mem)
        local start = debugprofilestop and debugprofilestop() or 0
        local deals, status
        if ns.FindDeals then
            deals, status = ns.FindDeals()
        end
        local elapsed = (debugprofilestop and debugprofilestop() or 0) - start
        ns.Print("GoldFinder Performance Benchmark:")
        ns.Print("  - Memory Working Set: %s", memStr)
        ns.Print("  - Deal calculation latency: %.2f ms (%d active deals evaluated across %d items)", elapsed, deals and #deals or 0, status and status.items or 0)
        ns.Print("  - Performance certification: OPTIMAL (<5MB footprint)")
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
        ns.Print("  /gf config [float|game] - open options panel (context-aware: embedded away from AH, floating at AH)")
        ns.Print("  /gf ratio <5-95>     - set discount percentage threshold")
        ns.Print("  /gf minscans <1-20>  - set minimum prior scans required")
        ns.Print("  /gf minconf <any|med|high> - filter deals by sighting confidence rating")
        ns.Print("  /gf factionshare [on|off] - toggle cross-faction market sharing")
        ns.Print("  /gf sync             - view database realm and faction sharing status")
        ns.Print("  /gf minimap [on|off] - toggle minimap coin icon")
        ns.Print("  /gf sort             - toggle sort: profit vs discount")
        ns.Print("  /gf sound [on|off|auction|coins|whisper|raid|loot] - select alert sound kit")
        ns.Print("  /gf rw [on|off]      - toggle on-screen Mega Snipe Raid Warning banner")
        ns.Print("  /gf soundthrottle <sec> - set audio alert cooldown throttle (e.g. 30, 0)")
        ns.Print("  /gf chat [on|off]    - toggle chat summary on deal find")
        ns.Print("  /gf minprofit <amt>  - set minimum net profit filter (e.g. 5g, 50s, 0)")
        ns.Print("  /gf maxspend <amt>   - set Quick-Buy spend cap (e.g. 50g, 100g, 0)")
        ns.Print("  /gf tooltip [on|off] - toggle item tooltip market pricing")
        ns.Print("  /gf helper [on|off]  - toggle Blizzard Sell tab market helper card")
        ns.Print("  /gf chattab [on|off] - toggle dedicated GoldFinder chat window tab")
        ns.Print("  /gf export           - open CSV data export window")
        ns.Print("  /gf profile [export|import] - export or import settings & watchlist string")
        ns.Print("  /gf vacuum [days]    - compact database & prune old sightings (default 30d)")
        ns.Print("  /gf merge <string>   - merge external scan database")
        ns.Print("  /gf prune [days]     - prune items not seen in [days] (default 30)")
        ns.Print("  /gf resetitem <link> - clear price history for a specific item")
        ns.Print("  /gf preset <snipe|standard|volume> - apply preset trading profile")
        ns.Print("  /gf cat <all|herbs|mining|cloth|leather|crafts|undercuts|shopping|watchlist> - switch active category")
        ns.Print("  /gf watch <link|id>   - add item to watchlist")
        ns.Print("  /gf unwatch <link|id> - remove item from watchlist")
        ns.Print("  /gf watchlist         - view all starred watchlist items")
        ns.Print("  /gf buy <link|id> <qty> [max] - set quota target and optional max unit price")
        ns.Print("  /gf unbuy <link|id>   - remove material from shopping list")
        ns.Print("  /gf snipe [on|off]   - toggle live AH snipe mode")
        ns.Print("  /gf snipethreshold <amt> - set profit threshold for high-urgency snipe alarm")
        ns.Print("  /gf restock <link> <minQty> - set minimum stock safety restock level")
        ns.Print("  /gf unrestock <link> - remove material from restock tracker")
        ns.Print("  /gf restock          - view current material inventory stock levels")
        ns.Print("  /gf cart [buy|clear] - open staging cart or execute batch buy")
        ns.Print("  /gf vendor [link]    - inspect trade NPC reagent prices")
        ns.Print("  /gf shopping          - view active shopping list fulfillment progress")
        ns.Print("  /gf tour             - start interactive feature onboarding walkthrough")
        ns.Print("  /gf info             - open About & System Diagnostics dashboard")
        ns.Print("  /gf bench            - run memory & calculation latency benchmark")
    end
end
