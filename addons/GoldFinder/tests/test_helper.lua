-- test_helper.lua -- Busted test helper & WoW API stubs for GoldFinder
-- Provides headless WoW API simulation for pure-logic unit testing.

local helper = {}

-- State tracking for assertions
helper.chatMessages = {}
helper.playedSounds = {}
helper.raidNotices = {}
helper.timers = {}
helper.mockItemNames = {}
helper.mockItemCounts = {}
helper.createdFrames = {}
helper.currentTime = 1000
helper.currentServerTime = 1700000000
helper.playerMoney = 5000000 -- 500g

-------------------------------------------------------------------------------
-- WoW Global Stubs & Environment
-------------------------------------------------------------------------------

_G.wipe = function(t)
    if t then
        for k in pairs(t) do
            t[k] = nil
        end
    end
    return t
end

_G.tinsert = table.insert
_G.tremove = table.remove
_G.date = os.date
_G.time = os.time

_G.strsplit = function(delim, str, limit)
    if not str then return nil end
    local result = {}
    local pattern = "(.-)" .. delim
    local last_end = 1
    local s, e, cap = str:find(pattern, 1)
    local count = 0
    while s do
        count = count + 1
        if limit and count >= limit then break end
        table.insert(result, cap)
        last_end = e + 1
        s, e, cap = str:find(pattern, last_end)
    end
    table.insert(result, str:sub(last_end))
    return unpack(result)
end

_G.strjoin = function(delim, ...)
    local args = {...}
    for i = 1, select("#", ...) do
        args[i] = tostring(args[i] or "")
    end
    return table.concat(args, delim)
end

_G.strtrim = function(s)
    if not s then return nil end
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

_G.format = string.format

_G.GetTime = function()
    return helper.currentTime
end

_G.GetServerTime = function()
    return helper.currentServerTime
end

_G.GetMoney = function()
    return helper.playerMoney
end

_G.UnitName = function(_unit)
    return "Tester"
end

_G.GetRealmName = function()
    return "TestRealm"
end

_G.C_Item = {
    GetItemNameByID = function(itemID)
        return helper.mockItemNames[itemID] or ("Item " .. tostring(itemID))
    end,
    GetItemCount = function(itemID, _includeBank)
        return helper.mockItemCounts[itemID] or 0
    end,
    GetItemInfoInstant = function(itemID)
        return itemID, "item", "parts", 1, 1, 7, 0
    end,
    GetItemIconByID = function(_itemID)
        return 134400
    end,
}

_G.IsControlKeyDown = function() return false end
_G.UISpecialFrames = _G.UISpecialFrames or {}

_G.GetItemInfo = function(itemID)
    local name = helper.mockItemNames[itemID] or ("Item " .. tostring(itemID))
    local link = string.format("|cffffffff|Hitem:%d::::::::||h[%s]|h|r", itemID, name)
    -- returns: name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice
    return name, link, 1, 1, 1, "Trade Goods", "Parts", 20, "", 134400, 10
end

_G.GetItemCount = function(itemID, _includeBank)
    return helper.mockItemCounts[itemID] or 0
end

_G.C_CurrencyInfo = {
    GetCoinTextureString = function(copper, _height)
        copper = math.floor(copper or 0)
        local g = math.floor(copper / 10000)
        local s = math.floor((copper % 10000) / 100)
        local c = copper % 100
        if g > 0 then return string.format("%dg %ds %dc", g, s, c) end
        if s > 0 then return string.format("%ds %dc", s, c) end
        return string.format("%dc", c)
    end,
}

_G.C_Timer = {
    After = function(seconds, callback)
        table.insert(helper.timers, { delay = seconds, callback = callback })
    end,
}

_G.C_AddOns = {
    GetAddOnMetadata = function(_addon, field)
        if field == "Version" then return "1.0.6" end
        return nil
    end,
    IsAddOnLoaded = function(_addon) return true end,
}
_G.GetAddOnMetadata = _G.C_AddOns.GetAddOnMetadata

_G.RaidWarningFrame = {}
_G.ChatTypeInfo = { RAID_WARNING = { r = 1, g = 0.2, b = 0.2 } }
_G.RaidNotice_AddMessage = function(frame, msg, chatTypeInfo)
    table.insert(helper.raidNotices, msg)
end

