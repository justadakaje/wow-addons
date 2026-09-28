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
    local L, warn = {}, false
    local tabs = AuctionHouseFrame and AuctionHouseFrame.Tabs

    if type(tabs) ~= "table" then
        L[#L + 1] = "The auction house tab list could not be read, so overlap cannot be checked."
    elseif #tabs == BLIZZARD_TABS then
        L[#L + 1] = { "Blizzard tabs", tostring(#tabs) }
    elseif #tabs > BLIZZARD_TABS then
        L[#L + 1] = { "Blizzard tabs", tostring(#tabs) }
        L[#L + 1] = ("%d tab(s) were added directly by another addon, outside the shared tab library."):format(#tabs - BLIZZARD_TABS)
    else
        L[#L + 1] = { warn = ("The auction house reports %d tabs where %d were measured. Something has changed."):format(#tabs, BLIZZARD_TABS) }
        warn = true
    end

    local st = SharedRow()
    if st and type(st.Tabs) == "table" then
        L[#L + 1] = { "Other addon tabs", tostring(#st.Tabs - 1) }
    else
        L[#L + 1] = "The number of other addon tabs could not be read."
    end

    local overlapped = RowIsOverlapped()
    if overlapped == true then
        L[#L + 1] = { warn = "A tab added outside the shared tab library is drawn under this row. Tabs may overlap." }
        warn = true
    elseif overlapped == nil then
        L[#L + 1] = "Whether any tabs overlap could not be determined."
    end
    return L, warn
end

---------------------------------------------------------------------------
-- Panel

local MAX_ROWS, ROW_HEIGHT = 12, 20
local COLUMNS = {
    { key = "name",    x = 0,   w = 300, j = "LEFT",  title = "Material" },
    { key = "now",     x = 310, w = 140, j = "RIGHT", title = "Lowest now" },
    { key = "typical", x = 460, w = 140, j = "RIGHT", title = "Typical" },
    { key = "below",   x = 610, w = 70,  j = "RIGHT", title = "Below" },
    { key = "qty",     x = 690, w = 60,  j = "RIGHT", title = "Listed" },
}

local ui = { rows = {} }
local requested = {}  -- itemIDs whose names we have asked the client to load
local OpenInBuy, ShowRowTip  -- defined below; rows call them on click/hover

-- clickable rows highlight on hover and open their deal in the Buy view.
local function MakeRow(anchor, font, clickable)
    local row = CreateFrame("Frame", nil, panel)
    row:SetHeight(ROW_HEIGHT)
    row:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, 0)
    row:SetPoint("RIGHT", panel, "RIGHT")
    row.cells = {}
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
        end)
        row:SetScript("OnMouseUp", function(self, button)
            if button == "LeftButton" and self.deal then OpenInBuy(self.deal) end
        end)
    end
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
    ui.title:SetPoint("TOPLEFT", panel, "TOPLEFT")
    ui.title:SetJustifyH("LEFT")

    ui.sub = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    ui.sub:SetPoint("TOPLEFT", ui.title, "BOTTOMLEFT", 0, -6)
    ui.sub:SetPoint("RIGHT", panel, "RIGHT")
    ui.sub:SetJustifyH("LEFT")

    local spacer = CreateFrame("Frame", nil, panel)
    spacer:SetSize(1, 14)
    spacer:SetPoint("TOPLEFT", ui.sub, "BOTTOMLEFT")

    ui.header = MakeRow(spacer, "GameFontNormalSmall")
    for _, col in ipairs(COLUMNS) do ui.header.cells[col.key]:SetText(col.title) end

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
end

local function Money(copper)
    return C_CurrencyInfo.GetCoinTextureString(math.floor(copper), 12)
end

-- Browse results carry no item names. Ask the client once per item; the
-- ITEM_DATA_LOAD_RESULT handler below refreshes when a name arrives.
local function ItemName(d)
    if d.name then return d.name end
    local name = C_Item.GetItemNameByID(d.itemID)
    if name then
        local rec = ns.db and ns.db.items[d.itemID]
        if rec then rec.name = name end
        return name
    end
    if not requested[d.itemID] then
        requested[d.itemID] = true
        C_Item.RequestLoadItemDataByID(d.itemID)
    end
    return ("|cff999999Item %d (loading)|r"):format(d.itemID)
end

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

ShowRowTip = function(row)
    local d = row.deal
    if not d then return end
    local tip = GameTooltip
    tip:SetOwner(row, "ANCHOR_RIGHT")
    tip:AddLine(ItemName(d), 1, 1, 1)
    tip:AddDoubleLine("Lowest now", Money(d.now), 1, 0.82, 0, 1, 1, 1)
    tip:AddDoubleLine("Typical", Money(d.typical), 1, 0.82, 0, 1, 1, 1)
    tip:AddLine(" ")
    tip:AddLine("Click to see its listings in the Buy view.", 0.4, 1, 0.4, true)
    tip:AddLine("Check the price there before buying: per unit versus per stack is not yet measured.", 0.8, 0.8, 0.8, true)
    tip:Show()
end

-- Safe to call any time: does nothing until the panel exists and is shown.
function ns.RefreshPanel()
    if not (panel and panel:IsShown()) then return end

    local deals, status = ns.FindDeals()
    local title, sub = ns.DealStatus(deals, status)
    local hasDeals = #deals > 0

    ui.title:SetShown(hasDeals)
    ui.sub:SetShown(hasDeals)
    ui.header:SetShown(hasDeals)
    ui.emptyTitle:SetShown(not hasDeals)
    ui.emptySub:SetShown(not hasDeals)

    if hasDeals then
        ui.title:SetText(title)
        if #deals > MAX_ROWS then
            sub = sub .. (" Showing the %d deepest discounts."):format(MAX_ROWS)
        end
        ui.sub:SetText(sub)
    else
        ui.emptyTitle:SetText(title)
        ui.emptySub:SetText(sub)
    end

    for i = 1, MAX_ROWS do
        local row, d = ui.rows[i], deals[i]
        if d then
            row.cells.name:SetText(ItemName(d))
            row.cells.now:SetText(Money(d.now))
            row.cells.typical:SetText(Money(d.typical))
            row.cells.below:SetText(("|cff40ff40%d%%|r"):format(math.floor(d.below * 100 + 0.5)))
            row.cells.qty:SetText(tostring(d.qty))
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
end

local function CheckOverlap()
    if warnedOverlap or not created then return end
    if RowIsOverlapped() == true then
        warnedOverlap = true
        ns.Warn("Another addon added an auction house tab without the shared tab library. It may overlap the GoldFinder tab. Hover the GoldFinder footer for details.")
    end
end

local events = CreateFrame("Frame")
events:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")
events:SetScript("OnEvent", function(_, _, interactionType)
    if interactionType ~= Enum.PlayerInteractionType.Auctioneer then return end
    CreateTabOnce()
    -- Other addons may add their tabs in the same frame; look after they have.
    C_Timer.After(0, CheckOverlap)
end)
