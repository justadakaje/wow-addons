-- GoldFinder -- Interactive Feature Tour & Onboarding Walkthrough (#51)
-- Provides a clean 6-step interactive onboarding guide for new users.
-- Replayable anytime via /gf tour or the Info dashboard.

local ADDON, ns = ...

local tourFrame = nil
local currentStep = 1

local TOUR_STEPS = {
    {
        title = "1. Welcome to GoldFinder",
        desc = "GoldFinder is your zero-cooldown Auction House arbitrage engine.\n\n" ..
               "Unlike heavy scanners that lock you out with AH cooldowns, GoldFinder works |cffffd100100% passively|r: it watches searches and full scans you already run, recording accurate price histories without extra network requests.",
    },
    {
        title = "2. The Auction House Tab",
        desc = "Open the Auction House and click the |cffffd100GoldFinder|r tab at the bottom.\n\n" ..
               "GoldFinder calculates typical baseline prices (Median, Trimmed Mean, or 7-Day EMA) and highlights materials listed at deep discounts (default: 30%+ off). Each row shows exact net profit after Blizzard's 5% AH cut.",
    },
    {
        title = "3. Quick-Buy & Staging Cart",
        desc = "Speed is everything when sniping flips:\n\n" ..
               "• |cffffd100Shift-Click|r any commodity deal row to instant |cff40ff40Quick-Buy|r in one click.\n" ..
               "• |cffffd100Alt-Click|r deal rows to add items to your |cff40ff40Staging Cart|r for safe batch review before purchasing.",
    },
    {
        title = "4. Live Snipe Alarm",
        desc = "Want audio warnings for massive flips?\n\n" ..
               "Click |cffffd100[ Snipe: OFF ]|r in the tab header or type |cffffd100/gf snipe|r. " ..
               "Snipe Mode monitors incoming auction browse packets in real time and blares a raid warning alarm whenever a 70%+ discount or 100g+ mega-flip appears!",
    },
    {
        title = "5. Blizzard Sell Tab Helper",
        desc = "Never guess your listing prices again.\n\n" ..
               "When you drag an item to sell on Blizzard's Sell tab, GoldFinder docks a |cffffd100Selling Price Helper|r card outside the window. It shows median market prices, price trend direction, and one-click buttons to undercut (-1c), match, or post at typical market value.",
    },
    {
        title = "6. Mailbox Collector & P&L Ledger",
        desc = "Track every copper of profit:\n\n" ..
               "• Visit any mailbox and click |cffffd100[ Collect Deals ]|r to loot won auctions and sale income in one click.\n" ..
               "• Type |cffffd100/gf ledger|r to open your Goblin Accounting Ledger with lifetime net profit, flip ROI %, and transaction history!",
    },
}

local function UpdateTourStep(f)
    local step = TOUR_STEPS[currentStep]
    if not step then return end

    f.title:SetText("|cffffd100" .. step.title .. "|r")
    f.desc:SetText(step.desc)
    f.counter:SetText(("Step %d of %d"):format(currentStep, #TOUR_STEPS))

    f.backBtn:SetEnabled(currentStep > 1)
    if currentStep == #TOUR_STEPS then
        f.nextBtn:SetText("Finish")
    else
        f.nextBtn:SetText("Next >")
    end
end

function ns.StartTour()
    if tourFrame then
        tourFrame:Show()
        tourFrame:Raise()
        currentStep = 1
        UpdateTourStep(tourFrame)
        return
    end

    local template = BackdropTemplateMixin and "BackdropTemplate" or nil
    local f = CreateFrame("Frame", "GoldFinderTourFrame", UIParent, template)
    f:SetSize(460, 260)
    f:SetPoint("CENTER", UIParent, "CENTER", 0, 50)
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

    tinsert(UISpecialFrames, "GoldFinderTourFrame")

    -- Title
    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 24, -20)
    title:SetText("GoldFinder Feature Tour")
    f.title = title

    -- Counter
    local counter = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    counter:SetPoint("TOPRIGHT", -24, -22)
    counter:SetText("Step 1 of 6")
    f.counter = counter

    -- Description body
    local desc = f:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    desc:SetPoint("TOPLEFT", 24, -58)
    desc:SetPoint("BOTTOMRIGHT", -24, 60)
    desc:SetJustifyH("LEFT")
    desc:SetJustifyV("TOP")
    desc:SetWordWrap(true)
    f.desc = desc

    -- Navigation buttons
    local skipBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    skipBtn:SetSize(90, 22)
    skipBtn:SetPoint("BOTTOMLEFT", 24, 18)
    skipBtn:SetText("Skip Tour")
    skipBtn:SetScript("OnClick", function()
        f:Hide()
        if GoldFinderDB then GoldFinderDB.tourSeen = true end
        ns.Print("Tour dismissed. You can replay it anytime via: /gf tour")
    end)

    local nextBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    nextBtn:SetSize(90, 22)
    nextBtn:SetPoint("BOTTOMRIGHT", -24, 18)
    nextBtn:SetText("Next >")
    nextBtn:SetScript("OnClick", function()
        if currentStep < #TOUR_STEPS then
            currentStep = currentStep + 1
            UpdateTourStep(f)
        else
            f:Hide()
            if GoldFinderDB then GoldFinderDB.tourSeen = true end
            ns.Good("GoldFinder: Feature tour completed! Happy goldmaking!")
        end
    end)
    f.nextBtn = nextBtn

    local backBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    backBtn:SetSize(80, 22)
    backBtn:SetPoint("RIGHT", nextBtn, "LEFT", -8, 0)
    backBtn:SetText("< Back")
    backBtn:SetScript("OnClick", function()
        if currentStep > 1 then
            currentStep = currentStep - 1
            UpdateTourStep(f)
        end
    end)
    f.backBtn = backBtn

    tourFrame = f
    currentStep = 1
    UpdateTourStep(f)
    f:Show()
    return f
end

-- Automatic first-run trigger
local autoTour = CreateFrame("Frame")
autoTour:RegisterEvent("PLAYER_LOGIN")
autoTour:SetScript("OnEvent", function(self)
    self:UnregisterEvent("PLAYER_LOGIN")
    C_Timer.After(3, function()
        if GoldFinderDB and not GoldFinderDB.tourSeen then
            ns.StartTour()
        end
    end)
end)
