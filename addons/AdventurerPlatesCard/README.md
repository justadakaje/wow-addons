# Adventurer Plates (Card)

A **landscape card** layout of the Adventurer Plate, for WoW: Forever.

This is a deliberate **fork** of [`AdventurerPlates`](../AdventurerPlates), not
a replacement. Both addons install and run side by side, each with its own
SavedVariables and its own slash command, so the portrait layout stays available
and comparable rather than living only in git history.

| | portrait original | this fork |
| --- | --- | --- |
| folder | `AdventurerPlates` | `AdventurerPlatesCard` |
| command | `/advplate`, `/aplate` | `/advcard`, `/acard` |
| SavedVariables | `AdventurerPlatesDB` | `AdventurerPlatesCardDB` |
| shape | 440 x 604 portrait | 800 x 420 landscape |

**They do not share saved data.** Editing your card does not change your plate.
That is the point of the fork — two designs, two datasets, no interference.

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
| `/advcard` | command list (also `/acard`) |
| `/advcard show` | show or hide your Adventurer Card |
| `/advcard edit` | open the card editor |
| `/advcard probe` | **Tier A** capability probe — documented API only. Safe. |
| `/advcard report` | reprint the last Tier A result |
| `/advcard risky` | **Tier B** — calls undocumented globals. Can crash the client. |

The capability probe is carried over unchanged. It is duplicated rather than
shared because `AGENTS.md` requires each addon to be self-contained and forbids
reaching across addon folders; the duplication is the sanctioned cost. Its
findings are recorded in the original addon's README and are not repeated here.

## Status

**Built, syntax-checked, not yet run in game.** The portrait original has been
run and its model portrait confirmed rendering on build 69913, which is what
justified making the portrait the hero element here — but this specific layout
has not been seen on screen yet.

## Client support

Forever only (`## Interface: 16001`), same as the original.
