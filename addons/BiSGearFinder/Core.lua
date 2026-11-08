-- BiSGearFinder -- Core Engine
-- Best-in-Slot (BiS) BoE equipment radar, scarcity price tracker, and gear upgrade advisor.

local ADDON, ns = ...

rawset(_G, "BiSGearFinder", ns)

local PREFIX = "|cffffd100BiSGearFinder:|r "

function ns.Print(fmt, ...)
    local msg = (select("#", ...) > 0) and fmt:format(...) or fmt
    DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. msg)
end

function ns.Good(fmt, ...)
    local msg = (select("#", ...) > 0) and fmt:format(...) or fmt
    DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. "|cff40ff40" .. msg .. "|r")
end

function ns.Warn(fmt, ...)
    local msg = (select("#", ...) > 0) and fmt:format(...) or fmt
    DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. "|cffff4040" .. msg .. "|r")
end

---------------------------------------------------------------------------
-- SavedVariables & Lifecycle
---------------------------------------------------------------------------

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")

f:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == ADDON then
        BiSGearFinderDB = BiSGearFinderDB or {}
        local db = BiSGearFinderDB
        db.version = 1
        db.settings = db.settings or {
            enabled        = true,
            tooltip        = true,
            scarcityAlert  = true,
            minTier        = "ALL",
        }
        ns.db = db
    elseif event == "PLAYER_LOGIN" then
        local count = 0
        local allItems = ns.GetAllBiSItems and ns.GetAllBiSItems() or {}
        for _ in pairs(allItems) do count = count + 1 end
        ns.Print("Loaded v0.1.0 (%d curated BoE BiS items indexed). Type |cffffd100/bgf|r for options.", count)
    end
end)

---------------------------------------------------------------------------
-- Tooltip Integration
---------------------------------------------------------------------------

local TIER_DISPLAY = {
    PRE_RAID_BIS    = "|cffff8000[Pre-Raid BiS]|r",
    EPIC_WORLD_DROP = "|cffa335ee[Top BoE Epic]|r",
    TWINK_19        = "|cff0070dd[L19 Twink BiS]|r",
    TWINK_39        = "|cff0070dd[L39 Twink BiS]|r",
}

local function AddBiSTooltipLines(tip, itemID)
    if not (ns.db and ns.db.settings and ns.db.settings.tooltip) then return end
    local info = ns.GetItemBiS and ns.GetItemBiS(itemID)
    if not info then return end

    local tierTag = TIER_DISPLAY[info.tier] or "|cffffd100[BiS Gear]|r"
    tip:AddLine(" ")
    tip:AddDoubleLine("|cffffd100BiSGearFinder:|r", tierTag, 1, 1, 1, 1, 1, 1)

    if info.classes and #info.classes > 0 then
        local classList = table.concat(info.classes, ", ")
        tip:AddDoubleLine("|cff888888Target Classes:|r", "|cff00ccff" .. classList .. "|r", 1, 1, 1, 1, 1, 1)
    end

    if info.note then
        tip:AddLine("|cffffd100Note:|r " .. info.note, 0.9, 0.9, 0.9, true)
    end

    -- Market intelligence bridge (if GoldFinder is present)
    if ns.GetMarketSummary then
        local summary = ns.GetMarketSummary(itemID)
        if summary then
            tip:AddDoubleLine("|cff888888AH Market:|r", summary, 1, 1, 1, 1, 1, 1)
        end
    end
end

local function OnTooltipSetItem(tip)
    local _, link = tip:GetItem()
    if not link then return end
    local itemID = tonumber(link:match("item:(%d+)"))
    if itemID then
        AddBiSTooltipLines(tip, itemID)
    end
end

if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall and Enum.TooltipDataType and Enum.TooltipDataType.Item then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tip, data)
        if tip == GameTooltip or tip == ItemRefTooltip then
            local itemID = data and data.id
            if itemID then
                AddBiSTooltipLines(tip, itemID)
            end
        end
    end)
else
    if GameTooltip and GameTooltip.HookScript then
        GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
    end
    if ItemRefTooltip and ItemRefTooltip.HookScript then
        ItemRefTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
    end
end

---------------------------------------------------------------------------
-- Slash Commands: /bgf and /bis
---------------------------------------------------------------------------

local function FormatItemLink(itemID, fallback)
    local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID))
        or (GetItemInfo and GetItemInfo(itemID))
        or fallback
        or ("Item " .. itemID)
    return ("|cffffd100[%s]|r (ID: %d)"):format(name, itemID)
end

