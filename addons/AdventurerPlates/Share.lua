-- Adventurer Plates -- sharing (v0.3)
--
-- Whisper-pull, not broadcast. You ask a specific person for their plate and
-- they decide whether to answer. Nothing is sent unasked, and there is no
-- hidden channel.
--
-- Transport is Chomp, vendored under libs/. Chomp owns chunking, throttling
-- and reassembly; with fullMsgOnly set, our callback fires once with the whole
-- message however many pieces it travelled in. The measured payload is two
-- chunks, so this is not a heavy user of that machinery -- but the queue is
-- already correct, which is worth more than the bytes.
--
-- Wire format, measured on build 69913:
--   CBOR 386 B -> Deflate 293 B -> Base64 392 B -> 2 chunks
-- Base64 output is plain ASCII, so it passes Chomp's logged-content check and
-- needs no binaryBlob handling.
--
-- PRIVACY IS ENFORCED ON THE RESPONDER. The requester cannot assert who they
-- are; we look them up ourselves. A refusal is a normal reply, not an error.

local ADDON, ns = ...

local S = {}
ns.Share = S

local D = ns.Data

-- Chomp caps prefixes at 16 bytes.
local PREFIX = "ADVPLATE"

-- Bump when the wire shape changes in a way an older client cannot read.
-- Sent with every message so both ends can refuse cleanly rather than
-- misparse.
local PROTOCOL = 1

-- Field separator. The obvious choice -- an ASCII unit separator, \031 -- is
-- WRONG here: Chomp's CheckLoggedContents rejects [%z\001-\009\011-\031\127]
-- as ASCII_CONTROL and errors the send. Verified in its StringManip.lua, not
-- assumed.
--
-- "~" is safe on every count that matters: not in the standard Base64 alphabet
-- (A-Z a-z 0-9 + / =), so it cannot appear inside a payload; not "|", so it is
-- not a WoW text escape; no special meaning in a Lua pattern; and not legal in
-- a character or realm name.
local SEP = "~"

local REQUEST_TIMEOUT = 15   -- seconds before a pending request is abandoned

--------------------------------------------------------------------------
-- privacy
--------------------------------------------------------------------------

S.PRIVACY = {
    { key = "everyone", label = "Everyone" },
    { key = "guild",    label = "Guild & Friends" },
    { key = "friends",  label = "Friends only" },
    { key = "nobody",   label = "Nobody" },
}

S.PRIVACY_BY_KEY = {}
for _, p in ipairs(S.PRIVACY) do S.PRIVACY_BY_KEY[p.key] = p end

local DEFAULT_PRIVACY = "guild"

function S.GetPrivacy()
    local stored = ns.db and ns.db.share and ns.db.share.privacy
    if stored and S.PRIVACY_BY_KEY[stored] then return stored end
    return DEFAULT_PRIVACY
end

function S.SetPrivacy(key)
    if not S.PRIVACY_BY_KEY[key] then
        return false, ("Unknown privacy setting %q."):format(tostring(key))
    end
    if not (ns.db and type(ns.db.share) == "table") then
        return false, "Saved data is not available, so the setting was not stored."
    end
    ns.db.share.privacy = key
    return true
end

-- Name comparison has to survive realm suffixes and Forever's surnames, which
-- contain a space. Chomp.NameMergedRealm normalises to Name-Realm; fall back to
-- a plain compare if Chomp is missing rather than guessing at the format.
local function SameName(a, b)
    if not a or not b then return false end
    if a == b then return true end
    local chomp = _G.AddOn_Chomp
    if chomp and chomp.NameMergedRealm then
        local okA, fullA = pcall(chomp.NameMergedRealm, a)
        local okB, fullB = pcall(chomp.NameMergedRealm, b)
        if okA and okB then return fullA == fullB end
    end
    -- Compare the name part only, as a last resort.
    return (a:match("^([^-]+)") or a) == (b:match("^([^-]+)") or b)
end

local function IsFriend(sender)
    if type(C_FriendList) ~= "table" or type(C_FriendList.GetFriendInfo) ~= "function" then
        return false, "This client has no friend list API, so friend status cannot be checked."
    end
    local bare = sender:match("^([^-]+)") or sender
    local ok, info = pcall(C_FriendList.GetFriendInfo, bare)
    if not ok then return false end
    return info ~= nil
end

