# Handoff

Working context for picking this repo up cold. Read `AGENTS.md` too — it holds
the rules; this holds the findings, the dead ends, and the open questions.

Last updated 2026-09-20, against WoW: Forever beta build 69913.

## Environment facts

- **Primary client is now WoW: Forever** (1.60.1 beta), not Classic Era. Path:
  `F:\World of Warcraft\_classic_beta_\Interface\AddOns`. Flavor file says
  `wow_classic_beta`; `Config.wtf` has `portal "test"`.
- **`## Interface: 16001`.** Confirmed by `GetBuildInfo()` (4th return) and by
  every shipped Forever `.toc`. CurseForge metadata showing `11601` is a digit
  transposition — do not use it.
- **Game type token is `camelot`**, for `.toc` `[AllowLoadGameType ...]` gates.
  Confirmed twice: BugSack ships `forever.lua [ExcludeLoadGameType standard,
  classic][AllowLoadGameType camelot]`, and the client's own crash report header
  reads `<Exception.WowProject> Camelot`.
- **But `WOW_PROJECT_ID == WOW_PROJECT_MAINLINE` (both `1`) at the Lua layer.**
  Two taxonomies that disagree: a `.toc` sees `camelot`, Lua sees mainline. This
  is the single most load-bearing gotcha in this repo — see Corrections.
- Classic Era (`_classic_era_`) is Interface **20506** and still valid for
  anything targeting that client. Multi-client addons want both numbers.
- Git: `https://github.com/justadakaje/wow-addons`, MIT, default branch `master`.
  Branch **`forever-probe` is one commit ahead of `master` and unpushed**
  (`70d2e9e`). The older handoff claimed the repo was uncommitted; it was not.
- **The `wow-api` MCP server IS attached**, and answers from this client's own
  capture. Verified 2026-09-20: `lookup_api`, `search_api`, `get_enum`,
  `get_event`, `get_namespace`, `get_widget_methods` and `list_deprecated` all
  resolve. Every response footers `WoW: Forever 1.60.1 (build 69913), Interface
  16001` — the same build as the ForeverProbe dump, so it is not a pre-1.60.1
  public scrape. Coverage spot-checked on `C_AuctionHouse` and `C_Housing` (62
  documented functions). This supersedes the previous handoff's "NOT attached",
  which was true when written and is no longer. **For any single name prefer
  `lookup_api` over `list_deprecated`** — see Legacy globals for why.

## Goal

Surface gold-making opportunities in-game: raw materials listed below market
value, and craftables sellable above crafting cost.

**This is currently blocked on Forever** — see the Auctionator finding below.
The goal has not changed; the target client moved out from under it.

## What is built

- `addons/ForeverProbe/` — the reason most of this document can be stated as
  fact. Read-only. On `PLAYER_LOGIN` it walks `_G` and dumps to SavedVariables:
  every `C_*` namespace and member, every global function, `GetBuildInfo()`,
  `WOW_PROJECT_*` constants, and a watchlist of Classic-vs-modern API splits.
  `Events.lua` additionally records events passively.
  - `/fprobe` — re-run the API capture
  - `/fpevents [housing]` — event summary. **Stages in memory only.**
  - `/fphouse` — read `C_Housing`. Explicit-only and genuinely risky; see below.
  - Output: `WTF/Account/<id>/SavedVariables/ForeverProbe.lua` (~2.1 MB).
- `addons/AddonSmokeTest/` — minimal proof-of-life addon, `20506, 16001`.
- `scripts/link-addons.ps1` — symlinks `addons/*` into a client. Needs elevation
  or Developer Mode. Editing in the repo is then live in-game.
- `.github/workflows/validate.yml` — checks each addon has a `.toc` with an
  `## Interface:` line. Does not lint Lua yet.

## Verified findings — the Forever client

All from build 69913 unless noted.

### Legacy globals are gone

