-- GoldFinder -- Config
-- Graphical options & configuration panel (#36).
-- Provides interactive controls for discount threshold, scan count, profit floors,
-- spend caps, confidence rating filters, audio alert selection and throttle,
-- cross-faction sharing, and minimap button display.
-- Supports standalone window (UIParent) and Blizzard Settings / Interface Options category registration.

local ADDON, ns = ...

local configFrame = nil
local isRefreshing = false
local statusText = nil

local function NotifySettingSaved(desc)
    if statusText and desc then
        statusText:SetText(("|cff40ff40Saved: %s|r"):format(desc))
    end
end

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

    -- Profile persistence state (HUD Edit Mode style)
    if controls.charProfileCb and controls.profileNameText then
        local isChar = ns.IsCharacterSpecificProfile and ns.IsCharacterSpecificProfile()
        controls.charProfileCb:SetChecked(isChar == true)
        if isChar then
            local charName = ns.GetCharacterName and ns.GetCharacterName() or "Character"
            controls.profileNameText:SetText(("|cff40ff40%s (Character-Specific)|r"):format(charName))
        else
            controls.profileNameText:SetText("|cffffd100Default (Account-Wide)|r")
        end
        local parent = controls.charProfileCb:GetParent()
        if parent then
            local tw = (controls.charProfileCb.text and controls.charProfileCb.text:GetStringWidth()) or 0
            if tw > 0 then
                controls.charProfileCb:ClearAllPoints()
                controls.charProfileCb:SetPoint("RIGHT", parent, "RIGHT", -(tw + 12), 0)
            end
        end
    end

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

    -- c) Minimum profit floor slider (0 - 10g, step 1s)
    local minProfit = ns.GetMinProfit()
    local profitGold = math.min(10, minProfit / 10000)
    controls.minProfitSlider:SetValue(profitGold)
    controls.minProfitSlider.UpdateDisplay(profitGold)

    -- d) Spend cap slider (0 - 100g, step 10s)
    local maxSpend = ns.GetMaxQuickBuySpend()
    local spendGold = math.min(100, maxSpend / 10000)
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

    -- k) Mailbox collector checkbox (#40)
    if controls.mailCollectorCb then
        local mc = ns.IsMailCollectorEnabled and ns.IsMailCollectorEnabled()
        if mc == nil then mc = true end
        controls.mailCollectorCb:SetChecked(mc == true)
    end

    -- l) Cost basis tooltip checkbox (#42)
    if controls.costBasisCb then
        local cb = ns.IsCostBasisTooltipEnabled and ns.IsCostBasisTooltipEnabled()
        if cb == nil then cb = true end
        controls.costBasisCb:SetChecked(cb == true)
    end

    -- m) Dedicated chat tab checkbox
    if controls.chatTabCb then
        local ct = ns.IsDedicatedChatTabEnabled and ns.IsDedicatedChatTabEnabled()
        controls.chatTabCb:SetChecked(ct == true)
    end

    if statusText then
        statusText:SetText("|cff40ff40All settings saved and active|r")
    end

    isRefreshing = false
end

local function ResetDefaults()
    if ns.ResetCurrentProfile then
        ns.ResetCurrentProfile()
    else
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
        if ns.SetMailCollector then
            ns.SetMailCollector(true)
        end
        if ns.SetCostBasisTooltip then
            ns.SetCostBasisTooltip(true)
        end
        if ns.SetDedicatedChatTab then
            ns.SetDedicatedChatTab(false)
        end
    end

    RefreshControls()
    NotifySettingSaved("Active profile settings restored to defaults")
    if ns.RefreshPanel then ns.RefreshPanel() end
    ns.Good("GoldFinder: Active profile options restored to default values.")
end