local function IsGuildmate(sender)
    -- C_GuildInfo has 39 functions and none returns your own guild name, but
    -- MemberExistsByName answers exactly this question.
    if type(C_GuildInfo) ~= "table" or type(C_GuildInfo.MemberExistsByName) ~= "function" then
        return false, "This client cannot check guild membership."
    end
    local bare = sender:match("^([^-]+)") or sender
    local ok, exists = pcall(C_GuildInfo.MemberExistsByName, bare)
    return ok and exists or false
end

local function IsIgnored(sender)
    if type(C_FriendList) ~= "table" or type(C_FriendList.IsIgnored) ~= "function" then
        return false
    end
    local ok, ignored = pcall(C_FriendList.IsIgnored, sender)
    return ok and ignored or false
end

-- Returns true to answer, or false plus a short machine-readable reason.
function S.MayAnswer(sender)
    if IsIgnored(sender) then
        -- Deliberately distinguishable from a refusal: we do not reply at all.
        return false, "ignored"
    end

    local level = S.GetPrivacy()
    if level == "nobody"   then return false, "private" end
    if level == "everyone" then return true end
    if level == "friends"  then
        if IsFriend(sender) then return true end
        return false, "friends"
    end
    if level == "guild" then
        if IsFriend(sender) or IsGuildmate(sender) then return true end
        return false, "guild"
    end
    return false, "private"
end

local REFUSAL_TEXT = {
    private = "%s is not sharing their plate.",
    friends = "%s only shares their plate with friends.",
    guild   = "%s only shares their plate with guild members and friends.",
    proto   = "%s is running an incompatible version of Adventurer Plates.",
}

--------------------------------------------------------------------------
-- wire payload
--------------------------------------------------------------------------

-- A plate as it travels: the authored fields plus a snapshot of the live facts,
-- because the receiver cannot look up someone else's level or guild.
function S.BuildPayload()
    local plate, why = D.Load()
    if not plate then return nil, why end

    local id    = D.Name()
    local class = D.Class()
    local race  = D.Race()
    local level = D.Level()
    local guild = D.Guild()

    return {
        v         = PROTOCOL,
        name      = id and id.name or nil,
        realm     = id and id.realm or nil,
        level     = level,
        race      = race and race.label or nil,
        raceFile  = race and race.file or nil,
        class     = class and class.label or nil,
        classFile = class and class.file or nil,
        guild     = guild and guild.name or nil,
        rank      = guild and guild.rank or nil,
        titleID   = plate.titleID,
        tags      = plate.tags,
        hours     = plate.hours,
        motto     = plate.motto,
        updated   = plate.updated,
    }
end

-- CBOR -> Deflate -> Base64. Every step is native on this client; there is no
-- LibSerialize or LibDeflate anywhere in this addon.
function S.Encode(payload)
    if type(C_EncodingUtil) ~= "table" then
        return nil, "This client has no C_EncodingUtil, so plates cannot be encoded."
    end

    local ok, result = pcall(function()
        local cbor     = C_EncodingUtil.SerializeCBOR(payload)
        local deflated = C_EncodingUtil.CompressString(cbor,
            Enum.CompressionMethod.Deflate, Enum.CompressionLevel.OptimizeForSize)
        return C_EncodingUtil.EncodeBase64(deflated, Enum.Base64Variant.Standard)
    end)

    if not ok then return nil, "Encoding this plate failed: " .. tostring(result) end
    return result
end

function S.Decode(blob)
    if type(C_EncodingUtil) ~= "table" then
        return nil, "This client has no C_EncodingUtil, so plates cannot be decoded."
    end

    local ok, result = pcall(function()
        local raw      = C_EncodingUtil.DecodeBase64(blob, Enum.Base64Variant.Standard)
        local inflated = C_EncodingUtil.DecompressString(raw, Enum.CompressionMethod.Deflate)
        return C_EncodingUtil.DeserializeCBOR(inflated)
    end)

    if not ok then return nil, "That plate could not be read: " .. tostring(result) end
    if type(result) ~= "table" then return nil, "That plate arrived in a shape we cannot read." end

    -- Never trust the wire. Everything below is what a stranger sent us.
    return S.SanitisePayload(result)
end

local function CleanString(v, max)
    if type(v) ~= "string" then return nil end
    -- Strip control characters, including the chat colour escapes that would
    -- otherwise let a sender recolour or inject into our UI.
    v = v:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|H.-|h", ""):gsub("|T.-|t", "")
    v = v:gsub("%c", " ")
    v = v:sub(1, max or 60)
    if v == "" then return nil end
    return v
end

