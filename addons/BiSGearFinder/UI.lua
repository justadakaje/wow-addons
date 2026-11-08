-- BiSGearFinder -- UI Browser
-- Interactive in-game BiS gear browser, scarcity monitor, and upgrade roadmap.
-- Accessible via /bgf, /bgf browse, or /bis.

local ADDON, ns = ...

local uiFrame = nil
local ROWS_PER_PAGE = 12
local currentPage = 1
local currentFilter = "ALL"
local currentClassFilter = "ALL"
local currentQuery = ""

local function GetPlayerClass()
    if UnitClass then
        local _, classFilename = UnitClass("player")
        return classFilename or "WARRIOR"
    end
    return "WARRIOR"
end

local function GetFilteredItems()
    local all = ns.GetAllBiSItems and ns.GetAllBiSItems() or {}
    local filtered = {}
    local qLower = currentQuery:lower()

    for itemID, info in pairs(all) do
        local pass = true

        -- Tier filter
        if currentFilter == "PRE_RAID" and info.tier ~= "PRE_RAID_BIS" then
            pass = false
        elseif currentFilter == "EPIC" and info.tier ~= "EPIC_WORLD_DROP" then
            pass = false
        elseif currentFilter == "TWINK" and not info.tier:find("TWINK") then
            pass = false
        end

        -- Class filter
        if pass and currentClassFilter ~= "ALL" then
            local matchedClass = false
            for _, c in ipairs(info.classes) do
                if c:upper() == currentClassFilter:upper() then
                    matchedClass = true
                    break
                end
            end
            if not matchedClass then pass = false end
        end

        -- Search text query
        if pass and qLower ~= "" then
            local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID))
                or (GetItemInfo and GetItemInfo(itemID))
                or info.name
                or ""
            if not name:lower():find(qLower, 1, true) and not tostring(itemID):find(qLower, 1, true) then
                pass = false
            end
        end

        if pass then
            filtered[#filtered + 1] = { itemID = itemID, info = info }
        end
    end

    table.sort(filtered, function(a, b)
        if (a.info.reqLevel or 0) ~= (b.info.reqLevel or 0) then
            return (a.info.reqLevel or 0) > (b.info.reqLevel or 0)
        end
        return a.itemID < b.itemID
    end)

    return filtered
end

local function FormatMoneyShort(copper)
    if not copper or copper <= 0 then return "|cff8888880c|r" end
    local g = math.floor(copper / 10000)
    local s = math.floor((copper % 10000) / 100)
    if g > 0 then
        return ("|cffffd100%dg|r |cffe6e6e6%ds|r"):format(g, s)
    else
        return ("|cffe6e6e6%ds|r"):format(s)
    end
end

local function RefreshBrowserUI()
    if not uiFrame or not uiFrame:IsShown() then return end

    local filtered = GetFilteredItems()
    local totalItems = #filtered
    local totalPages = math.max(1, math.ceil(totalItems / ROWS_PER_PAGE))

    if currentPage > totalPages then currentPage = totalPages end
    if currentPage < 1 then currentPage = 1 end

    uiFrame.pageText:SetText(("Page %d of %d (%d items)"):format(currentPage, totalPages, totalItems))
    uiFrame.prevBtn:SetEnabled(currentPage > 1)
    uiFrame.nextBtn:SetEnabled(currentPage < totalPages)

    local startIndex = (currentPage - 1) * ROWS_PER_PAGE

    for i = 1, ROWS_PER_PAGE do
        local row = uiFrame.rows[i]
        local itemData = filtered[startIndex + i]

        if itemData then
            local itemID = itemData.itemID
            local info = itemData.info
            row.itemID = itemID
            row.info = info

            local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID))
                or (GetItemInfo and GetItemInfo(itemID))
                or info.name
                or ("Item " .. itemID)

            local icon = (C_Item and C_Item.GetItemIconByID and C_Item.GetItemIconByID(itemID))
                or (GetItemIcon and GetItemIcon(itemID))
                or 134400

            row.icon:SetTexture(icon)
            row.nameText:SetText(name)
            row.slotText:SetText((info.armorType or "") .. " " .. (info.slot:gsub("INVTYPE_", "") or ""))
            row.lvlText:SetText(tostring(info.reqLevel or 1))
            row.classesText:SetText(table.concat(info.classes, "/"))

            -- Market & Scarcity status
            local market = ns.GetCachedItemMarket and ns.GetCachedItemMarket(itemID)
            local scarcity = ns.GetItemScarcity and ns.GetItemScarcity(itemID)

            if scarcity == "SCARCE" then
                row.ahStatusText:SetText("|cffff4040[UNLISTED]|r")
            elseif scarcity == "MONOPOLY_SINGLE" and market and market.lowest > 0 then
                row.ahStatusText:SetText(FormatMoneyShort(market.lowest) .. " |cffff9900(1 left)|r")
            elseif market and market.lowest > 0 then
                row.ahStatusText:SetText(FormatMoneyShort(market.lowest))
            else
                row.ahStatusText:SetText("|cff888888Unchecked|r")
            end

            row:Show()
        else
            row.itemID = nil
            row:Hide()
        end
    end
