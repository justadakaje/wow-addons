-- Adventurer Plates -- Core
-- Namespace, SavedVariables bootstrap, chat output, slash dispatch.
-- No game API is called at file scope; everything waits for ADDON_LOADED.

local ADDON, ns = ...

ns.addonName = ADDON
ns.version   = C_AddOns.GetAddOnMetadata(ADDON, "Version") or "unknown"

-- SavedVariables format version. Bump this whenever the persisted shape
-- changes, and handle the migration explicitly -- never trust a stored table
-- whose schema does not match.
ns.DB_SCHEMA = 1

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

local function InitDB()
    if type(AdventurerPlatesDB) ~= "table" then
        AdventurerPlatesDB = {}
    end

    local db = AdventurerPlatesDB

    if db.schema ~= nil and db.schema ~= ns.DB_SCHEMA then
        ns.Warn("stored data is schema %s, this build expects %s -- starting fresh.",
            tostring(db.schema), tostring(ns.DB_SCHEMA))
        AdventurerPlatesDB = {}
        db = AdventurerPlatesDB
    end

    db.schema = ns.DB_SCHEMA
    if type(db.probe) ~= "table" then db.probe = {} end

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
        ns.Line("  |cffffd100/advplate %s|r -- %s", name, ns.commands[name].help or "")
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

    SLASH_ADVENTURERPLATES1 = "/advplate"
    SLASH_ADVENTURERPLATES2 = "/aplate"
    SlashCmdList["ADVENTURERPLATES"] = Dispatch

    ns.Print("v%s loaded. |cffffd100/advplate|r for commands.", ns.version)
end)
