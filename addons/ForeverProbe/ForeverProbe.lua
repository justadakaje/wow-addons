-- ForeverProbe -- captures the real API surface of WoW: Forever (1.60.1 beta).
--
-- Why this exists: there is no API reference for this client yet. Wiki data,
-- model training data, and every addon author's assumptions all predate it.
-- The only authoritative source for what 1.60.1 exposes is the running client,
-- so we ask it directly and write the answer to SavedVariables.
--
-- Read-only. Enumerates _G, reads Blizzard's own documentation tables if they
-- exist, and calls GetBuildInfo(). Changes no game state.

local SCHEMA_VERSION = 3

-- The documentation framework loads without its data: v2 found every
-- APIDocumentation method present but `systems` empty. On modern clients the
-- generated tables live in a second addon, so try both.
local DOC_ADDONS = { "Blizzard_APIDocumentation", "Blizzard_APIDocumentationGenerated" }

-- Functions whose home moved between Classic and modern clients. Forever runs a
-- modern engine over Classic content, so which side of each split it landed on
-- is an open question -- probe, never assume.
local WATCHLIST = {
  "GetAddOnMetadata",             "C_AddOns.GetAddOnMetadata",
  "GetNumAddOns",                 "C_AddOns.GetNumAddOns",
  "IsAddOnLoaded",                "C_AddOns.IsAddOnLoaded",
  "GetContainerNumSlots",         "C_Container.GetContainerNumSlots",
  "GetContainerItemInfo",         "C_Container.GetContainerItemInfo",
  "GetItemInfo",                  "C_Item.GetItemInfo",
  "GetSpellInfo",                 "C_Spell.GetSpellInfo",
  "IsSpellKnown",                 "C_SpellBook.IsSpellKnown",
  "UnitAura",                     "C_UnitAuras.GetAuraDataByIndex",
  "QueryAuctionItems",            "C_AuctionHouse.SendBrowseQuery",
  "GetTradeSkillInfo",            "C_TradeSkillUI.GetRecipeInfo",
  "C_EditMode.GetLayouts",        "C_Housing",
  "C_Timer.After",                "CreateFrame",
}

-- Walks a dotted path against _G without invoking metatables, so a probe never
-- accidentally constructs the namespace it is testing for.
local function Resolve(path)
  local node = _G
  for part in string.gmatch(path, "[^%.]+") do
    if type(node) ~= "table" then return nil end
    node = rawget(node, part)
    if node == nil then return nil end
  end
  return node
end

