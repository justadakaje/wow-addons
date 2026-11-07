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
ns.DB_SCHEMA = 3

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
    if db.settings.sortBy == nil then db.settings.sortBy = "profit" end
    if db.settings.tooltip == nil then db.settings.tooltip = true end
    if db.settings.minProfit == nil then db.settings.minProfit = 0 end
    if db.settings.maxQuickBuySpend == nil then db.settings.maxQuickBuySpend = 500000 end
    if type(db.watchlist) ~= "table" then db.watchlist = {} end

    ns.db = db
end)

---------------------------------------------------------------------------
-- Category & Watchlist State

ns.activeCategory = "all"

function ns.GetActiveCategory()
    return ns.activeCategory or "all"
end

function ns.SetActiveCategory(cat)
    cat = cat and cat:lower() or "all"
    local valid = { all = true, herbs = true, mining = true, cloth = true, leather = true, watchlist = true }
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
-- Slash commands

SLASH_GOLDFINDER1 = "/goldfinder"
SLASH_GOLDFINDER2 = "/gf"
SlashCmdList["GOLDFINDER"] = function(msg)
    msg = (msg or ""):match("^%s*(.-)%s*$")
    local cmd, arg = msg:match("^(%S+)%s*(.*)$")
    cmd = cmd and cmd:lower() or ""

    if cmd == "ratio" or cmd == "discount" then
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
        local val
        if arg == "on" or arg == "1" or arg == "true" then val = true
        elseif arg == "off" or arg == "0" or arg == "false" then val = false
        else val = not ns.IsSoundAlertEnabled() end
        ns.SetSoundAlert(val)
        ns.Good("Deal audio chime %s.", val and "enabled" or "disabled")
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
    elseif cmd == "cat" or cmd == "category" then
        arg = arg and arg:lower() or ""
        if arg == "all" or arg == "herbs" or arg == "mining" or arg == "cloth" or arg == "leather" or arg == "watchlist" then
            ns.SetActiveCategory(arg)
            ns.Good("Active category filter set to: %s", arg:upper())
            if ns.RefreshPanel then ns.RefreshPanel() end
        else
            ns.Warn("Usage: /gf cat <all|herbs|mining|cloth|leather|watchlist>")
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
        ns.Print("  - Audio chime: %s", ns.IsSoundAlertEnabled() and "on" or "off")
        ns.Print("  - Chat notification: %s", ns.IsChatAlertEnabled() and "on" or "off")
        ns.Print("  - Item tooltip pricing: %s", ns.IsTooltipEnabled() and "on" or "off")
        local minProfit = ns.GetMinProfit()
        local minProfitStr = (minProfit > 0) and ns.Money(minProfit) or "none (0c)"
        ns.Print("  - Min profit floor: %s", minProfitStr)
        local maxSpend = ns.GetMaxQuickBuySpend()
        local maxSpendStr = (maxSpend > 0) and ns.Money(maxSpend) or "none (no limit)"
        ns.Print("  - Quick-Buy max spend cap: %s", maxSpendStr)
        ns.Print("Commands:")
        ns.Print("  /gf ratio <5-95>     - set discount percentage threshold")
        ns.Print("  /gf minscans <1-20>  - set minimum prior scans required")
        ns.Print("  /gf sort             - toggle sort: profit vs discount")
        ns.Print("  /gf sound [on|off]   - toggle audio chime on deal find")
        ns.Print("  /gf chat [on|off]    - toggle chat summary on deal find")
        ns.Print("  /gf minprofit <amt>  - set minimum net profit filter (e.g. 5g, 50s, 0)")
        ns.Print("  /gf maxspend <amt>   - set Quick-Buy spend cap (e.g. 50g, 100g, 0)")
        ns.Print("  /gf tooltip [on|off] - toggle item tooltip market pricing")
        ns.Print("  /gf export           - open CSV data export window")
        ns.Print("  /gf prune [days]     - prune items not seen in [days] (default 30)")
        ns.Print("  /gf resetitem <link> - clear price history for a specific item")
        ns.Print("  /gf preset <snipe|standard|volume> - apply preset trading profile")
        ns.Print("  /gf cat <all|herbs|mining|cloth|leather|watchlist> - switch active category")
        ns.Print("  /gf watch <link|id>   - add item to watchlist")
        ns.Print("  /gf unwatch <link|id> - remove item from watchlist")
        ns.Print("  /gf watchlist         - view all starred watchlist items")
    end
end
