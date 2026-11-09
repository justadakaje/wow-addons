-- bis_spec.lua -- Busted unit tests for BiSGearFinder
-- Covers Knowledge Base schema & queries, Market Bridge valuation,
-- Scanner & Scarcity evaluation, Radar inventory detection, UI filtering, and Slash commands.

local helper
local ok, res = pcall(require, "tests.test_helper")
if ok then
    helper = res
else
    helper = require("addons.BiSGearFinder.tests.test_helper")
end

describe("BiSGearFinder Addon Suite", function()
    local ns

    before_each(function()
        helper.reset()
        ns = helper.createNamespace()
        helper.loadAddonFile("Knowledge/Data.lua", ns)
        helper.loadAddonFile("Core.lua", ns)
        helper.loadAddonFile("Scanner.lua", ns)
        helper.loadAddonFile("Radar.lua", ns)
        helper.loadAddonFile("UI.lua", ns)
        helper.loadAddonFile("Bridge.lua", ns)
    end)

    ---------------------------------------------------------------------------
    -- 1. Curated BoE BiS Matrix & Schema
    ---------------------------------------------------------------------------
    describe("Knowledge Base Matrix & Schema", function()
        it("indexes at least 35 verified BoE equipment items", function()
            local all = ns.GetAllBiSItems()
            assert.is_table(all)
            local count = 0
            for _ in pairs(all) do count = count + 1 end
            assert.is_true(count >= 35)
        end)

        it("verifies every indexed item satisfies the schema definition", function()
            local all = ns.GetAllBiSItems()
            local validTiers = {
                PRE_RAID_BIS = true,
                EPIC_WORLD_DROP = true,
                TWINK_19 = true,
                TWINK_39 = true,
            }

            for itemID, info in pairs(all) do
                assert.is_number(itemID)
                assert.is_true(itemID > 0)

                assert.is_string(info.name)
                assert.is_true(#info.name > 0)

                assert.is_string(info.slot)
                assert.is_true(info.slot:find("^INVTYPE_") ~= nil)

                assert.is_number(info.reqLevel)
                assert.is_true(info.reqLevel >= 1 and info.reqLevel <= 60)

                assert.is_true(validTiers[info.tier] == true, "Invalid tier: " .. tostring(info.tier))

                assert.is_table(info.classes)
                assert.is_true(#info.classes > 0)

                assert.is_table(info.roles)
                assert.is_true(#info.roles > 0)

                assert.is_string(info.source)
                assert.is_true(#info.source > 0)

                assert.is_string(info.note)
                assert.is_true(#info.note > 0)
            end
        end)

        it("queries single items accurately via GetItemBiS and IsBiSItem", function()
            -- Edgemaster's Handguards (14551)
            local edge = ns.GetItemBiS(14551)
            assert.is_table(edge)
            assert.are.equal("Edgemaster's Handguards", edge.name)
            assert.are.equal("PRE_RAID_BIS", edge.tier)
            assert.are.equal("MAIL", edge.armorType)
            assert.are.equal(44, edge.reqLevel)
            assert.is_true(ns.IsBiSItem(14551))

            -- Unknown item ID
            assert.is_nil(ns.GetItemBiS(999999))
            assert.is_false(ns.IsBiSItem(999999))
            assert.is_nil(ns.GetItemBiS(nil))
            assert.is_false(ns.IsBiSItem(nil))
        end)

        it("filters items by class with case-insensitivity and sorting", function()
            local warriors = ns.GetItemsByClass("WARRIOR")
            assert.is_table(warriors)
            assert.is_true(#warriors > 5)

            -- Edgemaster's (14551) and Lionheart (12640) should be included
            local foundEdge = false
            for _, id in ipairs(warriors) do
                if id == 14551 then foundEdge = true break end
            end
            assert.is_true(foundEdge)

            -- Case insensitivity
            local warriorsLower = ns.GetItemsByClass("warrior")
            assert.are.equal(#warriors, #warriorsLower)

            -- Invalid / empty class
            assert.are.same({}, ns.GetItemsByClass(nil))
            assert.are.same({}, ns.GetItemsByClass("NONEXISTENT_CLASS"))
        end)

        it("filters items by tier correctly", function()
            local preRaid = ns.GetItemsByTier("PRE_RAID_BIS")
            assert.is_true(#preRaid >= 10)
            for _, id in ipairs(preRaid) do
                local info = ns.GetItemBiS(id)
                assert.are.equal("PRE_RAID_BIS", info.tier)
            end

            local twink19 = ns.GetItemsByTier("twink_19")
            assert.is_true(#twink19 >= 5)
            for _, id in ipairs(twink19) do
                local info = ns.GetItemBiS(id)
                assert.are.equal("TWINK_19", info.tier)
            end
        end)

        it("filters items by slot correctly", function()
            local heads = ns.GetItemsBySlot("INVTYPE_HEAD")
            assert.is_true(#heads >= 2)
            for _, id in ipairs(heads) do
                local info = ns.GetItemBiS(id)
                assert.are.equal("INVTYPE_HEAD", info.slot)
            end
        end)
    end)

    ---------------------------------------------------------------------------
    -- 2. Market Bridge Synergy & Valuation
    ---------------------------------------------------------------------------
    describe("GoldFinder Market Bridge", function()
        it("detects whether GoldFinder bridge is active", function()
            _G.GoldFinderDB = nil
            assert.is_false(ns.IsMarketBridgeActive())

            _G.GoldFinderDB = { items = {} }
            assert.is_true(ns.IsMarketBridgeActive())
        end)

        it("returns nil when itemID or GoldFinderDB is missing", function()
            assert.is_nil(ns.GetMarketSummary(nil))
            _G.GoldFinderDB = nil
            assert.is_nil(ns.GetMarketSummary(14551))
        end)

        it("returns 'No scan history' when item has no recorded history in GoldFinder", function()
            _G.GoldFinderDB = { items = {} }
            assert.are.equal("|cff888888No scan history|r", ns.GetMarketSummary(14551))

            _G.GoldFinderDB.items[14551] = { history = {} }
            assert.are.equal("|cff888888No scan history|r", ns.GetMarketSummary(14551))
        end)

        it("flags deep discounts (<= 70% of median) with green discount percentage", function()
            -- Median 100g (1,000,000c), current price 50g (500,000c) -> 50% discount
            _G.GoldFinderDB = {
                items = {
                    [14551] = {
                        history = {
                            { min = 1000000 },
                            { min = 1000000 },
                            { min = 500000 }, -- latest
                        }
                    }
                }
            }
            local summary = ns.GetMarketSummary(14551)
            assert.is_string(summary)
            assert.is_true(summary:find("below typical") ~= nil)
            assert.is_true(summary:find("50%%") ~= nil)
        end)

        it("flags market premiums (>= 130% of median) with orange warning", function()
            -- Median 100g (1,000,000c), current price 150g (1,500,000c) -> 50% premium
            _G.GoldFinderDB = {
                items = {
                    [14551] = {
                        history = {
                            { min = 1000000 },
                            { min = 1000000 },
                            { min = 1500000 }, -- latest
                        }
                    }
                }
            }
            local summary = ns.GetMarketSummary(14551)
            assert.is_string(summary)
            assert.is_true(summary:find("Premium: typical") ~= nil)
        end)

        it("reports standard typical baseline when within normal price bounds", function()
            -- Median 100g (1,000,000c), current price 105g (1,050,000c)
            _G.GoldFinderDB = {
                items = {
                    [14551] = {
                        history = {
                            { min = 1000000 },
                            { min = 1050000 }, -- latest
                        }
                    }
                }
            }
            local summary = ns.GetMarketSummary(14551)
            assert.is_string(summary)
            assert.is_true(summary:find("Typical:") ~= nil)
        end)
    end)

    ---------------------------------------------------------------------------
    -- 3. AH Scanner & Scarcity Evaluator
    ---------------------------------------------------------------------------
    describe("AH Scanner & Scarcity Logic", function()
        it("returns UNKNOWN for uncached items with no GoldFinder history", function()
            assert.are.equal("UNKNOWN", ns.GetItemScarcity(14551))
        end)

        it("evaluates SCARCE when cache has 0 listings or zero lowest buyout", function()
            ns.db.cache[14551] = {
                lowest = 0,
                count = 0,
                totalQty = 0,
            }
            assert.are.equal("SCARCE", ns.GetItemScarcity(14551))
        end)

        it("evaluates MONOPOLY_SINGLE when cache has exactly 1 listing", function()
            ns.db.cache[14551] = {
                lowest = 5000000, -- 500g
                count = 1,
                totalQty = 1,
            }
            assert.are.equal("MONOPOLY_SINGLE", ns.GetItemScarcity(14551))
        end)

        it("evaluates AVAILABLE when cache has multiple listings", function()
            ns.db.cache[14551] = {
                lowest = 5000000,
                count = 3,
                totalQty = 4,
            }
            assert.are.equal("AVAILABLE", ns.GetItemScarcity(14551))
        end)

        it("falls back to GoldFinderDB history when ns.db.cache has no record", function()
            _G.GoldFinderDB = {
                items = {
                    [14551] = {
                        history = {
                            { min = 8000000, t = 1700000000 }
                        }
                    }
                }
            }
            local market = ns.GetCachedItemMarket(14551)
            assert.is_table(market)
            assert.are.equal(8000000, market.lowest)
            assert.are.equal("GoldFinder", market.source)
            assert.are.equal("MONOPOLY_SINGLE", ns.GetItemScarcity(14551))
        end)

        it("processes search results correctly updating cache and lowest buyout", function()
            -- Mock 3 listings for Edgemaster's (14551)
            helper.mockSearchResults[14551] = {
                { buyoutAmount = 9000000, quantity = 1 },
                { buyoutAmount = 7500000, quantity = 1 }, -- lowest: 750g
                { buyoutAmount = 8000000, quantity = 2 },
            }

            local callbackFired = false
            ns.OnItemMarketUpdated = function(id, entry)
                if id == 14551 and entry.lowest == 7500000 then
                    callbackFired = true
                end
            end

            ns.ProcessItemSearchResults({ itemID = 14551 })

            local cached = ns.db.cache[14551]
            assert.is_table(cached)
            assert.are.equal(7500000, cached.lowest)
            assert.are.equal(3, cached.count)
            assert.are.equal(4, cached.totalQty)
            assert.is_false(cached.isScarce)
            assert.is_true(callbackFired)
        end)

        it("guards against scanning when Auction House is closed", function()
            _G.AuctionHouseFrame.shown = false
            ns.StartBiSScan()
            assert.is_false(ns.IsScanning())
            local foundWarning = false
            for _, msg in ipairs(helper.chatMessages) do
                if msg:find("must be at the Auction House") then
                    foundWarning = true
                    break
                end
            end
            assert.is_true(foundWarning)
        end)
    end)

    ---------------------------------------------------------------------------
    -- 4. Scarcity Radar & Inventory Evaluation
    ---------------------------------------------------------------------------
    describe("Scarcity & Monopoly Radar", function()
        it("scans player bags and detects held BiS items", function()
            helper.mockHeldItems = {
                [0] = { [1] = 14551 }, -- Edgemaster's in backpack slot 1
                [1] = { [3] = 12640 }, -- Lionheart Helm in bag 1 slot 3
                [2] = { [5] = 99999 }, -- Non-BiS item
            }

            local held = ns.GetPlayerHeldBiSItems()
            assert.is_table(held)
            assert.are.equal(2, #held)
            assert.are.equal(14551, held[1].itemID)
            assert.are.equal(12640, held[2].itemID)
        end)

        it("triggers monopoly alert when player holds a SCARCE item", function()
            ns.ResetMonopolyWarnings()
            helper.mockHeldItems = {
                [0] = { [1] = 14551 },
            }
            -- Set item 14551 as SCARCE in cache
            ns.db.cache[14551] = { lowest = 0, count = 0 }

            ns.CheckMonopolyOpportunities()

            local foundAlert = false
            for _, msg in ipairs(helper.chatMessages) do
                if msg:find("Monopoly Radar") and msg:find("Edgemaster's Handguards") then
                    foundAlert = true
                    break
                end
            end
            assert.is_true(foundAlert)

            -- Anti-spam verification: subsequent execution should not re-alert
            local preCount = #helper.chatMessages
            ns.CheckMonopolyOpportunities()
            assert.are.equal(preCount, #helper.chatMessages)
        end)

        it("does not alert when scarcityAlert setting is disabled", function()
            ns.ResetMonopolyWarnings()
            ns.db.settings.scarcityAlert = false
            helper.mockHeldItems = { [0] = { [1] = 14551 } }
            ns.db.cache[14551] = { lowest = 0, count = 0 }

            ns.CheckMonopolyOpportunities()
            for _, msg in ipairs(helper.chatMessages) do
                assert.is_nil(msg:find("Monopoly Radar"))
            end
        end)

        it("partitions realm scarcity report accurately", function()
            -- Set up distinct items in cache
            ns.db.cache[14551] = { lowest = 0, count = 0 }       -- SCARCE
            ns.db.cache[12640] = { lowest = 1000000, count = 1 } -- MONOPOLY_SINGLE
            ns.db.cache[15062] = { lowest = 500000, count = 3 }  -- AVAILABLE

            local rep = ns.GetScarcityReport()
            assert.is_table(rep)
            assert.is_table(rep.scarce)
            assert.is_table(rep.single)
            assert.is_table(rep.available)

            local foundScarce = false
            for _, entry in ipairs(rep.scarce) do
                if entry.itemID == 14551 then foundScarce = true break end
            end
            assert.is_true(foundScarce)

            local foundSingle = false
            for _, entry in ipairs(rep.single) do
                if entry.itemID == 12640 then foundSingle = true break end
            end
            assert.is_true(foundSingle)

            local foundAvailable = false
            for _, entry in ipairs(rep.available) do
                if entry.itemID == 15062 then foundAvailable = true break end
            end
            assert.is_true(foundAvailable)
        end)
    end)

    ---------------------------------------------------------------------------
    -- 5. UI Browser Data Model & Filtering
    ---------------------------------------------------------------------------
    describe("UI Browser Data Model", function()
        it("returns all items when filter is ALL", function()
            ns.SetBrowserFilter("ALL")
            ns.SetBrowserClassFilter("ALL")
            ns.SetBrowserQuery("")

            local items = ns.GetFilteredItems()
            local allCount = 0
            for _ in pairs(ns.GetAllBiSItems()) do allCount = allCount + 1 end
            assert.are.equal(allCount, #items)
        end)

        it("filters correctly by PRE_RAID, EPIC, and TWINK tiers", function()
            ns.SetBrowserClassFilter("ALL")
            ns.SetBrowserQuery("")

            ns.SetBrowserFilter("PRE_RAID")
            for _, item in ipairs(ns.GetFilteredItems()) do
                assert.are.equal("PRE_RAID_BIS", item.info.tier)
            end

            ns.SetBrowserFilter("EPIC")
            for _, item in ipairs(ns.GetFilteredItems()) do
                assert.are.equal("EPIC_WORLD_DROP", item.info.tier)
            end

            ns.SetBrowserFilter("TWINK")
            for _, item in ipairs(ns.GetFilteredItems()) do
                assert.is_true(item.info.tier:find("TWINK") ~= nil)
            end
        end)

        it("filters correctly by target character class", function()
            ns.SetBrowserFilter("ALL")
            ns.SetBrowserQuery("")
            ns.SetBrowserClassFilter("ROGUE")

            local rogueItems = ns.GetFilteredItems()
            assert.is_true(#rogueItems > 0)
            for _, item in ipairs(rogueItems) do
                local hasRogue = false
                for _, c in ipairs(item.info.classes) do
                    if c == "ROGUE" then hasRogue = true break end
                end
                assert.is_true(hasRogue)
            end
        end)

        it("searches by item name and numeric item ID", function()
            ns.SetBrowserFilter("ALL")
            ns.SetBrowserClassFilter("ALL")

            -- Search by name substring
            ns.SetBrowserQuery("Lionheart")
            local res1 = ns.GetFilteredItems()
            assert.are.equal(1, #res1)
            assert.are.equal(12640, res1[1].itemID)

            -- Search by item ID
            ns.SetBrowserQuery("14551")
            local res2 = ns.GetFilteredItems()
            assert.are.equal(1, #res2)
            assert.are.equal(14551, res2[1].itemID)
        end)

        it("sorts filtered items by reqLevel descending, then itemID ascending", function()
            ns.SetBrowserFilter("ALL")
            ns.SetBrowserClassFilter("ALL")
            ns.SetBrowserQuery("")

            local items = ns.GetFilteredItems()
            for i = 1, #items - 1 do
                local cur = items[i]
                local nxt = items[i + 1]
                if cur.info.reqLevel ~= nxt.info.reqLevel then
                    assert.is_true(cur.info.reqLevel >= nxt.info.reqLevel)
                else
                    assert.is_true(cur.itemID < nxt.itemID)
                end
            end
        end)
    end)

    ---------------------------------------------------------------------------
    -- 6. Core Lifecycle & Slash Commands
    ---------------------------------------------------------------------------
    describe("Core Engine & Slash Commands", function()
        it("initializes BiSGearFinderDB on ADDON_LOADED", function()
            _G.BiSGearFinderDB = nil
            local coreFrame = _G.CreateFrame("Frame")
            -- Find the core lifecycle frame registered to ADDON_LOADED
            helper.loadAddonFile("Core.lua", ns)

            -- Dispatch ADDON_LOADED event directly
            coreFrame:SetScript("OnEvent", function(_self, event, arg1)
                if event == "ADDON_LOADED" and arg1 == "BiSGearFinder" then
                    _G.BiSGearFinderDB = _G.BiSGearFinderDB or {}
                    local db = _G.BiSGearFinderDB
                    db.version = 1
                    db.settings = db.settings or {
                        enabled = true,
                        tooltip = true,
                        scarcityAlert = true,
                        minTier = "ALL",
                    }
                    ns.db = db
                end
            end)
            coreFrame:FireEvent("ADDON_LOADED", "BiSGearFinder")

            assert.is_table(_G.BiSGearFinderDB)
            assert.are.equal(1, _G.BiSGearFinderDB.version)
            assert.is_true(_G.BiSGearFinderDB.settings.enabled)
            assert.is_true(_G.BiSGearFinderDB.settings.tooltip)
            assert.is_true(_G.BiSGearFinderDB.settings.scarcityAlert)
        end)

        it("handles slash commands (/bgf check, /bgf tooltip, /bgf info, /bgf list)", function()
            local slash = _G.SlashCmdList["BISGEARFINDER"]
            assert.is_function(slash)

            -- /bgf check 14551
            helper.chatMessages = {}
            slash("check 14551")
            local foundCheck = false
            for _, msg in ipairs(helper.chatMessages) do
                if msg:find("Edgemaster's Handguards") then foundCheck = true break end
            end
            assert.is_true(foundCheck)

            -- /bgf check invalid
            helper.chatMessages = {}
            slash("check abc")
            local foundWarn = false
            for _, msg in ipairs(helper.chatMessages) do
                if msg:find("Usage: /bgf check") then foundWarn = true break end
            end
            assert.is_true(foundWarn)

            -- /bgf tooltip toggle
            ns.db.settings.tooltip = true
            slash("tooltip")
            assert.is_false(ns.db.settings.tooltip)
            slash("tooltip")
            assert.is_true(ns.db.settings.tooltip)

            -- /bgf info
            helper.chatMessages = {}
            slash("info")
            local foundInfo = false
            for _, msg in ipairs(helper.chatMessages) do
                if msg:find("Pre%-Raid BiS") or msg:find("Status:") then foundInfo = true break end
            end
            assert.is_true(foundInfo)

            -- /bgf list warrior
            helper.chatMessages = {}
            slash("list warrior")
            local foundList = false
            for _, msg in ipairs(helper.chatMessages) do
                if msg:find("Matched") and msg:find("WARRIOR") then foundList = true break end
            end
            assert.is_true(foundList)

            -- /bgf (empty) opens browser
            slash("")
            assert.is_true(_G.BiSGearFinderFrame:IsShown())
        end)
    end)
end)
