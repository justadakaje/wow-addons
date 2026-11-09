local lib = LibStub:NewLibrary("LibAHTab-1-0", 7)

if not lib or lib.internalState then return end

local MIN_TAB_WIDTH = 70
local TAB_PADDING = 20
local OFFSET_X = 3
if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE and WOW_PROJECT_ID ~= (WOW_PROJECT_CAMELOT or 18) then
  OFFSET_X = -14
end

local tabIDErrorMessage = "tabID should be a string"

function lib:DoesIDExist(tabID)
  assert(type(tabID) == "string", tabIDErrorMessage)
  return lib.internalState and lib.internalState.usedIDs[tabID] ~= nil
end

local function RelayoutTabs()
  if not lib.internalState or not lib.internalState.Tabs then return end
  local totalTabs = #lib.internalState.Tabs
  local padding = TAB_PADDING
  local minWidth = MIN_TAB_WIDTH

  -- When multiple addons add tabs (e.g. GoldFinder + Auctionator's 4 tabs = 5 addon tabs),
  -- dynamically compress tab padding and minWidth so the entire tab row fits cleanly
  -- across the AuctionHouseFrame bottom bar without spilling off the right edge.
  if totalTabs >= 5 then
    padding = 8
    minWidth = 52
  elseif totalTabs == 4 then
    padding = 10
    minWidth = 58
  elseif totalTabs == 3 then
    padding = 14
    minWidth = 64
  end

  local baseLevel = (lib.internalState.rootFrame and lib.internalState.rootFrame:GetFrameLevel()) or 1

  for i, tab in ipairs(lib.internalState.Tabs) do
    PanelTemplates_TabResize(tab, padding, nil, minWidth)
    tab:ClearAllPoints()
    if i > 1 then
      tab:SetPoint("TOPLEFT", lib.internalState.Tabs[i - 1], "TOPRIGHT", OFFSET_X, 0)
    else
      tab:SetPoint("TOPLEFT", lib.internalState.rootFrame, "TOPLEFT", OFFSET_X, 0)
    end
    tab:SetHitRectInsets((math.abs(OFFSET_X) - 3) / 2, (math.abs(OFFSET_X) - 3) / 2, 0, 0)

    -- Keep consistent baseline frame level for all deselected sibling tabs
    tab:SetFrameLevel(baseLevel + 1)
  end
end

function lib:CreateTab(tabID, attachedFrame, displayText, tabHeader)
  assert(AuctionHouseFrame, "Wait for the AH to open before creating your tab")
  assert(type(tabID) == "string", tabIDErrorMessage)
  assert(type(attachedFrame) == "table" and attachedFrame.IsObjectType and attachedFrame:IsObjectType("Frame"), "attachedFrame should be a frame")
  assert(type(displayText) == "string", "displayText should be a string")
  assert(tabHeader == nil or type(tabHeader) == "string", "tabHeader should be a string")

  if not lib.internalState then
    lib.internalState = {
      Tabs = {},
      usedIDs = {},
      selectedTab = nil,
    }
    lib.internalState.rootFrame = CreateFrame("Frame", nil, AuctionHouseFrame)
    lib.internalState.rootFrame:SetSize(10, 10)
    lib.internalState.rootFrame:SetPoint("TOPLEFT", AuctionHouseFrame.Tabs[#AuctionHouseFrame.Tabs], "TOPRIGHT")

    hooksecurefunc(AuctionHouseFrame, "SetDisplayMode", function(self, mode)
      if mode ~= nil and #mode > 0 then
        local baseLevel = (lib.internalState.rootFrame and lib.internalState.rootFrame:GetFrameLevel()) or 1
        for _, tab in ipairs(lib.internalState.Tabs) do
          tab.frameRef:Hide()
          tab:SetFrameLevel(baseLevel + 1)
          PanelTemplates_DeselectTab(tab)
        end
      end
    end)
  end

  if lib:DoesIDExist(tabID) then
    error("The tab id already exists")
  end

  local newTab = CreateFrame("Button", "LibAHFrame-1.0-" .. tabID, lib.internalState.rootFrame, "AuctionHouseFrameDisplayModeTabTemplate")
  table.insert(lib.internalState.Tabs, newTab)

  newTab:SetText(displayText)

  lib.internalState.usedIDs[tabID] = newTab

  PanelTemplates_DeselectTab(newTab)

  newTab.frameRef = attachedFrame
  newTab.tabHeader = tabHeader or displayText

  attachedFrame:Hide()

  newTab:SetScript("OnClick", function()
    lib:SetSelected(tabID)
  end)

  RelayoutTabs()
end

function lib:GetButton(tabID)
  assert(type(tabID) == "string", tabIDErrorMessage)
  return lib.internalState.usedIDs[tabID]
end

function lib:SetSelected(tabID)
  assert(type(tabID) == "string", tabIDErrorMessage)
  if lib.internalState == nil or not lib:DoesIDExist(tabID) then
    error("Tab doesn't exist")
  end

  AuctionHouseFrame:SetDisplayMode({})

  local baseLevel = (lib.internalState.rootFrame and lib.internalState.rootFrame:GetFrameLevel()) or 1

  for _, tab in ipairs(lib.internalState.Tabs) do
    tab.frameRef:Hide()
    tab:SetFrameLevel(baseLevel + 1)
    PanelTemplates_DeselectTab(tab)
  end

  for _, tab in ipairs(AuctionHouseFrame.Tabs) do
    PanelTemplates_DeselectTab(tab)
  end

  local selectedTab = lib:GetButton(tabID)
  selectedTab:SetFrameLevel(baseLevel + 5)
  PanelTemplates_SelectTab(selectedTab)

  AuctionHouseFrame:SetTitle(selectedTab.tabHeader)
  selectedTab.frameRef:Show()
end
