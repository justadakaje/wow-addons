# Fact Sheet — Adventurer Plates session, 2026-09-20/21

**Single source of truth for every number.** Use this twice: as an input to the
episode generator, and as a checklist against the generated audio before it
ships.

> **Why this file exists.** The episode's thesis is *an AI was confidently wrong
> and verification caught it*. If the generator drifts on one figure — says
> ASCII 30 instead of 31, or rounds 392 bytes to 400 — the episode undermines
> its own argument in the most clippable way possible. Every number below was
> measured, not estimated.

---

## Client under test

| Fact | Value |
| --- | --- |
| Game | World of Warcraft: Forever (beta) |
| Version | 1.60.1 |
| Build | **69913** |
| Interface | **16001** |
| Build date | Sep 17 2026 |
| `WOW_PROJECT_ID` | 1 (equals `WOW_PROJECT_MAINLINE`) |
| Test character | Aeldorath Zephrai, level 8 |
| Race | Windshaper Skyborne — race ID **96**, not a Classic race |
| Class | Hunter |
| Realm | ClassicBetaPvE2 |
| Guild | none |
| Titles known | **0 of 111** |
| NDA status | Confirmed NDA-free (verify before broadcast) |

## The four errors — the episode's spine

### 1. `Menu.ModifyMenu` was documented as absent. It exists.

- Project notes recorded "zero occurrences in this client's surface" as fact.
- An in-client `type()` check found it immediately.
- **Two independent blind spots** caused it:
  - The API index documents the **C** API; `Menu` is a FrameXML **Lua** table.
  - The `_G` dump walks top-level *functions* and `C_*` namespaces; `Menu` is a
    plain non-`C_` global **table**.
- The real picture is **inverted**: the modern API is live, and the *legacy*
  path is gutted — `UnitPopupButtons` is `nil`.
- `UnitPopupMenus` is a real table with **39 menus**, including
  `DISCORD_USER`, `DISCORD_USER_SELF`, `NEIGHBORHOOD_ROSTER`.

### 2. The migration would have destroyed the probe data

- Old `InitDB` wiped the entire database on any schema mismatch.
- The probe results had just been written into that table.
- The very next change bumped `DB_SCHEMA` 1 → 2, which would have deleted them.
- Same shape as a prior incident: an earlier addon lost a **98-minute session**
  to a crasher in `PLAYER_LOGOUT` — the act of saving destroyed the data.
- Fix: forward-walking migrations keyed by source schema; unknown version
  **disables features and leaves data alone**.

### 3. ASCII 31 broke every message

- Used ASCII **31** (unit separator) as the field separator. Textbook choice.
- Chomp's `CheckLoggedContents` rejects `[%z\001-\009\011-\031\127]` as
  `ASCII_CONTROL` and **errors the send**. Not a dropped message — a thrown
  Lua error on every call.
- Found by reading Chomp's `StringManip.lua`, not by testing.
- Replaced with **`~`**: outside the Base64 alphabet, not `|` so not a WoW text
  escape, no Lua pattern meaning, illegal in character and realm names.

### 4. The rename plan was inverted

- Assumed the card addon's data needed rescuing. Read both files first:

```
AdventurerPlatesDB      6 tags, hours, full motto, updated 1789952629
AdventurerPlatesCardDB  0 tags, empty motto,       updated 0
```

- The on-screen data had **never been flushed to disk**. WoW writes
  SavedVariables at `/reload` or logout, *then* loads addons — the file always
  lags memory by one reload.
- The planned migration would have rescued the **empty** table over the real one.
- Actual outcome: keeping the name kept the variable, so the data was inherited
  with **zero migration code**.

## Measured wire format

```
CBOR      386 B
Deflate   293 B   (-24%)
Base64    392 B   (+34%)
JSON      517 B   (for contrast)

round trip: LOSSLESS
chunks:     2, at 240 B
```

- **Base64 output (392 B) is larger than the CBOR it started from (386 B).**
  Compression is not paying for the encoding — it pays for the chunk boundary.
  Base64 of raw CBOR ≈ 515 B = three chunks.
- Decision rule was pre-registered: *two chunks → stay native.* It came in at
  two, so **no LibDeflate dependency**.

## The crash model

- `C_Housing.GetMaxHouseLevel` **access-violates the client**.
- It is **documented** AND **present at runtime** (one of `C_Housing`'s 63
  functions in the `_G` walk).
- So `if C_Foo and C_Foo.Bar then` is a nil-guard, not a crash-guard.
- `pcall` catches Lua errors, **not access violations**.

## Namespace coverage

```
documented C_ namespaces    277
runtime C_ namespaces       269
documented AND present      250
documented, NOT present      27
present, NOT documented     ~19
```

## Model widgets

