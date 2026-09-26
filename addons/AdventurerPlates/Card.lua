-- Adventurer Plates (Card) -- landscape card layout
--
-- Fork of the portrait plate, reshaped after a real FFXIV Adventurer Plate:
-- landscape, portrait as the hero element on the right, level/class as a
-- typographic block rather than a sentence, playstyle as a row of badges, and
-- an hours strip labelled only at 12am and 12pm.
--
-- The portrait plate still exists as its own addon. Neither reaches into the
-- other; per AGENTS.md each addon is self-contained, and the duplication is the
-- sanctioned cost of that.
--
-- No OnUpdate. Redraws on show and on save.

local ADDON, ns = ...

local C = {}
ns.Card = C

local D = ns.Data

-- Roughly 2:1, the proportion that makes it read as a card rather than a panel.
-- Height carries a two-line motto clear of the action row; the motto wraps, so
-- it is the one dimension that must not be tight.
local WIDTH, HEIGHT = 800, 448

-- Portrait occupies the right edge, full height, bleeding to the border.
local PORTRAIT_W = 290
local LEFT_W     = WIDTH - PORTRAIT_W          -- 510
local PAD        = 20

-- Hour ticks: taller than wide, like the FFXIV strip. 24 * (13+3) = 384, which
-- fits the left column with the row label beside it.
local TICK_W, TICK_H, TICK_GAP = 13, 16, 3
local ROW_LABEL_W = 78
local ROW_X = PAD + ROW_LABEL_W

local BADGE = 32

local COL_DIM   = { r = 0.60, g = 0.60, b = 0.65 }
local COL_LABEL = { r = 1.00, g = 0.82, b = 0.00 }

--------------------------------------------------------------------------
-- builders
--------------------------------------------------------------------------

local function Text(parent, font, justify)
    local fs = parent:CreateFontString(nil, "OVERLAY", font or "GameFontHighlight")
    fs:SetJustifyH(justify or "LEFT")
    fs:SetWordWrap(false)
    return fs
end

local function Backdrop(frame, alpha)
    if not frame.SetBackdrop then return end
    frame:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
    })
    frame:SetBackdropColor(0.04, 0.04, 0.06, alpha or 0.95)
    frame:SetBackdropBorderColor(0.28, 0.28, 0.34, 1)
end

--------------------------------------------------------------------------
-- portrait -- the hero element
--------------------------------------------------------------------------

-- The capability probe's SetUnit test was invalid: it hid the frame first, and
-- a hidden model does not load geometry. Keeping the model on hide and setting
-- the unit on a SHOWN frame is what actually works on build 69913 -- confirmed
-- in game, not inferred.
local function BuildPortrait(parent)
    local holder = CreateFrame("Frame", nil, parent)
    holder:SetPoint("TOPRIGHT", -1, -1)
    holder:SetPoint("BOTTOMRIGHT", -1, 1)
    holder:SetWidth(PORTRAIT_W)

    local bg = holder:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0.07, 0.07, 0.10, 1)

    local model = CreateFrame("PlayerModel", nil, holder)
    model:SetAllPoints()
    if model.SetKeepModelOnHide then pcall(model.SetKeepModelOnHide, model, true) end

    local fallback = holder:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    fallback:SetPoint("TOPLEFT", 12, -12)
    fallback:SetPoint("BOTTOMRIGHT", -12, 12)
    fallback:SetJustifyH("CENTER")
    fallback:SetJustifyV("MIDDLE")
    fallback:SetWordWrap(true)
    fallback:Hide()

    -- A soft vertical seam so the model does not collide with the text column.
    local seam = holder:CreateTexture(nil, "OVERLAY")
    seam:SetWidth(1)
    seam:SetPoint("TOPLEFT", 0, 0)
    seam:SetPoint("BOTTOMLEFT", 0, 0)
    seam:SetColorTexture(0.28, 0.28, 0.34, 0.9)

    holder.model = model
    holder.fallback = fallback
    return holder
end

