GoldFinderTabFrameMixin = {}

-- TODO(episode 1): replace with the real raw-material-flip / craft-profit views.
-- Placeholder confirms the tab mounts, sizes, and shows/hides correctly first.

function GoldFinderTabFrameMixin:OnLoad()
  self.PlaceholderText:SetText("GoldFinder: tab mounted OK. Views not built yet.")
end

function GoldFinderTabFrameMixin:OnShow()
  -- Real work (scan kickoff, data refresh) goes here once the views exist.
end
