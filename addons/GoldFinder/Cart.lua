-- GoldFinder -- Cart
-- Multi-item quick-buy staging cart (#47).
-- Allows queuing multiple underpriced materials and commodity deals for batch execution
-- with sequential purchase pacing, spend cap protection, and confirmation guards.

local ADDON, ns = ...

local cart = {}
ns.cart = cart
local cartFrame = nil
local isPurchasing = false
local currentPurchaseIndex = 1

---------------------------------------------------------------------------
-- Cart State & Helpers
---------------------------------------------------------------------------

function ns.GetCart()
    return cart
end

function ns.GetCartTotals()
    local totalItems = 0
    local totalCost = 0
    local totalProfit = 0

    for _, item in ipairs(cart) do
        local q = item.qty or 1
        totalItems = totalItems + q
        totalCost = totalCost + (item.totalCost or (item.unitPrice * q))
        totalProfit = totalProfit + (item.profit or 0)
    end

    return #cart, totalItems, totalCost, totalProfit
end

function ns.AddToCart(deal, qty)
    if not deal or not deal.itemID then return false end
    qty = qty or deal.qty or 1

    -- Check if item is already in cart
    for i, item in ipairs(cart) do
        if item.itemID == deal.itemID then
            item.qty = item.qty + qty
            item.totalCost = item.qty * item.unitPrice
            item.profit = (deal.netUnitProfit or 0) * item.qty
            ns.Good("Updated cart: %dx %s (Total cost: %s).", item.qty, item.name, ns.Money(item.totalCost))
            if cartFrame and cartFrame:IsShown() then ns.RefreshCartUI() end
            if ns.UpdateCartButton then ns.UpdateCartButton() end
            return true
        end
    end

    local unitPrice = deal.now or deal.lowestNow or deal.unitPrice or 0
    local totalCost = unitPrice * qty
    local totalProfit = (deal.netUnitProfit or 0) * qty

    local entry = {
        itemID        = deal.itemID,
        name          = deal.name or (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(deal.itemID)) or ("Item " .. deal.itemID),
        unitPrice     = unitPrice,
        qty           = qty,
        totalCost     = totalCost,
        profit        = totalProfit,
        tier          = deal.tier,
        link          = deal.link,
        isCommodity   = deal.isCommodity ~= false,
    }

    cart[#cart + 1] = entry
    ns.Good("Added to cart: %dx %s (%s total).", qty, entry.name, ns.Money(totalCost))

    if cartFrame and cartFrame:IsShown() then ns.RefreshCartUI() end
    if ns.UpdateCartButton then ns.UpdateCartButton() end
    return true
end

function ns.RemoveFromCart(index)
    if index and cart[index] then
        local removed = table.remove(cart, index)
        ns.Print("Removed %s from cart.", removed.name or "Item")
        if cartFrame and cartFrame:IsShown() then ns.RefreshCartUI() end
        if ns.UpdateCartButton then ns.UpdateCartButton() end
        return true
    end
    return false
end

function ns.ClearCart()
    wipe(cart)
    ns.Print("GoldFinder staging cart cleared.")
    if cartFrame and cartFrame:IsShown() then ns.RefreshCartUI() end
    if ns.UpdateCartButton then ns.UpdateCartButton() end
end

---------------------------------------------------------------------------
-- Sequential Batch Purchase Engine
---------------------------------------------------------------------------

local function ProcessNextPurchase()
    if not isPurchasing then return end

    if #cart == 0 or currentPurchaseIndex > #cart then
        isPurchasing = false
        ns.Good("Cart batch purchase completed.")
        if cartFrame and cartFrame.buyBtn then
            cartFrame.buyBtn:SetText("Buy All Items")
            cartFrame.buyBtn:Enable()
        end
        if cartFrame and cartFrame:IsShown() then ns.RefreshCartUI() end
        if ns.UpdateCartButton then ns.UpdateCartButton() end
        return
    end

    local item = cart[currentPurchaseIndex]
    if not item then
        isPurchasing = false
        return
    end

    -- Verify spend cap
    local maxSpend = ns.GetMaxQuickBuySpend and ns.GetMaxQuickBuySpend() or 0
    if maxSpend > 0 and item.totalCost > maxSpend then
        ns.Warn("Skipping %s: Total cost (%s) exceeds quick-buy spend cap (%s).", item.name, ns.Money(item.totalCost), ns.Money(maxSpend))
        currentPurchaseIndex = currentPurchaseIndex + 1
        C_Timer.After(0.3, ProcessNextPurchase)
        return
    end

    if C_AuctionHouse and C_AuctionHouse.StartCommoditiesPurchase and C_AuctionHouse.ConfirmCommoditiesPurchase then
        -- Execute purchase through modern Auction House API
        C_AuctionHouse.StartCommoditiesPurchase(item.itemID, item.qty)
        C_Timer.After(0.15, function()
            C_AuctionHouse.ConfirmCommoditiesPurchase(item.itemID, item.qty)
            ns.Good("Purchased %dx %s for %s.", item.qty, item.name, ns.Money(item.totalCost))
            -- Play coin sound
            if PlaySound then PlaySound(895) end
            -- Remove bought item from cart
            table.remove(cart, currentPurchaseIndex)
            if cartFrame and cartFrame:IsShown() then ns.RefreshCartUI() end
            if ns.UpdateCartButton then ns.UpdateCartButton() end
            -- Pace next purchase
            C_Timer.After(0.35, ProcessNextPurchase)
        end)
    else
        ns.Warn("Direct commodity purchase not supported on this game client. Navigate to Buy tab to complete purchase.")
        isPurchasing = false
    end
end

function ns.ExecuteCartPurchase()
    if isPurchasing then return end
    if #cart == 0 then
        ns.Print("Staging cart is empty.")
        return
    end

    local _, _, totalCost, _ = ns.GetCartTotals()
    local maxSpend = ns.GetMaxQuickBuySpend and ns.GetMaxQuickBuySpend() or 0

    if maxSpend > 0 and totalCost > maxSpend then
        ns.Warn("Cart total (%s) exceeds your quick-buy spend cap of %s. Use /gf maxspend to adjust.", ns.Money(totalCost), ns.Money(maxSpend))
    end

    isPurchasing = true
    currentPurchaseIndex = 1

    if cartFrame and cartFrame.buyBtn then
        cartFrame.buyBtn:SetText("Purchasing...")
        cartFrame.buyBtn:Disable()
    end

    ProcessNextPurchase()
end

---------------------------------------------------------------------------
-- Cart UI Window
---------------------------------------------------------------------------

local ROWS_COUNT = 8
local ROW_HEIGHT = 22

function ns.RefreshCartUI()
    local f = cartFrame
    if not f or not f:IsShown() then return end

    local entriesCount, totalItems, totalCost, totalProfit = ns.GetCartTotals()
    f.countVal:SetText(("%d items (%d lots)"):format(totalItems, entriesCount))
    f.costVal:SetText(ns.Money(totalCost))

    local pColor = totalProfit >= 0 and "|cff40ff40+" or "|cffff4040"
    f.profitVal:SetText(pColor .. ns.Money(totalProfit) .. "|r")

    local maxSpend = ns.GetMaxQuickBuySpend and ns.GetMaxQuickBuySpend() or 0
    if maxSpend > 0 and totalCost > maxSpend then
        f.spendWarning:SetText(("|cffff4040Warning: Total exceeds %s spend cap!|r"):format(ns.Money(maxSpend)))
        f.spendWarning:Show()
    else
        f.spendWarning:Hide()
    end

    for i = 1, ROWS_COUNT do
        local row = f.rows[i]
        local item = cart[i]
        if item then
            row.index = i
            row.nameText:SetText(item.name)
            row.qtyText:SetText("x" .. tostring(item.qty))
            row.priceText:SetText(ns.Money(item.unitPrice))
            row.totalText:SetText(ns.Money(item.totalCost))
            local profitStr = (item.profit >= 0 and "|cff40ff40+" or "|cffff4040") .. ns.Money(item.profit) .. "|r"
            row.profitText:SetText(profitStr)
            row:Show()
        else
            row.index = nil
            row:Hide()
        end
    end

    if entriesCount == 0 then
        f.emptyText:Show()
        f.buyBtn:Disable()
        f.clearBtn:Disable()
    else
        f.emptyText:Hide()
        f.buyBtn:Enable()
        f.clearBtn:Enable()
    end
end

local function CreateCartFrameOnce()
    if cartFrame then return cartFrame end

    local template = BackdropTemplateMixin and "BackdropTemplate" or nil
    local f = CreateFrame("Frame", "GoldFinderCartFrame", UIParent, template)
    f:SetSize(560, 420)
    f:SetPoint("CENTER", UIParent, "CENTER", 40, -20)
    f:SetFrameStrata("DIALOG")
    f:SetToplevel(true)
    f:EnableMouse(true)
    f:SetMovable(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:SetClampedToScreen(true)

    f:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 8, right = 8, top = 8, bottom = 8 }
    })
    if f.SetBackdropColor then
        f:SetBackdropColor(0, 0, 0, 1)
    end

    local solidBg = f:CreateTexture(nil, "BACKGROUND", nil, -8)
    solidBg:SetPoint("TOPLEFT", 6, -6)
    solidBg:SetPoint("BOTTOMRIGHT", -6, 6)
    solidBg:SetColorTexture(0.08, 0.08, 0.10, 0.98)

    tinsert(UISpecialFrames, "GoldFinderCartFrame")

    -- Title Bar Header
    local headerTex = f:CreateTexture(nil, "ARTWORK")
    headerTex:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
    headerTex:SetSize(320, 64)
    headerTex:SetPoint("TOP", 0, 12)

    local titleText = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleText:SetPoint("TOP", headerTex, "TOP", 0, -14)
    titleText:SetText("GoldFinder Staging Cart")

    local subText = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    subText:SetPoint("TOP", 0, -30)
    subText:SetText("Queue multiple underpriced deals for safe batch execution.")

    local closeBtn = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -6, -6)
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    -- KPI Metrics Card
    local summaryCard = CreateFrame("Frame", nil, f, template)
    summaryCard:SetSize(512, 44)
    summaryCard:SetPoint("TOPLEFT", 24, -50)
    if summaryCard.SetBackdrop then
        summaryCard:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = "Interface\\Buttons\\WHITE8X8",
            edgeSize = 1,
            insets = { left = 1, right = 1, top = 1, bottom = 1 },
        })
        summaryCard:SetBackdropColor(0.12, 0.12, 0.14, 0.9)
        summaryCard:SetBackdropBorderColor(0.28, 0.28, 0.32, 0.8)
    end

    local cLabel = summaryCard:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    cLabel:SetPoint("TOPLEFT", 12, -6)
    cLabel:SetText("TOTAL STAGED")
    local cVal = summaryCard:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    cVal:SetPoint("BOTTOMLEFT", 12, 6)
    cVal:SetText("0 items")
    f.countVal = cVal

    local costLabel = summaryCard:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    costLabel:SetPoint("TOPLEFT", 180, -6)
    costLabel:SetText("TOTAL PURCHASE COST")
    local costVal = summaryCard:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    costVal:SetPoint("BOTTOMLEFT", 180, 6)
    costVal:SetText("0")
    f.costVal = costVal

    local pLabel = summaryCard:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    pLabel:SetPoint("TOPLEFT", 350, -6)
    pLabel:SetText("EST. NET FLIP PROFIT")
    local pVal = summaryCard:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    pVal:SetPoint("BOTTOMLEFT", 350, 6)
    pVal:SetText("0")
    f.profitVal = pVal

    local spendWarning = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    spendWarning:SetPoint("TOPLEFT", 26, -98)
    spendWarning:Hide()
    f.spendWarning = spendWarning

    -- Table Header
    local tableHeader = CreateFrame("Frame", nil, f)
    tableHeader:SetSize(512, 18)
    tableHeader:SetPoint("TOPLEFT", 24, -116)

    local cols = {
        { title = "Material",    w = 170, x = 0,   j = "LEFT" },
        { title = "Qty",         w = 40,  x = 175, j = "CENTER" },
        { title = "Unit Price",  w = 85,  x = 220, j = "RIGHT" },
        { title = "Total Cost",  w = 90,  x = 310, j = "RIGHT" },
        { title = "Est. Profit", w = 90,  x = 405, j = "RIGHT" },
    }
    for _, c in ipairs(cols) do
        local fs = tableHeader:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        fs:SetPoint("LEFT", tableHeader, "LEFT", c.x, 0)
        fs:SetWidth(c.w)
        fs:SetJustifyH(c.j)
        fs:SetText(c.title)
    end

    -- Table Rows
    f.rows = {}
    local prevAnchor = tableHeader
    for i = 1, ROWS_COUNT do
        local row = CreateFrame("Frame", nil, f)
        row:SetSize(512, ROW_HEIGHT)
        row:SetPoint("TOPLEFT", prevAnchor, "BOTTOMLEFT", 0, -2)

        local hl = row:CreateTexture(nil, "BACKGROUND")
        hl:SetAllPoints(row)
        hl:SetColorTexture(1, 0.82, 0, 0.08)
        hl:Hide()
        row.hl = hl

        row.nameText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.nameText:SetPoint("LEFT", 0, 0)
        row.nameText:SetWidth(170)
        row.nameText:SetJustifyH("LEFT")

        row.qtyText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.qtyText:SetPoint("LEFT", 175, 0)
        row.qtyText:SetWidth(40)
        row.qtyText:SetJustifyH("CENTER")

        row.priceText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.priceText:SetPoint("LEFT", 220, 0)
        row.priceText:SetWidth(85)
        row.priceText:SetJustifyH("RIGHT")

        row.totalText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.totalText:SetPoint("LEFT", 310, 0)
        row.totalText:SetWidth(90)
        row.totalText:SetJustifyH("RIGHT")

        row.profitText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        row.profitText:SetPoint("LEFT", 405, 0)
        row.profitText:SetWidth(75)
        row.profitText:SetJustifyH("RIGHT")

        local delBtn = CreateFrame("Button", nil, row)
        delBtn:SetSize(16, 16)
        delBtn:SetPoint("RIGHT", row, "RIGHT", -2, 0)
        delBtn:SetNormalTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
        delBtn:SetHighlightTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Highlight")
        delBtn:SetScript("OnClick", function()
            if row.index then
                ns.RemoveFromCart(row.index)
            end
        end)
        delBtn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("Remove from Cart", 1, 0.25, 0.25)
            GameTooltip:Show()
        end)
        delBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

        row:EnableMouse(true)
        row:SetScript("OnEnter", function(self) self.hl:Show() end)
        row:SetScript("OnLeave", function(self) self.hl:Hide() end)

        f.rows[i] = row
        prevAnchor = row
    end

    -- Empty state notice
    local emptyText = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    emptyText:SetPoint("CENTER", f, "CENTER", 0, -40)
    emptyText:SetText("Your staging cart is empty.\nAlt-Click any deal row in the GoldFinder tab to stage it here.")
    emptyText:SetJustifyH("CENTER")
    f.emptyText = emptyText

    -- Bottom Buttons
    local buyBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    buyBtn:SetSize(150, 24)
    buyBtn:SetPoint("BOTTOMLEFT", 24, 18)
    buyBtn:SetText("Buy All Items")
    buyBtn:SetScript("OnClick", function()
        ns.ExecuteCartPurchase()
    end)
    f.buyBtn = buyBtn

    local clearBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    clearBtn:SetSize(110, 24)
    clearBtn:SetPoint("LEFT", buyBtn, "RIGHT", 10, 0)
    clearBtn:SetText("Clear Cart")
    clearBtn:SetScript("OnClick", function()
        ns.ClearCart()
    end)
    f.clearBtn = clearBtn

    local bottomClose = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    bottomClose:SetSize(100, 24)
    bottomClose:SetPoint("BOTTOMRIGHT", -24, 18)
    bottomClose:SetText("Close")
    bottomClose:SetScript("OnClick", function() f:Hide() end)

    f:SetScript("OnShow", function()
        ns.RefreshCartUI()
    end)

    cartFrame = f
    return cartFrame
end

function ns.OpenCart()
    local f = CreateCartFrameOnce()
    if f then
        f:Show()
        f:Raise()
        ns.RefreshCartUI()
    end
end

function ns.ToggleCart()
    if cartFrame and cartFrame:IsShown() then
        cartFrame:Hide()
    else
        ns.OpenCart()
    end
end