_G.DEFAULT_CHAT_FRAME = {
    AddMessage = function(_self, msg)
        table.insert(helper.chatMessages, msg)
    end,
}

_G.hooksecurefunc = function(arg1, arg2, arg3)
    local targetTable, funcName, hookFn
    if type(arg1) == "table" then
        targetTable, funcName, hookFn = arg1, arg2, arg3
    else
        targetTable, funcName, hookFn = _G, arg1, arg2
    end
    local orig = targetTable[funcName]
    targetTable[funcName] = function(...)
        if orig then orig(...) end
        return hookFn(...)
    end
end

_G.PlaySound = function(soundID)
    table.insert(helper.playedSounds, soundID)
end

_G.SOUNDKIT = {
    IG_MAINMENU_OPEN = 1,
    IG_MAINMENU_CLOSE = 2,
    IG_CHARACTER_INFO_TAB = 3,
}

_G.SlashCmdList = {}
_G.UISpecialFrames = {}

local function CreateMockFrame(frameType, name, parent, template)
    local f = {
        name = name,
        parent = parent,
        frameType = frameType,
        template = template,
        scripts = {},
        events = {},
        points = {},
        shown = true,
        width = 0,
        height = 0,
        checked = false,
        value = 0,
        scrollVal = 0,
    }
    function f:SetScript(handler, fn) f.scripts[handler] = fn end
    function f:GetScript(handler) return f.scripts[handler] end
    function f:RegisterEvent(event) f.events[event] = true end
    function f:UnregisterEvent(event) f.events[event] = nil end
    function f:IsEventRegistered(event) return f.events[event] == true end
    function f:FireEvent(event, ...)
        if f.scripts["OnEvent"] then
            f.scripts["OnEvent"](f, event, ...)
        end
    end
    function f:Show() f.shown = true end
    function f:Hide() f.shown = false end
    function f:IsShown() return f.shown end
    function f:SetPoint(...) table.insert(f.points, {...}) end
    function f:SetSize(w, h) f.width = w; f.height = h end
    function f:SetWidth(w) f.width = w end
    function f:SetHeight(h) f.height = h end
    function f:GetWidth() return f.width end
    function f:GetHeight() return f.height end
    function f:EnableMouse() end
    function f:SetMovable() end
    function f:RegisterForDrag() end
    function f:SetBackdrop() end
    function f:SetBackdropColor() end
    function f:SetBackdropBorderColor() end
    function f:SetFrameStrata() end
    function f:SetToplevel() end
    function f:SetClampedToScreen() end
    function f:SetScrollChild(c) f.scrollChild = c end
    function f:EnableMouseWheel() end
    function f:GetVerticalScroll() return f.scrollVal or 0 end
    function f:SetVerticalScroll(v) f.scrollVal = v end
    function f:GetVerticalScrollRange() return 200 end
    function f:SetChecked(val) f.checked = (val == true or val == 1) end
    function f:GetChecked() return f.checked end
    function f:SetValue(v) f.value = v end
    function f:GetValue() return f.value end
    function f:SetMinMaxValues(minV, maxV) f.minV = minV; f.maxV = maxV end
    function f:SetValueStep(s) f.step = s end
    function f:SetObeyStepOnDrag() end
    function f:SetText(t) f.text = t end
    function f:GetText() return f.text or "" end
    function f:LockHighlight() f.lockedHighlight = true end
    function f:UnlockHighlight() f.lockedHighlight = false end
    function f:Raise() end
    function f:StartMoving() end
    function f:StopMovingOrSizing() end
    function f:ClearAllPoints() f.points = {} end
    function f:GetParent() return f.parent end
    function f:GetName() return f.name end
    function f:CreateFontString()
        local fs = { shown = true }
        function fs:SetFontObject() end
        function fs:SetPoint() end
        function fs:ClearAllPoints() end
        function fs:SetText(text) fs.text = text end
        function fs:GetText() return fs.text or "" end
        function fs:SetTextColor() end
        function fs:SetJustifyH() end
        function fs:SetJustifyV() end
        function fs:SetWidth() end
        function fs:SetHeight() end
        function fs:GetStringWidth() return 50 end
        function fs:Show() fs.shown = true end
        function fs:Hide() fs.shown = false end
        function fs:IsShown() return fs.shown end
        return fs
    end
    function f:CreateTexture()
        local tex = { shown = true }
        function tex:SetTexture() end
        function tex:SetColorTexture() end
        function tex:SetAllPoints() end
        function tex:ClearAllPoints() end
        function tex:SetPoint() end
        function tex:SetSize() end
        function tex:SetWidth() end
        function tex:SetHeight() end
        function tex:SetVertexColor() end
        function tex:Show() tex.shown = true end
        function tex:Hide() tex.shown = false end
        function tex:IsShown() return tex.shown end
        return tex
    end
    if name and _G then
        _G[name] = f
    end
    table.insert(helper.createdFrames, f)
    return f
