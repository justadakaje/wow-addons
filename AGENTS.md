# AGENTS.md

Guidance for AI coding agents (and humans) working in this repo.

## Environment facts

- Client: WoW Classic Era / Season of Discovery. Local AddOns path (user's machine):
  `F:\World of Warcraft\_classic_era_\Interface\AddOns`
- Confirmed `## Interface:` value for this client: **20506** — cross-checked against
  Auctionator (v334), TomTom (v4.3.8), GatherMate2, BugGrabber, the Scrap/Bagnon family.
  Some installed addons still declare only `11509` (older numbering); use 20506 for new code.
- GitHub: `https://github.com/justadakaje/wow-addons`, MIT license, default branch `master`.
- Local dev syncs into the live AddOns folder via `scripts/link-addons.ps1` (symlinks, not copies —
  edit in the repo, reload in-game with `/reload`).
- Season of Discovery is confirmed (per Blizzard, late June 2026) to be receiving no further new
  content. Treat SoD-specific feature work as lower priority than MoP Classic work going forward,
  all else equal — but Classic Era/Legacy-AH compatibility still matters for anything shipping
  against the current client.

## Verify API before coding

Don't guess WoW API signatures. If `wow-api-mcp` (`lookup_api`, `search_api`, `get_namespace`,
`get_widget_methods`, `get_enum`, `get_event`, `list_deprecated`) is attached in this session, use
it. Otherwise cross-check against an installed addon's actual source before assuming a signature.
Missing data from the API is `nil` — never fabricate a plausible-looking return value.

## Auctionator integration — confirmed facts

All reference addons below are by **plusmouse** (github.com/TheMouseNest), who also authors
Auctionator itself.

- **Auctionator** ships its own `AGENTS.md` in the live install
  (`Auctionator\AGENTS.md`) — read it before writing Auctionator-integration code.
  Internally maintains parallel implementations: `Source_ModernAH` [cata,mists,mainline] vs
  `Source_LegacyAH` + `Patches\TaintLess.xml` [vanilla,tbc,wrath]. Also already has a crafting
  view showing reagent cost/profit per known recipe — check what it already covers before
  building a redundant feature.
- **Confirmed public tab API:** `Auctionator.Tabs.Register({ name, textLabel, tabTemplate,
  tabHeader, tabFrameName, tabOrder })` — read directly from Collectionator's
  `Source/Summary/Tab/Register.lua` (github.com/TheMouseNest/Collectionator, MIT). This is a
  higher-level, addon-facing API — third-party addons register a tab template + frame name and
  Auctionator handles insertion, rather than needing to touch `Source_LegacyAH` internals
  directly. **Not yet confirmed against the Classic Era (LegacyAH) build specifically** —
  Collectionator itself only targets Interface 120005/50504 (Retail/Wrath), not Classic Era.
  Confirm `Auctionator.Tabs.Register` exists and behaves the same on the installed Classic Era
  copy before relying on it; if it's Modern-AH-only, fall back to reading `Source_LegacyAH` +
  `Patches\TaintLess.xml` directly (that was the original plan).
- Tab frame template pattern: virtual `Frame` anchored to `$parent.CategoriesList`
  (`TOP`/`LEFT`/`BOTTOMRIGHT`), `mixin` for behavior, `OnLoad`/`OnShow` scripts. See
  `Source/Summary/Tab/Main.xml` in Collectionator for a full example.
- **LibAHTab** — confirmed Retail-only (Dragonflight+, `PLAYER_INTERACTION_MANAGER_FRAME_SHOW` +
  `Enum.PlayerInteractionType.Auctioneer`, don't exist pre-Dragonflight). Not usable for Classic Era.
- **PointBlankSniper** (`RequiredDeps: Auctionator`) — shopping-list deal sniper, Interface
  120000/50503 (Retail + Wrath only, not Classic Era). Known upstream issue: scanner slows after
  repeated iterations, suspected AH-refresh-cooldown related.
- **Journalator** (installed, v169) — not a live market feed, a personal transaction ledger. Real
  public API in the installed `Journalator\Source\API.lua`:
  `Journalator.API.v1.Get{Realm}{Mean,Min,Max,Last}{Sold,Bought}ByItemName(callerID, itemName)`,
  keyed via `Auctionator.Utilities.DBKeyFromLink`. Useful as a secondary "does this actually sell"
  signal on top of Auctionator's live price DB, not a replacement.

## Correction — don't repeat

`Journalator_Display` does **not** add a tab inside Blizzard's Auction House frame — verified by
reading its `Source\Initialize.lua`. It opens its own standalone top-level window (`JNRView`).
Its `TabButton`/`TabbedView` mixins are for tabs inside that separate window only. Don't reuse it
as the in-AH-tab reference.

## Current goal

New tab in the in-game Auction House window (via Auctionator) surfacing gold-making
opportunities on Classic Era/SoD:
1. Raw materials currently listed below market value (flip opportunities)
2. Craftable items (from known recipes) sellable above crafting cost

See `addons/GoldFinder/` for the in-progress implementation.

Longer-term/separate track: fork `stryker-max/GoldCopilot` (MIT, currently TBC Classic
Anniversary only) and port to MoP Classic. Lower priority than the above per the SoD note.

## Working preferences

Infra/platform engineering background — skip 101-level explanations, assume senior baseline.
Direct, no flattery/filler. If something's ambiguous, state the assumption and proceed rather
than blocking on a question. Prefer incremental, reversible, testable changes; call out failure
modes, rate limits, and validation steps explicitly. Complete code blocks over fragments unless
isolating a specific fix.
