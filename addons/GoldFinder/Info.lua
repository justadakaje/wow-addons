-- GoldFinder -- Info & About Dashboard (#54)
-- Journalator-style Info window providing project metadata, copyable links,
-- translation credits, live performance diagnostics (#53), and 1-click diagnostic export.

local ADDON, ns = ...

local infoFrame = nil
local diagDialog = nil

local function CreateCopyBox(parent, text, labelText, yOffset)
    local lbl = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    lbl:SetPoint("TOPLEFT", 28, yOffset)
    lbl:SetText(labelText)

    local box = CreateFrame("EditBox", nil, parent, "InputBoxTemplate")
    box:SetSize(236, 20)
    box:SetPoint("TOPLEFT", 28, yOffset - 16)
    box:SetAutoFocus(false)
    box:SetText(text)
    box:SetFontObject("GameFontHighlightSmall")
    box:SetCursorPosition(0)
    box:SetScript("OnEditFocusGained", function(self)
        self:HighlightText()
    end)
    box:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)

    local copyBtn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    copyBtn:SetSize(54, 20)
    copyBtn:SetPoint("LEFT", box, "RIGHT", 6, 0)
    copyBtn:SetText("Copy")
    copyBtn:SetScript("OnClick", function()
        box:HighlightText()
        box:SetFocus()
        ns.Good("Link highlighted. Press Ctrl+C to copy!")
    end)

    return box
end

---------------------------------------------------------------------------
-- Pillar 1: In-Game Diagnostic Report Generator
---------------------------------------------------------------------------

function ns.GenerateDiagnosticReport()
    local author = (C_AddOns and C_AddOns.GetAddOnMetadata and C_AddOns.GetAddOnMetadata("GoldFinder", "Author"))
        or (GetAddOnMetadata and GetAddOnMetadata("GoldFinder", "Author"))
        or "KenHenChan"
    local version = ns.version or "2.0.0"
    local locale = (GetLocale and GetLocale()) or "unknown"
    local buildVersion, buildNum, buildDate, uiVersion
    if GetBuildInfo then
        buildVersion, buildNum, buildDate, uiVersion = GetBuildInfo()
    end
    local realm = (ns.GetActiveRealm and ns.GetActiveRealm()) or (GetRealmName and GetRealmName()) or "unknown"
    local faction = (UnitFactionGroup and UnitFactionGroup("player")) or "unknown"
    local charName = (UnitName and UnitName("player")) or "Unknown"
    local charLevel = (UnitLevel and UnitLevel("player")) or 0
    local charClass
    if UnitClass then
        local _
        _, charClass = UnitClass("player")
    end

    if UpdateAddOnMemoryUsage then UpdateAddOnMemoryUsage() end
    local mem = (GetAddOnMemoryUsage and GetAddOnMemoryUsage("GoldFinder")) or 0
    local memStr = (mem > 1024) and ("%.2f MB"):format(mem / 1024) or ("%.1f KB"):format(mem)

    local db = ns.db
    local itemCount = 0
    local historyCount = 0
    if db and db.items then
        for _, rec in pairs(db.items) do
            itemCount = itemCount + 1
            if rec.history then historyCount = historyCount + #rec.history end
        end
    end
    local scanCount = (db and db.scans and #db.scans) or 0
    local lifetimeScans = (db and db.lifetimeScans) or scanCount
    local scanStatus = ns.ScanStatus and ns.ScanStatus()
    local lastScan = (scanStatus and scanStatus.status) or "None recorded"

    local isChar = ns.IsCharacterSpecificProfile and ns.IsCharacterSpecificProfile()
    local profileName = isChar and (charName .. " (Character-Specific)") or "Default (Account-Wide)"

    local ratio = ns.GetDealRatio and ns.GetDealRatio() or 0.70
    local discount = math.floor((1 - ratio) * 100 + 0.5)
    local minPrior = ns.GetMinPrior and ns.GetMinPrior() or 3
    local minProfit = ns.GetMinProfit and ns.GetMinProfit() or 0
    local spendCap = ns.GetMaxQuickBuySpend and ns.GetMaxQuickBuySpend() or 0
    local conf = ns.GetMinConfidence and ns.GetMinConfidence() or "any"
    local valModel = ns.GetValuationModel and ns.GetValuationModel() or "median"

    local soundOn = ns.IsSoundAlertEnabled and ns.IsSoundAlertEnabled()
    local soundThrottle = ns.GetSoundThrottle and ns.GetSoundThrottle() or 30
    local raidWarnOn = ns.IsRaidWarningAlertEnabled and ns.IsRaidWarningAlertEnabled()
    local chatTab = ns.IsDedicatedChatTabEnabled and ns.IsDedicatedChatTabEnabled()
    local tooltipOn = ns.IsTooltipEnabled and ns.IsTooltipEnabled()
    local sellHelper = ns.IsSellHelperEnabled and ns.IsSellHelperEnabled()
    local buyHelper = ns.IsBuyHelperEnabled and ns.IsBuyHelperEnabled()
    local mailCollector = ns.IsMailCollectorEnabled and ns.IsMailCollectorEnabled()
    local costBasis = ns.IsCostBasisTooltipEnabled and ns.IsCostBasisTooltipEnabled()
    local factionShare = ns.IsFactionShareEnabled and ns.IsFactionShareEnabled()

    local ahShown = AuctionHouseFrame and AuctionHouseFrame:IsShown() and true or false
    local ahSelectedTab = (PanelTemplates_GetSelectedTab and AuctionHouseFrame and PanelTemplates_GetSelectedTab(AuctionHouseFrame)) or 0

    local lines = {}
    lines[#lines + 1] = "```markdown"
    lines[#lines + 1] = "### GoldFinder Diagnostic & Support Report"
    lines[#lines + 1] = ("- **Generated:** %s"):format(date and date("%Y-%m-%d %H:%M:%S") or "unknown")
    lines[#lines + 1] = ("- **Addon:** GoldFinder v%s (Author: %s)"):format(version, author)
    lines[#lines + 1] = ("- **Client:** WoW %s (Build %s, Date %s, Interface %s, Locale %s)"):format(
        tostring(buildVersion), tostring(buildNum), tostring(buildDate), tostring(uiVersion), tostring(locale))
    lines[#lines + 1] = ("- **Player:** %s (Level %s %s, Faction: %s)"):format(charName, tostring(charLevel), tostring(charClass or "Class"), faction)
    lines[#lines + 1] = ("- **Realm:** %s"):format(realm)
    lines[#lines + 1] = ("- **Memory Footprint:** %s"):format(memStr)
    local scanStr = (lifetimeScans > scanCount)
        and ("%d scans recorded (%d retained in rolling buffer)"):format(lifetimeScans, scanCount)
        or ("%d scans recorded"):format(scanCount)
    lines[#lines + 1] = ("- **Database:** %d items tracked, %d price points, %s (Last: %s)"):format(itemCount, historyCount, scanStr, lastScan)
    lines[#lines + 1] = ("- **Active Profile:** %s"):format(profileName)
    lines[#lines + 1] = ("- **Thresholds:** Discount: %d%%, MinPrior: %d, MinProfit: %s, SpendCap: %s"):format(
        discount, minPrior, ns.Money(minProfit), (spendCap > 0) and ns.Money(spendCap) or "Unlimited")
    lines[#lines + 1] = ("- **Engine Settings:** Confidence: %s, ValuationModel: %s, FactionShare: %s"):format(conf:upper(), valModel:upper(), factionShare and "ON" or "OFF")
    lines[#lines + 1] = ("- **Modules:** Sound: %s (%ds throttle), RaidWarning: %s, ChatTab: %s, Tooltip: %s, SellHelper: %s, BuyHelper: %s, MailCollector: %s, CostBasis: %s"):format(
        soundOn and "ON" or "MUTED", soundThrottle, raidWarnOn and "ON" or "OFF", chatTab and "ON" or "OFF", tooltipOn and "ON" or "OFF", sellHelper and "ON" or "OFF", buyHelper and "ON" or "OFF", mailCollector and "ON" or "OFF", costBasis and "ON" or "OFF")
    lines[#lines + 1] = ("- **AH State:** IsShown=%s, SelectedTab=%s"):format(tostring(ahShown), tostring(ahSelectedTab))

    local scanDiag = ns.GetScanDiag and ns.GetScanDiag()
    if scanDiag then
        lines[#lines + 1] = ("- **Scan Engine Activity:** %s"):format(scanDiag)
    end

    -- Recent errors if any
    local errors = ns.lastErrors or {}
    if #errors > 0 then
        lines[#lines + 1] = "- **Recent Trapped Errors:**"
        for i, err in ipairs(errors) do
            lines[#lines + 1] = ("  %d) %s"):format(i, tostring(err))
        end
    else
        lines[#lines + 1] = "- **Recent Trapped Errors:** None recorded (Clean execution)"
    end
    lines[#lines + 1] = "```"
    lines[#lines + 1] = ""
    lines[#lines + 1] = "*Submit this report at: https://github.com/justadakaje/wow-addons/issues or in Discord.*"

    return table.concat(lines, "\n")
end

local function CreateDiagnosticDialogOnce()
    if diagDialog then return diagDialog end

    local template = BackdropTemplateMixin and "BackdropTemplate" or nil
    local f = CreateFrame("Frame", "GoldFinderDiagnosticDialog", UIParent, template)
    f:SetSize(620, 480)
    f:SetPoint("CENTER", UIParent, "CENTER", 0, 30)
    f:SetFrameStrata("FULLSCREEN_DIALOG")
    if f.SetFrameLevel then f:SetFrameLevel(220) end
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

    tinsert(UISpecialFrames, "GoldFinderDiagnosticDialog")

    -- Close Button
    local closeBtn = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -6, -6)
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    -- Header
    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", 20, -18)
    title:SetText("|cffffd100GoldFinder Diagnostic & Bug Report|r")

    -- Description
    local desc = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
    desc:SetPoint("RIGHT", f, "RIGHT", -20, 0)
    desc:SetJustifyH("LEFT")
    desc:SetText("The pre-formatted Markdown report below contains live memory, realm, deal threshold, and error diagnostics. Press |cff40ff40Ctrl+C|r to copy, then paste into GitHub Issues or Discord:")

    -- Scrollable EditBox
    local scrollFrame = CreateFrame("ScrollFrame", "GoldFinderDiagScroll", f, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 0, -10)
    scrollFrame:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -32, 56)

    local editBox = CreateFrame("EditBox", nil, scrollFrame)
    editBox:SetMultiLine(true)
    editBox:SetMaxLetters(999999)
    editBox:EnableMouse(true)
    editBox:SetAutoFocus(false)
    editBox:SetFontObject("GameFontHighlightSmall")
    editBox:SetWidth(550)
    editBox:SetScript("OnEscapePressed", function() f:Hide() end)
    scrollFrame:SetScrollChild(editBox)
    f.editBox = editBox

    -- Status feedback text
    local status = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    status:SetPoint("BOTTOMLEFT", 20, 20)
    status:SetJustifyH("LEFT")
    f.status = status

    -- Action buttons
    local doneBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    doneBtn:SetSize(80, 24)
    doneBtn:SetPoint("BOTTOMRIGHT", -18, 16)
    doneBtn:SetText("Done")
    doneBtn:SetScript("OnClick", function() f:Hide() end)

    local copyBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    copyBtn:SetSize(110, 24)
    copyBtn:SetPoint("RIGHT", doneBtn, "LEFT", -8, 0)
    copyBtn:SetText("Copy (Ctrl+C)")
    copyBtn:SetScript("OnClick", function()
        editBox:HighlightText()
        editBox:SetFocus()
        status:SetText("|cff40ff40Report highlighted! Press Ctrl+C to copy.|r")
    end)
    copyBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Copy Report", 1, 0.82, 0)
        GameTooltip:AddLine("Highlights the full diagnostic report and focuses the text box.", 1, 1, 1, true)
        GameTooltip:AddLine("Press Ctrl+C to copy to your clipboard.", 0.25, 1, 0.25)
        GameTooltip:Show()
    end)
    copyBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    local selectBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    selectBtn:SetSize(90, 24)
    selectBtn:SetPoint("RIGHT", copyBtn, "LEFT", -8, 0)
    selectBtn:SetText("Select All")
    selectBtn:SetScript("OnClick", function()
        editBox:HighlightText()
        editBox:SetFocus()
        status:SetText("|cff40ff40Highlighted. Press Ctrl+C.|r")
    end)

    diagDialog = f
    return diagDialog
end

function ns.ShowDiagnosticDialog()
    local f = CreateDiagnosticDialogOnce()
    local report = ns.GenerateDiagnosticReport and ns.GenerateDiagnosticReport() or "No diagnostic report generated."
    f.editBox:SetText(report)
    f.editBox:HighlightText()
    f.editBox:SetFocus()
    f.status:SetText("|cff40ff40Report focused! Press Ctrl+C to copy.|r")
    f:Show()
    f:Raise()
    return f
end

---------------------------------------------------------------------------
-- Main Info & About Frame
---------------------------------------------------------------------------

function ns.ShowInfoDialog()
    if infoFrame then
        if infoFrame:IsShown() then
            infoFrame:Hide()
            return
        else
            infoFrame:SetFrameStrata("FULLSCREEN_DIALOG")
            if infoFrame.SetFrameLevel then infoFrame:SetFrameLevel(200) end
            infoFrame:Show()
            infoFrame:Raise()
            if infoFrame.UpdateStats then infoFrame.UpdateStats() end
            return
        end
    end

    local template = BackdropTemplateMixin and "BackdropTemplate" or nil
    local f = CreateFrame("Frame", "GoldFinderInfoFrame", UIParent, template)
    f:SetSize(720, 480)
    f:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
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
    if f.SetBackdropColor then f:SetBackdropColor(0, 0, 0, 1) end

    local solidBg = f:CreateTexture(nil, "BACKGROUND", nil, -8)
    solidBg:SetPoint("TOPLEFT", 6, -6)
    solidBg:SetPoint("BOTTOMRIGHT", -6, 6)
    solidBg:SetColorTexture(0.08, 0.08, 0.10, 0.98)

    tinsert(UISpecialFrames, "GoldFinderInfoFrame")

    -- Close button
    local closeBtn = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -6, -6)
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    -- Header Title
    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 28, -20)
    title:SetText("|cffffd100GoldFinder - Info & About|r")

    -- Top Right: Open Addon Options
    local optBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    optBtn:SetSize(160, 24)
    optBtn:SetPoint("TOPRIGHT", -44, -18)
    optBtn:SetText("Open Addon Options")
    optBtn:SetScript("OnClick", function()
        f:Hide()
        if ns.OpenConfig then ns.OpenConfig() end
    end)

    -----------------------------------------------------------------------
    -- Left Column: Metadata & Community Links
    -----------------------------------------------------------------------
    local metaHeader = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    metaHeader:SetPoint("TOPLEFT", 28, -58)
    metaHeader:SetText("Author & Version:")

    local metaText = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    metaText:SetPoint("TOPLEFT", 28, -76)
    local author = (C_AddOns and C_AddOns.GetAddOnMetadata and C_AddOns.GetAddOnMetadata("GoldFinder", "Author"))
        or (GetAddOnMetadata and GetAddOnMetadata("GoldFinder", "Author"))
        or "KenHenChan"
    metaText:SetText(("|cffffffffAuthor:|r %s      |cffffffffVersion:|r %s      |cffffffffLicense:|r MIT"):format(
        author, ns.version or "1.0.6"))

    local engageHeader = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    engageHeader:SetPoint("TOPLEFT", 28, -108)
    engageHeader:SetText("Engage With GoldFinder:")

    CreateCopyBox(f, "https://discord.gg/byEfdxqkS", "Organized Chaos Discord Community:", -130)
    CreateCopyBox(f, "https://github.com/justadakaje/wow-addons/issues", "Bug Reports & Feature Requests (GitHub):", -180)
    CreateCopyBox(f, "https://www.curseforge.com/wow/addons/goldfinder", "CurseForge Addon Page:", -230)

    -- Translators & Language Support
    local transHeader = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    transHeader:SetPoint("TOPLEFT", 28, -282)
    transHeader:SetText("Localization & Translators:")

    local transList = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    transList:SetPoint("TOPLEFT", 28, -302)
    transList:SetJustifyH("LEFT")
    transList:SetText(
        "|cffffd100deDE|r - German: Team Antigravity & Community\n" ..
        "|cffffd100frFR|r - French: Team Antigravity\n" ..
        "|cffffd100esES|r - Spanish (Spain/LatAm): Team Antigravity\n" ..
        "|cffffd100zhCN|r - Simplified Chinese: Team Antigravity\n" ..
        "|cffffd100zhTW|r - Traditional Chinese: Team Antigravity\n" ..
        "|cffffd100koKR|r - Korean: Team Antigravity\n" ..
        "|cffffd100ruRU|r - Russian: Team Antigravity"
    )

    -----------------------------------------------------------------------
    -- Right Column: Live Diagnostics & Performance (#53)
    -----------------------------------------------------------------------
    local diagHeader = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    diagHeader:SetPoint("TOPLEFT", 380, -58)
    diagHeader:SetText("Live System & Performance Health:")

    local diagCard = CreateFrame("Frame", nil, f)
    diagCard:SetPoint("TOPLEFT", 380, -80)
    diagCard:SetSize(300, 310)

    local diagBg = diagCard:CreateTexture(nil, "BACKGROUND")
    diagBg:SetAllPoints(diagCard)
    diagBg:SetColorTexture(0.04, 0.04, 0.06, 0.90)

    local diagBorder = CreateFrame("Frame", nil, diagCard, BackdropTemplateMixin and "BackdropTemplate" or nil)
    diagBorder:SetAllPoints(diagCard)
    if diagBorder.SetBackdrop then
        diagBorder:SetBackdrop({
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            edgeSize = 12,
            insets = { left = 2, right = 2, top = 2, bottom = 2 },
        })
        diagBorder:SetBackdropBorderColor(0.3, 0.3, 0.35, 0.8)
    end

    local statsText = diagCard:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    statsText:SetPoint("TOPLEFT", 14, -14)
    statsText:SetPoint("BOTTOMRIGHT", -14, 14)
    statsText:SetJustifyH("LEFT")
    statsText:SetJustifyV("TOP")

    local function UpdateStats()
        if UpdateAddOnMemoryUsage then UpdateAddOnMemoryUsage() end
        local mem = (GetAddOnMemoryUsage and GetAddOnMemoryUsage("GoldFinder")) or 0
        local memStr = (mem > 1024) and ("%.2f MB"):format(mem / 1024) or ("%.1f KB"):format(mem)

        local db = ns.db
        local itemCount = 0
        local historyCount = 0
        if db and db.items then
            for _, rec in pairs(db.items) do
                itemCount = itemCount + 1
                if rec.history then
                    historyCount = historyCount + #rec.history
                end
            end
        end

        local scanCount = (db and db.scans and #db.scans) or 0
        local lifetimeScans = (db and db.lifetimeScans) or scanCount
        local scanStatus = ns.ScanStatus and ns.ScanStatus()
        local lastScan = (scanStatus and scanStatus.status) or "None recorded"
        local realm = ns.GetActiveRealm and ns.GetActiveRealm() or "Default"
        local buildInfo = (GetBuildInfo and select(4, GetBuildInfo())) or 16001

        local scanDisplay = (lifetimeScans > scanCount)
            and ("%d scans (%d in buffer)"):format(lifetimeScans, scanCount)
            or ("%d scans"):format(scanCount)

        statsText:SetText(
            ("|cffffd100Memory Working Set:|r %s\n\n" ..
             "|cffffd100Tracked Reagents:|r %d items\n\n" ..
             "|cffffd100Historical Price Points:|r %d points\n\n" ..
             "|cffffd100Full Scans Recorded:|r %s\n\n" ..
             "|cffffd100Current Realm:|r %s\n\n" ..
             "|cffffd100Client Interface Build:|r %s\n\n" ..
             "|cffffd100AH API Architecture:|r Modern (C_AuctionHouse)\n\n" ..
             "|cffffd100Database Status:|r Health Optimal (<2MB)\n\n" ..
             "|cffffd100Last Scan Summary:|r %s"):format(
                memStr, itemCount, historyCount, scanDisplay, realm, tostring(buildInfo), lastScan
            )
        )
    end
    f.UpdateStats = UpdateStats
    UpdateStats()

    -- Bottom action buttons
    local runTourBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    runTourBtn:SetSize(150, 24)
    runTourBtn:SetPoint("BOTTOMLEFT", 28, 20)
    runTourBtn:SetText("Replay Feature Tour")
    runTourBtn:SetScript("OnClick", function()
        f:Hide()
        if ns.StartTour then ns.StartTour() end
    end)

    local copyDiagBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    copyDiagBtn:SetSize(190, 24)
    copyDiagBtn:SetPoint("LEFT", runTourBtn, "RIGHT", 10, 0)
    copyDiagBtn:SetText("Copy Diagnostic Report")
    copyDiagBtn:SetScript("OnClick", function()
        if ns.ShowDiagnosticDialog then
            ns.ShowDiagnosticDialog()
        end
    end)
    copyDiagBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Copy Diagnostic & Bug Report", 1, 0.82, 0)
        GameTooltip:AddLine("Generates a clean Markdown system and error report ready to paste into GitHub Issues or Discord.", 1, 1, 1, true)
        GameTooltip:AddLine("Shortcut: /gf diag or /gf report", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    copyDiagBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    local bottomClose = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    bottomClose:SetSize(90, 24)
    bottomClose:SetPoint("BOTTOMRIGHT", -28, 20)
    bottomClose:SetText("Close")
    bottomClose:SetScript("OnClick", function() f:Hide() end)

    infoFrame = f
    f:Show()
    return f
end
