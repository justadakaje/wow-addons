local ADDON, NS = ...

local function SafeValue(val)
  if val == nil then
    return nil
  end
  if issecretvalue and issecretvalue(val) then
    return nil
  end
  if canaccessvalue and not canaccessvalue(val) then
    return nil
  end
  return val
end

local function EchoChat(msg)
  local frame = SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME
  if frame and frame.AddMessage then
    frame:AddMessage("|cff22d3ee[KenHenRoster]|r " .. tostring(msg))
  end
end

local function DetectFlavor()
  local _, _, _, tocVersion = GetBuildInfo()
  -- Check Forever TOC range before WOW_PROJECT_MAINLINE (Forever sets WOW_PROJECT_ID = 1 == MAINLINE)
  if tocVersion and tocVersion >= 16000 and tocVersion < 20000 then
    return "forever"
  end
  if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
    return "retail"
  end
  if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
    return "classic-era"
  end
  return "classic-prog"
end

local function EscapeJsonString(str)
  local s = tostring(str or "")
  s = s:gsub("\\", "\\\\")
  s = s:gsub('"', '\\"')
  s = s:gsub("\b", "\\b")
  s = s:gsub("\f", "\\f")
  s = s:gsub("\n", "\\n")
  s = s:gsub("\r", "\\r")
  s = s:gsub("\t", "\\t")
  return '"' .. s .. '"'
end

local function EncodeJsonValue(val)
  local t = type(val)
  if val == nil then
    return "null"
  elseif t == "boolean" then
    return val and "true" or "false"
  elseif t == "number" then
    if val ~= val or val == math.huge or val == -math.huge then
      return "0"
    end
    return tostring(val)
  elseif t == "string" then
    return EscapeJsonString(val)
  elseif t == "table" then
    local n = #val
    local isArray = true
    local count = 0
    for k in pairs(val) do
      count = count + 1
      if type(k) ~= "number" or k < 1 or k > n or math.floor(k) ~= k then
        isArray = false
        break
      end
    end
    if isArray and count == n then
      local parts = {}
      for i = 1, n do
        parts[i] = EncodeJsonValue(val[i])
      end
      return "[" .. table.concat(parts, ",") .. "]"
    else
      local keys = {}
      for k in pairs(val) do
        if type(k) == "string" or type(k) == "number" then
          table.insert(keys, k)
        end
      end
      table.sort(keys, function(a, b)
        return tostring(a) < tostring(b)
      end)
      local parts = {}
      for _, k in ipairs(keys) do
        table.insert(parts, EscapeJsonString(tostring(k)) .. ":" .. EncodeJsonValue(val[k]))
      end
      return "{" .. table.concat(parts, ",") .. "}"
    end
  end
  return "null"
end

local function EnsureDB()
  if type(KenHenRosterDB) ~= "table" then
    KenHenRosterDB = {}
  end
  KenHenRosterDB.version = 1
  KenHenRosterDB.flavor = DetectFlavor()
  if type(KenHenRosterDB.chars) ~= "table" then
    KenHenRosterDB.chars = {}
  end
end

