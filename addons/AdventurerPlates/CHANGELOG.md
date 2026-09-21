# Changelog

All notable changes to Adventurer Plates. Format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions follow
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned

- **v0.2 Portraits** — pose, rotation, zoom, camera, background and frame,
  kept as a separate system from the plate exactly as FFXIV splits them. The
  full legacy model camera surface was confirmed present on build 69913, so
  this is unblocked.
- **v0.3 Sharing** — whisper-pull request/response over
  [Chomp](https://github.com/wow-rp-addons/Chomp), CBOR → Deflate → Base64,
  cached against a content hash. Privacy enforced on the responder:
  Everyone / Guild & Friends / Friends / Nobody.
- A richer **Playstyle & Focus** display. The current two-letter badges are a
  deliberate placeholder, not the intended design.

## [0.1.0] - 2026-09-20

First working version. **Local only — there is no sharing yet.** Your plate is
visible to you and to nobody else until v0.3.

### Added

- **The plate**, an 800x448 landscape card: live 3D portrait, name and realm,
  title, guild and rank, level/race/class, Playstyle & Focus tags, a
  weekday/weekend active-hours grid, and a motto.
- **The editor** (`/advplate edit`): pick up to 6 playstyle tags, paint active
  hours by click or drag, cycle earned titles, and write a motto up to 140
  characters. Edits are held in a working copy, so Cancel is a real cancel.
- **Persistence** to SavedVariables under a versioned schema, with forward
  migrations that never discard data they do not understand.
- `/advplate show` to show or hide the plate.
- A two-tier capability probe (`/advplate probe`, `/advplate risky`) used to
  verify this client's API surface. Not included in release packages.

### Notes on this client

Built and tested against **WoW: Forever 1.60.1, build 69913, Interface 16001**.
Forever only — `C_EncodingUtil` is the spine of the planned sharing design and
Classic Era has no equivalent without extra libraries.

Every API call was verified against the client's own documentation or observed
live. Where the two disagreed, the observation won; the addon README records
those disagreements, including one documented claim that turned out to be
wrong.

### Known gaps

- **Guild and title display are unverified.** The test character has no guild
  and none of 111 titles, so both render their empty-state sentences. The code
  paths exist and have never shown real data.
- **The portrait fallback has never fired.** The 3D model has loaded on every
  run, so the "could not render" sentence is written but unseen.
- Playstyle badges are coloured two-letter glyphs rather than icon art, because
  no verified source of category artwork exists on this client yet.
- English only.

[Unreleased]: https://github.com/justadakaje/wow-addons/tree/master/addons/AdventurerPlates
[0.1.0]: https://github.com/justadakaje/wow-addons/releases/tag/adventurerplates-v0.1.0
