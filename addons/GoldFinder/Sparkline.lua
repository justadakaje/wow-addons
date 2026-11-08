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
