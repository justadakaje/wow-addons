-- BiSGearFinder -- Bridge
-- Optional market intelligence bridge between BiSGearFinder and GoldFinder.
-- Pulls historical typical prices, current lowest buyouts, and scarcity data
-- from GoldFinderDB without running duplicate full scans.

local ADDON, ns = ...

local function FormatMoney(copper)
    if not copper or copper <= 0 then return "0c" end
    copper = math.floor(copper)
    local g = math.floor(copper / 10000)
    local s = math.floor((copper % 10000) / 100)
    local c = copper % 100

    if g > 0 then
        return ("|cffffd100%dg|r |cffe6e6e6%ds|r |cffc87d3e%dc|r"):format(g, s, c)
    elseif s > 0 then
        return ("|cffe6e6e6%ds|r |cffc87d3e%dc|r"):format(s, c)
    else
        return ("|cffc87d3e%dc|r"):format(c)
    end
end

function ns.GetMarketSummary(itemID)
    if not itemID then return nil end
    if not (GoldFinderDB and GoldFinderDB.items) then return nil end

    local rec = GoldFinderDB.items[itemID]
    if not rec then
        return "|cff888888No scan history|r"
    end

    local h = rec.history
    if not h or #h == 0 then
        return "|cff888888No scan history|r"
    end

    -- Compute historical median
    local prices = {}
    for i = 1, #h do prices[i] = h[i].min end
    table.sort(prices)
    local median = prices[math.ceil(#prices / 2)]

    -- Check latest listing
    local latest = h[#h]
    local nowPrice = (latest and latest.min) or 0

    if nowPrice > 0 and median and median > 0 then
        local ratio = nowPrice / median
        if ratio <= 0.70 then
            local discount = math.floor((1 - ratio) * 100 + 0.5)
            return ("%s (|cff40ff40%d%% below typical|r)"):format(FormatMoney(nowPrice), discount)
        elseif ratio >= 1.30 then
            return ("%s (|cffff9900Premium: typical %s|r)"):format(FormatMoney(nowPrice), FormatMoney(median))
        else
            return ("%s (Typical: %s)"):format(FormatMoney(nowPrice), FormatMoney(median))
        end
    elseif median and median > 0 then
        return ("Typical: %s"):format(FormatMoney(median))
    end

    return nil
end

function ns.IsMarketBridgeActive()
    return (GoldFinderDB and GoldFinderDB.items) ~= nil
end
