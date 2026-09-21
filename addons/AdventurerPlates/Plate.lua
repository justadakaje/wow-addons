-- Adventurer Plates -- the plate itself
--
-- Renders live character facts plus the player's authored fields. Built once,
-- lazily, on first show; refreshed in place afterwards. No OnUpdate anywhere --
-- the plate redraws when it is shown or when something it displays changes.

local ADDON, ns = ...

local P = {}
ns.Plate = P

local D = ns.Data

-- Height leaves clearance for a two-line motto above the action buttons; the
-- motto wraps, so this is the one dimension that cannot be tight.
local WIDTH, HEIGHT = 440, 604
local PORTRAIT_W, PORTRAIT_H = 150, 190

-- 24 cells across the content width, with a gap between them.
local CELL_W, CELL_H, CELL_GAP = 14, 14, 2

local COL_DIM   = { r = 0.62, g = 0.62, b = 0.66 }
local COL_LABEL = { r = 1.00, g = 0.82, b = 0.00 }

--------------------------------------------------------------------------
-- small builders
--------------------------------------------------------------------------

local function Backdrop(frame, alpha)
    -- BackdropTemplate is confirmed present on this client by the probe.
    if not frame.SetBackdrop then return end
    frame:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
    })
    frame:SetBackdropColor(0.05, 0.05, 0.07, alpha or 0.92)
    frame:SetBackdropBorderColor(0.25, 0.25, 0.30, 1)
end

local function Text(parent, font, justify)
    local fs = parent:CreateFontString(nil, "OVERLAY", font or "GameFontHighlight")
    fs:SetJustifyH(justify or "LEFT")
    fs:SetWordWrap(false)
    return fs
end

--------------------------------------------------------------------------
-- portrait
--------------------------------------------------------------------------

-- A live 3D model only renders for a unit the client can actually see. For
-- your own plate that is always "player", so the model path is the expected
-- one here; the fallback exists because v0.3 will show other people's plates,
-- where it becomes the common case.
--
-- The capability probe's SetUnit test was INVALID -- it hid the frame before
-- calling SetUnit, and a hidden model does not load geometry. This is the
-- corrected version: keep the model on hide, then set the unit.
local function BuildPortrait(parent)
    local holder = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    holder:SetSize(PORTRAIT_W, PORTRAIT_H)
    Backdrop(holder, 0.55)

    local model = CreateFrame("PlayerModel", nil, holder)
    model:SetPoint("TOPLEFT", 1, -1)
    model:SetPoint("BOTTOMRIGHT", -1, 1)

    -- Order matters. Without this the model can be asked to load while
    -- effectively hidden and silently come back with displayID 0.
    if model.SetKeepModelOnHide then pcall(model.SetKeepModelOnHide, model, true) end

    -- Shown behind the fallback text; whichever succeeds is what you see.
    local fallback = holder:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    fallback:SetPoint("TOPLEFT", 8, -8)
    fallback:SetPoint("BOTTOMRIGHT", -8, 8)
    fallback:SetJustifyH("CENTER")
    fallback:SetJustifyV("MIDDLE")
    fallback:SetWordWrap(true)
    fallback:Hide()

    holder.model = model
    holder.fallback = fallback
    return holder
end

-- Try the live model. If it will not load, say why in words rather than
-- drawing a placeholder that implies we know what the character looks like.
local function RefreshPortrait(holder, race, class)
    local model, fallback = holder.model, holder.fallback

    local function giveUp(reason)
        model:Hide()
        fallback:SetText(reason)
        fallback:Show()
    end

    if not model or not model.SetUnit then
        return giveUp("This client did not provide a model frame, so there is no portrait.")
    end

    model:Show()
    fallback:Hide()

    local ok, success = pcall(model.SetUnit, model, "player", false)
    if not ok then
        return giveUp("The portrait could not be loaded: " .. tostring(success))
    end

    -- SetUnit is documented to return success:bool. Observed false on a hidden
    -- frame during the probe; this path is shown, so a false here is real.
    if success == false then
        local who = (race and class)
            and ("%s %s"):format(race.label or "?", class.label or "?")
            or "this character"
        return giveUp(("The client declined to render a model for %s, so no portrait is shown.")
            :format(who))
    end

    if model.SetPortraitZoom then pcall(model.SetPortraitZoom, model, 0.35) end
    if model.SetRotation    then pcall(model.SetRotation, model, 0.35, false) end
