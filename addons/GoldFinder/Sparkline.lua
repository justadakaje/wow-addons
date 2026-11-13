-- GoldFinder -- Sparkline
-- Renders lightweight 14-day historical price sparklines and trend curves
-- directly inside or docked to deal tooltips.

local ADDON, ns = ...

local sparkFrame = nil
local BAR_COUNT = 18
local SPARK_WIDTH = 250
local SPARK_HEIGHT = 52
local PLOT_TOP = 14
local PLOT_BOTTOM = 16

local function CreateSparklineFrame()
    if sparkFrame then return sparkFrame end

    local template = BackdropTemplateMixin and "BackdropTemplate" or nil
    local f = CreateFrame("Frame", "GoldFinderSparklineFrame", UIParent, template)
    f:SetSize(SPARK_WIDTH, SPARK_HEIGHT)
    f:SetFrameStrata("TOOLTIP")
    f:SetClampedToScreen(true)

    if f.SetBackdrop then
        f:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true, tileSize = 8, edgeSize = 10,
            insets = { left = 2, right = 2, top = 2, bottom = 2 },
        })
        f:SetBackdropColor(0.04, 0.06, 0.09, 0.95)
        f:SetBackdropBorderColor(0.25, 0.35, 0.45, 0.9)
    end

    -- Header / Title label
    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    title:SetPoint("TOPLEFT", 6, -3)
    title:SetText("|cff22d3ee14-Day Price History|r")
    f.title = title

    -- Median / Typical reference label (top right)
    local medLabel = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    medLabel:SetPoint("TOPRIGHT", -6, -3)
    f.medLabel = medLabel

    -- Horizontal Median reference line
    local medLine = f:CreateTexture(nil, "ARTWORK")
    medLine:SetColorTexture(0.88, 0.66, 0.23, 0.5) -- Soft gold
    medLine:SetHeight(1)
    f.medLine = medLine

    -- Min & Max labels at bottom
    local lowLabel = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    lowLabel:SetPoint("BOTTOMLEFT", 6, 3)
    f.lowLabel = lowLabel

    local highLabel = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    highLabel:SetPoint("BOTTOMRIGHT", -6, 3)
    f.highLabel = highLabel

    local trendLabel = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    trendLabel:SetPoint("BOTTOM", 0, 3)
    f.trendLabel = trendLabel

    -- Empty state label
    local emptyLabel = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    emptyLabel:SetPoint("CENTER", 0, 0)
    emptyLabel:SetText("|cff888888Gathering price scans...|r")
    f.emptyLabel = emptyLabel

    -- Bar Pool for plotting price points
    f.bars = {}
    for i = 1, BAR_COUNT do
        local bar = f:CreateTexture(nil, "OVERLAY")
        bar:SetColorTexture(0.14, 0.78, 0.85, 0.85) -- Cyan default
        bar:Hide()
        f.bars[i] = bar
    end

    sparkFrame = f
    return f
end

