-- taint_safety_spec.lua -- Regression tests for WoW 12.x / Forever (16001) taint avoidance

local helper
local ok, res = pcall(require, "tests.test_helper")
if ok then
    helper = res
else
    helper = require("addons.GoldFinder.tests.test_helper")
end

local function CreateMockFontString()
    local fs = {
        text = "",
        shown = true,
        ClearAllPoints = function() end,
        SetPoint = function() end,
        SetAllPoints = function() end,
        SetSize = function() end,
        SetWidth = function() end,
        SetHeight = function() end,
        SetJustifyH = function() end,
        SetJustifyV = function() end,
        SetTextColor = function() end,
        SetAlpha = function() end,
        GetAlpha = function() return 1 end,
        SetWordWrap = function() end,
        SetText = function(self, txt) self.text = txt or "" end,
        GetText = function(self) return self.text end,
        GetStringWidth = function(self) return #(self.text or "") * 6 end,
        Show = function(self) self.shown = true end,
        Hide = function(self) self.shown = false end,
        SetShown = function(self, s) self.shown = s == true end,
        IsShown = function(self) return self.shown end,
    }
    return fs
end

local function CreateMockTexture()
    return {
        shown = true,
        SetAllPoints = function() end,
        SetPoint = function() end,
        ClearAllPoints = function() end,
        SetSize = function() end,
        SetWidth = function() end,
        SetHeight = function() end,
        SetColorTexture = function() end,
        SetTexture = function() end,
        SetTexCoord = function() end,
        SetVertexColor = function() end,
        SetBlendMode = function() end,
        SetAlpha = function() end,
        GetAlpha = function() return 1 end,
        Show = function(self) self.shown = true end,
        Hide = function(self) self.shown = false end,
        SetShown = function(self, s) self.shown = s == true end,
        IsShown = function(self) return self.shown end,
    }
end

local function CreateRichMockFrame(frameType, name, parent)
    local scripts = {}
    local events = {}
    local f
    f = {
        frameType = frameType,
        name = name,
        parent = parent,
        shown = true,
        enabled = true,
        text = "",
        strata = "MEDIUM",
        level = 1,
        width = 800,
        height = 600,
        value = 0,
        Instructions = CreateMockFontString(),
        GetParent = function(self) return self.parent end,
        SetParent = function(self, p) self.parent = p end,
        Show = function(self)
            self.shown = true
            if scripts.OnShow then scripts.OnShow(self) end
        end,
        Hide = function(self)
            self.shown = false
            if scripts.OnHide then scripts.OnHide(self) end
        end,
        IsShown = function(self) return self.shown end,
        SetShown = function(self, s) if s then self:Show() else self:Hide() end end,
        Enable = function(self) self.enabled = true end,
        Disable = function(self) self.enabled = false end,
        SetEnabled = function(self, e) self.enabled = e end,
        IsEnabled = function(self) return self.enabled end,
        SetAlpha = function() end,
        GetAlpha = function() return 1 end,
        SetSize = function(self, w, h) self.width = w; self.height = h end,
        SetWidth = function(self, w) self.width = w end,
        SetHeight = function(self, h) self.height = h end,
        GetWidth = function(self) return self.width end,
        GetHeight = function(self) return self.height end,
        SetPoint = function() end,
        ClearAllPoints = function() end,
        SetAllPoints = function() end,
        SetFrameStrata = function(self, s) self.strata = s end,
        GetFrameStrata = function(self) return self.strata end,
        SetFrameLevel = function(self, lvl) self.level = lvl end,
        GetFrameLevel = function(self) return self.level end,
        SetToplevel = function() end,
        Raise = function() end,
        EnableMouse = function() end,
        SetMovable = function() end,
        RegisterForDrag = function() end,
        RegisterForClicks = function() end,
        SetClipsChildren = function() end,
        SetBackdrop = function() end,
        SetBackdropColor = function() end,
        SetBackdropBorderColor = function() end,
        SetText = function(self, txt) self.text = txt or "" end,
        GetText = function(self) return self.text end,
        SetFontObject = function() end,
        SetNormalFontObject = function() end,
        SetHighlightFontObject = function() end,
        SetNormalTexture = function() end,
        SetHighlightTexture = function() end,
        SetChecked = function(self, c) self.checked = c end,
        GetChecked = function(self) return self.checked end,
        SetAutoFocus = function() end,
        ClearFocus = function() end,
        SetNumeric = function() end,
        SetMaxLetters = function() end,
        SetMinMaxValues = function() end,
        SetValue = function(self, v) self.value = v end,
        GetValue = function(self) return self.value end,
        SetValueStep = function() end,
        SetObeyStepOnDrag = function() end,
        SetOrientation = function() end,
        SetScrollChild = function() end,
        SetVerticalScroll = function() end,
        GetVerticalScroll = function() return 0 end,
        SetStatusBarTexture = function() end,
        SetStatusBarColor = function() end,
        CreateFontString = function()
            local fs = CreateMockFontString()
            return fs
        end,
        CreateTexture = function()
            return CreateMockTexture()
        end,
        SetScript = function(self, event, fn)
            scripts[event] = fn
        end,
        GetScript = function(self, event)
            return scripts[event]
        end,
        HookScript = function(self, event, fn)
            local prev = scripts[event]
            scripts[event] = function(...)
                if prev then prev(...) end
                fn(...)
            end
        end,
        HasScript = function() return true end,
        RegisterEvent = function(self, ev) events[ev] = true end,
        UnregisterEvent = function(self, ev) events[ev] = nil end,
        IsEventRegistered = function(self, ev) return events[ev] == true end,
        FireEvent = function(self, ev, ...)
            if events[ev] and scripts.OnEvent then
                scripts.OnEvent(self, ev, ...)
            end
        end,
        FireScript = function(self, scriptName, ...)
            if scripts[scriptName] then
                return scripts[scriptName](self, ...)
            end
        end,
        FireClick = function(self, button)
            if scripts.OnClick then
                scripts.OnClick(self, button or "LeftButton")
            end
        end,
    }
    if name and name ~= "" then
        _G[name] = f
    end
    return f
