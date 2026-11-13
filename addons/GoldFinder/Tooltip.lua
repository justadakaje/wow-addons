-- GoldFinder -- Tooltip
-- Appends recorded typical price and lowest seen price to item tooltips
-- in bags, vendor screens, and world links.

local ADDON, ns = ...

local function Median(values)
    local t = {}
    for i = 1, #values do t[i] = values[i] end
    table.sort(t)
    local n = #t
    if n % 2 == 1 then return t[(n + 1) / 2] end
    return (t[n / 2] + t[n / 2 + 1]) / 2
end

local function AddPriceLines(tip, itemID)
    if not (ns.IsTooltipEnabled and ns.IsTooltipEnabled()) then return end
    local db = ns.db
    if not db then return end

    local rec = db.items and db.items[itemID]
    local cost = ns.GetCostBasis and ns.GetCostBasis(itemID)
    local hasHistory = rec and rec.history and #rec.history > 0
    local hasCost = cost and cost.totalQty and cost.totalQty > 0 and (ns.IsCostBasisTooltipEnabled and ns.IsCostBasisTooltipEnabled())
    local vInfo = ns.GetVendorReagent and ns.GetVendorReagent(itemID)
    local restockTarget = ns.GetRestockLevel and ns.GetRestockLevel(itemID)
    local advice = (MailFrame and MailFrame:IsShown() and ns.EvaluateExpiredAuction) and ns.EvaluateExpiredAuction(itemID)
    local deNet = ns.GetDisenchantValue and ns.GetDisenchantValue(itemID)
    local altTotal, altRows = 0, {}
    if ns.GetAltItemBreakdown then
        altTotal, altRows = ns.GetAltItemBreakdown(itemID)
    end

    if not hasHistory and not hasCost and not vInfo and not restockTarget and not advice and not deNet and not (altTotal and altTotal > 0) then return end

    local typical = nil
    tip:AddLine(" ")

    if hasHistory then
        local h = rec.history
        local prior = {}
        for i = 1, #h do prior[i] = h[i].min end

        typical = (ns.CalculateBaseline and ns.CalculateBaseline(prior)) or Median(prior)
        local latest = h[#h]
        local now = GetServerTime()
        local age = now - (latest.seen or latest.t)
        local ageStr
        if age < 60 then
            ageStr = "<1m ago"
        elseif age < 3600 then
            ageStr = ("%dm ago"):format(math.floor(age / 60))
        else
            ageStr = ("%.0fh ago"):format(age / 3600)
        end

        local conf = ns.GetConfidenceScore and ns.GetConfidenceScore(h)
        local typStr = ns.Money(typical)
        if conf and conf.tag then
            typStr = ("%s %s%s|r"):format(typStr, conf.colorStr, conf.tag)
        end

        tip:AddDoubleLine("GoldFinder Typical:", typStr, 1, 0.82, 0, 1, 1, 1)
        tip:AddDoubleLine("GoldFinder Lowest:", ("%s (%s)"):format(ns.Money(latest.min), ageStr), 1, 0.82, 0, 0.7, 0.7, 0.7)
    end

    if hasCost then
        tip:AddDoubleLine("GoldFinder Cost Basis:", ("%s (%dx bought)"):format(ns.Money(cost.avgUnitCost), cost.totalQty), 1, 0.82, 0, 1, 1, 1)
        if typical and typical > 0 then
            local netTypical = math.floor(typical * 0.95)
            local margin = netTypical - cost.avgUnitCost
            local roi = (cost.avgUnitCost > 0) and ((margin / cost.avgUnitCost) * 100) or 0
            local marginColor = margin >= 0 and "|cff40ff40" or "|cffff4040"
            tip:AddDoubleLine("Unrealized Margin:", ("%s%+s (%.0f%%)|r"):format(marginColor, ns.Money(margin), roi), 1, 0.82, 0, 1, 1, 1)
        end
    end

    -- Fixed vendor reagent integration (#46)
    vInfo = ns.GetVendorReagent and ns.GetVendorReagent(itemID)
    if vInfo then
        tip:AddDoubleLine("GoldFinder Vendor Price:", ns.Money(vInfo.vendorPrice), 1, 0.82, 0, 0.25, 1, 0.25)
        local curPrice = (rec and rec.history and #rec.history > 0 and rec.history[#rec.history].min) or typical
        if curPrice and curPrice > vInfo.vendorPrice then
            local markup = math.floor(((curPrice - vInfo.vendorPrice) / vInfo.vendorPrice) * 100 + 0.5)
            tip:AddLine(("|cffff4040[OVERPRICED: Buy from NPC for %s (+%d%% AH markup)]|r"):format(ns.Money(vInfo.vendorPrice), markup), 1, 0.25, 0.25, true)
        end
    end

    -- Inventory restock safety target (#45)
    restockTarget = ns.GetRestockLevel and ns.GetRestockLevel(itemID)
    if restockTarget and restockTarget > 0 then
        local currentStock = (C_Item and C_Item.GetItemCount and C_Item.GetItemCount(itemID, true)) or (GetItemCount and GetItemCount(itemID, true) or 0)
        local isLow = currentStock < restockTarget
        local color = isLow and "|cffff4040" or "|cff40ff40"
        local statusTag = isLow and (" (Shortage: %d)"):format(restockTarget - currentStock) or " (Healthy)"
        tip:AddDoubleLine("GoldFinder Safety Stock:", ("%s%d / %d target%s|r"):format(color, currentStock, restockTarget, statusTag), 1, 0.82, 0, 1, 1, 1)
    end

    -- Disenchant Expected Value (Theme 1 - v2.0)
    if deNet and deNet > 0 then
        local latestAH = (hasHistory and rec.history[#rec.history].min) or nil
        if latestAH and latestAH > 0 and deNet > latestAH then
            local deProfit = deNet - latestAH
            tip:AddDoubleLine("GoldFinder Disenchant EV:", ("%s |cff40ff40(+%s DE flip)|r"):format(ns.Money(deNet), ns.Money(deProfit)), 1, 0.82, 0, 1, 1, 1)
        else
            tip:AddDoubleLine("GoldFinder Disenchant EV:", ("%s (net after 5%% cut)"):format(ns.Money(deNet)), 1, 0.82, 0, 0.7, 0.85, 1)
        end
    end

    -- Mailbox expired auction relist advisor (#43)
    if advice then
        tip:AddLine(" ")
        tip:AddDoubleLine("GoldFinder Relist Advisor:", advice.tag, 1, 0.82, 0, advice.r, advice.g, advice.b)
        tip:AddLine(advice.reason, 0.85, 0.85, 0.85, true)
    end

    -- Multi-Alt Realm Inventory Hub (Theme 2 - v2.0, #63)
    if altTotal and altTotal > 0 and altRows and #altRows > 0 then
        tip:AddDoubleLine("GoldFinder Realm Inventory:", ("%d total across %d character(s)"):format(altTotal, #altRows), 1, 0.82, 0, 0.4, 0.8, 1)
        for i = 1, math.min(4, #altRows) do
            local r = altRows[i]
            tip:AddDoubleLine("  " .. r.charName, ("%d (Bag:%d Bank:%d Mail:%d)"):format(r.total, r.bags, r.bank, r.mail), 0.75, 0.75, 0.75, 0.9, 0.9, 0.9)
        end
    end
end

local function OnTooltipSetItem(tip)
    local _, link = tip:GetItem()
    if not link then return end
    local itemID = tonumber(link:match("item:(%d+)"))
    if itemID then
        AddPriceLines(tip, itemID)
    end
end

-- Hook tooltips safely across modern TooltipDataProcessor and classic hooks
if TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall and Enum.TooltipDataType and Enum.TooltipDataType.Item then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function(tip, data)
        if tip == GameTooltip or tip == ItemRefTooltip then
            local itemID = data and data.id
            if itemID then
                AddPriceLines(tip, itemID)
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
