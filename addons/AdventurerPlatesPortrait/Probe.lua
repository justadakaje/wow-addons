-- Adventurer Plates -- capability probe
--
-- Answers the questions the offline API index cannot: which model widget this
-- client actually gives us, whether the legacy UnitPopup tables exist (the
-- modern Menu.ModifyMenu does NOT on build 69913), how big an encoded plate
-- really is, and what the undocumented globals return.
--
-- Two tiers, deliberately separated:
--   Tier A (/advportrait probe) -- documented API and pure Lua only.
--   Tier B (/advportrait risky) -- calls globals that exist in _G but carry no
--     entry in the documentation this client ships. C_Housing.GetMaxHouseLevel
--     proved a *documented* getter can access-violate, so an undocumented one
--     gets announced before it is called and is resumable from any step.
--
-- Nothing here runs at load, and nothing here runs in the save path.

local ADDON, ns = ...

local P = {}
ns.Probe = P

-- Addon message payloads cap at 255 bytes. 240 leaves room for our own
-- chunk header without a second guess.
local CHUNK_BYTES = 240

--------------------------------------------------------------------------
-- helpers
--------------------------------------------------------------------------

local function rets(...)
    local n = select("#", ...)
    if n == 0 then return "(no return)" end
    local out = {}
    for i = 1, n do out[i] = ns.Describe((select(i, ...))) end
    return table.concat(out, ", ")
end

local function deepEqual(a, b, path)
    path = path or ""
    if type(a) ~= type(b) then
        return false, path .. " (type " .. type(a) .. " vs " .. type(b) .. ")"
    end
    if type(a) ~= "table" then
        if a ~= b then
            return false, path .. " (" .. tostring(a) .. " vs " .. tostring(b) .. ")"
        end
        return true
    end
    for k, v in pairs(a) do
        local ok, why = deepEqual(v, b[k], path .. "." .. tostring(k))
        if not ok then return false, why end
    end
    for k in pairs(b) do
        if a[k] == nil then return false, path .. "." .. tostring(k) .. " (extra)" end
    end
    return true
end

-- A plate shaped like the real thing, for sizing the wire format.
function P.SamplePlate()
    local function hours()
        local h = {}
        for i = 1, 24 do h[i] = i % 3 end
        return h
    end
    return {
        v        = 1,
        name     = "Shapeshifted",
        realm    = "Firemaw",
        level    = 14,
        race     = "NightElf",
        class    = "DRUID",
        sex      = 3,
        titleID  = 148,
        guild    = "Lotion Appreciation Club",
        rank     = "Gold Member",
        rankIdx  = 2,
        motto    = "Exploring the lands of Azeroth!",
        tags     = { "dungeon", "leveling", "worldpvp", "hardcore", "camping", "housing" },
        hours    = { weekday = hours(), weekend = hours() },
        portrait = { zoom = 0.42, rot = 0.3, anim = 0, bg = 3, frame = 2, accent = 1 },
        stamp    = 1758326400,
    }
end

--------------------------------------------------------------------------
-- Tier A sections
--------------------------------------------------------------------------

local MODEL_FRAME_TYPES = {
    "PlayerModel", "DressUpModel", "ModelScene", "CinematicModel", "TabardModel", "Model",
}

-- Two lists, because "absent" means the opposite thing for each of them.
--
-- DOCUMENTED is the complete FrameAPICharacterModelBase surface exactly as the
-- wow-api index reports it for build 69913 -- 24 methods, transcribed from
-- get_widget_methods, not recalled. A frame that reports itself as a character
-- model and is MISSING one of these has diverged from the client's own
-- documentation, which is a finding in its own right.
local MODEL_METHODS_DOCUMENTED = {
    "ApplySpellVisualKit", "CanSetUnit", "FreezeAnimation", "GetDisplayInfo",
    "GetDoBlend", "GetKeepModelOnHide", "HasAnimation", "PlayAnimKit",
    "RefreshCamera", "RefreshUnit", "SetAnimation", "SetBarberShopAlternateForm",
    "SetCamDistanceScale", "SetCreature", "SetDisplayInfo", "SetDoBlend",
    "SetItem", "SetItemAppearance", "SetKeepModelOnHide", "SetPortraitZoom",
    "SetRotation", "SetUnit", "StopAnimKit", "ZeroCachedCenterXY",
}

