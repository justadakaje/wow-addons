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
