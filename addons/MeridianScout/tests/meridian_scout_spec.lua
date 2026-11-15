-- meridian_scout_spec.lua -- Busted unit tests for MeridianScout on WoW: Forever (16001)
-- Verifies compatibility when legacy globals GetNumQuestLogEntries / GetQuestLogTitle are nil
-- and validates quest, bind, coordinate, and observed taxi output.

local function makeWidget(name, opts)
    local w = {
        _name = name,
        _shown = false,
        _text = "",
        _scripts = {},
        TitleText = { SetText = function(self, txt) self._text = txt end },
    }
    if opts then
        for k, v in pairs(opts) do w[k] = v end
    end
    function w:RegisterEvent() end
    function w:SetScript(ev, fn) self._scripts[ev] = fn end
    function w:SetSize() end
    function w:SetPoint() end
    function w:SetFrameStrata() end
    function w:SetMultiLine() end
    function w:SetFontObject() end
    function w:SetWidth() end
    function w:SetAutoFocus() end
    function w:SetScrollChild() end
    function w:Show() self._shown = true end
    function w:Hide() self._shown = false end
    function w:IsShown() return self._shown end
    function w:SetText(txt) self._text = txt end
    function w:GetText() return self._text end
    function w:SetFocus() end
    function w:HighlightText() end
    return w
end

describe("MeridianScout Addon", function()
    local createdFrames
    local eventFrame
    local printedMessages
    local expandedCalls
    local collapsedCalls

    before_each(function()
        createdFrames = {}
        eventFrame = nil
        printedMessages = {}
        expandedCalls = {}
        collapsedCalls = {}

        _G.MeridianScoutFlights = nil
        _G.SlashCmdList = {}
        _G.UISpecialFrames = {}
        _G.UIParent = {}
        _G.ChatFontNormal = {}
        _G.DEFAULT_CHAT_FRAME = {
            AddMessage = function(_, msg) table.insert(printedMessages, msg) end,
        }
        _G.SELECTED_CHAT_FRAME = _G.DEFAULT_CHAT_FRAME

        _G.CreateFrame = function(_, name)
            local f = makeWidget(name)
            table.insert(createdFrames, f)
            if not eventFrame then
                eventFrame = f
            end
            return f
        end

        -- Emulate WoW: Forever where GetNumQuestLogEntries and GetQuestLogTitle are removed from _G
        _G.GetNumQuestLogEntries = nil
        _G.GetQuestLogTitle = nil

        _G.C_Timer = {
            After = function(_, fn) fn() end,
        }

        _G.TaxiFrame = { IsShown = function() return true end }
        _G.NumTaxiNodes = function() return 3 end
        _G.TaxiNodeGetType = function(i)
            return ({ "CURRENT", "REACHABLE", "NONE" })[i]
        end
        _G.TaxiNodeName = function(i)
            return ({ "Orgrimmar, Durotar", "Crossroads, The Barrens", "Thunder Bluff, Mulgore" })[i]
        end

        _G.UnitName = function() return "Jakob" end
        _G.GetRealmName = function() return "Forever" end
        _G.UnitLevel = function() return 24 end
        _G.UnitXP = function() return 12000 end
        _G.UnitXPMax = function() return 28900 end
        _G.UnitFactionGroup = function() return "Horde" end
        _G.UnitRace = function() return "Orc", "Orc" end
        _G.UnitClass = function() return "Warrior", "WARRIOR" end
        _G.GetRealZoneText = function() return "The Barrens" end
        _G.GetSubZoneText = function() return "Crossroads" end
        _G.GetBindLocation = function() return "Crossroads" end

        _G.C_Map = {
            GetBestMapForUnit = function() return 1413 end,
            GetPlayerMapPosition = function() return { x = 0.515, y = 0.304 } end,
        }

        local entries = {
            { title = "The Barrens", level = 0, isHeader = true, isCollapsed = true, questID = 0 },
            { title = "Raptor Thieves", level = 13, isHeader = false, isCollapsed = false, questID = 869 },
        }
        _G.ExpandQuestHeader = function(idx)
            table.insert(expandedCalls, idx)
            entries[idx].isCollapsed = false
        end
        _G.CollapseQuestHeader = function(idx)
            table.insert(collapsedCalls, idx)
            entries[idx].isCollapsed = true
        end
        _G.GetNumQuestLeaderBoards = function() return 1 end
        _G.GetQuestLogLeaderBoard = function() return "Raptor Heads: 4/12" end

        _G.C_QuestLog = {
            GetNumQuestLogEntries = function() return #entries, 1 end,
            GetInfo = function(idx) return entries[idx] end,
            IsComplete = function(qid) return qid == 999 end,
            GetQuestObjectives = function(qid)
                if qid == 869 then
                    return { { text = "Raptor Heads: 4/12" } }
                end
                return {}
            end,
            GetAllCompletedQuestIDs = function() return { 788, 789 } end,
        }

        assert(loadfile("addons/MeridianScout/MeridianScout.lua"))()
    end)

    it("exports character, quest log, completed IDs, bind, position, and observed taxis without legacy globals", function()
        assert.is_function(_G.SlashCmdList.MERIDIANSCOUT)
        _G.SlashCmdList.MERIDIANSCOUT()

        local editBox = createdFrames[4]
        assert.is_not_nil(editBox)
        local output = editBox:GetText()

        assert.is_truthy(output:find("Jakob-Forever|L24|12000/28900|Horde|Orc|WARRIOR|The Barrens", 1, true))
        assert.is_truthy(output:find("Q:869:13:0:Raptor Thieves | Raptor Heads: 4/12", 1, true))
        assert.is_truthy(output:find("DONE(2):788,789", 1, true))
        assert.is_truthy(output:find("BIND: Crossroads", 1, true))
        assert.is_truthy(output:find("POSITION: 1413 Crossroads 51.50,30.40", 1, true))
        assert.is_truthy(output:find("OBSERVED TAXIS: Crossroads, The Barrens | Orgrimmar, Durotar", 1, true))
        assert.is_nil(output:find("Thunder Bluff", 1, true))
        assert.are.same({ 1 }, expandedCalls)
        assert.are.same({ 1 }, collapsedCalls)
        assert.are.equal(1, #printedMessages)
    end)

    it("records flight nodes on TAXIMAP_OPENED across multiple openings", function()
        eventFrame._scripts.OnEvent()
        assert.is_true(_G.MeridianScoutFlights["Orgrimmar, Durotar"])
        assert.is_true(_G.MeridianScoutFlights["Crossroads, The Barrens"])
        assert.is_nil(_G.MeridianScoutFlights["Thunder Bluff, Mulgore"])
    end)
end)
