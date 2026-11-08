-- GoldFinder -- Profiles & Database Maintenance (#48, #49, #50)
-- Handles Base64 profile export/import, multi-account scan data merging,
-- and automated database vacuuming / compaction (< 2MB file size guarantee).

local ADDON, ns = ...

---------------------------------------------------------------------------
-- Pure Lua Base64 Engine (Fallback when C_EncodingUtil is absent)
---------------------------------------------------------------------------

local b64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local function LuaEncodeBase64(data)
    local bytes = { string.byte(data, 1, #data) }
    local result = {}
    local pad = (3 - (#bytes % 3)) % 3

    for i = 1, pad do bytes[#bytes + 1] = 0 end

    for i = 1, #bytes, 3 do
        local n = (bytes[i] * 65536) + (bytes[i + 1] * 256) + bytes[i + 2]
        result[#result + 1] = string.sub(b64chars, math.floor(n / 262144) % 64 + 1, math.floor(n / 262144) % 64 + 1)
        result[#result + 1] = string.sub(b64chars, math.floor(n / 4096) % 64 + 1, math.floor(n / 4096) % 64 + 1)
        result[#result + 1] = string.sub(b64chars, math.floor(n / 64) % 64 + 1, math.floor(n / 64) % 64 + 1)
        result[#result + 1] = string.sub(b64chars, n % 64 + 1, n % 64 + 1)
    end

    if pad == 1 then
        result[#result] = "="
    elseif pad == 2 then
        result[#result] = "="
        result[#result - 1] = "="
    end

    return table.concat(result)
end

local function LuaDecodeBase64(data)
    data = string.gsub(data, "[^A-Za-z0-9+/=]", "")
    local result = {}
    local pad = 0
    if string.sub(data, -2) == "==" then pad = 2
    elseif string.sub(data, -1) == "=" then pad = 1 end

    local b64lookup = {}
    for i = 1, 64 do
        b64lookup[string.byte(b64chars, i)] = i - 1
    end

    local cleanLen = #data - pad
    local i = 1
    while i <= cleanLen do
        local c1 = b64lookup[string.byte(data, i)] or 0
        local c2 = b64lookup[string.byte(data, i + 1)] or 0
        local c3 = b64lookup[string.byte(data, i + 2)] or 0
        local c4 = b64lookup[string.byte(data, i + 3)] or 0

        local n = (c1 * 262144) + (c2 * 4096) + (c3 * 64) + c4
        result[#result + 1] = string.char(math.floor(n / 65536) % 256)
        if (i + 2) <= cleanLen then
            result[#result + 1] = string.char(math.floor(n / 256) % 256)
        end
        if (i + 3) <= cleanLen then
            result[#result + 1] = string.char(n % 256)
        end
        i = i + 4
    end

    return table.concat(result)
end

---------------------------------------------------------------------------
-- Lightweight Table Serializer / Deserializer
---------------------------------------------------------------------------

local function SerializeVal(v)
    local t = type(v)
    if t == "number" or t == "boolean" then
        return tostring(v)
    elseif t == "string" then
        return string.format("%q", v)
    elseif t == "table" then
        local parts = {}
        for k, sub in pairs(v) do
            local kStr
            if type(k) == "number" then
                kStr = "[" .. k .. "]"
            elseif type(k) == "string" and k:match("^[%a_][%w_]*$") then
                kStr = k
            else
                kStr = "[" .. string.format("%q", tostring(k)) .. "]"
            end
            parts[#parts + 1] = kStr .. "=" .. SerializeVal(sub)
        end
        return "{" .. table.concat(parts, ",") .. "}"
    else
        return "nil"
    end
end

local function SafeDeserialize(str)
    if not str or str == "" then return nil end
    -- Only allow safe characters for deserializing table declarations
    if str:find("function") or str:find("while") or str:find("for") or str:find("repeat") then
        return nil, "Invalid or unsafe payload"
    end
    local fn, err = loadstring("return " .. str)
    if not fn then return nil, err end
    -- Sandbox environment
    setfenv(fn, {})
    local ok, res = pcall(fn)
    if not ok then return nil, res end
    return res
end

---------------------------------------------------------------------------
-- Base64 Profile Encode & Decode (Issue #48)
---------------------------------------------------------------------------

function ns.EncodeProfileString(payloadTable)
    local rawStr = nil
    if C_EncodingUtil and C_EncodingUtil.SerializeJSON then
        local ok, json = pcall(C_EncodingUtil.SerializeJSON, payloadTable)
        if ok and json then rawStr = json end
    end
    if not rawStr then
        rawStr = SerializeVal(payloadTable)
    end

    if C_EncodingUtil and C_EncodingUtil.EncodeBase64 then
        local ok, b64 = pcall(C_EncodingUtil.EncodeBase64, rawStr, Enum.Base64Variant.Standard)
        if ok and b64 then return "GF1:" .. b64 end
    end

    return "GF1:" .. LuaEncodeBase64(rawStr)
end

function ns.DecodeProfileString(encoded)
    if not encoded or type(encoded) ~= "string" then
        return nil, "Missing or invalid profile string."
    end
    encoded = encoded:match("^%s*(.-)%s*$")
    if not encoded:match("^GF1:") then
        return nil, "Invalid profile format. Profile strings must begin with 'GF1:'."
    end
    local b64 = encoded:sub(5)

    local raw = nil
    if C_EncodingUtil and C_EncodingUtil.DecodeBase64 then
        local ok, dec = pcall(C_EncodingUtil.DecodeBase64, b64, Enum.Base64Variant.Standard)
        if ok and dec then raw = dec end
    end
    if not raw then
        raw = LuaDecodeBase64(b64)
    end
    if not raw or raw == "" then
        return nil, "Failed to decode base64 profile payload."
    end

    -- Attempt JSON deserialize first
    if C_EncodingUtil and C_EncodingUtil.DeserializeJSON then
        local ok, tbl = pcall(C_EncodingUtil.DeserializeJSON, raw)
        if ok and type(tbl) == "table" then return tbl end
    end

    -- Fallback to Lua table deserialization
    local tbl, err = SafeDeserialize(raw)
    if type(tbl) == "table" then return tbl end
    return nil, err or "Could not parse decoded profile data."
end

---------------------------------------------------------------------------
-- Profile Data Export & Import Handlers (#48)
---------------------------------------------------------------------------

function ns.ExportProfile()
    local db = ns.db
    if not db then return nil, "Database not loaded." end

    local profile = {
        version = 1,
        addonVersion = ns.version or "0.9.0",
        created = GetServerTime(),
        realm = ns.GetActiveRealm and ns.GetActiveRealm() or "Default",
        settings = {},
        watchlist = {},
        customCategories = {},
        shoppingLists = {},
        restock = {},
    }

    -- Deep copy settings
    if db.settings then
        for k, v in pairs(db.settings) do
            if type(v) ~= "table" then
                profile.settings[k] = v
            end
        end
    end

    -- Copy watchlist
    if db.watchlist then
        for id, v in pairs(db.watchlist) do
            if v then profile.watchlist[id] = true end
        end
    end

    -- Copy custom categories
    if db.customCategories then
        for catId, cat in pairs(db.customCategories) do
            profile.customCategories[catId] = {
                label = cat.label or catId,
                items = {},
            }
            if cat.items then
                for itID, isMember in pairs(cat.items) do
                    if isMember then profile.customCategories[catId].items[itID] = true end
                end
            end
        end
    end

    -- Copy shopping lists
    if db.shoppingLists then
        for id, quota in pairs(db.shoppingLists) do
            profile.shoppingLists[id] = {
                target = quota.target or 0,
                maxPrice = quota.maxPrice or 0,
            }
        end
    end

    -- Copy restock targets
    if db.restock then
        for id, minQty in pairs(db.restock) do
            profile.restock[id] = minQty
        end
    end

    return ns.EncodeProfileString(profile)
end

function ns.ImportProfile(encodedStr, mergeMode)
    local profile, err = ns.DecodeProfileString(encodedStr)
    if not profile then
        return false, err
    end

    local db = ns.db
    if not db then return false, "Database not loaded." end
    db.settings = db.settings or {}
    db.watchlist = db.watchlist or {}
    db.customCategories = db.customCategories or {}
    db.shoppingLists = db.shoppingLists or {}
    db.restock = db.restock or {}

    -- Import settings
    if profile.settings then
        for k, v in pairs(profile.settings) do
            if mergeMode or db.settings[k] == nil then
                db.settings[k] = v
            else
                db.settings[k] = v
            end
        end
    end

    -- Import watchlist
    if profile.watchlist then
        if not mergeMode then
            wipe(db.watchlist)
        end
        for id, v in pairs(profile.watchlist) do
            local numID = tonumber(id) or id
            if v then db.watchlist[numID] = true end
        end
    end

    -- Import custom categories
    if profile.customCategories then
        if not mergeMode then
            wipe(db.customCategories)
        end
        for catId, cat in pairs(profile.customCategories) do
            db.customCategories[catId] = {
                label = cat.label or catId,
                items = {},
            }
            if cat.items then
                for itID, isMember in pairs(cat.items) do
                    local nID = tonumber(itID) or itID
                    if isMember then db.customCategories[catId].items[nID] = true end
                end
            end
        end
    end

    -- Import shopping lists
    if profile.shoppingLists then
        if not mergeMode then
            wipe(db.shoppingLists)
        end
        for id, quota in pairs(profile.shoppingLists) do
            local numID = tonumber(id) or id
            db.shoppingLists[numID] = {
                target = quota.target or 0,
                maxPrice = quota.maxPrice or 0,
            }
        end
    end

    -- Import restock safety levels
    if profile.restock then
        if not mergeMode then
            wipe(db.restock)
        end
        for id, minQty in pairs(profile.restock) do
            local numID = tonumber(id) or id
            db.restock[numID] = minQty
        end
    end

    if ns.RebuildCategoryButtons then ns.RebuildCategoryButtons() end
    if ns.RefreshControls then ns.RefreshControls() end
    if ns.RefreshPanel then ns.RefreshPanel() end

    return true, ("Successfully imported GoldFinder profile (v%s from realm %s)."):format(
        profile.addonVersion or "1.0", profile.realm or "Unknown")
end

---------------------------------------------------------------------------
-- Multi-Account Database Merger (#49)
---------------------------------------------------------------------------

function ns.MergeScanDatabase(externalData)
    local db = ns.db
    if not db then return false, "Active database not loaded." end
    if not externalData or type(externalData) ~= "table" then
        return false, "Invalid scan database structure."
    end

    local extItems = externalData.items or externalData
    if type(extItems) ~= "table" then return false, "No item price data found." end

    local mergedItems = 0
    local addedPoints = 0
    db.items = db.items or {}

    for itemID, rec in pairs(extItems) do
        local numID = tonumber(itemID)
        if numID and rec and rec.history and #rec.history > 0 then
            local localRec = db.items[numID]
            if not localRec then
                localRec = { name = rec.name, history = {} }
                db.items[numID] = localRec
                mergedItems = mergedItems + 1
            elseif rec.name and not localRec.name then
                localRec.name = rec.name
            end

            -- Build timestamp lookup of local history to deduplicate
            local seenTimes = {}
            for _, h in ipairs(localRec.history) do
                local t = h.seen or h.t or 0
                seenTimes[t] = true
            end

            for _, extH in ipairs(rec.history) do
                local extT = extH.seen or extH.t or 0
                local isDuplicate = false
                -- Check within 10-minute window
                for localT in pairs(seenTimes) do
                    if math.abs(localT - extT) < 600 then
                        isDuplicate = true
                        break
                    end
                end

                if not isDuplicate and (extH.min and extH.min > 0) then
                    localRec.history[#localRec.history + 1] = {
                        seen = extT,
                        min = extH.min,
                        vol = extH.vol or 1,
                    }
                    seenTimes[extT] = true
                    addedPoints = addedPoints + 1
                end
            end

            -- Sort history chronologically
            table.sort(localRec.history, function(a, b)
                return (a.seen or a.t or 0) < (b.seen or b.t or 0)
            end)
        end
    end

    -- Merge scan records
    local addedScans = 0
    if externalData.scans and type(externalData.scans) == "table" then
        db.scans = db.scans or {}
        local localScanTimes = {}
        for _, s in ipairs(db.scans) do
            localScanTimes[s.t or 0] = true
        end
        for _, s in ipairs(externalData.scans) do
            if s.t and not localScanTimes[s.t] then
                db.scans[#db.scans + 1] = s
                localScanTimes[s.t] = true
                addedScans = addedScans + 1
            end
        end
        table.sort(db.scans, function(a, b) return (a.t or 0) < (b.t or 0) end)
    end

    if ns.RefreshPanel then ns.RefreshPanel() end

    return true, ("Database merge complete: %d items touched, %d price points added, %d scans integrated."):format(
        mergedItems, addedPoints, addedScans)
end

---------------------------------------------------------------------------
-- Database Compaction & Auto-Vacuum Maintenance (#50)
---------------------------------------------------------------------------

function ns.VacuumDatabase(options)
    options = options or {}
    local retentionDays = options.retentionDays or 30
    local maxHistoryPerItem = options.maxHistory or 30
    local now = GetServerTime()
    local cutoffTime = now - (retentionDays * 86400)

    local db = ns.db
    if not db then return false, "No database loaded." end

    local prunedOldPoints = 0
    local prunedDuplicates = 0
    local prunedOrphans = 0
    local totalItems = 0

    if db.items then
        for itemID, rec in pairs(db.items) do
            totalItems = totalItems + 1
            if rec.history and #rec.history > 0 then
                local newHistory = {}
                local lastSeenTime = nil
                local lastMinPrice = nil

                for _, h in ipairs(rec.history) do
                    local t = h.seen or h.t or 0
                    if t >= cutoffTime then
                        -- Check if identical price recorded within 2 hours
                        local isRedundant = lastSeenTime and (t - lastSeenTime < 7200) and (h.min == lastMinPrice)
                        if isRedundant then
                            prunedDuplicates = prunedDuplicates + 1
                        else
                            newHistory[#newHistory + 1] = h
                            lastSeenTime = t
                            lastMinPrice = h.min
                        end
                    else
                        prunedOldPoints = prunedOldPoints + 1
                    end
                end

                -- Cap max history points per item
                if #newHistory > maxHistoryPerItem then
                    local excess = #newHistory - maxHistoryPerItem
                    local trimmed = {}
                    for i = excess + 1, #newHistory do
                        trimmed[#trimmed + 1] = newHistory[i]
                    end
                    newHistory = trimmed
                    prunedOldPoints = prunedOldPoints + excess
                end

                rec.history = newHistory
            end

            -- Orphan check: no history, not in watchlist, shopping, or restock
            local isTracked = (db.watchlist and db.watchlist[itemID]) or
                              (db.shoppingLists and db.shoppingLists[itemID]) or
                              (db.restock and db.restock[itemID])

            if (not rec.history or #rec.history == 0) and not isTracked then
                db.items[itemID] = nil
                prunedOrphans = prunedOrphans + 1
            end
        end
    end

    -- Vacuum scan records
    local prunedScans = 0
    if db.scans then
        local newScans = {}
        for _, s in ipairs(db.scans) do
            if (s.t or 0) >= cutoffTime then
                newScans[#newScans + 1] = s
            else
                prunedScans = prunedScans + 1
            end
        end
        db.scans = newScans
    end

    -- Record last vacuum timestamp in settings
    db.settings = db.settings or {}
    db.settings.lastVacuumTime = now

    local summary = ("Compacted database: pruned %d stale points (>%dd), %d redundant entries, %d orphaned items, and %d old scans. Active items: %d."):format(
        prunedOldPoints, retentionDays, prunedDuplicates, prunedOrphans, prunedScans, totalItems - prunedOrphans)

    if ns.RefreshPanel then ns.RefreshPanel() end
    return true, summary
end

---------------------------------------------------------------------------
-- Automated Maintenance on Login (#50)
---------------------------------------------------------------------------

local maintenance = CreateFrame("Frame")
maintenance:RegisterEvent("PLAYER_LOGIN")
maintenance:SetScript("OnEvent", function(self)
    self:UnregisterEvent("PLAYER_LOGIN")

    C_Timer.After(5, function()
        if not ns.db or not ns.db.settings then return end
        local lastVac = ns.db.settings.lastVacuumTime or 0
        local now = GetServerTime()

        -- Run auto-vacuum if > 7 days since last run
        if (now - lastVac) > (7 * 86400) then
            local ok, msg = ns.VacuumDatabase({ retentionDays = 30, maxHistory = 30 })
            if ok and ns.debug then
                ns.Print("Auto-vacuum: " .. tostring(msg))
            end
        end
    end)
end)

---------------------------------------------------------------------------
-- Interactive Profile Import / Export Dialog UI (#48)
---------------------------------------------------------------------------

local profileDialog = nil

local function CreateProfileDialogOnce()
    if profileDialog then return profileDialog end

    local template = BackdropTemplateMixin and "BackdropTemplate" or nil
    local f = CreateFrame("Frame", "GoldFinderProfileDialog", UIParent, template)
    f:SetSize(520, 360)
    f:SetPoint("CENTER", UIParent, "CENTER", 0, 40)
    f:SetFrameStrata("FULLSCREEN_DIALOG")
    f:SetToplevel(true)
    f:EnableMouse(true)
    f:SetMovable(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:SetClampedToScreen(true)

    f:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 8, right = 8, top = 8, bottom = 8 }
    })
    if f.SetBackdropColor then f:SetBackdropColor(0, 0, 0, 1) end

    local solidBg = f:CreateTexture(nil, "BACKGROUND", nil, -8)
    solidBg:SetPoint("TOPLEFT", 6, -6)
    solidBg:SetPoint("BOTTOMRIGHT", -6, 6)
    solidBg:SetColorTexture(0.08, 0.08, 0.10, 0.98)

    tinsert(UISpecialFrames, "GoldFinderProfileDialog")

    -- Title
    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOPLEFT", 20, -16)
    f.title = title

    -- Description
    local desc = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    desc:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -6)
    desc:SetPoint("RIGHT", f, "RIGHT", -20, 0)
    desc:SetJustifyH("LEFT")
    f.desc = desc

    -- Scrollable EditBox
    local scrollFrame = CreateFrame("ScrollFrame", "GoldFinderProfileScroll", f, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", desc, "BOTTOMLEFT", 0, -10)
    scrollFrame:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -32, 60)

    local editBox = CreateFrame("EditBox", nil, scrollFrame)
    editBox:SetMultiLine(true)
    editBox:SetMaxLetters(999999)
    editBox:EnableMouse(true)
    editBox:SetAutoFocus(false)
    editBox:SetFontObject("GameFontHighlightSmall")
    editBox:SetWidth(460)
    editBox:SetScript("OnEscapePressed", function() f:Hide() end)
    scrollFrame:SetScrollChild(editBox)
    f.editBox = editBox

    -- Status feedback text
    local status = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    status:SetPoint("BOTTOMLEFT", 20, 24)
    status:SetJustifyH("LEFT")
    f.status = status

    -- Bottom action buttons
    local closeBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    closeBtn:SetSize(80, 24)
    closeBtn:SetPoint("BOTTOMRIGHT", -18, 18)
    closeBtn:SetText("Close")
    closeBtn:SetScript("OnClick", function() f:Hide() end)

    local applyBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    applyBtn:SetSize(110, 24)
    applyBtn:SetPoint("RIGHT", closeBtn, "LEFT", -8, 0)
    applyBtn:SetText("Apply Profile")
    applyBtn:SetScript("OnClick", function()
        local text = editBox:GetText()
        local ok, msg = ns.ImportProfile(text, false)
        if ok then
            status:SetText("|cff40ff40" .. msg .. "|r")
            ns.Good("GoldFinder: " .. msg)
            C_Timer.After(1.5, function() f:Hide() end)
        else
            status:SetText("|cffff4040Error: " .. tostring(msg) .. "|r")
            ns.Bad("GoldFinder Profile Error: " .. tostring(msg))
        end
    end)
    f.applyBtn = applyBtn

    local copyBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    copyBtn:SetSize(110, 24)
    copyBtn:SetPoint("RIGHT", closeBtn, "LEFT", -8, 0)
    copyBtn:SetText("Copy (Ctrl+C)")
    copyBtn:SetScript("OnClick", function()
        editBox:HighlightText()
        editBox:SetFocus()
        status:SetText("|cff40ff40String selected. Press Ctrl+C to copy!|r")
    end)
    copyBtn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("Copy Profile String", 1, 0.82, 0)
        GameTooltip:AddLine("Highlights the entire profile string and focuses the box.", 1, 1, 1, true)
        GameTooltip:AddLine("Press Ctrl+C to copy to your clipboard.", 0.25, 1, 0.25)
        GameTooltip:Show()
    end)
    copyBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    f.copyBtn = copyBtn

    local selectBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    selectBtn:SetSize(90, 24)
    selectBtn:SetPoint("RIGHT", copyBtn, "LEFT", -8, 0)
    selectBtn:SetText("Select All")
    selectBtn:SetScript("OnClick", function()
        editBox:HighlightText()
        editBox:SetFocus()
        status:SetText("|cff40ff40Highlighted. Press Ctrl+C.|r")
    end)
    f.selectBtn = selectBtn

    profileDialog = f
    return profileDialog
end

function ns.ShowProfileDialog(mode)
    local f = CreateProfileDialogOnce()
    mode = mode or "export"

    if mode == "export" then
        f.title:SetText("|cffffd100Export GoldFinder Profile|r")
        f.desc:SetText("Copy the encoded string below to share your thresholds, filters, watchlists, and custom groups with another character or account:")
        f.applyBtn:Hide()
        f.copyBtn:Show()
        f.selectBtn:Show()
        f.status:SetPoint("RIGHT", f.selectBtn, "LEFT", -10, 0)

        local str = ns.ExportProfile() or ""
        f.editBox:SetText(str)
        f.editBox:HighlightText()
        f.editBox:SetFocus()
        f.status:SetText("|cff40ff40String copied to focus. Press Ctrl+C to copy.|r")
    else
        f.title:SetText("|cffffd100Import GoldFinder Profile|r")
        f.desc:SetText("Paste an exported GoldFinder profile string (starts with 'GF1:') into the box below and click Apply:")
        f.copyBtn:Hide()
        f.selectBtn:Hide()
        f.applyBtn:Show()
        f.status:SetPoint("RIGHT", f.applyBtn, "LEFT", -10, 0)

        f.editBox:SetText("")
        f.editBox:SetFocus()
        f.status:SetText("|cff888888Paste profile string with Ctrl+V.|r")
    end

    f:SetFrameStrata("FULLSCREEN_DIALOG")
    if f.SetFrameLevel then f:SetFrameLevel(200) end
    f:Show()
    f:Raise()
    return f
end
