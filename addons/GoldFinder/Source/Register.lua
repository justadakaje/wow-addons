-- Registers GoldFinder's tab with Auctionator via its public Tabs API
-- (Auctionator.Tabs.Register), discovered by reading Collectionator's own
-- Source/Summary/Tab/Register.lua (github.com/TheMouseNest/Collectionator, MIT).
--
-- OPEN QUESTION (episode 1, step 1): Collectionator only ships for Interface
-- 120005/50504 (Retail/Wrath). Auctionator.Tabs.Register is NOT yet confirmed to
-- exist on the Classic Era build (Source_LegacyAH). If the guard below prints
-- the warning in-game, fall back to reading Source_LegacyAH + Patches/TaintLess.xml
-- directly from the installed Auctionator copy.

if Auctionator and Auctionator.Tabs and Auctionator.Tabs.Register then
  Auctionator.Tabs.Register({
    name = "GoldFinder",
    textLabel = "GoldFinder",
    tabTemplate = "GoldFinderTabFrameTemplate",
    tabHeader = "Gold Finder",
    tabFrameName = "GoldFinderTabFrame",
    tabOrder = 10,
  })
else
  print("|cffff4444GoldFinder|r: Auctionator.Tabs.Register not found on this build."
    .. " Falling back to Source_LegacyAH is required — see AGENTS.md.")
end
