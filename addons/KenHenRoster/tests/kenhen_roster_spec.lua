-- kenhen_roster_spec.lua -- Busted unit tests for KenHenRoster

local function makeWidget(frameType, name, parent)
    local w
    w = {
        _type = frameType,
        _name = name,
        _parent = parent,
        _shown = false,
        _text = "",
        _scripts = {},
        _events = {},
        _color = nil,
        _unit = nil,
        _rotation = nil,
        _zoom = nil,
        SetSize = function() end,
        SetPoint = function() end,
        SetAllPoints = function() end,
        SetFrameStrata = function() end,
        SetMovable = function() end,
        EnableMouse = function() end,
        EnableMouseWheel = function() end,
        RegisterForDrag = function() end,
        SetBackdrop = function() end,
        SetBackdropColor = function() end,
        SetBackdropBorderColor = function() end,
        SetText = function(self, txt) self._text = txt or "" end,
        GetText = function(self) return self._text end,
        SetTextColor = function() end,
        SetMultiLine = function() end,
        SetFontObject = function() end,
        SetWidth = function() end,
        SetAutoFocus = function() end,
        SetScrollChild = function() end,
        HighlightText = function() end,
        SetFocus = function() end,
        SetKeepModelOnHide = function() end,
        ClearModel = function() end,
        SetUnit = function(self, u) self._unit = u; return true end,
        SetRotation = function(self, r) self._rotation = r end,
        SetPortraitZoom = function(self, z) self._zoom = z end,
        Show = function(self) self._shown = true end,
        Hide = function(self)
            self._shown = false
            if self._scripts.OnHide then
                self._scripts.OnHide(self)
            end
        end,
        IsShown = function(self) return self._shown end,
        RegisterEvent = function(self, ev) self._events[ev] = true end,
        SetScript = function(self, ev, fn) self._scripts[ev] = fn end,
        GetScript = function(self, ev) return self._scripts[ev] end,
        CreateFontString = function()
            return {
                SetPoint = function() end,
                SetText = function() end,
                SetTextColor = function() end,
            }
        end,
        CreateTexture = function()
            local tex = {
                SetAllPoints = function() end,
                SetColorTexture = function(self, r, g, b, a)
                    self._color = { r, g, b, a }
                end,
            }
            return tex
        end,
    }
    if name and name ~= "" then
        _G[name] = w
    end
    return w
end