function ns.ShowSparkline(parentTip, history, medianPrice, currentPrice)
    if not parentTip or not parentTip:IsShown() then
        if sparkFrame then sparkFrame:Hide() end
        return
    end

    local f = CreateSparklineFrame()

    -- Filter points: past 14 days (14 * 86400 seconds)
    local now = (GetServerTime and GetServerTime()) or time()
    local fourteenDaysAgo = now - (14 * 86400)

    local points = {}
    if history and #history > 0 then
        for _, pt in ipairs(history) do
            local t = pt.seen or pt.t or 0
            if t >= fourteenDaysAgo and pt.min and pt.min > 0 then
                points[#points + 1] = pt.min
            end
        end
    end

    -- If history has few points, use all available points up to BAR_COUNT
    if #points < 2 and history and #history > 0 then
        points = {}
        for _, pt in ipairs(history) do
            if pt.min and pt.min > 0 then
                points[#points + 1] = pt.min
            end
        end
    end

    -- Include current candidate price as the final latest point
    if currentPrice and currentPrice > 0 then
        points[#points + 1] = currentPrice
    end

    -- If still insufficient data
    if #points < 2 then
        for i = 1, BAR_COUNT do f.bars[i]:Hide() end
        f.medLine:Hide()
        f.medLabel:SetText("")
        f.lowLabel:SetText("")
        f.highLabel:SetText("")
        f.trendLabel:SetText("")
        f.emptyLabel:Show()
    else
        f.emptyLabel:Hide()

        -- Trim to most recent BAR_COUNT points
        while #points > BAR_COUNT do
            table.remove(points, 1)
        end

        local minVal = points[1]
        local maxVal = points[1]
        for _, v in ipairs(points) do
            if v < minVal then minVal = v end
            if v > maxVal then maxVal = v end
        end

        -- Ensure non-zero range
        local range = maxVal - minVal
        if range <= 0 then range = math.max(1, minVal * 0.1) end

        -- Set labels
        f.lowLabel:SetText("Low: " .. ns.Money(minVal))
        f.highLabel:SetText("High: " .. ns.Money(maxVal))

        if medianPrice and medianPrice > 0 then
            f.medLabel:SetText("Typical: " .. ns.Money(medianPrice))
            -- Position median reference line
            local medYRatio = math.max(0, math.min(1, (medianPrice - minVal) / range))
            local plotH = SPARK_HEIGHT - PLOT_TOP - PLOT_BOTTOM
            local lineY = PLOT_BOTTOM + (medYRatio * plotH)
            f.medLine:ClearAllPoints()
            f.medLine:SetPoint("BOTTOMLEFT", 6, lineY)
            f.medLine:SetPoint("BOTTOMRIGHT", -6, lineY)
            f.medLine:Show()
        else
            f.medLabel:SetText("")
            f.medLine:Hide()
        end

        -- Trend label
        local firstVal = points[1]
        local lastVal = points[#points]
        if lastVal < firstVal * 0.90 then
            f.trendLabel:SetText("|cff22c55eFalling / Dip|r")
        elseif lastVal > firstVal * 1.10 then
            f.trendLabel:SetText("|cffff5555Spiking / High|r")
        else
            f.trendLabel:SetText("|cff888888Steady|r")
        end

        -- Plot bars
        local totalBars = #points
        local availW = SPARK_WIDTH - 16
        local barWidth = math.max(4, math.floor(availW / totalBars) - 2)
        local plotH = SPARK_HEIGHT - PLOT_TOP - PLOT_BOTTOM

        for i = 1, BAR_COUNT do
            local bar = f.bars[i]
            if i <= totalBars then
                local val = points[i]
                local ratio = math.max(0.08, math.min(1.0, (val - minVal) / range))
                local barH = math.max(3, math.floor(ratio * plotH))
                local posX = 8 + (i - 1) * (barWidth + 2)

                bar:ClearAllPoints()
                bar:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", posX, PLOT_BOTTOM)
                bar:SetSize(barWidth, barH)

                -- Color-code: Green if cheap, Red if spike, Gold/Cyan if current
                if i == totalBars then
                    -- Current lot: bright gold/cyan pulse
                    bar:SetColorTexture(1.0, 0.82, 0.0, 1.0)
                elseif medianPrice and val <= medianPrice * 0.80 then
                    -- Deep bargain dip (green)
                    bar:SetColorTexture(0.13, 0.77, 0.36, 0.85)
                elseif medianPrice and val >= medianPrice * 1.25 then
                    -- Outlier spike (red)
                    bar:SetColorTexture(0.93, 0.27, 0.27, 0.85)
                else
                    -- Normal range (cyan)
                    bar:SetColorTexture(0.14, 0.65, 0.85, 0.75)
                end
                bar:Show()
            else
                bar:Hide()
            end
        end
    end

    -- Anchor below the GameTooltip cleanly
    f:ClearAllPoints()
    f:SetPoint("TOPLEFT", parentTip, "BOTTOMLEFT", 0, -2)
    f:SetPoint("TOPRIGHT", parentTip, "BOTTOMRIGHT", 0, -2)
    f:Show()
end

function ns.HideSparkline()
    if sparkFrame then
        sparkFrame:Hide()
    end
end

---------------------------------------------------------------------------
-- Interactive 30-Day Historical Price Chart Modal (Theme 4 - v2.0, #62)

local chartModal = nil
local MODAL_MAX_BARS = 30
local MODAL_WIDTH = 480
local MODAL_HEIGHT = 300

local function ComputeStats(points)
    local vals = {}
    local minP, maxP
    for i = 1, #points do
        local p = points[i].min
        if p and p > 0 then
            vals[#vals + 1] = p
            if not minP or p < minP then minP = p end
            if not maxP or p > maxP then maxP = p end
        end
    end
    if #vals == 0 then return nil, nil, nil, nil end
    local sorted = {}
    for i = 1, #vals do sorted[i] = vals[i] end
    table.sort(sorted)
    local n = #sorted
    local med = (n % 2 == 1) and sorted[(n + 1) / 2] or math.floor((sorted[n / 2] + sorted[n / 2 + 1]) / 2)

    -- 7-day / trailing EMA over most recent up to 7 points
    local emaStart = math.max(1, #vals - 6)
    local alpha = 2 / (math.min(7, #vals) + 1)
    local ema = vals[emaStart]
    for i = emaStart + 1, #vals do
        ema = (vals[i] * alpha) + (ema * (1 - alpha))
    end
    ema = math.floor(ema + 0.5)

    return minP, maxP, med, ema
end

local function CreatePriceChartModal()
    if chartModal then return chartModal end

    local template = BackdropTemplateMixin and "BackdropTemplate" or nil
    local f = CreateFrame("Frame", "GoldFinderPriceChartModal", UIParent, template)
    f:SetSize(MODAL_WIDTH, MODAL_HEIGHT)
    f:SetPoint("CENTER")
    f:SetFrameStrata("DIALOG")
    f:SetClampedToScreen(true)
    if f.SetMovable then f:SetMovable(true) end
    if f.EnableMouse then f:EnableMouse(true) end
    if f.RegisterForDrag then f:RegisterForDrag("LeftButton") end
    f:SetScript("OnDragStart", function(self) if self.StartMoving then self:StartMoving() end end)
    f:SetScript("OnDragStop", function(self) if self.StopMovingOrSizing then self:StopMovingOrSizing() end end)

    if f.SetBackdrop then
        f:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true, tileSize = 16, edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 },
        })
        f:SetBackdropColor(0.05, 0.06, 0.09, 0.96)
        f:SetBackdropBorderColor(0.45, 0.52, 0.62, 1.0)
    end

    if UISpecialFrames then
        local found = false
        for _, name in ipairs(UISpecialFrames) do
            if name == "GoldFinderPriceChartModal" then found = true; break end
        end
        if not found then
            table.insert(UISpecialFrames, "GoldFinderPriceChartModal")
        end
    end

    local closeBtn = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", -4, -4)
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    local icon = f:CreateTexture(nil, "ARTWORK")
    icon:SetSize(24, 24)
    icon:SetPoint("TOPLEFT", 14, -14)
    f.icon = icon

    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("LEFT", icon, "RIGHT", 8, 2)
    title:SetPoint("RIGHT", closeBtn, "LEFT", -8, 0)
    if title.SetJustifyH then title:SetJustifyH("LEFT") end
    f.title = title

    local summary = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    summary:SetPoint("TOPLEFT", 14, -44)
    summary:SetPoint("TOPRIGHT", -14, -44)
    if summary.SetJustifyH then summary:SetJustifyH("LEFT") end
    f.summary = summary

    -- Plot container
    local plot = CreateFrame("Frame", nil, f, template)
    plot:SetPoint("TOPLEFT", 14, -68)
    plot:SetPoint("BOTTOMRIGHT", -14, 28)
    if plot.SetBackdrop then
        plot:SetBackdrop({
            bgFile = "Interface\\Buttons\\WHITE8X8",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true, tileSize = 8, edgeSize = 8,
            insets = { left = 2, right = 2, top = 2, bottom = 2 },
        })
        plot:SetBackdropColor(0.02, 0.03, 0.05, 0.9)
        plot:SetBackdropBorderColor(0.2, 0.25, 0.32, 0.85)
    end
    f.plot = plot

    local emaLine = plot:CreateTexture(nil, "ARTWORK")
    emaLine:SetHeight(1)
    emaLine:SetColorTexture(1, 0.82, 0, 0.7)
    f.emaLine = emaLine

    local emaTag = plot:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    emaTag:SetTextColor(1, 0.82, 0)
    f.emaTag = emaTag

    local emptyText = plot:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    emptyText:SetPoint("CENTER")
    emptyText:SetWidth(MODAL_WIDTH - 60)
    emptyText:Hide()
    f.emptyText = emptyText

    local footer = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    footer:SetPoint("BOTTOMLEFT", 14, 10)
    footer:SetText("Hover bars for exact sighting date and unit buyout price. Drag header to move, Esc to close.")
    f.footer = footer

    f.bars = {}
    for i = 1, MODAL_MAX_BARS do
        local bar = CreateFrame("Button", nil, plot)
        local tex = bar:CreateTexture(nil, "ARTWORK")
        tex:SetAllPoints()
        tex:SetColorTexture(0.14, 0.65, 0.85, 0.85)
        bar.tex = tex
        bar:SetScript("OnEnter", function(self)
            if not self.pointData then return end
            GameTooltip:SetOwner(self, "ANCHOR_TOP")
            local dt = date and date("%Y-%m-%d %H:%M", self.pointData.seen or self.pointData.t or 0) or "?"
            GameTooltip:AddLine(dt, 0.7, 0.85, 1)
            local priceStr = ns.Money and ns.Money(self.pointData.min) or tostring(self.pointData.min)
            GameTooltip:AddDoubleLine("Lowest Unit Price:", priceStr, 1, 0.82, 0, 1, 1, 1)
            GameTooltip:Show()
        end)
        bar:SetScript("OnLeave", function() GameTooltip:Hide() end)
        bar:Hide()
        f.bars[i] = bar
    end

    chartModal = f
    return f
end

function ns.ShowPriceChartModal(itemID)
    itemID = tonumber(itemID)
    if not itemID then return nil end

    local f = CreatePriceChartModal()
    local rec = ns.db and ns.db.items and ns.db.items[itemID]
    local rawHistory = (rec and rec.history) or {}

    local itemName = (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(itemID))
        or (rec and rec.name)
        or ("Item " .. itemID)
    local iconID = (C_Item and C_Item.GetItemIconByID and C_Item.GetItemIconByID(itemID))
        or "Interface\\Icons\\INV_Misc_QuestionMark"

    if f.icon.SetTexture then f.icon:SetTexture(iconID) end
    f.title:SetText(("|cff22d3ee30-Day Price History:|r %s"):format(itemName))

    -- Filter up to last 30 valid sightings
    local cutoff = (GetServerTime and GetServerTime() or time()) - (30 * 86400)
    local recent = {}
    for i = 1, #rawHistory do
        local pt = rawHistory[i]
        local ts = pt.seen or pt.t or 0
        if pt.min and pt.min > 0 and (ts == 0 or ts >= cutoff) then
            recent[#recent + 1] = pt
        end
    end
    local startIdx = math.max(1, #recent - MODAL_MAX_BARS + 1)
    local points = {}
    for i = startIdx, #recent do
        points[#points + 1] = recent[i]
    end

    if #points < 2 then
        for i = 1, MODAL_MAX_BARS do f.bars[i]:Hide() end
        f.emaLine:Hide()
        f.emaTag:Hide()
        f.summary:SetText(("Sightings: %d  |  Insufficient trend data"):format(#points))
        f.emptyText:SetText("Insufficient price history (need at least 2 sightings to plot 30-day trend).")
        f.emptyText:Show()
        f:Show()
        return f
    end

    f.emptyText:Hide()
    local minP, maxP, medP, emaP = ComputeStats(points)
    local moneyFn = ns.Money or tostring
    f.summary:SetText(("Low: %s   High: %s   Median: %s   7d EMA: %s   (%d pts)"):format(
        moneyFn(minP), moneyFn(maxP), moneyFn(medP), moneyFn(emaP), #points))

    local plotW = (f.plot.GetWidth and f.plot:GetWidth()) or (MODAL_WIDTH - 28)
    local plotH = (f.plot.GetHeight and f.plot:GetHeight()) or 170
    if plotW <= 0 then plotW = MODAL_WIDTH - 28 end
    if plotH <= 0 then plotH = 170 end

    local usableW = plotW - 16
    local usableH = plotH - 22
    local barSlot = usableW / #points
    local barW = math.max(4, math.floor(barSlot - 2))
    local span = (maxP > minP) and (maxP - minP) or 1

    -- Reference line for 7-day EMA
    if emaP then
        local normEma = (maxP == minP) and 0.5 or ((emaP - minP) / span)
        local yOff = 10 + math.floor(normEma * usableH)
        f.emaLine:ClearAllPoints()
        f.emaLine:SetPoint("BOTTOMLEFT", f.plot, "BOTTOMLEFT", 6, yOff)
        f.emaLine:SetPoint("BOTTOMRIGHT", f.plot, "BOTTOMRIGHT", -6, yOff)
        f.emaLine:Show()
        f.emaTag:ClearAllPoints()
        f.emaTag:SetPoint("BOTTOMRIGHT", f.emaLine, "TOPRIGHT", -2, 2)
        f.emaTag:SetText("7d EMA: " .. moneyFn(emaP))
        f.emaTag:Show()
    end

    for i = 1, MODAL_MAX_BARS do
        local bar = f.bars[i]
        local pt = points[i]
        if pt then
            bar.pointData = pt
            local norm = (maxP == minP) and 0.5 or ((pt.min - minP) / span)
            local barH = math.max(8, math.floor(norm * usableH))
            local posX = 8 + (i - 1) * barSlot
            bar:ClearAllPoints()
            bar:SetPoint("BOTTOMLEFT", f.plot, "BOTTOMLEFT", posX, 8)
            bar:SetSize(barW, barH)
            if i == #points then
                bar.tex:SetColorTexture(1.0, 0.82, 0.0, 1.0)
            elseif medP and pt.min <= medP * 0.85 then
                bar.tex:SetColorTexture(0.13, 0.77, 0.36, 0.9)
            elseif medP and pt.min >= medP * 1.25 then
                bar.tex:SetColorTexture(0.93, 0.27, 0.27, 0.9)
            else
                bar.tex:SetColorTexture(0.14, 0.65, 0.85, 0.85)
            end
            bar:Show()
        else
            bar.pointData = nil
            bar:Hide()
        end
    end

    f:Show()
    return f
end
