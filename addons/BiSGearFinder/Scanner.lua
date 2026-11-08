-- BiSGearFinder -- Scanner
-- Targeted Auction House scanner and passive market observer for tracked BiS items.
-- Queries C_AuctionHouse for curated BoE equipment and caches current buyouts and scarcity.

local ADDON, ns = ...

ns.Scanner = ns.Scanner or {}

local isScanning = false
local scanQueue = {}
local queueIndex = 1

---------------------------------------------------------------------------
-- Cache Accessors
---------------------------------------------------------------------------

function ns.GetCachedItemMarket(itemID)
    if not itemID then return nil end
    local cache = ns.db and ns.db.cache and ns.db.cache[itemID]
    if cache then return cache end

    -- Fallback to GoldFinderDB if present
    if GoldFinderDB and GoldFinderDB.items and GoldFinderDB.items[itemID] then
        local rec = GoldFinderDB.items[itemID]
        local latest = rec.history and rec.history[#rec.history]
        if latest then
            return {
                lowest   = latest.min,
                count    = 1,
                totalQty = 1,
                seen     = latest.t or 0,
                source   = "GoldFinder",
            }
        end
    end
    return nil
end

function ns.GetItemScarcity(itemID)
    local m = ns.GetCachedItemMarket(itemID)
    if not m then return "UNKNOWN" end
    if not m.count or m.count == 0 or not m.lowest or m.lowest <= 0 then
        return "SCARCE"
    elseif m.count == 1 then
        return "MONOPOLY_SINGLE"
    else
        return "AVAILABLE"
    end
end

---------------------------------------------------------------------------
-- Query Execution & Event Handling
---------------------------------------------------------------------------

local scanFrame = CreateFrame("Frame")
scanFrame:RegisterEvent("ITEM_SEARCH_RESULTS_UPDATED")
scanFrame:RegisterEvent("AUCTION_HOUSE_CLOSED")

local function ProcessItemSearchResults(itemKey)
    if not itemKey or not itemKey.itemID then return end
    local itemID = itemKey.itemID
    if not ns.IsBiSItem(itemID) then return end

    if not (C_AuctionHouse and C_AuctionHouse.GetNumItemSearchResults and C_AuctionHouse.GetItemSearchResultInfo) then
        return
    end

    local numResults = C_AuctionHouse.GetNumItemSearchResults(itemKey) or 0
    local lowestBuyout = nil
    local totalQty = 0

    for i = 1, numResults do
        local info = C_AuctionHouse.GetItemSearchResultInfo(itemKey, i)
        if info and info.buyoutAmount and info.buyoutAmount > 0 then
            if not lowestBuyout or info.buyoutAmount < lowestBuyout then
                lowestBuyout = info.buyoutAmount
            end
            totalQty = totalQty + (info.quantity or 1)
        end
    end

    ns.db = ns.db or BiSGearFinderDB or {}
    ns.db.cache = ns.db.cache or {}

    local entry = {
        lowest   = lowestBuyout or 0,
        count    = numResults,
        totalQty = totalQty,
        seen     = (GetServerTime and GetServerTime()) or time(),
        isScarce = (numResults == 0 or not lowestBuyout),
    }

    ns.db.cache[itemID] = entry

    -- Fire callbacks or update UI if open
    if ns.OnItemMarketUpdated then
        ns.OnItemMarketUpdated(itemID, entry)
    end
end

scanFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ITEM_SEARCH_RESULTS_UPDATED" then
        ProcessItemSearchResults(arg1)
    elseif event == "AUCTION_HOUSE_CLOSED" then
        isScanning = false
        scanQueue = {}
    end
end)

---------------------------------------------------------------------------
-- Batch & Queue Scanning
---------------------------------------------------------------------------

local function StepQueue()
    if not isScanning or queueIndex > #scanQueue then
        isScanning = false
        ns.Good("BiS scan complete (%d items queried).", #scanQueue)
        if ns.RefreshUI then ns.RefreshUI() end
        return
    end

    local itemID = scanQueue[queueIndex]
    queueIndex = queueIndex + 1

    if C_AuctionHouse and C_AuctionHouse.MakeItemKey and C_AuctionHouse.SendSearchQuery then
        local key = C_AuctionHouse.MakeItemKey(itemID)
        if key then
            pcall(C_AuctionHouse.SendSearchQuery, key, {}, false)
        end
    end

    -- Throttled step every 0.35s to respect Blizzard AH query throttle
    C_Timer.After(0.35, StepQueue)
end

function ns.StartBiSScan()
    if not (AuctionHouseFrame and AuctionHouseFrame:IsShown()) then
        ns.Warn("You must be at the Auction House to scan BiS items.")
        return
    end

    if isScanning then
        ns.Warn("A BiS scan is already in progress.")
        return
    end

    local all = ns.GetAllBiSItems and ns.GetAllBiSItems() or {}
    scanQueue = {}
    for itemID in pairs(all) do
        scanQueue[#scanQueue + 1] = itemID
    end

    table.sort(scanQueue)

    -- Multi-key search optimization if client supports batching
    if C_AuctionHouse and C_AuctionHouse.SearchForItemKeys and C_AuctionHouse.MakeItemKey then
        local keys = {}
        for _, id in ipairs(scanQueue) do
            local k = C_AuctionHouse.MakeItemKey(id)
            if k then keys[#keys + 1] = k end
        end

        if #keys > 0 then
            local ok = pcall(C_AuctionHouse.SearchForItemKeys, keys, {})
            if ok then
                ns.Print("Scanning %d BiS BoE items via batch query...", #keys)
                isScanning = true
                C_Timer.After(2.5, function()
                    isScanning = false
                    ns.Good("BiS batch scan processed.")
                    if ns.RefreshUI then ns.RefreshUI() end
                end)
                return
            end
        end
    end

    -- Fallback to sequential throttled search
    isScanning = true
    queueIndex = 1
    ns.Print("Starting sequential scan of %d BiS BoE items...", #scanQueue)
    StepQueue()
end

function ns.IsScanning()
    return isScanning
end
