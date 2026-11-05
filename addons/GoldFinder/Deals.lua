-- GoldFinder -- Deals
-- Which materials are listed well below their typical price right now.
--
--   typical = median of an item's EARLIER lowest prices (the current one
--             excluded, so a deal cannot drag its own baseline down)
--   deal    = current lowest <= DEAL_RATIO * typical
--
-- Median, not mean: one troll listing at 1c or 999g moves a mean a long way
-- and a median barely at all. Pure computation over GoldFinderDB -- no game
-- API calls here except GetServerTime.

local ADDON, ns = ...

local FRESH_SECONDS = 1800  -- a price older than this is not "right now"

local function Median(values)
    local t = {}
    for i = 1, #values do t[i] = values[i] end
    table.sort(t)
    local n = #t
    if n % 2 == 1 then return t[(n + 1) / 2] end
    return (t[n / 2] + t[n / 2 + 1]) / 2
end

-- Evaluates whether an item's prices have been trending up, steady, or down
-- over its historical scans (detects falling knives).
local function CalculateTrend(history)
    if not history or #history < 4 then return nil end
    local count = #history - 1  -- exclude candidate deal
    local mid = math.floor(count / 2)
    if mid < 1 then return nil end

    local older, newer = {}, {}
    for i = 1, mid do older[i] = history[i].min end
    for i = mid + 1, count do newer[#newer + 1] = history[i].min end

    local olderMed = Median(older)
    local newerMed = Median(newer)
    if olderMed <= 0 then return nil end

    local pctChange = (newerMed - olderMed) / olderMed
    if pctChange <= -0.10 then
        return {
            direction = "falling",
            pct = math.floor(math.abs(pctChange) * 100 + 0.5),
            label = ("Falling (-%d%%)"):format(math.floor(math.abs(pctChange) * 100 + 0.5)),
            warning = "Caution: typical price has dropped over recent scans (falling market).",
            r = 1, g = 0.35, b = 0.35,
        }
    elseif pctChange >= 0.10 then
        return {
            direction = "rising",
            pct = math.floor(pctChange * 100 + 0.5),
            label = ("Rising (+%d%%)"):format(math.floor(pctChange * 100 + 0.5)),
            warning = nil,
            r = 0.35, g = 1, b = 0.35,
        }
    else
        return {
            direction = "steady",
            pct = 0,
            label = "Steady",
            warning = nil,
            r = 0.8, g = 0.8, b = 0.8,
        }
    end
end

-- Returns deals (sorted by active sort setting) and a status table that
-- explains everything that was not a deal, so the panel can say why.
-- Classifies a deal into visual rarity tiers based on discount depth and profit magnitude.
function ns.GetDealTier(deal)
    if not deal then return nil end
    local below = deal.below or 0
    local profit = deal.totalNetProfit or 0

    -- Mega Snipe: >= 50% discount OR >= 50 gold (500,000 copper) net profit
    if below >= 0.50 or profit >= 500000 then
        return {
            id = "mega",
            label = "Mega Snipe",
            tag = "[SNIPE]",
            hex = "ffa335ee",
            colorStr = "|cffa335ee",
            r = 0.64, g = 0.21, b = 0.93,
            bgAlpha = 0.12,
        }
    -- Great Deal: >= 35% discount OR >= 15 gold (150,000 copper) net profit
    elseif below >= 0.35 or profit >= 150000 then
        return {
            id = "great",
            label = "Great Deal",
            tag = "[GREAT]",
            hex = "0070dd",
            colorStr = "|cff0070dd",
            r = 0.0, g = 0.44, b = 0.87,
            bgAlpha = 0.07,
        }
    -- Good Flip: Standard qualifying deal
    else
        return {
            id = "good",
            label = "Good Flip",
            tag = "",
            hex = "1eff00",
            colorStr = "|cff1eff00",
            r = 0.12, g = 1.0, b = 0.0,
            bgAlpha = 0.0,
        }
    end
end

function ns.FindDeals()
    local status = { items = 0, judged = 0, needMore = 0, stale = 0, fewestMissing = nil }
    local deals = {}
    local db = ns.db
    if not db then return deals, status end
    local now = GetServerTime()

    local ratio = ns.GetDealRatio()
    local minPrior = ns.GetMinPrior()
    local sortBy = ns.GetSortBy()
    local minProfit = ns.GetMinProfit()

    for itemID, rec in pairs(db.items) do
        local h = rec.history
        local n = h and #h or 0
        if n > 0 then
            status.items = status.items + 1
            local current = h[n]
            if now - (current.seen or current.t) > FRESH_SECONDS then
                status.stale = status.stale + 1
            elseif n - 1 < minPrior then
                status.needMore = status.needMore + 1
                local missing = minPrior - (n - 1)
                if not status.fewestMissing or missing < status.fewestMissing then
                    status.fewestMissing = missing
                end
            else
                status.judged = status.judged + 1
                local prior = {}
                for i = 1, n - 1 do prior[i] = h[i].min end
                local typical = Median(prior)
                if typical > 0 and current.min <= ratio * typical then
                    -- Net flip profit: after deducting Blizzard's 5% AH cut
                    local netUnit = math.floor(typical * 0.95 - current.min)
                    local totalNet = math.max(0, math.floor(netUnit * (current.qty or 1)))
                    if totalNet >= minProfit then
                        deals[#deals + 1] = {
                        itemID         = itemID,
                        itemKey        = rec.itemKey,  -- nil for items not seen since v0.0.6
                        name           = rec.name,
                        now            = current.min,
                        typical        = typical,
                        below          = 1 - current.min / typical,
                        qty            = current.qty or 0,
                        netUnitProfit  = netUnit,
                        totalNetProfit = totalNet,
                        trend          = CalculateTrend(h),
                        history        = h,
                        category       = ns.GetItemCategory and ns.GetItemCategory(itemID) or "other",
                        isWatched      = ns.IsWatched and ns.IsWatched(itemID) or false,
                    }
                    deals[#deals].tier = ns.GetDealTier(deals[#deals])
                    end
                end
            end
        end
    end

    if sortBy == "profit" then
        table.sort(deals, function(a, b)
            if a.totalNetProfit ~= b.totalNetProfit then
                return a.totalNetProfit > b.totalNetProfit
            end
            return a.below > b.below
        end)
    else
        table.sort(deals, function(a, b)
            if a.below ~= b.below then
                return a.below > b.below
            end
            return a.totalNetProfit > b.totalNetProfit
        end)
    end
    return deals, status
end

local function Plural(n, one, many) return n == 1 and one or many end

-- A title and one sentence for the panel: what the player sees first.
function ns.DealStatus(deals, status)
    local ratio = ns.GetDealRatio()
    local pct = math.floor((1 - ratio) * 100 + 0.5)
    local sortBy = ns.GetSortBy()
    local sortDesc = (sortBy == "profit") and "by estimated net profit" or "by discount"

    if status.items == 0 then
        return "No prices recorded yet",
            "Run a Full Scan at the auction house. GoldFinder records the results automatically."
    end
    if #deals > 0 then
        return ("%d underpriced %s (%s)"):format(#deals, Plural(#deals, "material", "materials"), sortDesc),
            ("Listed at least %d%% below typical price."):format(pct)
    end
    if status.judged > 0 then
        return "No underpriced materials right now",
            ("%d %s checked. None is %d%% or more below its typical price."):format(
                status.judged, Plural(status.judged, "material", "materials"), pct)
    end
    if status.needMore > 0 then
        return "Building price history",
            ("%d materials tracked. Deals can show after %d more Full %s, at least 10 minutes apart."):format(
                status.items, status.fewestMissing, Plural(status.fewestMissing, "Scan", "Scans"))
    end
    return "No recent prices",
        "Run a Full Scan to check what is listed now."
end

-- Detail rows for the tooltip, same shape as ns.ScanStatus().lines.
function ns.DealDetails(status)
    local ratio = ns.GetDealRatio()
    local pct = math.floor((1 - ratio) * 100 + 0.5)
    local sortBy = (ns.GetSortBy() == "profit") and "Est. Net Profit" or "Discount %"
    local minProfit = ns.GetMinProfit()
    local minProfitStr = (minProfit > 0) and ns.Money(minProfit) or "None (0c)"
    return {
        { "Threshold", ("%d%% below typical"):format(pct) },
        { "Category", (ns.GetActiveCategory and ns.GetActiveCategory() or "all"):upper() },
        { "Watchlist", ("%d item(s)"):format(ns.GetWatchlistCount and ns.GetWatchlistCount() or 0) },
        { "Min profit", minProfitStr },
        { "Min scans", tostring(ns.GetMinPrior()) },
        { "Sorted by", sortBy },
        { "Tracked", tostring(status.items) },
        { "Judged", tostring(status.judged) },
        { "Need more history", tostring(status.needMore) },
        { "Not seen in " .. FRESH_SECONDS / 60 .. " min", tostring(status.stale) },
    }
end