-- A received plate is untrusted input. Clamp every field to a shape the UI can
-- render, and drop anything unrecognised rather than passing it through.
function S.SanitisePayload(p)
    local out = {
        v         = tonumber(p.v) or 0,
        name      = CleanString(p.name, 48),
        realm     = CleanString(p.realm, 48),
        race      = CleanString(p.race, 40),
        raceFile  = CleanString(p.raceFile, 40),
        class     = CleanString(p.class, 40),
        classFile = CleanString(p.classFile, 40),
        guild     = CleanString(p.guild, 48),
        rank      = CleanString(p.rank, 48),
        motto     = CleanString(p.motto, D.MAX_MOTTO),
        tags      = {},
        hours     = D.EmptyHours(),
    }

    local level = tonumber(p.level)
    if level and level >= 1 and level <= 200 then out.level = math.floor(level) end

    local titleID = tonumber(p.titleID)
    if titleID and titleID > 0 then out.titleID = math.floor(titleID) end

    local updated = tonumber(p.updated)
    if updated and updated >= 0 then out.updated = math.floor(updated) end

    if type(p.tags) == "table" then
        local n = 0
        for key, on in pairs(p.tags) do
            -- Unknown keys are dropped, and the cap is enforced on receipt so a
            -- sender cannot draw twenty badges on our card.
            if on and D.TAG_BY_KEY[key] and n < D.MAX_TAGS then
                out.tags[key] = true
                n = n + 1
            end
        end
    end

    if type(p.hours) == "table" then
        for _, part in ipairs({ "weekday", "weekend" }) do
            local src = p.hours[part]
            if type(src) == "table" then
                for i = 1, 24 do out.hours[part][i] = src[i] and true or false end
            end
        end
    end

    return out
end

--------------------------------------------------------------------------
-- cache
--------------------------------------------------------------------------

local function CacheStore()
    if not (ns.db and type(ns.db.share) == "table") then return nil end
    if type(ns.db.share.cache) ~= "table" then ns.db.share.cache = {} end
    return ns.db.share.cache
end

function S.GetCached(name)
    local cache = CacheStore()
    if not cache then return nil end
    return cache[name]
end

local function Cache(name, payload)
    local cache = CacheStore()
    if not cache then return end
    local okTime, now = pcall(GetServerTime)
    cache[name] = { plate = payload, fetched = (okTime and now) or 0 }
end

--------------------------------------------------------------------------
-- transport
--------------------------------------------------------------------------

local pending = {}

local function Chomp()
    return _G.AddOn_Chomp
end

function S.Available()
    local chomp = Chomp()
    if not chomp then
        return false, "Chomp did not load, so plates cannot be shared this session."
    end
    if type(chomp.SmartAddonMessage) ~= "function" then
        return false, "The bundled Chomp is missing SmartAddonMessage; sharing is disabled."
    end
    return true
end

local function Send(target, text)
    local ok, why = S.Available()
    if not ok then return false, why end

    -- LOW priority: a plate fetch is never urgent, and should never delay
    -- anything a user is actively doing.
    local sent, err = pcall(Chomp().SmartAddonMessage, PREFIX, text, "WHISPER", target,
        { priority = "LOW" })
    if not sent then
        return false, "Sending failed: " .. tostring(err)
    end
    return true
end

--------------------------------------------------------------------------
-- protocol
--------------------------------------------------------------------------

local function HandleRequest(sender, theirVersion)
    if tonumber(theirVersion) ~= PROTOCOL then
        Send(sender, table.concat({ "NO", PROTOCOL, "proto" }, SEP))
        return
    end

    local may, reason = S.MayAnswer(sender)
    if not may then
        -- An ignored sender gets nothing at all. Replying would confirm we are
        -- here and listening, which is the one thing ignoring should prevent.
        if reason == "ignored" then return end
        Send(sender, table.concat({ "NO", PROTOCOL, reason }, SEP))
        return
    end

    local payload, why = S.BuildPayload()
    if not payload then
        ns.Warn("could not build your plate to send: %s", tostring(why))
        return
    end

    local blob, encodeWhy = S.Encode(payload)
    if not blob then
        ns.Warn(tostring(encodeWhy))
        return
    end

    Send(sender, table.concat({ "RES", PROTOCOL, blob }, SEP))
end

