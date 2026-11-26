# Project rules — wow-addons

- **Monorepo, one folder per addon.** Each addon under `addons/<AddonName>/` is self-contained: its own `.toc` (or one `.toc` per supported client — e.g. `AddonName.toc`, `AddonName_Vanilla.toc`, `AddonName_Mists.toc`), its own Lua, its own `Knowledge/` if it has curated static data, its own `tests/` if it has tests. Nothing reaches across addon folders.
- **Verify every API call before writing it.** Use the attached `wow-api` MCP server's tools (`lookup_api`, `search_api`, `get_namespace`, `get_widget_methods`, `get_enum`, `get_event`, `list_deprecated`) rather than recalling function signatures from memory. If the MCP server isn't attached in the current session, say so explicitly instead of guessing — this applies to Claude or any other agent working in this repo.
- **Determine the target game version, don't assume it.** Check the `.toc`'s `## Interface:` line(s) for the addon you're touching. Multi-client addons check every `.toc` that exists. If it's ambiguous, ask rather than guess. For this project's primary client (Classic Era / Season of Discovery) the confirmed Interface number is **20506** (cross-checked against multiple actively-updated installed addons). For **WoW: Forever** (1.60.1 beta, `_classic_beta_`) it is **16001**, verified 2026-09-19 against the shipped `.toc` of Auctionator, Ace3, !BugGrabber, BugSack, Leatrix Plus and APLForever. CurseForge file metadata showing `11601` is a digit transposition — do not use it.
- **Missing data resolves to `nil` plus an explanation, never a guessed number or a silent zero.** If a value can't be computed from real data (no price found, no sample size yet, etc.), surface that in the UI as a sentence, not a fabricated figure.
- **No `OnUpdate` polling.** Recurring work runs off events or a self-rescheduling `C_Timer.After` that stops itself once no longer needed.
- **Avoid `fn and fn(...)` on multi-return Lua functions.** Lua's `and`/`or` operators truncate multiple returns to a single value (leaving secondary variables `nil` and triggering Luacheck errors). Guard optional multi-return APIs with an explicit `local a, b; if fn then a, b = fn(...) end`.
- **Slash command UX (chat echoing & item resolution):** When an addon routes alerts to a custom chat tab, always mirror direct slash command responses (`SlashCmdList`) to `SELECTED_CHAT_FRAME` so commands never appear silent. Any slash command accepting an item argument must resolve item links, numeric `itemID`s, exact case-insensitive item names, and shortest partial name matches.
- **Programmatic `AuctionHouseFrame` switching:** Whenever calling `AuctionHouseFrame:SelectBrowseResult(...)` to navigate to an item, follow a successful call with `pcall(C_AuctionHouse.SendSearchQuery, key, {}, false)` (or `C_AuctionHouse.RefreshCommoditySearchResults(itemID)` fallback) — if `CommoditiesBuyFrame` or `ItemBuyFrame` is already open, `SelectBrowseResult` alone leaves the listings pane stuck on `"Searching..."`.
- **UI layout parity, row modifier forwarding & AH modal strata:** When adding controls to a shared options panel, update both the floating frame size and Blizzard's embedded Settings `scrollChild` size / bottom button offsets together. When clickable table rows host child buttons (such as watchlist stars), handle or forward modifier-clicks (`Ctrl`/`Shift`/`Alt`) consistently and keep modifier hints present across all row-type tooltips. Modals opened from the Auction House must use `FULLSCREEN_DIALOG` strata, `SetToplevel(true)`, and `Raise()`.
- **New item/spell/quest IDs get checked against Questie/AtlasLoot (or `wow-api`'s data) before being added anywhere — never typed from memory.**
- **SavedVariables discipline:** never modify or delete the user's existing `WTF` data. Any new persistent structure needs a format version and a type check before it's trusted.
- **Commits:** small, incremental, and reversible. State your assumptions before generating code, per the addon's own conventions if it has an `AGENTS.md` of its own (e.g. a forked addon keeps its own rules — this file governs addons authored directly in this repo). Auctionator is **All Rights Reserved** and must not be forked, modified, or read as a reference; GoldFinder is standalone and only needs to coexist with it.
- **Check docs before starting work:** Read [docs/facts-build-69913.md](docs/facts-build-69913.md), [docs/facts-build-70009.md](docs/facts-build-70009.md), and [reference/README.md](reference/README.md) for verified WoW: Forever measurements and API dumps (if a local, gitignored `HANDOFF.md` exists in your working tree, consult it as well).

## Project context (shared by Claude Code and Antigravity)

*Section added 2026-11-26 from the README, docs and git history. The rules above are unchanged.*

### Stack

- Lua 5.1 addons with `.toc` files, one folder per addon under `addons/`. Default branch is **`master`**.
- `mcp/`: the `wow-api` MCP server (TypeScript) that the API-verification rule above depends on. Both Claude Code and Antigravity need it attached; see `docs/copilot-devkit.md`.
- `reference/`: API dumps captured by ForeverProbe; `docs/facts-build-*.md`: verified build measurements.
- `.claude/skills/` (`wow-addon-partner`, `content-pack`): repo-local skills. Claude Code loads them automatically. *Inferred:* Antigravity doesn't, so read the relevant `SKILL.md` by hand when the task matches.

### Build, test, release

```bash
node scripts/check-toc.js addons
node scripts/check-lua.js addons
bash scripts/run-tests.sh          # or: powershell -ExecutionPolicy Bypass -File scripts/run-tests.ps1  (Luacheck + Busted)
cd mcp && npm ci && npm run build && node smoke.mjs
```

- CI: `.github/workflows/validate.yml` on push and PR.
- Releases (`docs/releasing.md`): bump `## Version:` in the `.toc`, add a `CHANGELOG.md` entry, merge to `master` through a `release/<addon>-vX.Y.Z` PR, then push a tag such as `goldfinder-vX.Y.Z`. `release.yml` packages and uploads to CurseForge. Tags publish publicly, so tag only when Ken asks.

### Key decisions

- 2026-09-19: WoW: Forever Interface `16001` confirmed from shipped `.toc` files (see rules above).
- 2026-11-08: Luacheck + Busted QA runner and GitHub Actions workflow; LF line endings enforced for shell scripts.
- 2026-11-13: GoldFinder v2.0.0 feature suite (issues #60 to #63).
- 2026-11-15: WoW: Forever Addon Copilot DevKit packager; KenHenRoster multi-client roster exporter; MeridianScout exporter; local handoff files and raw art untracked.
- 2026-11-24: GoldFinder v2.0.2 (overlay strata above host panels) and v2.0.3 (TradeSkill margin badge docked below the Professions window).

### In flight (as of 2026-11-26)

- GoldFinder is at `2.0.3`. Backlog and bugs are tracked in GitHub Issues (`docs/goldfinder-backlog.md`).
- Four open Dependabot PRs on `mcp/` dependencies: #64 (qs), #65 (`@modelcontextprotocol/sdk`), #66 (hono), #67 (`@hono/node-server`).

## Working across Claude Code and Antigravity

Both tools work in this repo, and neither can see the other's chat history. This file is the shared memory between them.

- Read this file before starting. `CLAUDE.md` and `GEMINI.md` only point here.
- When a session makes a decision a later session needs (a convention, a rejected approach, a version pin, a domain or config change), add a dated line under **Key decisions** in the same PR.
- Update **In flight** when multi-session work starts or finishes.
- Mark anything not verified against the code or history as *inferred*.
