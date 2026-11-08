-- BiSGearFinder -- Radar
-- Scarcity and monopoly radar: detects when top-tier BiS items have zero active
-- realm listings, alerts players holding unlisted gear to price with monopoly margins,
-- and warns buyers of single-seller price inflation.

local ADDON, ns = ...

ns.Radar = ns.Radar or {}

local warnedItems = {}

---------------------------------------------------------------------------
-- Inventory Scanner & Monopoly Radar
---------------------------------------------------------------------------

local function GetPlayerHeldBiSItems()
    local held = {}
    local getNumSlots = (C_Container and C_Container.GetContainerNumSlots) or _G.GetContainerNumSlots
    local getItemID = (C_Container and C_Container.GetContainerItemID) or _G.GetContainerItemID

    if not getNumSlots or not getItemID then return held end

    for bag = 0, 4 do
        local numSlots = getNumSlots(bag) or 0
        for slot = 1, numSlots do
            local itemID = getItemID(bag, slot)
            if itemID and ns.IsBiSItem(itemID) then
                held[#held + 1] = {
                    itemID = itemID,
                    bag    = bag,
                    slot   = slot,
                    info   = ns.GetItemBiS(itemID),
                }
            end
        end
    end
    return held
end

function ns.CheckMonopolyOpportunities()
    if not (ns.db and ns.db.settings and ns.db.settings.scarcityAlert) then return end

    local held = GetPlayerHeldBiSItems()
    if #held == 0 then return end

    for _, entry in ipairs(held) do
        local itemID = entry.itemID
        local scarcity = ns.GetItemScarcity(itemID)

        if scarcity == "SCARCE" and not warnedItems[itemID] then
            warnedItems[itemID] = true
            local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID))
                or (GetItemInfo and GetItemInfo(itemID))
                or entry.info.name
                or ("Item " .. itemID)

            ns.Good("🔥 |cffffd100Monopoly Radar:|r You have |cffff8000[%s]|r in your bags!", name)
            DEFAULT_CHAT_FRAME:AddMessage("   There are currently |cffff4040ZERO active listings|r on this realm!")
            DEFAULT_CHAT_FRAME:AddMessage("   💡 |cff40ff40Recommendation:|r Price with a +25% to +50% scarcity premium on the AH.")
        end
    end
end

---------------------------------------------------------------------------
-- Event Watcher
---------------------------------------------------------------------------

local radarFrame = CreateFrame("Frame")
radarFrame:RegisterEvent("BAG_UPDATE_DELAYED")
radarFrame:RegisterEvent("AUCTION_HOUSE_SHOW")

local updateArmed = false
radarFrame:SetScript("OnEvent", function(self, event)
    if updateArmed then return end
    updateArmed = true
    C_Timer.After(1.0, function()
        updateArmed = false
        ns.CheckMonopolyOpportunities()
    end)
end)

---------------------------------------------------------------------------
-- Query Helper
---------------------------------------------------------------------------

function ns.GetScarcityReport()
    local all = ns.GetAllBiSItems and ns.GetAllBiSItems() or {}
    local scarce = {}
    local single = {}
    local available = {}

    for itemID, info in pairs(all) do
        local st = ns.GetItemScarcity(itemID)
        if st == "SCARCE" then
            scarce[#scarce + 1] = { itemID = itemID, info = info }
        elseif st == "MONOPOLY_SINGLE" then
            single[#single + 1] = { itemID = itemID, info = info }
        elseif st == "AVAILABLE" then
            available[#available + 1] = { itemID = itemID, info = info }
        end
    end

    return {
        scarce    = scarce,
        single    = single,
        available = available,
    }
end