`GetItemInfo`, `GetSpellInfo`, `GetTradeSkillInfo`, `UnitAura`,
`QueryAuctionItems`, `GetContainerItemInfo`, `GetContainerNumSlots`,
`GetAddOnMetadata`, `GetNumAddOns`, `IsAddOnLoaded` and `LoadAddOn` all resolve
to `nil`. Only the `C_*` forms exist. Any Classic-era addon leaning on the old
globals breaks.

`GetTradeSkillInfo` came from the MCP's `list_deprecated`, not the original
ForeverProbe walk — it was absent from this list until 2026-09-20.

**`list_deprecated` is not exhaustive. Do not treat it as the authority.** It
returns 10 removed globals and omits `LoadAddOn`, which ForeverProbe verified as
`nil` and which `lookup_api("LoadAddOn")` independently confirms: a bare-name
lookup returns only `C_AddOns.LoadAddOn`, no global. Two sources, each with a
hole the other fills. For a specific name `lookup_api` is authoritative —
absence from its output means the symbol does not exist on this client. Use
`list_deprecated` as a starting list, never as a clean bill of health.

`IsSpellKnown` survives as a global while `GetSpellInfo` does not. That
inconsistency is unguessable and is the whole argument for probing over
reasoning.

Surface: 269 `C_*` namespaces, 4,912 namespaced functions, 5,889 global
functions. Modern systems are all present — `C_Garrison` (227),
`C_TransmogCollection`, `C_Commentator`, `C_Housing` (63). Modern engine,
Classic content.

Those are members found by walking `_G`, which is not the same measure the MCP
reports: `get_namespace("C_Housing")` gives **62 documented functions** against
the 63 members counted here. The one-item gap has not been diffed and is
unexplained. Expect "exists on the client" and "is documented" to diverge
slightly rather than assuming either number is wrong.

### There is a full API reference, and we have it

`Blizzard_APIDocumentation` ships the *framework* only — loading it alone leaves
`systems` empty, which is what made the first attempt look like a dead end. The
data is in a second addon. Load **both**:

```lua
C_AddOns.LoadAddOn("Blizzard_APIDocumentation")
C_AddOns.LoadAddOn("Blizzard_APIDocumentationGenerated")
```

That yields **408 systems, 6,577 functions, 1,802 events** with full signatures:
argument names, types, nilability, return types. It is in the ForeverProbe dump
under `documentation`.

**Prefer reading these signatures over calling functions to find out.** That is
not a style preference — see the crash in Corrections.

### Campsite is a rest area, not Housing

Three independent signals: no housing event fired during a campsite visit,
`Logs/Housing.log` stayed 0 bytes, and the string "campsite" appears nowhere in
all 6,577 documented signatures. What did fire was `PLAYER_UPDATE_RESTING` (×12)
and `HEARTHSTONE_BOUND`.

Campsite introduces **no new API** and needs no addon support. Housing is a real
and substantial system in this client (13 namespaces, 342 functions,
neighborhoods, charters, plots, five editor modes) but is a separate thing that
has not been engaged yet.

### Auctionator's auction-house layer does not load

`Auctionator.toc` gates `Source_ModernAH`, `Assets_ModernAH`, `Imports_ModernAH`
and `Libs_ModernAH` to `cata, mists, mainline`, and the `*_LegacyAH` equivalents
to `vanilla, tbc, wrath`. **Neither list contains `camelot`**, and the string
appears nowhere in the addon. What loads is the ungated `Libs/`, `Locales/` and
`Source/` (which does carry `AH/`, `Tabs/`, `Database/`, `Selling/`, `API/`).

Meanwhile its own constants resolve like this on Forever:

```lua
IsRetail  = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE  -- TRUE
IsVanilla = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC   -- false
```

So the surviving Lua believes it is running on Retail while the Retail *files*
were never loaded. Split-brain, not graceful degradation — it should throw
rather than no-op once the AH is actually opened.

**Unverified:** nobody has opened an auctioneer yet. This is inferred from toc
gating plus constant logic. Ten seconds in front of an auctioneer confirms or
kills it, and it decides whether the goal above is blocked on upstream or needs
a fork of Auctionator.

## Verified findings — reusable components