local function CapturePlayerCharacter()
  EnsureDB()

  local guid = SafeValue(UnitGUID("player"))
  if not guid then
    return
  end

  local rawName, rawSecond = UnitFullName("player")
  rawName = SafeValue(rawName) or SafeValue(UnitName("player")) or "Unknown"
  rawSecond = SafeValue(rawSecond)
  local normRealm = SafeValue(GetNormalizedRealmName and GetNormalizedRealmName())
  local realmDisplay = SafeValue(GetRealmName and GetRealmName()) or ""

  local firstName = rawName
  local surname = nil
  local realmSlug = normRealm

  -- On WoW: Forever (including 70009+ builds with non-empty GetNormalizedRealmName), UnitFullName returns ("First", "Surname")
  if rawSecond and rawSecond ~= "" and rawSecond ~= normRealm and not firstName:find(" ", 1, true) then
    surname = rawSecond
  elseif firstName:find(" ", 1, true) then
    local sp = firstName:find(" ", 1, true)
    surname = firstName:sub(sp + 1)
    firstName = firstName:sub(1, sp - 1)
  end

  local fullName = surname and (firstName .. " " .. surname) or firstName
  local level = tonumber(SafeValue(UnitLevel("player"))) or 1
  local faction = SafeValue(UnitFactionGroup("player")) or "Neutral"
  local raceName, raceFile, raceID = UnitRace("player")
  local className, classFile, classID = UnitClass("player")
  local guildName, guildRankName = GetGuildInfo("player")

  local specName = nil
  if C_SpecializationInfo and C_SpecializationInfo.GetSpecialization and C_SpecializationInfo.GetSpecializationInfo then
    local specIdx = SafeValue(C_SpecializationInfo.GetSpecialization())
    if specIdx then
      local _, sName = C_SpecializationInfo.GetSpecializationInfo(specIdx)
      specName = SafeValue(sName)
    end
  else
    local getSpecFn = _G.GetSpecialization
    local getSpecInfoFn = _G.GetSpecializationInfo
    if getSpecFn and getSpecInfoFn then
      local specIdx = SafeValue(getSpecFn())
      if specIdx then
        local _, sName = getSpecInfoFn(specIdx)
        specName = SafeValue(sName)
      end
    end
  end

  local ilvl = nil
  local getAvgItemLevelFn = _G.GetAverageItemLevel
  if getAvgItemLevelFn then
    local _, equipped = getAvgItemLevelFn()
    equipped = SafeValue(equipped)
    if type(equipped) == "number" and equipped > 0 then
      ilvl = math.floor(equipped + 0.5)
    end
  end

  KenHenRosterDB.chars[guid] = {
    id = guid,
    name = firstName,
    surname = surname,
    fullName = fullName,
    level = level,
    faction = faction,
    race = SafeValue(raceName) or "Human",
    raceFile = SafeValue(raceFile),
    raceId = SafeValue(raceID),
    cls = SafeValue(className) or "Warrior",
    classFile = SafeValue(classFile) or "WARRIOR",
    classId = SafeValue(classID),
    realm = (realmDisplay ~= "" and realmDisplay) or nil,
    realmSlug = (realmSlug and realmSlug ~= "" and realmSlug) or nil,
    guild = SafeValue(guildName),
    guildRank = SafeValue(guildRankName),
    spec = specName,
    ilvl = ilvl,
    updatedAt = time(),
  }
end

local function BuildExportString(forceRawJson)
  EnsureDB()
  CapturePlayerCharacter()

  local list = {}
  for _, entry in pairs(KenHenRosterDB.chars) do
    if type(entry) == "table" and entry.name then
      table.insert(list, entry)
    end
  end
  table.sort(list, function(a, b)
    local la = tonumber(a.level) or 0
    local lb = tonumber(b.level) or 0
    if la ~= lb then
      return la > lb
    end
    return tostring(a.fullName or a.name) < tostring(b.fullName or b.name)
  end)

  local payload = {
    v = 1,
    flavor = KenHenRosterDB.flavor or DetectFlavor(),
    exportedAt = time(),
    chars = list,
  }

  local jsonText = nil
  if C_EncodingUtil and C_EncodingUtil.SerializeJSON then
    local ok, res = pcall(C_EncodingUtil.SerializeJSON, payload)
    if ok and type(res) == "string" then
      jsonText = res
    end
  end
  if not jsonText then
    jsonText = EncodeJsonValue(payload)
  end

  if forceRawJson then
    return jsonText, #list
  end

  local compMethod = Enum and Enum.CompressionMethod and Enum.CompressionMethod.Deflate
  local compLevel = Enum and Enum.CompressionLevel and (Enum.CompressionLevel.OptimizeForSize or Enum.CompressionLevel.Default)
  local b64Variant = Enum and Enum.Base64Variant and Enum.Base64Variant.Standard

  if C_EncodingUtil and C_EncodingUtil.CompressString and C_EncodingUtil.EncodeBase64 and compMethod ~= nil then
    local ok, compressed
    if compLevel ~= nil then
      ok, compressed = pcall(C_EncodingUtil.CompressString, jsonText, compMethod, compLevel)
    else
      ok, compressed = pcall(C_EncodingUtil.CompressString, jsonText, compMethod)
    end
    if ok and type(compressed) == "string" then
      local b64Ok, b64
      if b64Variant ~= nil then
        b64Ok, b64 = pcall(C_EncodingUtil.EncodeBase64, compressed, b64Variant)
      else
        b64Ok, b64 = pcall(C_EncodingUtil.EncodeBase64, compressed)
      end
      if b64Ok and type(b64) == "string" then
        return "KHR1:" .. b64, #list
      end
    end
  end

  if C_EncodingUtil and C_EncodingUtil.EncodeBase64 then
    local b64Ok, b64
    if b64Variant ~= nil then
      b64Ok, b64 = pcall(C_EncodingUtil.EncodeBase64, jsonText, b64Variant)
    else
      b64Ok, b64 = pcall(C_EncodingUtil.EncodeBase64, jsonText)
    end
    if b64Ok and type(b64) == "string" then
      return "KHR1J:" .. b64, #list
    end
  end

  return jsonText, #list
end

