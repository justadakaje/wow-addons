-- cart_spec.lua -- Unit tests for GoldFinder cart operations

local helper
local ok, res = pcall(require, "tests.test_helper")
if ok then
    helper = res
else
    helper = require("addons.GoldFinder.tests.test_helper")
end

describe("GoldFinder Cart Operations", function()
    local ns

    before_each(function()
        helper.reset()
        ns = helper.createNamespace()
        helper.loadAddonFile("Core.lua", ns)
        helper.loadAddonFile("Cart.lua", ns)
    end)

    it("starts with an empty cart and zero totals", function()
        local count, totalItems, totalCost, totalProfit = ns.GetCartTotals()
        assert.are.equal(0, count)
        assert.are.equal(0, totalItems)
        assert.are.equal(0, totalCost)
        assert.are.equal(0, totalProfit)
    end)

    it("adds items to cart and computes totals", function()
        local deal1 = {
            itemID = 2770, -- Copper Ore
            name = "Copper Ore",
            now = 50, -- 50c
            netUnitProfit = 25,
            qty = 20,
        }
        local added = ns.AddToCart(deal1, 20)
        assert.is_true(added)

        local count, totalItems, totalCost, totalProfit = ns.GetCartTotals()
        assert.are.equal(1, count)
        assert.are.equal(20, totalItems)
        assert.are.equal(1000, totalCost) -- 20 * 50
        assert.are.equal(500, totalProfit) -- 20 * 25
    end)

    it("stacks quantity and recalculates totals when adding duplicate item", function()
        local deal = {
            itemID = 2770,
            name = "Copper Ore",
            now = 50,
            netUnitProfit = 25,
        }

        ns.AddToCart(deal, 10)
        ns.AddToCart(deal, 15)

        local count, totalItems, totalCost, totalProfit = ns.GetCartTotals()
        assert.are.equal(1, count)
        assert.are.equal(25, totalItems)
        assert.are.equal(1250, totalCost)
        assert.are.equal(625, totalProfit)
    end)

    it("removes items and clears the cart", function()
        local deal1 = { itemID = 100, name = "Item 1", now = 10, netUnitProfit = 5 }
        local deal2 = { itemID = 200, name = "Item 2", now = 20, netUnitProfit = 10 }

        ns.AddToCart(deal1, 1)
        ns.AddToCart(deal2, 1)
        assert.are.equal(2, #ns.GetCart())

        -- Remove first item
        local removed = ns.RemoveFromCart(1)
        assert.is_true(removed)
        assert.are.equal(1, #ns.GetCart())
        assert.are.equal(200, ns.GetCart()[1].itemID)

        -- Clear remaining items
        ns.ClearCart()
        assert.are.equal(0, #ns.GetCart())
    end)
end)
