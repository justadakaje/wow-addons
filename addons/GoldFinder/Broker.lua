-- GoldFinder -- Broker
-- LibDataBroker (LDB) feed and LibDBIcon minimap button (#23).
-- Displays active deals and potential profit on broker display bars (Titan Panel,
-- ChocolateBar, Bazooka) and provides a minimap coin button.

local ADDON, ns = ...

local ldb = LibStub and LibStub:GetLibrary("LibDataBroker-1.1", true)
if not ldb then return end
local icon = LibStub and LibStub:GetLibrary("LibDBIcon-1.0", true)

local dataObj = nil

function ns.ShowBrokerTooltip(tip)
    local allDeals, status = (ns.FindDeals and ns.FindDeals()) or {}
    tip:AddDoubleLine("|cffffd100GoldFinder|r", "v" .. (ns.version or "0.8.0"), 1, 0.82, 0, 0.7, 0.7, 0.7)
    tip:AddLine(" ")

    local numDeals = #allDeals
    local totalFlipProfit = 0
    for _, d in ipairs(allDeals) do
        totalFlipProfit = totalFlipProfit + (d.totalNetProfit or 0)
    end

    tip:AddDoubleLine("Active Deals Found:", tostring(numDeals), 1, 1, 1, numDeals > 0 and 0.25 or 0.7, numDeals > 0 and 1 or 0.7, numDeals > 0 and 0.25 or 0.7)
    if numDeals > 0 then
        tip:AddDoubleLine("Total Flip Potential:", "+" .. ns.Money(totalFlipProfit), 1, 0.82, 0, 0.25, 1, 0.25)
        tip:AddLine(" ")
        tip:AddLine("Top Opportunities:", 1, 0.82, 0)
        local maxShow = math.min(4, numDeals)
        for i = 1, maxShow do
            local d = allDeals[i]
            local name = d.name or (C_Item and C_Item.GetItemNameByID and C_Item.GetItemNameByID(d.itemID)) or ("Item " .. d.itemID)
            local pct = math.floor(d.below * 100 + 0.5)
            local profitStr = "+" .. ns.Money(d.totalNetProfit or 0)
            tip:AddDoubleLine(("  %s (-%d%%)"):format(name, pct), profitStr, 0.9, 0.9, 0.9, 0.25, 1, 0.25)
        end
    else
        tip:AddLine("No deals currently meeting discount threshold.", 0.7, 0.7, 0.7, true)
    end

    -- Restock alert status (#45)
    local lowStock = ns.GetLowStockItems and ns.GetLowStockItems()
    if lowStock and #lowStock > 0 then
        tip:AddLine(" ")
        tip:AddDoubleLine("Restock Alert:", ("|cffff4040%d material(s) low|r"):format(#lowStock), 1, 0.82, 0, 1, 0.25, 0.25)
        for i = 1, math.min(3, #lowStock) do
            local it = lowStock[i]
            tip:AddDoubleLine(("  %s"):format(it.name), ("%d / %d"):format(it.current, it.target), 0.8, 0.8, 0.8, 1, 0.4, 0.4)
        end
    end

    -- Snipe Engine status (#44)
    if ns.IsSnipeMode and ns.IsSnipeMode() then
        tip:AddLine(" ")
        tip:AddDoubleLine("Live Snipe Engine:", "|cff40ff40ACTIVE|r", 1, 0.82, 0, 0.25, 1, 0.25)
    end

    -- Scan freshness status
    local scan = ns.ScanStatus and ns.ScanStatus()
    if scan and scan.footer then
        tip:AddLine(" ")
        tip:AddDoubleLine("Market Scan Status:", scan.footer, 1, 0.82, 0, 0.8, 0.8, 0.8)
    end

    tip:AddLine(" ")
    tip:AddLine("Left-Click: Open GoldFinder tab at Auction House.", 0.4, 0.8, 1, true)
    tip:AddLine("Right-Click: Open GoldFinder Options & Configuration.", 0.4, 0.8, 1, true)
    tip:AddLine("Shift-Click: Open CSV data export dialog.", 0.4, 0.8, 1, true)
    tip:AddLine("Type /gf minimap to toggle this minimap button.", 0.6, 0.6, 0.6, true)
end

function ns.UpdateBrokerText()
    if not dataObj then return end
    local allDeals = (ns.FindDeals and ns.FindDeals()) or {}
    local num = #allDeals
    if num == 0 then
        dataObj.text = "GoldFinder: 0 Deals"
    else
        local topProfit = allDeals[1] and allDeals[1].totalNetProfit or 0
        dataObj.text = ("GoldFinder: %d Deal%s (+%s)"):format(num, num == 1 and "" or "s", ns.Money(topProfit))
    end
end

local function InitBroker()
    dataObj = ldb:NewDataObject("GoldFinder", {
        type = "data source",
        text = "GoldFinder",
        icon = "Interface\\AddOns\\GoldFinder\\assets\\GoldFinder-Logo.png",
        OnEnter = function(self)
            GameTooltip:SetOwner(self, "ANCHOR_NONE")
            GameTooltip:ClearAllPoints()
            GameTooltip:SetPoint("TOPRIGHT", self, "BOTTOMLEFT", -4, -4)
            GameTooltip:ClearLines()
            ns.ShowBrokerTooltip(GameTooltip)
            GameTooltip:Show()
        end,
        OnLeave = function()
            GameTooltip:Hide()
        end,
        OnClick = function(self, button)
            if button == "LeftButton" then
                if IsShiftKeyDown() then
                    ns.ShowExportDialog()
                else
                    if AuctionHouseFrame and AuctionHouseFrame:IsShown() and LibAHTab then
                        LibAHTab:SetSelectedTab(AuctionHouseFrame, "GOLDFINDER")
                    else
                        ns.Print("Visit an Auction House to view deals. Shift-Click for CSV export.")
                    end
                end
            elseif button == "RightButton" then
                if IsShiftKeyDown() then
                    ns.ShowExportDialog()
                else
                    if ns.OpenConfig then
                        ns.OpenConfig()
                    elseif ns.ToggleConfig then
                        ns.ToggleConfig()
                    end
                end
            end
        end,
    })

    if icon then
        if not ns.db then return end
        ns.db.settings = ns.db.settings or {}
        ns.db.settings.minimap = ns.db.settings.minimap or { hide = false }
        icon:Register("GoldFinder", dataObj, ns.db.settings.minimap)
    end

    ns.UpdateBrokerText()
end

function ns.SetMinimapButtonShown(shown)
    if not icon then return end
    if not ns.db or not ns.db.settings then return end
    ns.db.settings.minimap = ns.db.settings.minimap or {}
    ns.db.settings.minimap.hide = not shown
    if shown then
        icon:Show("GoldFinder")
    else
        icon:Hide("GoldFinder")
    end
end

function ns.IsMinimapButtonShown()
    if not ns.db or not ns.db.settings or not ns.db.settings.minimap then return true end
    return not ns.db.settings.minimap.hide
end

-- Wait for ADDON_LOADED to ensure ns.db exists before registering with LibDBIcon
local boot = CreateFrame("Frame")
boot:RegisterEvent("ADDON_LOADED")
boot:SetScript("OnEvent", function(self, _, name)
    if name ~= ADDON then return end
    self:UnregisterEvent("ADDON_LOADED")
    InitBroker()
end)