All by **plusmouse** (github.com/plusmouse, org github.com/TheMouseNest), who
also authors Auctionator. Verified during Classic Era planning — **the
`## Interface:` conclusions below predate Forever and none of these declare
`16001`**, so treat every one as needing a port.

- **Auctionator** (installed, v334). Ships its own `AGENTS.md` in the live
  install — read it before writing integration code. Already has a crafting view
  showing reagent cost/profit per known recipe; check it before building a
  redundant feature.
- **LibAHTab** (MIT) — taint-safe AH tab helper, **Retail-only** (Dragonflight+;
  uses `PLAYER_INTERACTION_MANAGER_FRAME_SHOW` and
  `Enum.PlayerInteractionType.Auctioneer`). Was unusable on Classic Era. Given
  Forever reports as mainline in Lua *and* has the modern AH API, this is worth
  re-evaluating — it may now be the right answer.
- **PointBlankSniper** (MIT) — shopping-list deal sniper. `RequiredDeps:
  Auctionator`. `## Interface: 120000, 50503`. Upstream issue #21: scanner slows
  after repeated iterations, suspected AH-refresh-cooldown related.
- **Collectionator** (MIT) — adds its own tab to the AH. `RequiredDeps:
  Auctionator`. `## Interface: 120000, 110207, 50502`. Closest same-author
  example of "add a tab to Auctionator"; its tab-registration source still has
  not been read.
- **Journalator** (installed, v169) — **not a live market feed**, a personal
  transaction ledger. Real public API, read from the installed
  `Journalator\Source\API.lua`:

  ```lua
  Journalator.API.v1.GetRealmMeanSoldByItemName(callerID, itemName)
  Journalator.API.v1.GetRealmMinSoldByItemName(callerID, itemName)
  Journalator.API.v1.GetRealmMaxSoldByItemName(callerID, itemName)
  Journalator.API.v1.GetRealmLastSoldByItemName(callerID, itemName)
  Journalator.API.v1.GetRealmMeanBoughtByItemName / ByItemLink(callerID, item)
  Journalator.API.v1.GetRealmMinBoughtByItemName / MaxBoughtByItemName(callerID, item)
  Journalator.API.v1.GetRealmSuccessCountByItemName / FailureCountByItemName(callerID, item)
  ```

  Keyed via `Auctionator.Utilities.DBKeyFromLink`, so it shares Auctionator's
  item addressing. Useful as a secondary "does this actually sell" signal, not a
  replacement for a live price database.

## Corrections — do not repeat these

- **`pcall` does not make an unknown C function safe.** It catches Lua errors. A
  null dereference inside native code takes the whole process down with `pcall`
  sitting on the stack. `C_Housing.GetMaxHouseLevel()` access-violates on build
  69913 when the player owns no house — despite being documented as a no-argument
  getter returning a non-nilable number. It is in `KNOWN_CRASHERS` in
  `Events.lua`. Reported to Blizzard, report ID
  `82192690-9E96-4A2B-A3FD-FCAA44FA13CC`.
- **Nothing that can crash may run in the save path.** That getter was being
  called from `Flush()`, which runs on `PLAYER_LOGOUT` — so every clean logout
  and every `/reload` would have crashed before writing a byte. The act of saving
  destroyed the data being saved. Cost: a 98-minute session, 16,446 events.
- **SavedVariables cannot be flushed from Lua.** Only the client writes them, and
  only on logout or `/reload`. A crash loses everything since the last write.
  Any UI text implying otherwise is a trap — `/fpevents` now says "staged in
  memory" for exactly this reason.
- **Do not infer a game's identity from one layer.** `.toc` gating says
  `camelot`; `WOW_PROJECT_ID` says mainline. Checking either alone gives a
  confidently wrong answer about what will load and which branches run.
- **`Journalator_Display` does not add a tab to Blizzard's AH frame.** Verified
  by reading `Source\Initialize.lua`: it opens its own top-level window
  (`JNRView`, parented to `UIParent`). Its `TabButton`/`TabbedView` mixins are
  for tabs inside *that* window. Not an in-AH-tab reference.
