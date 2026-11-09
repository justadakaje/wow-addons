-- GoldFinder -- BuyHelper (#57)
-- Smart Buy Parity Advisor: real-time crafting parity comparison when browsing
-- or buying commodities at the Auction House. Detects whether it is cheaper
-- to buy raw materials and craft/smelt, or if finished goods are cheaper than raw materials.

local ADDON, ns = ...

local L = ns.L or setmetatable({}, { __index = function(_, k) return k end })

local helperCard = nil
local currentItemID = nil

function ns.IsBuyHelperEnabled()
    local s = ns.db and ns.db.settings
    if s and s.buyHelper ~= nil then return s.buyHelper end
    return true
end

function ns.SetBuyHelperEnabled(val)
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.buyHelper = val
    end
    if not val and helperCard then
        helperCard:Hide()
    end
end

function ns.GetCurrentBuyHelperItemID()
    return currentItemID
end

function ns.HideBuyHelper()
    if helperCard and helperCard:IsShown() then
        helperCard:Hide()
    end
    currentItemID = nil
end

---------------------------------------------------------------------------
-- Conversion Lookups
---------------------------------------------------------------------------

local outputToConv = {}
local reagentToConv = {}
local lookupsBuilt = false

local function BuildConversionLookups()
    if lookupsBuilt then return end
    lookupsBuilt = true

    local convs = ns.CONVERSIONS or {}
    for _, conv in ipairs(convs) do
        if conv.output and conv.output.itemID then
            outputToConv[conv.output.itemID] = conv
        end
        if conv.reagents then
            for _, r in ipairs(conv.reagents) do
                if r.itemID then
                    reagentToConv[r.itemID] = conv
                end
            end
        end
    end
end

---------------------------------------------------------------------------
-- Display State Check (Multi-Layered Mutual Exclusion)
---------------------------------------------------------------------------

local function IsBuyFrameActive()
    if not AuctionHouseFrame or not AuctionHouseFrame:IsVisible() then
        return false, "AuctionHouseFrame not visible"
    end

    -- Tab check: tab 1 is Blizzard's Buy tab
    local selectedTab = (PanelTemplates_GetSelectedTab and PanelTemplates_GetSelectedTab(AuctionHouseFrame))
        or AuctionHouseFrame.selectedTab
        or 0
    if selectedTab ~= 1 then
        return false, ("selectedTab=%s (not Buy tab 1)"):format(tostring(selectedTab))
    end

    -- Mutual exclusion: If any Sell frame or Auctions frame is currently visible on screen, we are NOT buying!
    if AuctionHouseFrame.CommoditiesSellFrame and AuctionHouseFrame.CommoditiesSellFrame:IsVisible() then
        return false, "CommoditiesSellFrame is visible"
    end
    if AuctionHouseFrame.ItemSellFrame and AuctionHouseFrame.ItemSellFrame:IsVisible() then
        return false, "ItemSellFrame is visible"
    end
    if AuctionHouseFrame.WoWTokenSellFrame and AuctionHouseFrame.WoWTokenSellFrame:IsVisible() then
        return false, "WoWTokenSellFrame is visible"
    end
    if AuctionHouseFrame.AuctionsFrame and AuctionHouseFrame.AuctionsFrame:IsVisible() then
        return false, "AuctionsFrame is visible"
    end

    -- Subframe check: player must be actively viewing commodities or items to buy (and it must be ISVISIBLE, not just isshown!)
    local buyCommodities = AuctionHouseFrame.CommoditiesBuyFrame
    local buyItem = AuctionHouseFrame.ItemBuyFrame

    local isCommVisible = buyCommodities and buyCommodities:IsVisible()
    local isItemVisible = buyItem and buyItem:IsVisible()

    if not isCommVisible and not isItemVisible then
        return false, "Neither CommoditiesBuyFrame nor ItemBuyFrame is visible"
    end

    return true, "Buy commodity/item view active"
end

---------------------------------------------------------------------------
-- Card UI Construction
---------------------------------------------------------------------------

local function CreateBuyHelperCard()
    if helperCard then return helperCard end

    local template = BackdropTemplateMixin and "BackdropTemplate" or nil
    local card = CreateFrame("Frame", "GoldFinderBuyHelperCard", UIParent, template)
    card:SetSize(320, 175)
    card:SetFrameStrata("HIGH")
    card:SetClampedToScreen(true)

    -- Enable interactive dragging
    card:EnableMouse(true)
    card:SetMovable(true)
    card:RegisterForDrag("LeftButton")
    card:SetScript("OnDragStart", function(self)
        self:StartMoving()
    end)
    card:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
        self.userMoved = true
    end)

    if card.SetBackdrop then
        card:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true, tileSize = 16, edgeSize = 14,
            insets = { left = 4, right = 4, top = 4, bottom = 4 },
        })
        card:SetBackdropColor(0.08, 0.08, 0.10, 0.94)
        card:SetBackdropBorderColor(0.85, 0.70, 0.20, 1.0)
    end

    -- Close button
    local closeBtn = CreateFrame("Button", nil, card, "UIPanelCloseButton")
    closeBtn:SetSize(22, 22)
    closeBtn:SetPoint("TOPRIGHT", -4, -4)
    closeBtn:SetScript("OnClick", function()
        ns.HideBuyHelper()
    end)

    -- Header Title
    local title = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", 16, -12)
    title:SetText("|cffffd100" .. (L["Smart Buy Parity Advisor"] or "Smart Buy Parity Advisor") .. "|r")

    -- Item currently being viewed
    local viewing = card:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    viewing:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
    viewing:SetPoint("RIGHT", card, "RIGHT", -24)
    viewing:SetJustifyH("LEFT")
    viewing:SetWordWrap(false)
    card.viewing = viewing

    -- Comparison details
    local compLine = card:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    compLine:SetPoint("TOPLEFT", viewing, "BOTTOMLEFT", 0, -6)
    compLine:SetPoint("RIGHT", card, "RIGHT", -16)
    compLine:SetJustifyH("LEFT")
    compLine:SetWordWrap(true)
    card.compLine = compLine

    -- Savings banner
    local savings = card:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    savings:SetPoint("TOPLEFT", compLine, "BOTTOMLEFT", 0, -6)
    savings:SetPoint("RIGHT", card, "RIGHT", -16)
    savings:SetJustifyH("LEFT")
    savings:SetWordWrap(true)
    card.savings = savings

    -- Switch button
    local switchBtn = CreateFrame("Button", nil, card, "UIPanelButtonTemplate")
    switchBtn:SetSize(170, 22)
    switchBtn:SetPoint("BOTTOMLEFT", 16, 12)
    switchBtn:SetText("Search Alternative")
    switchBtn:SetScript("OnClick", function()
        if card.targetAltID and C_AuctionHouse and C_AuctionHouse.MakeItemKey and C_AuctionHouse.SendSearchQuery then
            local key = C_AuctionHouse.MakeItemKey(card.targetAltID)
            if key then
                C_AuctionHouse.SendSearchQuery(key, {}, false)
                ns.Good("Searching AH for %s...", card.targetAltName or "alternative")
            end
        end
    end)
    card.switchBtn = switchBtn

    helperCard = card
    return card
