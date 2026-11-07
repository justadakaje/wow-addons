-- GoldFinder -- SellHelper
-- Integrates with Blizzard's Sell tab (ItemSellFrame & CommoditiesSellFrame)
-- to overlay typical market values, current lowest buyout, price trends,
-- and smart undercut relisting suggestions.

local ADDON, ns = ...

local helperCard = nil
local currentSellFrame = nil
local currentItemID = nil

function ns.IsSellHelperEnabled()
    local s = ns.db and ns.db.settings
    if s and s.sellHelper ~= nil then return s.sellHelper end
    return true
end

function ns.SetSellHelperEnabled(val)
    if ns.db then
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.sellHelper = val
    end
    if not val and helperCard then
        helperCard:Hide()
    end
end

local function ApplyPrice(sellFrame, copper)
    if not sellFrame or not copper or copper <= 0 then return end
    copper = math.floor(copper)
    local applied = false

    if sellFrame.PriceInput and sellFrame.PriceInput.SetAmount then
        local ok = pcall(sellFrame.PriceInput.SetAmount, sellFrame.PriceInput, copper)
        if ok then applied = true end
    end
    if sellFrame.Buyout and sellFrame.Buyout.MoneyInputFrame and sellFrame.Buyout.MoneyInputFrame.SetAmount then
        local ok = pcall(sellFrame.Buyout.MoneyInputFrame.SetAmount, sellFrame.Buyout.MoneyInputFrame, copper)
        if ok then applied = true end
    end
    if sellFrame.SetUnitPrice then
        local ok = pcall(sellFrame.SetUnitPrice, sellFrame, copper)
        if ok then applied = true end
    end

    if applied then
        ns.Good("GoldFinder: Set sell price to %s.", ns.Money(copper))
    else
        ns.Warn("GoldFinder: Could not automatically fill price input for this item.")
    end
end

local function CreateHelperCard()
    if helperCard then return helperCard end

    local template = BackdropTemplateMixin and "BackdropTemplate" or nil
    local card = CreateFrame("Frame", "GoldFinderSellHelperCard", UIParent, template)
    card:SetSize(280, 185)
    card:SetFrameStrata("HIGH")
    card:SetClampedToScreen(true)

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

    -- Header
    local title = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", 12, -10)
    title:SetText("|cffffd100GoldFinder Price Helper|r")

    -- Item name
    local itemName = card:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    itemName:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
    itemName:SetPoint("RIGHT", card, "RIGHT", -12)
    itemName:SetJustifyH("LEFT")
    itemName:SetWordWrap(false)
    card.itemName = itemName

    -- Typical price row
    local typLabel = card:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    typLabel:SetPoint("TOPLEFT", itemName, "BOTTOMLEFT", 0, -8)
    typLabel:SetText("Typical (Median):")

    local typVal = card:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    typVal:SetPoint("RIGHT", card, "RIGHT", -12)
    typVal:SetPoint("TOP", typLabel, "TOP")
    card.typVal = typVal

    -- Current lowest row
    local lowLabel = card:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    lowLabel:SetPoint("TOPLEFT", typLabel, "BOTTOMLEFT", 0, -4)
    lowLabel:SetText("Lowest AH Now:")

    local lowVal = card:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    lowVal:SetPoint("RIGHT", card, "RIGHT", -12)
    lowVal:SetPoint("TOP", lowLabel, "TOP")
    card.lowVal = lowVal

    -- Trend row
    local trendLabel = card:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    trendLabel:SetPoint("TOPLEFT", lowLabel, "BOTTOMLEFT", 0, -4)
    trendLabel:SetText("Market Trend:")

    local trendVal = card:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    trendVal:SetPoint("RIGHT", card, "RIGHT", -12)
    trendVal:SetPoint("TOP", trendLabel, "TOP")
    card.trendVal = trendVal

    -- Suggestion banner
    local advice = card:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    advice:SetPoint("TOPLEFT", trendLabel, "BOTTOMLEFT", 0, -8)
    advice:SetPoint("RIGHT", card, "RIGHT", -12)
    advice:SetJustifyH("LEFT")
    advice:SetWordWrap(true)
    card.advice = advice

    -- Quick-Fill buttons
    local btnUndercut = CreateFrame("Button", nil, card, "UIPanelButtonTemplate")
    btnUndercut:SetSize(82, 22)
    btnUndercut:SetPoint("BOTTOMLEFT", 10, 10)
    btnUndercut:SetText("-1c Cut")
    btnUndercut:SetScript("OnClick", function()
        if card.suggestedUndercut and currentSellFrame then
            ApplyPrice(currentSellFrame, card.suggestedUndercut)
        end
    end)
    card.btnUndercut = btnUndercut

    local btnMatch = CreateFrame("Button", nil, card, "UIPanelButtonTemplate")
    btnMatch:SetSize(82, 22)
    btnMatch:SetPoint("LEFT", btnUndercut, "RIGHT", 4, 0)
    btnMatch:SetText("Match")
    btnMatch:SetScript("OnClick", function()
        if card.suggestedMatch and currentSellFrame then
            ApplyPrice(currentSellFrame, card.suggestedMatch)
        end
    end)
    card.btnMatch = btnMatch

    local btnTypical = CreateFrame("Button", nil, card, "UIPanelButtonTemplate")
    btnTypical:SetSize(82, 22)
    btnTypical:SetPoint("LEFT", btnMatch, "RIGHT", 4, 0)
    btnTypical:SetText("Typical")
    btnTypical:SetScript("OnClick", function()
        if card.suggestedTypical and currentSellFrame then
            ApplyPrice(currentSellFrame, card.suggestedTypical)
        end
    end)
    card.btnTypical = btnTypical

    helperCard = card
    return card
