local ADDON_NAME = ...

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, loadedAddon)
    if loadedAddon == ADDON_NAME then
        print("|cff33ff99" .. ADDON_NAME .. "|r loaded successfully.")
        self:UnregisterEvent("ADDON_LOADED")
    end
end)

SLASH_ADDONSMOKETEST1 = "/smoketest"
SlashCmdList["ADDONSMOKETEST"] = function(msg)
    print(ADDON_NAME .. " says hi. You typed: " .. (msg ~= "" and msg or "(nothing)"))
end