end

---------------------------------------------------------------------------
-- Parity Calculation & Card Updates
---------------------------------------------------------------------------

local function EvaluateParity(itemID)
    if not ns.IsBuyHelperEnabled() then
        ns.HideBuyHelper()
        return
    end

    -- Strictly ensure the player is on the Buy tab viewing a commodity or item!
    -- Never show on the Sell tab, GoldFinder tab, or Auctions tab.
    local active, reason = IsBuyFrameActive()
    if not active then
        if ns.Trace then ns.Trace("BuyHelper EvaluateParity(%s) SUPPRESSED: %s", tostring(itemID), reason or "not active") end
        ns.HideBuyHelper()
        return
    end

    if ns.Trace then ns.Trace("BuyHelper EvaluateParity(%s) ACTIVE: %s", tostring(itemID), reason or "active") end

    BuildConversionLookups()

    local asOutput = outputToConv[itemID]
    local asReagent = reagentToConv[itemID]

    if not asOutput and not asReagent then
        ns.HideBuyHelper()
        return
    end

    local card = CreateBuyHelperCard()
    currentItemID = itemID

    local currentPrice = ns.GetItemCurrentPrice and ns.GetItemCurrentPrice(itemID)
    local curName = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID))
        or (GetItemInfo and GetItemInfo(itemID))
        or ("Item " .. itemID)

    card.viewing:SetText(curName .. (currentPrice and currentPrice > 0 and (" (" .. ns.Money(currentPrice) .. ")") or ""))

    -- Case 1: Player is viewing a finished good (e.g. Copper Bar, Bolt of Silk, Arcanite Bar)
    if asOutput then
        local conv = asOutput
        local craftCost = 0
        local hasAllReagentPrices = true
        local mainReagent = conv.reagents[1]

        for _, r in ipairs(conv.reagents) do
            local rCost = r.fixedPrice or (ns.GetVendorPrice and ns.GetVendorPrice(r.itemID)) or (ns.GetItemCurrentPrice and ns.GetItemCurrentPrice(r.itemID)) or (ns.GetItemTypicalPrice and ns.GetItemTypicalPrice(r.itemID))
            if not rCost or rCost <= 0 then
                hasAllReagentPrices = false
                break
            end
            craftCost = craftCost + (rCost * r.qty)
        end

        local unitCraftCost = (conv.output.qty > 0) and math.floor(craftCost / conv.output.qty) or craftCost
        local rName = mainReagent and ((C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(mainReagent.itemID)) or (GetItemInfo and GetItemInfo(mainReagent.itemID)) or "raw reagents")

        if hasAllReagentPrices and currentPrice and currentPrice > 0 and unitCraftCost < math.floor(currentPrice * 0.85) then
            local savingsPerUnit = currentPrice - unitCraftCost
            local pct = math.floor((savingsPerUnit / currentPrice) * 100 + 0.5)

            card.compLine:SetText(("|cffffd100[Craft Alert]:|r 1x %s costs %s to craft."):format(curName, ns.Money(unitCraftCost)))
            card.savings:SetText(("|cff40ff40Save %s (%d%% cheaper)|r by buying %s and crafting yourself."):format(ns.Money(savingsPerUnit), pct, rName))
            card.targetAltID = mainReagent and mainReagent.itemID
            card.targetAltName = rName
            card.switchBtn:SetText("Search " .. (rName:sub(1, 14)))
            card.switchBtn:Show()
        else
            card.compLine:SetText(("|cff40ff40[Competitive]:|r Crafting costs %s."):format(hasAllReagentPrices and ns.Money(unitCraftCost) or "unknown"))
            card.savings:SetText("Current finished item price is reasonable compared to raw materials.")
            card.switchBtn:Hide()
        end

    -- Case 2: Player is viewing a raw reagent (e.g. Copper Ore, Silk Cloth)
    elseif asReagent then
        local conv = asReagent
        local outputPrice = (ns.GetItemCurrentPrice and ns.GetItemCurrentPrice(conv.output.itemID)) or (ns.GetItemTypicalPrice and ns.GetItemTypicalPrice(conv.output.itemID))
        local outName = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(conv.output.itemID)) or (GetItemInfo and GetItemInfo(conv.output.itemID)) or "finished item"

        -- Calculate raw cost required to produce 1 output
        local reqQty = 1
        for _, r in ipairs(conv.reagents) do
            if r.itemID == itemID then
                reqQty = r.qty
                break
            end
        end

        local rawCostForOne = currentPrice and (currentPrice * reqQty) or 0

        if outputPrice and outputPrice > 0 and rawCostForOne > 0 and outputPrice < math.floor(rawCostForOne * 0.90) then
            local savingsAmt = rawCostForOne - outputPrice
            card.compLine:SetText(("|cffff4040[Do Not Craft]:|r %s is selling for %s."):format(outName, ns.Money(outputPrice)))
            card.savings:SetText(("|cff40ff40Save %s|r: Buying pre-crafted %s is cheaper than crafting from raw materials!"):format(ns.Money(savingsAmt), outName))
            card.targetAltID = conv.output.itemID
            card.targetAltName = outName
            card.switchBtn:SetText("Search " .. (outName:sub(1, 14)))
            card.switchBtn:Show()
        else
            card.compLine:SetText(("|cff40ff40[Parity Normal]:|r Finished %s is %s."):format(outName, outputPrice and ns.Money(outputPrice) or "unknown"))
            card.savings:SetText("Raw material prices align with finished market value.")
            card.switchBtn:Hide()
        end
    end

    -- Dock card to the right of AuctionHouseFrame (if not manually moved by the user)
    if not card.userMoved then
        local anchor = AuctionHouseFrame
        if anchor and anchor:IsShown() then
            card:ClearAllPoints()
            local right = (anchor.GetRight and anchor:GetRight()) or 0
            local screenWidth = UIParent:GetWidth() or 1920
            if right + 335 < screenWidth then
                card:SetPoint("TOPLEFT", anchor, "TOPRIGHT", 6, -10)
            else
                card:SetPoint("TOPRIGHT", anchor, "TOPLEFT", -6, -10)
            end
        end
    end
    card:Show()
