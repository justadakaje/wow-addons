-- config_spec.lua -- Unit tests for GoldFinder Hybrid Configuration Architecture (#58)

local helper = require("addons.GoldFinder.tests.test_helper")

describe("GoldFinder Hybrid Configuration Architecture (#58)", function()
    local ns

    before_each(function()
        helper.reset()
        _G.AuctionHouseFrame = nil
        _G.AuctionFrame = nil
        _G.Settings = nil
        _G.SettingsPanel = nil
        helper.lastAddedCategory = nil
        helper.lastOpenedCategory = nil

        ns = helper.createNamespace()
        helper.loadAddonFile("Core.lua", ns)
        helper.loadAddonFile("Config.lua", ns)
    end)

    it("registers Blizzard Settings canvas layout category on ADDON_LOADED", function()
        -- Simulate ADDON_LOADED event
        for _, f in ipairs(helper.createdFrames) do
            if f.IsEventRegistered and f:IsEventRegistered("ADDON_LOADED") then
                f:FireEvent("ADDON_LOADED", "GoldFinder")
            end
        end

        assert.is_not_nil(ns.blizzardSettingsPanel)
        assert.are.equal("GoldFinder", ns.blizzardSettingsPanel.name)
        assert.are.equal(ns.blizzardSettingsPanel, helper.lastAddedCategory)
    end)

    it("creates and displays the standalone floating config frame on OpenStandaloneConfig", function()
        local frame = ns.OpenStandaloneConfig()
        assert.is_not_nil(frame)
        assert.is_true(frame:IsShown())
        assert.are.equal("GoldFinderConfigFrame", frame.name)
    end)

    it("opens standalone window when Auction House is open to avoid AUCTION_HOUSE_CLOSED", function()
        -- Mock active Auction House session
        local mockAH = CreateFrame("Frame", "AuctionHouseFrame")
        mockAH:Show()
        _G.AuctionHouseFrame = mockAH

        local opened = ns.OpenConfig()
        assert.is_not_nil(opened)
        assert.are.equal("GoldFinderConfigFrame", opened.name)
        assert.is_true(opened:IsShown())
        -- Blizzard settings should NOT have been opened
        assert.is_nil(helper.lastOpenedCategory)
    end)

    it("opens Blizzard Settings category directly when invoked away from Auction House", function()
        -- AH is closed/nil
        _G.AuctionHouseFrame = nil
        _G.AuctionFrame = nil

        -- Fire ADDON_LOADED to register settings
        for _, f in ipairs(helper.createdFrames) do
            if f.IsEventRegistered and f:IsEventRegistered("ADDON_LOADED") then
                f:FireEvent("ADDON_LOADED", "GoldFinder")
            end
        end

        local opened = ns.OpenConfig()
        assert.is_true(opened)
        assert.are.equal(ns.blizzardSettingsPanel, helper.lastOpenedCategory)
    end)

    it("supports explicit mode overrides ('standalone' vs 'blizzard')", function()
        -- Fire ADDON_LOADED to register settings
        for _, f in ipairs(helper.createdFrames) do
            if f.IsEventRegistered and f:IsEventRegistered("ADDON_LOADED") then
                f:FireEvent("ADDON_LOADED", "GoldFinder")
            end
        end

        -- Explicit standalone even when AH is closed
        _G.AuctionHouseFrame = nil
        local frame = ns.OpenConfig("standalone")
        assert.is_not_nil(frame)
        assert.are.equal("GoldFinderConfigFrame", frame.name)

        -- Explicit blizzard even when AH is open
        local mockAH = CreateFrame("Frame", "AuctionHouseFrame")
        mockAH:Show()
        _G.AuctionHouseFrame = mockAH

        local blizzardOpened = ns.OpenConfig("blizzard")
        assert.is_true(blizzardOpened)
        assert.are.equal(ns.blizzardSettingsPanel, helper.lastOpenedCategory)
    end)

    it("synchronizes settings between standalone and embedded control sets", function()
        -- Fire ADDON_LOADED to initialize embedded panel
        for _, f in ipairs(helper.createdFrames) do
            if f.IsEventRegistered and f:IsEventRegistered("ADDON_LOADED") then
                f:FireEvent("ADDON_LOADED", "GoldFinder")
            end
        end

        -- Initialize standalone frame
        local standalone = ns.OpenStandaloneConfig()
        assert.is_not_nil(standalone)

        -- Change discount threshold via API
        ns.SetDealRatio(0.60) -- 40% discount
        ns.RefreshControls()

        -- Verify deal ratio updated
        assert.are.equal(0.60, ns.GetDealRatio())
    end)
end)
