# Changelog

All notable changes to Adventurer Plates. Format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions follow
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.3.0] - 2026-09-20

Sharing. You can now ask another player for their Adventurer Plate and see it.

### Added

- **Whisper-pull sharing** over [Chomp](https://github.com/wow-rp-addons/Chomp),
  vendored under `libs/`. `/advplate ask <name>`, or target someone and run
  `/advplate ask`. Nothing is ever sent unasked, and there is no hidden channel.
- **Privacy, enforced on the responder**: `/advplate privacy` with
  Everyone / Guild & Friends / Friends only / Nobody, defaulting to
  **Guild & Friends**. A requester cannot assert who they are — their guild and
  friend status is looked up locally before anything is sent.
- Anyone on your **ignore list gets no reply at all**, rather than a refusal.
  A refusal would confirm you are online and running the addon, which is the
  one thing ignoring should prevent.
- **Received plates render in the same card**, with the Edit button swapped for
  a "My Plate" button so you always know whose you are looking at. Their
  portrait renders only if your client can currently see them; otherwise the
  card says why in words.
- Received plates are cached, so one you have already fetched survives the
  session.

### Security

- Everything arriving over the wire is treated as untrusted. Strings are
  stripped of colour codes, hyperlinks, textures and control characters before
  display; numbers are range-clamped; unknown playstyle tags are dropped and the
  six-tag cap is re-enforced on receipt. A sender cannot draw arbitrary badges
  or inject markup into your UI.
- A received plate only opens a window when **you** asked for it. An
  unsolicited message is cached silently and never puts anything on screen.

### Notes

The wire format is the one measured during the capability probe: CBOR 386 B to
Deflate 293 B to Base64 392 B, two chunks, lossless round trip. Base64 output is
plain ASCII, so it passes the transport's logged-content check with no special
handling.

## [Unreleased]

### Planned

- **v0.2 Portraits** — pose, rotation, zoom, camera, background and frame,
  kept as a separate system from the plate exactly as FFXIV splits them. The
  full legacy model camera surface was confirmed present on build 69913, so
  this is unblocked.
- A richer **Playstyle & Focus** display. The current two-letter badges are a
  deliberate placeholder, not the intended design.
- A **presence ping** on GUILD/PARTY/RAID, so you can see who nearby has a
  plate without asking each of them individually. Deliberately left out of
  0.3.0: pull-on-request is the conservative half, and it is worth confirming
  that works before adding anything that broadcasts.

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
