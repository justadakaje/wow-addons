# Handoff — planning chat → Claude Code

Context from a Claude.ai planning conversation, for picking up work in Claude Code. Read `AGENTS.md` too.

## Environment facts

- Client: WoW Classic Era / Season of Discovery. AddOns path: `F:\World of Warcraft\_classic_era_\Interface\AddOns`
- Confirmed current `## Interface:` value for this client: **20506** — cross-checked against Auctionator (v334), TomTom (v4.3.8), GatherMate2, BugGrabber, the Scrap/Bagnon family. (Some installed addons still declare only `11509`, an older numbering; 20506 is the one to use for new code.)
- A Filesystem MCP connector gives direct read/write to the user's machine, allow-listed to: `C:\Temp`, `F:\scratch`, `D:\Code`, and the AddOns path above. This repo lives at `D:\Code\GitHub\wow-addons`.
- GitHub: `https://github.com/justadakaje/wow-addons`, MIT license, default branch `master`. No GitHub MCP connector was available in the planning chat, so nothing was pushed — check `git status`/`git log` here, likely everything in this repo as of now is uncommitted.
- `wow-api-mcp` (grounds WoW API lookups against real signatures — `lookup_api`, `search_api`, `get_namespace`, `get_widget_methods`, `get_enum`, `get_event`, `list_deprecated`) was configured for Claude **Desktop**, not confirmed working (user was given a self-check: ask Desktop to `lookup_api` a real function and confirm a tool call fires). Not available in the planning chat surface at all, and not available here unless separately configured for Claude Code — check for it before assuming it's attached.
- User did not have a paid Claude plan as of this handoff; Claude Code needs Pro ($17/mo annual, $20/mo monthly) or higher, or API billing.

## Goal

New tab in the in-game Auction House window (via Auctionator) surfacing gold-making opportunities on Classic Era/SoD:
1. Raw materials currently listed below market value (flip opportunities)
2. Craftable items (from known recipes) sellable above crafting cost

Longer-term/separate track: fork `stryker-max/GoldCopilot` (MIT, currently TBC Classic Anniversary only) and port to MoP Classic. Season of Discovery is not receiving new content per Blizzard (confirmed late June 2026), so treat as lower priority than MoP.

## Already built this session (in this repo now, likely uncommitted)

- `AGENTS.md`, `README.md`, `scripts/link-addons.ps1`, `.github/workflows/validate.yml` — repo scaffold.
- `addons/AddonSmokeTest/` — minimal working addon (Interface 20506), also written live to the AddOns path above and not yet load-tested in-game by the user.
- A `wow-addon-partner` Claude Skill was authored separately (verify-API-before-coding, determine-game-version-from-.toc, no-OnUpdate, missing-data-is-nil-not-a-guess) and given to the user as a zip to upload via Desktop's Customize > Skills — not part of this repo, upload status unconfirmed.

## Research findings — reusable components (do not re-research, verified this session)

All of the following are by **plusmouse** (github.com/plusmouse, org github.com/TheMouseNest), who also authors Auctionator itself.