local function HandleResponse(sender, theirVersion, blob)
    local req = pending[sender]
    pending[sender] = nil

    if tonumber(theirVersion) ~= PROTOCOL then
        ns.Warn(REFUSAL_TEXT.proto:format(sender))
        return
    end

    local payload, why = S.Decode(blob)
    if not payload then
        ns.Bad(tostring(why))
        return
    end

    Cache(sender, payload)
    ns.Good("received %s's Adventurer Plate.", sender)

    -- Only auto-open if this was an explicit request, never on an unsolicited
    -- message. A stranger must not be able to pop a window on your screen.
    if req and ns.Card and ns.Card.ShowRemote then
        ns.Card.ShowRemote(sender, payload)
    end
end

local function HandleRefusal(sender, theirVersion, reason)
    pending[sender] = nil
    local text = REFUSAL_TEXT[reason] or "%s declined to share their plate."
    ns.Print(text:format(sender))
end

-- Chomp calls this once per complete message: callback(prefix, data, channel, sender, ...)
local function OnMessage(prefix, data, channel, sender)
    if prefix ~= PREFIX or type(data) ~= "string" or not sender then return end

    local kind, version, rest = data:match("^([^" .. SEP .. "]*)" .. SEP
        .. "([^" .. SEP .. "]*)" .. SEP .. "?(.*)$")
    if not kind then return end

    if kind == "REQ" then
        HandleRequest(sender, version)
    elseif kind == "RES" then
        HandleResponse(sender, version, rest)
    elseif kind == "NO" then
        HandleRefusal(sender, version, rest)
    end
    -- Unknown kinds are ignored, so a future version can add one safely.
end

--------------------------------------------------------------------------
-- requesting
--------------------------------------------------------------------------

function S.Request(target)
    if not target or target == "" then
        return false, "Name someone to ask, or target them first."
    end

    local me = D.Name()
    if me and SameName(target, me.name) then
        return false, "That is you. Use /advplate show."
    end

    local ok, why = S.Available()
    if not ok then return false, why end

    local okTime, now = pcall(GetServerTime)
    pending[target] = (okTime and now) or 0

    local sent, sendWhy = Send(target, table.concat({ "REQ", PROTOCOL, "" }, SEP))
    if not sent then
        pending[target] = nil
        return false, sendWhy
    end

    ns.Print("asked %s for their Adventurer Plate...", target)

    -- Self-cancelling timer, not an OnUpdate. If nothing comes back we say so
    -- rather than leaving the user watching an empty screen.
    C_Timer.After(REQUEST_TIMEOUT, function()
        if pending[target] then
            pending[target] = nil
            ns.Warn("no answer from %s. They may be offline, or not running Adventurer Plates.",
                target)
        end
    end)

    return true
end

--------------------------------------------------------------------------
-- registration
--------------------------------------------------------------------------

function S.Init()
    local ok, why = S.Available()
    if not ok then
        ns.Warn(tostring(why))
        return
    end

    local chomp = Chomp()
    if chomp.IsAddonPrefixRegistered and chomp.IsAddonPrefixRegistered(PREFIX) then
        return
    end

    -- fullMsgOnly: Chomp reassembles multi-chunk messages and calls us once
    -- with the whole thing, which is the entire reason for the dependency.
    local registered, err = pcall(chomp.RegisterAddonPrefix, PREFIX, OnMessage, {
        fullMsgOnly = true,
        validTypes  = { ["string"] = true },
    })

    if not registered then
        ns.Bad("could not register the sharing prefix: %s", tostring(err))
    end
end

--------------------------------------------------------------------------
-- commands
--------------------------------------------------------------------------

ns.RegisterCommand("ask", function(arg)
    local target = arg
    if not target or target == "" then
        local ok, name = pcall(UnitName, "target")
        if ok and name then target = name end
    end
    local ok, why = S.Request(target)
    if not ok then ns.Warn(tostring(why)) end
end, "ask someone for their plate: /advplate ask <name>, or target them first")

ns.RegisterCommand("privacy", function(arg)
    arg = (arg or ""):lower()
    if arg == "" then
        ns.Print("sharing with: |cffffd100%s|r", S.PRIVACY_BY_KEY[S.GetPrivacy()].label)
        for _, p in ipairs(S.PRIVACY) do
            ns.Line("  /advplate privacy %-9s -- %s", p.key, p.label)
        end
        return
    end
    local ok, why = S.SetPrivacy(arg)
    if ok then
        ns.Good("now sharing your plate with: %s", S.PRIVACY_BY_KEY[arg].label)
    else
        ns.Warn(tostring(why))
    end
end, "who may see your plate: /advplate privacy [everyone|guild|friends|nobody]")