end

_G.CreateFrame = CreateMockFrame

_G.InterfaceOptions_AddCategory = function(panel) helper.lastAddedCategory = panel end
_G.InterfaceOptionsFrame_OpenToCategory = function(panel) helper.lastOpenedCategory = panel end

-------------------------------------------------------------------------------
-- Module Loading & Namespace Setup
-------------------------------------------------------------------------------

local source = debug.getinfo(1, "S").source:gsub("^@", ""):gsub("\\", "/")
local helperDir = source:match("(.*/)") or "./"
local addonDir = helperDir:gsub("tests/?$", "")

function helper.getAddonDir()
    return addonDir
end

function helper.reset()
    helper.chatMessages = {}
    helper.playedSounds = {}
    helper.raidNotices = {}
    helper.timers = {}
    helper.mockItemNames = {}
    helper.mockItemCounts = {}
    helper.createdFrames = {}
    helper.currentTime = 1000
    helper.currentServerTime = 1700000000
    helper.playerMoney = 5000000
end

function helper.createNamespace(overrides)
    local ns = {
        addonName = "GoldFinder",
        version = "2.0.0",
        db = {
            items = {},
            scans = {},
            settings = {
                dealRatio = 0.70,
                minPrior = 3,
                minProfit = 0,
                sortBy = "discount",
                valuationModel = "median",
                minConfidence = "any",
            },
            history = {},
            watchlist = {},
            blacklist = {},
        },
        L = setmetatable({}, {
            __index = function(_, k) return k end,
        }),
        Print = function(...)
            table.insert(helper.chatMessages, string.format(...))
        end,
        Good = function(...)
            table.insert(helper.chatMessages, string.format(...))
        end,
        Warn = function(...)
            table.insert(helper.chatMessages, string.format(...))
        end,
    }

    -- Basic accessors mirroring Core.lua defaults
    function ns.GetDealRatio() return (ns.db and ns.db.settings and ns.db.settings.dealRatio) or 0.70 end
    function ns.SetDealRatio(r) if ns.db and ns.db.settings then ns.db.settings.dealRatio = r end end
    function ns.GetMinPrior() return (ns.db and ns.db.settings and ns.db.settings.minPrior) or 3 end
    function ns.GetSortBy() return (ns.db and ns.db.settings and ns.db.settings.sortBy) or "discount" end
    function ns.GetMinProfit() return (ns.db and ns.db.settings and ns.db.settings.minProfit) or 0 end
    function ns.GetValuationModel() return (ns.db and ns.db.settings and ns.db.settings.valuationModel) or "median" end
    function ns.GetMinConfidence() return (ns.db and ns.db.settings and ns.db.settings.minConfidence) or "any" end
    function ns.GetSnipeThreshold() return 1000000 end
    function ns.IsBlacklisted(itemID) return ns.db and ns.db.blacklist and (ns.db.blacklist[itemID] == true) end
    function ns.IsWatched(itemID) return ns.db and ns.db.watchlist and (ns.db.watchlist[itemID] == true) end

    function ns.Money(copper)
        copper = math.floor(copper or 0)
        local g = math.floor(copper / 10000)
        local s = math.floor((copper % 10000) / 100)
        local c = copper % 100
        if g > 0 then return string.format("%dg %ds %dc", g, s, c) end
        if s > 0 then return string.format("%ds %dc", s, c) end
        return string.format("%dc", c)
    end

    if overrides then
        for k, v in pairs(overrides) do
            ns[k] = v
        end
    end

    return ns
end

function helper.loadAddonFile(filename, ns)
    local fullPath = addonDir .. filename
    local chunk, err = loadfile(fullPath)
    if not chunk then
        error(string.format("Failed to load file '%s': %s", fullPath, tostring(err)))
    end
    chunk("GoldFinder", ns)
    return ns
end

return helper