- **Auctionator** (installed, v334) — base addon. Ships its **own `AGENTS.md`** in the live install (`Auctionator\AGENTS.md`) — read it before writing Auctionator-integration code. Internally maintains parallel implementations: `Source_ModernAH`/`Assets_ModernAH` [cata,mists,mainline] vs `Source_LegacyAH`/`Assets_LegacyAH`/`Imports_LegacyAH` [vanilla,tbc,wrath] + `Patches\TaintLess.xml` [vanilla,tbc,wrath]. **`Source_LegacyAH` is the authoritative reference for how to add a tab on Classic Era** — this was the next thing to read when the planning session ended; not yet actually read. Full root listing of the installed Auctionator folder: `AGENTS.md, Assets_LegacyAH.xml, Assets_ModernAH.xml, Auctionator.toc, CHANGELOG.md, Data_Cata/, Data_Vanilla/, Images/, Images_Classic/, Imports_LegacyAH/, Imports_ModernAH/, Libs/, Libs_ModernAH/, LICENSE, Locales/, Patches/, Source/, Source_Classic/, Source_LegacyAH/, Source_Mainline/, Source_ModernAH/, Source_TBC/, Source_Vanilla/`. Also already has a crafting view showing reagent cost/profit per known recipe — check what it already covers before building a redundant feature.
- **LibAHTab** (github.com/TheMouseNest/LibAHTab, MIT) — taint-safe AH tab helper. **Confirmed Retail-only** ("10.0.0/Dragonflight pre-patch and newer"; safe no-op on older clients — uses `PLAYER_INTERACTION_MANAGER_FRAME_SHOW` + `Enum.PlayerInteractionType.Auctioneer`, which don't exist pre-Dragonflight). **Not usable for Classic Era.**
- **PointBlankSniper** (github.com/TheMouseNest/PointBlankSniper, MIT) — shopping-list deal sniper. `RequiredDeps: Auctionator`, `OptionalDeps: TheUndermineJournal, OribosExchange`. `## Interface: 120000, 50503` — **Retail + Wrath Classic only, not Classic Era.** Known upstream issue #21: scanner slows after repeated iterations, suspected AH-refresh-cooldown related. Full `Source/` contents not retrieved — GitHub's tree/folder view is blocked by robots.txt for `web_fetch`, and `api.github.com`/`raw.githubusercontent.com` were both rejected as "not in allowlist" from the planning chat's bash sandbox despite appearing in its stated config. **Clone this repo directly in Code to read `Source/` in full** — no such restriction there.
- **Collectionator** (github.com/TheMouseNest/Collectionator, MIT) — adds its own tab to the AH (uncollected transmog/pets/toys/mounts/recipes). `RequiredDeps: Auctionator`. `## Interface: 120000, 110207, 50502` — **also not Classic Era.** Closest same-author example of "add a new tab to Auctionator," but its tab-registration source wasn't read this session (same access limits as above) and it still needs a Classic Era port.
- **Journalator** (installed, v169, `OptionalDeps: Auctionator`) — **not a live market feed**, it's a personal transaction ledger (auction posting/sales, mail, loot, quests, trades, vendor buys/repairs, training, reputation; crafting-order tracking is retail-only, disabled on Classic via a `notClassic` flag in `Source\Constants.lua`). Has a real public API, read directly from the installed `Journalator\Source\API.lua` and `Journalator_Statistics\API.lua`:
  ```lua
  Journalator.API.v1.GetRealmMeanSoldByItemName(callerID, itemName)
  Journalator.API.v1.GetRealmMinSoldByItemName(callerID, itemName)
  Journalator.API.v1.GetRealmMaxSoldByItemName(callerID, itemName)
  Journalator.API.v1.GetRealmLastSoldByItemName(callerID, itemName)
  Journalator.API.v1.GetRealmMeanBoughtByItemName / ByItemLink(callerID, item)
  Journalator.API.v1.GetRealmMinBoughtByItemName / MaxBoughtByItemName(callerID, item)
  Journalator.API.v1.GetRealmSuccessCountByItemName / FailureCountByItemName(callerID, item)
  ```
  Keyed via `Auctionator.Utilities.DBKeyFromLink` — shares Auctionator's item-addressing scheme. Useful as a secondary "does this actually sell" signal on top of Auctionator's live price database, not a replacement for it.

## Correction — don't repeat this mistake

Earlier in the planning chat I (incorrectly) guessed that `Journalator_Display` adds a tab inside Blizzard's Auction House frame, and suggested reading it as a reference. **This was wrong** — verified by reading its actual `Source\Initialize.lua`: it opens its own standalone top-level window (`JNRView`, parented to `UIParent`, toggled from the addon-compartment button). Its `TabButton`/`TabbedView` mixins are for tabs *inside that separate window* only, not the real AH frame. Do not reuse this as the in-AH-tab pattern.

## Immediate next steps, in order

1. Read Auctionator's own `Source_LegacyAH\` and `Patches\TaintLess.xml` (installed copy, path above) — the real answer for how to safely add a tab on Classic Era.
2. Check Auctionator's existing crafting-profit view before building a parallel feature.
3. Clone PointBlankSniper and Collectionator into `D:\Code\GitHub\` to read their full `Source/` — not retrievable via web fetch in the planning session.
4. Design the tab: Auctionator's live price DB for raw-mat flips + known-recipe cost comparison for crafted profit, optionally cross-checked against Journalator's per-item historical API.
5. Confirm/execute: fork `stryker-max/GoldCopilot` under the user's account (not yet done) — keep separate from this repo, add `upstream` remote.
6. Commit and push this repo's current uncommitted state (scaffold + AddonSmokeTest) once reviewed.
7. Confirm `wow-api-mcp` is actually attached wherever this work continues (Desktop or Code) — not yet confirmed working as of this handoff.

## User's working preferences (carry forward)

Infra/platform engineering background — skip 101-level explanations, assume senior baseline. Direct, no flattery/filler. If something's ambiguous, state the assumption and proceed rather than blocking on a question. Prefer incremental, reversible, testable changes; call out failure modes, rate limits, and validation steps explicitly. Complete code blocks over fragments unless isolating a specific fix.
