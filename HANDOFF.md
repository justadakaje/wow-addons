# Handoff

Working context for picking this repo up cold. Read `AGENTS.md` too — it holds
the rules; this holds the findings, the dead ends, and the open questions.

Last updated 2026-09-20 (second pass, AdventurerPlates session), against WoW:
Forever beta build 69913.

**If you are a new session picking this up:** the active work is
`addons/AdventurerPlates/`, not the gold/AH goal below. Read
`addons/AdventurerPlates/README.md` first, then the "Current work" section
here. The gold goal is real but parked and blocked — see Goal.

> ✅ **`get_namespace` is trustworthy again — confirmed live 2026-09-20.**
> Commit `740a476` ("Merge documented systems that share a namespace") fixed
> the shadowing: `mcp/src/data.ts` keys by namespace and merges, and
> `reference/api/` was regenerated. Confirmed in a fresh session against a
> rebuilt server: `C_PartyInfo` 55, `C_PlayerInfo` 40, `C_SocialQueue` 10. The
> stale warning has been removed from `AGENTS.md`.
>
> **Still a live trap:** `mcp/dist/` is gitignored, so a session whose server
> was never rebuilt still sees the old 2-function `C_PartyInfo`. Before
> trusting `get_namespace`, check it reports those three counts; if it does
> not, run `npm run build` in `mcp/` and restart the server.
>
> ⚠️ **This repo has had more than one agent session working in it at once.**
> Commits `740a476` and `755c2ba` landed on branch `adventurer-plates` from a
> parallel session *after* `6dc0a5f`. Nothing was lost, but check
> `git log --oneline -5` and `git status` before assuming the tree matches what
> you last read. A file read early in a session may be stale by the end of it.

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
  **Corrected 2026-09-20:** `forever-probe` is **fully merged into `master`**
  (`git branch --merged master` lists it; `master...forever-probe` is 6/0). The
  earlier claim that it was one commit ahead and unpushed is stale — that
  branch is safe to delete. Current state: branch **`adventurer-plates`** is 1
  ahead of `master`, `master` is 2 ahead of `origin/master`. **Nothing is
  pushed.**
- **The `wow-api` MCP server IS attached**, and answers from this client's own
  capture. Verified 2026-09-20: `lookup_api`, `search_api`, `get_enum`,
  `get_event`, `get_namespace`, `get_widget_methods` and `list_deprecated` all
  resolve. Every response footers `WoW: Forever 1.60.1 (build 69913), Interface
  16001` — the same build as the ForeverProbe dump, so it is not a pre-1.60.1
  public scrape. Coverage spot-checked on `C_AuctionHouse` and `C_Housing` (62
  documented functions). This supersedes the previous handoff's "NOT attached",
  which was true when written and is no longer. **For any single name prefer
  `lookup_api` over `list_deprecated`** — see Legacy globals for why.

## Current work — AdventurerPlates

**This is what the last session was doing and where a new session should start.**

### What it is

An FFXIV-style **Adventurer Plate** for Forever: a character card carrying
portrait, title, guild + rank, level/race/class, playstyle tags, a weekday /
weekend active-hours grid, and a motto.

Origin: a post by Shobek (`https://x.com/Shobektv/status/2101665615115153745`)
asking for the feature in Forever. The mockup in that post is the entire
requirements document — the thread replies add nothing. Nothing here depends on
Blizzard shipping it.

**Naming, researched:** FFXIV calls it the **Adventurer Plate** — singular, no
apostrophe. The pose/lighting/framing editor is a *separate* system called
**Portraits**. Some third-party guides write "Adventurer's Plate"; that is
wrong. The addon is named "Adventurer Plates" (plural) deliberately, because
that is the phrasing people will search for. CurseForge had no collision for
any spelling as of 2026-09-20.

### State: PROBE RUN 2026-09-20, both tiers, nothing crashed

Tier A and Tier B both completed on build 69913. Results are in SavedVariables
under `AdventurerPlatesDB.probe`. The addon README now says **observed** rather
than verified-against-the-index, and carries the measured numbers.

Headline results:

- **Wire format: 2 chunks.** CBOR 386 B -> Deflate 293 B -> Base64 392 B, round
  trip lossless. The Base64-vs-LibDeflate decision is **closed in favour of
  native Base64**.
- **`Menu.ModifyMenu` EXISTS.** The earlier "zero occurrences" claim was true of
  the documentation index and false of the client.