end

--------------------------------------------------------------------------
-- hours grid
--------------------------------------------------------------------------

-- A read-only strip of 24 cells. The editor builds its own interactive copy;
-- this one is deliberately dumb so the plate cannot mutate anything.
local function BuildHourRow(parent)
    local row = CreateFrame("Frame", nil, parent)
    row:SetSize((CELL_W + CELL_GAP) * 24, CELL_H)
    row.cells = {}

    for i = 1, 24 do
        local cell = row:CreateTexture(nil, "ARTWORK")
        cell:SetSize(CELL_W, CELL_H)
        cell:SetPoint("LEFT", (i - 1) * (CELL_W + CELL_GAP), 0)
        row.cells[i] = cell
    end

    return row
end

local function RefreshHourRow(row, hours, colour)
    for i = 1, 24 do
        if hours and hours[i] then
            row.cells[i]:SetColorTexture(colour.r, colour.g, colour.b, 0.95)
        else
            row.cells[i]:SetColorTexture(0.18, 0.18, 0.21, 0.85)
        end
    end
end

--------------------------------------------------------------------------
-- construction
--------------------------------------------------------------------------

local function Build()
    local f = CreateFrame("Frame", "AdventurerPlatesFrame", UIParent, "BackdropTemplate")
    f:SetSize(WIDTH, HEIGHT)
    f:SetPoint("CENTER")
    f:SetFrameStrata("DIALOG")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:SetClampedToScreen(true)
    Backdrop(f)
    f:Hide()

    local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -2, -2)

    local heading = Text(f, "GameFontNormalLarge")
    heading:SetPoint("TOPLEFT", 14, -12)
    heading:SetText("Adventurer Plate")
    heading:SetTextColor(COL_LABEL.r, COL_LABEL.g, COL_LABEL.b)

    -- ---- portrait + identity block
    f.portrait = BuildPortrait(f)
    f.portrait:SetPoint("TOPLEFT", 14, -40)

    local ix = 14 + PORTRAIT_W + 14

    f.name = Text(f, "GameFontNormalLarge")
    f.name:SetPoint("TOPLEFT", ix, -44)
    f.name:SetWidth(WIDTH - ix - 14)

    f.realm = Text(f, "GameFontHighlightSmall")
    f.realm:SetPoint("TOPLEFT", ix, -66)
    f.realm:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)

    f.title = Text(f, "GameFontHighlight")
    f.title:SetPoint("TOPLEFT", ix, -88)
    f.title:SetWidth(WIDTH - ix - 14)

    f.levelLine = Text(f, "GameFontHighlight")
    f.levelLine:SetPoint("TOPLEFT", ix, -112)
    f.levelLine:SetWidth(WIDTH - ix - 14)

    f.guild = Text(f, "GameFontHighlight")
    f.guild:SetPoint("TOPLEFT", ix, -136)
    f.guild:SetWidth(WIDTH - ix - 14)
    f.guild:SetWordWrap(true)

    f.guildRank = Text(f, "GameFontHighlightSmall")
    f.guildRank:SetPoint("TOPLEFT", ix, -160)
    f.guildRank:SetWidth(WIDTH - ix - 14)
    f.guildRank:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)

    -- ---- playstyle
    local tagLabel = Text(f, "GameFontNormal")
    tagLabel:SetPoint("TOPLEFT", 14, -244)
    tagLabel:SetText("Playstyle & Focus")
    tagLabel:SetTextColor(COL_LABEL.r, COL_LABEL.g, COL_LABEL.b)

    f.tags = Text(f, "GameFontHighlight")
    f.tags:SetPoint("TOPLEFT", 14, -266)
    f.tags:SetWidth(WIDTH - 28)
    f.tags:SetWordWrap(true)
    f.tags:SetJustifyV("TOP")

    -- ---- active hours
    local hoursLabel = Text(f, "GameFontNormal")
    hoursLabel:SetPoint("TOPLEFT", 14, -330)
    hoursLabel:SetText("Active Hours (server time)")
    hoursLabel:SetTextColor(COL_LABEL.r, COL_LABEL.g, COL_LABEL.b)

    f.weekdayLabel = Text(f, "GameFontHighlightSmall")
    f.weekdayLabel:SetPoint("TOPLEFT", 14, -354)
    f.weekdayLabel:SetText("Weekday")

    f.weekdayRow = BuildHourRow(f)
    f.weekdayRow:SetPoint("TOPLEFT", 14, -370)

    f.weekdayText = Text(f, "GameFontHighlightSmall")
    f.weekdayText:SetPoint("TOPLEFT", 14, -390)
    f.weekdayText:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)

    f.weekendLabel = Text(f, "GameFontHighlightSmall")
    f.weekendLabel:SetPoint("TOPLEFT", 14, -414)
    f.weekendLabel:SetText("Weekend")

    f.weekendRow = BuildHourRow(f)
    f.weekendRow:SetPoint("TOPLEFT", 14, -430)

    f.weekendText = Text(f, "GameFontHighlightSmall")
    f.weekendText:SetPoint("TOPLEFT", 14, -450)
    f.weekendText:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)

    -- hour scale, every 6 hours so the strip stays readable
    for _, h in ipairs({ 0, 6, 12, 18 }) do
        local mark = Text(f, "GameFontDisableSmall")
        mark:SetPoint("TOPLEFT", 14 + h * (CELL_W + CELL_GAP), -466)
        mark:SetText(("%02d"):format(h))
    end

    -- ---- motto
    local mottoLabel = Text(f, "GameFontNormal")
    mottoLabel:SetPoint("TOPLEFT", 14, -488)
    mottoLabel:SetText("Motto")
    mottoLabel:SetTextColor(COL_LABEL.r, COL_LABEL.g, COL_LABEL.b)

    f.motto = Text(f, "GameFontHighlight")
    f.motto:SetPoint("TOPLEFT", 14, -508)
    f.motto:SetWidth(WIDTH - 28)
    f.motto:SetWordWrap(true)
    f.motto:SetJustifyV("TOP")

    -- ---- actions
    local edit = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    edit:SetSize(110, 22)
    edit:SetPoint("BOTTOMLEFT", 14, 12)
    edit:SetText("Edit Plate")
    edit:SetScript("OnClick", function()
        if ns.Editor then ns.Editor.Toggle() end
    end)

    local dismiss = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    dismiss:SetSize(110, 22)
    dismiss:SetPoint("BOTTOMRIGHT", -14, 12)
    dismiss:SetText("Close")
    dismiss:SetScript("OnClick", function() f:Hide() end)

    f.stamp = Text(f, "GameFontDisableSmall", "CENTER")
    f.stamp:SetPoint("BOTTOM", 0, 18)

    return f