end

---------------------------------------------------------------------------
-- Lifecycle & Event Watcher (10-Layer Defense)
---------------------------------------------------------------------------

local hookedAH = false
function ns.InitBuyHelper()
    if hookedAH or not AuctionHouseFrame then return end
    hookedAH = true

    -- 1. Hook AH hide
    if AuctionHouseFrame.Hide then
        hooksecurefunc(AuctionHouseFrame, "Hide", function()
            if ns.Trace then ns.Trace("AuctionHouseFrame:Hide -> hiding BuyHelper") end
            ns.HideBuyHelper()
            if helperCard then
                helperCard.userMoved = nil
            end
        end)
    end

    -- 2. Hook subframe method hides (using method hooksecurefunc, NEVER HookScript on Blizzard frames!)
    if AuctionHouseFrame.CommoditiesBuyFrame and AuctionHouseFrame.CommoditiesBuyFrame.Hide then
        hooksecurefunc(AuctionHouseFrame.CommoditiesBuyFrame, "Hide", function()
            if ns.Trace then ns.Trace("CommoditiesBuyFrame:Hide -> hiding BuyHelper") end
            ns.HideBuyHelper()
        end)
    end

    if AuctionHouseFrame.ItemBuyFrame and AuctionHouseFrame.ItemBuyFrame.Hide then
        hooksecurefunc(AuctionHouseFrame.ItemBuyFrame, "Hide", function()
            if ns.Trace then ns.Trace("ItemBuyFrame:Hide -> hiding BuyHelper") end
            ns.HideBuyHelper()
        end)
    end

    -- 3. Hook LibAHTab addon tab changes (GoldFinder, Auctionator, etc.)
    local LibAHTab = LibStub and LibStub("LibAHTab-1-0", true)
    if LibAHTab and LibAHTab.SetSelected then
        hooksecurefunc(LibAHTab, "SetSelected", function(_, tabID)
            if ns.Trace then ns.Trace("LibAHTab:SetSelected(%s) -> hiding BuyHelper", tostring(tabID)) end
            ns.HideBuyHelper()
        end)
    end

    -- 4. Hook AH display mode changes (Blizzard's state machine for all tab and search transitions)
    if AuctionHouseFrame.SetDisplayMode then
        hooksecurefunc(AuctionHouseFrame, "SetDisplayMode", function()
            local isBuying, reason = IsBuyFrameActive()
            if not isBuying and helperCard and helperCard:IsShown() then
                if ns.Trace then ns.Trace("SetDisplayMode -> not buying (%s) -> hiding BuyHelper", reason or "inactive") end
                ns.HideBuyHelper()
            end
        end)
    end
end

local buyWatcher = CreateFrame("Frame")
buyWatcher:RegisterEvent("COMMODITY_SEARCH_RESULTS_UPDATED")
buyWatcher:RegisterEvent("AUCTION_HOUSE_SHOW")
buyWatcher:RegisterEvent("AUCTION_HOUSE_CLOSED")

buyWatcher:SetScript("OnEvent", function(self, event, arg1)
    if event == "COMMODITY_SEARCH_RESULTS_UPDATED" then
        if arg1 and arg1 > 0 then
            EvaluateParity(arg1)
        end
    elseif event == "AUCTION_HOUSE_SHOW" then
        if ns.InitBuyHelper then ns.InitBuyHelper() end
    elseif event == "AUCTION_HOUSE_CLOSED" then
        if ns.Trace then ns.Trace("AUCTION_HOUSE_CLOSED -> hiding BuyHelper") end
        if helperCard then
            helperCard:Hide()
            helperCard.userMoved = nil
        end
        currentItemID = nil
    end
end)