- **All six model widget types exist**, `PlayerModel` included.
- **All four Tier B globals returned cleanly.** No crash.

Two model readings are NOT yet answers: `SetUnit` returned `false` and
`CanSetUnit` returned `nil` for every token. The `SetUnit` test is confounded —
the probe hides the frame before calling it, and a hidden model will not load
geometry without `SetKeepModelOnHide(true)`. Re-run on a visible frame before
concluding anything about rendering.

### Why a probe before a UI

Three things could not be settled offline, and `AGENTS.md` says verify rather
than guess:

1. **Which model widget exists.** `FrameAPICharacterModelBase` is documented and
   `DressUpModel` / `ModelSceneFrame` are documented widget types, but
   `PlayerModel` is not in that list. The probe creates all six candidates.
2. ~~**How the right-click menu works.**~~ **SETTLED, AND THE PREMISE WAS
   WRONG** — `Menu.ModifyMenu` exists on this client. The claim below was true
   of the documentation index only. `Menu` is a FrameXML *Lua* table; the index
   documents the *C* API, and the ForeverProbe dump walks only top-level
   functions and `C_*` namespaces, so a plain global table was invisible to
   both. Kept for the record: `Menu.ModifyMenu` has **zero occurrences**
   in this client's surface — the modern context-menu API is absent. Only
   `UnitPopup_OpenMenu` and the legacy `UIDropDownMenu_*` family survive, and
   the legacy path needs the `UnitPopupButtons` / `UnitPopupMenus` *tables*,
   which are tables and so were invisible to the ForeverProbe function walk.
3. **What the undocumented globals return.** `GetGuildInfo`, `GetProfessions`,
   `GetProfessionInfo`, `GetAchievementInfo` all exist in `_G` with no
   documentation entry.

It also measures the wire format, which decides the whole sharing design.

### Probe design — respect the two tiers

- `/advplate probe` — **Tier A**, documented API and pure Lua only. Safe.
- `/advplate report` — reprint the last Tier A result.
- `/advplate risky [n]` — **Tier B**, calls the four undocumented globals.

Tier B announces every call *before* making it and is resumable from any step,
because `pcall` catches Lua errors but does **not** stop a native crash —
`C_Housing.GetMaxHouseLevel` access-violates despite being a documented
no-argument getter. If the client dies, the last chat line names the culprit and
`/advplate risky <n>` resumes from the next step.

Nothing in either tier runs at load, and nothing runs in the save path. That is
not stylistic: ForeverProbe lost a 98-minute session to a crasher sitting in
`PLAYER_LOGOUT`.

### Verified API this is built on

Checked against `wow-api` (build 69913) or the ForeverProbe `_G` dump.

**Present and load-bearing**

- `C_EncodingUtil` — `SerializeCBOR`, `CompressString`, `EncodeBase64` and
  inverses. Native serialisation, so **no LibSerialize, no LibDeflate, no Ace**.
  `Enum.CompressionMethod.Deflate = 0`,
  `Enum.CompressionLevel.OptimizeForSize = 2`, `Enum.Base64Variant.Standard = 0`.
- `C_ChatInfo.SendAddonMessage` / `SendAddonMessageLogged` /
  `RegisterAddonMessagePrefix` / `IsAddonMessagePrefixRegistered` /
  `GetRegisteredAddonMessagePrefixes`, `CHAT_MSG_ADDON`, and a full
  `SendAddonMessageResult` enum.
- Titles: `GetNumTitles`, `GetTitleName`, `IsTitleKnown`, `GetCurrentTitle`.
- `RequestTimePlayed` + `TIME_PLAYED_MSG`, `GetServerTime`, `GetGameTime`.
- `CanInspect` / `NotifyInspect` / `INSPECT_READY`.
- Templates `BackdropTemplate`, `UIPanelButtonTemplate`, `InputBoxTemplate`,
  `UICheckButtonTemplate`, `UIPanelScrollFrameTemplate`, `UIPanelCloseButton` —
  all already in use by APLForever on this client, so not in question.

**Absent — design around these**

- `UnitPVPRank`, `GetPVPRankInfo` — gone. No Classic PvP rank badge. Forever
  reworked honor; `UnitHonor`, `UnitHonorLevel`, `GetPVPLifetimeStats` exist.
- `GetSkillLineInfo`, `GetNumSkillLines` — gone.
- ~~`Menu.ModifyMenu` — does not exist.~~ **WRONG, corrected 2026-09-20.** It
  exists and is the path to use; it is `UnitPopupButtons` that is `nil`.
