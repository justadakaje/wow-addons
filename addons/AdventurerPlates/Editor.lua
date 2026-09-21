-- Adventurer Plates -- the editor
--
-- Edits a working COPY of the plate and only writes it back on Save, so
-- Cancel is a real cancel and a half-finished edit never reaches disk.
--
-- SavedVariables are flushed by the client on /reload or logout, never by us.
-- Save writes to the in-memory table; that is all any addon can do.

local ADDON, ns = ...

local E = {}
ns.Editor = E

local D = ns.Data

local WIDTH, HEIGHT = 540, 624
local CELL_W, CELL_H, CELL_GAP = 16, 16, 2

local COL_LABEL = { r = 1.00, g = 0.82, b = 0.00 }
local COL_DIM   = { r = 0.62, g = 0.62, b = 0.66 }

-- Deep-ish copy. The plate is two levels of plain tables, so this is enough;
-- it is not a general deep copy and should not be reused as one.
local function CopyPlate(p)
    local out = D.NewPlate()
    out.titleID = p.titleID
    out.motto   = p.motto or ""
    out.updated = p.updated or 0
    for k, v in pairs(p.tags or {}) do out.tags[k] = v and true or nil end
    for _, part in ipairs({ "weekday", "weekend" }) do
        for i = 1, 24 do out.hours[part][i] = (p.hours and p.hours[part] and p.hours[part][i]) or false end
    end
    return out
end

local function Backdrop(frame, alpha)
    if not frame.SetBackdrop then return end
    frame:SetBackdrop({
        bgFile   = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Buttons\\WHITE8X8",
        edgeSize = 1,
    })
    frame:SetBackdropColor(0.05, 0.05, 0.07, alpha or 0.95)
    frame:SetBackdropBorderColor(0.25, 0.25, 0.30, 1)
end

local function Text(parent, font, justify)
    local fs = parent:CreateFontString(nil, "OVERLAY", font or "GameFontHighlight")
    fs:SetJustifyH(justify or "LEFT")
    return fs
end

-- A hairline under a section heading. Cheap, and it stops the panel reading as
-- one undifferentiated wall of controls.
local function Divider(parent, y)
    local line = parent:CreateTexture(nil, "ARTWORK")
    line:SetHeight(1)
    line:SetPoint("TOPLEFT", 14, y)
    line:SetPoint("TOPRIGHT", -14, y)
    line:SetColorTexture(0.35, 0.35, 0.42, 0.65)
    return line
end

-- The editor and the plate are separate top-level frames, and in the same
-- strata their children interleave by frame level rather than by which window
-- you think is "in front". That is what made plate text punch through the
-- editor panel. Putting the editor one strata up makes the ordering explicit
-- instead of incidental.
local EDITOR_STRATA = "FULLSCREEN_DIALOG"

-- Open beside the plate rather than on top of it. Anchored on each open, so
-- dragging either window during a session still works and the next open tidies
-- up again.
local function PositionBeside(f)
    f:ClearAllPoints()
    local plate = ns.Plate and ns.Plate.frame
    if plate and plate:IsShown() then
        f:SetPoint("TOPLEFT", plate, "TOPRIGHT", 12, 0)
    else
        f:SetPoint("CENTER")
    end
end

--------------------------------------------------------------------------
-- interactive hour row
--------------------------------------------------------------------------

-- Click to toggle one hour; click-and-drag paints, because setting 14 hours
-- one click at a time is miserable. The drag state lives on the row, not in a
-- global, so two rows cannot fight over it.
local function BuildHourRow(parent, part, onChange)
    local row = CreateFrame("Frame", nil, parent)
    row:SetSize((CELL_W + CELL_GAP) * 24, CELL_H)
    row.part = part
    row.cells = {}

    for i = 1, 24 do
        local cell = CreateFrame("Button", nil, row)
        cell:SetSize(CELL_W, CELL_H)
        cell:SetPoint("LEFT", (i - 1) * (CELL_W + CELL_GAP), 0)

        local tex = cell:CreateTexture(nil, "ARTWORK")
        tex:SetAllPoints()
        cell.tex = tex

        cell:SetScript("OnMouseDown", function()
            local plate = E.working
            if not plate then return end
            -- The first cell decides whether this drag turns hours on or off,
            -- so dragging across a mixed range does one consistent thing.
            row.paintTo = not plate.hours[part][i]
            plate.hours[part][i] = row.paintTo
            onChange()
        end)

        cell:SetScript("OnMouseUp", function() row.paintTo = nil end)

        cell:SetScript("OnEnter", function()
            local plate = E.working
            if not plate or row.paintTo == nil then return end

            -- Releasing the button outside the row never delivers OnMouseUp to
            -- a cell, which would leave the drag armed and repaint on the next
            -- accidental hover. Confirm the button is still physically down.
            if not IsMouseButtonDown("LeftButton") then
                row.paintTo = nil
                return
            end

            plate.hours[part][i] = row.paintTo
            onChange()
        end)

        row.cells[i] = cell
    end

    -- A mouse-up outside the row must end the drag too, or the next hover
    -- keeps painting.
    row:SetScript("OnHide", function() row.paintTo = nil end)

    return row