-- `unit` is the token to render, or nil when there is nobody the client can
-- see. For your own card that is always "player". For someone else's it is
-- "target" or "mouseover" when they happen to be in front of you, and nil
-- otherwise -- a model can only be drawn for a unit the client has loaded.
local function RefreshPortrait(holder, raceLabel, classLabel, unit, whoFor)
    local model, fallback = holder.model, holder.fallback

    local function giveUp(reason)
        model:Hide()
        fallback:SetText(reason)
        fallback:Show()
    end

    if not model or not model.SetUnit then
        return giveUp("This client did not provide a model frame, so there is no portrait.")
    end

    local who = (raceLabel and classLabel)
        and ("%s %s"):format(raceLabel, classLabel)
        or "this character"

    if not unit then
        -- Missing data becomes a sentence. Say what we do know -- race and
        -- class came over the wire -- and why there is no picture, rather than
        -- drawing something that implies we have one.
        return giveUp(("%s is a %s.\n\nNo portrait: a 3D model can only be drawn for someone the client can currently see. Target them or mouse over them, then open this again.")
            :format(whoFor or "This character", who))
    end

    model:Show()
    fallback:Hide()

    local ok, success = pcall(model.SetUnit, model, unit, false)
    if not ok then
        return giveUp("The portrait could not be loaded: " .. tostring(success))
    end
    if success == false then
        return giveUp(("The client declined to render a model for %s, so no portrait is shown.")
            :format(who))
    end

    -- Wider framing than the portrait layout used: this is a full-height hero
    -- image, so it wants more of the body in frame and less head.
    if model.SetPortraitZoom then pcall(model.SetPortraitZoom, model, 0.06) end
    if model.SetRotation    then pcall(model.SetRotation, model, 0.42, false) end
end

--------------------------------------------------------------------------
-- hours strip
--------------------------------------------------------------------------

local function BuildTickRow(parent)
    local row = CreateFrame("Frame", nil, parent)
    row:SetSize((TICK_W + TICK_GAP) * 24, TICK_H)
    row.ticks = {}
    for i = 1, 24 do
        local t = row:CreateTexture(nil, "ARTWORK")
        t:SetSize(TICK_W, TICK_H)
        t:SetPoint("LEFT", (i - 1) * (TICK_W + TICK_GAP), 0)
        row.ticks[i] = t
    end
    return row
end

local function RefreshTickRow(row, hours, colour)
    for i = 1, 24 do
        if hours and hours[i] then
            row.ticks[i]:SetColorTexture(colour.r, colour.g, colour.b, 0.95)
        else
            row.ticks[i]:SetColorTexture(0.16, 0.16, 0.19, 0.9)
        end
    end
end

--------------------------------------------------------------------------
-- badges
--------------------------------------------------------------------------

-- One badge per chosen tag, capped by D.MAX_TAGS so the row is a fixed width
-- and cannot wrap into the hours strip below it.
local function BuildBadges(parent)
    local badges = {}
    for i = 1, D.MAX_TAGS do
        local b = CreateFrame("Frame", nil, parent)
        b:SetSize(BADGE, BADGE)
        b:SetPoint("TOPLEFT", PAD + (i - 1) * (BADGE + 8), -232)

        local fill = b:CreateTexture(nil, "ARTWORK")
        fill:SetAllPoints()
        b.fill = fill

        local text = b:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        text:SetPoint("CENTER")
        b.text = text

        b:Hide()
        badges[i] = b
    end
    return badges
end

local function RefreshBadges(badges, plate)
    local shown = 0
    for _, tag in ipairs(D.TAGS) do
        if plate.tags[tag.key] and shown < D.MAX_TAGS then
            shown = shown + 1
            local b = badges[shown]
            local c = tag.rgb or { 0.5, 0.5, 0.5 }
            b.fill:SetColorTexture(c[1], c[2], c[3], 0.92)
            b.text:SetText(tag.abbr or "?")
            -- Dark glyph on a saturated field reads better than white here.
            b.text:SetTextColor(0.08, 0.08, 0.10)
            b:Show()
        end
    end
    for i = shown + 1, D.MAX_TAGS do badges[i]:Hide() end
    return shown
end

--------------------------------------------------------------------------
-- construction
--------------------------------------------------------------------------

