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
    if not db or not db.items then return end

    local rec = db.items[itemID]
    if not rec or not rec.history or #rec.history == 0 then return end

    local h = rec.history
    local prior = {}
    for i = 1, #h do prior[i] = h[i].min end

    local typical = Median(prior)
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

    tip:AddLine(" ")
    tip:AddDoubleLine("GoldFinder Typical:", ns.Money(typical), 1, 0.82, 0, 1, 1, 1)
    tip:AddDoubleLine("GoldFinder Lowest:", ("%s (%s)"):format(ns.Money(latest.min), ageStr), 1, 0.82, 0, 0.7, 0.7, 0.7)
    tip:Show()
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