end

local function WithSavedGlobals(keys, fn)
    local saved = {}
    for _, k in ipairs(keys) do
        saved[k] = _G[k]
    end
    local okCall, err = pcall(fn)
    for _, k in ipairs(keys) do
        _G[k] = saved[k]
    end
    if not okCall then
        error(err, 2)
    end
end

describe("GoldFinder Taint Safety & Forever 16001 Fixes", function()
    local trackedGlobals = {
        "UIParent", "CreateFrame", "hooksecurefunc", "GameTooltip", "ItemRefTooltip",
        "TooltipDataProcessor", "Enum", "issecretvalue", "MailFrame", "InboxFrame",
        "GoldFinderMailCollectBtn", "ProfessionsFrame", "TradeSkillFrame",
        "GoldFinderTradeSkillBadgeFrame", "C_TradeSkillUI", "AuctionHouseFrame",
        "GoldFinderAuctionTabPanel", "C_AuctionHouse", "C_Item", "LibStub",
        "SettingsPanel", "HideUIPanel", "C_RestrictedActions", "InCombatLockdown",
        "FCF_OpenNewWindow", "DEFAULT_CHAT_FRAME", "IsShiftKeyDown", "IsControlKeyDown", "IsAltKeyDown", "EventRegistry",
        "SearchBoxTemplate_OnTextChanged", "C_CurrencyInfo",
    }

    before_each(function()
        helper.reset()
        _G.hooksecurefunc = function(tbl, methodName, hookFn)
            local targetTbl = tbl
            local key = methodName
            if type(tbl) == "string" then
                targetTbl = _G
                key = tbl
                hookFn = methodName
            end
            local orig = targetTbl[key]
            targetTbl[key] = function(...)
                local r1, r2, r3, r4
                if orig then
                    r1, r2, r3, r4 = orig(...)
                end
                hookFn(...)
                return r1, r2, r3, r4
            end
        end
    end)

    describe("Tooltip.lua", function()
        it("uses TooltipDataProcessor exclusively and skips forbidden/secret tooltips", function()
            WithSavedGlobals(trackedGlobals, function()
                local postCallback
                local hookScriptCalls = 0
                local addedLines = 0
                local getItemCalls = 0

                _G.Enum = { TooltipDataType = { Item = 0 } }
                _G.TooltipDataProcessor = {
                    AddTooltipPostCall = function(dataType, cb)
                        assert.are.equal(0, dataType)
                        postCallback = cb
                    end,
                }
                _G.GameTooltip = {
                    HookScript = function() hookScriptCalls = hookScriptCalls + 1 end,
                    HasScript = function() return true end,
                    IsForbidden = function() return false end,
                    GetItem = function() getItemCalls = getItemCalls + 1 return nil, nil end,
                    AddLine = function() addedLines = addedLines + 1 end,
                    AddDoubleLine = function() addedLines = addedLines + 1 end,
                }
                _G.ItemRefTooltip = {
                    HookScript = function() hookScriptCalls = hookScriptCalls + 1 end,
                    HasScript = function() return true end,
                    IsForbidden = function() return false end,
                    GetItem = function() return nil, nil end,
                    AddLine = function() addedLines = addedLines + 1 end,
                    AddDoubleLine = function() addedLines = addedLines + 1 end,
                }
                _G.issecretvalue = function(val) return val == "SECRET_ID" end

                local ns = helper.createNamespace()
                helper.loadAddonFile("Core.lua", ns)
                ns.db.items[2589] = { history = { { min = 500, t = 1700000000, seen = 1700000000 } } }
                helper.loadAddonFile("Tooltip.lua", ns)

                assert.is_function(postCallback)
                assert.are.equal(0, hookScriptCalls)

                -- Forbidden tooltip must be skipped without calling GetItem or AddLine
                local forbiddenTip = {
                    IsForbidden = function() return true end,
                    GetItem = function() getItemCalls = getItemCalls + 1 return nil, "item:2589" end,
                    AddLine = function() addedLines = addedLines + 1 end,
                }
                postCallback(forbiddenTip, { id = 2589 })
                assert.are.equal(0, getItemCalls)
                assert.are.equal(0, addedLines)

                -- Secret item id on GameTooltip must not error or touch lines
                postCallback(_G.GameTooltip, { id = "SECRET_ID" })
                assert.are.equal(0, addedLines)

                -- Non-forbidden GameTooltip with valid item id adds lines
                postCallback(_G.GameTooltip, { id = 2589 })
                assert.is_true(addedLines > 0)
            end)
        end)

        it("skips forbidden tooltips in legacy HookScript fallback", function()
            WithSavedGlobals(trackedGlobals, function()
                local hookedFn
                local getItemCalls = 0
                local addedLines = 0

                _G.TooltipDataProcessor = nil
                _G.Enum = nil
                _G.GameTooltip = {
                    HasScript = function(_, s) return s == "OnTooltipSetItem" end,
                    HookScript = function(_, s, fn)
                        if s == "OnTooltipSetItem" then hookedFn = fn end
                    end,
                }
                _G.ItemRefTooltip = {
                    HasScript = function() return false end,
                    HookScript = function() error("Should not hook when HasScript is false") end,
                }

                local ns = helper.createNamespace()
                helper.loadAddonFile("Core.lua", ns)
                helper.loadAddonFile("Tooltip.lua", ns)

                assert.is_function(hookedFn)
                hookedFn({
                    IsForbidden = function() return true end,
                    GetItem = function() getItemCalls = getItemCalls + 1 return nil, "item:2589" end,
                    AddLine = function() addedLines = addedLines + 1 end,
                })
                assert.are.equal(0, getItemCalls)
                assert.are.equal(0, addedLines)
            end)
        end)
    end)

    describe("Mail.lua", function()
        it("parents GoldFinderMailCollectBtn to UIParent and hides on Inbox/Mail hide", function()
            WithSavedGlobals(trackedGlobals, function()
                local createdFrames = {}
                _G.UIParent = CreateRichMockFrame("Frame", "UIParent")
                _G.MailFrame = CreateRichMockFrame("Frame", "MailFrame", _G.UIParent)
                _G.InboxFrame = CreateRichMockFrame("Frame", "InboxFrame", _G.MailFrame)
                _G.CreateFrame = function(ft, name, parent)
                    local f = CreateRichMockFrame(ft, name, parent)
                    createdFrames[#createdFrames + 1] = f
                    return f
                end

                local ns = helper.createNamespace()
                helper.loadAddonFile("Core.lua", ns)
                helper.loadAddonFile("Mail.lua", ns)

                -- Trigger MAIL_SHOW on the registered mail event frame
                local mailEventsFrame
                for _, f in ipairs(createdFrames) do
                    if f:IsEventRegistered("MAIL_SHOW") then
                        mailEventsFrame = f
                        break
                    end
                end
                assert.is_not_nil(mailEventsFrame)

                mailEventsFrame:FireEvent("MAIL_SHOW")
                local btn = _G.GoldFinderMailCollectBtn
                assert.is_not_nil(btn)
                assert.are.equal(_G.UIParent, btn:GetParent())
                assert.are.equal("HIGH", btn:GetFrameStrata())
                assert.is_true(btn:IsShown())

                -- Switching to Send Mail tab hides InboxFrame -> button hides cleanly
                _G.InboxFrame:Hide()
                assert.is_false(btn:IsShown())

                _G.InboxFrame:Show()
                assert.is_true(btn:IsShown())

                -- Closing MailFrame hides button even if InboxFrame itself isn't toggled
                _G.MailFrame:Hide()
                assert.is_false(btn:IsShown())
            end)
        end)
    end)

    describe("BuyHelper.lua", function()
        it("parents TradeSkill badge to UIParent without mutating ProfessionsFrame", function()
            WithSavedGlobals(trackedGlobals, function()
                local createdFrames = {}
                local profCreateFontStringCalls = 0

                _G.UIParent = CreateRichMockFrame("Frame", "UIParent")
                _G.CreateFrame = function(ft, name, parent)
                    local f = CreateRichMockFrame(ft, name, parent)
                    createdFrames[#createdFrames + 1] = f
                    return f
                end
                _G.ProfessionsFrame = CreateRichMockFrame("Frame", "ProfessionsFrame", _G.UIParent)
                _G.ProfessionsFrame.CreateFontString = function()
                    profCreateFontStringCalls = profCreateFontStringCalls + 1
                    return CreateMockFontString()
                end
                _G.C_TradeSkillUI = {
                    GetRecipeSchematic = function()
                        return { outputItemID = 2592, quantityMin = 1, reagentSlotSchematics = {} }
                    end,
                }

                local ns = helper.createNamespace()
                helper.loadAddonFile("Core.lua", ns)
                helper.loadAddonFile("BuyHelper.lua", ns)

                local tsWatcher
                for _, f in ipairs(createdFrames) do
                    if f:IsEventRegistered("TRADE_SKILL_SHOW") then
                        tsWatcher = f
                        break
                    end
                end
                assert.is_not_nil(tsWatcher)

                tsWatcher:FireEvent("TRADE_SKILL_SHOW")
                _G.C_TradeSkillUI.GetRecipeSchematic(1001, false)

                assert.are.equal(0, profCreateFontStringCalls)
                local badgeFrame = _G.GoldFinderTradeSkillBadgeFrame
                assert.is_not_nil(badgeFrame)
                assert.are.equal(_G.UIParent, badgeFrame:GetParent())
                assert.are.equal("HIGH", badgeFrame:GetFrameStrata())
                assert.is_true(badgeFrame:IsShown())

                -- Hiding ProfessionsFrame hides the standalone badge
                _G.ProfessionsFrame:Hide()
                assert.is_false(badgeFrame:IsShown())

                -- Re-show then close via TRADE_SKILL_CLOSE
                _G.ProfessionsFrame:Show()
                _G.C_TradeSkillUI.GetRecipeSchematic(1002, false)
                assert.is_true(badgeFrame:IsShown())
                tsWatcher:FireEvent("TRADE_SKILL_CLOSE")
                assert.is_false(badgeFrame:IsShown())
            end)
        end)
    end)

    describe("Tab.lua", function()
        it("parents panel to UIParent, preserves 4 GetCartTotals returns, and avoids Tabs[1]:Click in OpenInBuy", function()
            WithSavedGlobals(trackedGlobals, function()
                local createdFrames = {}
                local registeredPanels = {}
                local buyTabClicks = 0
                local selectBrowseCalls = {}
                local searchQueryCalls = {}
                local tooltipLines = {}

                _G.UIParent = CreateRichMockFrame("Frame", "UIParent")
                _G.CreateFrame = function(ft, name, parent)
                    local f = CreateRichMockFrame(ft, name, parent)
                    createdFrames[#createdFrames + 1] = f
                    return f
                end
                _G.SearchBoxTemplate_OnTextChanged = function() end
                _G.IsShiftKeyDown = function() return false end
                _G.IsControlKeyDown = function() return false end
                _G.IsAltKeyDown = function() return false end
                _G.GameTooltip = {
                    SetOwner = function() end,
                    SetText = function() tooltipLines = {} end,
                    AddLine = function(_, line) tooltipLines[#tooltipLines + 1] = tostring(line) end,
                    AddDoubleLine = function(_, k, v)
                        tooltipLines[#tooltipLines + 1] = tostring(k) .. " " .. tostring(v)
                    end,
                    Show = function() end,
                    Hide = function() end,
                }
                _G.C_Item = {
                    GetItemInfo = function(id) return "Item " .. tostring(id), nil, 1 end,
                    GetItemIconByID = function() return 134400 end,
                    GetItemCount = function() return 0 end,
                    RequestLoadItemDataByID = function() end,
                }
                _G.C_AuctionHouse = {
                    MakeItemKey = function(id) return { itemID = id, itemLevel = 0, itemSuffix = 0 } end,
                    GetItemKeyInfo = function(key)
                        return { itemName = "Linen Cloth", iconFileID = 134400, quality = 1, isCommodity = true, itemID = key.itemID }
                    end,
                    SendSearchQuery = function(key, sorts, separate)
                        searchQueryCalls[#searchQueryCalls + 1] = { key = key, sorts = sorts, separate = separate }
                    end,
                }
                _G.AuctionHouseFrame = CreateRichMockFrame("Frame", "AuctionHouseFrame", _G.UIParent)
                _G.AuctionHouseFrame.Tabs = {
                    { Click = function() buyTabClicks = buyTabClicks + 1 end },
                }
                _G.AuctionHouseFrame.SelectBrowseResult = function(_, info)
                    selectBrowseCalls[#selectBrowseCalls + 1] = info
                end
                local registeredList = {}
                local function getMockLibAH()
                    return {
                        DoesIDExist = function(_, id) return registeredPanels[id] ~= nil end,
                        CreateTab = function(_, id, frame)
                            registeredPanels[id] = frame
                            registeredList[#registeredList + 1] = { id = id, frame = frame }
                        end,
                    }
                end
                _G.LibStub = setmetatable({
                    GetLibrary = function(arg1, arg2)
                        local libName = (type(arg1) == "string") and arg1 or arg2
                        if libName == "LibAHTab-1-0" then
                            return getMockLibAH()
                        end
                        return nil
                    end,
                }, {
                    __call = function(_, libName)
                        if libName == "LibAHTab-1-0" then
                            return getMockLibAH()
                        end
                        return nil
                    end,
                })

                local ns = helper.createNamespace()
                helper.loadAddonFile("Localization.lua", ns)
                helper.loadAddonFile("Core.lua", ns)
                helper.loadAddonFile("Deals.lua", ns)
                helper.loadAddonFile("Tab.lua", ns)

                -- Provide a live deal in cache and cart totals returning 4 values
                local dealKey = { itemID = 2589, itemLevel = 0, itemSuffix = 0 }
                ns.lastDeals = {
                    {
                        itemID = 2589,
                        name = "Linen Cloth",
                        now = 50,
                        typical = 200,
                        qty = 20,
                        netUnitProfit = 140,
                        totalNetProfit = 2800,
                        below = 0.75,
                        dropPct = 75,
                        samples = 10,
                        itemKey = dealKey,
                    },
                }
                ns.FindDeals = function()
                    return ns.lastDeals, { items = 1, judged = 1, needMore = 0, fewestMissing = 0 }
                end
                ns.ScanStatus = function() return { count = 1, lifetime = 1, footer = "1 scan", status = "Ready" } end
                ns.GetCartTotals = function() return 2, 15, 300, 120 end

                local ahEventsFrame
                for _, f in ipairs(createdFrames) do
                    if f:IsEventRegistered("AUCTION_HOUSE_SHOW") then
                        ahEventsFrame = f
                        break
                    end
                end
                assert.is_not_nil(ahEventsFrame)

                ahEventsFrame:FireEvent("AUCTION_HOUSE_SHOW")

                local reg = registeredList[1]
                assert.is_not_nil(reg)
                assert.are.equal("GoldFinder", reg.id)
                local panel = reg.frame
                assert.is_not_nil(panel)
                assert.are.equal(_G.UIParent, panel:GetParent())
                assert.are.equal("HIGH", panel:GetFrameStrata())
                assert.is_false(panel:IsShown())

                panel:Show()
                assert.is_true(panel:IsShown())
                assert.are.equal("HIGH", panel:GetFrameStrata())
                assert.are.equal("DIALOG", ns.GetOverlayStrata({ GetFrameStrata = function() return "HIGH" end }))

                -- Closing AuctionHouseFrame hides standalone panel
                _G.AuctionHouseFrame:Hide()
                assert.is_false(panel:IsShown())

                -- Reopen panel and verify Cart button tooltip preserves all 4 GetCartTotals returns
                panel:Show()
                local cartBtn
                for _, f in ipairs(createdFrames) do
                    if f.frameType == "Button" and (f:GetText() or ""):find("Cart") then
                        cartBtn = f
                        break
                    end
                end
                assert.is_not_nil(cartBtn)
                cartBtn:FireScript("OnEnter")
                local joined = table.concat(tooltipLines, "\n")
                assert.is_not_nil(joined:find("2", 1, true), "expected cart count in tooltip: " .. joined)
                assert.is_not_nil(joined:find("15", 1, true), "expected non-truncated item count in tooltip: " .. joined)
                assert.is_not_nil(joined:find(ns.Money(300), 1, true), "expected non-truncated cost in tooltip: " .. joined)
                assert.is_not_nil(joined:find(ns.Money(120), 1, true), "expected non-truncated profit in tooltip: " .. joined)

                -- Verify row click executes OpenInBuy without clicking Tabs[1] and calls SendSearchQuery
                local dealRowBtn
                local clickScriptName
                local framesWithDeal = 0
                for _, f in ipairs(createdFrames) do
                    if f.deal then
                        framesWithDeal = framesWithDeal + 1
                        if f:GetScript("OnClick") then
                            dealRowBtn = f
                            clickScriptName = "OnClick"
                            break
                        elseif f:GetScript("OnMouseUp") then
                            dealRowBtn = f
                            clickScriptName = "OnMouseUp"
                            break
                        end
                    end
                end
                assert.is_not_nil(dealRowBtn, ("no dealRowBtn (activeCat=%s, framesWithDeal=%d)"):format(
                    tostring(ns.GetActiveCategory and ns.GetActiveCategory()), framesWithDeal))
                dealRowBtn:FireScript(clickScriptName, "LeftButton")
                assert.are.equal(0, buyTabClicks)
                assert.are.equal(1, #selectBrowseCalls)
                assert.are.equal(dealKey, selectBrowseCalls[1].itemKey)
                assert.are.equal(1, #searchQueryCalls)
                assert.are.equal(dealKey, searchQueryCalls[1].key)
                assert.is_false(searchQueryCalls[1].separate)
                assert.is_false(panel:IsShown())
            end)
        end)
    end)

    describe("Config.lua, Core.lua, Broker.lua", function()
        it("Config.ToggleConfig never calls HideUIPanel or SettingsPanel:Hide", function()
            WithSavedGlobals(trackedGlobals, function()
                local hideUIPanelCalls = 0
                local settingsHideCalls = 0
                _G.HideUIPanel = function() hideUIPanelCalls = hideUIPanelCalls + 1 end
                _G.SettingsPanel = {
                    IsShown = function() return true end,
                    Hide = function() settingsHideCalls = settingsHideCalls + 1 end,
                }

                local ns = helper.createNamespace()
                helper.loadAddonFile("Localization.lua", ns)
                helper.loadAddonFile("Core.lua", ns)
                helper.loadAddonFile("Config.lua", ns)
                ns.settingsCategory = { ID = 99 }

                ns.ToggleConfig()
                assert.are.equal(0, hideUIPanelCalls)
                assert.are.equal(0, settingsHideCalls)
            end)
        end)

        it("Core.GetOrCreateChatWindow skips FCF_OpenNewWindow during combat lockdown", function()
            WithSavedGlobals(trackedGlobals, function()
                local openCalls = 0
                local fallbackFrame = { name = "DefaultChat" }
                _G.DEFAULT_CHAT_FRAME = fallbackFrame
                _G.InCombatLockdown = function() return true end
                _G.FCF_OpenNewWindow = function()
                    openCalls = openCalls + 1
                    return { name = "GoldFinder" }
                end

                local ns = helper.createNamespace()
                helper.loadAddonFile("Core.lua", ns)

                local frame = ns.GetOrCreateChatWindow("GoldFinder")
                assert.are.equal(0, openCalls)
                assert.are.equal(fallbackFrame, frame)
            end)
        end)

        it("Broker OnClick calls LibAHTab:SetSelected via LibStub instead of undefined LibAHTab:SetSelectedTab", function()
            WithSavedGlobals(trackedGlobals, function()
                local ldbSpec
                local selectedTabArg
                local libAHObj = {
                    SetSelected = function(self, tabID)
                        assert.is_not_nil(self)
                        selectedTabArg = tabID
                    end,
                }
                local createdFrames = {}
                _G.CreateFrame = function(ft, name, parent)
                    local f = CreateRichMockFrame(ft, name, parent)
                    createdFrames[#createdFrames + 1] = f
                    return f
                end
                local function lookupLib(arg1, arg2)
                    local name = (type(arg1) == "string") and arg1 or arg2
                    if name == "LibDataBroker-1.1" then
                        return {
                            NewDataObject = function(_, _, spec)
                                ldbSpec = spec
                                return spec
                            end,
                        }
                    elseif name == "LibAHTab-1-0" then
                        return libAHObj
                    end
                    return nil
                end
                _G.LibStub = setmetatable({
                    GetLibrary = function(arg1, arg2) return lookupLib(arg1, arg2) end,
                }, {
                    __call = function(_, name) return lookupLib(name) end,
                })
                _G.AuctionHouseFrame = { IsShown = function() return true end }
                _G.IsShiftKeyDown = function() return false end

                local ns = helper.createNamespace()
                helper.loadAddonFile("Core.lua", ns)
                helper.loadAddonFile("Broker.lua", ns)

                for _, f in ipairs(createdFrames) do
                    if f:IsEventRegistered("ADDON_LOADED") then
                        f:FireEvent("ADDON_LOADED", "GoldFinder")
                    end
                    if f:IsEventRegistered("PLAYER_LOGIN") then
                        f:FireEvent("PLAYER_LOGIN")
                    end
                end

                assert.is_not_nil(ldbSpec)
                ldbSpec:OnClick("LeftButton")
                assert.are.equal("GoldFinder", selectedTabArg)
            end)
        end)
    end)
end)