-- SPECULATIVE is the legacy `Model` camera/placement surface. None of these
-- carry an entry in this client's documentation -- `Model` is not one of the
-- 18 documented FrameAPI widget families -- so these names are candidates
-- drawn from the older Model API, NOT verified signatures. Their PRESENCE is
-- the finding: they are what v0.2 Portraits (pose, camera, lighting) would be
-- built on, and if they are gone that feature needs a different design.
--
-- Probing a name is not calling it. Each is tested with a type() check only.
local MODEL_METHODS_SPECULATIVE = {
    "SetPosition", "SetFacing", "SetModelScale", "SetLight", "SetCustomCamera",
    "SetViewTranslation", "SetPitch", "SetCamera", "SetSequence", "SetModel",
    "ClearModel", "GetFacing", "GetModelScale", "GetPosition", "GetLight",
}

-- Which units can the client actually render? The portrait design assumes a
-- live model only works for a unit that is currently visible, with a
-- class-crest composition as the fallback and the UI saying why. CanSetUnit is
-- documented on FrameAPICharacterModelBase, so this is answerable in Tier A
-- rather than by guessing. The last token is deliberately invalid -- a client
-- that returns true for it is not really answering the question.
local MODEL_UNIT_TOKENS = {
    "player", "target", "mouseover", "party1", "focus", "definitely_not_a_unit",
}

local TEMPLATES = {
    { "Frame",       "BackdropTemplate" },
    { "Button",      "UIPanelButtonTemplate" },
    { "Button",      "UIPanelCloseButton" },
    { "EditBox",     "InputBoxTemplate" },
    { "CheckButton", "UICheckButtonTemplate" },
    { "ScrollFrame", "UIPanelScrollFrameTemplate" },
    { "Slider",      "OptionsSliderTemplate" },
    { "Frame",       "TooltipBorderedFrameTemplate" },
}

local function ProbeClient()
    local version, build, buildDate, toc = GetBuildInfo()
    return {
        version   = version,
        build     = build,
        buildDate = buildDate,
        toc       = toc,
        projectID = WOW_PROJECT_ID,
        mainline  = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE) and true or false,
    }
end