local function HandleSlash(msg)
    local cmd, arg = msg:match("^(%S+)%s*(.*)$")
    cmd = (cmd or ""):lower()
    arg = arg and arg:match("^%s*(.-)%s*$") or ""

    if cmd == "" or cmd == "browse" or cmd == "ui" then
        if ns.ToggleBrowser then
            ns.ToggleBrowser()
        end

    elseif cmd == "scan" then
        if ns.StartBiSScan then
            ns.StartBiSScan()
        end

    elseif cmd == "radar" then
        if ns.GetScarcityReport then
            local rep = ns.GetScarcityReport()
            ns.Good("BiS Realm Scarcity Report:")
            DEFAULT_CHAT_FRAME:AddMessage(("  🔥 |cffff4040Unlisted (Zero Listings):|r %d items"):format(#rep.scarce))
            DEFAULT_CHAT_FRAME:AddMessage(("  ⚠️ |cffff9900Single Seller (Monopoly):|r %d items"):format(#rep.single))
            DEFAULT_CHAT_FRAME:AddMessage(("  ✓ |cff40ff40Active Listings:|r %d items"):format(#rep.available))
            if #rep.scarce > 0 then
                local names = {}
                for i = 1, math.min(5, #rep.scarce) do
                    names[#names + 1] = rep.scarce[i].info.name
                end
                DEFAULT_CHAT_FRAME:AddMessage("  Top Unlisted: " .. table.concat(names, ", "))
            end
        end
        if ns.CheckMonopolyOpportunities then
            ns.CheckMonopolyOpportunities()
        end

    elseif cmd == "list" then
        local all = ns.GetAllBiSItems and ns.GetAllBiSItems() or {}
        local filter = arg:upper()
        local matched = {}

        for itemID, info in pairs(all) do
            local pass = false
            if filter == "" or filter == "ALL" then
                pass = true
            elseif info.tier:upper():find(filter, 1, true) then
                pass = true
            else
                for _, c in ipairs(info.classes) do
                    if c:upper() == filter then
                        pass = true
                        break
                    end
                end
            end
            if pass then
                matched[#matched + 1] = { itemID = itemID, info = info }
            end
        end

        table.sort(matched, function(a, b)
            return (a.info.reqLevel or 0) > (b.info.reqLevel or 0)
        end)

        ns.Print("Matched %d BiS BoE items%s:", #matched, filter ~= "" and (" for '" .. filter .. "'") or "")
        for i = 1, math.min(15, #matched) do
            local m = matched[i]
            local tag = TIER_DISPLAY[m.info.tier] or m.info.tier
            DEFAULT_CHAT_FRAME:AddMessage(("  %s %s - Lvl %d %s (%s)"):format(
                tag,
                FormatItemLink(m.itemID, m.info.name),
                m.info.reqLevel or 0,
                m.info.armorType or "",
                table.concat(m.info.classes, "/")
            ))
        end
        if #matched > 15 then
            DEFAULT_CHAT_FRAME:AddMessage(("  |cff888888... and %d more items.|r"):format(#matched - 15))
        end

    elseif cmd == "check" then
        local itemID = tonumber(arg) or tonumber(arg:match("item:(%d+)"))
        if not itemID then
            ns.Warn("Usage: /bgf check <itemLink|itemID>")
            return
        end
        local info = ns.GetItemBiS and ns.GetItemBiS(itemID)
        if info then
            ns.Good("Found: %s", FormatItemLink(itemID, info.name))
            DEFAULT_CHAT_FRAME:AddMessage("  Tier: " .. (TIER_DISPLAY[info.tier] or info.tier))
            DEFAULT_CHAT_FRAME:AddMessage("  Slot: " .. info.slot .. " (" .. (info.armorType or "Generic") .. ")")
            DEFAULT_CHAT_FRAME:AddMessage("  Classes: " .. table.concat(info.classes, ", "))
            DEFAULT_CHAT_FRAME:AddMessage("  Note: " .. info.note)
        else
            ns.Print("Item ID %d is not in the curated BiS matrix.", itemID)
        end

    elseif cmd == "tooltip" then
        if ns.db and ns.db.settings then
            ns.db.settings.tooltip = not ns.db.settings.tooltip
            ns.Good("Tooltip annotations: %s", ns.db.settings.tooltip and "|cff40ff40Enabled|r" or "|cffff4040Disabled|r")
        end

    elseif cmd == "info" then
        local all = ns.GetAllBiSItems and ns.GetAllBiSItems() or {}
        local count, preRaid, epics, twinks = 0, 0, 0, 0
        for _, info in pairs(all) do
            count = count + 1
            if info.tier == "PRE_RAID_BIS" then preRaid = preRaid + 1
            elseif info.tier == "EPIC_WORLD_DROP" then epics = epics + 1
            elseif info.tier:find("TWINK") then twinks = twinks + 1
            end
        end
        ns.Print("Status: v0.1.0 | %d Total BiS BoE Items Tracked", count)
        DEFAULT_CHAT_FRAME:AddMessage(("  • Pre-Raid BiS: %d"):format(preRaid))
        DEFAULT_CHAT_FRAME:AddMessage(("  • Epic World Drops: %d"):format(epics))
        DEFAULT_CHAT_FRAME:AddMessage(("  • Twink Tournament BiS: %d"):format(twinks))
        if GoldFinderDB and GoldFinderDB.items then
            ns.Good("GoldFinder Market Bridge: Connected (Reading live AH history)")
        else
            DEFAULT_CHAT_FRAME:AddMessage("  • GoldFinder Bridge: Standalone Mode")
        end

    else
        ns.Print("Commands:")
        DEFAULT_CHAT_FRAME:AddMessage("  |cffffd100/bgf|r (or /bis) - Open interactive BiS BoE radar browser")
        DEFAULT_CHAT_FRAME:AddMessage("  |cffffd100/bgf scan|r - Start targeted Auction House query for all BiS items")
        DEFAULT_CHAT_FRAME:AddMessage("  |cffffd100/bgf radar|r - Scan inventory for unlisted monopoly items & print scarcity")
        DEFAULT_CHAT_FRAME:AddMessage("  |cffffd100/bgf list [class|tier]|r - List tracked BiS items (e.g. /bgf list warrior, /bgf list twink)")
        DEFAULT_CHAT_FRAME:AddMessage("  |cffffd100/bgf check <link|id>|r - Look up an item in the BiS database")
        DEFAULT_CHAT_FRAME:AddMessage("  |cffffd100/bgf tooltip|r - Toggle item tooltip annotations")
        DEFAULT_CHAT_FRAME:AddMessage("  |cffffd100/bgf info|r - View database status and bridge connectivity")
    end
end

SLASH_BISGEARFINDER1 = "/bgf"
SLASH_BISGEARFINDER2 = "/bis"
SlashCmdList["BISGEARFINDER"] = HandleSlash
