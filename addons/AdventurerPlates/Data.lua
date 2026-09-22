-- Adventurer Plates -- plate data model
--
-- Two kinds of field, kept strictly apart:
--
--   LIVE    read from the client every time the plate renders (name, level,
--           guild, class). Never persisted, because a stored copy goes stale
--           the moment you level or join a guild, and a stale plate is worse
--           than no plate.
--   STORED  authored by the player (tags, hours, motto, chosen title). These
--           are the only things that reach SavedVariables.
--
-- Every live getter returns `value, nil` on success or `nil, reason` on
-- failure, where `reason` is a sentence fit to show a human. Per the repo rule,
-- missing data becomes an explanation, never a guess and never a silent zero.

local ADDON, ns = ...

local D = {}
ns.Data = D

--------------------------------------------------------------------------
-- Static vocabulary
--------------------------------------------------------------------------

-- Order is display order. `key` is what reaches SavedVariables and, later,
-- the wire -- so keys are short and must never be renamed without a migration.
--
-- `abbr` and `rgb` exist for the card layout's badge row. FFXIV uses real icon
-- art here; we do not, deliberately. Icon art means a texture path, and there
-- is no verified source of playstyle-category art on this client -- guessing an
-- "Interface\\ICONS\\..." string from memory is exactly the mistake that
-- produced the Menu.ModifyMenu error. A coloured badge carrying two letters is
-- honest, needs no path, and reads at a glance. Swapping in real art later is a
-- texture call, not a re-layout.
D.TAGS = {
    { key = "dungeon",  label = "Dungeon Delver",        abbr = "DD", rgb = { 0.45, 0.62, 0.95 } },
    { key = "raid",     label = "Raider",                abbr = "RD", rgb = { 0.72, 0.42, 0.95 } },
    { key = "worldpvp", label = "World PvP",             abbr = "WP", rgb = { 0.90, 0.30, 0.30 } },
    { key = "bg",       label = "Battlegrounds",         abbr = "BG", rgb = { 0.95, 0.48, 0.28 } },
    { key = "leveling", label = "Casual Leveling",       abbr = "CL", rgb = { 0.40, 0.80, 0.55 } },
    { key = "hardcore", label = "Hardcore / Survival",   abbr = "HC", rgb = { 0.80, 0.18, 0.22 } },
    { key = "rp",       label = "Roleplay",              abbr = "RP", rgb = { 0.85, 0.62, 0.90 } },
    { key = "prof",     label = "Professions & Crafting",abbr = "PR", rgb = { 0.85, 0.70, 0.35 } },
    { key = "gold",     label = "Gold Making",           abbr = "GM", rgb = { 0.95, 0.82, 0.25 } },
    { key = "collect",  label = "Collector",             abbr = "CO", rgb = { 0.40, 0.75, 0.82 } },
    { key = "mentor",   label = "Mentor",                abbr = "MT", rgb = { 0.55, 0.85, 0.40 } },
    { key = "explore",  label = "Explorer",              abbr = "EX", rgb = { 0.50, 0.70, 0.90 } },
    -- Forever-specific. Camping introduces no new API (it fires
    -- PLAYER_UPDATE_RESTING, not housing events) so it is self-declared;
    -- Housing is a real 13-namespace system a later version could read.
    { key = "camping",  label = "Camping",               abbr = "CP", rgb = { 0.62, 0.52, 0.36 } },
    { key = "housing",  label = "Housing",               abbr = "HO", rgb = { 0.72, 0.60, 0.48 } },
}

D.TAG_BY_KEY = {}
for _, t in ipairs(D.TAGS) do D.TAG_BY_KEY[t.key] = t end

D.MAX_MOTTO = 140
D.MAX_TAGS  = 6

--------------------------------------------------------------------------
-- Live identity
--------------------------------------------------------------------------

