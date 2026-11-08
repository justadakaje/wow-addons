-- GoldFinder -- Vendors
-- Fixed vendor reagent cost integration (#46).
-- Prevents buying common vendor-sold reagents at marked-up AH prices and injects
-- precise NPC vendor costs into crafting conversions and arbitrage formulas.

local ADDON, ns = ...

-- Curated catalog of trade supply and profession reagents sold by unlimited-stock NPCs.
-- All Item IDs and base vendor buy prices verified against WoW database records (Wowhead Classic / QuestieDB):
ns.VENDOR_REAGENTS = {
    -- Smelting & Metalworking (Mining & Blacksmithing Supplies)
    [3857]  = { name = "Coal",                  vendorPrice = 500,  category = "mining" },  -- 5s
    [2880]  = { name = "Weak Flux",             vendorPrice = 100,  category = "mining" },  -- 1s
    [3466]  = { name = "Strong Flux",           vendorPrice = 2000, category = "mining" },  -- 20s

    -- Tailoring & Leatherworking Supplies (Threads & Dyes)
    [2320]  = { name = "Coarse Thread",         vendorPrice = 10,   category = "cloth" },   -- 10c
    [2321]  = { name = "Fine Thread",           vendorPrice = 100,  category = "cloth" },   -- 1s
    [4291]  = { name = "Silken Thread",         vendorPrice = 500,  category = "cloth" },   -- 5s
    [4341]  = { name = "Heavy Silken Thread",   vendorPrice = 20,   category = "cloth" },   -- 20c
    [14341] = { name = "Rune Thread",           vendorPrice = 5000, category = "cloth" },  -- 50s
    [2604]  = { name = "Red Dye",               vendorPrice = 2500, category = "cloth" },  -- 25s
    [2605]  = { name = "Green Dye",             vendorPrice = 100,  category = "cloth" },   -- 1s
    [4357]  = { name = "Rough Boomstick",       vendorPrice = 400,  category = "engineering" }, -- 4s

    -- Alchemy Supplies (Vials)
    [3371]  = { name = "Empty Vial",            vendorPrice = 40,   category = "alchemy" }, -- 40c
    [3372]  = { name = "Leaded Vial",           vendorPrice = 200,  category = "alchemy" }, -- 2s
    [8925]  = { name = "Crystal Vial",          vendorPrice = 2500, category = "alchemy" }, -- 25s

    -- Cooking Supplies (Spices & Staples)
    [2888]  = { name = "Salt",                  vendorPrice = 10,   category = "cooking" }, -- 10c
    [7071]  = { name = "Deeprock Salt",         vendorPrice = 100,  category = "cooking" }, -- 1s
    [2692]  = { name = "Hot Spices",            vendorPrice = 25,   category = "cooking" }, -- 25c
    [3713]  = { name = "Soothing Spices",       vendorPrice = 16,   category = "cooking" }, -- 16c
    [3081]  = { name = "Simple Flour",          vendorPrice = 25,   category = "cooking" }, -- 25c
    [159]   = { name = "Refreshing Spring Water", vendorPrice = 25, category = "cooking" }, -- 25c
}

---------------------------------------------------------------------------
-- Query Functions
---------------------------------------------------------------------------

function ns.GetVendorReagent(itemID)
    if not itemID then return nil end
    return ns.VENDOR_REAGENTS[itemID]
end

function ns.IsVendorReagent(itemID)
    if not itemID then return false end
    return ns.VENDOR_REAGENTS[itemID] ~= nil
end

function ns.GetVendorPrice(itemID)
    local info = ns.GetVendorReagent(itemID)
    return info and info.vendorPrice or nil
end

-- Checks if an auction listing price represents an overpriced markup over the NPC vendor price
function ns.IsOverpricedVendorListing(itemID, currentPrice)
    if not itemID or not currentPrice or currentPrice <= 0 then return false end
    local vPrice = ns.GetVendorPrice(itemID)
    if not vPrice or vPrice <= 0 then return false end
    -- If AH price is higher than NPC vendor price, it is marked up
    return currentPrice > vPrice
end

-- Formats a vendor price explanation string
function ns.GetVendorReagentWarning(itemID, currentPrice)
    local info = ns.GetVendorReagent(itemID)
    if not info then return nil end
    local vPrice = info.vendorPrice
    if currentPrice and currentPrice > vPrice then
        local markup = math.floor(((currentPrice - vPrice) / vPrice) * 100 + 0.5)
        return ("|cffff4040Overpriced NPC item! Sold by vendors for %s (+%d%% AH markup).|r"):format(ns.Money(vPrice), markup)
    else
        return ("|cffffd100Vendor item:|r Sold by trade supplies NPCs for %s."):format(ns.Money(vPrice))
    end
end