local function Build()
    local f = CreateFrame("Frame", "AdventurerPlatesFrame", UIParent, "BackdropTemplate")
    f:SetSize(WIDTH, HEIGHT)
    -- Offset opposite to the portrait original, which also defaults to CENTER.
    -- Both title bars stay reachable when the two are open together.
    f:SetPoint("CENTER", 90, -50)
    f:SetFrameStrata("DIALOG")
    f:SetMovable(true)
    f:EnableMouse(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:SetClampedToScreen(true)
    -- Click-to-front. Two windows in one strata otherwise keep whatever
    -- relative order they were given, and there is no way to get at the one
    -- underneath. SetToplevel makes a click raise this frame within DIALOG,
    -- which is what every other window on screen already does.
    f:SetToplevel(true)
    Backdrop(f)
    f:Hide()

    f.portrait = BuildPortrait(f)

    local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -2, -2)

    ------------------------------------------------------------- identity
    f.name = Text(f, "GameFontNormalLarge")
    f.name:SetPoint("TOPLEFT", PAD, -20)
    f.name:SetWidth(LEFT_W - PAD * 2 - 140)

    -- Realm sits top-right of the text column, as FFXIV puts the world name
    -- top-right of the card. Keeps the most valuable vertical space free.
    f.realm = Text(f, "GameFontHighlightSmall", "RIGHT")
    f.realm:SetPoint("TOPRIGHT", -(PORTRAIT_W + PAD), -24)
    f.realm:SetWidth(180)
    f.realm:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)

    f.title = Text(f, "GameFontHighlightSmall")
    f.title:SetPoint("TOPLEFT", PAD, -46)
    f.title:SetWidth(LEFT_W - PAD * 2)

    local rule = f:CreateTexture(nil, "ARTWORK")
    rule:SetHeight(1)
    rule:SetPoint("TOPLEFT", PAD, -68)
    rule:SetPoint("TOPRIGHT", -(PORTRAIT_W + PAD), -68)
    rule:SetColorTexture(0.32, 0.32, 0.40, 0.7)

    ---------------------------------------------------- level / class block
    -- The FFXIV hierarchy: small "LEVEL n" above a large class name. This is
    -- the focal point of the card, not a line of prose.
    f.levelSmall = Text(f, "GameFontNormalSmall")
    f.levelSmall:SetPoint("TOPLEFT", PAD, -82)
    f.levelSmall:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)

    f.className = Text(f, "GameFontNormalLarge")
    f.className:SetPoint("TOPLEFT", PAD, -98)
    f.className:SetWidth(LEFT_W - PAD * 2)

    f.raceName = Text(f, "GameFontHighlightSmall")
    f.raceName:SetPoint("TOPLEFT", PAD, -124)
    f.raceName:SetWidth(LEFT_W - PAD * 2)
    f.raceName:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)

    ---------------------------------------------------------------- guild
    f.guild = Text(f, "GameFontHighlight")
    f.guild:SetPoint("TOPLEFT", PAD, -152)
    f.guild:SetWidth(LEFT_W - PAD * 2)

    f.guildRank = Text(f, "GameFontHighlightSmall")
    f.guildRank:SetPoint("TOPLEFT", PAD, -172)
    f.guildRank:SetWidth(LEFT_W - PAD * 2)
    f.guildRank:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)

    --------------------------------------------------------------- badges
    f.tagHeading = Text(f, "GameFontNormalSmall")
    f.tagHeading:SetPoint("TOPLEFT", PAD, -212)
    f.tagHeading:SetText("PLAYSTYLE & FOCUS")
    f.tagHeading:SetTextColor(COL_LABEL.r, COL_LABEL.g, COL_LABEL.b)

    f.badges = BuildBadges(f)

    f.noTags = Text(f, "GameFontHighlightSmall")
    f.noTags:SetPoint("TOPLEFT", PAD, -242)
    f.noTags:SetWidth(LEFT_W - PAD * 2)
    f.noTags:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)

    ---------------------------------------------------------------- hours
    -- The heading gets its own line. It previously shared y with the 12:00 a.m.
    -- label, and "ACTIVE HOURS" is wider than the 78px row-label gutter, so it
    -- overran the label and swallowed its leading "1".
    f.hoursHeading = Text(f, "GameFontNormalSmall")
    f.hoursHeading:SetPoint("TOPLEFT", PAD, -276)
    f.hoursHeading:SetText("ACTIVE HOURS")
    f.hoursHeading:SetTextColor(COL_LABEL.r, COL_LABEL.g, COL_LABEL.b)

    -- Only two labels, as FFXIV does. Four (00/06/12/18) turned the strip into
    -- a chart; two keeps it a shape you read at a glance. Both align to the
    -- tick column they actually mark: hour 0 and hour 12.
    local midnight = Text(f, "GameFontDisableSmall")
    midnight:SetPoint("TOPLEFT", ROW_X, -296)
    midnight:SetText("12:00 a.m.")

    local noon = Text(f, "GameFontDisableSmall")
    noon:SetPoint("TOPLEFT", ROW_X + 12 * (TICK_W + TICK_GAP), -296)
    noon:SetText("12:00 p.m.")

    f.weekdayLabel = Text(f, "GameFontHighlightSmall")
    f.weekdayLabel:SetPoint("TOPLEFT", PAD, -314)
    f.weekdayLabel:SetText("Weekdays")

    f.weekdayRow = BuildTickRow(f)
    f.weekdayRow:SetPoint("TOPLEFT", ROW_X, -312)

    f.weekendLabel = Text(f, "GameFontHighlightSmall")
    f.weekendLabel:SetPoint("TOPLEFT", PAD, -338)
    f.weekendLabel:SetText("Weekends")

    f.weekendRow = BuildTickRow(f)
    f.weekendRow:SetPoint("TOPLEFT", ROW_X, -336)

    f.hoursText = Text(f, "GameFontDisableSmall")
    f.hoursText:SetPoint("TOPLEFT", ROW_X, -358)
    f.hoursText:SetWidth(LEFT_W - ROW_X - PAD)

    ---------------------------------------------------------------- motto
    f.motto = Text(f, "GameFontHighlight")
    f.motto:SetPoint("TOPLEFT", PAD, -382)
    f.motto:SetWidth(LEFT_W - PAD * 2)
    f.motto:SetWordWrap(true)
    f.motto:SetJustifyV("TOP")

    -------------------------------------------------------------- actions
    f.editButton = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    f.editButton:SetSize(104, 20)
    f.editButton:SetPoint("BOTTOMLEFT", PAD, 12)
    f.editButton:SetText("Edit Plate")
    f.editButton:SetScript("OnClick", function()
        if ns.Editor then ns.Editor.Toggle() end
    end)

    -- Occupies the same slot as Edit. Shown only while viewing someone else's
    -- plate, so the action row itself tells you whose card you are looking at.
    f.backButton = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    f.backButton:SetSize(104, 20)
    f.backButton:SetPoint("BOTTOMLEFT", PAD, 12)
    f.backButton:SetText("My Plate")
    f.backButton:SetScript("OnClick", function() C.Show() end)
    f.backButton:Hide()

    f.stamp = Text(f, "GameFontDisableSmall")
    f.stamp:SetPoint("BOTTOMLEFT", PAD + 116, 17)

    return f
