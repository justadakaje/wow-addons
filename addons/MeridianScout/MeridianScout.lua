local watcher = CreateFrame("Frame")

local function scan()
    if not (NumTaxiNodes and TaxiNodeGetType and TaxiNodeName) then
        return
    end
    MeridianScoutFlights = MeridianScoutFlights or {}
    for i = 1, NumTaxiNodes() do
        local status = TaxiNodeGetType(i)
        local name = TaxiNodeName(i)
        if name and (status == "CURRENT" or status == "REACHABLE") then
            MeridianScoutFlights[name] = true
        end
    end
end

watcher:RegisterEvent("TAXIMAP_OPENED")
watcher:SetScript("OnEvent", function()
    if C_Timer and C_Timer.After then
        C_Timer.After(0, scan)
    else
        scan()
    end
end)

local function GetNumEntries()
    if C_QuestLog and C_QuestLog.GetNumQuestLogEntries then
        local numShown = C_QuestLog.GetNumQuestLogEntries()
        return numShown or 0
    elseif GetNumQuestLogEntries then
        local numShown = GetNumQuestLogEntries()
        return numShown or 0
    end
    return 0
end

local function GetEntryInfo(index)
    if C_QuestLog and C_QuestLog.GetInfo then
        local info = C_QuestLog.GetInfo(index)
        if not info then return nil end
        local questID = info.questID
        local isComplete = false
        if questID and questID > 0 and C_QuestLog.IsComplete then
            isComplete = C_QuestLog.IsComplete(questID) and true or false
        end
        return info.title, info.level or 0, info.isHeader and true or false,
               info.isCollapsed and true or false, isComplete, questID
    elseif GetQuestLogTitle then
        local title, level, _, isHeader, isCollapsed, complete, _, questID = GetQuestLogTitle(index)
        return title, level or 0, isHeader and true or false,
               isCollapsed and true or false, (complete == 1 or complete == true), questID
    end
    return nil
end

local function GetObjectivesText(logIndex, questID)
    local objectives = {}
    if C_QuestLog and C_QuestLog.GetQuestObjectives and questID then
        local list = C_QuestLog.GetQuestObjectives(questID)
        if list then
            for _, obj in ipairs(list) do
                table.insert(objectives, obj.text or "")
            end
        end
    end
    if #objectives == 0 and GetNumQuestLeaderBoards and GetQuestLogLeaderBoard then
        for k = 1, GetNumQuestLeaderBoards(logIndex) do
            local text = GetQuestLogLeaderBoard(k, logIndex)
            table.insert(objectives, text or "")
        end
    end
    return table.concat(objectives, "; ")
end

local window, box

local function export()
    if TaxiFrame and TaxiFrame:IsShown() then scan() end

    local map
    if C_Map and C_Map.GetBestMapForUnit then
        map = C_Map.GetBestMapForUnit("player")
    end
    local p
    if map and C_Map and C_Map.GetPlayerMapPosition then
        p = C_Map.GetPlayerMapPosition(map, "player")
    end

    local flights = {}
    for name in pairs(MeridianScoutFlights or {}) do
        table.insert(flights, name)
    end
    table.sort(flights)

    local _, race = UnitRace("player")
    local _, class = UnitClass("player")
    local lines = {
        string.format(
            "%s-%s|L%d|%d/%d|%s|%s|%s|%s",
            UnitName("player") or "Unknown",
            GetRealmName() or "",
            UnitLevel("player") or 0,
            UnitXP("player") or 0,
            UnitXPMax("player") or 0,
            UnitFactionGroup("player") or "",
            race or "",
            class or "",
            GetRealZoneText() or ""
        )
    }

    local expanded = {}
    local totalEntries = GetNumEntries()
    for i = totalEntries, 1, -1 do
        local heading, _, isHeader, isCollapsed = GetEntryInfo(i)
        if isHeader and isCollapsed and heading then
            expanded[heading] = true
            if ExpandQuestHeader then ExpandQuestHeader(i) end
        end
    end

    totalEntries = GetNumEntries()
    for i = 1, totalEntries do
        local title, level, isHeader, _, isComplete, questID = GetEntryInfo(i)
        if not isHeader and questID and questID > 0 then
            local objText = GetObjectivesText(i, questID)
            table.insert(lines, string.format("Q:%d:%d:%d:%s | %s",
                questID, level, isComplete and 1 or 0, title or "", objText))
        end
    end

    totalEntries = GetNumEntries()
    for i = totalEntries, 1, -1 do
        local heading, _, isHeader = GetEntryInfo(i)
        if isHeader and heading and expanded[heading] then
            if CollapseQuestHeader then CollapseQuestHeader(i) end
        end
    end

    if C_QuestLog and C_QuestLog.GetAllCompletedQuestIDs then
        local done = C_QuestLog.GetAllCompletedQuestIDs()
        if done then
            table.sort(done)
            table.insert(lines, "DONE(" .. #done .. "):" .. table.concat(done, ","))
        end
    end

    local bindLoc = GetBindLocation and GetBindLocation() or "unknown"
    local subZone = GetSubZoneText and GetSubZoneText() or ""
    local coords = p and string.format("%.2f,%.2f", 100 * p.x, 100 * p.y) or "coordinates unavailable"
    table.insert(lines, "BIND: " .. bindLoc)
    table.insert(lines, "POSITION: " .. (map or "?") .. " " .. subZone .. " " .. coords)
    table.insert(lines, "OBSERVED TAXIS: " .. table.concat(flights, " | "))

    if not window then
        window = CreateFrame("Frame", "MeridianScoutExport", UIParent, "BasicFrameTemplateWithInset")
        window:SetSize(560, 390)
        window:SetPoint("CENTER")
        window:SetFrameStrata("DIALOG")
        window.TitleText:SetText("Meridian Scout  -  Ctrl+A, Ctrl+C to copy")
        local scroll = CreateFrame("ScrollFrame", nil, window, "UIPanelScrollFrameTemplate")
        scroll:SetPoint("TOPLEFT", 14, -34)
        scroll:SetPoint("BOTTOMRIGHT", -32, 14)
        box = CreateFrame("EditBox", nil, scroll)
        box:SetMultiLine(true)
        box:SetFontObject(ChatFontNormal)
        box:SetWidth(505)
        box:SetAutoFocus(false)
        scroll:SetScrollChild(box)
        box:SetScript("OnEscapePressed", function() window:Hide() end)
        if UISpecialFrames then
            table.insert(UISpecialFrames, "MeridianScoutExport")
        end
    end

    window:Show()
    box:SetText(table.concat(lines, "\n"))
    box:SetFocus()
    box:HighlightText()

    local chatFrame = SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME
    if chatFrame and chatFrame.AddMessage then
        chatFrame:AddMessage("Meridian Scout: export window opened (Ctrl+C to copy).")
    end
end

SLASH_MERIDIANSCOUT1 = "/meridianscout"
SlashCmdList.MERIDIANSCOUT = export