describe("KenHenRoster Addon", function()
    local ns
    local frames
    local chatMessages

    local function loadAddon()
        ns = {}
        frames = {}
        chatMessages = {}
        _G.KenHenRosterDB = nil
        _G.SlashCmdList = {}
        _G.UISpecialFrames = {}
        _G.UIParent = {}
        _G.ChatFontNormal = {}
        _G.BackdropTemplateMixin = {}
        _G.SELECTED_CHAT_FRAME = {
            AddMessage = function(_, msg)
                table.insert(chatMessages, msg)
            end,
        }
        _G.DEFAULT_CHAT_FRAME = _G.SELECTED_CHAT_FRAME

        _G.CreateFrame = function(frameType, name, parent)
            local f = makeWidget(frameType, name, parent)
            table.insert(frames, f)
            return f
        end

        _G.time = function() return 1794800000 end
        _G.GetBuildInfo = function() return "1.60.1", "70862", "Nov 2026", 16001 end
        _G.WOW_PROJECT_ID = 1
        _G.WOW_PROJECT_MAINLINE = 1
        _G.WOW_PROJECT_CLASSIC = 2
        _G.GetNormalizedRealmName = function() return "ClassicBetaPvE2" end
        _G.GetRealmName = function() return "ClassicBetaPvE2" end
        _G.UnitGUID = function() return "Player-16001-0001" end
        _G.UnitFullName = function() return "Aldric", "Windweaver" end
        _G.UnitName = function() return "Aldric" end
        _G.UnitLevel = function() return 16 end
        _G.UnitFactionGroup = function() return "Horde" end
        _G.UnitRace = function() return "Undead", "Scourge", 5 end
        _G.UnitClass = function() return "Warrior", "WARRIOR", 1 end
        _G.GetGuildInfo = function() return "Alting Guild", "Initiate" end
        _G.C_SpecializationInfo = nil
        _G.GetSpecialization = nil
        _G.GetSpecializationInfo = nil
        _G.GetAverageItemLevel = nil
        _G.C_EncodingUtil = nil
        _G.Enum = nil
        _G.issecretvalue = nil
        _G.canaccessvalue = nil

        local chunk = assert(loadfile("addons/KenHenRoster/KenHenRoster.lua"))
        chunk("KenHenRoster", ns)
    end

    before_each(function()
        loadAddon()
    end)

    it("detects WoW: Forever flavor even when WOW_PROJECT_ID equals MAINLINE", function()
        assert.are.equal("forever", ns.DetectFlavor())

        _G.GetBuildInfo = function() return "12.0.1", "65000", "Nov 2026", 120105 end
        assert.are.equal("retail", ns.DetectFlavor())

        _G.WOW_PROJECT_ID = _G.WOW_PROJECT_CLASSIC
        _G.GetBuildInfo = function() return "1.15.8", "63000", "Nov 2026", 11508 end
        assert.are.equal("classic-era", ns.DetectFlavor())
    end)

    it("captures Forever surname cleanly even when GetNormalizedRealmName is non-empty", function()
        ns.CapturePlayerCharacter()
        local rec = _G.KenHenRosterDB.chars["Player-16001-0001"]
        assert.is_table(rec)
        assert.are.equal("Aldric", rec.name)
        assert.are.equal("Windweaver", rec.surname)
        assert.are.equal("Aldric Windweaver", rec.fullName)
        assert.are.equal(16, rec.level)
        assert.are.equal("Horde", rec.faction)
        assert.are.equal("Undead", rec.race)
        assert.are.equal("WARRIOR", rec.classFile)
        assert.are.equal("Alting Guild", rec.guild)
    end)

    it("does not mistake matching realm slug for a surname on standard realms", function()
        _G.UnitFullName = function() return "Thrall", "Area52" end
        _G.UnitName = function() return "Thrall" end
        _G.GetNormalizedRealmName = function() return "Area52" end
        _G.GetBuildInfo = function() return "12.0.1", "65000", "Nov 2026", 120105 end

        ns.CapturePlayerCharacter()
        local rec = _G.KenHenRosterDB.chars["Player-16001-0001"]
        assert.are.equal("Thrall", rec.name)
        assert.is_nil(rec.surname)
        assert.are.equal("Thrall", rec.fullName)
    end)

    it("encodes compressed KHR1 payloads using C_EncodingUtil enums when available and falls back to JSON", function()
        local jsonStr, countJson = ns.BuildExportString(false)
        assert.are.equal(1, countJson)
        assert.is_truthy(jsonStr:find('"fullName":"Aldric Windweaver"', 1, true))

        local compressCalls = {}
        local encodeCalls = {}
        _G.Enum = {
            CompressionMethod = { Deflate = 0 },
            CompressionLevel = { Default = 0, OptimizeForSize = 2 },
            Base64Variant = { Standard = 0 },
        }
        _G.C_EncodingUtil = {
            SerializeJSON = function() return '{"v":1,"chars":[]}' end,
            CompressString = function(src, method, level)
                table.insert(compressCalls, { src = src, method = method, level = level })
                return "compressed-bytes"
            end,
            EncodeBase64 = function(bytes, variant)
                table.insert(encodeCalls, { bytes = bytes, variant = variant })
                return "QUJDREVGRw=="
            end,
        }

        local khrStr, countKhr = ns.BuildExportString(false)
        assert.are.equal(1, countKhr)
        assert.are.equal("KHR1:QUJDREVGRw==", khrStr)
        assert.are.equal(0, compressCalls[1].method)
        assert.are.equal(2, compressCalls[1].level)
        assert.are.equal(0, encodeCalls[1].variant)
    end)

    it("opens export or chroma studio via /khr without keeping an idle OnUpdate handler", function()
        assert.is_function(_G.SlashCmdList.KENHENROSTER)
        _G.SlashCmdList.KENHENROSTER("")
        assert.is_true(_G.KenHenRosterExportFrame:IsShown())
        assert.is_true(#chatMessages >= 1)

        _G.SlashCmdList.KENHENROSTER("studio")
        local studio = _G.KenHenRosterStudioFrame
        assert.is_true(studio:IsShown())
        assert.is_nil(studio:GetScript("OnUpdate"))

        studio:GetScript("OnMouseDown")(studio, "LeftButton")
        assert.is_function(studio:GetScript("OnUpdate"))

        studio:GetScript("OnMouseUp")(studio, "LeftButton")
        assert.is_nil(studio:GetScript("OnUpdate"))
    end)
end)