end

--------------------------------------------------------------------------
-- refresh
--------------------------------------------------------------------------

-- Which unit token, if any, the client can render for a given character.
-- Checked in order of how likely the model is already loaded.
local function VisibleUnitFor(name)
    if not name then return nil end
    for _, token in ipairs({ "target", "mouseover", "focus",
                             "party1", "party2", "party3", "party4" }) do
        local ok, unitName = pcall(UnitName, token)
        if ok and unitName and unitName == name then return token end
    end
    return nil
end

-- Renders either your own card or one that arrived over the wire.
--
-- `remote` is nil for your own, or a sanitised payload from Share.Decode.
-- Everything the card shows is read from one `view` table built here, so the
-- drawing code below does not care which it is -- the alternative was a branch
-- at every single field, which is where this sort of thing rots.
function C.Refresh(remote)
    local f = C.frame
    if not f then return end

    local view, plate

    if remote then
        plate = remote
        view = {
            name      = remote.name or "Unknown",
            realm     = remote.realm,
            level     = remote.level,
            raceLabel = remote.race,
            className = remote.class,
            classFile = remote.classFile,
            guildName = remote.guild,
            guildRank = remote.rank,
            titleText = nil,   -- titles are client-local; see below
            isRemote  = true,
        }
    else
        local stored, why = D.Load()
        if not stored then
            f.name:SetText("Card unavailable")
            f.name:SetTextColor(1, 0.4, 0.4)
            f.title:SetText(why or "Saved data could not be read.")
            f.levelSmall:SetText("")
            f.className:SetText("")
            f.raceName:SetText("")
            f.guild:SetText("")
            f.guildRank:SetText("")
            f.noTags:SetText("")
            f.motto:SetText("")
            f.stamp:SetText("")
            return
        end

        plate = stored
        local id    = D.Name()
        local class = D.Class()
        local race  = D.Race()
        -- One call, both returns: D.Guild() hits an undocumented global, so
        -- calling it twice to get the reason string would double that risk for
        -- no reason.
        local guild, guildWhy = D.Guild()
        view = {
            name      = id and id.name or "Unknown character",
            realm     = id and id.realm or nil,
            level     = D.Level(),
            raceLabel = race and race.label or nil,
            className = class and class.label or nil,
            classFile = class and class.file or nil,
            guildName = guild and guild.name or nil,
            guildRank = guild and guild.rank or nil,
            guildWhy  = guildWhy,
            isRemote  = false,
        }
    end

    local colour = D.ClassColor(view.classFile)

    -- The card has no title bar by design -- the name is the heading. So
    -- "whose plate is this" is signalled by swapping the action row rather
    -- than by adding chrome: you cannot edit someone else's plate.
    f.editButton:SetShown(not view.isRemote)
    f.backButton:SetShown(view.isRemote)

    -- name + realm
    f.name:SetText(view.name)
    f.name:SetTextColor(colour.r, colour.g, colour.b)
    f.realm:SetText(view.realm or "Realm unknown")

    -- Title. GetTitleName resolves against the LOCAL client's title table, so
    -- a remote titleID is only meaningful if this client knows that id too.
    -- Resolving it is correct; inventing a name for an unknown id is not.
    local titleID = plate.titleID or (not view.isRemote and D.CurrentTitleID()) or nil
    local titleText = titleID and D.TitleText(titleID) or nil
    if titleText then
        f.title:SetText(titleText)
        f.title:SetTextColor(1, 1, 1)
    else
        f.title:SetText(view.isRemote and (titleID and "Title unknown to this client." or "No title set.")
                                       or "No title set.")
        f.title:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)
    end

    -- level / class / race
    f.levelSmall:SetText(view.level and ("LEVEL %d"):format(view.level) or "LEVEL ?")
    if view.className then
        f.className:SetText(view.className:upper())
        f.className:SetTextColor(colour.r, colour.g, colour.b)
    else
        f.className:SetText("CLASS UNKNOWN")
        f.className:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)
    end
    f.raceName:SetText(view.raceLabel or "Race not reported.")

    -- guild
    if view.guildName then
        f.guild:SetText("<" .. view.guildName .. ">")
        f.guild:SetTextColor(0.6, 0.9, 0.6)
        f.guildRank:SetText(view.guildRank or "Rank not reported.")
    else
        f.guild:SetText(view.guildWhy or "Not in a guild.")
        f.guild:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)
        f.guildRank:SetText("")
    end

    -- portrait: your own is always renderable; someone else's only if the
    -- client currently has them loaded.
    local unit = view.isRemote and VisibleUnitFor(view.name) or "player"
    RefreshPortrait(f.portrait, view.raceLabel, view.className, unit,
        view.isRemote and view.name or nil)

    -- badges
    local shown = RefreshBadges(f.badges, plate)
    if shown == 0 then
        f.noTags:SetText(view.isRemote
            and "No playstyle tags on this plate."
            or "No playstyle tags chosen yet. Use Edit Plate to add some.")
    else
        f.noTags:SetText("")
    end

    -- hours
    RefreshTickRow(f.weekdayRow, plate.hours.weekday, colour)
    RefreshTickRow(f.weekendRow, plate.hours.weekend, colour)

    local wd, wdWhy = D.HourRanges(plate.hours.weekday)
    local we, weWhy = D.HourRanges(plate.hours.weekend)
    if wd or we then
        f.hoursText:SetText(("Weekdays %s   |   Weekends %s")
            :format(wd or "none", we or "none"))
    else
        f.hoursText:SetText(wdWhy or weWhy or "No hours set.")
    end

    -- motto
    if plate.motto and plate.motto ~= "" then
        f.motto:SetText(plate.motto)
        f.motto:SetTextColor(1, 1, 1)
    else
        f.motto:SetText(view.isRemote and "No motto on this plate." or "No motto written yet.")
        f.motto:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)
    end

    -- stamp
    if plate.updated and plate.updated > 0 then
        f.stamp:SetText((view.isRemote and "They last edited " or "Last edited ")
            .. date("%Y-%m-%d %H:%M", plate.updated))
    else
        f.stamp:SetText(view.isRemote and "Never edited by them." or "Never edited.")
    end
end

function C.Show()
    if not C.frame then C.frame = Build() end
    C.viewing = nil
    C.Refresh()
    C.frame:Show()
end

-- Show a plate that arrived over the wire. Only ever called for a plate we
-- asked for -- Share.lua will not open this on an unsolicited message, because
-- a stranger must not be able to put a window on your screen.
function C.ShowRemote(sender, payload)
    if not C.frame then C.frame = Build() end
    C.viewing = { sender = sender, payload = payload }
    C.Refresh(payload)
    C.frame:Show()
end

function C.Hide()
    if C.frame then C.frame:Hide() end
end

function C.Toggle()
    if C.frame and C.frame:IsShown() and not C.viewing then
        C.Hide()
    else
        C.Show()
    end
end

--------------------------------------------------------------------------
-- commands
--------------------------------------------------------------------------

ns.RegisterCommand("show", function() C.Toggle() end, "show or hide your Adventurer Card")
