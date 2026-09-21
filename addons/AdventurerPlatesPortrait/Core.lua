-- Adventurer Plates -- Core
-- Namespace, SavedVariables bootstrap, chat output, slash dispatch.
-- No game API is called at file scope; everything waits for ADDON_LOADED.

local ADDON, ns = ...

ns.addonName = ADDON
ns.version   = C_AddOns.GetAddOnMetadata(ADDON, "Version") or "unknown"

-- SavedVariables format version. Bump this whenever the persisted shape
-- changes, and add a matching entry to MIGRATIONS below -- never trust a
-- stored table whose schema does not match, and never discard one either.
ns.DB_SCHEMA = 2

local LABEL = "|cff8fd3ffAdventurer Plates|r"

local function emit(colour, msg, ...)
    if select("#", ...) > 0 then
        msg = msg:format(...)
    end
    print(("%s: %s%s|r"):format(LABEL, colour, msg))
end

function ns.Print(msg, ...) emit("|cffffffff", msg, ...) end
function ns.Good(msg, ...)  emit("|cff40ff40", msg, ...) end
function ns.Warn(msg, ...)  emit("|cffff9900", msg, ...) end
function ns.Bad(msg, ...)   emit("|cffff4040", msg, ...) end

-- Plain line, no addon label. For multi-line report bodies.
function ns.Line(msg, ...)
    if select("#", ...) > 0 then msg = msg:format(...) end
    print(msg)
end

function ns.Count(t)
    if type(t) ~= "table" then return 0 end
    local n = 0
    for _ in pairs(t) do n = n + 1 end
    return n
end

-- Describe any value compactly enough for a chat line.
function ns.Describe(v)
    local t = type(v)
    if t == "string" then return ("%q"):format(v) end
    if t == "table"  then return ("table(%d)"):format(ns.Count(v)) end
    return tostring(v)
end

--------------------------------------------------------------------------
-- SavedVariables
--------------------------------------------------------------------------

-- Migrations are keyed by the schema they upgrade FROM, and each one returns
-- the schema it produced. Adding a key is how you add a migration.
--
-- Deliberately NOT "wipe on mismatch". The previous version did that, and it
-- would have destroyed the probe results the moment DB_SCHEMA went 1 -> 2 --
-- discarding data we had just spent a live client session collecting. Wiping
-- is only correct when the stored shape genuinely cannot be carried forward,
-- and that has not happened yet.
local MIGRATIONS = {
    -- 1 -> 2: added `plates`. Nothing stored under schema 1 changes shape, so
    -- this is purely additive and `probe` carries over untouched.
    [1] = function(db)
        if type(db.plates) ~= "table" then db.plates = {} end
        return 2
    end,
}

local function InitDB()
    if type(AdventurerPlatesPortraitDB) ~= "table" then
        AdventurerPlatesPortraitDB = {}
    end

    local db = AdventurerPlatesPortraitDB

    -- A fresh table starts at the current schema; there is nothing to migrate.
    if db.schema == nil then
        db.schema = ns.DB_SCHEMA
    end

    -- Walk forward one step at a time so a database two versions behind still
    -- arrives intact. The loop is bounded by the migration table, not by a
    -- guess, so a missing step stops it rather than spinning.
    local guard = 0
    while db.schema ~= ns.DB_SCHEMA do
        local step = MIGRATIONS[db.schema]
        if not step then
            ns.Bad("no migration from schema %s to %s. Leaving stored data ALONE "
                .. "-- nothing has been deleted. Plate features are disabled this session.",
                tostring(db.schema), tostring(ns.DB_SCHEMA))
            ns.db = nil
            return
        end

        local from = db.schema
        local ok, produced = pcall(step, db)
        if not ok then
            ns.Bad("migration from schema %s failed: %s. Stored data left ALONE.",
                tostring(from), tostring(produced))
            ns.db = nil
            return
        end

        db.schema = produced
        ns.Print("migrated saved data from schema %s to %s.",
            tostring(from), tostring(produced))

        guard = guard + 1
        if guard > 16 then
            ns.Bad("migration did not converge; stopping. Stored data left ALONE.")
            ns.db = nil
            return
        end
    end

    -- Type-check every top-level container before anything trusts it. A
    -- corrupted SavedVariables file is a plain Lua file someone may have
    -- hand-edited; it is not guaranteed to match what we wrote.
    if type(db.probe)  ~= "table" then db.probe  = {} end
    if type(db.plates) ~= "table" then db.plates = {} end

    ns.db = db
end

--------------------------------------------------------------------------
-- Slash dispatch
--------------------------------------------------------------------------

-- Subcommands register into this table as { handler = fn, help = "..." }.
ns.commands = {}

function ns.RegisterCommand(name, handler, help)
    ns.commands[name] = { handler = handler, help = help }
end

local function Usage()
    ns.Print("v%s -- commands:", ns.version)
    local names = {}
    for name in pairs(ns.commands) do names[#names + 1] = name end
    table.sort(names)
    for _, name in ipairs(names) do
        ns.Line("  |cffffd100/advportrait %s|r -- %s", name, ns.commands[name].help or "")
    end
end

ns.RegisterCommand("help", Usage, "this list")

local function Dispatch(input)
    input = strtrim(input or "")
    if input == "" then
        Usage()
        return
    end

    local cmd, rest = input:match("^(%S+)%s*(.*)$")
    cmd = cmd and cmd:lower() or ""

    local entry = ns.commands[cmd]
    if not entry then
        ns.Bad("unknown command %q.", cmd)
        Usage()
        return
    end

    entry.handler(strtrim(rest or ""))
end

--------------------------------------------------------------------------
-- Bootstrap
--------------------------------------------------------------------------

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(self, event, loadedAddon)
    if event ~= "ADDON_LOADED" or loadedAddon ~= ADDON then return end
    self:UnregisterEvent("ADDON_LOADED")

    InitDB()

    SLASH_ADVENTURERPLATESPORTRAIT1 = "/advportrait"
    SLASH_ADVENTURERPLATESPORTRAIT2 = "/aportrait"
    SlashCmdList["ADVENTURERPLATESPORTRAIT"] = Dispatch

    ns.Print("v%s loaded. |cffffd100/advportrait|r for commands.", ns.version)
end)