-- UnitFullName is the only one of the name getters that reliably carries the
-- realm: on build 69913 UnitName("player") returned the name with a nil realm,
-- while UnitFullName returned both. Observed, not assumed.
--
-- Names on this client contain a space -- Forever has a surname system, and
-- the test character is "Aeldorath Zephrai". Nothing here may split on
-- whitespace.
function D.Name()
    local ok, name, realm = pcall(UnitFullName, "player")
    if not ok or not name then
        return nil, "The client did not return a character name."
    end

    if not realm or realm == "" then
        local okRealm, normalised = pcall(GetNormalizedRealmName)
        realm = (okRealm and normalised) or nil
    end

    return { name = name, realm = realm }
end

-- A stable key for the stored plate. Realm is included when we have it so two
-- same-named characters on different realms do not collide; when we do not, the
-- bare name is still better than refusing to save.
function D.PlateKey()
    local id = D.Name()
    if not id then return nil, "No character name, so there is nothing to key a plate by." end
    if id.realm then return id.name .. "-" .. id.realm end
    return id.name
end

function D.Class()
    local ok, localised, fileName, classID = pcall(UnitClass, "player")
    if not ok or not fileName then
        return nil, "The client did not return a class."
    end
    return { label = localised, file = fileName, id = classID }
end

function D.Race()
    local ok, localised, fileName, raceID = pcall(UnitRace, "player")
    if not ok or not localised then
        return nil, "The client did not return a race."
    end
    return { label = localised, file = fileName, id = raceID }
end

function D.Level()
    local ok, level = pcall(UnitLevel, "player")
    if not ok or type(level) ~= "number" or level <= 0 then
        return nil, "The client did not return a level."
    end
    return level
end

-- C_ClassColor.GetClassColor takes the FILE name ("HUNTER"), not the localised
-- one. Falls back to plain white rather than inventing a colour.
function D.ClassColor(classFile)
    local white = { r = 1, g = 1, b = 1 }
    if not classFile then return white end
    if type(C_ClassColor) ~= "table" or type(C_ClassColor.GetClassColor) ~= "function" then
        return white
    end
    local ok, colour = pcall(C_ClassColor.GetClassColor, classFile)
    if not ok or type(colour) ~= "table" or type(colour.r) ~= "number" then
        return white
    end
    return colour
end

--------------------------------------------------------------------------
-- Guild
--------------------------------------------------------------------------

-- GetGuildInfo is UNDOCUMENTED on this client, and it is used anyway because
-- there is no alternative: C_GuildInfo has 39 functions and not one of them
-- returns your own guild name or rank name.
--
-- Tier B of the capability probe called it on build 69913 and observed
-- (name, rankName, rankIndex, realm) returned cleanly, with all-nil for a
-- guildless character. That is an observation, not a guarantee -- pcall catches
-- a Lua error but not a native crash -- so it is guarded and its absence is a
-- sentence rather than a failure.
function D.Guild()
    if type(_G.GetGuildInfo) ~= "function" then
        return nil, "This client has no GetGuildInfo, so guild rank cannot be read."
    end

    local ok, name, rankName, rankIndex = pcall(GetGuildInfo, "player")
    if not ok then
        return nil, "Reading guild information failed: " .. tostring(name)
    end
    if not name or name == "" then
        return nil, "Not in a guild."
    end

    return {
        name      = name,
        rank      = (rankName ~= "" and rankName) or nil,
        rankIndex = tonumber(rankIndex),
    }
end

--------------------------------------------------------------------------
-- Titles
--------------------------------------------------------------------------

