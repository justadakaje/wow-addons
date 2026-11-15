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

    -- 1. Check GoldFinderDB for deep historical pricing
    if GoldFinderDB and GoldFinderDB.items then
        local rec = GoldFinderDB.items[itemID]
        local h = rec and rec.history
        if h and #h > 0 then
            local prices = {}
            for i = 1, #h do prices[i] = h[i].min end
            table.sort(prices)
            local median = prices[math.ceil(#prices / 2)]
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
        end
        return "|cff888888No scan history|r"
    end

    -- 2. Fallback to BiSGearFinder's own live AH cache
    local cache = ns.GetCachedItemMarket and ns.GetCachedItemMarket(itemID)
    if cache then
        if cache.lowest and cache.lowest > 0 then
            local qtyStr = (cache.count and cache.count == 1) and " |cffff9900(1 left on realm)|r" or ""
            return FormatMoney(cache.lowest) .. qtyStr
        elseif cache.isScarce or (cache.count and cache.count == 0) then
            return "|cffff4040[UNLISTED]|r (Zero active realm listings)"
        end
    end

    return nil
end

function ns.IsMarketBridgeActive()
    return (GoldFinderDB and GoldFinderDB.items) ~= nil
end