local function ProbeWidgets()
    local out = {}
    for _, frameType in ipairs(MODEL_FRAME_TYPES) do
        local ok, obj = pcall(CreateFrame, frameType, nil, UIParent)
        if ok and obj then
            -- Index through pcall. A widget's __index is normally a plain
            -- table lookup, but this client is not one to take on trust, and
            -- 38 protected reads per frame type costs nothing.
            local function split(list)
                local present, missing = {}, {}
                for _, m in ipairs(list) do
                    local okIdx, member = pcall(function() return obj[m] end)
                    if okIdx and type(member) == "function" then
                        present[#present + 1] = m
                    else
                        missing[#missing + 1] = m
                    end
                end
                return present, missing
            end

            local docPresent, docMissing = split(MODEL_METHODS_DOCUMENTED)
            local specPresent = split(MODEL_METHODS_SPECULATIVE)

            local okType, objectType = pcall(obj.GetObjectType, obj)
            out[frameType] = {
                created     = true,
                objectType  = okType and objectType or "?",
                docPresent  = docPresent,
                docMissing  = docMissing,
                specPresent = specPresent,
            }
            pcall(obj.Hide, obj)
        else
            out[frameType] = { created = false, err = tostring(obj) }
        end
    end
    return out
end

local function ProbeModel()
    local res = {}
    local ok, model = pcall(CreateFrame, "PlayerModel", nil, UIParent)
    if not ok or not model then
        res.available = false
        res.err = tostring(model)
        return res
    end
    res.available = true
    pcall(model.SetSize, model, 200, 260)
    pcall(model.SetPoint, model, "CENTER")
    pcall(model.Hide, model)

    -- Ask before telling: CanSetUnit is the documented way to find out which
    -- units this client will render, and it decides the portrait fallback.
    -- Strictly less invasive than SetUnit, which we call immediately below.
    local okCanIdx, canSetUnit = pcall(function() return model.CanSetUnit end)
    if okCanIdx and type(canSetUnit) == "function" then
        local can = {}
        for _, token in ipairs(MODEL_UNIT_TOKENS) do
            local okCan, result = pcall(model.CanSetUnit, model, token)
            can[token] = okCan and tostring(result) or ("error: " .. tostring(result))
        end
        res.canSetUnit = can
    else
        res.canSetUnitAbsent = true
    end

    local okSet, success = pcall(model.SetUnit, model, "player", false)
    res.setUnit = okSet and tostring(success) or ("error: " .. tostring(success))

    local okDisp, displayID = pcall(model.GetDisplayInfo, model)
    res.displayIDImmediate = okDisp and tostring(displayID) or ("error: " .. tostring(displayID))

    -- Models load asynchronously; the immediate read is usually 0. Re-read
    -- once the client has had a moment, and patch the stored result in place.
    P.keepAliveModel = model
    C_Timer.After(1.0, function()
        local okLater, later = pcall(model.GetDisplayInfo, model)
        local value = okLater and tostring(later) or ("error: " .. tostring(later))
        res.displayIDAfter1s = value
        ns.Print("PlayerModel displayID after 1s: %s (immediate was %s)",
            value, tostring(res.displayIDImmediate))
    end)

    return res
end

local function ProbeTemplates()
    local out = {}
    for _, entry in ipairs(TEMPLATES) do
        local frameType, template = entry[1], entry[2]
        local ok, obj = pcall(CreateFrame, frameType, nil, UIParent, template)
        out[template] = (ok and obj) and true or false
        if ok and obj then pcall(obj.Hide, obj) end
    end
    return out
end

local function ProbeUnitPopup()
    local res = {
        UnitPopupButtons      = type(_G.UnitPopupButtons),
        UnitPopupMenus        = type(_G.UnitPopupMenus),
        UnitPopupShared       = type(_G.UnitPopupShared),
        UnitPopupManager      = type(_G.UnitPopupManager),
        UnitPopup_OnClick     = type(_G.UnitPopup_OnClick),
        UnitPopup_ShowMenu    = type(_G.UnitPopup_ShowMenu),
        UnitPopup_OpenMenu    = type(_G.UnitPopup_OpenMenu),
        UnitPopup_HideButtons = type(_G.UnitPopup_HideButtons),
        Menu                  = type(_G.Menu),
        MenuModifyMenu        = (type(_G.Menu) == "table") and type(_G.Menu.ModifyMenu) or "nil",
    }

    if type(_G.UnitPopupMenus) == "table" then
        local menus = {}
        for key, list in pairs(_G.UnitPopupMenus) do
            menus[tostring(key)] = (type(list) == "table") and #list or type(list)
        end
        res.menus = menus
        res.menuCount = ns.Count(menus)
    end

    if type(_G.UnitPopupButtons) == "table" then
        res.buttonCount = ns.Count(_G.UnitPopupButtons)
        res.hasWhisper  = (_G.UnitPopupButtons["WHISPER"] ~= nil) and true or false
        res.hasInspect  = (_G.UnitPopupButtons["INSPECT"] ~= nil) and true or false
    end

    return res
end

local function ProbeEncoding()
    local res = {}
    local plate = P.SamplePlate()

    local function step(key, fn, ...)
        local ok, out = pcall(fn, ...)
        if not ok then
            res[key] = { ok = false, err = tostring(out) }
            return nil
        end
        res[key] = { ok = true, bytes = (type(out) == "string") and #out or nil }
        return out
    end

    local cbor = step("cbor", C_EncodingUtil.SerializeCBOR, plate)
    step("json", C_EncodingUtil.SerializeJSON, plate)
    if not cbor then return res end

    local deflated = step("deflate", C_EncodingUtil.CompressString, cbor,
        Enum.CompressionMethod.Deflate, Enum.CompressionLevel.OptimizeForSize)
    if not deflated then return res end

    local b64 = step("base64", C_EncodingUtil.EncodeBase64, deflated, Enum.Base64Variant.Standard)
    if not b64 then return res end

    res.chunkBytes = CHUNK_BYTES
    res.chunks = math.ceil(#b64 / CHUNK_BYTES)

    local ok, back = pcall(function()
        local raw      = C_EncodingUtil.DecodeBase64(b64, Enum.Base64Variant.Standard)
        local inflated = C_EncodingUtil.DecompressString(raw, Enum.CompressionMethod.Deflate)
        return C_EncodingUtil.DeserializeCBOR(inflated)
    end)

    if not ok then
        res.roundTrip = { ok = false, err = tostring(back) }
    else
        local same, why = deepEqual(plate, back)
        res.roundTrip = { ok = same, mismatch = (not same) and why or nil }
    end

    return res
end

local function ProbeTitles()
    local res = {}
    local okNum, num = pcall(GetNumTitles)
    if not okNum then
        res.err = tostring(num)
        return res
    end
    res.numTitles = num

    local okCur, current = pcall(GetCurrentTitle)
    res.currentTitleID = okCur and current or ("error: " .. tostring(current))

    local known, sample = 0, {}
    for i = 1, (tonumber(num) or 0) do
        local okKnown, isKnown = pcall(IsTitleKnown, i)
        if okKnown and isKnown then
            known = known + 1
            if #sample < 6 then
                local okName, titleString = pcall(GetTitleName, i)
                sample[#sample + 1] = ("%d=%s"):format(i, okName and tostring(titleString) or "?")
            end
        end
    end
    res.knownTitles = known
    res.sample = sample
    return res
end

local function ProbeComms()
    local res = {}
    local okReg, result = pcall(C_ChatInfo.RegisterAddonMessagePrefix, "ADVPLATE")
    res.registerResult = okReg and tostring(result) or ("error: " .. tostring(result))

    local okIs, isRegistered = pcall(C_ChatInfo.IsAddonMessagePrefixRegistered, "ADVPLATE")
    res.registered = okIs and tostring(isRegistered) or ("error: " .. tostring(isRegistered))

    local okList, list = pcall(C_ChatInfo.GetRegisteredAddonMessagePrefixes)
    res.totalPrefixes = (okList and type(list) == "table") and #list or "?"
    return res
end

local function ProbeCharacter()
    local res = {}
    -- Collect through varargs rather than a table: a nil in the middle of a
    -- return tuple (UnitFullName with no realm, say) would put a hole in the
    -- table and truncate unpack.
    local function collect(ok, ...)
        if not ok then return "error: " .. tostring((...)) end
        return rets(...)
    end

    local function try(key, fn, ...)
        res[key] = collect(pcall(fn, ...))
    end
    -- Every name below resolves in the wow-api index for build 69913, which is
    -- what makes this Tier A. Re-check before adding to this list.
    try("UnitName",               UnitName, "player")
    try("UnitFullName",           UnitFullName, "player")
    try("UnitRace",               UnitRace, "player")
    try("UnitClass",              UnitClass, "player")
    try("UnitLevel",              UnitLevel, "player")
    try("UnitSex",                UnitSex, "player")
    try("GetNormalizedRealmName", GetNormalizedRealmName)
    try("GetServerTime",          GetServerTime)
    try("GetGameTime",            GetGameTime)

    -- GetAverageItemLevel is NOT in the index for this client. It used to be
    -- called here, which quietly broke Tier A's "documented API only" promise:
    -- pcall would have caught a Lua error, but pcall does not stop a native
    -- crash, and that is the whole reason Tier B exists.
    --
    -- Item level is not a v0.1 plate field anyway, so report whether the
    -- symbol exists and leave calling it to a deliberate Tier B decision.
    -- Reading a global is not calling one.
    res.GetAverageItemLevel = ("%s (undocumented on this client -- not called)")
        :format(type(_G.GetAverageItemLevel))

    return res
end

--------------------------------------------------------------------------
-- Tier A runner + report
--------------------------------------------------------------------------

function P.ReportSafe(t)
    if type(t) ~= "table" then
        ns.Warn("no Tier A probe stored yet -- run |cffffd100/advportrait probe|r.")
        return
    end

    ns.Print("Tier A probe from %s (addon v%s)", tostring(t.at), tostring(t.addonVersion))

    local c = t.client or {}
    ns.Line("  client: %s build %s, toc %s, mainline=%s",
        tostring(c.version), tostring(c.build), tostring(c.toc), tostring(c.mainline))

    ns.Line("  |cffffd100model widgets|r")
    for _, frameType in ipairs(MODEL_FRAME_TYPES) do
        local w = (t.widgets or {})[frameType]
        if not w then
            ns.Line("    %-15s untested", frameType)
        elseif not w.created then
            ns.Line("    %-15s |cffff4040no|r -- %s", frameType, tostring(w.err))
        else
            local docPresent = #(w.docPresent or {})
            local docTotal = docPresent + #(w.docMissing or {})
            ns.Line("    %-15s |cff40ff40yes|r (%s) documented %d/%d, legacy %d/%d",
                frameType, tostring(w.objectType), docPresent, docTotal,
                #(w.specPresent or {}), #MODEL_METHODS_SPECULATIVE)
            -- A documented method that is absent is a divergence; say so loudly.
            if w.docMissing and #w.docMissing > 0 then
                ns.Line("        |cffff4040documented but absent|r: %s",
                    table.concat(w.docMissing, ", "))
            end
            -- An undocumented method that is present is free capability.
            if w.specPresent and #w.specPresent > 0 then
                ns.Line("        |cff40ff40undocumented but present|r: %s",
                    table.concat(w.specPresent, ", "))
            end
        end
    end

    local m = t.model or {}
    ns.Line("  |cffffd100PlayerModel|r available=%s SetUnit=%s displayID=%s",
        tostring(m.available), tostring(m.setUnit), tostring(m.displayIDImmediate))

    if m.canSetUnitAbsent then
        ns.Line("    |cffff4040CanSetUnit absent|r -- portrait eligibility cannot be asked, only tried")
    elseif m.canSetUnit then
        local parts = {}
        for _, token in ipairs(MODEL_UNIT_TOKENS) do
            parts[#parts + 1] = ("%s=%s"):format(token, tostring(m.canSetUnit[token]))
        end
        ns.Line("    CanSetUnit: %s", table.concat(parts, " "))
    end

    local okTpl, badTpl = {}, {}
    for name, present in pairs(t.templates or {}) do
        if present then okTpl[#okTpl + 1] = name else badTpl[#badTpl + 1] = name end
    end
    table.sort(okTpl)
    table.sort(badTpl)
    ns.Line("  |cffffd100templates|r ok: %s", (#okTpl > 0) and table.concat(okTpl, ", ") or "none")
    if #badTpl > 0 then
        ns.Line("    |cffff4040absent|r: %s", table.concat(badTpl, ", "))
    end

    local up = t.unitPopup or {}
    ns.Line("  |cffffd100right-click menu|r UnitPopupButtons=%s UnitPopupMenus=%s Menu.ModifyMenu=%s",
        tostring(up.UnitPopupButtons), tostring(up.UnitPopupMenus), tostring(up.MenuModifyMenu))
    if up.menuCount then
        ns.Line("    %d menus, %s buttons, WHISPER=%s INSPECT=%s",
            up.menuCount, tostring(up.buttonCount), tostring(up.hasWhisper), tostring(up.hasInspect))
    end

    local e = t.encoding or {}
    local function bytes(key)
        local s = e[key]
        if not s then return "?" end
        if not s.ok then return "ERR " .. tostring(s.err) end
        return tostring(s.bytes)
    end
    ns.Line("  |cffffd100wire format|r cbor=%sB json=%sB deflate=%sB base64=%sB -> %s chunk(s) of %s",
        bytes("cbor"), bytes("json"), bytes("deflate"), bytes("base64"),
        tostring(e.chunks), tostring(e.chunkBytes))
    local rt = e.roundTrip
    if rt then
        if rt.ok then
            ns.Line("    round trip: |cff40ff40lossless|r")
        else
            ns.Line("    round trip: |cffff4040FAILED|r %s", tostring(rt.mismatch or rt.err))
        end
    end

    local ti = t.titles or {}
    ns.Line("  |cffffd100titles|r %s total, %s known, current=%s",
        tostring(ti.numTitles), tostring(ti.knownTitles), tostring(ti.currentTitleID))
    if ti.sample and #ti.sample > 0 then
        ns.Line("    known: %s", table.concat(ti.sample, " | "))
    end

    local cm = t.comms or {}
    ns.Line("  |cffffd100comms|r prefix register=%s registered=%s (%s prefixes live)",
        tostring(cm.registerResult), tostring(cm.registered), tostring(cm.totalPrefixes))

    ns.Line("  |cffffd100character|r")
    local keys = {}
    for k in pairs(t.character or {}) do keys[#keys + 1] = k end
    table.sort(keys)
    for _, k in ipairs(keys) do
        ns.Line("    %-22s %s", k, tostring(t.character[k]))
    end

    ns.Warn("results reach disk only on /reload or logout.")
end

function P.RunSafe()
    if not (ns.db and type(ns.db.probe) == "table") then
        ns.Bad("SavedVariables not ready -- try again after a /reload.")
        return
    end

    local t = {
        at           = date("%Y-%m-%d %H:%M:%S"),
        addonVersion = ns.version,
        client       = ProbeClient(),
        widgets      = ProbeWidgets(),
        templates    = ProbeTemplates(),
        unitPopup    = ProbeUnitPopup(),
        encoding     = ProbeEncoding(),
        titles       = ProbeTitles(),
        comms        = ProbeComms(),
        character    = ProbeCharacter(),
    }
    t.model = ProbeModel()

    ns.db.probe.safe = t
    P.ReportSafe(t)
end

--------------------------------------------------------------------------
-- Tier B -- undocumented globals
--------------------------------------------------------------------------

-- Each step writes into `store` and returns an array of display lines.
-- Ordered least-surprising first, so a crash late in the list still leaves
-- the earlier answers on screen.
local RISKY_STEPS = {
    {
        label = "GetGuildInfo(player)",
        run = function(store)
            local name, rankName, rankIndex, realm = GetGuildInfo("player")
            store.GetGuildInfo = rets(name, rankName, rankIndex, realm)
            return { "  -> " .. store.GetGuildInfo }
        end,
    },
    {
        label = "GetProfessions()",
        run = function(store)
            local prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions()
            store.GetProfessions = rets(prof1, prof2, archaeology, fishing, cooking, firstAid)

            local slots = { prof1, prof2, archaeology, fishing, cooking, firstAid }
            local indices = {}
            for i = 1, 6 do
                if type(slots[i]) == "number" then indices[#indices + 1] = slots[i] end
            end
            store.professionIndices = indices
            return {
                "  -> " .. store.GetProfessions,
                ("  -> %d usable slot index(es)"):format(#indices),
            }
        end,
    },
    {
        label = "GetProfessionInfo(index) for each slot",
        run = function(store)
            local indices = store.professionIndices
            if type(indices) ~= "table" or #indices == 0 then
                store.GetProfessionInfo = "skipped -- GetProfessions() returned no slot indices"
                return { "  -> skipped, no slot indices" }
            end
            local lines, saved = {}, {}
            for _, i in ipairs(indices) do
                ns.Print("    calling GetProfessionInfo(%d) ...", i)
                local a, b, c, d, e, f, g, h = GetProfessionInfo(i)
                local line = ("[%d] %s"):format(i, rets(a, b, c, d, e, f, g, h))
                saved[#saved + 1] = line
                lines[#lines + 1] = "  -> " .. line
            end
            store.GetProfessionInfo = saved
            return lines
        end,
    },
    {
        label = "GetAchievementInfo(6) -- achievements may not be a real system here",
        run = function(store)
            local a, b, c, d, e, f, g, h = GetAchievementInfo(6)
            store.GetAchievementInfo = rets(a, b, c, d, e, f, g, h)
            return { "  -> " .. store.GetAchievementInfo }
        end,
    },
}

function P.RunRisky(arg)
    if not (ns.db and type(ns.db.probe) == "table") then
        ns.Bad("SavedVariables not ready -- try again after a /reload.")
        return
    end

    local first = tonumber(arg) or 1
    if first < 1 or first > #RISKY_STEPS then
        ns.Bad("step must be between 1 and %d.", #RISKY_STEPS)
        return
    end

    if type(ns.db.probe.risky) ~= "table" then ns.db.probe.risky = {} end
    local store = ns.db.probe.risky
    store.at = date("%Y-%m-%d %H:%M:%S")

    ns.Warn("Tier B calls UNDOCUMENTED globals. pcall does not stop a native crash.")
    ns.Warn("Every step prints before it runs -- if the client dies, the last line")
    ns.Warn("on screen names the call that did it. Resume with /advportrait risky <n>.")

    for i = first, #RISKY_STEPS do
        local step = RISKY_STEPS[i]
        ns.Print("step %d/%d -> %s", i, #RISKY_STEPS, step.label)
        local ok, result = pcall(step.run, store)
        if ok then
            for _, line in ipairs(result or {}) do ns.Line(line) end
            ns.Good("step %d/%d survived.", i, #RISKY_STEPS)
        else
            store["step" .. i .. "Error"] = tostring(result)
            ns.Bad("step %d/%d raised a Lua error: %s", i, #RISKY_STEPS, tostring(result))
        end
    end

    ns.Good("Tier B done. |cffffd100/reload|r to flush results to SavedVariables.")
end

--------------------------------------------------------------------------
-- commands
--------------------------------------------------------------------------

ns.RegisterCommand("probe", function() P.RunSafe() end,
    "Tier A: documented API only, safe to run")

ns.RegisterCommand("report", function()
    P.ReportSafe(ns.db and ns.db.probe and ns.db.probe.safe)
end, "reprint the last Tier A result")

ns.RegisterCommand("risky", function(arg) P.RunRisky(arg) end,
    "Tier B: undocumented globals, can crash the client; /advportrait risky <n> resumes")
