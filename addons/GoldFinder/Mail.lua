-- GoldFinder -- Mail
-- Mailbox deal collector, cost basis tracking, and expired auction relist advisor (#40, #42, #43).
-- Hooks MailFrame to automatically record purchase cost basis upon collecting auction buyouts,
-- evaluate expired auctions against current market prices, and provide one-click deal collection.

local ADDON, ns = ...

local collectBtn = nil
local isCollecting = false
local pendingCollection = {}
local currentCollectIndex = 1

---------------------------------------------------------------------------
-- Mailbox Analysis & Classification

local function IsAuctionHouseSender(sender)
    if not sender or sender == "" then return false end
    if sender == "Auction House" or sender:find("Auction") then return true end
    if AUCTION_HOUSE_MAIL_SUBJECT and sender == AUCTION_HOUSE_MAIL_SUBJECT then return true end
    return false
end

-- Evaluates advice for an expired or cancelled auction item
local function EvaluateExpiredAuction(itemID)
    if not itemID then return nil end
    local current = ns.GetItemCurrentPrice and ns.GetItemCurrentPrice(itemID)
    local typical = ns.GetItemTypicalPrice and ns.GetItemTypicalPrice(itemID)
    local cb = ns.GetCostBasis and ns.GetCostBasis(itemID)
    local avgCost = cb and cb.avgUnitCost or 0

    if current and avgCost > 0 and current < avgCost then
        return {
            action = "HOLD",
            colorStr = "|cffff4040",
            r = 1.0, g = 0.25, b = 0.25,
            tag = "[HOLD - BELOW COST]",
            reason = ("Current market (%s) is below your cost basis (%s). Hold inventory to avoid a loss."):format(ns.Money(current), ns.Money(avgCost)),
        }
    elseif current and typical and current >= math.floor(typical * 0.90) then
        local targetRelist = math.max(1, current - 1)
        return {
            action = "RELIST",
            colorStr = "|cff40ff40",
            r = 0.25, g = 1.0, b = 0.25,
            tag = "[RELIST - HEALTHY MARKET]",
            reason = ("Market has recovered (Lowest: %s, Typical: %s). Recommended relist: %s."):format(ns.Money(current), ns.Money(typical), ns.Money(targetRelist)),
        }
    elseif current and typical and current < math.floor(typical * 0.75) then
        return {
            action = "WAIT",
            colorStr = "|cffffd100",
            r = 1.0, g = 0.82, b = 0.0,
            tag = "[WAIT - UNDERCUT WAVE]",
            reason = ("Heavy competitor undercuts (%s vs %s typical). Wait for cheap listings to sell out."):format(ns.Money(current), ns.Money(typical)),
        }
    elseif typical and typical > 0 then
        return {
            action = "RELIST",
            colorStr = "|cff40ff40",
            r = 0.25, g = 1.0, b = 0.25,
            tag = "[RELIST]",
            reason = ("Relist at typical market baseline (%s)."):format(ns.Money(typical)),
        }
    else
        return {
            action = "INFO",
            colorStr = "|cffffffff",
            r = 0.8, g = 0.8, b = 0.8,
            tag = "[RELIST INFO]",
            reason = "Scan the Auction House to check current competitor prices.",
        }
    end
end
ns.EvaluateExpiredAuction = EvaluateExpiredAuction

-- Scans the inbox for deal deliveries, sold proceeds, and expired auctions
local function ScanInboxDeals()
    local candidates = {}
    if type(GetInboxNumItems) ~= "function" then return candidates end

    local numItems = GetInboxNumItems() or 0
    for i = 1, numItems do
        local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead, wasReturned, textCreated, canReply, isGM, itemQuantity = GetInboxHeaderInfo(i)
        local isAH = IsAuctionHouseSender(sender)

        if isAH then
            local invoiceType, itemName, playerName, bid, buyout, deposit, consignment, moneyDelay, etaHour, etaMin, count
            if type(GetInboxInvoiceInfo) == "function" then
                invoiceType, itemName, playerName, bid, buyout, deposit, consignment, moneyDelay, etaHour, etaMin, count = GetInboxInvoiceInfo(i)
            end

            -- 1. Buyer invoice: won auction deal with item attachment
            if (invoiceType == "buyer" or (subject and (subject:find("won") or subject:find("Won") or subject:find("buyout") or subject:find("Buyout")))) and hasItem then
                local link = (type(GetInboxItemLink) == "function") and GetInboxItemLink(i, 1)
                local itemID = link and tonumber(link:match("item:(%d+)"))
                local qty = count or itemQuantity or 1
                local totalCost = buyout or bid or (money and money > 0 and money) or 0
                candidates[#candidates + 1] = {
                    index = i,
                    type = "purchase",
                    itemID = itemID,
                    link = link,
                    name = itemName or (link and link:match("%[(.-)%]")) or "Material",
                    qty = qty,
                    totalCost = totalCost,
                    unitCost = (qty > 0) and math.floor(totalCost / qty) or 0,
                    hasItem = true,
                    hasMoney = false,
                }
            -- 2. Seller invoice: auction sold proceeds with money attached
            elseif (invoiceType == "seller" or (subject and (subject:find("sold") or subject:find("Sold") or subject:find("successful") or subject:find("Successful")))) and money and money > 0 then
                local gross = bid or money or 0
                local cut = consignment or math.floor(gross * 0.05)
                candidates[#candidates + 1] = {
                    index = i,
                    type = "sale",
                    name = itemName or subject or "Auction Sale",
                    qty = count or 1,
                    gross = gross,
                    ahCut = cut,
                    net = money,
                    hasItem = false,
                    hasMoney = true,
                }
            -- 3. Expired or cancelled auction item
            elseif hasItem and (subject and (subject:find("expired") or subject:find("Expired") or subject:find("cancelled") or subject:find("Cancelled") or subject:find("removed") or subject:find("Removed"))) then
                local link = (type(GetInboxItemLink) == "function") and GetInboxItemLink(i, 1)
                local itemID = link and tonumber(link:match("item:(%d+)"))
                candidates[#candidates + 1] = {
                    index = i,
                    type = "expired",
                    itemID = itemID,
                    link = link,
                    name = itemName or (link and link:match("%[(.-)%]")) or "Expired Material",
                    qty = count or itemQuantity or 1,
                    hasItem = true,
                    hasMoney = false,
                    advisor = itemID and EvaluateExpiredAuction(itemID),
                }
            end
        end
    end

    return candidates
end

---------------------------------------------------------------------------
-- Automated Paced Collection Engine

local function ProcessNextCollection()
    if not isCollecting then return end

    -- Check if mail command is currently pending in client
    if C_Mail and C_Mail.IsCommandPending and C_Mail.IsCommandPending() then
        C_Timer.After(0.2, ProcessNextCollection)
        return
    end

    if currentCollectIndex > #pendingCollection then
        -- All pending items collected
        isCollecting = false
        ns.Good("Mailbox deal collection complete.")
        if collectBtn then
            collectBtn:SetText("Collect Deals")
            collectBtn:Enable()
        end
        return
    end

    local item = pendingCollection[currentCollectIndex]
    currentCollectIndex = currentCollectIndex + 1

    local numItems = (type(GetInboxNumItems) == "function") and GetInboxNumItems() or 0
    if item.index <= numItems then
        if item.type == "purchase" then
            if item.itemID and item.qty and item.qty > 0 then
                ns.RecordPurchase(item.itemID, item.qty, item.totalCost, item.unitCost)
                local name = item.link or item.name or ("Item " .. item.itemID)
                if item.totalCost > 0 then
                    ns.Good("Collected %dx %s (Cost basis: %s each, total %s).", item.qty, name, ns.Money(item.unitCost), ns.Money(item.totalCost))
                else
                    ns.Good("Collected %dx %s from auction house delivery.", item.qty, name)
                end
            end
            if type(TakeInboxItem) == "function" then
                TakeInboxItem(item.index, 1)
            elseif type(AutoLootMailItemAndMoney) == "function" then
                AutoLootMailItemAndMoney(item.index)
            end
        elseif item.type == "sale" then
            if item.net and item.net > 0 then
                local rec = ns.RecordSale and ns.RecordSale(item.itemID, item.name, item.qty, item.gross, item.ahCut, item.cost)
                local profitStr = rec and (rec.profit >= 0 and ("|cff40ff40+" .. ns.Money(rec.profit) .. "|r") or ("|cffff4040" .. ns.Money(rec.profit) .. "|r")) or ns.Money(item.net)
                ns.Good("Collected sale: %dx %s for %s net gold (Realized profit: %s).", item.qty, item.name, ns.Money(item.net), profitStr)
            end
            if type(TakeInboxMoney) == "function" then
                TakeInboxMoney(item.index)
            elseif type(AutoLootMailItemAndMoney) == "function" then
                AutoLootMailItemAndMoney(item.index)
            end
        elseif item.type == "expired" then
            if item.advisor then
                local name = item.link or item.name or "Item"
                ns.Print("%s %s %s", item.advisor.tag, name, item.advisor.reason)
            end
            if type(TakeInboxItem) == "function" then
                TakeInboxItem(item.index, 1)
            end
        end
    end

    -- Pace requests with a 0.25 second throttle
    C_Timer.After(0.25, ProcessNextCollection)
end

local function StartCollection()
    if isCollecting then return end
    local candidates = ScanInboxDeals()
    if #candidates == 0 then
        ns.Print("No auction deals or proceeds found in inbox to collect.")
        return
    end

    isCollecting = true
    pendingCollection = candidates
    currentCollectIndex = 1

    if collectBtn then
        collectBtn:SetText("Collecting...")
        collectBtn:Disable()
    end

    ProcessNextCollection()
end

---------------------------------------------------------------------------
-- MailFrame UI Integration

local function UpdateCollectButton()
    if not collectBtn or not collectBtn:IsShown() then return end
    if isCollecting then return end

    local candidates = ScanInboxDeals()
    local count = #candidates
    if count > 0 then
        collectBtn:SetText(("Collect Deals (%d)"):format(count))
        collectBtn:Enable()
    else
        collectBtn:SetText("Collect Deals (0)")
        collectBtn:Disable()
    end
end

local function CreateMailButtonOnce()
    if collectBtn or not MailFrame then return end
    if not (ns.IsMailCollectorEnabled and ns.IsMailCollectorEnabled()) then return end

    local btn = CreateFrame("Button", "GoldFinderMailCollectBtn", MailFrame, "UIPanelButtonTemplate")
    btn:SetSize(130, 22)
    -- Position in top header area of MailFrame
    btn:SetPoint("TOPRIGHT", MailFrame, "TOPRIGHT", -50, -32)
    btn:SetText("Collect Deals")
    btn:SetScript("OnClick", StartCollection)
    btn:SetScript("OnEnter", function(self)
        local candidates = ScanInboxDeals()
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("GoldFinder Deal Collector", 1, 0.82, 0)
        GameTooltip:AddLine("Collects won auction materials and sale payments in one click,", 1, 1, 1, true)
        GameTooltip:AddLine("automatically logging purchase cost basis and realized profit.", 1, 1, 1, true)
        if #candidates > 0 then
            GameTooltip:AddLine(("Pending items to collect: %d"):format(#candidates), 0.25, 1, 0.25)
        else
            GameTooltip:AddLine("No auction items pending in inbox.", 0.7, 0.7, 0.7)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    collectBtn = btn
    UpdateCollectButton()
end

---------------------------------------------------------------------------
-- Tooltip Relist Advisor on Mail Items

local function HookMailTooltips()
    if GameTooltip and GameTooltip.HookScript then
        GameTooltip:HookScript("OnTooltipSetItem", function(self)
            if not MailFrame or not MailFrame:IsShown() then return end
            local _, link = self:GetItem()
            if not link then return end
            local itemID = tonumber(link:match("item:(%d+)"))
            if not itemID then return end

            local advice = EvaluateExpiredAuction(itemID)
            if advice then
                self:AddLine(" ")
                self:AddDoubleLine("GoldFinder Relist Advisor:", advice.tag, 1, 0.82, 0, advice.r, advice.g, advice.b)
                self:AddLine(advice.reason, 0.85, 0.85, 0.85, true)
                self:Show()
            end
        end)
    end
end

---------------------------------------------------------------------------
-- Event Registration

local mailFrameEvents = CreateFrame("Frame")
mailFrameEvents:RegisterEvent("MAIL_SHOW")
mailFrameEvents:RegisterEvent("MAIL_INBOX_UPDATE")
mailFrameEvents:RegisterEvent("MAIL_CLOSED")

mailFrameEvents:SetScript("OnEvent", function(self, event)
    if event == "MAIL_SHOW" then
        CreateMailButtonOnce()
        UpdateCollectButton()
    elseif event == "MAIL_INBOX_UPDATE" then
        UpdateCollectButton()
    elseif event == "MAIL_CLOSED" then
        isCollecting = false
        pendingCollection = {}
    end
end)

HookMailTooltips()