| widget | documented (24) | legacy camera (15) |
| --- | --- | --- |
| `PlayerModel` | 24/24 | 15/15 |
| `DressUpModel` | 24/24 | 15/15 |
| `CinematicModel` | 24/24 | 15/15 |
| `TabardModel` | 24/24 | 15/15 |
| `Model` | 24/24 | 15/15 |
| `ModelScene` | **0/24** | 1/15 |

- `PlayerModel` is **not** one of the 18 documented `FrameAPI*` families. Works
  anyway.
- **No documented method was missing** on any model type.
- Trap: a **hidden** model frame will not load geometry. `SetKeepModelOnHide(true)`
  before `SetUnit`, or you get `false` and display ID 0 and misdiagnose it.
- `CanSetUnit` is **not a predicate** here — returns `nil` for every token,
  including deliberately invalid ones.

## Undocumented globals that work

```
GetGuildInfo("player")  ->  name, rankName, rankIndex, realm
GetProfessions()        ->  5, 7, nil, 6, nil, nil
GetProfessionInfo(i)    ->  8 values; 7th is the skill-line ID
                            165 Leatherworking, 393 Skinning, 356 Fishing
GetAchievementInfo(id)  ->  all nil  (achievements not player-facing)
```

- `C_GuildInfo` has **39 functions and none returns your own guild name or
  rank**. The undocumented global is the only path.

## Gone from this client

`GetItemInfo`, `GetSpellInfo`, `UnitAura`, `GetAddOnMetadata`, `UnitPVPRank`,
`GetPVPRankInfo`, `GetSkillLineInfo`, `GetNumSkillLines`.

**Kept inconsistently:** `IsSpellKnown` survives while `GetSpellInfo` does not.
There is no pattern.

## Auction house — the unblocked side project

```
AUCTION_HOUSE_SHOW                     1
AUCTION_HOUSE_BROWSE_RESULTS_ADDED     3
AUCTION_HOUSE_BROWSE_RESULTS_UPDATED   1
AUCTION_HOUSE_NEW_RESULTS_RECEIVED     4
AUCTION_HOUSE_THROTTLED_MESSAGE_SENT   9
AUCTION_HOUSE_CLOSED                   1

legacy AUCTION_ITEM_LIST_UPDATE etc.   ZERO
```

- Modern `C_AuctionHouse` with all **85 functions** at runtime.
- Auctionator **degrades silently** — no Lua errors. The prediction in the
  project notes ("should throw rather than no-op") was wrong.
- **Five** gates omit `camelot`, not four: `Libs_ModernAH`, `Imports_ModernAH`,
  `Assets_ModernAH`, `Source_ModernAH`, `Source_Mainline`.

## Dependency cost of Chomp

```
addon's own code     1,608 lines
Chomp core           1,587 lines
its three deps         935 lines
vendored total       2,522 lines   (~61% of the shipped addon)
```

- Chomp's own `Libs/` is **empty in git** — filled at package time from
  CurseForge SVN via `.pkgmeta`. A plain clone does not run.
- All three deps are hard requirements despite `## OptionalDeps`.
- Versions: Chomp **37**, LibStub **2**, CallbackHandler-1.0 **8**,
  ChatThrottleLib **32**.
- Licenses: ISC, Public Domain, BSD-3, Public Domain.

## Session shape

| | |
| --- | --- |
| Part 1 recording | `2026-09-20_19-07-38.mkv`, **02:03:23** |
| Part 2 recording | `2026-09-20_21-12-04.mkv`, **02:53:31** |
| Third file | `2026-09-21_00-44-14.mkv` — **corrupt, unreadable, not content** |
| Total content | **4h 56m 54s** |
| Commits | 12 |
| Shipped versions | v0.1 (local plate) → v0.3 (sharing) |
| Published to CurseForge | **NO** — deliberately held |

## Things that are NOT true — do not let these into the episode

- ❌ "Started from a blank IDE / zero to MVP." The addon already existed; the
  probe was written and **never run**.
- ❌ "Chomp was deferred for stability." It was **adopted**; v0.3 ships sharing.
- ❌ "Launched on CurseForge." **Not published.** Package built and verified only.
- ❌ "Debated MIT vs GPL." The repo already had an MIT license from 2020. Only
  the copyright year changed.
- ❌ "It's an RP addon." It is explicitly **out-of-character** social
  matchmaking, distinguished from Total RP 3.
- ❌ "Used Cursor." **Claude Code.**
- ❌ "The MCP server accelerated development." It **verified API calls**.
  Correctness, not speed.

## Still unverified at session end

- **All of sharing** — no plate has ever been sent or received. Needs a second
  player.
- **Guild display** — test character has no guild.
- **Title display** — 0 of 111 titles known; level 20 is the beta cap.
- **Portrait fallback** — the model loaded every time, so the failure sentence
  has never appeared.

Roughly a third of the card's fields are correct-looking and unexercised.
