# Adventurer Plates

A character "business card" for WoW: Forever — portrait, title, guild, playstyle
tags, active hours and a motto — modelled on Final Fantasy XIV's **Adventurer
Plate** (Patch 6.1).

Named after the FFXIV feature it borrows from. FFXIV splits the idea in two: the
**Adventurer Plate** is the card, and **Portraits** is the separate pose/lighting
/framing editor that feeds it a picture. This addon keeps that split.

Origin: [a post by Shobek](https://x.com/Shobektv/status/2101665615115153745)
asking for the feature in Forever. Nothing here depends on Blizzard shipping it.

## Status

**v0.1.0-probe — capability probe only. No plate UI yet.**

The probe exists because three things could not be settled from the API index
offline, and the repo rule is to verify rather than guess:

1. **Which model widget this client gives us.** `FrameAPICharacterModelBase` is
   documented, and `DressUpModel` / `ModelSceneFrame` are documented widget
   types, but `PlayerModel` is not in that list. The probe creates all six
   candidates and reports which exist and which methods each carries.
2. **How the right-click menu works here.** `Menu.ModifyMenu` — the modern
   context-menu API — has **zero occurrences** in this client's surface. Only
   `UnitPopup_OpenMenu` and the legacy `UIDropDownMenu_*` family survive. The
   legacy path needs the `UnitPopupButtons` / `UnitPopupMenus` *tables*, which
   are tables and so were invisible to the ForeverProbe function walk.
3. **What the undocumented globals actually return.** `GetGuildInfo`,
   `GetProfessions`, `GetProfessionInfo` and `GetAchievementInfo` all exist in
   `_G` but carry no entry in the client's own documentation, so their
   signatures are unknown.

It also measures the wire format, which decides the whole sharing design.

## Commands

| Command | What it does |
| --- | --- |
| `/advplate` | command list (also `/aplate`) |
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

## Verified API this is built on

All checked against `wow-api` (build 69913, Interface 16001) or the ForeverProbe
`_G` dump — none recalled from memory.

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
- `GetSkillLineInfo` / `GetNumSkillLines` — gone.
- `Menu.ModifyMenu` — does not exist on this client.
- `C_AchievementInfo` exposes five stubs only. Whether achievements are real
  player-facing data here is what Tier B step 4 is for.

## Planned

- **v0.1** local plate + editor: portrait, name/realm, title, guild + rank,
  level/race/class, Playstyle & Focus tags, weekday/weekend active-hours grid,
  motto. Persisted, no network.
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
