-- GoldFinder -- Tab
-- One "GoldFind" tab on the auction house, added through LibAHTab so it
-- shares a single tab row with every other addon that uses the library.
--
-- Collision model:
--   * Other LibAHTab users: LibStub makes the library a singleton, so all
--     their tabs and ours live in one list and chain left to right.
--   * Tab ID clash: CreateTab errors on a reused ID; we check first and say so.
--   * Addons that bypass LibAHTab and append to AuctionHouseFrame.Tabs
--     directly: cannot be prevented, only detected. LibAHTab anchors its row
--     to whatever Tabs[#Tabs] was when the row was built; if that is no longer
--     the last tab, a raw tab now sits under the row. We report that as a
--     sentence rather than let it overlap silently.
--
-- AuctionHouseFrame, its Tabs table and PanelTemplates_* are Blizzard Lua,
-- invisible to the API index. Each was confirmed present by an in-client
-- type() check before this file was written; the tab was first seen working
-- on build 70009, alongside Auctionator's four LibAHTab tabs.

local ADDON, ns = ...

local TAB_ID     = "GoldFinder"
local TAB_TEXT   = "GoldFind"
local TAB_HEADER = "GoldFinder"

-- Blizzard's own tab count (Buy, Sell, Auctions), measured
-- in-client 2026-09-27. A baseline, not a guarantee.
local BLIZZARD_TABS = 3

local LibAHTab = LibStub("LibAHTab-1-0")

local created, deferred, warnedOverlap = false, false, false
local panel, body

-- LibAHTab keeps its row in lib.internalState. That is internal, not API:
-- every read here is nil-guarded and a missing field becomes "unknown".
local function SharedRow()
    local st = LibAHTab.internalState
    if type(st) ~= "table" then return nil end
    return st
end

-- nil when it cannot be determined; otherwise true/false.
local function RowIsOverlapped()
    local st = SharedRow()
    local tabs = AuctionHouseFrame and AuctionHouseFrame.Tabs
    if not st or not st.rootFrame or type(tabs) ~= "table" or #tabs == 0 then
        return nil
    end
    local _, anchoredTo = st.rootFrame:GetPoint(1)
    return anchoredTo ~= tabs[#tabs]
end

local function Report()
    local lines = {}
    local tabs = AuctionHouseFrame and AuctionHouseFrame.Tabs

    if type(tabs) ~= "table" then
        lines[#lines + 1] = "The auction house's own tab list could not be read, so overlap with other addons cannot be checked."
    elseif #tabs == BLIZZARD_TABS then
        lines[#lines + 1] = ("The auction house has its %d standard tabs. No addon has added one outside the shared tab library."):format(#tabs)
    elseif #tabs > BLIZZARD_TABS then
        lines[#lines + 1] = ("%d tab(s) were added to the auction house directly by another addon, outside the shared tab library."):format(#tabs - BLIZZARD_TABS)
    else
        lines[#lines + 1] = ("The auction house reports %d tabs where %d were measured on this build. Something has changed; treat the rest of this report with suspicion."):format(#tabs, BLIZZARD_TABS)
    end

    local st = SharedRow()
    if st and type(st.Tabs) == "table" then
        local others = #st.Tabs - 1
        if others == 0 then
            lines[#lines + 1] = "GoldFind is the only addon tab in the shared row."
        else
            lines[#lines + 1] = ("GoldFind shares its tab row with %d other addon tab(s), laid out side by side."):format(others)
        end
    else
        lines[#lines + 1] = "The number of other addon tabs in the shared row could not be read."
    end

    local overlapped = RowIsOverlapped()
    if overlapped == true then
        lines[#lines + 1] = "|cffff9900A tab added after the shared row was built is drawn underneath it. Tabs may overlap.|r"
    elseif overlapped == nil then
        lines[#lines + 1] = "Whether any tabs overlap could not be determined."
    end

    return table.concat(lines, "\n\n")
end

local function BuildPanel()
    panel = CreateFrame("Frame", nil, AuctionHouseFrame)
    panel:SetPoint("TOPLEFT", AuctionHouseFrame, "TOPLEFT", 16, -72)
    panel:SetPoint("BOTTOMRIGHT", AuctionHouseFrame, "BOTTOMRIGHT", -16, 16)

    body = panel:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    body:SetPoint("TOPLEFT", panel, "TOPLEFT")
    body:SetPoint("TOPRIGHT", panel, "TOPRIGHT")
    body:SetJustifyH("LEFT")

    panel:SetScript("OnShow", function() body:SetText(Report()) end)
end

local function CreateTabOnce()
    if created then return end

    if not AuctionHouseFrame then
        -- The AH UI is load-on-demand and may not exist yet when our handler
        -- runs. Wait one frame, once; never poll.
        if not deferred then
            deferred = true
            C_Timer.After(0, CreateTabOnce)
        else
            ns.Bad("The auction house window had not loaded when GoldFind tried to add its tab. It will try again next time you open the auction house.")
            deferred = false
        end
        return
    end

    created = true

    if LibAHTab:DoesIDExist(TAB_ID) then
        ns.Bad("Another addon has already registered a tab with GoldFinder's ID. GoldFind will not add a second one.")
        return
    end

    BuildPanel()
    local ok, err = pcall(LibAHTab.CreateTab, LibAHTab, TAB_ID, panel, TAB_TEXT, TAB_HEADER)
    if not ok then
        ns.Bad("The GoldFind tab could not be added: %s", tostring(err))
    end
end

local function CheckOverlap()
    if warnedOverlap or not created then return end
    if RowIsOverlapped() == true then
        warnedOverlap = true
        ns.Warn("Another addon added an auction house tab without the shared tab library. It may overlap the GoldFind tab. Open GoldFind for details.")
    end
end

local events = CreateFrame("Frame")
events:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")
events:SetScript("OnEvent", function(_, _, interactionType)
    if interactionType ~= Enum.PlayerInteractionType.Auctioneer then return end
    CreateTabOnce()
    -- Other addons may add their tabs in the same frame; look after they have.
    C_Timer.After(0, CheckOverlap)
end)