end

local function UpdateCardData(sellFrame, itemID)
    if not ns.IsSellHelperEnabled() then
        if helperCard then helperCard:Hide() end
        return
    end

    if not itemID or itemID <= 0 then
        if helperCard then helperCard:Hide() end
        return
    end

    local card = CreateHelperCard()
    currentSellFrame = sellFrame
    currentItemID = itemID

    local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID)) or ("Item " .. itemID)
    card.itemName:SetText(name)

    local typical = ns.GetItemTypicalPrice and ns.GetItemTypicalPrice(itemID)
    local lowest = ns.GetItemCurrentPrice and ns.GetItemCurrentPrice(itemID)

    if typical and typical > 0 then
        card.typVal:SetText(ns.Money(typical))
        card.suggestedTypical = typical
        card.btnTypical:Enable()
    else
        card.typVal:SetText("|cff888888No history|r")
        card.suggestedTypical = nil
        card.btnTypical:Disable()
    end

    if lowest and lowest > 0 then
        card.lowVal:SetText(ns.Money(lowest))
        card.suggestedMatch = lowest
        card.suggestedUndercut = math.max(1, lowest - 1)
        card.btnMatch:Enable()
        card.btnUndercut:Enable()
    else
        card.lowVal:SetText("|cff888888No listings|r")
        card.suggestedMatch = typical
        card.suggestedUndercut = typical and math.max(1, typical - 1) or nil
        if typical then
            card.btnMatch:Enable()
            card.btnUndercut:Enable()
        else
            card.btnMatch:Disable()
            card.btnUndercut:Disable()
        end
    end

    -- Trend calculation
    local trend = nil
    if ns.db and ns.db.items and ns.db.items[itemID] then
        trend = ns.CalculateTrend and ns.CalculateTrend(ns.db.items[itemID].history)
    end

    if trend then
        local color = ("|cff%02x%02x%02x"):format(math.floor(trend.r * 255), math.floor(trend.g * 255), math.floor(trend.b * 255))
        card.trendVal:SetText(color .. trend.label .. "|r")
    else
        card.trendVal:SetText("|cff888888Steady / Unknown|r")
    end

    -- Market evaluation advice
    if typical and lowest and lowest < math.floor(typical * 0.70) then
        local discount = math.floor((1 - lowest / typical) * 100 + 0.5)
        card.advice:SetText(("|cffff5555Caution: Market crashed (%d%% below typical). Consider holding inventory until prices recover.|r"):format(discount))
    elseif typical and lowest and lowest >= typical then
        card.advice:SetText("|cff55ff55Healthy market: Listings are at or above historical median. Post competitively to sell fast.|r")
    elseif typical and lowest then
        card.advice:SetText("|cffffd100Competitive market: Undercut lowest by 1 copper to capture the next sale.|r")
    else
        card.advice:SetText("|cff888888Insufficient scan data to determine market health.|r")
    end

    -- Position relative to sellFrame
    card:SetParent(sellFrame)
    card:ClearAllPoints()

    -- Place to the right of sell frame if room allows, otherwise to the left
    local left, right = sellFrame:GetLeft() or 0, sellFrame:GetRight() or 0
    local screenWidth = UIParent:GetWidth()
    if right + 290 < screenWidth then
        card:SetPoint("TOPLEFT", sellFrame, "TOPRIGHT", 8, -10)
    else
        card:SetPoint("TOPRIGHT", sellFrame, "TOPLEFT", -8, -10)
    end

    card:Show()