- **Forever is real.** It was reasonable to be suspicious of a screenshot showing
  retail-style version numbers under a 1.x game version and filenames like
  `CUsersJaliborcDesktopBagnon-12.1.2.zip`. Those are sloppy author uploads.
  BlizzCon 2026 announcement, beta since Sep 2026.

## Tooling

No Lua interpreter is installed on this machine, and there is no C compiler.

- **Syntax checking today:** `npm install luaparse` (pure JS, Lua 5.1 — WoW's
  dialect, no admin, no toolchain). A checker lives in the session scratchpad;
  it is not yet in the repo and should be.
  - Known trap: luaparse 0.3.1 **wrongly rejects `break;`** under `luaVersion:
    '5.1'` while accepting `return;`, though Lua 5.1's grammar
    (`block ::= {stat [';']} [laststat [';']]`) permits both. It false-positives
    on Auctionator's `Imports_LegacyAH/TableBuilder.lua`. Normalise that token
    before believing a 5.1 failure.
  - All 412 installed addon Lua files parse clean.
- **What is actually wanted:** `luacheck`, which catches the failure that bites
  in WoW — a typo'd global silently resolving to `nil`. It needs Lua + luarocks
  and admin on Windows, but `validate.yml` already runs on `ubuntu-latest` where
  it is two lines. It needs a `.luacheckrc` declaring WoW globals, and the
  ForeverProbe dump can generate one from *this* client rather than someone's
  Retail snapshot.
- SavedVariables are written **CRLF**. Normalise before grepping, and scope
  searches to the right block — the file contains both a `globalFunctions` list
  and per-namespace member lists, so an unscoped grep for `GetItemInfo` matches
  `C_Item.GetItemInfo` and tells you the opposite of the truth.

## Open questions

1. **Does Auctionator actually break at an auctioneer on Forever?** Inferred, not
   observed. Decides upstream-vs-fork for the whole goal.
2. **~~What should the WoW MCP server be, now?~~ Resolved 2026-09-20.** It was
   built on the client's own capture and is attached as `wow-api`; the
   scraped-public-data shape was correctly rejected. What is left is a defect,
   not a design question: `list_deprecated` returns an incomplete removed-list
   (see Legacy globals). Reconcile it against the ForeverProbe dump so the two
   sources agree. Keep the numbering in this section stable — Next steps
   references these items by number.
3. **Is the housing market live on the beta?** `C_Housing.IsHousingMarketEnabled`,
   `IsHousingMarketShopEnabled`, `IsHousingMarketCartFullRemoveEnabled` and
   `C_HousingCatalog.GetCatalogEntryRefundTimeStampByRecordID` describe an
   economy with a cart and refund windows that does not exist on Classic Era. If
   the AH path stays blocked, this may be the better target. Read the documented
   signatures first; do not sweep-call the namespace.
4. **Does `11601` appear on any real Forever addon**, or is it purely a
   CurseForge metadata error? Zero occurrences across all installed tocs so far.

## Next steps, in order

1. Open an auctioneer on Forever. Settle question 1.
2. Push `forever-probe` and merge to `master`.
3. Move the luaparse checker into the repo and wire `luacheck` into
   `validate.yml`, with a `.luacheckrc` generated from the ForeverProbe dump.
4. Extract the housing/AH signatures from the dump into a readable reference —
   the first genuinely shareable artifact here, and the MCP's seed.
5. Depending on 1: fork Auctionator to add `camelot` gates, or re-evaluate
   LibAHTab now that the client reports mainline and has the modern AH API.
6. Read Auctionator's own `AGENTS.md` in the live install before writing any
   integration code.

## Working preferences

Infra/platform engineering background — skip 101-level explanations, assume a
senior baseline. Direct, no flattery or filler. If something is ambiguous, state
the assumption and proceed rather than blocking on a question. Prefer
incremental, reversible, testable changes. Call out failure modes, rate limits
and validation steps explicitly. Complete code blocks over fragments unless
isolating a specific fix. Say plainly when something could not be verified.
