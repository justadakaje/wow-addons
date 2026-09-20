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
  chunked under a registered prefix, cached against a content hash. Light
  presence ping on GUILD/PARTY/RAID. Privacy enforced on the responder:
  Everyone / Guild & Friends / Friends / Nobody. No hidden global chat channel
  by default.

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

## Client support

Forever only (`## Interface: 16001`). Not Classic Era — `C_EncodingUtil` is the
spine of the sharing design and Classic Era has no equivalent without pulling in
LibSerialize and LibDeflate.
