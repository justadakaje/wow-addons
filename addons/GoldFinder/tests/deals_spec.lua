-- deals_spec.lua -- Unit tests for GoldFinder deal valuation and detection logic

local helper
local ok, res = pcall(require, "tests.test_helper")
if ok then
    helper = res
else
    helper = require("addons.GoldFinder.tests.test_helper")
end

describe("GoldFinder Deals Engine", function()
    local ns

    before_each(function()
        helper.reset()
        ns = helper.createNamespace()
        helper.loadAddonFile("Core.lua", ns)
        helper.loadAddonFile("Deals.lua", ns)
    end)

    describe("Statistical Valuation Baselines", function()
        it("calculates median correctly for odd and even counts", function()
            -- Empty or nil
            assert.is_nil(ns.CalculateMedian(nil))
            assert.is_nil(ns.CalculateMedian({}))

            -- Single value
            assert.are.equal(100, ns.CalculateMedian({100}))

            -- Odd number of elements
            assert.are.equal(30, ns.CalculateMedian({50, 10, 30}))

            -- Even number of elements (average of two middle)
            assert.are.equal(25, ns.CalculateMedian({10, 20, 30, 40}))

            -- Rounding check for even number with fractional half
            -- (10 + 25) / 2 = 17.5 -> 18
            assert.are.equal(18, ns.CalculateMedian({10, 25}))
        end)

        it("calculates trimmed mean discarding outliers", function()
            -- Fallback for small sample size (<= 2)
            assert.are.equal(20, ns.CalculateTrimmedMean({10, 30}))

            -- 10 elements: 10% trim removes 1 highest and 1 lowest
            -- [1000, 10, 12, 11, 13, 10, 12, 11, 14, 1]
            -- Sorted: [1, 10, 10, 11, 11, 12, 12, 13, 14, 1000]
            -- Trim 1 from each end -> [10, 10, 11, 11, 12, 12, 13, 14]
            -- Sum = 93, Count = 8, Mean = 93 / 8 = 11.625 -> 12
            local values = {1000, 10, 12, 11, 13, 10, 12, 11, 14, 1}
            local trimmed = ns.CalculateTrimmedMean(values, 0.10)
            assert.are.equal(12, trimmed)
        end)

        it("calculates exponential moving average (EMA) weighting recent scans higher", function()
            -- Constant values should yield same value
            assert.are.equal(100, ns.CalculateEMA({100, 100, 100}))

            -- Price drop: older 200, middle 150, newest 100
            -- EMA should be lower than standard mean ((200+150+100)/3 = 150)
            local drop = ns.CalculateEMA({200, 150, 100}, 7)
            assert.is_true(drop < 150)

            -- Price surge: older 100, middle 150, newest 200
            -- EMA should be higher than standard mean
            local surge = ns.CalculateEMA({100, 150, 200}, 7)
            assert.is_true(surge > 150)
        end)

        it("dispatches CalculateBaseline according to valuation model", function()
            local values = {1, 10, 10, 10, 10, 1000}
            assert.are.equal(ns.CalculateMedian(values), ns.CalculateBaseline(values, "median"))
            assert.are.equal(ns.CalculateTrimmedMean(values), ns.CalculateBaseline(values, "trimmed"))
            assert.are.equal(ns.CalculateEMA(values), ns.CalculateBaseline(values, "ema"))
        end)
    end)

    describe("Market Trend Detection", function()
        it("returns nil when history is insufficient", function()
            assert.is_nil(ns.CalculateTrend(nil))
            assert.is_nil(ns.CalculateTrend({ { min = 100 } }))
            assert.is_nil(ns.CalculateTrend({ { min = 100 }, { min = 100 }, { min = 100 } }))
        end)

        it("detects falling prices (falling knife warning)", function()
            -- 5 historical scans: first 2 are old, next 2 are new, last 1 is candidate deal
            local history = {
                { min = 1000 },
                { min = 1000 },
                { min = 800 },
                { min = 750 },
                { min = 400 }, -- candidate deal excluded from trend calculation
            }
            local trend = ns.CalculateTrend(history)
            assert.is_not_nil(trend)
            assert.are.equal("falling", trend.direction)
            assert.is_not_nil(trend.warning)
            assert.is_true(trend.pct >= 10)
        end)

        it("detects rising and steady market trends", function()
            local risingHistory = {
                { min = 500 },
                { min = 550 },
                { min = 750 },
                { min = 800 },
                { min = 400 },
            }
            local trendRising = ns.CalculateTrend(risingHistory)
            assert.are.equal("rising", trendRising.direction)
            assert.is_nil(trendRising.warning)

            local steadyHistory = {
                { min = 500 },
                { min = 510 },
                { min = 505 },
                { min = 495 },
                { min = 300 },
            }
            local trendSteady = ns.CalculateTrend(steadyHistory)
            assert.are.equal("steady", trendSteady.direction)
        end)
    end)

    describe("Confidence Scoring", function()
        it("marks thin or empty history as speculative", function()
            local scoreEmpty = ns.GetConfidenceScore({})
            assert.are.equal("speculative", scoreEmpty.level)
            assert.are.equal(1, scoreEmpty.score)

            local scoreFew = ns.GetConfidenceScore({
                { min = 100, seen = 1000 },
                { min = 100, seen = 2000 },
            })
            assert.are.equal("speculative", scoreFew.level)
            assert.are.equal(1, scoreFew.score)
        end)

        it("awards high confidence for deep and stable scan history", function()
            local deepHistory = {}
            local baseTime = 100000
            for i = 1, 15 do
                deepHistory[i] = {
                    min = 1000 + (i % 3) * 10,
                    seen = baseTime + (i * 7200), -- spans 30 hours
                }
            end
            local conf = ns.GetConfidenceScore(deepHistory)
            assert.are.equal("high", conf.level)
            assert.are.equal(3, conf.score)
        end)
    end)

    describe("Deal Tier Classification", function()
        it("identifies Mega Snipe for deep discounts or massive profit", function()
            local deepDiscount = { below = 0.75, totalNetProfit = 5000 }
            assert.are.equal("mega", ns.GetDealTier(deepDiscount).id)

            local hugeProfit = { below = 0.30, totalNetProfit = 1500000 } -- 150g profit
            assert.are.equal("mega", ns.GetDealTier(hugeProfit).id)
        end)

        it("identifies Great Deal and Good Flip", function()
            local greatDeal = { below = 0.40, totalNetProfit = 50000 }
            assert.are.equal("great", ns.GetDealTier(greatDeal).id)

            local goodFlip = { below = 0.25, totalNetProfit = 10000 }
            assert.are.equal("good", ns.GetDealTier(goodFlip).id)
        end)
    end)

    describe("FindDeals Valuation & Filter Engine", function()
        it("finds underpriced deals and deducts 5% AH cut from profit", function()
            -- Set current server time
            helper.currentServerTime = 1700000000

            -- Configure test item with 4 scans:
            -- Prior scans: 10000c, 10000c, 10000c -> typical = 10000c (1g)
            -- Current scan: 6000c (60s) -> 40% below typical (qualifies at 70% ratio)
            ns.db.items[12345] = {
                name = "Test Ore",
                history = {
                    { min = 10000, qty = 10, seen = 1700000000 - 3600 },
                    { min = 10000, qty = 10, seen = 1700000000 - 2400 },
                    { min = 10000, qty = 10, seen = 1700000000 - 1200 },
                    { min = 6000,  qty = 5,  seen = 1700000000 - 60 },
                },
            }

            local deals, status = ns.FindDeals()
            assert.are.equal(1, status.items)
            assert.are.equal(1, status.judged)
            assert.are.equal(0, status.needMore)
            assert.are.equal(0, status.stale)
            assert.are.equal(1, #deals)

            local deal = deals[1]
            assert.are.equal(12345, deal.itemID)
            assert.are.equal(6000, deal.now)
            assert.are.equal(10000, deal.typical)
            assert.are.equal(0.40, deal.below)

            -- 5% cut: typical (10000) * 0.95 = 9500c.
            -- netUnitProfit = 9500 - 6000 = 3500c.
            -- totalNetProfit = 3500 * qty (5) = 17500c.
            assert.are.equal(3500, deal.netUnitProfit)
            assert.are.equal(17500, deal.totalNetProfit)
        end)

        it("filters out stale listings older than 30 minutes", function()
            helper.currentServerTime = 1700000000
            ns.db.items[999] = {
                name = "Old Herbs",
                history = {
                    { min = 10000, seen = 1700000000 - 5000 },
                    { min = 10000, seen = 1700000000 - 4000 },
                    { min = 10000, seen = 1700000000 - 3000 },
                    { min = 5000,  seen = 1700000000 - 2000 }, -- 2000s > 1800s FRESH_SECONDS
                },
            }

            local deals, status = ns.FindDeals()
            assert.are.equal(0, #deals)
            assert.are.equal(1, status.stale)
        end)

        it("filters out items needing more scans to establish baseline", function()
            helper.currentServerTime = 1700000000
            ns.db.items[888] = {
                name = "New Leather",
                history = {
                    { min = 10000, seen = 1700000000 - 600 },
                    { min = 4000,  seen = 1700000000 - 60 }, -- only 1 prior scan, default requires 3
                },
            }

            local deals, status = ns.FindDeals()
            assert.are.equal(0, #deals)
            assert.are.equal(1, status.needMore)
            assert.are.equal(2, status.fewestMissing)
        end)

        it("ignores blacklisted items", function()
            helper.currentServerTime = 1700000000
            ns.db.blacklist[777] = true
            ns.db.items[777] = {
                name = "Blacklisted Cloth",
                history = {
                    { min = 10000, seen = 1700000000 - 3600 },
                    { min = 10000, seen = 1700000000 - 2400 },
                    { min = 10000, seen = 1700000000 - 1200 },
                    { min = 3000,  seen = 1700000000 - 60 },
                },
            }

            local deals, status = ns.FindDeals()
            assert.are.equal(0, #deals)
            assert.are.equal(0, status.items)
        end)
    end)
end)
