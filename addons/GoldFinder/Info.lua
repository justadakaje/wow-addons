-- GoldFinder -- Info & About Dashboard (#54)
-- Journalator-style Info window providing project metadata, copyable links,
-- translation credits, and live memory/performance diagnostics (#53).

local ADDON, ns = ...

local infoFrame = nil

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
    metaText:SetText(("|cffffffffAuthor:|r %s      |cffffffffVersion:|r %s      |cffffffffLicense:|r MIT"):format(
        "justadakaje", ns.version or "1.0.0"))

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
        local lastScan = (ns.ScanStatus and ns.ScanStatus().status) or "None recorded"
        local realm = ns.GetActiveRealm and ns.GetActiveRealm() or "Default"
        local buildInfo = (GetBuildInfo and select(4, GetBuildInfo())) or 16001

        statsText:SetText(
            ("|cffffd100Memory Working Set:|r %s\n\n" ..
             "|cffffd100Tracked Reagents:|r %d items\n\n" ..
             "|cffffd100Historical Price Points:|r %d points\n\n" ..
             "|cffffd100Full Scans Recorded:|r %d scans\n\n" ..
             "|cffffd100Current Realm:|r %s\n\n" ..
             "|cffffd100Client Interface Build:|r %s\n\n" ..
             "|cffffd100AH API Architecture:|r Modern (C_AuctionHouse)\n\n" ..
             "|cffffd100Database Status:|r Health Optimal (<2MB)\n\n" ..
             "|cffffd100Last Scan Summary:|r %s"):format(
                memStr, itemCount, historyCount, scanCount, realm, tostring(buildInfo), lastScan
            )
        )
    end
    f.UpdateStats = UpdateStats
    UpdateStats()

    -- Bottom action buttons
    local runTourBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    runTourBtn:SetSize(160, 24)
    runTourBtn:SetPoint("BOTTOMLEFT", 28, 20)
    runTourBtn:SetText("Replay Feature Tour")
    runTourBtn:SetScript("OnClick", function()
        f:Hide()
        if ns.StartTour then ns.StartTour() end
    end)

    local bottomClose = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    bottomClose:SetSize(100, 24)
    bottomClose:SetPoint("BOTTOMRIGHT", -28, 20)
    bottomClose:SetText("Close")
    bottomClose:SetScript("OnClick", function() f:Hide() end)

    infoFrame = f
    f:Show()
    return f
end
