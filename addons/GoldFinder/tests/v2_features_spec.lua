-- v2_features_spec.lua -- Unit tests for GoldFinder v2.0.0 feature themes
-- Covers:
--   Theme 1 (#60): Expanded CONVERSIONS, multi-recipe BuyHelper parity, Disenchant EV, TradeSkill profit
--   Theme 3 (#61): Trade Chat Bark Scanner parser & Neutral vs Faction Cross-Market Arbitrage
--   Theme 4 (#62): Interactive 30-Day Price Chart Modal & LibSharedMedia-3.0 sounds
--   Theme 2 (#63): Multi-Alt Reagent Hub & Mailbox Expiration Watcher

local helper
local ok, res = pcall(require, "tests.test_helper")
if ok then
    helper = res
else
    helper = require("addons.GoldFinder.tests.test_helper")
end

local function SeedItemHistory(ns, itemID, prices, name)
    local h = {}
    local now = GetServerTime()
    for idx, p in ipairs(prices) do
        h[#h + 1] = { min = p, seen = now - (#prices - idx) * 3600 }
    end
    ns.db.items[itemID] = {
        name = name or ("Item " .. tostring(itemID)),
        history = h,
    }
end

describe("GoldFinder v2.0.0 Features", function()
    local ns
    local origCItemGetItemInfo
    local origCContainer
    local origGetInboxNumItems
    local origGetInboxHeaderInfo
    local origGetInboxItemLink
    local origGetInboxItem
    local origLibStub
    local origPlaySoundFile

    before_each(function()
        helper.reset()
        origCItemGetItemInfo = C_Item.GetItemInfo
        origCContainer = _G.C_Container
        origGetInboxNumItems = _G.GetInboxNumItems
        origGetInboxHeaderInfo = _G.GetInboxHeaderInfo
        origGetInboxItemLink = _G.GetInboxItemLink
        origGetInboxItem = _G.GetInboxItem
        origLibStub = _G.LibStub
        origPlaySoundFile = _G.PlaySoundFile

        ns = helper.createNamespace()
        ns.db.settings.minPrior = 2
        ns.db.settings.dealRatio = 0.75
        ns.db.settings.soundAlert = true
        ns.db.settings.soundThrottle = 0
        ns.db.realms = {
            TestRealm = {
                items = ns.db.items,
                scans = ns.db.scans,
                factions = {},
                characters = {},
            },
        }
        helper.loadAddonFile("Core.lua", ns)
        helper.loadAddonFile("Vendors.lua", ns)
        helper.loadAddonFile("Deals.lua", ns)
        helper.loadAddonFile("BuyHelper.lua", ns)
        helper.loadAddonFile("Sparkline.lua", ns)
        helper.loadAddonFile("Mail.lua", ns)
    end)

    after_each(function()
        C_Item.GetItemInfo = origCItemGetItemInfo
        _G.C_Container = origCContainer
        _G.GetInboxNumItems = origGetInboxNumItems
        _G.GetInboxHeaderInfo = origGetInboxHeaderInfo
        _G.GetInboxItemLink = origGetInboxItemLink
        _G.GetInboxItem = origGetInboxItem
        _G.LibStub = origLibStub
        _G.PlaySoundFile = origPlaySoundFile
    end)

    describe("Theme 1: Smart Buy Parity 2.0 & Disenchant EV (#60)", function()
        it("indexes Leatherworking, Alchemy, and Enchanting multi-recipe conversions", function()
            assert.is_table(ns.CONVERSIONS)
            local outLookup, reagentLookup = ns.GetConversionLookups()
            -- Medium Leather (2319) -> Heavy Leather (4234) & Cured Medium Hide (4233)
            assert.is_table(outLookup[4234])
            assert.is_true(#outLookup[4234] >= 1)
            assert.is_table(reagentLookup[2319])
            assert.is_true(#reagentLookup[2319] >= 1)
            -- 3x Lesser Magic Essence (10938) -> Greater Magic Essence (10939)
            assert.is_table(reagentLookup[10938])
            assert.is_table(outLookup[10939])
            -- Heart of Fire (7077) -> 3x Elemental Fire (7068)
            local foundHeartToFire = false
            for _, conv in ipairs(outLookup[7068] or {}) do
                if conv.reagents[1] and conv.reagents[1].itemID == 7077 and conv.output.qty == 3 then
                    foundHeartToFire = true
                end
            end
            assert.is_true(foundHeartToFire)
        end)

        it("computes Disenchant EV for uncommon armor and returns nil + reason otherwise", function()
            SeedItemHistory(ns, 10940, { 200, 200, 200 }, "Strange Dust")
            SeedItemHistory(ns, 10938, { 1000, 1000, 1000 }, "Lesser Magic Essence")

            C_Item.GetItemInfo = function(id)
                if id == 90001 then
                    return "Green Tunic", "|cff1eff00|Hitem:90001::::::::10:::::|h[Green Tunic]|h|r", 2, 12, "", "", "", 1, "", 0, 0, 4
                elseif id == 90002 then
                    return "White Shirt", "|cffffffff|Hitem:90002::::::::1:::::|h[White Shirt]|h|r", 1, 12, "", "", "", 1, "", 0, 0, 4
                end
            end

            local netEV, err, details = ns.GetDisenchantValue(90001)
            assert.is_nil(err)
            assert.is_number(netEV)
            assert.is_true(netEV > 0)
            assert.is_table(details)
            assert.are.equal(12, details.iLevel)

            local missingEV, missingErr = ns.GetDisenchantValue(90002)
            assert.is_nil(missingEV)
            assert.is_string(missingErr)
        end)

        it("evaluates TradeSkill recipe profit using vendor/AH reagent costs", function()
            SeedItemHistory(ns, 2318, { 100, 100, 100 }, "Light Leather")
            SeedItemHistory(ns, 2319, { 1000, 1000, 1000 }, "Medium Leather")
            local resProfit = ns.EvaluateRecipeProfit(2319, 1, { { itemID = 2318, qty = 4 } })
            assert.is_table(resProfit)
            assert.are.equal(400, resProfit.cost)
            assert.are.equal(950, resProfit.netOutput)
            assert.are.equal(550, resProfit.netProfit)
        end)
    end)

    describe("Theme 3: Trade Chat Bark Scanner & Cross-Market Arbitrage (#61)", function()
        it("parses valid WTS bargain barks and ignores WTB, overpriced, self, and link-number spoofs", function()
            SeedItemHistory(ns, 13468, { 1000000, 1000000, 1000000 }, "Black Lotus") -- 100g typical

            local bark, reason = ns.ParseTradeBark("WTS |cff1eff00|Hitem:13468::::::::60:::::|h[Black Lotus]|h|r 50g", "GoblinTrader", "Trade - City")
            assert.is_nil(reason)
            assert.is_table(bark)
            assert.are.equal(13468, bark.itemID)
            assert.are.equal(500000, bark.price)
            assert.is_true(bark.netProfit > 0)

            -- WTB ignored
            local wtbBark, wtbErr = ns.ParseTradeBark("WTB |cff1eff00|Hitem:13468::::::::60:::::|h[Black Lotus]|h|r 50g", "Buyer", "Trade - City")
            assert.is_nil(wtbBark)
            assert.is_string(wtbErr)

            -- Self ignored (UnitName == "Tester")
            local selfBark, selfErr = ns.ParseTradeBark("WTS |cff1eff00|Hitem:13468::::::::60:::::|h[Black Lotus]|h|r 40g", "Tester-TestRealm", "Trade - City")
            assert.is_nil(selfBark)
            assert.is_string(selfErr)

            -- Overpriced ignored
            local highBark, highErr = ns.ParseTradeBark("WTS |cff1eff00|Hitem:13468::::::::60:::::|h[Black Lotus]|h|r 90g", "OtherSeller", "Trade - City")
            assert.is_nil(highBark)
            assert.is_string(highErr)

            -- Spoofed number inside item link without actual price outside link
            local spoofBark, spoofErr = ns.ParseTradeBark("WTS |cffffffff|Hitem:13468::::::::60:::::|h[10g Box]|h|r pst", "Spoofer", "Trade - City")
            assert.is_nil(spoofBark)
            assert.is_string(spoofErr)
        end)

        it("calculates Cross-Market Arbitrage accounting for 15% Neutral AH vs 5% Faction AH cut", function()
            local now = GetServerTime()
            ns.db.realms["TestRealm"].factions = {
                Horde = {
                    items = {
                        [7068] = { name = "Elemental Fire", history = { { min = 20000, seen = now - 3600 }, { min = 20000, seen = now } } },
                        [2772] = { name = "Iron Ore", history = { { min = 1000, seen = now - 3600 }, { min = 1000, seen = now } } },
                    },
                },
                Neutral = {
                    items = {
                        [7068] = { name = "Elemental Fire", history = { { min = 5000, seen = now - 3600 }, { min = 5000, seen = now } } },
                        [2772] = { name = "Iron Ore", history = { { min = 2000, seen = now - 3600 }, { min = 2000, seen = now } } },
                    },
                },
            }

            local deals = ns.FindCrossMarketDeals()
            assert.is_true(#deals >= 2)
            assert.are.equal(7068, deals[1].itemID)
            assert.are.equal("Neutral", deals[1].buyMarket)
            assert.are.equal("Horde", deals[1].sellMarket)
            assert.are.equal(5, deals[1].ahCutPct)
            assert.are.equal(14000, deals[1].netProfit) -- floor(20000 * 0.95) - 5000 = 14000

            assert.are.equal(2772, deals[2].itemID)
            assert.are.equal("Horde", deals[2].buyMarket)
            assert.are.equal("Neutral", deals[2].sellMarket)
            assert.are.equal(15, deals[2].ahCutPct)
            assert.are.equal(700, deals[2].netProfit) -- floor(2000 * 0.85) - 1000 = 700
        end)
    end)

    describe("Theme 4: 30-Day Price Chart Modal & LibSharedMedia-3.0 (#62)", function()
        it("renders 30-day modal chart when >= 2 sightings exist and shows message when insufficient", function()
            SeedItemHistory(ns, 30001, { 1000 })
            local emptyModal = ns.ShowPriceChartModal(30001)
            assert.is_table(emptyModal)
            assert.is_true(emptyModal:IsShown())
            assert.is_true(emptyModal.emptyText:IsShown())

            SeedItemHistory(ns, 30002, { 1000, 1200, 900, 1500, 1100 })
            local modal = ns.ShowPriceChartModal(30002)
            assert.is_table(modal)
            assert.is_true(modal:IsShown())
            assert.is_false(modal.emptyText:IsShown())
            assert.is_true(modal.bars[5]:IsShown())
            assert.is_false(modal.bars[6]:IsShown())
        end)

        it("discovers and plays custom sounds registered via LibSharedMedia-3.0", function()
            local playedFile
            _G.PlaySoundFile = function(path) playedFile = path end
            local fakeLSM = {
                List = function(_, mediaType)
                    if mediaType == "sound" then return { "Auction Chime Custom" } end
                    return {}
                end,
                Fetch = function(_, mediaType, key)
                    if mediaType == "sound" and key == "Auction Chime Custom" then
                        return "Interface\\AddOns\\Custom\\chime.ogg"
                    end
                    return nil
                end,
            }
            _G.LibStub = function(name)
                if name == "LibSharedMedia-3.0" then return fakeLSM end
                return nil
            end

            local sounds = ns.GetAvailableSounds()
            local foundCustom = false
            for _, s in ipairs(sounds) do
                if s.key == "Auction Chime Custom" and not s.isBuiltin then
                    foundCustom = true
                end
            end
            assert.is_true(foundCustom)

            local selectedKey, selectedInfo = ns.SetSoundChoice("Auction Chime Custom")
            assert.are.equal("Auction Chime Custom", selectedKey)
            assert.are.equal("Interface\\AddOns\\Custom\\chime.ogg", selectedInfo.lsmPath)
            assert.are.equal("Interface\\AddOns\\Custom\\chime.ogg", playedFile)
        end)
    end)

    describe("Theme 2: Multi-Alt Reagent Hub & Mailbox Expiration Watcher (#63)", function()
        it("scans character bags & mail and aggregates realm-wide alt inventory + 3-day expiry alerts", function()
            _G.C_Container = {
                GetContainerNumSlots = function(bag) return (bag == 0) and 2 or 0 end,
                GetContainerItemInfo = function(bag, slot)
                    if bag == 0 and slot == 1 then
                        return { itemID = 13464, stackCount = 12 }
                    end
                    return nil
                end,
            }
            local bags = ns.ScanCharacterBags()
            assert.are.equal(12, bags[13464])

            _G.GetInboxNumItems = function() return 1 end
            _G.GetInboxHeaderInfo = function(_idx)
                return nil, nil, "Auction House", "Auction won", 0, 0, 2.2, true
            end
            _G.GetInboxItemLink = function(_idx, attachIdx)
                if attachIdx == 1 then return "|cff1eff00|Hitem:13464::::::::60:::::|h[Golden Sansam]|h|r" end
                return nil
            end
            _G.GetInboxItem = function(_idx, attachIdx)
                if attachIdx == 1 then return "Golden Sansam", 13464, 134400, 8 end
                return nil
            end

            local mailCounts = ns.ScanCharacterMail()
            assert.are.equal(8, mailCounts[13464])

            -- Seed an alt character on the same realm
            ns.db.realms["TestRealm"].characters["AltBanker"] = {
                faction = "Horde",
                class = "MAGE",
                bags = { [13464] = 5 },
                bank = { [13464] = 20 },
                mail = {},
                mailEarliestExpiry = 1.5,
                mailExpiringCount = 2,
                lastScanned = GetServerTime(),
                lastMailScanned = GetServerTime(),
            }

            local total, rows = ns.GetAltItemBreakdown(13464)
            assert.are.equal(45, total) -- Tester (12 bag + 8 mail = 20) + AltBanker (5 bag + 20 bank = 25)
            assert.are.equal(2, #rows)

            local warnings = ns.CheckAltMailExpirations(3)
            assert.are.equal(2, #warnings)
            assert.are.equal("AltBanker", warnings[1].charName)
        end)
    end)
end)
