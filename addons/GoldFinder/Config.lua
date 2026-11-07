-- GoldFinder -- Config
-- Graphical options & configuration panel (#36).
-- Provides interactive controls for discount threshold, scan count, profit floors,
-- spend caps, confidence rating filters, audio alert selection and throttle,
-- cross-faction sharing, and minimap button display.
-- Supports standalone window (UIParent) and Blizzard Settings / Interface Options category registration.

local ADDON, ns = ...

local configFrame = nil
local isRefreshing = false

-- Slider and control references for programmatic refresh
local controls = {}

local function CreateCheckbox(parent, label, tooltipTitle, tooltipText, onClick)
    local cb = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    cb:SetSize(24, 24)

    local text = cb.text or _G[cb:GetName() and (cb:GetName() .. "Text") or ""]
    if not text then
        text = cb:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        text:SetPoint("LEFT", cb, "RIGHT", 4, 1)
        cb.text = text
    else
        text:SetFontObject("GameFontHighlight")
        text:SetPoint("LEFT", cb, "RIGHT", 4, 1)
    end
    text:SetText(label)

    if tooltipTitle or tooltipText then
        cb:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(tooltipTitle or label, 1, 0.82, 0)
            if tooltipText then
                GameTooltip:AddLine(tooltipText, 1, 1, 1, true)
            end
            GameTooltip:Show()
        end)
        cb:SetScript("OnLeave", function() GameTooltip:Hide() end)
    end

    if onClick then
        cb:SetScript("OnClick", function(self)
            local checked = self:GetChecked()
            local isChecked = (checked == true or checked == 1)
            onClick(self, isChecked)
        end)
    end

    return cb
end

local sliderID = 0
local function CreateSlider(parent, label, minVal, maxVal, step, formatFunc, tooltipTitle, tooltipText, onValueChanged)
    sliderID = sliderID + 1
    local name = "GoldFinderConfigSlider" .. sliderID
    local slider = CreateFrame("Slider", name, parent, "OptionsSliderTemplate")
    slider:SetMinMaxValues(minVal, maxVal)
    slider:SetValueStep(step)
    slider:SetObeyStepOnDrag(true)

    local title = slider.Text or _G[name .. "Text"]
    if not title then
        title = slider:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        slider.Text = title
    end
    title:ClearAllPoints()
    title:SetPoint("BOTTOMLEFT", slider, "TOPLEFT", 0, 4)
    title:SetFontObject("GameFontNormalSmall")
    title:SetJustifyH("LEFT")
    title:SetText(label)

    local valText = slider.valText
    if not valText then
        valText = slider:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        slider.valText = valText
    end
    valText:ClearAllPoints()
    valText:SetPoint("BOTTOMRIGHT", slider, "TOPRIGHT", 0, 4)
    valText:SetFontObject("GameFontHighlightSmall")
    valText:SetJustifyH("RIGHT")

    local lowText = slider.Low or _G[name .. "Low"]
    local highText = slider.High or _G[name .. "High"]
    if lowText then
        lowText:SetFontObject("GameFontDisableSmall")
        lowText:SetText(formatFunc and formatFunc(minVal) or tostring(minVal))
    end
    if highText then
        highText:SetFontObject("GameFontDisableSmall")
        highText:SetText(formatFunc and formatFunc(maxVal) or tostring(maxVal))
    end

    local function updateDisplay(val)
        local displayStr = formatFunc and formatFunc(val) or tostring(val)
        valText:SetText(displayStr)
    end

    slider:SetScript("OnValueChanged", function(self, val, userInput)
        val = math.floor((val / step) + 0.5) * step
        updateDisplay(val)
        if not isRefreshing and onValueChanged then
            onValueChanged(self, val, userInput)
        end
    end)

    if tooltipTitle or tooltipText then
        slider:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(tooltipTitle or label, 1, 0.82, 0)
            if tooltipText then
                GameTooltip:AddLine(tooltipText, 1, 1, 1, true)
            end
            GameTooltip:Show()
        end)
        slider:SetScript("OnLeave", function() GameTooltip:Hide() end)
    end

    slider.UpdateDisplay = updateDisplay
    return slider
end

local function SetButtonGroupActive(buttons, activeKey)
    for key, btn in pairs(buttons) do
        if key == activeKey then
            btn:LockHighlight()
            btn:SetText("|cffffd100" .. (btn.rawLabel or btn:GetText() or ""))
        else
            btn:UnlockHighlight()
            btn:SetText("|cffffffff" .. (btn.rawLabel or btn:GetText() or ""))
        end
    end