local function CreateConfigFrameOnce()
    if configFrame then return configFrame end

    local template = BackdropTemplateMixin and "BackdropTemplate" or nil
    local f = CreateFrame("Frame", "GoldFinderConfigFrame", UIParent, template)
    f:Hide()
    f:SetSize(620, 700)
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
    if f.SetBackdropColor then
        f:SetBackdropColor(0, 0, 0, 1)
    end

    local solidBg = f:CreateTexture(nil, "BACKGROUND", nil, -8)
    solidBg:SetPoint("TOPLEFT", 6, -6)
    solidBg:SetPoint("BOTTOMRIGHT", -6, 6)
    solidBg:SetColorTexture(0.08, 0.08, 0.10, 0.98)

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
    -- Section 0: Profile Persistence & Scope (HUD Edit Mode Style)
    -----------------------------------------------------------------------
    local profPanel = CreateFrame("Frame", nil, f, BackdropTemplateMixin and "BackdropTemplate" or nil)
    profPanel:SetSize(564, 30)
    profPanel:SetPoint("TOPLEFT", 28, -48)
    profPanel:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = false, tileSize = 16, edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    if profPanel.SetBackdropColor then
        profPanel:SetBackdropColor(0.04, 0.04, 0.06, 0.90)
        profPanel:SetBackdropBorderColor(0.35, 0.35, 0.40, 0.8)
    end

    local profLabel = profPanel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    profLabel:SetPoint("LEFT", 10, 0)
    profLabel:SetText("Active Profile:")

    controls.profileNameText = profPanel:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    controls.profileNameText:SetPoint("LEFT", profLabel, "RIGHT", 6, 0)
    controls.profileNameText:SetText("|cffffd100Default (Account-Wide)|r")

    -- Checkbox: Character-Specific Settings (matching HUD Edit Mode's "Character Specific Layout")
    controls.charProfileCb = CreateCheckbox(
        profPanel,
        "Character-Specific Settings",
        "Character-Specific Profile",
        "When checked, saves all deal filters, notification sounds, and options exclusively for this character (like HUD Edit Mode's 'Character Specific Layout').\n\nWhen unchecked, settings are shared across all characters using the account-wide 'Default' profile.",
        function(_, checked)
            if ns.SetCharacterSpecificProfile then
                ns.SetCharacterSpecificProfile(checked)
            end
            RefreshControls()
            NotifySettingSaved(checked and "Using Character-Specific Profile" or "Using Account-Wide Profile")
        end
    )
    -- Align checkbox so its label text stays fully within the right border of profPanel
    local cbTextWidth = (controls.charProfileCb.text and controls.charProfileCb.text:GetStringWidth()) or 0
    if not cbTextWidth or cbTextWidth <= 0 then cbTextWidth = 145 end
    controls.charProfileCb:SetPoint("RIGHT", profPanel, "RIGHT", -(cbTextWidth + 12), 0)

    -- Button: Copy Profile
    local copyProfBtn = CreateFrame("Button", nil, profPanel, "UIPanelButtonTemplate")
    copyProfBtn:SetSize(86, 20)
    copyProfBtn:SetPoint("RIGHT", controls.charProfileCb, "LEFT", -12, 0)
    copyProfBtn:SetText("Copy From...")
    copyProfBtn:SetScript("OnClick", function()
        local isChar = ns.IsCharacterSpecificProfile and ns.IsCharacterSpecificProfile()
        if isChar then
            local ok, err
            if ns.CopyProfile then
                ok, err = ns.CopyProfile("Default")
            end
            if ok then
                RefreshControls()
                NotifySettingSaved("Copied settings from Default")
                ns.Good("GoldFinder: Copied settings from Account-Wide (Default) profile.")
            else
                NotifySettingSaved("Copy failed: " .. tostring(err))
            end
        else
            local charKey = ns.GetCharacterKey and ns.GetCharacterKey()
            if GoldFinderDB and GoldFinderDB.profiles and GoldFinderDB.profiles[charKey] then
                local ok, err
                if ns.CopyProfile then
                    ok, err = ns.CopyProfile(charKey)
                end
                if ok then
                    RefreshControls()
                    NotifySettingSaved("Copied settings from " .. ns.GetCharacterName())
                    ns.Good("GoldFinder: Copied settings from %s into Default profile.", ns.GetCharacterName())
                else
                    NotifySettingSaved("Copy failed: " .. tostring(err))
                end
            else
                NotifySettingSaved("No character profile to copy from")
                ns.Print("GoldFinder: No character profile found. Enable Character-Specific Settings first to create one.")
            end
        end
    end)
    copyProfBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Copy Profile Settings", 1, 0.82, 0)
        local isChar = ns.IsCharacterSpecificProfile and ns.IsCharacterSpecificProfile()
        if isChar then
            GameTooltip:AddLine("Copy all thresholds, sounds, and filter options from the Account-Wide Default profile into this character's profile.", 1, 1, 1, true)
        else
            GameTooltip:AddLine("Copy settings from this character's specific profile into the Account-Wide Default profile.", 1, 1, 1, true)
        end
        GameTooltip:Show()
    end)
    copyProfBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    controls.copyProfBtn = copyProfBtn

    -----------------------------------------------------------------------
    -- Section 1: Deal Finding & Market Filters
    -----------------------------------------------------------------------
    local sec1 = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sec1:SetPoint("TOPLEFT", 24, -86)
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
            NotifySettingSaved(("Discount threshold set to %d%%"):format(val))
            if ns.RefreshPanel then ns.RefreshPanel() end
        end
    )
    controls.discountSlider:SetSize(250, 16)
    controls.discountSlider:SetPoint("TOPLEFT", 28, -114)

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
            NotifySettingSaved(("Minimum prior scans set to %d"):format(val))
            if ns.RefreshPanel then ns.RefreshPanel() end
        end
    )
    controls.minScansSlider:SetSize(250, 16)
    controls.minScansSlider:SetPoint("TOPLEFT", 330, -114)

    -- c) Minimum Profit Floor input/slider (0 to 10g, step 0.01g = 1s)
    controls.minProfitSlider = CreateSlider(
        f,
        "Minimum Profit Floor",
        0, 10, 0.01,
        function(val)
            if val <= 0 then return "0 (Disabled)" end
            local copper = math.floor(val * 10000 + 0.5)
            return ns.Money(copper)
        end,
        "Minimum Profit Floor",
        "Filter out deals whose estimated net profit after AH cut is below this threshold (0 = show all deals).",
        function(_, val)
            local copper = math.floor(val * 10000 + 0.5)
            ns.SetMinProfit(copper)
            if ns.db then
                ns.db.minProfit = copper
                if ns.db.settings then ns.db.settings.minProfit = copper end
            end
            local desc = (val <= 0) and "Profit floor disabled" or ("Min profit floor set to " .. ns.Money(copper))
            NotifySettingSaved(desc)
            if ns.RefreshPanel then ns.RefreshPanel() end
        end
    )
    controls.minProfitSlider:SetSize(250, 16)
    controls.minProfitSlider:SetPoint("TOPLEFT", 28, -166)

    -- d) Buyout Spend Cap input/slider (0 to 100g, step 0.1g = 10s)
    controls.spendCapSlider = CreateSlider(
        f,
        "Quick-Buy Spend Cap",
        0, 100, 0.1,
        function(val)
            if val <= 0 then return "0 (Unlimited)" end
            local copper = math.floor(val * 10000 + 0.5)
            return ns.Money(copper)
        end,
        "Quick-Buy Spend Cap",
        "Maximum purchase price permitted for one-click Quick-Buy commodity purchases (0 = unlimited).",
        function(_, val)
            local copper = math.floor(val * 10000 + 0.5)
            ns.SetMaxQuickBuySpend(copper)
            if ns.db then
                ns.db.spendCap = copper
                if ns.db.settings then ns.db.settings.spendCap = copper end
            end
            local desc = (val <= 0) and "Spend cap unlimited" or ("Spend cap set to " .. ns.Money(copper))
            NotifySettingSaved(desc)
            if ns.RefreshPanel then ns.RefreshPanel() end
        end
    )
    controls.spendCapSlider:SetSize(250, 16)
    controls.spendCapSlider:SetPoint("TOPLEFT", 330, -166)

    -- e) Sighting Confidence Filter (Any, Medium+, High Only)
    local confLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    confLabel:SetPoint("TOPLEFT", 28, -210)
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
        btn:SetPoint("TOPLEFT", 28 + (i - 1) * 188, -228)
        btn.rawLabel = opt.label
        btn:SetText(opt.label)
        btn:SetScript("OnClick", function()
            ns.SetMinConfidence(opt.key)
            if ns.db then
                ns.db.minConfidence = opt.key
                if ns.db.settings then ns.db.settings.minConfidence = opt.key end
            end
            SetButtonGroupActive(controls.confButtons, opt.key)
            NotifySettingSaved("Confidence rating set to " .. opt.label)
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
    valModelLabel:SetPoint("TOPLEFT", 28, -258)
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
        btn:SetPoint("TOPLEFT", 28 + (i - 1) * 188, -276)
        btn.rawLabel = opt.label
        btn:SetText(opt.label)
        btn:SetScript("OnClick", function()
            ns.SetValuationModel(opt.key)
            SetButtonGroupActive(controls.valModelButtons, opt.key)
            NotifySettingSaved("Valuation baseline set to " .. opt.label)
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
    sec2:SetPoint("TOPLEFT", 24, -312)
    sec2:SetText("|cffffd100Audio Alerts & Cooldown|r")

    local soundLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    soundLabel:SetPoint("TOPLEFT", 28, -332)
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
        btn:SetPoint("TOPLEFT", curX, -350)
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
                NotifySettingSaved("Audio alerts muted (None)")
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
                NotifySettingSaved("Audio alert set to " .. opt.label)
            end
            SetButtonGroupActive(controls.soundButtons, opt.key)
        end)
        controls.soundButtons[opt.key] = btn
    end

    -- [ Test Sound ] button
    local testBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    testBtn:SetSize(110, 22)
    testBtn:SetPoint("TOPLEFT", curX + 10, -350)
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
            NotifySettingSaved(("Audio cooldown set to %ds"):format(val))
        end
    )
    controls.throttleSlider:SetSize(250, 16)
    controls.throttleSlider:SetPoint("TOPLEFT", 28, -392)

    -----------------------------------------------------------------------
    -- Section 3: General & Database Settings
    -----------------------------------------------------------------------
    local sec3 = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sec3:SetPoint("TOPLEFT", 24, -434)
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
            NotifySettingSaved("Cross-faction sharing " .. (checked and "enabled" or "disabled"))
        end
    )
    controls.crossFactionCb:SetPoint("TOPLEFT", 28, -456)

    -- i) Checkbox: Show Selling Tab Price Helper
    controls.sellHelperCb = CreateCheckbox(
        f,
        "Enable Sell Tab Price Helper",
        "Selling Price Helper",
        "When enabled, docks market pricing suggestions and quick undercut buttons alongside the Auction House Sell tab.",
        function(_, checked)
            if ns.SetSellHelperEnabled then
                ns.SetSellHelperEnabled(checked)
            end
            NotifySettingSaved("Sell tab price helper " .. (checked and "enabled" or "disabled"))
        end
    )
    controls.sellHelperCb:SetPoint("TOPLEFT", 330, -456)

    -- j) Checkbox: Show Minimap Button
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
            NotifySettingSaved("Minimap button " .. (checked and "shown" or "hidden"))
        end
    )
    controls.minimapCb:SetPoint("TOPLEFT", 28, -484)

    -- k) Checkbox: Output to 'GoldFinder' Chat Tab
    controls.chatTabCb = CreateCheckbox(
        f,
        "Output to 'GoldFinder' Chat Tab",
        "Dedicated Chat Window Tab",
        "When enabled, creates and routes all GoldFinder deal notifications, audio alarms, and system output to a dedicated 'GoldFinder' chat tab instead of General chat.",
        function(_, checked)
            if ns.SetDedicatedChatTab then
                ns.SetDedicatedChatTab(checked)
            end
            NotifySettingSaved("Dedicated chat tab " .. (checked and "enabled" or "disabled"))
        end
    )
    controls.chatTabCb:SetPoint("TOPLEFT", 330, -484)

    -- l) Checkbox: Mailbox Deal Collector (#40)
    controls.mailCollectorCb = CreateCheckbox(
        f,
        "Enable Mailbox Deal Collector",
        "Mailbox Deal Collector",
        "When enabled, places a one-click 'Collect Deals' button on the Mailbox to automatically pick up won auction materials and sales payments while logging cost basis.",
        function(_, checked)
            if ns.SetMailCollector then
                ns.SetMailCollector(checked)
            end
            NotifySettingSaved("Mailbox deal collector " .. (checked and "enabled" or "disabled"))
        end
    )
    controls.mailCollectorCb:SetPoint("TOPLEFT", 28, -512)

    -- m) Checkbox: Cost Basis on Tooltips (#42)
    controls.costBasisCb = CreateCheckbox(
        f,
        "Show Cost Basis on Item Tooltips",
        "Cost Basis Tooltip Overlay",
        "When enabled, displays your average purchase cost basis and unrealized profit margin on bag, bank, and inventory item tooltips.",
        function(_, checked)
            if ns.SetCostBasisTooltip then
                ns.SetCostBasisTooltip(checked)
            end
            NotifySettingSaved("Cost basis tooltips " .. (checked and "enabled" or "disabled"))
        end
    )
    controls.costBasisCb:SetPoint("TOPLEFT", 330, -512)

    -- n) Button: Create Custom Material Group (#39)
    local newGroupBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    newGroupBtn:SetSize(260, 24)
    newGroupBtn:SetPoint("TOPLEFT", 28, -548)
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

    -- o) Button: Open Goblin Ledger (#41)
    local openLedgerBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    openLedgerBtn:SetSize(260, 24)
    openLedgerBtn:SetPoint("TOPLEFT", 330, -548)
    openLedgerBtn:SetText("Open Goblin P&L Ledger")
    openLedgerBtn:SetScript("OnClick", function()
        f:Hide()
        if ns.OpenLedger then
            ns.OpenLedger()
        end
    end)
    openLedgerBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Goblin Realized P&L Ledger", 1, 0.82, 0)
        GameTooltip:AddLine("Open the complete financial accounting dashboard to view realized profits, completed flips, ROI, and top profitable items.", 1, 1, 1, true)
        GameTooltip:AddLine("You can also open this with: /gf ledger", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    openLedgerBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -- p) Button: Open Staging Cart (#47)
    local openCartBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    openCartBtn:SetSize(260, 24)
    openCartBtn:SetPoint("TOPLEFT", 28, -580)
    openCartBtn:SetText("Open Staging Cart")
    openCartBtn:SetScript("OnClick", function()
        f:Hide()
        if ns.OpenCart then
            ns.OpenCart()
        end
    end)
    openCartBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Staging Quick-Buy Cart", 1, 0.82, 0)
        GameTooltip:AddLine("Open the batch staging cart to review staged items and execute multi-deal purchases.", 1, 1, 1, true)
        GameTooltip:AddLine("You can also open this with: /gf cart", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    openCartBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -- q) Button: Compact & Vacuum Database (#50)
    local vacuumBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    vacuumBtn:SetSize(260, 24)
    vacuumBtn:SetPoint("TOPLEFT", 330, -580)
    vacuumBtn:SetText("Compact & Vacuum DB")
    vacuumBtn:SetScript("OnClick", function()
        if ns.VacuumDatabase then
            local ok, msg = ns.VacuumDatabase({ retentionDays = 30, maxHistory = 30 })
            if ok then
                NotifySettingSaved("Database compacted")
                ns.Good("GoldFinder: " .. msg)
            else
                ns.Bad("Vacuum failed: " .. tostring(msg))
            end
        end
    end)
    vacuumBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Database Maintenance & Compaction", 1, 0.82, 0)
        GameTooltip:AddLine("Prunes stale historical price points (>30 days), deduplicates identical same-day sightings, and purges orphaned items.", 1, 1, 1, true)
        GameTooltip:AddLine("Keeps SavedVariables file size well under the 2MB performance ceiling.", 0.25, 1, 0.25)
        GameTooltip:AddLine("Command: /gf vacuum [days]", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    vacuumBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -- r) Button: Profile Import / Export (#48)
    local profileBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    profileBtn:SetSize(260, 24)
    profileBtn:SetPoint("TOPLEFT", 28, -612)
    profileBtn:SetText("Profile Import / Export")
    profileBtn:SetScript("OnClick", function()
        if ns.ShowProfileDialog then
            ns.ShowProfileDialog("export")
        end
    end)
    profileBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Base64 Profile Data Portability", 1, 0.82, 0)
        GameTooltip:AddLine("Export or import your complete GoldFinder configuration, watchlists, shopping lists, and custom categories as a sharable string.", 1, 1, 1, true)
        GameTooltip:AddLine("Command: /gf profile [export|import]", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    profileBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -- s) Button: Replay Feature Tour (#51)
    local tourBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    tourBtn:SetSize(260, 24)
    tourBtn:SetPoint("TOPLEFT", 330, -612)
    tourBtn:SetText("Replay Feature Tour")
    tourBtn:SetScript("OnClick", function()
        if ns.StartTour then
            ns.StartTour()
        end
    end)
    tourBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Interactive Feature Tour", 1, 0.82, 0)
        GameTooltip:AddLine("Replay the interactive 6-step walkthrough introducing GoldFinder's core arbitrage features.", 1, 1, 1, true)
        GameTooltip:AddLine("Command: /gf tour", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    tourBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    -----------------------------------------------------------------------
    -- Section 4: Action Buttons at Bottom
    -----------------------------------------------------------------------
    local resetBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    resetBtn:SetSize(120, 24)
    resetBtn:SetPoint("BOTTOMLEFT", 28, 20)
    resetBtn:SetText("Reset Defaults")
    resetBtn:SetScript("OnClick", ResetDefaults)
    resetBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Reset to Defaults", 1, 0.82, 0)
        GameTooltip:AddLine("Restore active profile settings to their recommended default values.", 1, 1, 1, true)
        GameTooltip:Show()
    end)
    resetBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    local infoBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    infoBtn:SetSize(110, 24)
    infoBtn:SetPoint("LEFT", resetBtn, "RIGHT", 8, 0)
    infoBtn:SetText("About / Info")
    infoBtn:SetScript("OnClick", function()
        if ns.ShowInfoDialog then
            ns.ShowInfoDialog()
        end
    end)
    infoBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("GoldFinder Info & About", 1, 0.82, 0)
        GameTooltip:AddLine("Open the Journalator-style project info, Discord/GitHub links, translation credits, and diagnostic dashboard.", 1, 1, 1, true)
        GameTooltip:AddLine("Command: /gf info or /gf about", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    infoBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    local saveCloseBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    saveCloseBtn:SetSize(120, 24)
    saveCloseBtn:SetPoint("BOTTOMRIGHT", -28, 20)
    saveCloseBtn:SetText("Save & Close")
    saveCloseBtn:SetScript("OnClick", function()
        f:Hide()
        if ns.RefreshPanel then ns.RefreshPanel() end
        ns.Good("GoldFinder: Settings saved and applied.")
    end)
    saveCloseBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Save & Close", 1, 0.82, 0)
        GameTooltip:AddLine("Confirm all active settings and close the configuration window.", 1, 1, 1, true)
        GameTooltip:AddLine("All choices are immediately active and persist across sessions.", 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    saveCloseBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)

    statusText = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    statusText:SetPoint("LEFT", infoBtn, "RIGHT", 10, 0)
    statusText:SetPoint("RIGHT", saveCloseBtn, "LEFT", -10, 0)
    statusText:SetJustifyH("CENTER")
    statusText:SetText("|cff40ff40All settings saved and active|r")

    f:SetScript("OnShow", RefreshControls)

    configFrame = f
    return configFrame
end

function ns.OpenConfig()
    local f = CreateConfigFrameOnce()
    if f then
        RefreshControls()
        f:Show()
        f:Raise()
    end
end

ns.RefreshControls = RefreshControls

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