- `C_AchievementInfo` exposes five stubs only — and `GetAchievementInfo(6)`
  returned all `nil`, so achievements are confirmed not player-facing here.
- `C_GuildInfo` (39 functions) has no getter for your own guild name or rank.
  Undocumented `GetGuildInfo("player")` is the only path; observed working.

### Decisions already made — do not relitigate

- **Transport for v0.3 is Chomp** (`wow-rp-addons/Chomp`, ISC). Its `.toc`
  already declares `16001`. Not adopted yet, because v0.1 is local-only and
  taking a dependency before measuring the payload is premature. Pinned so
  nobody builds a worse queue. Full reasoning in the addon README's Prior art
  section.
- **Total RP 3 is not a duplicate.** It is in-character identity; this is
  out-of-character social matchmaking. It also does not run on Forever
  (`## Interface: 120100`, gates omit `camelot`).
- **Base64 vs `LibDeflate:EncodeForWoWChatChannel` is CLOSED — native Base64.**
  Measured 2026-09-20: CBOR 386 B -> Deflate 293 B -> Base64 392 B = **2 chunks**
  at 240 B, round trip lossless. The pre-registered rule was "two chunks -> stay
  native", and it came in at two. Deflate still earns its place: Base64 of raw
  CBOR would be ~515 B, i.e. three chunks.
- **Portrait fallback:** a 3D model renders only for a unit the client can see.
  Target / mouseover / party → live model. Anyone else → class-crest
  composition, and the UI says why. Missing data becomes a sentence, never a
  fabricated picture.

### Roadmap

- **v0.1** local plate + editor, persisted, no network.
- **v0.2** Portraits — pose, rotation, zoom, camera, background, frame. Kept
  separate from the plate exactly as FFXIV splits them.
- **v0.3** sharing over Chomp, whisper-pull + presence ping, privacy enforced on
  the responder.

## Goal

Surface gold-making opportunities in-game: raw materials listed below market
value, and craftables sellable above crafting cost.

**Parked, not cancelled** — the AdventurerPlates work above is what is active.

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
- `addons/AdventurerPlates/` — **the active work.** `Core.lua` (namespace,
  SavedVariables with schema check, chat output, slash dispatch) and `Probe.lua`
  (the two-tier capability probe). Written and syntax-checked, never run. See
  "Current work" above and the addon's own README.
- `addons/AdventurerPlatesCard/` — **landscape fork** of AdventurerPlates,
  reshaped after a real FFXIV Adventurer Plate (800x420, portrait as a
  full-height hero on the right, playstyle as badges, hours labelled only at
  12am/12pm). Separate SavedVariables (`AdventurerPlatesCardDB`) and separate
  slash (`/advcard`), so both run side by side and the portrait layout stays
  available. Built and syntax-checked; NOT yet run in game.
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

### 408 vs 405 vs 394 — the counts, and the bug the old gap hid

**Fixed 2026-09-20.** Historical note kept because the shape recurs.

Three system counts are in circulation. They measure different things:

- **408** — raw documented system entries (`api.json` `systems[]`). Still 408:
  the extractor preserves the capture verbatim and merges only on the way out.
- **405** — distinct namespaces, and what `get_namespace()` with no argument
  now lists. 408 minus the 3 collisions below.
- **394** — `.md` files in `reference/api/`, and now also `counts.systems`.
  It is 405 minus **11 namespaces documenting neither a function nor an
  event** (`C_AccessibilityOptions`, `BagIndexConstants`, `C_CursorUtil`,
  `C_Platform`, `C_Pony`, `C_TraitConfig`, plus five `FrameAPI`/`SimpleAnim`
  shells), which `extract-api.js` skips.

`counts.systems` **was 397** before the fix, counting non-empty *entries*
rather than non-empty *namespaces*. It disagreed with the file count for the
same reason the reference was lossy.

That last subtraction is a defect, not a definition. **System and namespace are
not 1:1** — three pairs of documented systems share one namespace:

| namespace | documented systems | real functions |
|---|---|---|
| `C_PartyInfo` | `PartyInfo` (53 fns, 32 ev) + `PartyInfoSystemStatus` (2, 1) | 55 |
| `C_PlayerInfo` | `PlayerInfo` (33) + `PlayerLocationInfo` (7) | 40 |
| `C_SocialQueue` | `SocialQueue` (8, 2) + `SocialQueueSystemStatus` (2, 1) | 10 |

