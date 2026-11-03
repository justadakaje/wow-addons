-- GoldFinder -- Core
-- Namespace and chat output. No game API is called at file scope beyond
-- reading this addon's own metadata.

local ADDON, ns = ...

ns.addonName = ADDON
ns.version   = C_AddOns.GetAddOnMetadata(ADDON, "Version") or "unknown"

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

    ns.db = db
end)

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
        ns.Print("Commands:")
        ns.Print("  /gf ratio <5-95>     - set discount percentage threshold")
        ns.Print("  /gf minscans <1-20>  - set minimum prior scans required")
        ns.Print("  /gf sort             - toggle sort: profit vs discount")
        ns.Print("  /gf sound [on|off]   - toggle audio chime on deal find")
        ns.Print("  /gf chat [on|off]    - toggle chat summary on deal find")
        ns.Print("  /gf preset <snipe|standard|volume> - apply preset trading profile")
    end
end