local function SnapshotGlobals()
  local namespaces, globalFunctions = {}, {}
  local namespaceCount, memberCount = 0, 0

  for key, value in pairs(_G) do
    if type(key) == "string" then
      if type(value) == "table" and string.sub(key, 1, 2) == "C_" then
        local members = {}
        for memberName, member in pairs(value) do
          if type(memberName) == "string" and type(member) == "function" then
            members[#members + 1] = memberName
          end
        end
        table.sort(members)
        namespaces[key] = members
        namespaceCount = namespaceCount + 1
        memberCount = memberCount + #members
      elseif type(value) == "function" then
        globalFunctions[#globalFunctions + 1] = key
      end
    end
  end

  table.sort(globalFunctions)
  return namespaces, globalFunctions, namespaceCount, memberCount
end

-- Copies the documented fields off an argument, return value, or event payload.
local function CopyParams(list)
  if type(list) ~= "table" then return nil end
  local out = {}
  for i = 1, #list do
    local p = list[i]
    if type(p) == "table" then
      out[#out + 1] = { Name = p.Name, Type = p.Type, Nilable = p.Nilable, Default = p.Default }
    end
  end
  return out
end

-- Modern clients ship Blizzard's own API documentation in-game (/api on Retail).
-- If Forever inherited it, it yields real signatures -- argument names, types,
-- return types -- not just a list of function names. That is the difference
-- between "this function exists" and "here is how to call it".
--
-- We do not assume the table's shape. If it is not what we expect, we record
-- what we actually found, so a wrong guess here stays visible instead of silent.
local function HarvestDocumentation()
  -- Note: the plain global LoadAddOn does not exist on this client, only
  -- C_AddOns.LoadAddOn -- hence the lookup rather than a direct call.
  local loader = (C_AddOns and C_AddOns.LoadAddOn) or rawget(_G, "LoadAddOn")
  local loads = {}
  for i = 1, #DOC_ADDONS do
    local name = DOC_ADDONS[i]
    if loader then
      local ok, err = pcall(loader, name)
      loads[name] = ok and "loaded" or ("failed: " .. tostring(err))
    else
      loads[name] = "no loader available"
    end
  end

  -- Blizzard also ships a lazy-load stub for the docs UI; it exists here.
  local stub = rawget(_G, "APIDocumentation_LoadUI")
  if type(stub) == "function" then
    loads["APIDocumentation_LoadUI()"] = select(2, pcall(stub)) == nil and "called" or "errored"
  end

  local docs = rawget(_G, "APIDocumentation")
  if type(docs) ~= "table" then
    return {
      available = false,
      loads = loads,
      reason = "APIDocumentation global absent after attempting to load " .. table.concat(DOC_ADDONS, ", "),
    }
  end

  local shape = {}
  for key, value in pairs(docs) do shape[key] = type(value) end

  local systems = rawget(docs, "systems")
  if type(systems) ~= "table" then
    return {
      available = true,
      harvested = false,
      shape = shape,
      loads = loads,
      reason = "APIDocumentation exists but exposes no 'systems' table -- see shape",
    }
  end

  local out, fnCount, evCount = {}, 0, 0
  for i = 1, #systems do
    local system = systems[i]
    if type(system) == "table" then
      local entry = {
        Name = system.Name or system.Namespace,
        Namespace = system.Namespace,
        Functions = {},
        Events = {},
      }

      local fns = system.Functions
      if type(fns) == "table" then
        for j = 1, #fns do
          local fn = fns[j]
          if type(fn) == "table" and fn.Name then
            entry.Functions[#entry.Functions + 1] = {
              Name = fn.Name,
              Arguments = CopyParams(fn.Arguments),
              Returns = CopyParams(fn.Returns),
            }
            fnCount = fnCount + 1
          end
        end
      end

      local evs = system.Events
      if type(evs) == "table" then
        for j = 1, #evs do
          local ev = evs[j]
          if type(ev) == "table" and ev.Name then
            entry.Events[#entry.Events + 1] = {
              Name = ev.Name,
              LiteralName = ev.LiteralName,
              Payload = CopyParams(ev.Payload),
            }
            evCount = evCount + 1
          end
        end
      end

      out[#out + 1] = entry
    end
  end

  return {
    available = true,
    harvested = true,
    shape = shape,
    loads = loads,
    systems = out,
    counts = { systems = #out, functions = fnCount, events = evCount },
  }
end

-- WOW_PROJECT_* constants are what every addon's [AllowLoadGameType] gate and
-- every `WOW_PROJECT_ID == ...` branch actually keys off. v2 captured only
-- functions and C_ tables, so it missed them -- and they are precisely what
-- explains why Auctionator's auction-house layer does not load on this client.
local function SnapshotConstants()
  local out = {}
  for key, value in pairs(_G) do
    if type(key) == "string" and string.find(key, "^WOW_PROJECT") then
      local t = type(value)
      if t == "number" or t == "string" or t == "boolean" then out[key] = value end
    end
  end
  return out
end

local function Capture()
  -- Interface number is settled at 16001 (every shipped Forever .toc agrees).
  -- We still capture tocVersion: it is the client's own word for it, and the
  -- only thing that would catch a mid-beta bump.
  local version, build, buildDate, tocVersion = GetBuildInfo()
  local namespaces, globalFunctions, namespaceCount, memberCount = SnapshotGlobals()

  local watchlist = {}
  for _, path in ipairs(WATCHLIST) do
    watchlist[path] = (Resolve(path) ~= nil)
  end

  local ok, documentation = pcall(HarvestDocumentation)
  if not ok then
    documentation = { available = false, reason = "harvest error: " .. tostring(documentation) }
  end

  ForeverProbeDB = {
    schema     = SCHEMA_VERSION,
    capturedAt = date("%Y-%m-%d %H:%M:%S"),
    build = { version = version, build = build, buildDate = buildDate, tocVersion = tocVersion },
    counts = {
      namespaces       = namespaceCount,
      namespaceMembers = memberCount,
      globalFunctions  = #globalFunctions,
    },
    namespaces      = namespaces,
    globalFunctions = globalFunctions,
    watchlist       = watchlist,
    documentation   = documentation,
    projectConstants = SnapshotConstants(),
  }

  return tocVersion, version, build, namespaceCount, memberCount, #globalFunctions, documentation
end

local function Report()
  local tocVersion, version, build, nsCount, memberCount, fnCount, docs = Capture()

  print("|cff33ff99ForeverProbe|r captured:")
  -- If the client withholds a value we say so, rather than printing a
  -- plausible-looking number.
  print(("  Interface (tocVersion): %s"):format(tocVersion or "|cffff0000nil -- client reported none|r"))
  print(("  Version / build: %s / %s"):format(version or "nil", build or "nil"))
  print(("  C_ namespaces: %d (%d functions)"):format(nsCount, memberCount))
  print(("  Global functions: %d"):format(fnCount))

  if docs and docs.harvested and docs.counts then
    print(("|cff33ff99  API docs: %d systems, %d functions, %d events -- signatures captured|r")
      :format(docs.counts.systems, docs.counts.functions, docs.counts.events))
  else
    print(("|cffff9900  API docs: unavailable -- %s|r"):format((docs and docs.reason) or "unknown"))
  end

  local pid = rawget(_G, "WOW_PROJECT_ID")
  print(("  WOW_PROJECT_ID: %s"):format(tostring(pid)))

  print("  Full dump lands in SavedVariables on /reload or logout.")
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event)
  if event ~= "PLAYER_LOGIN" then return end
  self:UnregisterEvent("PLAYER_LOGIN")

  -- Anything already on disk is from a previous build or schema; stale by
  -- definition, so warn rather than silently merging into it.
  if type(ForeverProbeDB) == "table" and ForeverProbeDB.schema ~= SCHEMA_VERSION then
    print(("|cff33ff99ForeverProbe|r: replacing an older capture (schema %s)."):format(
      tostring(ForeverProbeDB.schema)))
  end

  Report()
end)

SLASH_FOREVERPROBE1 = "/fprobe"
SlashCmdList["FOREVERPROBE"] = Report