-- GetTitleName returns a fragment with the name's position implied, e.g.
-- " the Explorer" or "Private %s". Trim it for display; do not try to splice
-- the character name in, because the two forms need different handling and
-- getting it wrong prints a mangled name.
local function TitleText(titleID)
    if type(titleID) ~= "number" or titleID <= 0 then return nil end
    local ok, text = pcall(GetTitleName, titleID)
    if not ok or type(text) ~= "string" or text == "" then return nil end
    return (text:gsub("%%s", ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

D.TitleText = TitleText

-- Every title the character has actually earned, as { id = , text = }.
-- On the test character this was EMPTY (111 titles exist, 0 known), so the
-- empty case is the default path, not an edge case.
function D.KnownTitles()
    local okNum, count = pcall(GetNumTitles)
    if not okNum or type(count) ~= "number" then
        return nil, "This client did not report how many titles exist."
    end

    local out = {}
    for i = 1, count do
        local okKnown, known = pcall(IsTitleKnown, i)
        if okKnown and known then
            local text = TitleText(i)
            if text then out[#out + 1] = { id = i, text = text } end
        end
    end

    table.sort(out, function(a, b) return a.text < b.text end)
    return out
end

-- The title the client currently has equipped, which is what the plate shows
-- unless the player picked a different one. -1 means none; observed on the
-- test character.
function D.CurrentTitleID()
    local ok, id = pcall(GetCurrentTitle)
    if not ok or type(id) ~= "number" or id <= 0 then return nil end
    return id
end

--------------------------------------------------------------------------
-- Stored plate
--------------------------------------------------------------------------

local function EmptyHours()
    local t = { weekday = {}, weekend = {} }
    for i = 1, 24 do
        t.weekday[i] = false
        t.weekend[i] = false
    end
    return t
end

D.EmptyHours = EmptyHours

function D.NewPlate()
    return {
        titleID = nil,
        tags    = {},
        hours   = EmptyHours(),
        motto   = "",
        updated = 0,
    }
end

-- Coerce whatever is stored into a shape the UI can rely on. SavedVariables is
-- a plain Lua file that a person can hand-edit, so nothing read from it is
-- trusted without a type check.
function D.Sanitise(plate)
    if type(plate) ~= "table" then return D.NewPlate() end

    local clean = D.NewPlate()

    if type(plate.titleID) == "number" and plate.titleID > 0 then
        clean.titleID = plate.titleID
    end

    if type(plate.tags) == "table" then
        for key, on in pairs(plate.tags) do
            -- Drop unknown keys rather than carrying them forward: they are
            -- either corruption or a tag from a future version we cannot render.
            if on and D.TAG_BY_KEY[key] then clean.tags[key] = true end
        end
    end

    if type(plate.hours) == "table" then
        for _, part in ipairs({ "weekday", "weekend" }) do
            local src = plate.hours[part]
            if type(src) == "table" then
                for i = 1, 24 do clean.hours[part][i] = src[i] and true or false end
            end
        end
    end

    if type(plate.motto) == "string" then
        clean.motto = plate.motto:sub(1, D.MAX_MOTTO)
    end

    if type(plate.updated) == "number" then clean.updated = plate.updated end

    return clean
end

-- Load the stored plate for this character, creating one if absent.
function D.Load()
    if not (ns.db and type(ns.db.plates) == "table") then
        return nil, "Saved data is not available this session, so no plate could be loaded."
    end

    local key, why = D.PlateKey()
    if not key then return nil, why end

    local stored = ns.db.plates[key]
    local plate = D.Sanitise(stored)
    ns.db.plates[key] = plate
    return plate
end

function D.Save(plate)
    if not (ns.db and type(ns.db.plates) == "table") then
        return false, "Saved data is not available this session, so nothing was written."
    end

    local key, why = D.PlateKey()
    if not key then return false, why end

    local clean = D.Sanitise(plate)
    local okTime, now = pcall(GetServerTime)
    clean.updated = (okTime and now) or 0

    ns.db.plates[key] = clean
    return true
end

function D.CountTags(plate)
    local n = 0
    for _ in pairs((plate and plate.tags) or {}) do n = n + 1 end
    return n
end

-- Render an hours row as compact ranges ("18-23") rather than 24 digits.
-- Returns nil plus a sentence when nothing is selected, so the caller can say
-- so instead of drawing an empty bar with no explanation.
function D.HourRanges(row)
    if type(row) ~= "table" then return nil, "No hours recorded." end

    local ranges, start = {}, nil
    for i = 1, 25 do
        local on = (i <= 24) and row[i] or false
        if on and not start then
            start = i
        elseif not on and start then
            local last = i - 1
            ranges[#ranges + 1] = (start == last)
                and ("%02d"):format(start - 1)
                or ("%02d-%02d"):format(start - 1, last - 1)
            start = nil
        end
    end

    if #ranges == 0 then return nil, "No hours set." end
    return table.concat(ranges, ", ")
end