end

--------------------------------------------------------------------------
-- refresh
--------------------------------------------------------------------------

function P.Refresh()
    local f = P.frame
    if not f then return end

    local plate, why = D.Load()
    if not plate then
        -- Cannot read saved data: show the reason where the plate would be
        -- rather than an empty card that looks like a bug.
        f.name:SetText("Plate unavailable")
        f.name:SetTextColor(1, 0.4, 0.4)
        f.realm:SetText(why or "Saved data could not be read.")
        f.title:SetText("")
        f.levelLine:SetText("")
        f.guild:SetText("")
        f.guildRank:SetText("")
        f.tags:SetText("")
        f.motto:SetText("")
        f.stamp:SetText("")
        return
    end

    local id        = D.Name()
    local class     = D.Class()
    local race      = D.Race()
    local level     = D.Level()
    local colour    = D.ClassColor(class and class.file)

    -- name + realm
    if id then
        f.name:SetText(id.name)
        f.name:SetTextColor(colour.r, colour.g, colour.b)
        f.realm:SetText(id.realm or "Realm unknown.")
    else
        f.name:SetText("Unknown character")
        f.name:SetTextColor(1, 1, 1)
        f.realm:SetText("The client did not return a character name.")
    end

    -- title: the player's chosen one, else whatever is equipped, else a sentence
    local titleID = plate.titleID or D.CurrentTitleID()
    local titleText = titleID and D.TitleText(titleID) or nil
    if titleText then
        f.title:SetText(titleText)
        f.title:SetTextColor(1, 1, 1)
    else
        f.title:SetText("No title set.")
        f.title:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)
    end

    -- level / race / class
    local bits = {}
    bits[#bits + 1] = level and ("Level %d"):format(level) or nil
    bits[#bits + 1] = race and race.label or nil
    bits[#bits + 1] = class and class.label or nil
    if #bits > 0 then
        f.levelLine:SetText(table.concat(bits, "  "))
        f.levelLine:SetTextColor(1, 1, 1)
    else
        f.levelLine:SetText("Level, race and class could not be read from the client.")
        f.levelLine:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)
    end

    -- guild
    local guild, guildWhy = D.Guild()
    if guild then
        f.guild:SetText("<" .. guild.name .. ">")
        f.guild:SetTextColor(0.6, 0.9, 0.6)
        f.guildRank:SetText(guild.rank or "Rank not reported.")
    else
        f.guild:SetText(guildWhy or "Not in a guild.")
        f.guild:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)
        f.guildRank:SetText("")
    end

    -- portrait
    RefreshPortrait(f.portrait, race, class)

    -- tags
    local chosen = {}
    for _, t in ipairs(D.TAGS) do
        if plate.tags[t.key] then chosen[#chosen + 1] = t.label end
    end
    if #chosen > 0 then
        f.tags:SetText(table.concat(chosen, "   "))
        f.tags:SetTextColor(1, 1, 1)
    else
        f.tags:SetText("No playstyle tags chosen yet. Use Edit Plate to add some.")
        f.tags:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)
    end

    -- hours
    RefreshHourRow(f.weekdayRow, plate.hours.weekday, colour)
    RefreshHourRow(f.weekendRow, plate.hours.weekend, colour)

    local wdText, wdWhy = D.HourRanges(plate.hours.weekday)
    f.weekdayText:SetText(wdText or wdWhy or "")
    local weText, weWhy = D.HourRanges(plate.hours.weekend)
    f.weekendText:SetText(weText or weWhy or "")

    -- motto
    if plate.motto and plate.motto ~= "" then
        f.motto:SetText(plate.motto)
        f.motto:SetTextColor(1, 1, 1)
    else
        f.motto:SetText("No motto written yet.")
        f.motto:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)
    end

    -- stamp
    if plate.updated and plate.updated > 0 then
        f.stamp:SetText("Last edited " .. date("%Y-%m-%d %H:%M", plate.updated))
    else
        f.stamp:SetText("Never edited.")
    end
end

function P.Show()
    if not P.frame then P.frame = Build() end
    P.Refresh()
    P.frame:Show()
end

function P.Hide()
    if P.frame then P.frame:Hide() end
end

function P.Toggle()
    if P.frame and P.frame:IsShown() then
        P.Hide()
    else
        P.Show()
    end
end

--------------------------------------------------------------------------
-- commands
--------------------------------------------------------------------------

ns.RegisterCommand("show", function() P.Toggle() end, "show or hide your Adventurer Plate")
