-- GoldFinder -- Ledger
-- Realized Profit & Loss (P&L) Goblin Ledger (#41).
-- Tracks completed auction flips, calculates true net profit after purchase cost basis
-- and Blizzard's 5% auction cut, and renders an interactive accounting dashboard.

local ADDON, ns = ...

local ledgerFrame = nil
local ROWS_COUNT = 12
local ROW_HEIGHT = 20

local function FormatTime(ts)
    if not ts or ts == 0 then return "Unknown" end
    local dateTable = date("*t", ts)
    if dateTable then
        return ("%02d/%02d %02d:%02d"):format(dateTable.month, dateTable.day, dateTable.hour, dateTable.min)
    end
    return tostring(ts)
end

local function GetTopProfitableItems(records)
    local itemTotals = {}
    for _, r in ipairs(records) do
        local id = r.itemID or r.name
        if not itemTotals[id] then
            itemTotals[id] = {
                name = r.name or ("Item " .. tostring(id)),
                profit = 0,
                cost = 0,
                qty = 0,
            }
        end
        itemTotals[id].profit = itemTotals[id].profit + (r.profit or 0)
        itemTotals[id].cost = itemTotals[id].cost + (r.cost or 0)
        itemTotals[id].qty = itemTotals[id].qty + (r.qty or 1)
    end

    local list = {}
    for _, data in pairs(itemTotals) do
        list[#list + 1] = data
    end

    table.sort(list, function(a, b)
        return a.profit > b.profit
    end)

    return list
end

local function ShowLedgerExport()
    local ledger = ns.GetLedger and ns.GetLedger()
    local records = ledger and ledger.records or {}
    local lines = { "Date,Item,Quantity,GrossRevenue,AHCut,NetRevenue,CostBasis,RealizedProfit,ROI" }

    for _, r in ipairs(records) do
        local dateStr = date("%Y-%m-%d %H:%M:%S", r.t or GetServerTime())
        local cleanName = (r.name or "Item"):gsub(",", "")
        local gross = (r.gross or 0) / 10000
        local cut = (r.ahCut or 0) / 10000
        local net = (r.net or 0) / 10000
        local cost = (r.cost or 0) / 10000
        local profit = (r.profit or 0) / 10000
        local roi = r.roi or 0
        lines[#lines + 1] = ("%s,%s,%d,%.4f,%.4f,%.4f,%.4f,%.4f,%.1f%%"):format(
            dateStr, cleanName, r.qty or 1, gross, cut, net, cost, profit, roi
        )
    end

    local text = table.concat(lines, "\n")
    if ns.ShowExportDialog then
        ns.ShowExportDialog()
        if GoldFinderExportDialog and GoldFinderExportDialog.editBox then
            GoldFinderExportDialog.editBox:SetText(text)
            GoldFinderExportDialog.editBox:HighlightText()
        end
    else
        ns.Print("Ledger contains %d transactions. Use /gf export to view raw data.", #records)
    end
end

local function RefreshLedgerUI(f)
    if not f or not f:IsShown() then return end
    local ledger = ns.GetLedger and ns.GetLedger()
    local lt = ledger and ledger.lifetime or { totalGross = 0, totalCut = 0, totalNet = 0, totalCost = 0, totalProfit = 0, count = 0 }
    local records = ledger and ledger.records or {}

    -- 1. Update KPI Summary Cards
    local profit = lt.totalProfit or 0
    local profitColor = profit >= 0 and "|cff40ff40+" or "|cffff4040"
    f.kpiProfitVal:SetText(profitColor .. ns.Money(profit) .. "|r")

    local roi = (lt.totalCost and lt.totalCost > 0) and ((profit / lt.totalCost) * 100) or 0
    local roiColor = roi >= 0 and "|cff40ff40" or "|cffff4040"
    f.kpiRoiVal:SetText(("%s%+.1f%%|r"):format(roiColor, roi))

    f.kpiFlipsVal:SetText(tostring(lt.count or #records))
    f.kpiRevenueVal:SetText(ns.Money(lt.totalGross or 0))

    -- 2. Update Top Flips Banner
    local topItems = GetTopProfitableItems(records)
    if #topItems > 0 then
        local parts = {}
        for i = 1, math.min(3, #topItems) do
            local item = topItems[i]
            local pColor = item.profit >= 0 and "|cff40ff40+" or "|cffff4040"
            parts[#parts + 1] = ("#%d %s (%s%s|r)"):format(i, item.name, pColor, ns.Money(item.profit))
        end
        f.topFlipsText:SetText("|cffffd100Top Flips:|r " .. table.concat(parts, "  |cff666666•|r  "))
    else
        f.topFlipsText:SetText("|cffffd100Top Flips:|r No completed auction flips recorded yet.")
    end

    -- 3. Populate Recent Transactions Table (newest first)
    local totalRecords = #records
    for i = 1, ROWS_COUNT do
        local row = f.rows[i]
        local recIndex = totalRecords - (i - 1)
        local r = (recIndex >= 1) and records[recIndex] or nil

        if r then
            row.rec = r
            row.cells.date:SetText(FormatTime(r.t))
            row.cells.item:SetText(("%s |cff888888x%d|r"):format(r.name or "Item", r.qty or 1))
            row.cells.gross:SetText(ns.Money(r.gross or 0))
            row.cells.cost:SetText(ns.Money(r.cost or 0))

            local p = r.profit or 0
            local pStr = (p >= 0 and "|cff40ff40+" or "|cffff4040") .. ns.Money(p) .. "|r"
            row.cells.profit:SetText(pStr)

            local rRoi = r.roi or 0
            local rColor = rRoi >= 0 and "|cff40ff40" or "|cffff4040"
            row.cells.roi:SetText(("%s%+.0f%%|r"):format(rColor, rRoi))

            row:Show()
        else
            row.rec = nil
            row:Hide()
        end
    end

    -- Empty state notice
    if totalRecords == 0 then
        f.emptyNotice:Show()
    else
        f.emptyNotice:Hide()
    end
end

local function CreateLedgerFrameOnce()
    if ledgerFrame then return ledgerFrame end

    local template = BackdropTemplateMixin and "BackdropTemplate" or nil
    local f = CreateFrame("Frame", "GoldFinderLedgerFrame", UIParent, template)
    f:SetSize(720, 520)
    f:SetPoint("CENTER", UIParent, "CENTER", 0, 30)
    f:SetFrameStrata("DIALOG")
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

    tinsert(UISpecialFrames, "GoldFinderLedgerFrame")

    -- Title Bar Header Texture & Text
    local headerTex = f:CreateTexture(nil, "ARTWORK")
    headerTex:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
    headerTex:SetSize(360, 64)
    headerTex:SetPoint("TOP", 0, 12)

    local titleText = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleText:SetPoint("TOP", headerTex, "TOP", 0, -14)
    titleText:SetText("GoldFinder Goblin Ledger")

    local subText = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    subText:SetPoint("TOP", 0, -30)
    subText:SetText("Realized flip margins, true acquisition cost basis, and net ROI.")

    local closeBtn = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -6, -6)
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    -----------------------------------------------------------------------
    -- KPI Metric Cards
    -----------------------------------------------------------------------
    local function MakeCard(x, title)
        local card = CreateFrame("Frame", nil, f, BackdropTemplateMixin and "BackdropTemplate" or nil)
        card:SetSize(155, 52)
        card:SetPoint("TOPLEFT", x, -54)
        if card.SetBackdrop then
            card:SetBackdrop({
                bgFile = "Interface\\Buttons\\WHITE8X8",
                edgeFile = "Interface\\Buttons\\WHITE8X8",
                edgeSize = 1,
                insets = { left = 1, right = 1, top = 1, bottom = 1 },
            })
            card:SetBackdropColor(0.12, 0.12, 0.14, 0.9)
            card:SetBackdropBorderColor(0.28, 0.28, 0.32, 0.8)
        end

        local lbl = card:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        lbl:SetPoint("TOPLEFT", 8, -6)
        lbl:SetText(title)

        local val = card:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
        val:SetPoint("BOTTOMLEFT", 8, 8)
        val:SetText("0")
        card.val = val

        return card, val
    end

    local c1, v1 = MakeCard(24, "LIFETIME NET PROFIT")
    f.kpiProfitVal = v1

    local c2, v2 = MakeCard(192, "AVERAGE FLIP ROI")
    f.kpiRoiVal = v2

    local c3, v3 = MakeCard(360, "TOTAL FLIPS")
    f.kpiFlipsVal = v3

    local c4, v4 = MakeCard(528, "TOTAL REVENUE (GROSS)")
    f.kpiRevenueVal = v4

    -- Top Flips summary line
    local topFlips = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    topFlips:SetPoint("TOPLEFT", 26, -114)
    topFlips:SetPoint("RIGHT", f, "RIGHT", -26, 0)
    topFlips:SetJustifyH("LEFT")
    topFlips:SetText("|cffffd100Top Flips:|r Loading...")
    f.topFlipsText = topFlips

    -----------------------------------------------------------------------
    -- Transactions Table Header
    -----------------------------------------------------------------------
    local tableHeader = CreateFrame("Frame", nil, f)
    tableHeader:SetSize(668, 20)
    tableHeader:SetPoint("TOPLEFT", 26, -136)

    local cols = {
        { key = "date",   title = "Date/Time",   w = 90,  x = 0,   j = "LEFT" },
        { key = "item",   title = "Material",    w = 210, x = 95,  j = "LEFT" },
        { key = "gross",  title = "Sold Price",  w = 95,  x = 310, j = "RIGHT" },
        { key = "cost",   title = "Cost Basis",  w = 95,  x = 410, j = "RIGHT" },
        { key = "profit", title = "Realized Net",w = 100, x = 510, j = "RIGHT" },
        { key = "roi",    title = "ROI",         w = 50,  x = 615, j = "RIGHT" },
    }

    for _, c in ipairs(cols) do
        local fs = tableHeader:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        fs:SetPoint("LEFT", tableHeader, "LEFT", c.x, 0)
        fs:SetWidth(c.w)
        fs:SetJustifyH(c.j)
        fs:SetText(c.title)
    end

    -----------------------------------------------------------------------
    -- Table Rows
    -----------------------------------------------------------------------
    f.rows = {}
    local prevAnchor = tableHeader
    for i = 1, ROWS_COUNT do
        local row = CreateFrame("Frame", nil, f)
        row:SetSize(668, ROW_HEIGHT)
        row:SetPoint("TOPLEFT", prevAnchor, "BOTTOMLEFT", 0, -2)

        local hl = row:CreateTexture(nil, "BACKGROUND")
        hl:SetAllPoints(row)
        hl:SetColorTexture(1, 0.82, 0, 0.08)
        hl:Hide()
        row.hl = hl

        row.cells = {}
        for _, c in ipairs(cols) do
            local fs = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            fs:SetPoint("LEFT", row, "LEFT", c.x, 0)
            fs:SetWidth(c.w)
            fs:SetJustifyH(c.j)
            row.cells[c.key] = fs
        end

        row:EnableMouse(true)
        row:SetScript("OnEnter", function(self)
            self.hl:Show()
            if self.rec then
                local r = self.rec
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(r.name or "Transaction Detail", 1, 0.82, 0)
                GameTooltip:AddDoubleLine("Quantity Sold:", tostring(r.qty or 1), 1, 1, 1, 1, 1, 1)
                GameTooltip:AddDoubleLine("Gross Sold Price:", ns.Money(r.gross or 0), 1, 1, 1, 1, 1, 1)
                GameTooltip:AddDoubleLine("Blizzard AH Cut (5%):", "-" .. ns.Money(r.ahCut or 0), 1, 1, 1, 1, 0.4, 0.4)
                GameTooltip:AddDoubleLine("Net Revenue:", ns.Money(r.net or 0), 1, 1, 1, 1, 1, 1)
                GameTooltip:AddDoubleLine("Acquisition Cost Basis:", ns.Money(r.cost or 0), 1, 1, 1, 1, 1, 1)
                local p = r.profit or 0
                local pColor = p >= 0 and "|cff40ff40" or "|cffff4040"
                GameTooltip:AddDoubleLine("Realized Net Profit:", pColor .. ns.Money(p) .. "|r", 1, 1, 1, 1, 1, 1)
                GameTooltip:AddDoubleLine("Return on Investment (ROI):", ("%+.1f%%"):format(r.roi or 0), 1, 1, 1, 0.25, 1, 0.25)
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("Transaction recorded from mailbox auction sale.", 0.6, 0.6, 0.6)
                GameTooltip:Show()
            end
        end)
        row:SetScript("OnLeave", function(self)
            self.hl:Hide()
            GameTooltip:Hide()
        end)

        f.rows[i] = row
        prevAnchor = row
    end

    -- Empty state notice
    local emptyNotice = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    emptyNotice:SetPoint("CENTER", f, "CENTER", 0, -50)
    emptyNotice:SetText("No completed sales recorded yet.\nCollect won auction sales from your mailbox to populate the ledger.")
    emptyNotice:SetJustifyH("CENTER")
    f.emptyNotice = emptyNotice

    -----------------------------------------------------------------------
    -- Bottom Action Buttons
    -----------------------------------------------------------------------
    local exportBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    exportBtn:SetSize(110, 24)
    exportBtn:SetPoint("BOTTOMLEFT", 26, 18)
    exportBtn:SetText("Export CSV")
    exportBtn:SetScript("OnClick", ShowLedgerExport)
    exportBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Export Ledger Data", 1, 0.82, 0)
        GameTooltip:AddLine("Export all recorded flip transactions as CSV for Excel or Google Sheets.", 1, 1, 1, true)
        GameTooltip:Show()
    end)
    exportBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    local resetBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    resetBtn:SetSize(110, 24)
    resetBtn:SetPoint("LEFT", exportBtn, "RIGHT", 10, 0)
    resetBtn:SetText("Reset Ledger")
    resetBtn:SetScript("OnClick", function()
        if ns.ResetLedger then
            ns.ResetLedger()
            ns.Good("Goblin ledger reset.")
            RefreshLedgerUI(f)
        end
    end)
    resetBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Reset Ledger History", 1, 0.82, 0)
        GameTooltip:AddLine("Clears all recorded flip transactions and lifetime metrics.", 1, 1, 1, true)
        GameTooltip:Show()
    end)
    resetBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    local bottomClose = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    bottomClose:SetSize(100, 24)
    bottomClose:SetPoint("BOTTOMRIGHT", -26, 18)
    bottomClose:SetText("Close")
    bottomClose:SetScript("OnClick", function() f:Hide() end)

    f:SetScript("OnShow", function(self)
        RefreshLedgerUI(self)
    end)

    ledgerFrame = f
    return ledgerFrame
end

function ns.OpenLedger()
    local f = CreateLedgerFrameOnce()
    if f then
        f:Show()
        f:Raise()
        RefreshLedgerUI(f)
    end
end

function ns.ToggleLedger()
    if ledgerFrame and ledgerFrame:IsShown() then
        ledgerFrame:Hide()
    else
        ns.OpenLedger()
    end
end
