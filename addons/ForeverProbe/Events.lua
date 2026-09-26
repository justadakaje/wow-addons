-- ForeverProbe / Events -- passive event recorder for undocumented systems.
--
-- The API snapshot in ForeverProbe.lua answers "what exists". This answers
-- "what actually fires, in what order, carrying what" -- which is the only way
-- to map a system like Housing (the "Campsite" feature) on a client with no
-- documentation.
--
-- Strategy: RegisterAllEvents, then spend the budget where it pays.
--   * counts    -- every event, name + tally. Cheap, complete, no payloads.
--   * firstSeen -- the FIRST firing of every distinct event, with full payload.
--                  Bounded by the number of distinct events, so it cannot run
--                  away, and it is exactly what you want when mapping unknowns.
--   * log       -- full payload for every firing of an interesting event, capped.
--
-- Its own SavedVariable, deliberately: ForeverProbe.lua assigns ForeverProbeDB
-- wholesale on each capture, which would wipe an event log stored inside it.

local SCHEMA_VERSION = 1
local MAX_DETAIL = 3000

-- Fire continuously during ordinary play and would bury everything else.
-- They still get counted, just never payload-logged.
local NOISE = {
  COMBAT_LOG_EVENT_UNFILTERED = true, UPDATE_MOUSEOVER_UNIT = true,
  CURSOR_CHANGED = true, SPELL_UPDATE_COOLDOWN = true, SPELL_UPDATE_USABLE = true,
  ACTIONBAR_UPDATE_COOLDOWN = true, ACTIONBAR_UPDATE_USABLE = true,
  ACTIONBAR_UPDATE_STATE = true, UNIT_POWER_UPDATE = true, UNIT_POWER_FREQUENT = true,
  UNIT_HEALTH = true, UNIT_AURA = true, UNIT_THREAT_SITUATION_UPDATE = true,
  UNIT_THREAT_LIST_UPDATE = true, PLAYER_STARTED_MOVING = true,
  PLAYER_STOPPED_MOVING = true, BAG_UPDATE_DELAYED = true, BAG_UPDATE = true,
  UPDATE_UI_WIDGET = true, GUILD_ROSTER_UPDATE = true, UPDATE_WORLD_STATES = true,
  QUEST_LOG_UPDATE = true, UPDATE_INVENTORY_DURABILITY = true,
  PLAYER_TARGET_CHANGED = true, UI_ERROR_MESSAGE = true, UI_INFO_MESSAGE = true,
}

-- Substrings that mark an event as worth full payload capture every time.
-- Housing is the reason this file exists; the rest are cheap to keep.
local INTEREST = {
  "HOUS", "HOUSE", "PLOT", "NEIGHBORHOOD", "DECOR", "CAMP", "BLUEPRINT",
  "CATALOG", "LAYOUT", "FURNITURE", "TUTORIAL",
}

-- Read-only C_Housing getters, named explicitly rather than pattern-matched.
-- The namespace also contains ResetHouse, RelinquishHouse, LeaveHouse and
-- CreateGuildNeighborhood -- calling an unknown function by pattern could
-- destroy the very thing we are inspecting, so nothing mutating goes in here,
-- and neither do the Request*/Search* calls, which hit the server.
local SAFE_GETTERS = {
  "IsInsideHouse", "IsInsideHouseOrPlot", "IsInsideOwnHouse", "IsInsideOwnedHouse",
  "IsInsideOwnedHouseOrPlot", "IsInsideOwnedPlot", "IsInsidePlot", "IsOnNeighborhoodMap",
  "IsHousingMarketEnabled", "IsHousingServiceEnabled", "IsHousingMarketShopEnabled",
  "IsHousingMarketCartFullRemoveEnabled", "HasHousingExpansionAccess",
  "GetHousingAccessFlags", "GetCurrentHouseInfo", "GetCurrentNeighborhoodGUID",
  "GetPlayerOwnedHouses", "GetMaxHouseLevel", "GetTrackedHouseGuid",
  "GetCurrentHouseLevelFavor", "GetCurrentHouseRefundAmount", "GetVisitCooldownInfo",
}

local startTime = GetTime()
local counts, firstSeen, log = {}, {}, {}
local detailDropped = 0
local sessions = 0