end

local function RefreshControls()
    if not configFrame then return end
    isRefreshing = true

    -- a) Discount threshold slider (5% - 50%)
    local ratio = ns.GetDealRatio()
    local discount = math.floor((1 - ratio) * 100 + 0.5)
    discount = math.max(5, math.min(50, discount))
    controls.discountSlider:SetValue(discount)
    controls.discountSlider.UpdateDisplay(discount)

    -- b) Minimum scans slider (1 - 20)
    local minScans = ns.GetMinPrior()
    minScans = math.max(1, math.min(20, minScans))
    controls.minScansSlider:SetValue(minScans)
    controls.minScansSlider.UpdateDisplay(minScans)

    -- c) Minimum profit floor slider (0 - 50g)
    local minProfit = ns.GetMinProfit()
    local profitGold = math.min(50, minProfit / 10000)
    controls.minProfitSlider:SetValue(profitGold)
    controls.minProfitSlider.UpdateDisplay(profitGold)

    -- d) Spend cap slider (0 - 500g)
    local maxSpend = ns.GetMaxQuickBuySpend()
    local spendGold = math.min(500, maxSpend / 10000)
    controls.spendCapSlider:SetValue(spendGold)
    controls.spendCapSlider.UpdateDisplay(spendGold)

    -- e) Confidence filter
    local conf = ns.GetMinConfidence()
    if conf == "moderate" then conf = "med" end
    if not controls.confButtons[conf] then conf = "any" end
    SetButtonGroupActive(controls.confButtons, conf)

    -- e2) Valuation Baseline Engine (#38)
    if controls.valModelButtons then
        local valModel = ns.GetValuationModel()
        if not controls.valModelButtons[valModel] then valModel = "median" end
        SetButtonGroupActive(controls.valModelButtons, valModel)
    end

    -- f) Alert sound picker
    local soundKey
    if not ns.IsSoundAlertEnabled() then
        soundKey = "none"
    else
        soundKey = ns.GetSoundChoice()
        if not controls.soundButtons[soundKey] then soundKey = "auction" end
    end
    SetButtonGroupActive(controls.soundButtons, soundKey)

    -- g) Sound throttle slider (5s - 120s)
    local throttle = ns.GetSoundThrottle()
    throttle = math.max(5, math.min(120, throttle))
    controls.throttleSlider:SetValue(throttle)
    controls.throttleSlider.UpdateDisplay(throttle)

    -- h) Cross-faction share checkbox
    local fShare = ns.IsFactionShareEnabled()
    controls.crossFactionCb:SetChecked(fShare == true)

    -- i) Minimap button checkbox
    local mShown = (ns.IsMinimapButtonShown and ns.IsMinimapButtonShown())
    controls.minimapCb:SetChecked(mShown == true)

    -- j) Sell helper checkbox
    if controls.sellHelperCb then
        local sEnabled = ns.IsSellHelperEnabled and ns.IsSellHelperEnabled()
        if sEnabled == nil then sEnabled = true end
        controls.sellHelperCb:SetChecked(sEnabled == true)
    end

    isRefreshing = false
end

local function ResetDefaults()
    -- Set core settings
    ns.SetDealRatio(0.70)  -- 30% discount
    ns.SetMinPrior(3)      -- 3 scans
    ns.SetMinProfit(0)     -- 0c (disabled)
    ns.SetMaxQuickBuySpend(500000) -- 50g cap
    ns.SetMinConfidence("any")
    ns.SetValuationModel("median")
    ns.SetSoundAlert(true)
    ns.SetSoundChoice("auction")
    ns.SetSoundThrottle(30)
    ns.SetFactionShareEnabled(true)
    if ns.SetMinimapButtonShown then
        ns.SetMinimapButtonShown(true)
    end
    if ns.SetSellHelperEnabled then
        ns.SetSellHelperEnabled(true)
    end

    -- Also synchronize ns.db convenience keys if present
    if ns.db then
        ns.db.discountThreshold = 0.30
        ns.db.minScans = 3
        ns.db.minProfit = 0
        ns.db.spendCap = 500000
        ns.db.minConfidence = "any"
        ns.db.alertSound = "auction"
        ns.db.soundThrottle = 30
        ns.db.factionShare = true
        if GoldFinderDB then
            GoldFinderDB.minimap = GoldFinderDB.minimap or {}
            GoldFinderDB.minimap.hide = false
        end
    end

    RefreshControls()
    if ns.RefreshPanel then ns.RefreshPanel() end
    ns.Good("GoldFinder options restored to default values.")
