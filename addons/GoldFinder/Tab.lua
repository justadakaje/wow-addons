-- GoldFinder -- Tab
-- One "GoldFinder" tab on the auction house, added through LibAHTab so it
-- shares a single tab row with every other addon that uses the library.
--
-- Collision model:
--   * Other LibAHTab users: LibStub makes the library a singleton, so all
--     their tabs and ours live in one list and chain left to right.
--   * Tab ID clash: CreateTab errors on a reused ID; we check first and say so.
--   * Addons that bypass LibAHTab and append to AuctionHouseFrame.Tabs
--     directly: cannot be prevented, only detected. LibAHTab anchors its row
--     to whatever Tabs[#Tabs] was when the row was built; if that is no longer
--     the last tab, a raw tab now sits under the row. We report that rather
--     than let it overlap silently.
--
-- AuctionHouseFrame, its Tabs table and PanelTemplates_* are Blizzard Lua,
-- invisible to the API index. Each was confirmed present by an in-client
-- type() check before this file was written; the tab was first seen working
-- on build 70009, alongside Auctionator's four LibAHTab tabs.
--
-- Layout follows Blizzard's own AH: an empty state is a centred gold title
-- with one plain sentence; results get a gold count and a table. Diagnostics
-- live in a single grey footer line, bottom right (clear of the money
-- display, bottom left), with the detail in a tooltip.

local ADDON, ns = ...

local L = ns.L or setmetatable({}, { __index = function(_, k) return k end })

local TAB_ID     = "GoldFinder"
local TAB_TEXT   = "GoldFinder"
local TAB_HEADER = "GoldFinder"

-- Blizzard's own tab count (Buy, Sell, Auctions), measured
-- in-client 2026-09-27. A baseline, not a guarantee.
local BLIZZARD_TABS = 3

local LibAHTab = LibStub("LibAHTab-1-0")

local created, deferred, warnedOverlap = false, false, false
local panel

---------------------------------------------------------------------------
-- Tab row diagnostics

-- LibAHTab keeps its row in lib.internalState. That is internal, not API:
-- every read here is nil-guarded and a missing field becomes "unknown".
local function SharedRow()
    local st = LibAHTab.internalState
    if type(st) ~= "table" then return nil end
    return st
end

-- nil when it cannot be determined; otherwise true/false.
local function RowIsOverlapped()
    local st = SharedRow()
    local tabs = AuctionHouseFrame and AuctionHouseFrame.Tabs
    if not st or not st.rootFrame or type(tabs) ~= "table" or #tabs == 0 then
        return nil
    end
    local _, anchoredTo = st.rootFrame:GetPoint(1)
    return anchoredTo ~= tabs[#tabs]
end

-- Returns tooltip lines (same shape as ns.ScanStatus().lines) and whether
-- anything needs the player's attention.
local function TabRowStatus()
    local tipLines, warn = {}, false
    local tabs = AuctionHouseFrame and AuctionHouseFrame.Tabs

    if type(tabs) ~= "table" then
        tipLines[#tipLines + 1] = "The auction house tab list could not be read, so overlap cannot be checked."
    elseif #tabs == BLIZZARD_TABS then
        tipLines[#tipLines + 1] = { "Blizzard tabs", tostring(#tabs) }
    elseif #tabs > BLIZZARD_TABS then
        tipLines[#tipLines + 1] = { "Blizzard tabs", tostring(#tabs) }
        tipLines[#tipLines + 1] = ("%d tab(s) were added directly by another addon, outside the shared tab library."):format(#tabs - BLIZZARD_TABS)
    else
        tipLines[#tipLines + 1] = { warn = ("The auction house reports %d tabs where %d were measured. Something has changed."):format(#tabs, BLIZZARD_TABS) }
        warn = true
    end

    local st = SharedRow()
    if st and type(st.Tabs) == "table" then
        tipLines[#tipLines + 1] = { "Other addon tabs", tostring(#st.Tabs - 1) }
    else
        tipLines[#tipLines + 1] = "The number of other addon tabs could not be read."
    end

    local overlapped = RowIsOverlapped()
    if overlapped == true then
        tipLines[#tipLines + 1] = { warn = "A tab added outside the shared tab library is drawn under this row. Tabs may overlap." }
        warn = true
    elseif overlapped == nil then
        tipLines[#tipLines + 1] = "Whether any tabs overlap could not be determined."
    end
    return tipLines, warn
end

---------------------------------------------------------------------------
-- Panel

local MAX_ROWS, ROW_HEIGHT = 12, 20
local COLUMNS = {
    { key = "name",    x = 20,  w = 210, j = "LEFT",  title = L["Material"] },
    { key = "now",     x = 235, w = 110, j = "RIGHT", title = L["Lowest now"] },
    { key = "typical", x = 350, w = 110, j = "RIGHT", title = L["Typical"] },
    { key = "below",   x = 465, w = 60,  j = "RIGHT", title = L["Below"] },
    { key = "qty",     x = 530, w = 50,  j = "RIGHT", title = L["Listed"] },
    { key = "profit",  x = 585, w = 145, j = "RIGHT", title = L["Est. Profit"] },
}

local ui = { rows = {} }
local requested = {}  -- itemIDs whose names we have asked the client to load
local OpenInBuy, ShowRowTip, ItemName, QuickBuy  -- defined below; rows call them on click/hover

-- clickable rows highlight on hover and open their deal in the Buy view.
local function MakeRow(anchor, font, clickable)
    local row = CreateFrame("Frame", nil, panel)
    row:SetHeight(ROW_HEIGHT)
    row:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, 0)
    row:SetPoint("RIGHT", panel, "RIGHT")
    row.cells = {}
    row.tierBg = row:CreateTexture(nil, "BACKGROUND")
    row.tierBg:SetAllPoints(row)
    row.tierBg:Hide()
    if clickable then
        row.hl = row:CreateTexture(nil, "BACKGROUND")
        row.hl:SetAllPoints(row)
        row.hl:SetColorTexture(1, 0.82, 0, 0.12)
        row.hl:Hide()
        row:EnableMouse(true)
        row:SetScript("OnEnter", function(self)
            self.hl:Show()
            ShowRowTip(self)
        end)
        row:SetScript("OnLeave", function(self)
            self.hl:Hide()
            GameTooltip:Hide()
            if ns.HideSparkline then ns.HideSparkline() end
        end)
        row:SetScript("OnMouseUp", function(self, button)
            if not self.deal then return end
            if button == "LeftButton" then
                if self.deal.isUndercut then
                    local name = (ItemName and ItemName(self.deal)) or self.deal.name or ("Item %d"):format(self.deal.itemID)
                    local ok, err = pcall(C_AuctionHouse.CancelAuction, self.deal.auctionID)
                    if ok then
                        ns.Good("Cancelling undercut auction for %s...", name)
                    else
                        ns.Bad("Failed to cancel auction: %s", tostring(err))
                    end
                elseif IsAltKeyDown() then
                    if ns.AddToCart then
                        ns.AddToCart(self.deal, self.deal.qty or 1)
                    end
                elseif IsShiftKeyDown() then
                    QuickBuy(self.deal)
                else
                    OpenInBuy(self.deal)
                end
            elseif button == "RightButton" then
                local name = (ItemName and ItemName(self.deal)) or self.deal.name or ("Item %d"):format(self.deal.itemID)
                if IsAltKeyDown() then
                    local isIgnored = ns.ToggleBlacklist(self.deal.itemID)
                    if isIgnored then
                        ns.Good("Blacklisted %s. Item will no longer appear in GoldFinder deals.", name)
                    else
                        ns.Print("Removed %s from blacklist.", name)
                    end
                    ns.RefreshPanel()
                elseif IsShiftKeyDown() then
                    local activeCat = ns.GetActiveCategory()
                    local customCat = ns.GetCustomCategory and ns.GetCustomCategory(activeCat)
                    if customCat then
                        if customCat.items and customCat.items[self.deal.itemID] then
                            ns.RemoveCustomCategoryItem(activeCat, self.deal.itemID)
                            ns.Good("Removed %s from group '%s'.", name, customCat.label or activeCat)
                        else
                            ns.AddCustomCategoryItem(activeCat, self.deal.itemID)
                            ns.Good("Added %s to group '%s'.", name, customCat.label or activeCat)
                        end
                        ns.RefreshPanel()
                    else
                        local isWatched = ns.ToggleWatchlist(self.deal.itemID)
                        if isWatched then
                            ns.Good("Added %s to watchlist.", name)
                        else
                            ns.Print("Removed %s from watchlist.", name)
                        end
                        ns.RefreshPanel()
                    end
                else
                    local isWatched = ns.ToggleWatchlist(self.deal.itemID)
                    if isWatched then
                        ns.Good("Added %s to watchlist.", name)
                    else
                        ns.Print("Removed %s from watchlist.", name)
                    end
                    ns.RefreshPanel()
                end
            end
        end)
    end

    local star = CreateFrame("Button", nil, row)
    star:SetPoint("LEFT", row, "LEFT", 0, 0)
    star:SetSize(18, ROW_HEIGHT)
    local starIcon = star:CreateTexture(nil, "ARTWORK")
    starIcon:SetSize(14, 14)
    starIcon:SetPoint("CENTER", star, "CENTER", 0, 0)
    starIcon:SetTexture("Interface\\Common\\ReputationStar")
    star.icon = starIcon
    star:SetScript("OnClick", function(self)
        local pRow = self:GetParent()
        if pRow.deal and pRow.deal.itemID then
            local id = pRow.deal.itemID
            local isWatched = ns.ToggleWatchlist(id)
            local name = (ItemName and ItemName(pRow.deal)) or pRow.deal.name or ("Item %d"):format(id)
            if isWatched then
                ns.Good("Added %s to watchlist.", name)
            else
                ns.Print("Removed %s from watchlist.", name)
            end
            ns.RefreshPanel()
        end
    end)
    star:SetScript("OnEnter", function(self)
        local pRow = self:GetParent()
        if not pRow.deal then return end
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        local isWatched = ns.IsWatched(pRow.deal.itemID)
        GameTooltip:SetText(isWatched and "Watchlist: click to remove" or "Watchlist: click to add", 1, 1, 1)
        GameTooltip:Show()
        if not isWatched and self.icon then
            self.icon:SetAlpha(0.7)
            self.icon:SetVertexColor(1, 0.9, 0.4)
        end
    end)
    star:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
        local pRow = self:GetParent()
        if pRow and pRow.deal and self.icon then
            local isWatched = ns.IsWatched(pRow.deal.itemID)
            if not isWatched then
                self.icon:SetTexCoord(0.5, 1, 0, 0.5)
                self.icon:SetVertexColor(0.5, 0.5, 0.5)
                self.icon:SetAlpha(0.3)
            end
        end
    end)
    row.star = star
    for _, col in ipairs(COLUMNS) do
        local fs = row:CreateFontString(nil, "OVERLAY", font)
        fs:SetPoint("LEFT", row, "LEFT", col.x, 0)
        fs:SetWidth(col.w)
        fs:SetJustifyH(col.j)
        fs:SetWordWrap(false)
        row.cells[col.key] = fs
    end
    return row
end

local function AddDetailLines(tip, lines)
    for _, line in ipairs(lines) do
        if type(line) == "string" then
            tip:AddLine(line, 0.8, 0.8, 0.8, true)
        elseif line.warn then
            tip:AddLine(line.warn, 1, 0.6, 0, true)
        else
            tip:AddDoubleLine(line[1], line[2], 1, 0.82, 0, 1, 1, 1)
        end
    end
end

local function ShowDetails(owner)
    local deals, status = ns.FindDeals()
    local tip = GameTooltip
    tip:SetOwner(owner, "ANCHOR_TOPRIGHT")
    tip:AddLine("GoldFinder", 1, 0.82, 0)
    tip:AddLine(" ")
    tip:AddLine("Price history", 1, 1, 1)
    AddDetailLines(tip, ns.DealDetails(status))
    tip:AddLine(" ")
    tip:AddLine("Last scan", 1, 1, 1)
    AddDetailLines(tip, ns.ScanStatus().lines)
    tip:AddLine(" ")
    tip:AddLine("Tab row", 1, 1, 1)
    AddDetailLines(tip, (TabRowStatus()))
    tip:Show()
end

local function BuildPanel()
    panel = CreateFrame("Frame", nil, AuctionHouseFrame)
    panel:SetPoint("TOPLEFT", AuctionHouseFrame, "TOPLEFT", 20, -76)
    panel:SetPoint("BOTTOMRIGHT", AuctionHouseFrame, "BOTTOMRIGHT", -20, 14)

    -- Results view: gold count, one sentence, then the table.
    ui.title = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    ui.title:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, 0)
    ui.title:SetJustifyH("LEFT")

    ui.sub = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    ui.sub:SetPoint("TOPLEFT", ui.title, "BOTTOMLEFT", 0, -6)
    ui.sub:SetJustifyH("LEFT")

    -- Row 1: Options & Search Box
    local optBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    optBtn:SetSize(68, 22)
    optBtn:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -10, -2)
    optBtn:SetText(L["Options"])
    optBtn:SetScript("OnClick", function()
        if ns.OpenConfig then
            ns.OpenConfig()
        elseif ns.ToggleConfig then
            ns.ToggleConfig()
        end
    end)
    optBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
        GameTooltip:SetText("GoldFinder Options", 1, 0.82, 0)
        GameTooltip:AddLine("Open graphical settings panel to configure deal thresholds, sound alerts, and filters.", 1, 1, 1, true)
        GameTooltip:Show()
    end)
    optBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    ui.optionsButton = optBtn

    local search = CreateFrame("EditBox", nil, panel, "SearchBoxTemplate")
    search:SetSize(130, 22)
    search:SetPoint("TOPRIGHT", optBtn, "TOPLEFT", -8, 0)
    search:SetAutoFocus(false)
    search.Instructions:SetText(L["Search deals..."])
    search:SetScript("OnTextChanged", function(self)
        SearchBoxTemplate_OnTextChanged(self)
        ns.RefreshPanel()
    end)
    search:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)
    search:SetScript("OnEnterPressed", function(self)
        self:ClearFocus()
    end)
    ui.searchBox = search

    ui.title:SetPoint("RIGHT", search, "LEFT", -12, 0)

    -- Row 2: Staging Cart & Snipe Mode
    local cartBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    cartBtn:SetSize(68, 22)
    cartBtn:SetPoint("TOPRIGHT", optBtn, "BOTTOMRIGHT", 0, -4)
    cartBtn:SetText(L["Cart (0)"])
    cartBtn:SetScript("OnClick", function()
        if ns.ToggleCart then ns.ToggleCart() end
    end)
    cartBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
        GameTooltip:SetText("Staging Cart", 1, 0.82, 0)
        local n, items, cost, profit = ns.GetCartTotals and ns.GetCartTotals() or 0, 0, 0, 0
        GameTooltip:AddLine(("Staged lots: %d (%d items)"):format(n or 0, items or 0), 1, 1, 1)
        if cost and cost > 0 then
            GameTooltip:AddDoubleLine("Total Cost:", ns.Money(cost), 0.8, 0.8, 0.8, 1, 1, 1)
            GameTooltip:AddDoubleLine("Est. Flip Profit:", "+" .. ns.Money(profit or 0), 0.8, 0.8, 0.8, 0.25, 1, 0.25)
        end
        GameTooltip:AddLine(" ")
        GameTooltip:AddLine("Click: open staging cart window.", 0.4, 0.8, 1)
        GameTooltip:AddLine("Alt-Click any deal row to stage items into cart.", 0.6, 0.6, 0.6)
        GameTooltip:Show()
    end)
    cartBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    ui.cartButton = cartBtn

    local snipeBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    snipeBtn:SetSize(90, 22)
    snipeBtn:SetPoint("TOPRIGHT", cartBtn, "TOPLEFT", -8, 0)
    snipeBtn:SetText(L["Snipe: OFF"])
    snipeBtn:SetScript("OnClick", function()
        if ns.SetSnipeMode then
            ns.SetSnipeMode(not ns.IsSnipeMode())
        end
    end)
    snipeBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
        GameTooltip:SetText("Live Snipe Engine", 1, 0.82, 0)
        GameTooltip:AddLine("Actively watches for ultra-deep discounts and high-profit mega flips.", 1, 1, 1, true)
        GameTooltip:AddLine("Triggers loud raid warning alarm on qualifying deals.", 1, 1, 1, true)
        GameTooltip:AddLine(" ")
        local status = ns.IsSnipeMode and ns.IsSnipeMode() and "|cff40ff40ACTIVE|r" or "|cff888888OFF|r"
        GameTooltip:AddDoubleLine("Status:", status, 0.8, 0.8, 0.8, 1, 1, 1)
        local thresh = ns.GetSnipeThreshold and ns.GetSnipeThreshold() or 1000000
        GameTooltip:AddDoubleLine("Alarm Threshold:", ns.Money(thresh) .. " net profit", 0.8, 0.8, 0.8, 1, 0.82, 0)
        GameTooltip:AddLine("Click to toggle Snipe Mode.", 0.4, 0.8, 1)
        GameTooltip:Show()
    end)
    snipeBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    ui.snipeButton = snipeBtn

    ui.sub:SetPoint("RIGHT", snipeBtn, "LEFT", -12, 0)

    function ns.UpdateCartButton()
        if ui.cartButton and ns.GetCartTotals then
            local entriesCount = ns.GetCartTotals()
            if entriesCount and entriesCount > 0 then
                ui.cartButton:SetText((L["Cart (%d)"]):format(entriesCount))
            else
                ui.cartButton:SetText(L["Cart (0)"])
            end
        end
    end

    function ns.UpdateSnipeButton()
        if ui.snipeButton and ns.IsSnipeMode then
            if ns.IsSnipeMode() then
                ui.snipeButton:SetText("|cff40ff40" .. L["Snipe: ON"] .. "|r")
            else
                ui.snipeButton:SetText(L["Snipe: OFF"])
            end
        end
    end

    local createGroupDialog = nil
    local function ShowCreateGroupDialog()
        if not createGroupDialog then
            local template = BackdropTemplateMixin and "BackdropTemplate" or nil
            local f = CreateFrame("Frame", "GoldFinderCreateGroupDialog", UIParent, template)
            f:SetSize(320, 140)
            f:SetPoint("CENTER", UIParent, "CENTER", 0, 80)
            f:SetFrameStrata("FULLSCREEN_DIALOG")
            if f.SetFrameLevel then f:SetFrameLevel(200) end
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

            local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            title:SetPoint("TOP", 0, -16)
            title:SetText("Create Material Group")

            local hint = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            hint:SetPoint("TOP", title, "BOTTOM", 0, -6)
            hint:SetText("Enter a name for the new custom category tab:")

            local eb = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
            eb:SetSize(220, 22)
            eb:SetPoint("TOP", hint, "BOTTOM", 0, -10)
            eb:SetAutoFocus(false)
            f.editBox = eb

            local createBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
            createBtn:SetSize(90, 22)
            createBtn:SetPoint("BOTTOMLEFT", 45, 16)
            createBtn:SetText("Create")

            local function doCreate()
                local text = eb:GetText():match("^%s*(.-)%s*$")
                if text and text ~= "" then
                    local id, cat = ns.CreateCustomCategory(text)
                    if cat then
                        ns.Good("Created custom material group: %s.", cat.label)
                        ns.SetActiveCategory(id)
                        if ns.RefreshPanel then ns.RefreshPanel() end
                    end
                    f:Hide()
                    eb:SetText("")
                end
            end

            createBtn:SetScript("OnClick", doCreate)
            eb:SetScript("OnEnterPressed", doCreate)
            eb:SetScript("OnEscapePressed", function()
                f:Hide()
                eb:SetText("")
            end)

            local cancelBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
            cancelBtn:SetSize(90, 22)
            cancelBtn:SetPoint("BOTTOMRIGHT", -45, 16)
            cancelBtn:SetText("Cancel")
            cancelBtn:SetScript("OnClick", function()
                f:Hide()
                eb:SetText("")
            end)

            createGroupDialog = f
        end

        createGroupDialog:Show()
        createGroupDialog:Raise()
        createGroupDialog.editBox:SetText("")
        createGroupDialog.editBox:SetFocus()
    end
    ns.ShowCreateGroupDialog = ShowCreateGroupDialog

    local CATEGORIES = {
        { id = "all",         label = L["All"],       width = 44 },
        { id = "herbs",       label = L["Herbs"],     width = 54 },
        { id = "mining",      label = L["Mining"],    width = 58 },
        { id = "cloth",       label = L["Cloth"],     width = 52 },
        { id = "leather",     label = L["Leather"],   width = 62 },
        { id = "conversions", label = L["Crafts"],    width = 56 },
        { id = "undercuts",   label = L["Undercuts"], width = 74 },
        { id = "shopping",    label = L["Shopping"],  width = 68 },
        { id = "watchlist",   label = L["Watchlist"], width = 84, isWatchlist = true },
    }
    if _G.BiSGearFinder or (C_AddOns and C_AddOns.IsAddOnLoaded and C_AddOns.IsAddOnLoaded("BiSGearFinder")) then
        CATEGORIES[#CATEGORIES + 1] = { id = "bis", label = "BiS BoEs", width = 74 }
    end
    local categoryButtons = {}
    local createGroupBtn = nil

    local function UpdateCategoryButtons()
        local active = ns.GetActiveCategory()
        for _, btn in ipairs(categoryButtons) do
            local isActive = (btn.catId == active)
            if isActive then
                if btn.SetBackdropColor then
                    btn:SetBackdropColor(0.22, 0.18, 0.10, 0.95)
                    btn:SetBackdropBorderColor(0.85, 0.70, 0.20, 1.0)
                end
                if btn.activeBar then btn.activeBar:Show() end
                if btn.label then btn.label:SetTextColor(1.0, 0.82, 0.0) end
                if btn.starIcon then btn.starIcon:SetAlpha(1.0) end
            else
                if btn.SetBackdropColor then
                    btn:SetBackdropColor(0.10, 0.10, 0.12, 0.85)
                    btn:SetBackdropBorderColor(0.24, 0.24, 0.28, 0.8)
                end
                if btn.activeBar then btn.activeBar:Hide() end
                if btn.label then btn.label:SetTextColor(0.75, 0.75, 0.78) end
                if btn.starIcon then btn.starIcon:SetAlpha(0.55) end
            end
        end
    end
    ui.UpdateCategoryButtons = UpdateCategoryButtons
    ns.UpdateCategoryButtons = UpdateCategoryButtons

    local filterBar = CreateFrame("Frame", nil, panel)
    filterBar:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, -56)
    filterBar:SetSize(620, 24)
    ui.filterBar = filterBar

    local function RebuildCategoryButtons()
        if not filterBar then return end

        for _, btn in ipairs(categoryButtons) do
            btn:Hide()
        end
        if createGroupBtn then createGroupBtn:Hide() end

        local allCats = {}
        for _, c in ipairs(CATEGORIES) do
            allCats[#allCats + 1] = {
                id = c.id,
                label = c.label,
                width = c.width,
                isWatchlist = c.isWatchlist,
                isCustom = false,
            }
        end

        local customCats = ns.GetCustomCategories and ns.GetCustomCategories() or {}
        local customList = {}
        for id, c in pairs(customCats) do
            customList[#customList + 1] = { id = id, label = c.label or id }
        end
        table.sort(customList, function(a, b) return (a.label or a.id) < (b.label or b.id) end)

        for _, c in ipairs(customList) do
            local textLen = string.len(c.label)
            local w = math.max(54, math.min(120, textLen * 8 + 16))
            allCats[#allCats + 1] = {
                id = c.id,
                label = c.label,
                width = w,
                isCustom = true,
            }
        end

        local curX = 0
        local curY = 0
        local rowHeight = 22
        local spacing = 5
        local maxLineWidth = 730

        for i, cat in ipairs(allCats) do
            local btn = categoryButtons[i]
            if not btn then
                btn = CreateFrame("Button", nil, filterBar, BackdropTemplateMixin and "BackdropTemplate" or nil)
                btn:SetHeight(rowHeight)
                if btn.SetBackdrop then
                    btn:SetBackdrop({
                        bgFile = "Interface\\Buttons\\WHITE8X8",
                        edgeFile = "Interface\\Buttons\\WHITE8X8",
                        edgeSize = 1,
                        insets = { left = 1, right = 1, top = 1, bottom = 1 },
                    })
                end

                local activeBar = btn:CreateTexture(nil, "OVERLAY")
                activeBar:SetHeight(2)
                activeBar:SetPoint("BOTTOMLEFT", btn, "BOTTOMLEFT", 1, 1)
                activeBar:SetPoint("BOTTOMRIGHT", btn, "BOTTOMRIGHT", -1, 1)
                activeBar:SetColorTexture(1, 0.82, 0, 1)
                activeBar:Hide()
                btn.activeBar = activeBar

                local star = btn:CreateTexture(nil, "ARTWORK")
                star:SetSize(13, 13)
                star:SetTexture("Interface\\Common\\ReputationStar")
                star:SetTexCoord(0, 0.5, 0, 0.5)
                star:SetPoint("LEFT", btn, "LEFT", 7, 0)
                star:Hide()
                btn.starIcon = star

                local label = btn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
                label:SetPoint("CENTER", btn, "CENTER", 0, 0)
                btn.label = label

                btn:RegisterForClicks("LeftButtonUp", "RightButtonUp")
                btn:SetScript("OnClick", function(self, button)
                    if button == "RightButton" and self.isCustom then
                        local customCat = ns.GetCustomCategory and ns.GetCustomCategory(self.catId)
                        local cLabel = customCat and customCat.label or self.catId
                        ns.DeleteCustomCategory(self.catId)
                        ns.Good("Deleted custom material group '%s'.", cLabel)
                    else
                        ns.SetActiveCategory(self.catId)
                        UpdateCategoryButtons()
                        PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB or 841)
                        ns.RefreshPanel()
                    end
                end)

                btn:SetScript("OnEnter", function(self)
                    local active = ns.GetActiveCategory()
                    if self.catId ~= active then
                        if self.SetBackdropColor then
                            self:SetBackdropColor(0.18, 0.18, 0.22, 0.95)
                            self:SetBackdropBorderColor(0.45, 0.45, 0.50, 1.0)
                        end
                        if self.label then self.label:SetTextColor(1.0, 1.0, 1.0) end
                        if self.starIcon and self.starIcon:IsShown() then self.starIcon:SetAlpha(0.9) end
                    end
                    if self.isCustom then
                        local customCat = ns.GetCustomCategory and ns.GetCustomCategory(self.catId)
                        local count = 0
                        if customCat and customCat.items then
                            for _ in pairs(customCat.items) do count = count + 1 end
                        end
                        GameTooltip:SetOwner(self, "ANCHOR_TOP")
                        GameTooltip:SetText(customCat and customCat.label or self.catId, 1, 0.82, 0)
                        GameTooltip:AddLine(("Custom material group (%d items)."):format(count), 1, 1, 1)
                        GameTooltip:AddLine("Left-Click: Filter to this group.", 0.4, 0.8, 1)
                        GameTooltip:AddLine("Right-Click: Delete this group.", 1, 0.4, 0.4)
                        GameTooltip:Show()
                    end
                end)
                btn:SetScript("OnLeave", function(self)
                    local active = ns.GetActiveCategory()
                    if self.catId ~= active then
                        if self.SetBackdropColor then
                            self:SetBackdropColor(0.10, 0.10, 0.12, 0.85)
                            self:SetBackdropBorderColor(0.24, 0.24, 0.28, 0.8)
                        end
                        if self.label then self.label:SetTextColor(0.75, 0.75, 0.78) end
                        if self.starIcon and self.starIcon:IsShown() then self.starIcon:SetAlpha(0.55) end
                    end
                    GameTooltip:Hide()
                end)

                categoryButtons[i] = btn
            end

            btn.catId = cat.id
            btn.baseLabel = cat.label
            btn.isCustom = cat.isCustom
            btn.label:SetText(cat.label)
            local textW = (btn.label.GetStringWidth and btn.label:GetStringWidth() or 40) + 16
            if cat.isWatchlist then textW = textW + 16 end
            local btnW = math.max(cat.width or 44, math.ceil(textW))
            btn:SetWidth(btnW)

            if cat.isWatchlist then
                btn.starIcon:Show()
                btn.label:ClearAllPoints()
                btn.label:SetPoint("LEFT", btn.starIcon, "RIGHT", 4, 0)
            else
                btn.starIcon:Hide()
                btn.label:ClearAllPoints()
                btn.label:SetPoint("CENTER", btn, "CENTER", 0, 0)
            end

            if curX + btnW > maxLineWidth and curX > 0 then
                curX = 0
                curY = curY - (rowHeight + 4)
            end

            btn:ClearAllPoints()
            btn:SetPoint("TOPLEFT", filterBar, "TOPLEFT", curX, curY)
            btn:Show()

            curX = curX + btnW + spacing
        end

        local plusW = 60
        if curX + plusW > maxLineWidth and curX > 0 then
            curX = 0
            curY = curY - (rowHeight + 4)
        end

        if not createGroupBtn then
            createGroupBtn = CreateFrame("Button", nil, filterBar, BackdropTemplateMixin and "BackdropTemplate" or nil)
            createGroupBtn:SetHeight(rowHeight)
            if createGroupBtn.SetBackdrop then
                createGroupBtn:SetBackdrop({
                    bgFile = "Interface\\Buttons\\WHITE8X8",
                    edgeFile = "Interface\\Buttons\\WHITE8X8",
                    edgeSize = 1,
                    insets = { left = 1, right = 1, top = 1, bottom = 1 },
                })
                createGroupBtn:SetBackdropColor(0.08, 0.14, 0.18, 0.85)
                createGroupBtn:SetBackdropBorderColor(0.2, 0.45, 0.65, 0.8)
            end
            local plusLabel = createGroupBtn:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            plusLabel:SetPoint("CENTER", createGroupBtn, "CENTER", 0, 0)
            plusLabel:SetText("+ Group")
            plusLabel:SetTextColor(0.3, 0.8, 1.0)
            createGroupBtn.label = plusLabel

            createGroupBtn:SetScript("OnClick", function()
                ShowCreateGroupDialog()
            end)
            createGroupBtn:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_TOP")
                GameTooltip:SetText("Create Material Group", 1, 0.82, 0)
                GameTooltip:AddLine("Define a custom category tab for specific crafting reagents or arbitrage items.", 1, 1, 1, true)
                GameTooltip:AddLine("You can also use: /gf group create <name>", 0.7, 0.7, 0.7)
                GameTooltip:Show()
            end)
            createGroupBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
        end

        createGroupBtn:SetWidth(plusW)
        createGroupBtn:ClearAllPoints()
        createGroupBtn:SetPoint("TOPLEFT", filterBar, "TOPLEFT", curX, curY)
        createGroupBtn:Show()

        local totalBarHeight = math.abs(curY) + rowHeight
        filterBar:SetHeight(totalBarHeight)

        UpdateCategoryButtons()
    end
    ns.RebuildCategoryButtons = RebuildCategoryButtons

    RebuildCategoryButtons()

    ui.header = MakeRow(filterBar, "GameFontNormalSmall")
    for _, col in ipairs(COLUMNS) do ui.header.cells[col.key]:SetText(col.title) end

    -- Interactive sort buttons on Below and Est. Profit column headers
    local sortBelow = CreateFrame("Button", nil, ui.header)
    sortBelow:SetPoint("LEFT", ui.header, "LEFT", 465, 0)
    sortBelow:SetSize(60, ROW_HEIGHT)
    sortBelow:SetScript("OnClick", function()
        ns.SetSortBy("discount")
        ns.RefreshPanel()
    end)
    sortBelow:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Click to sort by Discount %", 1, 1, 1)
        GameTooltip:Show()
    end)
    sortBelow:SetScript("OnLeave", function() GameTooltip:Hide() end)

    local sortProfit = CreateFrame("Button", nil, ui.header)
    sortProfit:SetPoint("LEFT", ui.header, "LEFT", 585, 0)
    sortProfit:SetSize(145, ROW_HEIGHT)
    sortProfit:SetScript("OnClick", function()
        ns.SetSortBy("profit")
        ns.RefreshPanel()
    end)
    sortProfit:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Click to sort by Estimated Net Profit (after 5% AH cut)", 1, 1, 1)
        GameTooltip:Show()
    end)
    sortProfit:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -- Tooltip on Typical column header explaining active valuation model (#38)
    local tipTypical = CreateFrame("Frame", nil, ui.header)
    tipTypical:SetPoint("LEFT", ui.header, "LEFT", 350, 0)
    tipTypical:SetSize(110, ROW_HEIGHT)
    tipTypical:EnableMouse(true)
    tipTypical:SetScript("OnEnter", function(self)
        local model = ns.GetValuationModel and ns.GetValuationModel() or "median"
        local info = ns.VALUATION_MODELS and ns.VALUATION_MODELS[model]
        GameTooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip:SetText("Typical Price Baseline: " .. (info and info.name or "Median"), 1, 0.82, 0)
        GameTooltip:AddLine(info and info.desc or "Statistical price baseline.", 1, 1, 1, true)
        GameTooltip:AddLine("Configure via Options or /gf valuation <median|trimmed|ema>", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    tipTypical:SetScript("OnLeave", function() GameTooltip:Hide() end)

    local anchor = ui.header
    for i = 1, MAX_ROWS do
        ui.rows[i] = MakeRow(anchor, "GameFontHighlight", true)
        anchor = ui.rows[i]
    end

    -- Empty view: centred, like Blizzard's "No results found".
    ui.emptyTitle = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    ui.emptyTitle:SetPoint("CENTER", panel, "CENTER", 0, 24)

    ui.emptySub = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    ui.emptySub:SetPoint("TOP", ui.emptyTitle, "BOTTOM", 0, -10)
    ui.emptySub:SetWidth(520)
    ui.emptySub:SetJustifyH("CENTER")

    -- Footer: one grey line, bottom right; hover for detail.
    ui.footer = CreateFrame("Frame", nil, panel)
    ui.footer:SetSize(360, 16)
    ui.footer:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT")
    ui.footer:EnableMouse(true)
    ui.footer:SetScript("OnEnter", ShowDetails)
    ui.footer:SetScript("OnLeave", function() GameTooltip:Hide() end)

    ui.footerText = ui.footer:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    ui.footerText:SetPoint("RIGHT", ui.footer, "RIGHT")
    ui.footerText:SetJustifyH("RIGHT")

    panel:SetScript("OnShow", function() ns.RefreshPanel() end)
    panel:SetScript("OnHide", function()
        if ui.searchBox then ui.searchBox:ClearFocus() end
    end)
end

local Money = ns.Money

-- Browse results carry no item names. Ask the client once per item; the
-- ITEM_DATA_LOAD_RESULT handler below refreshes when a name arrives.
ItemName = function(d)
    if not d then return "" end
    if d.isConversion then
        return d.name or "Craft"
    end
    if d.itemID then
        -- Query authoritative client localized name (respects active locale like deDE)
        local name = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(d.itemID))
        if not name or name == "" then
            if GetItemInfo then name = GetItemInfo(d.itemID) end
        end
        if name and name ~= "" then
            if ns.db and ns.db.items and ns.db.items[d.itemID] then
                ns.db.items[d.itemID].name = name
            end
            d.name = name
            return name
        end
        if not requested[d.itemID] then
            requested[d.itemID] = true
            if C_Item and C_Item.RequestLoadItemDataByID then
                C_Item.RequestLoadItemDataByID(d.itemID)
            end
        end
    end
    if d.name and d.name ~= "" then return d.name end
    return ("|cff999999" .. (L["Item %d (loading)"]):format(d.itemID or 0) .. "|r")
end
ns.ItemName = ItemName

local function KeyFor(d)
    if d.itemKey then return d.itemKey, true end
    -- Recorded before v0.0.6 saved exact keys: level/suffix 0 is a guess
    -- that fits most materials. The next Full Scan stores the real key.
    return C_AuctionHouse.MakeItemKey(d.itemID), false
end

-- Opens the deal in Blizzard's own Buy view, where the real listings and
-- Blizzard's purchase confirmation live. GoldFinder finds; Blizzard buys.
--
-- SelectBrowseResult is Blizzard Lua, invisible to the API index; its
-- presence was type()-checked in-client. What it does with the argument is
-- NOT verified -- it is handed a table shaped like the documented
-- BrowseResultInfo, the same thing a click in Blizzard's own list passes.
OpenInBuy = function(d)
    local key, exact = KeyFor(d)
    local name = ItemName(d)
    if not C_AuctionHouse.GetItemKeyInfo(key) then
        C_Item.RequestLoadItemDataByID(d.itemID)
        ns.Warn("%s is still loading from the server. Click it again in a moment.", name)
        return
    end
    -- Select Blizzard's Buy tab first, as a player would, so Blizzard sets
    -- the title and tab highlight itself (v0.0.6 opened the view under the
    -- GoldFinder title with no tab lit). Tabs[1] is Buy: the order Buy,
    -- Sell, Auctions was measured in-client. Back then returns to Buy.
    local buyTab = type(AuctionHouseFrame.Tabs) == "table" and AuctionHouseFrame.Tabs[1]
    if buyTab and type(buyTab.Click) == "function" then
        pcall(buyTab.Click, buyTab)
    end

    local ok, err = pcall(AuctionHouseFrame.SelectBrowseResult, AuctionHouseFrame, {
        itemKey = key, minPrice = math.floor(d.now), totalQuantity = d.qty,
        containsOwnerItem = false,
    })
    if not ok then
        ns.Bad("Could not open %s in the Buy view: %s", name, tostring(err))
    elseif not exact then
        ns.Print("Opened %s by item ID. If no listings show, run a Full Scan and try again.", name)
    end
end

QuickBuy = function(d)
    if not (AuctionHouseFrame and AuctionHouseFrame:IsShown()) then
        ns.Warn("The auction house must be open to use Quick-Buy.")
        return
    end

    if ns.pendingQuickBuy then
        ns.Warn("A Quick-Buy purchase is already in progress for %s. Please wait.", ns.pendingQuickBuy.name)
        return
    end

    local key, exact = KeyFor(d)
    local name = ItemName(d)
    local keyInfo = C_AuctionHouse.GetItemKeyInfo(key)
    if not keyInfo then
        C_Item.RequestLoadItemDataByID(d.itemID)
        ns.Warn("%s is still loading from the server. Click again in a moment.", name)
        return
    end

    if not keyInfo.isCommodity then
        ns.Print("%s is not a commodity. Opening in Buy tab instead.", name)
        OpenInBuy(d)
        return
    end

    local availableQty = math.max(1, d.qty or 1)
    local unitPrice = math.floor(d.now or 0)
    local maxSpend = ns.GetMaxQuickBuySpend and ns.GetMaxQuickBuySpend() or 500000

    local qtyToBuy = availableQty
    if maxSpend > 0 and unitPrice > 0 then
        local maxAffordable = math.floor(maxSpend / unitPrice)
        if maxAffordable < 1 then
            ns.Warn("Quick-Buy cancelled: 1x %s costs %s, exceeding your max spend cap of %s. Use /gf maxspend to raise cap.",
                name, Money(unitPrice), Money(maxSpend))
            return
        end
        if qtyToBuy > maxAffordable then
            qtyToBuy = maxAffordable
        end
    end

    ns.pendingQuickBuy = {
        itemID            = d.itemID,
        name              = name,
        quantity          = qtyToBuy,
        expectedUnitPrice = unitPrice,
        maxSpend          = maxSpend,
        deal              = d,
        startedAt         = GetTime(),
    }

    -- Safety timeout: clear after 6 seconds if server does not respond
    C_Timer.After(6, function()
        if ns.pendingQuickBuy and ns.pendingQuickBuy.itemID == d.itemID then
            ns.Warn("Quick-Buy request timed out for %s.", ns.pendingQuickBuy.name)
            ns.pendingQuickBuy = nil
        end
    end)

    local ok, err = pcall(C_AuctionHouse.StartCommoditiesPurchase, d.itemID, qtyToBuy)
    if not ok then
        ns.Bad("Could not initiate commodity quick-buy for %s: %s", name, tostring(err))
        ns.pendingQuickBuy = nil
    else
        ns.Print("Quick-buying %dx %s (%s each, max total %s)...",
            qtyToBuy, name, Money(unitPrice), Money(qtyToBuy * unitPrice))
    end
end
ns.QuickBuy = QuickBuy

ShowRowTip = function(row)
    local d = row.deal
    if not d then return end
    local tip = GameTooltip
    tip:SetOwner(row, "ANCHOR_RIGHT")
    tip:AddLine(ItemName(d), 1, 1, 1)

    if d.isUndercut then
        tip:AddLine("Active Auction: Undercut Alert", 1, 0.25, 0.25)
        tip:AddDoubleLine("Your listed price", Money(d.typical), 1, 0.82, 0, 1, 1, 1)
        tip:AddDoubleLine("Lowest competitor price", Money(d.now), 1, 0.82, 0, 1, 0.25, 0.25)
        tip:AddDoubleLine("Undercut by", ("%s (%d%%)"):format(Money(d.typical - d.now), math.floor(d.below * 100 + 0.5)), 1, 0.82, 0, 1, 0.4, 0.4)
        tip:AddDoubleLine("Listed quantity", tostring(d.qty), 1, 0.82, 0, 1, 1, 1)
        tip:AddLine(" ")
        tip:AddLine("Click: cancel auction to relist at current market price.", 0.25, 1, 0.25, true)
        tip:Show()
    if ns.ShowSparkline then
        ns.ShowSparkline(tip, d.history, d.typical, d.now)
    end
        return
    end

    if d.isShopping then
        tip:AddLine("Shopping Target Quota", 0, 0.8, 1)
        tip:AddDoubleLine("Target Quota", tostring(d.target), 1, 0.82, 0, 1, 1, 1)
        tip:AddDoubleLine("In Bags / Bank", tostring(d.acquired), 1, 0.82, 0, 1, 1, 1)
        local pctFulfilled = d.target > 0 and math.floor((d.acquired / d.target) * 100) or 100
        local remColor = (d.remaining == 0) and {0.25, 1, 0.25} or {1, 0.82, 0}
        tip:AddDoubleLine("Remaining Needed", ("%d (%d%% fulfilled)"):format(d.remaining, pctFulfilled), 1, 0.82, 0, remColor[1], remColor[2], remColor[3])
        tip:AddLine(" ")
        tip:AddDoubleLine("Lowest AH Price", d.now > 0 and Money(d.now) or "None listed", 1, 0.82, 0, 1, 1, 1)
        tip:AddDoubleLine("Max Willing to Pay", d.maxUnitPrice and Money(d.maxUnitPrice) or "No cap set", 1, 0.82, 0, 1, 1, 1)
        tip:AddDoubleLine("Est. Gold to Complete", Money(d.totalCost), 1, 0.82, 0, 0.25, 1, 0.25)
        tip:AddLine(" ")
        tip:AddLine("Left-Click: open item in Buy view.", 0.4, 0.8, 1, true)
        tip:AddLine("Shift-Click: direct Quick-Buy batch.", 0.4, 0.8, 1, true)
        tip:AddLine("Type /gf unbuy <item> to remove from shopping list.", 0.6, 0.6, 0.6, true)
        tip:Show()
    if ns.ShowSparkline then
        ns.ShowSparkline(tip, d.history, d.typical, d.now)
    end
        return
    end

    if d.isConversion then
        tip:AddLine("Crafting Conversion Arbitrage", 0.4, 0.8, 1)
        tip:AddDoubleLine("Total Reagent Cost", Money(d.now), 1, 0.82, 0, 1, 1, 1)
        tip:AddDoubleLine("Net Output Value", Money(d.typical), 1, 0.82, 0, 1, 1, 1)
        tip:AddDoubleLine("Return on Investment (ROI)", ("+%d%%"):format(math.floor((d.roi or 0) * 100 + 0.5)), 1, 0.82, 0, 0.25, 1, 0.25)
        tip:AddLine(" ")
        tip:AddLine("Required Reagents:", 1, 0.82, 0)
        if d.reagents then
            for _, r in ipairs(d.reagents) do
                local rName = C_Item.GetItemNameByID(r.itemID) or ("Item " .. r.itemID)
                tip:AddDoubleLine(("  %dx %s"):format(r.qty, rName), Money(r.totalCost), 0.8, 0.8, 0.8, 1, 1, 1)
            end
        end
        tip:AddLine(" ")
        tip:AddLine("Profitability (after 5% AH cut):", 1, 0.82, 0)
        local totalNetStr = "+" .. Money(d.totalNetProfit or 0)
        tip:AddDoubleLine("Est. net craft profit", totalNetStr, 0.8, 0.8, 0.8, 0.25, 1, 0.25)
        tip:AddLine(" ")
        tip:AddLine("Left-Click: open crafted item in Buy view.", 0.4, 0.8, 1, true)
        tip:Show()
    if ns.ShowSparkline then
        ns.ShowSparkline(tip, d.history, d.typical, d.now)
    end
        return
    end
    local tier = d.tier or (ns.GetDealTier and ns.GetDealTier(d))
    if tier then
        tip:AddDoubleLine("Deal tier", tier.colorStr .. tier.label .. "|r", 1, 0.82, 0, tier.r, tier.g, tier.b)
    end
    tip:AddDoubleLine("Lowest now", Money(d.now), 1, 0.82, 0, 1, 1, 1)
    tip:AddDoubleLine("Typical (median)", Money(d.typical), 1, 0.82, 0, 1, 1, 1)
    tip:AddDoubleLine("Discount", ("%d%% below typical"):format(math.floor(d.below * 100 + 0.5)), 1, 0.82, 0, 0.25, 1, 0.25)
    tip:AddDoubleLine("Listed quantity", tostring(d.qty), 1, 0.82, 0, 1, 1, 1)

    if d.trend then
        tip:AddLine(" ")
        tip:AddDoubleLine("Price trend:", d.trend.label, 1, 0.82, 0, d.trend.r, d.trend.g, d.trend.b)
        if d.trend.warning then
            tip:AddLine(d.trend.warning, 1, 0.45, 0.2, true)
        end
    end

    if d.confidence then
        tip:AddLine(" ")
        tip:AddDoubleLine("Market depth:", d.confidence.colorStr .. d.confidence.label .. "|r", 1, 0.82, 0, d.confidence.r, d.confidence.g, d.confidence.b)
        if d.confidence.reason then
            tip:AddLine(d.confidence.reason, 0.75, 0.75, 0.75, true)
        end
    end

    tip:AddLine(" ")
    tip:AddLine("Profitability (after 5% AH cut):", 1, 0.82, 0)
    local unitNetStr = (d.netUnitProfit and d.netUnitProfit > 0 and "+" or "") .. Money(d.netUnitProfit or 0)
    tip:AddDoubleLine("Est. unit net profit", unitNetStr, 0.8, 0.8, 0.8, 1, 1, 1)
    local totalNetStr = (d.totalNetProfit and d.totalNetProfit > 0 and "+" or "") .. Money(d.totalNetProfit or 0)
    tip:AddDoubleLine("Est. total flip profit", totalNetStr, 0.8, 0.8, 0.8, 0.25, 1, 0.25)

    if d.history and #d.history > 1 then
        tip:AddLine(" ")
        tip:AddLine("Recent lowest prices:", 1, 0.82, 0)
        local h = d.history
        local now = GetServerTime()
        local maxRecent = math.min(3, #h - 1)
        for i = #h - 1, #h - maxRecent, -1 do
            local pt = h[i]
            local age = now - (pt.seen or pt.t)
            local ageStr
            if age < 60 then
                ageStr = "<1m ago"
            elseif age < 3600 then
                ageStr = ("%dm ago"):format(math.floor(age / 60))
            else
                ageStr = ("%.0fh ago"):format(age / 3600)
            end
            tip:AddDoubleLine("  " .. ageStr, Money(pt.min), 0.7, 0.7, 0.7, 1, 1, 1)
        end
    end

    tip:AddLine(" ")
    tip:AddDoubleLine("Watchlist:", ns.IsWatched(d.itemID) and "|cffffd100Starred|r" or "|cff888888Not starred|r", 1, 0.82, 0, 1, 1, 1)
    tip:AddLine("Left-Click: open in Buy. Shift-Click: direct Quick-Buy commodity.", 0.4, 0.8, 1, true)
    tip:AddLine("Alt-Click: Stage deal into Multi-Item Cart.", 0.25, 1, 0.5, true)
    tip:AddLine("Right-Click or click star: toggle Watchlist.", 0.4, 0.8, 1, true)
    tip:AddLine("Alt+Right-Click: Blacklist/ignore item from deals.", 0.8, 0.45, 0.45, true)
    if ns.GetCustomCategory and ns.GetCustomCategory(ns.GetActiveCategory()) then
        local customCat = ns.GetCustomCategory(ns.GetActiveCategory())
        local inGroup = customCat.items and customCat.items[d.itemID]
        tip:AddLine(("Shift+Right-Click: %s group '%s'."):format(inGroup and "Remove from" or "Add to", customCat.label or ns.GetActiveCategory()), 0.4, 1.0, 0.6, true)
    end
    tip:Show()
    if ns.ShowSparkline then
        ns.ShowSparkline(tip, d.history, d.typical, d.now)
    end
end

-- Safe to call any time: does nothing until the panel exists and is shown.
function ns.RefreshPanel()
    if not (panel and panel:IsShown()) then return end

    local allDeals, status = ns.FindDeals()
    local title, sub = ns.DealStatus(allDeals, status)

    if ui.UpdateCategoryButtons then ui.UpdateCategoryButtons() end
    if ns.UpdateCartButton then ns.UpdateCartButton() end
    if ns.UpdateSnipeButton then ns.UpdateSnipeButton() end

    -- 1. Filter by category (#12, #39)
    local activeCat = ns.GetActiveCategory()
    local catDeals = allDeals
    if activeCat == "watchlist" then
        catDeals = {}
        for _, d in ipairs(allDeals) do
            if ns.IsWatched(d.itemID) then
                catDeals[#catDeals + 1] = d
            end
        end
    elseif activeCat == "bis" then
        catDeals = {}
        for _, d in ipairs(allDeals) do
            if d.isBiS or (_G.BiSGearFinder and _G.BiSGearFinder.IsBiSItem and _G.BiSGearFinder.IsBiSItem(d.itemID)) then
                catDeals[#catDeals + 1] = d
            end
        end
    elseif activeCat == "conversions" or activeCat == "undercuts" or activeCat == "shopping" then
        catDeals = {}
        for _, d in ipairs(allDeals) do
            if d.category == activeCat then
                catDeals[#catDeals + 1] = d
            end
        end
    elseif ns.GetCustomCategory and ns.GetCustomCategory(activeCat) then
        local customCat = ns.GetCustomCategory(activeCat)
        catDeals = {}
        for _, d in ipairs(allDeals) do
            if d.itemID and customCat.items and customCat.items[d.itemID] then
                catDeals[#catDeals + 1] = d
            end
        end
    elseif activeCat ~= "all" then
        catDeals = {}
        for _, d in ipairs(allDeals) do
            if d.category == activeCat then
                catDeals[#catDeals + 1] = d
            end
        end
    end

    -- 2. Filter deals by search query if active (#24)
    local rawQuery = ui.searchBox and ui.searchBox:GetText() or ""
    local query = rawQuery:match("^%s*(.-)%s*$") or ""
    local isSearchFiltered = (query ~= "")
    local deals = catDeals

    if isSearchFiltered then
        local qLower = query:lower()
        local qNum = tonumber(query)
        deals = {}
        for _, d in ipairs(catDeals) do
            local matched = false
            if qNum and d.itemID == qNum then
                matched = true
            else
                local name = ItemName(d)
                if name and name:lower():find(qLower, 1, true) then
                    matched = true
                elseif d.name and d.name:lower():find(qLower, 1, true) then
                    matched = true
                end
            end
            if matched then
                deals[#deals + 1] = d
            end
        end
    end

    local isCategoryFiltered = (activeCat ~= "all")
    local isFiltered = isSearchFiltered or isCategoryFiltered

    local hasDeals = #deals > 0

    local isProfit = ns.GetSortBy() == "profit"
    if activeCat == "shopping" then
        ui.header.cells.typical:SetText(L["Max Price"])
        ui.header.cells.below:SetText(L["Remaining"])
        ui.header.cells.qty:SetText(L["Needed"])
        ui.header.cells.profit:SetText(L["Est. Cost"])
    else
        ui.header.cells.typical:SetText(L["Typical"])
        ui.header.cells.below:SetText(isProfit and L["Below"] or ("|cffffd100" .. L["Below"] .. " |TInterface\\Buttons\\UI-SortArrow:10:9:0:-1:32:32:0:18:0:32|t|r"))
        ui.header.cells.qty:SetText(L["Listed"])
        ui.header.cells.profit:SetText(isProfit and ("|cffffd100" .. L["Est. Profit"] .. " |TInterface\\Buttons\\UI-SortArrow:10:9:0:-1:32:32:0:18:0:32|t|r") or L["Est. Profit"])
    end

    ui.title:SetShown(hasDeals)
    ui.sub:SetShown(hasDeals)
    ui.header:SetShown(hasDeals)
    ui.emptyTitle:SetShown(not hasDeals)
    ui.emptySub:SetShown(not hasDeals)

    local catDisplayName
    if activeCat == "watchlist" then
        catDisplayName = L["Watchlist"]
    elseif activeCat == "conversions" then
        catDisplayName = L["Crafts"]
    elseif activeCat == "undercuts" then
        catDisplayName = L["Undercuts"]
    elseif activeCat == "shopping" then
        catDisplayName = L["Shopping"]
    elseif activeCat == "bis" then
        catDisplayName = "BiS BoEs"
    elseif ns.GetCustomCategory and ns.GetCustomCategory(activeCat) then
        catDisplayName = ns.GetCustomCategory(activeCat).label or activeCat
    elseif isCategoryFiltered then
        catDisplayName = L[activeCat:sub(1,1):upper() .. activeCat:sub(2)] or (activeCat:sub(1,1):upper() .. activeCat:sub(2))
    else
        catDisplayName = activeCat:sub(1,1):upper() .. activeCat:sub(2)
    end

    if hasDeals then
        if isSearchFiltered and isCategoryFiltered then
            ui.title:SetText(("%d %s deal%s matching \"%s\""):format(#deals, catDisplayName, #deals == 1 and "" or "s", query))
        elseif isSearchFiltered then
            ui.title:SetText(("%d deal%s matching \"%s\""):format(#deals, #deals == 1 and "" or "s", query))
        elseif isCategoryFiltered then
            ui.title:SetText(("%d %s deal%s found"):format(#deals, catDisplayName, #deals == 1 and "" or "s"))
        else
            ui.title:SetText(title)
        end

        local sortName = isProfit and "highest net profit" or "deepest discounts"
        if isFiltered then
            if #deals > MAX_ROWS then
                ui.sub:SetText(("Found %d of %d total deals. Showing top %d by %s."):format(#deals, #allDeals, MAX_ROWS, sortName))
            else
                ui.sub:SetText(("Found %d of %d total deals."):format(#deals, #allDeals))
            end
        else
            if #deals > MAX_ROWS then
                sub = sub .. (" Showing the %d %s."):format(MAX_ROWS, sortName)
            end
            ui.sub:SetText(sub)
        end
    else
        if isSearchFiltered and isCategoryFiltered then
            ui.emptyTitle:SetText(("No %s deals matching \"%s\""):format(catDisplayName, query))
            ui.emptySub:SetText("Try a broader search term or select another category.")
        elseif isSearchFiltered then
            ui.emptyTitle:SetText(("No deals matching \"%s\""):format(query))
            ui.emptySub:SetText("Try a different search query or clear the search box.")
        elseif activeCat == "watchlist" then
            ui.emptyTitle:SetText("Watchlist is empty")
            ui.emptySub:SetText("Click the star next to any deal row (or Right-Click a deal) to add it to your watchlist.")
        elseif activeCat == "undercuts" then
            ui.emptyTitle:SetText("No undercut auctions")
            ui.emptySub:SetText("None of your active auctions have been undercut by competitors.")
        elseif activeCat == "shopping" then
            ui.emptyTitle:SetText("Shopping list is empty")
            ui.emptySub:SetText("Track target materials with: /gf buy <link|itemID> <targetQty> [maxUnitPrice]")
        elseif ns.GetCustomCategory and ns.GetCustomCategory(activeCat) then
            local customCat = ns.GetCustomCategory(activeCat)
            local count = 0
            if customCat and customCat.items then
                for _ in pairs(customCat.items) do count = count + 1 end
            end
            if count == 0 then
                ui.emptyTitle:SetText(("Material group '%s' is empty"):format(catDisplayName))
                ui.emptySub:SetText("Shift+Right-Click any deal row to add it to this group, or use: /gf group add \"" .. catDisplayName .. "\" <link|id>")
            else
                ui.emptyTitle:SetText(("No active deals for '%s'"):format(catDisplayName))
                ui.emptySub:SetText(("None of the %d materials in this group currently meet the discount threshold."):format(count))
            end
        elseif isCategoryFiltered then
            ui.emptyTitle:SetText(("No %s deals found"):format(catDisplayName))
            ui.emptySub:SetText(("No %s materials currently meet the discount threshold."):format(catDisplayName:lower()))
        else
            ui.emptyTitle:SetText(title)
            ui.emptySub:SetText(sub)
        end
    end

    for i = 1, MAX_ROWS do
        local row, d = ui.rows[i], deals[i]
        if d then
            local tier = d.tier or (ns.GetDealTier and ns.GetDealTier(d))
            if tier and tier.bgAlpha and tier.bgAlpha > 0 then
                row.tierBg:SetColorTexture(tier.r, tier.g, tier.b, tier.bgAlpha)
                row.tierBg:Show()
            else
                row.tierBg:Hide()
            end
            local tagPrefix = (tier and tier.tag ~= "") and (tier.colorStr .. tier.tag .. "|r ") or ""
            if row.star and row.star.icon then
                local isWatched = ns.IsWatched(d.itemID)
                if isWatched then
                    row.star.icon:SetTexCoord(0, 0.5, 0, 0.5)
                    row.star.icon:SetVertexColor(1, 0.82, 0)
                    row.star.icon:SetAlpha(1.0)
                else
                    row.star.icon:SetTexCoord(0.5, 1, 0, 0.5)
                    row.star.icon:SetVertexColor(0.5, 0.5, 0.5)
                    row.star.icon:SetAlpha(0.3)
                end
            end
            if d.isShopping then
                local progStr = ("|cff00ccff[%d/%d]|r "):format(d.acquired, d.target)
                row.cells.name:SetText(tagPrefix .. progStr .. ItemName(d))
                row.cells.now:SetText(d.now > 0 and Money(d.now) or "|cff888888None|r")
                row.cells.typical:SetText(d.maxUnitPrice and Money(d.maxUnitPrice) or "|cff888888No cap|r")
                row.cells.below:SetText(d.remaining > 0 and ("|cffffd100%d left|r"):format(d.remaining) or "|cff40ff40Done|r")
                row.cells.qty:SetText(tostring(d.remaining))
                row.cells.profit:SetText(d.totalCost > 0 and Money(d.totalCost) or "|cff40ff400c|r")
            else
                local restockTag = ""
                if d.isRestockNeeded then
                    restockTag = "|cffff9900[LOW]|r "
                end
                row.cells.name:SetText(tagPrefix .. restockTag .. ItemName(d))
                row.cells.now:SetText(Money(d.now))
                row.cells.typical:SetText(Money(d.typical))
                local color = tier and tier.colorStr or "|cff40ff40"
                row.cells.below:SetText(("%s%d%%|r"):format(color, math.floor(d.below * 100 + 0.5)))
                row.cells.qty:SetText(tostring(d.qty))
                if d.totalNetProfit and d.totalNetProfit > 0 then
                    row.cells.profit:SetText(color .. "+" .. Money(d.totalNetProfit) .. "|r")
                else
                    row.cells.profit:SetText("|cff8888880c|r")
                end
            end
            row.deal = d
            row:Show()
        else
            row.deal = nil
            row:Hide()
        end
    end

    local scan = ns.ScanStatus()
    local _, tabWarn = TabRowStatus()
    if scan.warn or tabWarn then
        ui.footerText:SetText("|cffff9900" .. scan.footer .. ", needs attention|r")
    else
        ui.footerText:SetText(scan.footer)
    end
end

-- Item names arriving from the server: refresh once, shortly after the burst.
local nameEvents, nameRefreshArmed = CreateFrame("Frame"), false
nameEvents:RegisterEvent("ITEM_DATA_LOAD_RESULT")
nameEvents:SetScript("OnEvent", function(_, _, itemID)
    if not requested[itemID] or nameRefreshArmed then return end
    nameRefreshArmed = true
    C_Timer.After(0.2, function()
        nameRefreshArmed = false
        ns.RefreshPanel()
    end)
end)

---------------------------------------------------------------------------
-- Quick-Buy commodity purchase events

local qbEvents = CreateFrame("Frame")
qbEvents:RegisterEvent("COMMODITY_PRICE_UPDATED")
qbEvents:RegisterEvent("COMMODITY_PRICE_UNAVAILABLE")
qbEvents:RegisterEvent("COMMODITY_PURCHASE_FAILED")
qbEvents:RegisterEvent("COMMODITY_PURCHASE_SUCCEEDED")
qbEvents:RegisterEvent("COMMODITY_PURCHASED")
qbEvents:RegisterEvent("OWNED_AUCTIONS_UPDATED")
qbEvents:RegisterEvent("AUCTION_CANCELED")
qbEvents:RegisterEvent("BAG_UPDATE_DELAYED")
qbEvents:RegisterEvent("AUCTION_HOUSE_CLOSED")
qbEvents:SetScript("OnEvent", function(self, event, arg1, arg2)
    if event == "OWNED_AUCTIONS_UPDATED" or event == "AUCTION_CANCELED" or event == "BAG_UPDATE_DELAYED" then
        if ns.RefreshPanel then ns.RefreshPanel() end
        return
    end

    local pb = ns.pendingQuickBuy
    if event == "AUCTION_HOUSE_CLOSED" then
        ns.pendingQuickBuy = nil
        return
    end

    if not pb then return end

    if event == "COMMODITY_PRICE_UPDATED" then
        local updatedUnitPrice, updatedTotalPrice = arg1, arg2
        -- Spend cap protection
        if pb.maxSpend > 0 and updatedTotalPrice > pb.maxSpend then
            ns.Warn("Quick-Buy cancelled: confirmed total (%s) exceeds your spend cap of %s. Raise cap with /gf maxspend.",
                Money(updatedTotalPrice), Money(pb.maxSpend))
            ns.pendingQuickBuy = nil
            return
        end
        -- Unit price spike protection (> 5% increase)
        if updatedUnitPrice > math.floor(pb.expectedUnitPrice * 1.05) then
            ns.Warn("Quick-Buy cancelled: unit price rose from %s to %s.",
                Money(pb.expectedUnitPrice), Money(updatedUnitPrice))
            ns.pendingQuickBuy = nil
            return
        end

        pb.confirmedUnitPrice = updatedUnitPrice
        pb.confirmedTotalPrice = updatedTotalPrice

        local ok, err = pcall(C_AuctionHouse.ConfirmCommoditiesPurchase, pb.itemID, pb.quantity)
        if not ok then
            ns.Bad("Could not confirm commodity purchase: %s", tostring(err))
            ns.pendingQuickBuy = nil
        end
    elseif event == "COMMODITY_PRICE_UNAVAILABLE" then
        ns.Warn("%s is no longer available at that price (already bought or cancelled).", pb.name)
        ns.pendingQuickBuy = nil
    elseif event == "COMMODITY_PURCHASE_FAILED" then
        ns.Bad("Quick-Buy failed for %s (insufficient gold or full bags).", pb.name)
        ns.pendingQuickBuy = nil
    elseif event == "COMMODITY_PURCHASE_SUCCEEDED" or event == "COMMODITY_PURCHASED" then
        local totalStr = pb.confirmedTotalPrice and Money(pb.confirmedTotalPrice) or Money(pb.expectedUnitPrice * pb.quantity)
        ns.Good("Quick-bought %dx %s for %s!", pb.quantity, pb.name, totalStr)
        if type(PlaySound) == "function" then
            pcall(PlaySound, (SOUNDKIT and SOUNDKIT.IG_BACKPACK_COIN_OK) or 895)
        end
        ns.pendingQuickBuy = nil
        if ns.RefreshPanel then ns.RefreshPanel() end
    end
end)

---------------------------------------------------------------------------
-- Creating the tab

local function CreateTabOnce()
    if created then return end

    if not AuctionHouseFrame then
        -- The AH UI is load-on-demand and may not exist yet when our handler
        -- runs. Wait one frame, once; never poll.
        if not deferred then
            deferred = true
            C_Timer.After(0, CreateTabOnce)
        else
            ns.Bad("The auction house window had not loaded when GoldFinder tried to add its tab. It will try again next time you open the auction house.")
            deferred = false
        end
        return
    end

    created = true

    if LibAHTab:DoesIDExist(TAB_ID) then
        ns.Bad("Another addon has already registered a tab with GoldFinder's ID. GoldFinder will not add a second one.")
        return
    end

    BuildPanel()
    local ok, err = pcall(LibAHTab.CreateTab, LibAHTab, TAB_ID, panel, TAB_TEXT, TAB_HEADER)
    if not ok then
        ns.Bad("The GoldFinder tab could not be added: %s", tostring(err))
    end
    if ns.InitSellHelper then ns.InitSellHelper() end
    if ns.InitBuyHelper then ns.InitBuyHelper() end
end

local function CheckOverlap()
    if warnedOverlap or not created then return end
    if RowIsOverlapped() == true then
        warnedOverlap = true
        ns.Warn("Another addon added an auction house tab without the shared tab library. It may overlap the GoldFinder tab. Hover the GoldFinder footer for details.")
    end
end

local events = CreateFrame("Frame")
if EventRegistry and Enum and Enum.PlayerInteractionType and Enum.PlayerInteractionType.Auctioneer then
    events:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")
end
events:RegisterEvent("AUCTION_HOUSE_SHOW")
events:SetScript("OnEvent", function(_, event, interactionType)
    if event == "PLAYER_INTERACTION_MANAGER_FRAME_SHOW" then
        if interactionType ~= (Enum and Enum.PlayerInteractionType and Enum.PlayerInteractionType.Auctioneer) then return end
    end
    CreateTabOnce()
    -- Other addons may add their tabs in the same frame; look after they have.
    C_Timer.After(0, CheckOverlap)
end)
