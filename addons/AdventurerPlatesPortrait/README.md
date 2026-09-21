# Adventurer Plates (Portrait, shelved)

> **This is not the supported version.** The landscape card at
> [`AdventurerPlates`](../AdventurerPlates) is. This portrait layout is kept
> deliberately so the two designs stay comparable rather than one living only
> in git history, and because it may be worth revisiting.
>
> It installs alongside the card with its own saved data and its own
> `/advportrait` command. It starts empty: the dataset it used to own was
> inherited by the card when that became canonical.

A character "business card" for WoW: Forever — portrait, title, guild, playstyle
tags, active hours and a motto — modelled on Final Fantasy XIV's **Adventurer
Plate** (Patch 6.1).

Named after the FFXIV feature it borrows from. FFXIV splits the idea in two: the
**Adventurer Plate** is the card, and **Portraits** is the separate pose/lighting
/framing editor that feeds it a picture. This addon keeps that split.

Origin: [a post by Shobek](https://x.com/Shobektv/status/2101665615115153745)
asking for the feature in Forever. Nothing here depends on Blizzard shipping it.

## Status

**v0.1 — plate + editor, local only. Probe run 2026-09-20 on build 69913.**

Both probe tiers completed and nothing crashed. Everything in *Observed on this
client* below was seen on the running client, not inferred from the
documentation index. Where the two disagreed, the observation won — and those
disagreements turned out to be the most valuable thing the probe produced.

### The correction worth reading twice

The earlier claim — "`Menu.ModifyMenu` has zero occurrences in this client's
surface" — was a true statement about the **documentation index** and a false
statement about the **client**. `Menu.ModifyMenu` is a live function here.

`search_api("ModifyMenu")` genuinely does return nothing, because `Menu` is a
FrameXML **Lua** table and the index documents the **C** API. The `ForeverProbe`
`_G` dump should have caught it and did not, for a second and independent
reason: it walks top-level global *functions* and `C_*` namespaces. `Menu` is a
plain non-`C_` global *table*, so its contents were invisible — the same blind
spot that hid `UnitPopupMenus`.

**"Absent from `lookup_api`" means "absent from the C API", not "absent from the
client".** For anything Lua-side — `Menu`, `UnitPopupMenus`, `UIDropDownMenu_*`
— both offline sources are structurally blind, and only an in-client `type()`
check answers the question. That is this probe justifying its own existence.

## Commands

| Command | What it does |
| --- | --- |
| `/advplate` | command list (also `/aplate`) |
| `/advplate show` | show or hide your Adventurer Plate |
| `/advplate edit` | open the plate editor |
| `/advplate probe` | **Tier A** — documented API and pure Lua only. Safe. |
| `/advplate report` | reprint the last Tier A result |
| `/advplate risky` | **Tier B** — calls undocumented globals. Can crash the client. |
| `/advplate risky <n>` | resume Tier B from step `n` |

### Why two tiers

`pcall` catches Lua errors. It does **not** stop a null dereference inside a
native call from taking the whole process down — `C_Housing.GetMaxHouseLevel`
access-violates on build 69913 despite being a documented no-argument getter.

So Tier B announces every call *before* it makes it. If the client dies, the
last line on screen names the culprit, and `/advplate risky <n>` picks up from
the next step. Tier B is also ordered least-surprising first.

Nothing in either tier runs at load, and nothing runs in the save path —
`ForeverProbe` lost a 98-minute session to a crasher sitting in `PLAYER_LOGOUT`.

SavedVariables are written by the client only, on `/reload` or logout. Results
are printed to chat immediately for exactly that reason.

## Observed on this client

Measured by `/advplate probe` on 2026-09-20, build 69913. These are readings,
not documentation lookups.

### Wire format — decision closed

```
CBOR      386 B
Deflate   293 B   (-24%)
Base64    392 B   (+34%)
JSON      517 B   (for contrast)

round trip: LOSSLESS
chunks:     2  at 240 B
```

**Two chunks, so the native Base64 path stays.** No `LibDeflate` dependency.
The pre-registered rule was "two chunks → stay native; four or five → revisit",
and it came in at two.

The Deflate step still earns its place, and the numbers show exactly why:
Base64 of *raw* CBOR would be ~515 B, which is **three** chunks. Compressing
first buys precisely one chunk. Note that the Base64 output (392 B) is larger
than the CBOR it started from (386 B) — the compression is not paying for the
encoding, it is paying for the chunk boundary.

Sample plate was a realistic one: 6 tags, both 24-hour grids, guild, rank,
title, motto, portrait settings.

### Model widgets — all six exist

| widget | documented 24 | legacy 15 |
| --- | --- | --- |
| `PlayerModel` | 24/24 | 15/15 |
| `DressUpModel` | 24/24 | 15/15 |
| `CinematicModel` | 24/24 | 15/15 |
| `TabardModel` | 24/24 | 15/15 |
| `Model` | 24/24 | 15/15 |
| `ModelScene` | **0/24** | 1/15 |

`PlayerModel` is **not** one of the 18 documented `FrameAPI*` families and works
regardless. Five types share an identical surface; `ModelScene` carries none of
it, which is correct — it is a scene that hosts actors, not a model itself.

**No `docMissing` on any model type.** Nothing documented was absent.

The full legacy camera set is present — `SetCamera`, `SetPosition`, `SetFacing`,
`SetLight`, `SetCustomCamera`, `SetPitch`, `SetViewTranslation`. v0.2 Portraits
has what it needs.

### Two model results that are NOT yet answers

- **`SetUnit("player")` returned `false`, displayID `0`.** Do not read this as
  "the client cannot render the player". The probe calls `model:Hide()` *before*
  `SetUnit()`, and a hidden model frame will not load geometry unless
  `SetKeepModelOnHide(true)` is set first. **The test was confounded by its own
  setup** and has to be re-run on a visible frame before it means anything.
- **`CanSetUnit` returned `nil` for all six tokens**, including `player` and
  including a deliberately invalid one. Its documented signature lists no return
  value, so index and observation agree: it is not a predicate on this build and
  cannot be used as a portrait-eligibility test.

### Right-click menu — inverted from the earlier assumption

```
Menu                   table
Menu.ModifyMenu        function     <-- EXISTS
UnitPopupMenus         table, 39 menus
UnitPopup_OpenMenu     function
UnitPopupManager       table

UnitPopupButtons       nil          <-- legacy button table GONE
UnitPopup_OnClick      nil
UnitPopup_ShowMenu     nil
UnitPopup_HideButtons  nil
```

The modern API is live and the legacy path is the broken one — `UnitPopupButtons`
being `nil` means the legacy button-table model cannot work at all. Right-click
integration targets `Menu.ModifyMenu`.

The 39 menus include `DISCORD_USER`, `DISCORD_USER_SELF` and
`NEIGHBORHOOD_ROSTER`, which do not exist in Classic.

### Undocumented globals — Tier B, all four survived

```
GetGuildInfo("player")  ->  nil, nil, 0, nil        (no guild on the test char)
GetProfessions()        ->  5, 7, nil, 6, nil, nil
GetAchievementInfo(6)   ->  all nil

GetProfessionInfo:
  [5] "Leatherworking", 136247, 42, 75, 1, 20, 165, 0
  [7] "Skinning",       134366, 72, 75, 2, 25, 393, 0
  [6] "Fishing",        136245,  8, 75, 2, 22, 356, 0
```

`GetProfessionInfo` returns eight values and the 7th is the canonical skill-line
ID — 165 Leatherworking, 393 Skinning, 356 Fishing. Real structured data.
`GetGuildInfo` confirms `(name, rankName, rankIndex, realm)`.
`GetAchievementInfo` returning all `nil` matches `C_AchievementInfo` being five
stubs: achievements are not a player-facing system here.

### Character shape — two surprises

```
UnitFullName  ->  "Aeldorath Zephrai", "ClassicBetaPvE2"
UnitRace      ->  "Windshaper Skyborne", "Skyborne", 96
```

- **Names contain a space.** Forever has a surname system
  (`C_PlayerInfo.ShouldDisplaySurname` exists). Any name parsing that assumes a
  single token breaks — this matters for plate layout now and for whisper
  targeting in v0.3.
- **Race `Skyborne`, ID 96** — not a Classic race. A race→icon map built from
  Classic IDs will not cover it.

Also observed: all 8 frame templates present; prefix registration returned `0` =
`Enum.SendAddonMessageResult.Success`; 111 titles exist but **0 known** on the
test character, so the empty-title path is the default case, not an edge case.

## Verified API this is built on

Checked against `wow-api` (build 69913, Interface 16001) — none recalled from
memory.

**Present and load-bearing**

- `C_EncodingUtil` — `SerializeCBOR`, `CompressString(Deflate)`, `EncodeBase64`
  and their inverses. Native serialisation means **no LibSerialize, no
  LibDeflate, no Ace**. Enums: `Enum.CompressionMethod.Deflate = 0`,
  `Enum.CompressionLevel.OptimizeForSize = 2`, `Enum.Base64Variant.Standard = 0`.
- `C_ChatInfo.SendAddonMessage` / `RegisterAddonMessagePrefix` / `CHAT_MSG_ADDON`,
  with a full `SendAddonMessageResult` enum (`AddonMessageThrottle`,
  `TargetOffline`, `AddOnMessageLockdown`, …) — failures are classifiable.
- Titles: `GetNumTitles`, `GetTitleName`, `IsTitleKnown`, `GetCurrentTitle`.
- `FrameAPICharacterModelBase`: `SetUnit`, `SetPortraitZoom`, `SetRotation`,
  `SetAnimation`, `SetCamDistanceScale`, `GetDisplayInfo` / `SetDisplayInfo`.
- `RequestTimePlayed` + `TIME_PLAYED_MSG`, `GetServerTime`, `GetGameTime`.
- `CanInspect` / `NotifyInspect` / `INSPECT_READY`.
- Frame templates `BackdropTemplate`, `UIPanelButtonTemplate`,
  `InputBoxTemplate`, `UICheckButtonTemplate`, `UIPanelScrollFrameTemplate`,
  `UIPanelCloseButton` — all already in use by APLForever on this client.

**Absent — design around these**

- `UnitPVPRank` / `GetPVPRankInfo` — gone. No Classic PvP rank badge. Forever
  reworked honor; `UnitHonor`, `UnitHonorLevel` and `GetPVPLifetimeStats` exist.
- `GetSkillLineInfo` / `GetNumSkillLines` — gone. Use `GetProfessions` /
  `GetProfessionInfo` instead; undocumented, but observed working.
- `C_GuildInfo` has 39 functions and **none of them returns your own guild name
  or rank**. The undocumented `GetGuildInfo("player")` is the only path, and
  Tier B confirmed it works.
- `C_AchievementInfo` exposes five stubs only, and `GetAchievementInfo(6)`
  returned all `nil`. Achievements are not a player-facing system here —
  settled, not assumed.

~~`Menu.ModifyMenu` — does not exist on this client.~~ **Wrong.** It exists.
See *The correction worth reading twice* above.

## Planned

- **v0.1 — BUILT.** Local plate + editor: portrait, name/realm, title, guild +
  rank, level/race/class, Playstyle & Focus tags (max 6), weekday/weekend
  active-hours grid, motto (140 chars). Persisted to SavedVariables under
  schema 2, no network.
- **v0.2** Portraits: pose, rotation, zoom, camera, background, frame — kept
  separate from the plate, as FFXIV does.
- **v0.3** sharing: whisper-pull request/response, CBOR → Deflate → Base64,
  cached against a content hash. Light presence ping on GUILD/PARTY/RAID.
  Privacy enforced on the responder: Everyone / Guild & Friends / Friends /
  Nobody. No hidden global chat channel by default.
  **Transport is Chomp, not hand-rolled** — see Prior art below.

### Portrait fallback

A 3D model can only be rendered for a unit the client can actually see. Target,
mouseover or party member → live model. Anyone else → a class-crest composition
with race, class and faction, and the UI says why. Per repo rule, missing data
becomes a sentence, never a fabricated picture.

### Playstyle tags

Dungeon Delver · Raider · World PvP · Battlegrounds · Casual Leveling ·
Hardcore/Survival · Roleplay · Professions & Crafting · Gold Making · Collector ·
Mentor · Explorer · **Camping** · **Housing**

The last two are Forever-specific. Camping introduces no new API (it fires
`PLAYER_UPDATE_RESTING`, not housing events), so the tag is self-declared;
Housing is a real 13-namespace system that a later version could read from.

## Prior art

Surveyed 2026-09-20, after the probe was written and before any sharing code.

### Total RP 3 — overlapping plumbing, different product

[Total-RP/Total-RP-3](https://github.com/Total-RP/Total-RP-3), Apache-2.0.

**Not a duplicate of this addon.** TRP3 is an *in-character* identity system:
custom RP name, race, class, physical description, backstory, "Currently",
relationship status, IC/OOC toggle. It answers *who is my character in the
fiction*. An Adventurer Plate is *out-of-character* social matchmaking — real
class/level/guild, what content you like, when you actually play. It answers
*should we group up*. Square Enix shipped these as separate systems for the
same reason: Play Style tags and an Active Time grid only mean anything OOC.
TRP3's closest field is a single free-text "OOC information" box — prose, not
queryable tags or an hours histogram.

**TRP3 does not run on Forever.** `## Interface: 120100` (Retail 12.1, single
value, no `16001`), and its `AllowLoadGameType` gates list `vanilla`, `tbc`,
`mainline`, `mists`, `wrath` — no `camelot`. That is the same split-brain the
repo HANDOFF documents for Auctionator: Lua reports mainline so the branches
take the Retail path, while the `.toc` sees `camelot` and never loads the gated
files. There is currently no RP-profile addon serving Forever players at all.

*Verification depth: the `.toc` was read through a summarising fetch, not raw.
The Interface number is certain; the gate list is worth a `grep camelot` on a
clone before anyone relies on it.*

### Decision: use Chomp for v0.3 transport

[wow-rp-addons/Chomp](https://github.com/wow-rp-addons/Chomp), **ISC** licensed,
by Justin Snelgrove. It is the transport layer TRP3 sits on, and its `.toc`
already declares Forever:

```
## Interface: 120105, 120100, 50504, 30802, 20506, 16001, 11509
```

A rewrite of ChatThrottleLib with automatic message splitting, priority queues,
Battle.net game-data messaging and prefix management:

```lua
AddOn_Chomp.RegisterAddonPrefix(prefix, callback, prefixSettings)
AddOn_Chomp.SmartAddonMessage(prefix, data, kind, target, messageOptions)
AddOn_Chomp.SendAddonMessage(prefix, text, kind, target, priority, queue, callback, callbackArg)
```

That is the whole chunking-and-throttling problem, already solved and throttle-
tested at RP-server scale, under a license that asks only that the header be
kept.

It spans Interface 11509 through 120105 because its version-fragile surface is
tiny: it calls only `C_ChatInfo.RegisterAddonMessagePrefix` and
`IsAddonMessagePrefixRegistered` directly, and reaches the send path through
ChatThrottleLib. Both of those exist here, and `SendAddonMessageLogged` and
`C_BattleNet.SendGameData` both appear in this client's
`SendAddonMessageResult` consumers, so Chomp's full send surface is present.

**Not adopted yet, deliberately.** v0.1 is local-only with no comms at all, and
taking a dependency before the payload is measured is premature. The decision is
pinned so nobody spends a session building a worse queue.

### Patterns worth imitating, not copying

From `totalRP3/Core/CommunicationProtocol.lua` (Apache-2.0 — copying is legal
with attribution; the value is the shape):

```lua
Communications.sendObject(prefix, object, channel, target, priority, messageToken, useLoggedMessages, queue)
Communications.registerSubSystemPrefix(prefix, callback)
Communications.registerMessageTokenProgressHandler(messageToken, sender, onProgressCallback)
Communications.estimateStructureSize(object, shouldBeCompressed)
```

- **Message tokens** — a short id tying multi-chunk transfers together, with an
  attachable progress handler, so a slow fetch shows a spinner instead of
  hanging.
- **One registered prefix, sub-system routing underneath.** Blizzard caps
  registered prefixes. TRP3 registers exactly `"TRP3.3"` and multiplexes.

### Independent confirmation of the wire format

`totalRP3/Core/EncodingUtil.lua` wraps **`C_EncodingUtil.CompressString` /
`DecompressString`** and native Base64. A long-lived addon with a very large
install base chose the same native path over LibDeflate. That is about as good a
confirmation as an unrun design gets.

### One open trade they resolved differently

`totalRP3/Core/Compression.lua` does not use Base64 for the wire-safe step — it
uses `LibDeflate:EncodeForWoWChatChannel`. Addon message channels cannot carry
arbitrary bytes, so compressed output must be escaped. Base64 is the obvious
safe choice at a flat **+33%**; LibDeflate's encoding is denser because it only
escapes the byte values the chat protocol actually chokes on.

**Hold this decision until the probe prints the real byte count.** If Base64
lands at two chunks, adding a dependency to save a third of ~400 bytes is a bad
trade. If it pushes to four or five, revisit.

### Also worth lifting

TRP3 ships a `.luacheckrc` with a custom `wow` std listing hundreds of globals —
which is repo HANDOFF next-step #3 sitting on a shelf. Caveat matching this
repo's own rule: theirs is a **Retail** list, and this client removed
`GetItemInfo`, `GetSpellInfo`, `UnitPVPRank` and friends. Use their file as the
structural template and populate the `std` from the ForeverProbe dump, which is
this client's actual surface.

## Client support

Forever only (`## Interface: 16001`). Not Classic Era — `C_EncodingUtil` is the
spine of the sharing design and Classic Era has no equivalent without pulling in
LibSerialize and LibDeflate.