end

local function RefreshHourRow(row, hours, colour)
    for i = 1, 24 do
        if hours[i] then
            row.cells[i].tex:SetColorTexture(colour.r, colour.g, colour.b, 0.95)
        else
            row.cells[i].tex:SetColorTexture(0.18, 0.18, 0.21, 0.9)
        end
    end
end

--------------------------------------------------------------------------
-- construction
--------------------------------------------------------------------------

local function Build()
    local f = CreateFrame("Frame", "AdventurerPlatesEditor", UIParent, "BackdropTemplate")
    f:SetSize(WIDTH, HEIGHT)
    f:SetPoint("CENTER")
    f:SetFrameStrata(EDITOR_STRATA)
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
    close:SetScript("OnClick", function() E.Cancel() end)

    local heading = Text(f, "GameFontNormalLarge")
    heading:SetPoint("TOPLEFT", 14, -12)
    heading:SetText("Edit Adventurer Plate")
    heading:SetTextColor(COL_LABEL.r, COL_LABEL.g, COL_LABEL.b)
    Divider(f, -34)

    ----------------------------------------------------------------- title
    local titleLabel = Text(f, "GameFontNormal")
    titleLabel:SetPoint("TOPLEFT", 14, -44)
    titleLabel:SetText("Title")
    titleLabel:SetTextColor(COL_LABEL.r, COL_LABEL.g, COL_LABEL.b)

    f.titleValue = Text(f, "GameFontHighlight")
    f.titleValue:SetPoint("TOPLEFT", 14, -64)
    f.titleValue:SetWidth(WIDTH - 180)

    -- Cycles through earned titles. A dropdown would be nicer, but with zero
    -- titles earned on this client the list is usually empty, and a cycle
    -- button degrades to a clear sentence instead of an empty menu.
    f.titleNext = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    f.titleNext:SetSize(90, 22)
    f.titleNext:SetPoint("TOPRIGHT", -104, -60)
    f.titleNext:SetText("Next")
    f.titleNext:SetScript("OnClick", function() E.CycleTitle(1) end)

    f.titleClear = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    f.titleClear:SetSize(90, 22)
    f.titleClear:SetPoint("TOPRIGHT", -14, -60)
    f.titleClear:SetText("Clear")
    f.titleClear:SetScript("OnClick", function()
        if E.working then E.working.titleID = nil end
        E.Refresh()
    end)

    ------------------------------------------------------------------ tags
    Divider(f, -92)

    local tagLabel = Text(f, "GameFontNormal")
    tagLabel:SetPoint("TOPLEFT", 14, -102)
    tagLabel:SetText("Playstyle & Focus")
    tagLabel:SetTextColor(COL_LABEL.r, COL_LABEL.g, COL_LABEL.b)

    f.tagCount = Text(f, "GameFontHighlightSmall", "RIGHT")
    f.tagCount:SetPoint("TOPRIGHT", -14, -102)

    f.tagButtons = {}
    for i, tag in ipairs(D.TAGS) do
        local col = (i - 1) % 2
        local rowN = math.floor((i - 1) / 2)

        local cb = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
        cb:SetSize(22, 22)
        cb:SetPoint("TOPLEFT", 14 + col * 258, -124 - rowN * 25)

        local label = Text(f, "GameFontHighlight")
        label:SetPoint("LEFT", cb, "RIGHT", 4, 0)
        label:SetText(tag.label)
        -- "Professions & Crafting" is the longest label; this width fits it
        -- without clipping and without colliding with the second column.
        label:SetWidth(222)

        cb.tagKey = tag.key
        cb.label = label
        cb:SetScript("OnClick", function(self)
            local plate = E.working
            if not plate then return end

            if self:GetChecked() then
                if D.CountTags(plate) >= D.MAX_TAGS then
                    -- Refuse and say why, rather than silently dropping it.
                    self:SetChecked(false)
                    ns.Warn("a plate carries at most %d tags. Unpick one first.", D.MAX_TAGS)
                    return
                end
                plate.tags[self.tagKey] = true
            else
                plate.tags[self.tagKey] = nil
            end
            E.Refresh()
        end)

        f.tagButtons[i] = cb
    end

    -- Derived, not hard-coded: adding a tag to D.TAGS reflows everything below
    -- it rather than silently overlapping the hours grid.
    local tagRows = math.ceil(#D.TAGS / 2)
    local hoursY = -124 - tagRows * 25 - 18

    ----------------------------------------------------------------- hours
    Divider(f, hoursY + 8)

    local hoursLabel = Text(f, "GameFontNormal")
    hoursLabel:SetPoint("TOPLEFT", 14, hoursY)
    hoursLabel:SetText("Active Hours (server time)")
    hoursLabel:SetTextColor(COL_LABEL.r, COL_LABEL.g, COL_LABEL.b)

    local hint = Text(f, "GameFontDisableSmall", "RIGHT")
    hint:SetPoint("TOPRIGHT", -14, hoursY)
    hint:SetText("click or drag to paint")

    local onChange = function() E.Refresh() end

    local wdLabel = Text(f, "GameFontHighlightSmall")
    wdLabel:SetPoint("TOPLEFT", 14, hoursY - 22)
    wdLabel:SetText("Weekday")

    f.weekdayRow = BuildHourRow(f, "weekday", onChange)
    f.weekdayRow:SetPoint("TOPLEFT", 14, hoursY - 38)

    f.weekdayText = Text(f, "GameFontHighlightSmall")
    f.weekdayText:SetPoint("TOPLEFT", 14, hoursY - 60)
    f.weekdayText:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)

    local weLabel = Text(f, "GameFontHighlightSmall")
    weLabel:SetPoint("TOPLEFT", 14, hoursY - 84)
    weLabel:SetText("Weekend")

    f.weekendRow = BuildHourRow(f, "weekend", onChange)
    f.weekendRow:SetPoint("TOPLEFT", 14, hoursY - 100)

    f.weekendText = Text(f, "GameFontHighlightSmall")
    f.weekendText:SetPoint("TOPLEFT", 14, hoursY - 122)
    f.weekendText:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)

    -- quick fills
    local presets = {
        { "Clear",    function(h) for i = 1, 24 do h[i] = false end end },
        { "Evenings", function(h) for i = 1, 24 do h[i] = (i >= 19 and i <= 24) end end },
        { "All day",  function(h) for i = 1, 24 do h[i] = true end end },
    }
    for i, preset in ipairs(presets) do
        local b = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
        b:SetSize(84, 20)
        b:SetPoint("TOPLEFT", 14 + (i - 1) * 90, hoursY - 146)
        b:SetText(preset[1])
        b:SetScript("OnClick", function()
            local plate = E.working
            if not plate then return end
            preset[2](plate.hours.weekday)
            preset[2](plate.hours.weekend)
            E.Refresh()
        end)
    end

    ----------------------------------------------------------------- motto
    local mottoY = hoursY - 182

    Divider(f, mottoY + 8)

    local mottoLabel = Text(f, "GameFontNormal")
    mottoLabel:SetPoint("TOPLEFT", 14, mottoY)
    mottoLabel:SetText("Motto")
    mottoLabel:SetTextColor(COL_LABEL.r, COL_LABEL.g, COL_LABEL.b)

    f.mottoCount = Text(f, "GameFontDisableSmall", "RIGHT")
    f.mottoCount:SetPoint("TOPRIGHT", -14, mottoY)

    local box = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
    box:SetSize(WIDTH - 44, 24)
    box:SetPoint("TOPLEFT", 22, mottoY - 22)
    box:SetAutoFocus(false)
    box:SetMaxLetters(D.MAX_MOTTO)
    box:SetScript("OnTextChanged", function(self)
        if E.working then E.working.motto = self:GetText() or "" end
        E.RefreshMottoCount()
    end)
    box:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
    box:SetScript("OnEnterPressed", function(self) self:ClearFocus() end)
    f.mottoBox = box

    --------------------------------------------------------------- actions
    local save = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    save:SetSize(120, 24)
    save:SetPoint("BOTTOMLEFT", 14, 14)
    save:SetText("Save")
    save:SetScript("OnClick", function() E.Save() end)

    local cancel = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    cancel:SetSize(120, 24)
    cancel:SetPoint("BOTTOMRIGHT", -14, 14)
    cancel:SetText("Cancel")
    cancel:SetScript("OnClick", function() E.Cancel() end)

    f.status = Text(f, "GameFontDisableSmall", "CENTER")
    f.status:SetPoint("BOTTOM", 0, 44)
    f.status:SetWidth(WIDTH - 40)
    f.status:SetWordWrap(true)

    return f
