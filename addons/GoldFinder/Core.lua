-- GoldFinder -- Core
-- Namespace and chat output. No game API is called at file scope beyond
-- reading this addon's own metadata.

local ADDON, ns = ...

ns.addonName = ADDON
ns.version   = C_AddOns.GetAddOnMetadata(ADDON, "Version") or "unknown"

local LABEL = "|cffffd100GoldFinder|r"

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

-- SavedVariables format version. Bump when the persisted shape changes and
-- migrate; never discard a stored table.
ns.DB_SCHEMA = 2

-- Each migration takes the db from schema n-1 to n. Plain table work only.
local MIGRATIONS = {
    -- 1 -> 2: before v0.0.4 the client's re-delivered browse lists were
    -- recorded as new scans (see Scan.lua, Finish). A re-record is identical
    -- to the point before it -- same lowest price, same quantity -- with a
    -- later timestamp. Collapse each such run to its EARLIEST point, which
    -- carries the true observation time. Conservative: a genuinely unchanged
    -- market loses a point and is judged one scan later; nothing becomes
    -- falsely fresh.
    [2] = function(db)
        local removed = 0
        for _, rec in pairs(db.items) do
            local h, kept = rec.history, {}
            if type(h) == "table" then
                for _, p in ipairs(h) do
                    local last = kept[#kept]
                    if last and last.min == p.min and last.qty == p.qty then
                        removed = removed + 1
                    else
                        kept[#kept + 1] = p
                    end
                end
                rec.history = kept
            end
        end
        return removed
    end,
}

-- Nothing here can crash: plain table checks only. The save path stays that way.
local boot = CreateFrame("Frame")
boot:RegisterEvent("ADDON_LOADED")
boot:SetScript("OnEvent", function(self, _, name)
    if name ~= ADDON then return end
    self:UnregisterEvent("ADDON_LOADED")

    if type(GoldFinderDB) ~= "table" then GoldFinderDB = {} end
    local db = GoldFinderDB
    db.schema = db.schema or ns.DB_SCHEMA
    if type(db.scans) ~= "table" then db.scans = {} end  -- one summary per full scan
    if type(db.items) ~= "table" then db.items = {} end  -- [itemID] = { name, history }

    while db.schema < ns.DB_SCHEMA do
        local to = db.schema + 1
        local removed = MIGRATIONS[to](db)
        db.schema = to
        if removed and removed > 0 then
            ns.Print("Cleaned saved data (schema %d to %d): removed %d repeated price point(s) recorded from re-delivered results.", to - 1, to, removed)
        end
    end
    ns.db = db
end)
