-- scan_spec.lua -- Unit tests for GoldFinder scan status and buffer tracking

local helper
local ok, res = pcall(require, "tests.test_helper")
if ok then
    helper = res
else
    helper = require("addons.GoldFinder.tests.test_helper")
end

describe("GoldFinder Scan Engine & Buffer Tracking", function()
    local ns

    before_each(function()
        helper.reset()
        ns = helper.createNamespace()
        helper.loadAddonFile("Scan.lua", ns)
        helper.loadAddonFile("Info.lua", ns)
    end)

    describe("ScanStatus Reporting", function()
        it("returns default status when no scans are recorded", function()
            ns.db.scans = {}
            local st = ns.ScanStatus()
            assert.are.equal("No scans recorded yet", st.footer)
            assert.are.equal("No scans recorded yet", st.status)
            assert.are.equal(0, st.count)
            assert.are.equal(0, st.lifetime)
        end)

        it("returns rich status text when scans are present", function()
            local testTime = 1700000000
            ns.db.scans = {
                {
                    t = testTime,
                    source = "replicate",
                    rows = 4468,
                    distinctItems = 315,
                    materials = 248,
                    items = 248,
                    noInfo = 0,
                    unknownClass = 0,
                    noPrice = 0,
                    noItem = 0,
                    skipped = 1,
                }
            }

            local st = ns.ScanStatus()
            assert.is_not_nil(st.status)
            assert.is_not_nil(st.status:find("Snapshot"))
            assert.is_not_nil(st.status:find("248 materials"))
            assert.is_not_nil(st.status:find("4468 rows"))
            assert.is_not_nil(st.footer:find("1 scan recorded"))
        end)

        it("differentiates lifetime scans from rolling retained buffer", function()
            local testTime = 1700000000
            ns.db.scans = {}
            for i = 1, 100 do
                table.insert(ns.db.scans, {
                    t = testTime + i * 60,
                    source = "browse",
                    rows = 500,
                    distinctItems = 50,
                    materials = 40,
                    items = 40,
                    noInfo = 0,
                    unknownClass = 0,
                    noPrice = 0,
                    noItem = 0,
                    skipped = 0,
                })
            end
            ns.db.lifetimeScans = 145

            local st = ns.ScanStatus()
            assert.are.equal(100, st.count)
            assert.are.equal(145, st.lifetime)
            assert.is_not_nil(st.footer:find("145 scans %(100 retained%)"))
        end)

        it("provides diagnosis activity sentence", function()
            local diag = ns.GetScanDiag()
            assert.is_string(diag)
            assert.is_true(#diag > 0)
        end)
    end)

    describe("Diagnostic Report Generation", function()
        it("generates markdown report containing scan counts and diagnostics", function()
            ns.db.scans = {
                {
                    t = 1700000000,
                    source = "replicate",
                    rows = 4468,
                    distinctItems = 315,
                    materials = 248,
                    items = 248,
                    noInfo = 0,
                    unknownClass = 0,
                    noPrice = 0,
                    noItem = 0,
                    skipped = 1,
                }
            }
            ns.db.lifetimeScans = 105

            local report = ns.GenerateDiagnosticReport()
            assert.is_string(report)
            assert.is_not_nil(report:find("GoldFinder Diagnostic & Support Report"))
            assert.is_not_nil(report:find("105 scans recorded %(100 retained in rolling buffer%)") or report:find("105 scans recorded %(1 retained in rolling buffer%)"))
            assert.is_not_nil(report:find("Scan Engine Activity:"))
            assert.is_nil(report:find("Last: None recorded"))
        end)
    end)
end)
