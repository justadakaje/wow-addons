local ADDON_NAME = ...

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, loadedAddon)
  if event == "ADDON_LOADED" and loadedAddon == ADDON_NAME then
    print("|cff33ff99AddonSmokeTest|r loaded OK.")
    self:UnregisterEvent("ADDON_LOADED")
  end
end)