-- Event payloads carry tables and userdata that cannot be serialised into
-- SavedVariables. Keep primitives exact; describe the rest rather than losing
-- the fact that an argument was there at all.
local function Describe(value)
  local t = type(value)
  if t == "string" or t == "number" or t == "boolean" then return value end
  if t == "nil" then return "<nil>" end
  if t == "table" then
    local n = 0
    for _ in pairs(value) do n = n + 1 end
    return ("<table n=%d>"):format(n)
  end
  return "<" .. t .. ">"
end

local function PackArgs(...)
  local n = select("#", ...)
  if n == 0 then return nil end
  local out = { n = n }
  for i = 1, n do out[i] = Describe((select(i, ...))) end
  return out
end

local function IsInteresting(event)
  for i = 1, #INTEREST do
    if string.find(event, INTEREST[i], 1, true) then return true end
  end
  return false
end

local function OnEvent(self, event, ...)
  counts[event] = (counts[event] or 0) + 1

  -- First sighting of any event gets its payload, noise included: one row per
  -- distinct event name is bounded and is the most useful row in the file.
  if firstSeen[event] == nil then
    firstSeen[event] = { at = GetTime() - startTime, args = PackArgs(...) }
  end

  if IsInteresting(event) and not NOISE[event] then
    if #log < MAX_DETAIL then
      log[#log + 1] = { at = GetTime() - startTime, event = event, args = PackArgs(...) }
    else
      detailDropped = detailDropped + 1
    end
  end
end

-- Functions that hard-crash this client. C_Housing.GetMaxHouseLevel null-derefs
-- on build 69913 (ACCESS_VIOLATION reading 0x0, crash 2026-09-19 23.50.40) when
-- the player owns no house.
--
-- The lesson, paid for with a lost 98-minute session: pcall does NOT make an
-- unknown C function safe. It catches Lua errors; an access violation inside
-- native code takes the process down with pcall sitting right there on the
-- stack. "Read-only getter" is not a safety property on a beta client.
local KNOWN_CRASHERS = {
  GetMaxHouseLevel = "ACCESS_VIOLATION on build 69913 with no house owned",
}

-- Never called automatically -- see the comment on Flush(). Explicit opt-in only.
local function ReadHousingState()
  local out = {}
  local ns = rawget(_G, "C_Housing")
  if type(ns) ~= "table" then return { error = "C_Housing absent" } end
  for i = 1, #SAFE_GETTERS do
    local name = SAFE_GETTERS[i]
    if KNOWN_CRASHERS[name] then
      out[name] = "<skipped: " .. KNOWN_CRASHERS[name] .. ">"
    else
      local fn = rawget(ns, name)
      if type(fn) ~= "function" then
        out[name] = "<not present>"
      else
        local ok, a, b, c = pcall(fn)
        if not ok then
          out[name] = "<error: " .. tostring(a) .. ">"
        elseif b == nil and c == nil then
          out[name] = Describe(a)
        else
          out[name] = { Describe(a), Describe(b), Describe(c) }
        end
      end
    end
  end
  return out
end

-- Each flush replaces ForeverProbeEventsDB wholesale, so without this a
-- /reload (or a disconnect followed by a fresh login) would overwrite a good
-- capture with an empty one. Fold the previous file in first: tallies add,
-- first sightings keep the EARLIER record, and prior payload rows are retained
-- ahead of this session's. Beta world-refreshes make this a when, not an if.
local function MergePrevious()
  local prior = ForeverProbeEventsDB
  if type(prior) ~= "table" or prior.schema ~= SCHEMA_VERSION then return end

  sessions = tonumber(prior.sessions) or 1

  if type(prior.counts) == "table" then
    for event, n in pairs(prior.counts) do
      if type(n) == "number" then counts[event] = (counts[event] or 0) + n end
    end
  end

  if type(prior.firstSeen) == "table" then
    for event, rec in pairs(prior.firstSeen) do
      -- The stored one came from an earlier session, so it always wins.
      firstSeen[event] = rec
    end
  end

  if type(prior.log) == "table" then
    local merged = {}
    for i = 1, #prior.log do merged[#merged + 1] = prior.log[i] end
    for i = 1, #log do merged[#merged + 1] = log[i] end
    while #merged > MAX_DETAIL do table.remove(merged, 1) end -- drop oldest
    log = merged
  end
end

-- Flush runs on PLAYER_LOGOUT. It must therefore call NOTHING that can crash
-- the client, or the act of saving destroys the data being saved -- which is
-- exactly what happened when ReadHousingState() was called from here: every
-- logout and every /reload would have crashed before writing a single byte.
-- Housing state is read only on explicit command now, and cached for pickup.
local housingCache = nil

local function Flush()
  local distinct, total = 0, 0
  for _, n in pairs(counts) do distinct = distinct + 1; total = total + n end

  ForeverProbeEventsDB = {
    schema      = SCHEMA_VERSION,
    capturedAt  = date("%Y-%m-%d %H:%M:%S"),
    sessionSecs = GetTime() - startTime,
    sessions    = sessions + 1,
    counts      = counts,
    firstSeen   = firstSeen,
    log         = log,
    housingState = housingCache,
    stats = {
      distinctEvents = distinct,
      totalEvents    = total,
      detailLogged   = #log,
      detailDropped  = detailDropped,
    },
  }
  return distinct, total, #log, detailDropped
end

local frame = CreateFrame("Frame")
frame:RegisterAllEvents()
frame:SetScript("OnEvent", OnEvent)

-- SavedVariables only exist after our ADDON_LOADED, so the merge happens there
-- -- exactly once. Doing it inside Flush() would re-fold the same file on every
-- /fpevents and inflate the tallies.
local didMerge = false
local flusher = CreateFrame("Frame")
flusher:RegisterEvent("ADDON_LOADED")
flusher:RegisterEvent("PLAYER_LOGOUT")
flusher:SetScript("OnEvent", function(self, event, addonName)
  if event == "ADDON_LOADED" then
    if addonName == "ForeverProbe" and not didMerge then
      didMerge = true
      MergePrevious()
      self:UnregisterEvent("ADDON_LOADED")
    end
  elseif event == "PLAYER_LOGOUT" then
    -- Last chance to write before SavedVariables are serialised; /reload fires
    -- this too. A hard disconnect does not, which is why /fpevents exists.
    Flush()
  end
end)

SLASH_FOREVERPROBEEVENTS1 = "/fpevents"
SlashCmdList["FOREVERPROBEEVENTS"] = function(msg)
  local distinct, total, logged, dropped = Flush()
  print("|cff33ff99ForeverProbe/Events|r")
  print(("  %d distinct events, %d fired, %.0fs elapsed"):format(distinct, total, GetTime() - startTime))
  print(("  payload rows: %d logged%s"):format(logged, dropped > 0 and (", " .. dropped .. " dropped (cap)") or ""))

  if msg and string.find(msg, "hous") then
    local seen = {}
    for event in pairs(counts) do
      if IsInteresting(event) then seen[#seen + 1] = event end
    end
    table.sort(seen)
    if #seen == 0 then
      print("  |cffff9900no housing-related events seen yet|r")
    else
      for i = 1, #seen do print(("    %s x%d"):format(seen[i], counts[seen[i]])) end
    end
  else
    print("  /fpevents housing -- list housing events seen so far")
  end
  -- Precise wording matters here: this fills the table in memory. Only the
  -- client writes the file, and only on logout or /reload. A crash loses it.
  print("  |cffff9900Staged in memory. /reload to actually write it to disk.|r")
end

-- Deliberately a separate command, never wired to an event. Reading C_Housing
-- can take the client down (see KNOWN_CRASHERS), so it happens when you ask for
-- it and at no other time. Results are cached for the next Flush to pick up.
SLASH_FOREVERPROBEHOUSE1 = "/fphouse"
SlashCmdList["FOREVERPROBEHOUSE"] = function()
  print("|cff33ff99ForeverProbe/Housing|r reading C_Housing (skipping known crashers)...")
  housingCache = ReadHousingState()
  local shown = 0
  for i = 1, #SAFE_GETTERS do
    local name = SAFE_GETTERS[i]
    local v = housingCache[name]
    if v ~= nil and v ~= "<not present>" then
      print(("    %s = %s"):format(name, type(v) == "table" and table.concat({
        tostring(v[1]), tostring(v[2]), tostring(v[3]) }, ", ") or tostring(v)))
      shown = shown + 1
    end
  end
  print(("  %d values read. /reload to persist."):format(shown))
end