NS.DetectFlavor = DetectFlavor
NS.CapturePlayerCharacter = CapturePlayerCharacter
NS.BuildExportString = BuildExportString

local exportFrame
local function ShowExportWindow()
  if not exportFrame then
    local template = _G.BackdropTemplateMixin and "BackdropTemplate" or nil
    exportFrame = CreateFrame("Frame", "KenHenRosterExportFrame", UIParent, template)
    exportFrame:SetSize(620, 360)
    exportFrame:SetPoint("CENTER")
    exportFrame:SetFrameStrata("DIALOG")
    exportFrame:SetMovable(true)
    exportFrame:EnableMouse(true)
    exportFrame:RegisterForDrag("LeftButton")
    exportFrame:SetScript("OnDragStart", exportFrame.StartMoving)
    exportFrame:SetScript("OnDragStop", exportFrame.StopMovingOrSizing)
    if exportFrame.SetBackdrop then
      exportFrame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 14,
        insets = { left = 3, right = 3, top = 3, bottom = 3 },
      })
      exportFrame:SetBackdropColor(0.04, 0.06, 0.08, 0.96)
      exportFrame:SetBackdropBorderColor(0.88, 0.66, 0.23, 0.95)
    end
    table.insert(UISpecialFrames, "KenHenRosterExportFrame")

    local title = exportFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    title:SetPoint("TOPLEFT", 16, -14)
    title:SetText("KenHen.Win Roster Export (/khr)")

    local subtitle = exportFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    subtitle:SetPoint("TOPLEFT", 16, -38)
    subtitle:SetTextColor(0.65, 0.78, 0.85)
    exportFrame.subtitle = subtitle

    local scroll = CreateFrame("ScrollFrame", "KenHenRosterExportScroll", exportFrame, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", 16, -64)
    scroll:SetPoint("BOTTOMRIGHT", -36, 48)

    local editBox = CreateFrame("EditBox", "KenHenRosterExportEditBox", scroll)
    editBox:SetMultiLine(true)
    editBox:SetFontObject(ChatFontNormal)
    editBox:SetWidth(555)
    editBox:SetAutoFocus(true)
    editBox:SetScript("OnEscapePressed", function()
      exportFrame:Hide()
    end)
    scroll:SetScrollChild(editBox)
    exportFrame.editBox = editBox

    local closeBtn = CreateFrame("Button", nil, exportFrame, "UIPanelButtonTemplate")
    closeBtn:SetSize(96, 26)
    closeBtn:SetPoint("BOTTOMRIGHT", -16, 12)
    closeBtn:SetText("Close")
    closeBtn:SetScript("OnClick", function()
      exportFrame:Hide()
    end)

    local jsonBtn = CreateFrame("Button", nil, exportFrame, "UIPanelButtonTemplate")
    jsonBtn:SetSize(110, 26)
    jsonBtn:SetPoint("RIGHT", closeBtn, "LEFT", -8, 0)
    jsonBtn:SetText("Show Raw JSON")
    jsonBtn:SetScript("OnClick", function()
      local str, count = BuildExportString(true)
      exportFrame.subtitle:SetText(string.format("%d alt(s) captured. Press Ctrl+C and paste into KenHen.Win.", count))
      exportFrame.editBox:SetText(str)
      exportFrame.editBox:HighlightText()
      exportFrame.editBox:SetFocus()
    end)

    local studioBtn = CreateFrame("Button", nil, exportFrame, "UIPanelButtonTemplate")
    studioBtn:SetSize(130, 26)
    studioBtn:SetPoint("BOTTOMLEFT", 16, 12)
    studioBtn:SetText("Chroma Studio")
    studioBtn:SetScript("OnClick", function()
      exportFrame:Hide()
      NS.ShowStudioFrame()
    end)
  end

  local str, count = BuildExportString(false)
  exportFrame.subtitle:SetText(string.format("%d alt(s) captured. Press Ctrl+C and paste into KenHen.Win.", count))
  exportFrame.editBox:SetText(str)
  exportFrame:Show()
  exportFrame.editBox:HighlightText()
  exportFrame.editBox:SetFocus()
  EchoChat(string.format("Opened export window with %d captured alt(s).", count))
end

local studioFrame
function NS.ShowStudioFrame()
  if not studioFrame then
    studioFrame = CreateFrame("Frame", "KenHenRosterStudioFrame", UIParent)
    studioFrame:SetAllPoints(UIParent)
    studioFrame:SetFrameStrata("FULLSCREEN_DIALOG")
    studioFrame:EnableMouse(true)
    studioFrame:EnableMouseWheel(true)
    table.insert(UISpecialFrames, "KenHenRosterStudioFrame")

    local bg = studioFrame:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetColorTexture(0.0, 0.694, 0.251, 1.0) -- Narcissus Green #00b140
    studioFrame.bg = bg

    local model = CreateFrame("PlayerModel", nil, studioFrame)
    model:SetAllPoints()
    if model.SetKeepModelOnHide then
      pcall(model.SetKeepModelOnHide, model, true)
    end
    studioFrame.model = model

    local yaw = 0
    local zoom = 0.0
    local lastX = nil

    local function ReadCursorX()
      local getCursorPos = _G.GetCursorPosition
      if type(getCursorPos) == "function" then
        local x = getCursorPos()
        if type(x) == "number" then
          return x
        end
      end
      return nil
    end

    local function OnStudioDragUpdate()
      local curX = ReadCursorX()
      if curX ~= nil and lastX ~= nil then
        local delta = (curX - lastX) * 0.012
        yaw = yaw + delta
        lastX = curX
        if model.SetRotation then
          pcall(model.SetRotation, model, yaw, false)
        end
      elseif _G.GetCursorDelta then
        local dx = _G.GetCursorDelta()
        if type(dx) == "number" and dx ~= 0 then
          yaw = yaw + dx * 0.012
          if model.SetRotation then
            pcall(model.SetRotation, model, yaw, false)
          end
        end
      end
    end

    local function StopDrag()
      lastX = nil
      studioFrame:SetScript("OnUpdate", nil)
    end

    -- Attach OnUpdate strictly while LeftButton drag is active (AGENTS.md: no idle OnUpdate polling)
    studioFrame:SetScript("OnMouseDown", function(_, button)
      if button == "LeftButton" then
        lastX = ReadCursorX()
        studioFrame:SetScript("OnUpdate", OnStudioDragUpdate)
      end
    end)
    studioFrame:SetScript("OnMouseUp", StopDrag)
    studioFrame:SetScript("OnHide", StopDrag)

    studioFrame:SetScript("OnMouseWheel", function(_, delta)
      zoom = math.max(-0.5, math.min(0.85, zoom + delta * 0.08))
      if model.SetPortraitZoom then
        pcall(model.SetPortraitZoom, model, zoom)
      end
    end)

    local closeBtn = CreateFrame("Button", nil, studioFrame, "UIPanelButtonTemplate")
    closeBtn:SetSize(110, 28)
    closeBtn:SetPoint("TOPRIGHT", -24, -24)
    closeBtn:SetText("Close (ESC)")
    closeBtn:SetScript("OnClick", function()
      studioFrame:Hide()
    end)

    local greenBtn = CreateFrame("Button", nil, studioFrame, "UIPanelButtonTemplate")
    greenBtn:SetSize(120, 28)
    greenBtn:SetPoint("TOPLEFT", 24, -24)
    greenBtn:SetText("Green #00b140")
    greenBtn:SetScript("OnClick", function()
      bg:SetColorTexture(0.0, 0.694, 0.251, 1.0)
    end)

    local blueBtn = CreateFrame("Button", nil, studioFrame, "UIPanelButtonTemplate")
    blueBtn:SetSize(120, 28)
    blueBtn:SetPoint("LEFT", greenBtn, "RIGHT", 8, 0)
    blueBtn:SetText("Blue #0047bb")
    blueBtn:SetScript("OnClick", function()
      bg:SetColorTexture(0.0, 0.278, 0.733, 1.0)
    end)
  end

  if studioFrame.model.ClearModel then
    studioFrame.model:ClearModel()
  end
  studioFrame:Show()
  if studioFrame.model.SetUnit then
    pcall(studioFrame.model.SetUnit, studioFrame.model, "player", false)
  end
  if studioFrame.model.SetRotation then
    pcall(studioFrame.model.SetRotation, studioFrame.model, 0, false)
  end
  EchoChat("Opened Chroma-Key Portrait Studio (#00b140 / #0047bb). Drag to rotate, scroll to zoom, Esc to close.")
end

local events = CreateFrame("Frame")
events:RegisterEvent("PLAYER_LOGIN")
events:RegisterEvent("PLAYER_ENTERING_WORLD")
events:RegisterEvent("PLAYER_LEVEL_UP")
events:RegisterEvent("PLAYER_GUILD_UPDATE")
events:SetScript("OnEvent", function()
  CapturePlayerCharacter()
end)

SLASH_KENHENROSTER1 = "/khr"
SLASH_KENHENROSTER2 = "/kenhenroster"
SlashCmdList["KENHENROSTER"] = function(msg)
  local cmd = (msg or ""):lower():match("^%s*(.-)%s*$")
  if cmd == "studio" or cmd == "chroma" then
    NS.ShowStudioFrame()
  else
    ShowExportWindow()
  end
end