end

local function UpdateHelper(sellFrame, itemLocation)
    if not itemLocation then
        if helperCard then helperCard:Hide() end
        currentItemID = nil
        return
    end

    local itemID = nil
    if C_Item and C_Item.GetItemID then
        itemID = C_Item.GetItemID(itemLocation)
    end
    if not itemID and C_AuctionHouse and C_AuctionHouse.GetItemKeyFromItem then
        local key = C_AuctionHouse.GetItemKeyFromItem(itemLocation)
        itemID = key and key.itemID
    end

    if itemID and itemID > 0 then
        UpdateCardData(sellFrame, itemID)
    else
        if helperCard then helperCard:Hide() end
        currentItemID = nil
    end
end

local function HookSellFrame(frame)
    if not frame or frame._gfHooked then return end
    frame._gfHooked = true

    if frame.SetItem then
        hooksecurefunc(frame, "SetItem", function(self, itemLocation)
            UpdateHelper(self, itemLocation)
        end)
    end
    if frame.SetItemLocation then
        hooksecurefunc(frame, "SetItemLocation", function(self, itemLocation)
            UpdateHelper(self, itemLocation)
        end)
    end
    if frame.ClearItem then
        hooksecurefunc(frame, "ClearItem", function()
            if helperCard then helperCard:Hide() end
            currentItemID = nil
        end)
    end
    if frame.Reset then
        hooksecurefunc(frame, "Reset", function()
            if helperCard then helperCard:Hide() end
            currentItemID = nil
        end)
    end
    frame:HookScript("OnHide", function()
        if helperCard then helperCard:Hide() end
        currentItemID = nil
    end)
end

function ns.InitSellHelper()
    if not AuctionHouseFrame then return end

    if AuctionHouseFrame.ItemSellFrame then
        HookSellFrame(AuctionHouseFrame.ItemSellFrame)
    end
    if AuctionHouseFrame.CommoditiesSellFrame then
        HookSellFrame(AuctionHouseFrame.CommoditiesSellFrame)
    end
    if AuctionHouseFrame.WoWTokenSellFrame then
        HookSellFrame(AuctionHouseFrame.WoWTokenSellFrame)
    end
end

-- Refresh market card when search results update for the listed item
local sellEvents = CreateFrame("Frame")
sellEvents:RegisterEvent("COMMODITY_SEARCH_RESULTS_UPDATED")
sellEvents:RegisterEvent("ITEM_SEARCH_RESULTS_UPDATED")
sellEvents:SetScript("OnEvent", function(_, _, itemID)
    if currentItemID and currentSellFrame and helperCard and helperCard:IsShown() then
        if itemID == currentItemID or not itemID then
            UpdateCardData(currentSellFrame, currentItemID)
        end
    end
end)