`extract-api.js` named each file `Namespace || Name`, so the second write
clobbered the first: `reference/api/C_PartyInfo.md` documented **2** functions
where the client has **55**. The same shadowing was in the MCP server, where
`bySystem.set(title.toLowerCase(), sys)` let the last write win, so
`get_namespace("C_PartyInfo")` returned the 2-function entry and hid 53.

Both now collapse systems onto their namespace before indexing or emitting
(`extract-api.js:140`, `mcp/src/data.ts:81` and `:157`), deduping by member
name. Verified after the fix: `C_PartyInfo` 55, `C_PlayerInfo` 40,
`C_SocialQueue` 10, `C_Housing` 62 and `C_AuctionHouse` 85 unchanged, no
duplicates in the system list, totals still 6,577 functions / 1,802 events.

**Scope of the original defect, verified 2026-09-20.** `lookup_api` and
`search_api` were never affected: both index every function of every entry, so
`lookup_api("C_PartyInfo.ConvertToRaid")` and `search_api("ConvertToRaid")`
resolved the shadowed entry even before the fix. Only `get_namespace`
under-reported, and only for those three. On a rebuilt server all three agree,
so "absent from `get_namespace` means it does not exist" holds again — but only
once the three counts above check out.

**`mcp/dist/` is gitignored**, so the committed fix is source-only. Anyone
pulling this must run `npm run build` in `mcp/` and restart the MCP server
before `get_namespace` is correct in their session.

`scripts/extract-api.js` needs `luaparse` at the repo root (`npm install
luaparse`; the root `package.json` and `node_modules/` are gitignored for
exactly this). Regenerate with:

```
node scripts/extract-api.js "<path to>/SavedVariables/ForeverProbe.lua"
```

Still open, and a *different* defect: `list_deprecated`'s removed-list is
incomplete (it omits `LoadAddOn`). See Open questions 2.

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

**Reordered 2026-09-20 — AdventurerPlates is the active track.**

0. **`/reload`, then `/advplate probe`, then `/advplate risky`.** Paste the chat
   output back. This unblocks the whole v0.1 UI and is the single highest-value
   action available. Nothing else in this list should happen first.
0b. Once the probe has run, update the addon README to say "observed" instead of
   "verified against the index", and record the measured chunk count so the
   Base64-vs-LibDeflate decision can close.
0c. Build v0.1 — the plate frame and editor — on whatever the probe reported.

The items below are the parked gold/AH track and the standing infra debt.

1. Open an auctioneer on Forever. Settle question 1.
2. ~~Push `forever-probe` and merge to `master`.~~ **Done — it is merged.** What
   remains is pushing: `master` is 2 ahead of `origin/master` and
   `adventurer-plates` is 1 ahead of `master`, none of it pushed.
3. Move the luaparse checker into the repo and wire `luacheck` into
   `validate.yml`, with a `.luacheckrc` generated from the ForeverProbe dump.
   **New lead:** Total RP 3 ships a `.luacheckrc` with a custom `wow` std
   listing hundreds of globals — use its *structure* as the template, but
   populate the std from the ForeverProbe dump, because theirs is a Retail list
   and this client removed `GetItemInfo`, `GetSpellInfo`, `UnitPVPRank` et al.
   The checker currently lives only in a session scratchpad (`luaparse` 0.3.1 +
   a `check.js`); it is not in the repo and will be lost.
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

### This work is being recorded

As of 2026-09-20 the user streams/records this development (Streamlabs Desktop,
YouTube target, channel "Kenneth Henseler", on-screen label "Adventurer Plates
Addon Dev"). Practical consequences:

- **Forever beta is confirmed NDA-free** — verified by the user in a separate
  session. Showing client internals, the API dump and build numbers is fine.
- **Do not surface the WTF account ID on camera.** SavedVariables live at
  `WTF/Account/1283889#1/...` and that path shows up in tool output. Prefer
  relative paths or elide the account segment when printing.
- Terminal output is being read aloud and shown at 1080p. Favour short, legible
  blocks over wide tables; assume text gets downscaled to phone screens.
- Scene collection is "WoW Forever - Duo" with scenes `Forever Only`,
  `Forever + Claude`, `Claude Only`. The user switches via hotkey, so a long
  silent tool-running stretch is dead air — say what is running.