end

--------------------------------------------------------------------------
-- behaviour
--------------------------------------------------------------------------

-- Refresh() runs once per painted cell while dragging across the hour grid, so
-- nothing in it may be expensive. D.KnownTitles() walks all 111 titles with a
-- pcall each -- fine once, ruinous 24 times a second. Resolve it when the
-- editor opens and cache it; titles cannot be earned while this frame is up.
function E.Titles()
    if not E.titleCache then
        E.titleCache = D.KnownTitles() or {}
    end
    return E.titleCache
end

function E.CycleTitle(step)
    local plate = E.working
    if not plate then return end

    local titles = E.Titles()
    if not titles then
        ns.Warn("Titles could not be read.")
        return
    end
    if #titles == 0 then
        ns.Warn("no titles earned on this character yet, so there is none to pick.")
        return
    end

    local index = 0
    for i, t in ipairs(titles) do
        if t.id == plate.titleID then index = i break end
    end

    index = index + step
    if index > #titles then index = 1 elseif index < 1 then index = #titles end

    plate.titleID = titles[index].id
    E.Refresh()
end

function E.RefreshMottoCount()
    local f = E.frame
    if not f or not E.working then return end
    f.mottoCount:SetText(("%d / %d"):format(#(E.working.motto or ""), D.MAX_MOTTO))
end

function E.Refresh()
    local f, plate = E.frame, E.working
    if not f or not plate then return end

    -- Cached for the same reason as E.Titles(): class and colour cannot change
    -- while the editor is open, and this runs once per painted cell.
    if not E.colourCache then
        local class = D.Class()
        E.colourCache = D.ClassColor(class and class.file)
    end
    local colour = E.colourCache

    -- title
    local text = plate.titleID and D.TitleText(plate.titleID) or nil
    if text then
        f.titleValue:SetText(text)
        f.titleValue:SetTextColor(1, 1, 1)
    else
        local titles = E.Titles()
        if titles and #titles == 0 then
            f.titleValue:SetText("No titles earned on this character yet.")
        else
            f.titleValue:SetText("No title set.")
        end
        f.titleValue:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)
    end

    -- tags
    for _, cb in ipairs(f.tagButtons) do
        cb:SetChecked(plate.tags[cb.tagKey] and true or false)
    end
    local used = D.CountTags(plate)
    f.tagCount:SetText(("%d / %d chosen"):format(used, D.MAX_TAGS))
    if used >= D.MAX_TAGS then
        f.tagCount:SetTextColor(1, 0.6, 0.2)
    else
        f.tagCount:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)
    end

    -- hours
    RefreshHourRow(f.weekdayRow, plate.hours.weekday, colour)
    RefreshHourRow(f.weekendRow, plate.hours.weekend, colour)

    local wd, wdWhy = D.HourRanges(plate.hours.weekday)
    f.weekdayText:SetText(wd or wdWhy or "")
    local we, weWhy = D.HourRanges(plate.hours.weekend)
    f.weekendText:SetText(we or weWhy or "")

    E.RefreshMottoCount()
