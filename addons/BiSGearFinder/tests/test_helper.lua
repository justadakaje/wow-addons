-- test_helper.lua -- Busted test helper & WoW API stubs for BiSGearFinder
-- Provides headless WoW API simulation for pure-logic unit testing.

local helper = {}

helper.chatMessages = {}
helper.playedSounds = {}
helper.timers = {}
helper.mockItemNames = {}
helper.mockItemIcons = {}
helper.mockHeldItems = {} -- bag -> slot -> itemID
helper.currentTime = 1000
helper.currentServerTime = 1700000000
helper.mockSearchResults = {} -- itemID -> array of { buyoutAmount = x, quantity = y }

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

_G.time = function()
    return helper.currentServerTime
end

_G.UnitClass = function(unit)
    if unit == "player" then
        return "Warrior", "WARRIOR", 1
    end
    return "Warrior", "WARRIOR", 1
end

_G.C_Item = {
    GetItemNameByID = function(itemID)
        return helper.mockItemNames[itemID]
    end,
    GetItemIconByID = function(itemID)
        return helper.mockItemIcons[itemID] or 134400
    end,
    GetItemLinkByID = function(itemID)
        local name = helper.mockItemNames[itemID] or ("Item " .. tostring(itemID))
        return string.format("|cffa335ee|Hitem:%d::::::::||h[%s]|h|r", itemID, name)
    end,
}

_G.GetItemInfo = function(itemID)
    local name = helper.mockItemNames[itemID]
    if not name then return nil end
    local link = string.format("|cffa335ee|Hitem:%d::::::::||h[%s]|h|r", itemID, name)
    return name, link, 4, 60, 50, "Armor", "Plate", 1, "INVTYPE_HEAD", 134400, 1000
end

_G.GetItemIcon = function(itemID)
    return helper.mockItemIcons[itemID] or 134400
end

_G.C_Container = {
    GetContainerNumSlots = function(_bag)
        return 16
    end,
    GetContainerItemID = function(bag, slot)
        if helper.mockHeldItems[bag] then
            return helper.mockHeldItems[bag][slot]
        end
        return nil
    end,
}
_G.GetContainerNumSlots = _G.C_Container.GetContainerNumSlots
_G.GetContainerItemID = _G.C_Container.GetContainerItemID

_G.C_AuctionHouse = {
    MakeItemKey = function(itemID)
        return { itemID = itemID }
    end,
    SearchForItemKeys = function(_keys, _sorts)
        return true
    end,
    SendSearchQuery = function(_itemKey, _sorts, _separateOwnerItems)
        return true
    end,
    GetNumItemSearchResults = function(itemKey)
        local id = itemKey and itemKey.itemID
        local results = helper.mockSearchResults[id]
        return results and #results or 0
    end,
    GetItemSearchResultInfo = function(itemKey, index)
        local id = itemKey and itemKey.itemID
        local results = helper.mockSearchResults[id]
        if results and results[index] then
            return results[index]
        end
        return nil
    end,
}

_G.AuctionHouseFrame = {
    shown = false,
    IsShown = function(self) return self.shown end,
    Show = function(self) self.shown = true end,
    Hide = function(self) self.shown = false end,
}

_G.C_Timer = {
    After = function(seconds, callback)
        table.insert(helper.timers, { delay = seconds, callback = callback })
    end,
}

_G.DEFAULT_CHAT_FRAME = {
    AddMessage = function(_self, msg)
        table.insert(helper.chatMessages, msg)
    end,
}

_G.SlashCmdList = {}
_G.UISpecialFrames = {}

local function CreateMockTooltip()
    local tip = {
        lines = {},
        doubleLines = {},
        shown = false,
        scripts = {},
    }
    function tip:AddLine(text, _r, _g, _b, _wrap)
        table.insert(tip.lines, text)
    end
    function tip:AddDoubleLine(leftText, rightText, _lr, _lg, _lb, _rr, _rg, _rb)
        table.insert(tip.doubleLines, { left = leftText, right = rightText })
    end
    function tip:SetOwner(_owner, _anchor) end
    function tip:SetItemByID(_itemID) end
    function tip:Show() tip.shown = true end
    function tip:Hide() tip.shown = false end
    function tip:HookScript(script, fn) tip.scripts[script] = fn end
    function tip:GetItem() return "Item", "|cffa335ee|Hitem:14551::::::::||h[Edgemaster's Handguards]|h|r" end
    return tip
end

_G.GameTooltip = CreateMockTooltip()
_G.ItemRefTooltip = CreateMockTooltip()

_G.UIParent = {}

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
    function f:Show()
        f.shown = true
        if f.scripts["OnShow"] then f.scripts["OnShow"](f) end
    end
    function f:Hide()
        f.shown = false
        if f.scripts["OnHide"] then f.scripts["OnHide"](f) end
    end
    function f:IsShown() return f.shown end
    function f:Raise() end
    function f:SetPoint(...) table.insert(f.points, {...}) end
    function f:SetSize(w, h) f.width = w; f.height = h end
    function f:SetWidth(w) f.width = w end
    function f:SetHeight(h) f.height = h end
    function f:GetWidth() return f.width end
    function f:GetHeight() return f.height end
    function f:EnableMouse() end
    function f:SetMovable() end
    function f:SetFrameStrata() end
    function f:SetToplevel() end
    function f:SetClampedToScreen() end
    function f:RegisterForDrag() end
    function f:SetBackdrop() end
    function f:SetBackdropColor() end
    function f:SetEnabled() end
    function f:SetText(t) f.text = t end
    function f:GetText() return f.text end
    function f:CreateFontString()
        local fs = {
            SetFontObject = function() end,
            SetPoint = function() end,
            SetText = function(str, text) str.text = text end,
            GetText = function(str) return str.text or "" end,
            SetTextColor = function() end,
            SetJustifyH = function() end,
            SetJustifyV = function() end,
            SetWidth = function() end,
            SetHeight = function() end,
            SetWordWrap = function() end,
            GetStringWidth = function() return 50 end,
        }
        return fs
    end
    function f:CreateTexture()
        local tex = {
            SetTexture = function(tObj, t) tObj.texture = t end,
            SetColorTexture = function() end,
            SetAllPoints = function() end,
            SetPoint = function() end,
            SetSize = function() end,
            SetVertexColor = function() end,
            Hide = function() end,
            Show = function() end,
        }
        return tex
    end
    if name and _G then
        _G[name] = f
    end
    return f
end

_G.CreateFrame = CreateMockFrame

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
    helper.timers = {}
    helper.mockItemNames = {}
    helper.mockItemIcons = {}
    helper.mockHeldItems = {}
    helper.mockSearchResults = {}
    helper.currentTime = 1000
    helper.currentServerTime = 1700000000
    _G.GameTooltip.lines = {}
    _G.GameTooltip.doubleLines = {}
    _G.AuctionHouseFrame.shown = false
    _G.GoldFinderDB = nil
    _G.BiSGearFinderDB = nil
end

function helper.createNamespace(overrides)
    local ns = {
        addonName = "BiSGearFinder",
        version = "0.1.0",
        Knowledge = {},
        Scanner = {},
        Radar = {},
        db = {
            version = 1,
            settings = {
                enabled = true,
                tooltip = true,
                scarcityAlert = true,
                minTier = "ALL",
            },
            cache = {},
        },
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
    chunk("BiSGearFinder", ns)
    return ns
end

return helper
