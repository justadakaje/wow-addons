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

ns.DEAL_RATIO    = 0.70  -- 30% or more below typical
ns.MIN_PRIOR     = 3     -- earlier data points required before judging
local FRESH_SECONDS = 1800  -- a price older than this is not "right now"

local function Median(values)
    local t = {}
    for i = 1, #values do t[i] = values[i] end
    table.sort(t)
    local n = #t
    if n % 2 == 1 then return t[(n + 1) / 2] end
    return (t[n / 2] + t[n / 2 + 1]) / 2
end

-- Returns deals (sorted, deepest discount first) and a status table that
-- explains everything that was not a deal, so the panel can say why.
function ns.FindDeals()
    local status = { items = 0, judged = 0, needMore = 0, stale = 0, fewestMissing = nil }
    local deals = {}
    local db = ns.db
    if not db then return deals, status end
    local now = GetServerTime()

    for itemID, rec in pairs(db.items) do
        local h = rec.history
        local n = h and #h or 0
        if n > 0 then
            status.items = status.items + 1
            local current = h[n]
            if now - current.t > FRESH_SECONDS then
                status.stale = status.stale + 1
            elseif n - 1 < ns.MIN_PRIOR then
                status.needMore = status.needMore + 1
                local missing = ns.MIN_PRIOR - (n - 1)
                if not status.fewestMissing or missing < status.fewestMissing then
                    status.fewestMissing = missing
                end
            else
                status.judged = status.judged + 1
                local prior = {}
                for i = 1, n - 1 do prior[i] = h[i].min end
                local typical = Median(prior)
                if typical > 0 and current.min <= ns.DEAL_RATIO * typical then
                    deals[#deals + 1] = {
                        itemID  = itemID,
                        name    = rec.name,
                        now     = current.min,
                        typical = typical,
                        below   = 1 - current.min / typical,
                        qty     = current.qty,
                    }
                end
            end
        end
    end

    table.sort(deals, function(a, b) return a.below > b.below end)
    return deals, status
end

local function Plural(n, one, many) return n == 1 and one or many end

-- A title and one sentence for the panel: what the player sees first.
function ns.DealStatus(deals, status)
    local pct = math.floor((1 - ns.DEAL_RATIO) * 100 + 0.5)
    if status.items == 0 then
        return "No prices recorded yet",
            "Run a Full Scan at the auction house. GoldFind records the results automatically."
    end
    if #deals > 0 then
        return ("%d underpriced %s"):format(#deals, Plural(#deals, "material", "materials")),
            ("Listed at least %d%% below their typical price."):format(pct)
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
    return {
        { "Tracked", tostring(status.items) },
        { "Judged", tostring(status.judged) },
        { "Need more history", tostring(status.needMore) },
        { "Not seen in " .. FRESH_SECONDS / 60 .. " min", tostring(status.stale) },
    }
end