end

function E.Open()
    if not E.frame then E.frame = Build() end

    -- Drop the per-session caches so reopening picks up a title earned, or a
    -- class change, since the editor was last closed.
    E.titleCache  = nil
    E.colourCache = nil

    -- Re-anchor beside the plate every time, so the two windows never open
    -- stacked even if one of them was dragged earlier in the session.
    PositionBeside(E.frame)

    local stored, why = D.Load()
    if not stored then
        E.working = nil
        E.frame.status:SetText(why or "Saved data could not be read, so editing is disabled.")
        E.frame.status:SetTextColor(1, 0.4, 0.4)
        E.frame:Show()
        return
    end

    E.working = CopyPlate(stored)

    -- Set the text without the OnTextChanged handler clobbering the copy.
    E.frame.mottoBox:SetText(E.working.motto or "")
    E.frame.mottoBox:SetCursorPosition(0)

    E.frame.status:SetText("Changes are kept in memory until you press Save, "
        .. "and reach disk on your next /reload or logout.")
    E.frame.status:SetTextColor(COL_DIM.r, COL_DIM.g, COL_DIM.b)

    E.Refresh()
    E.frame:Show()
end

function E.Save()
    if not E.working then
        E.Close()
        return
    end

    local ok, why = D.Save(E.working)
    if not ok then
        ns.Bad(why or "The plate could not be saved.")
        if E.frame then
            E.frame.status:SetText(why or "The plate could not be saved.")
            E.frame.status:SetTextColor(1, 0.4, 0.4)
        end
        return
    end

    ns.Good("plate saved. It reaches disk on your next /reload or logout.")
    E.Close()
    if ns.Plate and ns.Plate.frame and ns.Plate.frame:IsShown() then
        ns.Plate.Refresh()
    end
end

function E.Cancel()
    E.working = nil
    E.Close()
    ns.Print("edit cancelled; nothing was changed.")
end

function E.Close()
    if E.frame then E.frame:Hide() end
end

function E.Toggle()
    if E.frame and E.frame:IsShown() then
        E.Cancel()
    else
        E.Open()
    end
end

--------------------------------------------------------------------------
-- commands
--------------------------------------------------------------------------

ns.RegisterCommand("edit", function() E.Toggle() end, "open the plate editor")
