# Adventurer Plates

A character "business card" for WoW: Forever — portrait, title, guild,
playstyle tags, active hours and a motto — modelled on Final Fantasy XIV's
**Adventurer Plate** (Patch 6.1).

Named after the FFXIV feature it borrows from. FFXIV splits the idea in two:
the **Adventurer Plate** is the card, and **Portraits** is the separate
pose/lighting/framing editor that feeds it a picture. This addon keeps that
split.

Origin: [a post by Shobek](https://x.com/Shobektv/status/2101665615115153745)
asking for the feature in Forever. Nothing here depends on Blizzard shipping it.

**The landscape card is the supported layout.** An earlier portrait layout is
kept at [`AdventurerPlatesPortrait`](../AdventurerPlatesPortrait) for
comparison — shelved, not deprecated, and installable alongside this one with
its own saved data and its own `/advportrait` command. You do not need it.

| | this addon | shelved portrait |
| --- | --- | --- |
| folder | `AdventurerPlates` | `AdventurerPlatesPortrait` |
| command | `/advplate`, `/aplate` | `/advportrait`, `/aportrait` |
| SavedVariables | `AdventurerPlatesDB` | `AdventurerPlatesPortraitDB` |
| shape | 800 x 448 landscape | 440 x 604 portrait |

## Why landscape

Reshaped after an actual FFXIV Adventurer Plate, which is roughly 2:1 with the
character portrait as a full-height hero image on the right. The portrait
version reads as a settings panel; this one reads as a card.

What the reference changed, concretely:

- **Landscape, ~2:1.** The single biggest difference, and the reason it reads
  as a card at all.
- **Portrait is the hero.** Full height on the right, 290px wide, bleeding to
  the border — not a 150x190 thumbnail in a corner. It also uses a much wider
  camera (`SetPortraitZoom(0.06)` rather than `0.35`) so more than a head is in
  frame.
- **Level and class are typographic.** Small `LEVEL 8` above a large,
  class-coloured `HUNTER`, with race beneath — a focal point instead of the
  flat sentence `Level 8  Windshaper Skyborne  Hunter`.
- **Two hour labels, not four.** FFXIV marks only 12am and 12pm. Four labels
  (`00 06 12 18`) turned the strip into a chart; two keeps it a shape you read
  at a glance. Ticks are also taller than wide and more tightly spaced.
- **Realm moved top-right**, freeing the most valuable vertical space on the
  card.
- **Playstyle is a row of badges**, not a wrapped list of text.

## The badges, and what they are not

FFXIV uses real icon art. **This does not, deliberately.**

Icon art means a texture path, and there is no verified source of
playstyle-category art on this client. Guessing an `Interface\ICONS\...` string
from memory is exactly the class of mistake that produced the `Menu.ModifyMenu`
error documented in the original addon's README — a confident claim sourced from
recall rather than observation.

So each badge is a coloured field carrying a two-letter abbreviation, defined by
`abbr` and `rgb` on `D.TAGS`. It needs no texture path, reads at a glance, and
is honest about being a stand-in. Swapping in real art later is a texture call,
not a re-layout.

There *is* one verified icon source on this client — `GetProfessionInfo`
returned real fileIDs (136247 Leatherworking, 134366 Skinning, 136245 Fishing) —
but it covers professions only, not "Mentor" or "World PvP".

## Commands

| Command | What it does |
| --- | --- |
| `/advplate` | command list (also `/aplate`) |
| `/advplate show` | show or hide your Adventurer Plate |
| `/advplate edit` | open the plate editor |

### Development-only commands

**These are not in released builds.** `scripts/package-addon.ps1` drops
`Probe.lua` from the package, because `/advplate risky` calls undocumented
globals and can crash the client -- a reasonable thing for the author to run
deliberately, and a bad thing for a curious user to find in a command list.
Run the addon from a checkout to get them.

| Command | What it does |
| --- | --- |
| `/advplate probe` | **Tier A** capability probe — documented API only. Safe. |
| `/advplate report` | reprint the last Tier A result |
| `/advplate risky` | **Tier B** — calls undocumented globals. Can crash the client. |
| `/advplate risky <n>` | resume Tier B from step `n` |

The probe is duplicated in the shelved portrait addon rather than shared,
because `AGENTS.md` requires each addon to be self-contained and forbids
reaching across addon folders. Its findings are recorded above under *Observed
on this client*.

## Status

**Built, syntax-checked, not yet run in game.** The portrait original has been
run and its model portrait confirmed rendering on build 69913, which is what
justified making the portrait the hero element here — but this specific layout
has not been seen on screen yet.

## Client support

Forever only (`## Interface: 16001`). Not Classic Era -- `C_EncodingUtil` is
the spine of the sharing design and Classic Era has no equivalent without
pulling in LibSerialize and LibDeflate.
