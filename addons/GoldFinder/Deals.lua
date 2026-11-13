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

local L = ns.L or setmetatable({}, { __index = function(_, k) return k end })
local FRESH_SECONDS = 1800  -- a price older than this is not "right now"

-- Statistical valuation baselines (#38)
local function Median(values)
    if not values or #values == 0 then return nil end
    local t = {}
    for i = 1, #values do t[i] = values[i] end
    table.sort(t)
    local n = #t
    if n == 1 then return t[1] end
    if n % 2 == 1 then return t[(n + 1) / 2] end
    return math.floor(((t[n / 2] + t[n / 2 + 1]) / 2) + 0.5)
end
ns.CalculateMedian = Median

-- Trimmed Mean: discards top and bottom outlier listings (default 10% trim each side)
-- and averages the remainder.
local function TrimmedMean(values, trimPct)
    if not values or #values == 0 then return nil end
    local n = #values
    if n <= 2 then return Median(values) end

    local t = {}
    for i = 1, n do t[i] = values[i] end
    table.sort(t)

    trimPct = trimPct or 0.10
    local trimCount = math.floor(n * trimPct)
    if n >= 5 and trimCount < 1 then
        trimCount = 1
    end

    if trimCount >= 1 and (2 * trimCount) < n then
        local sum = 0
        local count = 0
        for i = 1 + trimCount, n - trimCount do
            sum = sum + t[i]
            count = count + 1
        end
        if count > 0 then
            return math.floor((sum / count) + 0.5)
        end
    end

    local sum = 0
    for i = 1, n do sum = sum + t[i] end
    return math.floor((sum / n) + 0.5)
end
ns.CalculateTrimmedMean = TrimmedMean

-- 7-Day Exponential Moving Average (EMA):
-- Applies exponential weighting to chronological scans, weighting recent market
-- movements higher. Multiplier alpha = 2 / (period + 1), defaulting to 7-period (alpha = 0.25).
local function CalculateEMA(values, period)
    if not values or #values == 0 then return nil end
    local n = #values
    if n == 1 then return values[1] end

    period = period or 7
    local effectivePeriod = math.min(period, n)
    local alpha = 2 / (effectivePeriod + 1)

    local ema = values[1]
    for i = 2, n do
        ema = (values[i] * alpha) + (ema * (1 - alpha))
    end
    return math.floor(ema + 0.5)
end
ns.CalculateEMA = CalculateEMA

-- Unified baseline calculation dispatcher (#38)
function ns.CalculateBaseline(values, model)
    if not values or #values == 0 then return nil end
    model = model or (ns.GetValuationModel and ns.GetValuationModel()) or "median"

    if model == "trimmed" then
        return TrimmedMean(values, 0.10)
    elseif model == "ema" then
        return CalculateEMA(values, 7)
    else
        return Median(values)
    end
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
ns.CalculateTrend = CalculateTrend

function ns.GetConfidenceScore(history)
    if not history or #history == 0 then
        return {
            level    = "speculative",
            label    = "Speculative",
            score    = 1,
            tag      = "[THIN]",
            colorStr = "|cffff6644",
            r = 1.0, g = 0.40, b = 0.27,
            reason   = "No historical scans recorded yet.",
        }
    end

    local N = #history
    local first = history[1].seen or history[1].t or 0
    local last = history[N].seen or history[N].t or 0
    local timeSpan = math.max(0, last - first)

    local sum = 0
    for i = 1, N do sum = sum + (history[i].min or 0) end
    local mean = sum / N

    local varianceSum = 0
    for i = 1, N do
        local diff = (history[i].min or 0) - mean
        varianceSum = varianceSum + (diff * diff)
    end
    local stdDev = math.sqrt(varianceSum / N)
    local cv = (mean > 0) and (stdDev / mean) or 0

    if N >= 12 and timeSpan >= 86400 and cv <= 0.45 then
        local days = timeSpan / 86400
        return {
            level    = "high",
            label    = "High Confidence",
            score    = 3,
            tag      = "[HIGH]",
            colorStr = "|cff40ff40",
            r = 0.25, g = 1.0, b = 0.25,
            reason   = ("High depth: %d scans across %.1f days (low variance)."):format(N, days),
        }
    elseif N >= 5 and timeSpan >= 21600 and cv <= 0.75 then
        local hours = timeSpan / 3600
        return {
            level    = "moderate",
            label    = "Moderate Confidence",
            score    = 2,
            tag      = "[MED]",
            colorStr = "|cffffd100",
            r = 1.0, g = 0.82, b = 0.0,
            reason   = ("Moderate depth: %d scans across %.1f hours."):format(N, hours),
        }
    else
        local reason
        if N < 5 then
            reason = ("Thin market: only %d scan(s) recorded."):format(N)
        else
            reason = ("High volatility (CV: %.0f%%): wide price swings."):format(cv * 100)
        end
        return {
            level    = "speculative",
            label    = "Speculative / Thin",
            score    = 1,
            tag      = "[THIN]",
            colorStr = "|cffff6644",
            r = 1.0, g = 0.40, b = 0.27,
            reason   = reason,
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
    local snipeThresh = ns.GetSnipeThreshold and ns.GetSnipeThreshold() or 1000000

    -- Mega Snipe: >= 70% discount OR >= snipeThresh net profit OR (>= 50% and >= 50g)
    if below >= 0.70 or profit >= snipeThresh or (below >= 0.50 and profit >= 500000) then
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

-- CLASSIC CRAFTING CONVERSIONS (Arbitrage)
-- All item IDs verified against WoW database records (QuestieDB / Wowhead Classic):
-- Metals: Copper Ore 2770, Copper Bar 2840, Tin Ore 2772, Tin Bar 3576, Silver Ore 2775, Silver Bar 2842,
--         Bronze Bar 2841, Iron Ore 3858, Iron Bar 3575, Steel Bar 3859, Coal 3857,
--         Gold Ore 2776, Gold Bar 3577, Mithril Ore 3858, Mithril Bar 3860,
--         Truesilver Ore 7911, Truesilver Bar 6037, Thorium Ore 10620, Thorium Bar 12359,
--         Dark Iron Ore 11370, Dark Iron Bar 11371, Arcane Crystal 12363, Arcanite Bar 12360.
-- Cloth:  Linen Cloth 2589, Bolt of Linen 2996, Wool Cloth 2592, Bolt of Wool 2997,
--         Silk Cloth 4306, Bolt of Silk 4305, Mageweave Cloth 4338, Bolt of Mageweave 4339,
--         Runecloth 14047, Bolt of Runecloth 14048.
ns.CONVERSIONS = {
    -- Smelting
    { name = "Smelt Copper",       category = "mining", output = { itemID = 2840, qty = 1 }, reagents = { { itemID = 2770, qty = 1 } } },
    { name = "Smelt Tin",          category = "mining", output = { itemID = 3576, qty = 1 }, reagents = { { itemID = 2772, qty = 1 } } },
    { name = "Smelt Silver",       category = "mining", output = { itemID = 2842, qty = 1 }, reagents = { { itemID = 2775, qty = 1 } } },
    { name = "Smelt Bronze",       category = "mining", output = { itemID = 2841, qty = 2 }, reagents = { { itemID = 2840, qty = 1 }, { itemID = 3576, qty = 1 } } },
    { name = "Smelt Iron",         category = "mining", output = { itemID = 3575, qty = 1 }, reagents = { { itemID = 3858, qty = 1 } } },
    { name = "Smelt Steel",        category = "mining", output = { itemID = 3859, qty = 1 }, reagents = { { itemID = 3575, qty = 1 }, { itemID = 3857, qty = 1, fixedPrice = 500 } } },
    { name = "Smelt Gold",         category = "mining", output = { itemID = 3577, qty = 1 }, reagents = { { itemID = 2776, qty = 1 } } },
    { name = "Smelt Mithril",      category = "mining", output = { itemID = 3860, qty = 1 }, reagents = { { itemID = 3858, qty = 1 } } },
    { name = "Smelt Truesilver",   category = "mining", output = { itemID = 6037, qty = 1 }, reagents = { { itemID = 7911, qty = 1 } } },
    { name = "Smelt Thorium",      category = "mining", output = { itemID = 12359, qty = 1 }, reagents = { { itemID = 10620, qty = 1 } } },
    { name = "Smelt Dark Iron",    category = "mining", output = { itemID = 11371, qty = 1 }, reagents = { { itemID = 11370, qty = 8 } } },

    -- Alchemy Transmutes
    { name = "Transmute Arcanite", category = "other",  output = { itemID = 12360, qty = 1 }, reagents = { { itemID = 12363, qty = 1 }, { itemID = 12359, qty = 1 } } },

    -- Tailoring Bolts
    { name = "Bolt of Linen",      category = "cloth",  output = { itemID = 2996, qty = 1 }, reagents = { { itemID = 2589, qty = 2 } } },
    { name = "Bolt of Woolen",     category = "cloth",  output = { itemID = 2997, qty = 1 }, reagents = { { itemID = 2592, qty = 3 } } },
    { name = "Bolt of Silk",       category = "cloth",  output = { itemID = 4305, qty = 1 }, reagents = { { itemID = 4306, qty = 4 } } },
    { name = "Bolt of Mageweave",  category = "cloth",  output = { itemID = 4339, qty = 1 }, reagents = { { itemID = 4338, qty = 4 } } },
    { name = "Bolt of Runecloth",  category = "cloth",  output = { itemID = 14048, qty = 1 }, reagents = { { itemID = 14047, qty = 5 } } },

    -- Leatherworking Upgrades & Cured Hides
    { name = "Craft Medium Leather", category = "leather", output = { itemID = 2319, qty = 1 },  reagents = { { itemID = 2318, qty = 4 } } },
    { name = "Craft Heavy Leather",  category = "leather", output = { itemID = 4234, qty = 1 },  reagents = { { itemID = 2319, qty = 5 } } },
    { name = "Craft Thick Leather",  category = "leather", output = { itemID = 4304, qty = 1 },  reagents = { { itemID = 4234, qty = 5 } } },
    { name = "Craft Rugged Leather", category = "leather", output = { itemID = 8170, qty = 1 },  reagents = { { itemID = 4304, qty = 6 } } },
    { name = "Cure Light Hide",      category = "leather", output = { itemID = 4231, qty = 1 },  reagents = { { itemID = 783, qty = 1 },  { itemID = 2888, qty = 1 } } },
    { name = "Cure Medium Hide",     category = "leather", output = { itemID = 4233, qty = 1 },  reagents = { { itemID = 4232, qty = 1 }, { itemID = 2888, qty = 1 } } },
    { name = "Cure Heavy Hide",      category = "leather", output = { itemID = 4236, qty = 1 },  reagents = { { itemID = 4235, qty = 1 }, { itemID = 2888, qty = 3 } } },
    { name = "Cure Thick Hide",      category = "leather", output = { itemID = 8172, qty = 1 },  reagents = { { itemID = 8169, qty = 1 }, { itemID = 7071, qty = 1 } } },
    { name = "Cure Rugged Hide",     category = "leather", output = { itemID = 15407, qty = 1 }, reagents = { { itemID = 8171, qty = 1 }, { itemID = 15409, qty = 1 } } },

    -- Alchemy Elemental Transmutes
    { name = "Transmute Earth to Water",  category = "other", output = { itemID = 7080, qty = 1 }, reagents = { { itemID = 7076, qty = 1 } } },
    { name = "Transmute Water to Air",    category = "other", output = { itemID = 7082, qty = 1 }, reagents = { { itemID = 7080, qty = 1 } } },
    { name = "Transmute Undeath to Water",category = "other", output = { itemID = 7080, qty = 1 }, reagents = { { itemID = 12808, qty = 1 } } },
    { name = "Transmute Life to Earth",   category = "other", output = { itemID = 7076, qty = 1 }, reagents = { { itemID = 12803, qty = 1 } } },
    { name = "Transmute Elemental Fire",  category = "other", output = { itemID = 7068, qty = 3 }, reagents = { { itemID = 7077, qty = 1 } } },

    -- Enchanting Essence Upgrades (3 Lesser -> 1 Greater)
    { name = "Greater Magic Essence",   category = "other", output = { itemID = 10939, qty = 1 }, reagents = { { itemID = 10938, qty = 3 } } },
    { name = "Greater Astral Essence",  category = "other", output = { itemID = 11082, qty = 1 }, reagents = { { itemID = 10998, qty = 3 } } },
    { name = "Greater Mystic Essence",  category = "other", output = { itemID = 11135, qty = 1 }, reagents = { { itemID = 11134, qty = 3 } } },
    { name = "Greater Nether Essence",  category = "other", output = { itemID = 11175, qty = 1 }, reagents = { { itemID = 11174, qty = 3 } } },
    { name = "Greater Eternal Essence", category = "other", output = { itemID = 16203, qty = 1 }, reagents = { { itemID = 16202, qty = 3 } } },
}

---------------------------------------------------------------------------
-- Disenchant Expected Value Engine (Theme 1 - GoldFinder v2.0)
-- Verified Classic item IDs cross-checked against QuestieDB_Vanilla.toc.

local DE_BRACKETS = {
    { minLvl = 5,  maxLvl = 15, dust = { id = 10940, avgQty = 1.5 }, essence = { id = 10938, avgQty = 1.5 }, shard = nil },
    { minLvl = 16, maxLvl = 20, dust = { id = 10940, avgQty = 2.5 }, essence = { id = 10939, avgQty = 1.5 }, shard = { id = 10978, avgQty = 1.0 } },
    { minLvl = 21, maxLvl = 25, dust = { id = 10940, avgQty = 4.0 }, essence = { id = 10998, avgQty = 1.5 }, shard = { id = 10978, avgQty = 1.0 } },
    { minLvl = 26, maxLvl = 30, dust = { id = 11083, avgQty = 1.5 }, essence = { id = 11082, avgQty = 1.5 }, shard = { id = 11084, avgQty = 1.0 } },
    { minLvl = 31, maxLvl = 35, dust = { id = 11083, avgQty = 3.5 }, essence = { id = 11134, avgQty = 1.5 }, shard = { id = 11138, avgQty = 1.0 } },
    { minLvl = 36, maxLvl = 40, dust = { id = 11137, avgQty = 1.5 }, essence = { id = 11135, avgQty = 1.5 }, shard = { id = 11139, avgQty = 1.0 } },
    { minLvl = 41, maxLvl = 45, dust = { id = 11137, avgQty = 3.5 }, essence = { id = 11174, avgQty = 1.5 }, shard = { id = 11177, avgQty = 1.0 } },
    { minLvl = 46, maxLvl = 50, dust = { id = 11176, avgQty = 1.5 }, essence = { id = 11175, avgQty = 1.5 }, shard = { id = 11178, avgQty = 1.0 } },
    { minLvl = 51, maxLvl = 55, dust = { id = 11176, avgQty = 3.5 }, essence = { id = 16202, avgQty = 1.5 }, shard = { id = 14343, avgQty = 1.0 } },
    { minLvl = 56, maxLvl = 65, dust = { id = 16204, avgQty = 2.0 }, essence = { id = 16203, avgQty = 1.5 }, shard = { id = 14344, avgQty = 1.0 } },
}

local function GetItemInfoCompat(itemID)
    if C_Item and C_Item.GetItemInfo then
        local name, link, quality, iLevel, _, _, _, _, _, _, _, classID = C_Item.GetItemInfo(itemID)
        if name then return name, link, quality, iLevel, classID end
    end
    if GetItemInfo then
        local name, link, quality, iLevel, _, _, _, _, _, _, _, classID = GetItemInfo(itemID)
        if name then return name, link, quality, iLevel, classID end
    end
    return nil
end

function ns.GetDisenchantValue(itemID)
    if not itemID then return nil, "No item ID provided." end
    local _, _, quality, iLevel, classID = GetItemInfoCompat(itemID)
    if not classID and C_Item and C_Item.GetItemInfoInstant then
        classID = select(6, C_Item.GetItemInfoInstant(itemID))
    end

    if quality ~= 2 then
        return nil, "Only Uncommon (green) gear can be estimated cleanly."
    end
    if classID ~= 2 and classID ~= 4 then
        return nil, "Only armor and weapons can be disenchanted."
    end
    if not iLevel or iLevel < 5 then
        return nil, "Item level too low to disenchant."
    end

    local bracket = nil
    for _, b in ipairs(DE_BRACKETS) do
        if iLevel >= b.minLvl and iLevel <= b.maxLvl then
            bracket = b
            break
        end
    end
    if not bracket and iLevel > 65 then
        bracket = DE_BRACKETS[#DE_BRACKETS]
    end
    if not bracket then
        return nil, "No disenchant table matches this item level."
    end

    local isWeapon = (classID == 2)
    local wDust    = isWeapon and 0.20 or 0.75
    local wEssence = isWeapon and 0.75 or 0.20
    local wShard   = bracket.shard and 0.05 or 0.0

    local ev = 0
    local knownMaterials = 0
    local breakdown = {}

    local function AddComponent(entry, weight)
        if not entry or weight <= 0 then return end
        local unitPrice = (ns.GetItemTypicalPrice and ns.GetItemTypicalPrice(entry.id))
            or (ns.GetItemCurrentPrice and ns.GetItemCurrentPrice(entry.id))
        if unitPrice and unitPrice > 0 then
            knownMaterials = knownMaterials + 1
            local contribution = unitPrice * entry.avgQty * weight
            ev = ev + contribution
            breakdown[#breakdown + 1] = {
                itemID = entry.id,
                chance = weight,
                avgQty = entry.avgQty,
                unitPrice = unitPrice,
                contribution = contribution,
            }
        end
    end

    AddComponent(bracket.dust, wDust)
    AddComponent(bracket.essence, wEssence)
    AddComponent(bracket.shard, wShard)

    if knownMaterials == 0 or ev <= 0 then
        return nil, "Insufficient enchanting material price history to estimate disenchant value."
    end

    local expectedGross = math.floor(ev + 0.5)
    local expectedNet = math.floor(expectedGross * 0.95)
    return expectedNet, nil, {
        expectedGross = expectedGross,
        expectedNet = expectedNet,
        breakdown = breakdown,
        iLevel = iLevel,
        isWeapon = isWeapon,
    }
end

function ns.GetItemTypicalPrice(itemID)
    local db = ns.db
    if not db or not db.items or not db.items[itemID] then return nil end
    local h = db.items[itemID].history
    if not h or #h == 0 then return nil end
    if #h == 1 then return h[1].min end
    local prior = {}
    for i = 1, #h - 1 do prior[i] = h[i].min end
    return ns.CalculateBaseline(prior)
end

function ns.GetItemCurrentPrice(itemID)
    local db = ns.db
    if not db or not db.items or not db.items[itemID] then return nil end
    local h = db.items[itemID].history
    if not h or #h == 0 then return nil end
    local now = GetServerTime()
    local cur = h[#h]
    if now - (cur.seen or cur.t) <= FRESH_SECONDS then
        return cur.min
    end
    return ns.GetItemTypicalPrice(itemID)
end

function ns.FindConversionDeals()
    local deals = {}
    local minProfit = ns.GetMinProfit()

    for _, conv in ipairs(ns.CONVERSIONS) do
        if not (ns.IsBlacklisted and ns.IsBlacklisted(conv.output.itemID)) then
            local outTypical = ns.GetItemTypicalPrice(conv.output.itemID)
            local outCurrent = ns.GetItemCurrentPrice(conv.output.itemID)
            local outUnitPrice = outCurrent or outTypical

        if outUnitPrice and outUnitPrice > 0 then
            local totalOutValue = math.floor(outUnitPrice * conv.output.qty * 0.95)
            local totalCost = 0
            local hasAllReagents = true
            local reagentSummary = {}

            for _, r in ipairs(conv.reagents) do
                local rCost = r.fixedPrice or (ns.GetVendorPrice and ns.GetVendorPrice(r.itemID)) or ns.GetItemCurrentPrice(r.itemID) or ns.GetItemTypicalPrice(r.itemID)
                if not rCost or rCost <= 0 then
                    hasAllReagents = false
                    break
                end
                local subCost = rCost * r.qty
                totalCost = totalCost + subCost
                reagentSummary[#reagentSummary + 1] = {
                    itemID = r.itemID,
                    qty = r.qty,
                    unitCost = rCost,
                    totalCost = subCost,
                }
            end

            if hasAllReagents and totalCost > 0 then
                local netProfit = totalOutValue - totalCost
                if netProfit > 0 and netProfit >= minProfit then
                    local roi = netProfit / totalCost
                    local deal = {
                        isConversion   = true,
                        conversion     = conv,
                        itemID         = conv.output.itemID,
                        name           = (L and L[conv.name]) or conv.name,
                        now            = totalCost,
                        typical        = totalOutValue,
                        below          = math.min(0.95, math.max(0.05, roi / (1 + roi))),
                        roi            = roi,
                        qty            = conv.output.qty,
                        netUnitProfit  = math.floor(netProfit / conv.output.qty),
                        totalNetProfit = netProfit,
                        reagents       = reagentSummary,
                        category       = "conversions",
                        isWatched      = ns.IsWatched and ns.IsWatched(conv.output.itemID) or false,
                    }
                    deal.tier = ns.GetDealTier(deal)
                    deals[#deals + 1] = deal
                end
            end
        end
    end
    end

    local sortBy = ns.GetSortBy()
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

    return deals
end

function ns.FindUndercuts()
    local undercuts = {}
    if not C_AuctionHouse or not C_AuctionHouse.GetOwnedAuctions then return undercuts end

    local owned = C_AuctionHouse.GetOwnedAuctions()
    if type(owned) ~= "table" or #owned == 0 then
        local num = C_AuctionHouse.GetNumOwnedAuctions and C_AuctionHouse.GetNumOwnedAuctions() or 0
        if num > 0 and C_AuctionHouse.GetOwnedAuctionInfo then
            owned = {}
            for i = 1, num do
                local info = C_AuctionHouse.GetOwnedAuctionInfo(i)
                if info then owned[#owned + 1] = info end
            end
        end
    end

    if type(owned) ~= "table" then return undercuts end

    for _, a in ipairs(owned) do
        local itemID = a.itemKey and a.itemKey.itemID
        local buyout = a.buyoutAmount or 0
        local qty = math.max(1, a.quantity or 1)
        if itemID and buyout > 0 then
            local myUnitPrice = math.floor(buyout / qty)
            local currentLowest = ns.GetItemCurrentPrice(itemID)
            if currentLowest and currentLowest < myUnitPrice then
                local diff = myUnitPrice - currentLowest
                local pct = diff / myUnitPrice
                local deal = {
                    isUndercut      = true,
                    auctionID       = a.auctionID,
                    itemID          = itemID,
                    itemKey         = a.itemKey,
                    name            = a.itemLink or (C_Item.GetItemNameByID(itemID) or ("Item " .. itemID)),
                    now             = currentLowest,
                    typical         = myUnitPrice,
                    below           = pct,
                    qty             = a.quantity,
                    netUnitProfit   = 0,
                    totalNetProfit  = diff * qty,
                    timeLeft        = a.timeLeft,
                    timeLeftSeconds = a.timeLeftSeconds,
                    category        = "undercuts",
                }
                deal.tier = {
                    id       = "undercut",
                    label    = "Undercut",
                    tag      = "[UNDERCUT]",
                    hex      = "ff4444",
                    colorStr = "|cffff4444",
                    r        = 1.0,
                    g        = 0.25,
                    b        = 0.25,
                    bgAlpha  = 0.12,
                }
                undercuts[#undercuts + 1] = deal
            end
        end
    end

    table.sort(undercuts, function(x, y)
        return (x.totalNetProfit or 0) > (y.totalNetProfit or 0)
    end)

    return undercuts
end

function ns.FindShoppingDeals()
    local deals = {}
    local list = ns.GetShoppingList and ns.GetShoppingList()
    if not list then return deals end

    for itemID, req in pairs(list) do
        local targetQty = req.target or req.targetQty or 0
        if targetQty > 0 then
            local acquired = ns.GetItemInventoryCount and ns.GetItemInventoryCount(itemID) or 0
            local remaining = math.max(0, targetQty - acquired)
            local currentPrice = ns.GetItemCurrentPrice and ns.GetItemCurrentPrice(itemID)
            local typical = (ns.GetItemTypicalPrice and ns.GetItemTypicalPrice(itemID)) or currentPrice or 0
            local maxPrice = req.maxUnitPrice
            local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or ("Item %d"):format(itemID)

            local unitCost = currentPrice or maxPrice or typical or 0
            local totalCost = remaining * unitCost

            local below = 0
            if typical and typical > 0 and currentPrice and currentPrice > 0 then
                below = (typical - currentPrice) / typical
            end

            local altTotal, altBreakdown = 0, {}
            if ns.GetAltItemBreakdown then
                altTotal, altBreakdown = ns.GetAltItemBreakdown(itemID)
            end

            local deal = {
                isShopping      = true,
                itemID          = itemID,
                name            = name,
                now             = currentPrice or 0,
                typical         = maxPrice or typical or 0,
                below           = below,
                qty             = remaining,
                target          = targetQty,
                acquired        = acquired,
                remaining       = remaining,
                altTotal        = altTotal,
                altBreakdown    = altBreakdown,
                maxUnitPrice    = maxPrice,
                totalCost       = totalCost,
                netUnitProfit   = (typical > (currentPrice or 0)) and (typical - (currentPrice or 0)) or 0,
                totalNetProfit  = remaining * ((typical > (currentPrice or 0)) and (typical - (currentPrice or 0)) or 0),
                category        = "shopping",
            }

            if remaining == 0 then
                deal.tier = {
                    id       = "complete",
                    label    = "Complete",
                    tag      = "[GOAL MET]",
                    hex      = "40ff40",
                    colorStr = "|cff40ff40",
                    r        = 0.25,
                    g        = 1.0,
                    b        = 0.25,
                    bgAlpha  = 0.08,
                }
            elseif maxPrice and currentPrice and currentPrice > maxPrice then
                deal.tier = {
                    id       = "overbudget",
                    label    = "Over Budget",
                    tag      = "[OVER CAP]",
                    hex      = "ff8844",
                    colorStr = "|cffff8844",
                    r        = 1.0,
                    g        = 0.53,
                    b        = 0.27,
                    bgAlpha  = 0.08,
                }
            else
                deal.tier = {
                    id       = "shopping",
                    label    = "Target",
                    tag      = "[GOAL]",
                    hex      = "00ccff",
                    colorStr = "|cff00ccff",
                    r        = 0.0,
                    g        = 0.8,
                    b        = 1.0,
                    bgAlpha  = 0.10,
                }
            end

            deals[#deals + 1] = deal
        end
    end

    table.sort(deals, function(a, b)
        if (a.remaining > 0) ~= (b.remaining > 0) then
            return a.remaining > 0
        end
        return (a.remaining or 0) > (b.remaining or 0)
    end)

    return deals
end

function ns.FindDeals()
    if ns.GetActiveCategory and ns.GetActiveCategory() == "undercuts" then
        return ns.FindUndercuts(), { items = 0, judged = 0, needMore = 0, stale = 0, fewestMissing = nil }
    end
    if ns.GetActiveCategory and ns.GetActiveCategory() == "shopping" then
        local sDeals = ns.FindShoppingDeals()
        return sDeals, { items = #sDeals, judged = #sDeals, needMore = 0, stale = 0, fewestMissing = nil }
    end
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
        if not (ns.IsBlacklisted and ns.IsBlacklisted(itemID)) and n > 0 then
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
                local typical = ns.CalculateBaseline(prior)
                local isOverpricedVendor = ns.IsOverpricedVendorListing and ns.IsOverpricedVendorListing(itemID, current.min)
                if typical > 0 and current.min <= ratio * typical and not isOverpricedVendor then
                    local conf = ns.GetConfidenceScore(h)
                    local minConf = ns.GetMinConfidence and ns.GetMinConfidence() or "any"
                    local passConf = true
                    if minConf == "high" and conf.score < 3 then passConf = false end
                    if (minConf == "med" or minConf == "moderate") and conf.score < 2 then passConf = false end

                    if passConf then
                        -- Net flip profit: after deducting Blizzard's 5% AH cut
                        local netUnit = math.floor(typical * 0.95 - current.min)
                        local totalNet = math.max(0, math.floor(netUnit * (current.qty or 1)))
                        if totalNet >= minProfit then
                            local restockTarget = ns.GetRestockLevel and ns.GetRestockLevel(itemID)
                            local restockCurrent = restockTarget and (C_Item and C_Item.GetItemCount and C_Item.GetItemCount(itemID, true) or (GetItemCount and GetItemCount(itemID, true) or 0)) or 0
                            local isRestockNeeded = restockTarget and (restockCurrent < restockTarget) or false

                            deals[#deals + 1] = {
                                itemID          = itemID,
                                itemKey         = rec.itemKey,  -- nil for items not seen since v0.0.6
                                name            = ((C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or (GetItemInfo and GetItemInfo(itemID)) or rec.name),
                                now             = current.min,
                                typical         = typical,
                                below           = 1 - current.min / typical,
                                qty             = current.qty or 0,
                                netUnitProfit   = netUnit,
                                totalNetProfit  = totalNet,
                                trend           = CalculateTrend(h),
                                history         = h,
                                category        = ns.GetItemCategory and ns.GetItemCategory(itemID) or "other",
                                isWatched       = ns.IsWatched and ns.IsWatched(itemID) or false,
                                isShoppingGoal  = (ns.GetShoppingItem and ns.GetShoppingItem(itemID) ~= nil),
                                isRestockNeeded = isRestockNeeded,
                                restockTarget   = restockTarget,
                                restockCurrent  = restockCurrent,
                                confidence      = conf,
                                isBiS           = (_G.BiSGearFinder and _G.BiSGearFinder.IsBiSItem and _G.BiSGearFinder.IsBiSItem(itemID)) or false,
                            }
                            deals[#deals].tier = ns.GetDealTier(deals[#deals])
                        end
                    end
                end
            end
        end
    end

    local convDeals = ns.FindConversionDeals()
    for _, cd in ipairs(convDeals) do
        deals[#deals + 1] = cd
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
    local sortDesc = (sortBy == "profit") and (L["by estimated net profit"] or "by estimated net profit") or (L["by discount"] or "by discount")

    if status.items == 0 then
        return L["No prices recorded yet"],
            L["Run a Full Scan at the auction house. GoldFinder records the results automatically."]
    end
    if #deals > 0 then
        return (L["%d underpriced %s (%s)"]):format(#deals, Plural(#deals, L["material"], L["materials"]), sortDesc),
            (L["Listed at least %d%% below typical price."]):format(pct)
    end
    if status.judged > 0 then
        return L["No underpriced materials right now"],
            ("%d %s checked. None is %d%% or more below its typical price."):format(
                status.judged, Plural(status.judged, L["material"], L["materials"]), pct)
    end
    if status.needMore > 0 then
        return L["Building price history"],
            ("%d materials tracked. Deals can show after %d more Full %s, at least 10 minutes apart."):format(
                status.items, status.fewestMissing, Plural(status.fewestMissing, L["Scan"], L["Scans"]))
    end
    return L["No recent prices"],
        L["Run a Full Scan to check what is listed now."]
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

---------------------------------------------------------------------------
-- Trade Chat Bark Scanner (Theme 3 - GoldFinder v2.0)
---------------------------------------------------------------------------

ns.recentBarks = ns.recentBarks or {}
local MAX_BARKS = 25

function ns.ParseTradeBark(message, sender, channelName)
    if type(message) ~= "string" or message == "" then
        return nil, "Empty message."
    end
    local myName = UnitName and UnitName("player")
    if sender and myName then
        local shortSender = sender:match("^([^%-]+)") or sender
        if shortSender == myName then
            return nil, "Ignoring self message."
        end
    end

    local lower = message:lower()
    -- Ignore buyers / LFG / WTB spam
    if lower:find("%f[%a]wtb%f[%A]") or lower:find("%f[%a]lf%f[%A]") or lower:find("looking for") then
        return nil, "Message is a buy or group request."
    end

    -- Extract first WoW item link & ID
    local itemLink = message:match("(|c%x+|Hitem:%d+:[^|]*|h%[[^%]]+%]|h|r)")
        or message:match("(|Hitem:%d+:[^|]*|h%[[^%]]+%]|h)")
    local itemID = tonumber(message:match("|Hitem:(%d+):"))
    if not itemID then
        return nil, "No item link found."
    end

    -- Strip item links and WoW formatting codes before parsing numbers so item names cannot spoof prices
    local clean = message
    clean = clean:gsub("|c%x+|Hitem:[^|]*|h%[[^%]]+%]|h|r", " ")
    clean = clean:gsub("|Hitem:[^|]*|h%[[^%]]+%]|h", " ")
    clean = clean:gsub("|c%x%x%x%x%x%x%x%x", " "):gsub("|r", " ")
    local cleanLower = clean:lower()

    -- Parse price in copper (e.g. "15g 50s", "15.5g", "15g", "500s")
    local copper = nil
    local gPart, sPart = cleanLower:match("(%d+)%s*g%s*(%d+)%s*s")
    if gPart and sPart then
        copper = (tonumber(gPart) * 10000) + (tonumber(sPart) * 100)
    else
        local gFloat = cleanLower:match("(%d+%.%d+)%s*g")
        if gFloat then
            copper = math.floor(tonumber(gFloat) * 10000 + 0.5)
        else
            local gOnly = cleanLower:match("(%d+)%s*g")
            if gOnly then
                copper = tonumber(gOnly) * 10000
            else
                local sOnly = cleanLower:match("(%d+)%s*s")
                if sOnly then
                    copper = tonumber(sOnly) * 100
                end
            end
        end
    end

    if not copper or copper <= 0 then
        return nil, "No valid asking price parsed."
    end

    -- Must have either WTS/selling/each wording or a direct link+price
    local hasSellHint = lower:find("%f[%a]wts%f[%A]") or lower:find("selling") or lower:find("sale") or lower:find("%d+%s*[gs]")
    if not hasSellHint then
        return nil, "No selling indicator."
    end

    local typical = ns.GetItemTypicalPrice and ns.GetItemTypicalPrice(itemID)
    if not typical or typical <= 0 then
        return nil, "No typical AH price recorded for this item."
    end

    local ratio = (ns.GetDealRatio and ns.GetDealRatio()) or 0.70
    if copper > typical * ratio then
        return nil, "Asking price is not below deal threshold."
    end

    local netProfit = math.floor(typical * 0.95) - copper
    if netProfit <= 0 then
        return nil, "Net profit after 5% AH cut is non-positive."
    end

    local rec = {
        itemID    = itemID,
        itemLink  = itemLink or ((C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or ("Item " .. itemID)),
        sender    = sender or "Unknown",
        channel   = channelName or "Trade",
        price     = copper,
        typical   = typical,
        discount  = 1 - (copper / typical),
        netProfit = netProfit,
        time      = (GetServerTime and GetServerTime()) or time(),
    }

    table.insert(ns.recentBarks, 1, rec)
    while #ns.recentBarks > MAX_BARKS do
        table.remove(ns.recentBarks)
    end
    return rec
end

---------------------------------------------------------------------------
-- Neutral AH vs. Faction AH Cross-Market Arbitrage (Theme 3 - GoldFinder v2.0)
---------------------------------------------------------------------------

local function PartitionStats(rec)
    if not rec or not rec.history or #rec.history == 0 then return nil, nil end
    local h = rec.history
    local latest = h[#h].min
    if not latest or latest <= 0 then return nil, nil end
    local vals = {}
    for i = 1, #h do
        if h[i].min and h[i].min > 0 then
            vals[#vals + 1] = h[i].min
        end
    end
    local typical = (ns.CalculateBaseline and ns.CalculateBaseline(vals)) or Median(vals) or latest
    return latest, typical
end

function ns.FindCrossMarketDeals()
    local deals = {}
    if not ns.db or not ns.db.realms then return deals end

    local realm = (ns.GetActiveRealm and ns.GetActiveRealm()) or "Default"
    local rData = ns.db.realms[realm]
    if not rData or not rData.factions then return deals end

    local neutralData = rData.factions["Neutral"]
    if not neutralData or not neutralData.items then
        return deals
    end

    local activeFaction = (ns.GetActiveFaction and ns.GetActiveFaction()) or "Horde"
    if activeFaction == "Neutral" then
        activeFaction = (rData.factions["Horde"] and "Horde") or (rData.factions["Alliance"] and "Alliance") or nil
    end
    local factionData = activeFaction and rData.factions[activeFaction]
    if not factionData or not factionData.items then
        return deals
    end

    local minProfit = (ns.GetMinProfit and ns.GetMinProfit()) or 0

    for itemID, fRec in pairs(factionData.items) do
        local nRec = neutralData.items[itemID]
        if nRec and not (ns.IsBlacklisted and ns.IsBlacklisted(itemID)) then
            local fNow, fTyp = PartitionStats(fRec)
            local nNow, nTyp = PartitionStats(nRec)
            if fNow and fTyp and nNow and nTyp then
                -- Route A: Buy on Neutral AH -> Sell on Faction AH (5% cut)
                local factionNetReturn = math.floor(fTyp * 0.95)
                local neutralToFactionProfit = factionNetReturn - nNow

                -- Route B: Buy on Faction AH -> Sell on Neutral AH (15% Goblin cut)
                local neutralNetReturn = math.floor(nTyp * 0.85)
                local factionToNeutralProfit = neutralNetReturn - fNow

                if neutralToFactionProfit > 0 and neutralToFactionProfit >= minProfit and neutralToFactionProfit >= factionToNeutralProfit then
                    local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or fRec.name or nRec.name or ("Item " .. itemID)
                    deals[#deals + 1] = {
                        itemID      = itemID,
                        name        = name,
                        buyMarket   = "Neutral",
                        sellMarket  = activeFaction,
                        buyPrice    = nNow,
                        sellTypical = fTyp,
                        ahCutPct    = 5,
                        netProfit   = neutralToFactionProfit,
                        roi         = neutralToFactionProfit / nNow,
                    }
                elseif factionToNeutralProfit > 0 and factionToNeutralProfit >= minProfit then
                    local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or fRec.name or nRec.name or ("Item " .. itemID)
                    deals[#deals + 1] = {
                        itemID      = itemID,
                        name        = name,
                        buyMarket   = activeFaction,
                        sellMarket  = "Neutral",
                        buyPrice    = fNow,
                        sellTypical = nTyp,
                        ahCutPct    = 15,
                        netProfit   = factionToNeutralProfit,
                        roi         = factionToNeutralProfit / fNow,
                    }
                end
            end
        end
    end

    table.sort(deals, function(a, b)
        return (a.netProfit or 0) > (b.netProfit or 0)
    end)

    return deals
end