end

local function CreateConfigFrameOnce()
    if configFrame then return configFrame end

    local template = BackdropTemplateMixin and "BackdropTemplate" or nil
    local f = CreateFrame("Frame", "GoldFinderConfigFrame", UIParent, template)
    f:SetSize(620, 590)
    f:SetPoint("CENTER", UIParent, "CENTER", 0, 20)
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

    tinsert(UISpecialFrames, "GoldFinderConfigFrame")

    -- Title Bar Header Texture & Text
    local headerTex = f:CreateTexture(nil, "ARTWORK")
    headerTex:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
    headerTex:SetSize(320, 64)
    headerTex:SetPoint("TOP", 0, 12)

    local titleText = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleText:SetPoint("TOP", headerTex, "TOP", 0, -14)
    titleText:SetText("GoldFinder Options")

    local subText = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    subText:SetPoint("TOP", 0, -30)
    subText:SetText("Tune market deal filters, notification sounds, and database settings.")

    local closeBtn = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -6, -6)
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    -----------------------------------------------------------------------
    -- Section 1: Deal Finding & Market Filters
    -----------------------------------------------------------------------
    local sec1 = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sec1:SetPoint("TOPLEFT", 24, -54)
    sec1:SetText("|cffffd100Deal Thresholds & Market Filters|r")

    -- a) Discount Threshold slider (5% to 50%, step 1%)
    controls.discountSlider = CreateSlider(
        f,
        "Discount Threshold",
        5, 50, 1,
        function(val) return ("%d%% below typical"):format(val) end,
        "Discount Threshold",
        "Percentage below typical market price required to qualify as an underpriced deal.",
        function(_, val)
            local ratio = (100 - val) / 100
            ns.SetDealRatio(ratio)
            if ns.db then
                ns.db.discountThreshold = val / 100
                if ns.db.settings then ns.db.settings.discountThreshold = val / 100 end
            end
            if ns.RefreshPanel then ns.RefreshPanel() end
        end
    )
    controls.discountSlider:SetSize(250, 16)
    controls.discountSlider:SetPoint("TOPLEFT", 28, -82)

    -- b) Minimum Sighting Count slider (1 to 20, step 1)
    controls.minScansSlider = CreateSlider(
        f,
        "Minimum Prior Scans",
        1, 20, 1,
        function(val) return ("%d %s"):format(val, val == 1 and "scan" or "scans") end,
        "Minimum Historical Scans",
        "Number of past auction house scans required before an item's typical price is trusted.",
        function(_, val)
            ns.SetMinPrior(val)
            if ns.db then
                ns.db.minScans = val
                if ns.db.settings then ns.db.settings.minScans = val end
            end
            if ns.RefreshPanel then ns.RefreshPanel() end
        end
    )
    controls.minScansSlider:SetSize(250, 16)
    controls.minScansSlider:SetPoint("TOPLEFT", 330, -82)

    -- c) Minimum Profit Floor input/slider (0 to 50g, step 0.5g = 50s)
    controls.minProfitSlider = CreateSlider(
        f,
        "Minimum Profit Floor",
        0, 50, 0.5,
        function(val)
            if val <= 0 then return "0 (Disabled)" end
            local copper = math.floor(val * 10000)
            return ns.Money(copper)
        end,
        "Minimum Profit Floor",
        "Filter out deals whose estimated net profit after AH cut is below this threshold.",
        function(_, val)
            local copper = math.floor(val * 10000)
            ns.SetMinProfit(copper)
            if ns.db then
                ns.db.minProfit = copper
                if ns.db.settings then ns.db.settings.minProfit = copper end
            end
            if ns.RefreshPanel then ns.RefreshPanel() end
        end
    )
    controls.minProfitSlider:SetSize(250, 16)
    controls.minProfitSlider:SetPoint("TOPLEFT", 28, -134)

    -- d) Buyout Spend Cap input/slider (0 to 500g, step 10g)
    controls.spendCapSlider = CreateSlider(
        f,
        "Quick-Buy Spend Cap",
        0, 500, 10,
        function(val)
            if val <= 0 then return "0 (Unlimited)" end
            return ("%d Gold"):format(val)
        end,
        "Quick-Buy Spend Cap",
        "Maximum purchase price permitted for one-click Quick-Buy commodity purchases (0 = unlimited).",
        function(_, val)
            local copper = math.floor(val * 10000)
            ns.SetMaxQuickBuySpend(copper)
            if ns.db then
                ns.db.spendCap = copper
                if ns.db.settings then ns.db.settings.spendCap = copper end
            end
            if ns.RefreshPanel then ns.RefreshPanel() end
        end
    )
    controls.spendCapSlider:SetSize(250, 16)
    controls.spendCapSlider:SetPoint("TOPLEFT", 330, -134)

    -- e) Sighting Confidence Filter (Any, Medium+, High Only)
    local confLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    confLabel:SetPoint("TOPLEFT", 28, -178)
    confLabel:SetText("Sighting Confidence Rating Filter:")

    controls.confButtons = {}
    local confOptions = {
        { key = "any",  label = "Any (All Sightings)",  tip = "Display all deals, including first-time and single-scan sightings.", width = 175 },
        { key = "med",  label = "Medium+ (3+ Scans)",   tip = "Require at least 3 historical sightings or consistent market stability.", width = 175 },
        { key = "high", label = "High Only (5+ Scans)", tip = "Strict requirement: 5+ sightings with tight price dispersion.", width = 175 },
    }
    for i, opt in ipairs(confOptions) do
        local btn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        btn:SetSize(opt.width, 22)
        btn:SetPoint("TOPLEFT", 28 + (i - 1) * 188, -196)
        btn.rawLabel = opt.label
        btn:SetText(opt.label)
        btn:SetScript("OnClick", function()
            ns.SetMinConfidence(opt.key)
            if ns.db then
                ns.db.minConfidence = opt.key
                if ns.db.settings then ns.db.settings.minConfidence = opt.key end
            end
            SetButtonGroupActive(controls.confButtons, opt.key)
            if ns.RefreshPanel then ns.RefreshPanel() end
        end)
        btn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(opt.label, 1, 0.82, 0)
            GameTooltip:AddLine(opt.tip, 1, 1, 1, true)
            GameTooltip:Show()
        end)
        btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
        controls.confButtons[opt.key] = btn
    end

    -- f) Valuation Baseline Engine (#38)
    local valModelLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    valModelLabel:SetPoint("TOPLEFT", 28, -226)
    valModelLabel:SetText("Valuation Baseline Engine:")

    controls.valModelButtons = {}
    local valModelOptions = {
        { key = "median",  label = "Median (Default)", tip = "Standard statistical median. Best for most markets; immune to extreme single-listing spikes and 1c bait.", width = 175 },
        { key = "trimmed", label = "Trimmed Mean",     tip = "Discards top & bottom 10% outlier prices, averaging the middle 80%. Balances stability with distribution.", width = 175 },
        { key = "ema",     label = "7-Day EMA",        tip = "7-period Exponential Moving Average. Weights recent auction scans higher for volatile or shifting markets.", width = 175 },
    }
    for i, opt in ipairs(valModelOptions) do
        local btn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        btn:SetSize(opt.width, 22)
        btn:SetPoint("TOPLEFT", 28 + (i - 1) * 188, -244)
        btn.rawLabel = opt.label
        btn:SetText(opt.label)
        btn:SetScript("OnClick", function()
            ns.SetValuationModel(opt.key)
            SetButtonGroupActive(controls.valModelButtons, opt.key)
            if ns.RefreshPanel then ns.RefreshPanel() end
        end)
        btn:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText(opt.label, 1, 0.82, 0)
            GameTooltip:AddLine(opt.tip, 1, 1, 1, true)
            GameTooltip:Show()
        end)
        btn:SetScript("OnLeave", function() GameTooltip:Hide() end)
        controls.valModelButtons[opt.key] = btn
    end

    -----------------------------------------------------------------------
    -- Section 2: Audio Alerts & Cooldown
    -----------------------------------------------------------------------
    local sec2 = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sec2:SetPoint("TOPLEFT", 24, -280)
    sec2:SetText("|cffffd100Audio Alerts & Cooldown|r")

    local soundLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    soundLabel:SetPoint("TOPLEFT", 28, -300)
    soundLabel:SetText("Deal Found Alert Sound:")

    controls.soundButtons = {}
    local soundOptions = {
        { key = "auction", label = "Auction", width = 66 },
        { key = "coins",   label = "Coins",   width = 62 },
        { key = "whisper", label = "Whisper", width = 66 },
        { key = "raid",    label = "Raid",    width = 60 },
        { key = "loot",    label = "Loot",    width = 60 },
        { key = "none",    label = "None",    width = 60 },
    }
    local curX = 28
    for _, opt in ipairs(soundOptions) do
        local btn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        btn:SetSize(opt.width, 22)
        btn:SetPoint("TOPLEFT", curX, -318)
        btn.rawLabel = opt.label
        btn:SetText(opt.label)
        curX = curX + opt.width + 6
        btn:SetScript("OnClick", function()
            if opt.key == "none" then
                ns.SetSoundAlert(false)
                if ns.db then
                    ns.db.alertSound = "none"
                    if ns.db.settings then ns.db.settings.soundName = "none" end
                end
            else
                ns.SetSoundAlert(true)
                ns.SetSoundChoice(opt.key)
                if ns.db then
                    ns.db.alertSound = opt.key
                    if ns.db.settings then ns.db.settings.soundName = opt.key end
                end
                local info = ns.SOUND_CHOICES[opt.key]
                if info and info.id and type(PlaySound) == "function" then
                    pcall(PlaySound, info.id)
                end
            end
            SetButtonGroupActive(controls.soundButtons, opt.key)
        end)
        controls.soundButtons[opt.key] = btn
    end

    -- [ Test Sound ] button
    local testBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    testBtn:SetSize(110, 22)
    testBtn:SetPoint("TOPLEFT", curX + 10, -318)
    testBtn:SetText("Test Sound")
    testBtn:SetScript("OnClick", function()
        if not ns.IsSoundAlertEnabled() then
            ns.Print("Audio alerts are muted (sound set to None). Select a sound kit to preview.")
        else
            local _, choice = ns.GetSoundChoice()
            if choice and choice.id and type(PlaySound) == "function" then
                pcall(PlaySound, choice.id)
            end
        end
    end)
    testBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Test Sound Alert", 1, 0.82, 0)
        GameTooltip:AddLine("Preview the currently selected deal alert sound.", 1, 1, 1, true)
        GameTooltip:Show()
    end)
    testBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -- g) Sound Throttle slider (5s to 120s)
    controls.throttleSlider = CreateSlider(
        f,
        "Audio Throttle Cooldown",
        5, 120, 5,
        function(val) return ("%d seconds"):format(val) end,
        "Audio Throttle Cooldown",
        "Minimum cooldown window between audio alert chimes to prevent spam during frequent searches.",
        function(_, val)
            ns.SetSoundThrottle(val)
            if ns.db then
                ns.db.soundThrottle = val
                if ns.db.settings then ns.db.settings.soundThrottle = val end
            end
        end
    )
    controls.throttleSlider:SetSize(250, 16)
    controls.throttleSlider:SetPoint("TOPLEFT", 28, -360)

    -----------------------------------------------------------------------
    -- Section 3: General & Database Settings
    -----------------------------------------------------------------------
    local sec3 = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sec3:SetPoint("TOPLEFT", 24, -402)
    sec3:SetText("|cffffd100Database & Interface Settings|r")

    -- h) Checkbox: Cross-Faction Market Data Sharing
    controls.crossFactionCb = CreateCheckbox(
        f,
        "Cross-Faction Market Data Sharing",
        "Cross-Faction Market Sharing",
        "When enabled, auction history is shared across Horde and Alliance characters on this realm. When disabled, market data is partitioned by faction.",
        function(_, checked)
            ns.SetFactionShareEnabled(checked)
            if ns.db then
                ns.db.factionShare = checked
                if ns.db.settings then ns.db.settings.factionShare = checked end
            end
        end
    )
    controls.crossFactionCb:SetPoint("TOPLEFT", 28, -424)

    -- i) Checkbox: Show Minimap Button
    controls.minimapCb = CreateCheckbox(
        f,
        "Show Minimap Button",
        "Minimap Coin Button",
        "Display the GoldFinder coin button around the minimap ring.",
        function(_, checked)
            if ns.SetMinimapButtonShown then
                ns.SetMinimapButtonShown(checked)
            end
            if GoldFinderDB then
                GoldFinderDB.minimap = GoldFinderDB.minimap or {}
                GoldFinderDB.minimap.hide = not checked
            end
        end
    )
    controls.minimapCb:SetPoint("TOPLEFT", 28, -452)

    -- j) Checkbox: Show Selling Tab Price Helper
    controls.sellHelperCb = CreateCheckbox(
        f,
        "Enable Sell Tab Price Helper",
        "Selling Price Helper",
        "When enabled, docks market pricing suggestions and quick undercut buttons alongside the Auction House Sell tab.",
        function(_, checked)
            if ns.SetSellHelperEnabled then
                ns.SetSellHelperEnabled(checked)
            end
        end
    )
    controls.sellHelperCb:SetPoint("TOPLEFT", 330, -424)

    -- k) Button: Create Custom Material Group (#39)
    local newGroupBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    newGroupBtn:SetSize(210, 22)
    newGroupBtn:SetPoint("TOPLEFT", 330, -454)
    newGroupBtn:SetText("+ New Material Group")
    newGroupBtn:SetScript("OnClick", function()
        if ns.ShowCreateGroupDialog then
            ns.ShowCreateGroupDialog()
        end
    end)
    newGroupBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Create Material Group", 1, 0.82, 0)
        GameTooltip:AddLine("Define a custom category tab to track custom sets of crafting reagents or arbitrage items.", 1, 1, 1, true)
        GameTooltip:AddLine("You can also manage groups via: /gf groups", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    newGroupBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -----------------------------------------------------------------------
    -- Section 4: Action Buttons at Bottom
    -----------------------------------------------------------------------
    local resetBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    resetBtn:SetSize(130, 24)
    resetBtn:SetPoint("BOTTOMLEFT", 28, 20)
    resetBtn:SetText("Reset Defaults")
    resetBtn:SetScript("OnClick", ResetDefaults)
    resetBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Reset to Defaults", 1, 0.82, 0)
        GameTooltip:AddLine("Restore all GoldFinder settings to their recommended default values.", 1, 1, 1, true)
        GameTooltip:Show()
    end)
    resetBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    local bottomCloseBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    bottomCloseBtn:SetSize(100, 24)
    bottomCloseBtn:SetPoint("BOTTOMRIGHT", -28, 20)
    bottomCloseBtn:SetText("Close")
    bottomCloseBtn:SetScript("OnClick", function() f:Hide() end)

    f:SetScript("OnShow", RefreshControls)

    configFrame = f
    return configFrame
end

function ns.OpenConfig()
    local f = CreateConfigFrameOnce()
    if f then
        f:Show()
        f:Raise()
    end
end

function ns.ToggleConfig()
    if configFrame and configFrame:IsShown() then
        configFrame:Hide()
    else
        ns.OpenConfig()
    end
end

local function RegisterAddonSettings()
    local blizzardPanel = CreateFrame("Frame", "GoldFinderBlizzardSettingsPanel")
    blizzardPanel.name = "GoldFinder"

    local title = blizzardPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("GoldFinder")

    local sub = blizzardPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    sub:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
    sub:SetText("Auction House Arbitrage & Deal Finder")

    local desc = blizzardPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    desc:SetPoint("TOPLEFT", sub, "BOTTOMLEFT", 0, -12)
    desc:SetPoint("RIGHT", blizzardPanel, "RIGHT", -16, 0)
    desc:SetJustifyH("LEFT")
    desc:SetText("GoldFinder monitors market prices and highlights underpriced commodities, crafting reagent conversions, and active undercuts.\n\nClick the button below to open the complete graphical options window.")

    local openBtn = CreateFrame("Button", nil, blizzardPanel, "UIPanelButtonTemplate")
    openBtn:SetSize(220, 26)
    openBtn:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 0, -20)
    openBtn:SetText("Open GoldFinder Options")
    openBtn:SetScript("OnClick", function()
        if ns.OpenConfig then
            ns.OpenConfig()
        end
    end)

    if Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory then
        local category = Settings.RegisterCanvasLayoutCategory(blizzardPanel, "GoldFinder")
        Settings.RegisterAddOnCategory(category)
        ns.settingsCategory = category
    elseif InterfaceOptions_AddCategory then
        InterfaceOptions_AddCategory(blizzardPanel)
    end
end

local boot = CreateFrame("Frame")
boot:RegisterEvent("ADDON_LOADED")
boot:SetScript("OnEvent", function(self, _, name)
    if name ~= ADDON then return end
    self:UnregisterEvent("ADDON_LOADED")
    RegisterAddonSettings()
end)