end

local function CreateBrowserFrame()
    if uiFrame then return uiFrame end

    local template = BackdropTemplateMixin and "BackdropTemplate" or nil
    local f = CreateFrame("Frame", "BiSGearFinderFrame", UIParent, template)
    f:SetSize(720, 520)
    f:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
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
    if f.SetBackdropColor then f:SetBackdropColor(0, 0, 0, 1) end

    local solidBg = f:CreateTexture(nil, "BACKGROUND", nil, -8)
    solidBg:SetPoint("TOPLEFT", 6, -6)
    solidBg:SetPoint("BOTTOMRIGHT", -6, 6)
    solidBg:SetColorTexture(0.08, 0.08, 0.10, 0.98)

    tinsert(UISpecialFrames, "BiSGearFinderFrame")

    -- Header
    local headerTex = f:CreateTexture(nil, "ARTWORK")
    headerTex:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
    headerTex:SetSize(360, 64)
    headerTex:SetPoint("TOP", 0, 12)

    local titleText = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleText:SetPoint("TOP", headerTex, "TOP", 0, -14)
    titleText:SetText("BiSGearFinder — BoE Radar")

    local subText = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    subText:SetPoint("TOP", 0, -30)
    subText:SetText("Curated pre-raid BiS gear, realm scarcity radar, and market valuation.")

    local closeBtn = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -6, -6)
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    -- Filter Buttons
    local function MakeFilterBtn(x, text, filterVal)
        local btn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        btn:SetSize(80, 22)
        btn:SetPoint("TOPLEFT", x, -54)
        btn:SetText(text)
        btn:SetScript("OnClick", function()
            currentFilter = filterVal
            currentPage = 1
            RefreshBrowserUI()
        end)
        return btn
    end

    MakeFilterBtn(24, "All", "ALL")
    MakeFilterBtn(108, "Pre-Raid", "PRE_RAID")
    MakeFilterBtn(192, "Epics", "EPIC")
    MakeFilterBtn(276, "Twinks", "TWINK")

    local myClassBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    myClassBtn:SetSize(90, 22)
    myClassBtn:SetPoint("TOPLEFT", 360, -54)
    myClassBtn:SetText("My Class")
    myClassBtn:SetScript("OnClick", function()
        if currentClassFilter == "ALL" then
            currentClassFilter = GetPlayerClass()
            myClassBtn:SetText("|cff40ff40" .. currentClassFilter .. "|r")
        else
            currentClassFilter = "ALL"
            myClassBtn:SetText("My Class")
        end
        currentPage = 1
        RefreshBrowserUI()
    end)

    -- Scan AH Button
    local scanBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    scanBtn:SetSize(110, 22)
    scanBtn:SetPoint("TOPRIGHT", -26, -54)
    scanBtn:SetText("Scan AH Now")
    scanBtn:SetScript("OnClick", function()
        if ns.StartBiSScan then
            ns.StartBiSScan()
        end
    end)

    -- Table Header
    local thead = CreateFrame("Frame", nil, f)
    thead:SetSize(668, 20)
    thead:SetPoint("TOPLEFT", 26, -82)

    local colDefs = {
        { title = "Item",        x = 30,  w = 230, j = "LEFT" },
        { title = "Slot / Type", x = 265, w = 140, j = "LEFT" },
        { title = "Req",         x = 410, w = 40,  j = "CENTER" },
        { title = "Classes",     x = 455, w = 100, j = "LEFT" },
        { title = "AH Lowest",   x = 560, w = 100, j = "RIGHT" },
    }

    for _, c in ipairs(colDefs) do
        local fs = thead:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        fs:SetPoint("LEFT", thead, "LEFT", c.x, 0)
        fs:SetWidth(c.w)
        fs:SetJustifyH(c.j)
        fs:SetText(c.title)
    end

    -- Rows
    f.rows = {}
    local prevAnchor = thead
    for i = 1, ROWS_PER_PAGE do
        local row = CreateFrame("Button", nil, f)
        row:SetSize(668, 24)
        row:SetPoint("TOPLEFT", prevAnchor, "BOTTOMLEFT", 0, -2)

        local hl = row:CreateTexture(nil, "BACKGROUND")
        hl:SetAllPoints(row)
        hl:SetColorTexture(1, 0.82, 0, 0.08)
        hl:Hide()
        row.hl = hl

        local icon = row:CreateTexture(nil, "ARTWORK")
        icon:SetSize(20, 20)
        icon:SetPoint("LEFT", 4, 0)
        row.icon = icon

        local nameText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        nameText:SetPoint("LEFT", icon, "RIGHT", 6, 0)
        nameText:SetWidth(200)
        nameText:SetJustifyH("LEFT")
        nameText:SetWordWrap(false)
        row.nameText = nameText

        local slotText = row:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        slotText:SetPoint("LEFT", row, "LEFT", 265, 0)
        slotText:SetWidth(140)
        slotText:SetJustifyH("LEFT")
        row.slotText = slotText

        local lvlText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        lvlText:SetPoint("LEFT", row, "LEFT", 410, 0)
        lvlText:SetWidth(40)
        lvlText:SetJustifyH("CENTER")
        row.lvlText = lvlText

        local classesText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        classesText:SetPoint("LEFT", row, "LEFT", 455, 0)
        classesText:SetWidth(100)
        classesText:SetJustifyH("LEFT")
        classesText:SetWordWrap(false)
        row.classesText = classesText

        local ahStatusText = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        ahStatusText:SetPoint("RIGHT", row, "RIGHT", -8, 0)
        ahStatusText:SetWidth(100)
        ahStatusText:SetJustifyH("RIGHT")
        row.ahStatusText = ahStatusText

        row:EnableMouse(true)
        row:SetScript("OnEnter", function(self)
            self.hl:Show()
            if self.itemID then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetItemByID(self.itemID)
                GameTooltip:Show()
            end
        end)
        row:SetScript("OnLeave", function(self)
            self.hl:Hide()
            GameTooltip:Hide()
        end)
        row:SetScript("OnClick", function(self)
            if self.itemID and AuctionHouseFrame and AuctionHouseFrame:IsShown() and C_AuctionHouse and C_AuctionHouse.MakeItemKey and C_AuctionHouse.SendSearchQuery then
                local key = C_AuctionHouse.MakeItemKey(self.itemID)
                if key then
                    C_AuctionHouse.SendSearchQuery(key, {}, false)
                    ns.Good("Searching AH for item %d...", self.itemID)
                end
            elseif self.itemID and ChatEdit_InsertLink then
                local link = nil
                if GetItemInfo then
                    local _
                    _, link = GetItemInfo(self.itemID)
                end
                if not link and C_Item and C_Item.GetItemLinkByID then
                    link = C_Item.GetItemLinkByID(self.itemID)
                end
                if link then ChatEdit_InsertLink(link) end
            end
        end)

        f.rows[i] = row
        prevAnchor = row
    end

    -- Pagination Bottom Controls
    local prevBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    prevBtn:SetSize(80, 22)
    prevBtn:SetPoint("BOTTOMLEFT", 26, 16)
    prevBtn:SetText("Prev")
    prevBtn:SetScript("OnClick", function()
        currentPage = currentPage - 1
        RefreshBrowserUI()
    end)
    f.prevBtn = prevBtn

    local nextBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    nextBtn:SetSize(80, 22)
    nextBtn:SetPoint("LEFT", prevBtn, "RIGHT", 8, 0)
    nextBtn:SetText("Next")
    nextBtn:SetScript("OnClick", function()
        currentPage = currentPage + 1
        RefreshBrowserUI()
    end)
    f.nextBtn = nextBtn

    local pageText = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    pageText:SetPoint("LEFT", nextBtn, "RIGHT", 16, 0)
    f.pageText = pageText

    local bottomClose = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    bottomClose:SetSize(80, 22)
    bottomClose:SetPoint("BOTTOMRIGHT", -26, 16)
    bottomClose:SetText("Close")
    bottomClose:SetScript("OnClick", function() f:Hide() end)

    f:SetScript("OnShow", function()
        RefreshBrowserUI()
    end)

    uiFrame = f
    return uiFrame
end

function ns.OpenBrowser()
    local f = CreateBrowserFrame()
    if f then
        f:Show()
        f:Raise()
        RefreshBrowserUI()
    end
end

function ns.ToggleBrowser()
    if uiFrame and uiFrame:IsShown() then
        uiFrame:Hide()
    else
        ns.OpenBrowser()
    end
end

ns.RefreshUI = RefreshBrowserUI
