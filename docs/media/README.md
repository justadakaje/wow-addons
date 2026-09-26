# docs/media/

Production material for the recorded sessions: the podcast episode brief, the
fact sheet it is checked against, and the notes for cutting video.

Everything here is text. Recordings and rendered images stay out of the repo —
see **What is deliberately not here**, below.

## Contents

| File | What it is |
| --- | --- |
| `podcast-fact-sheet.md` | Every measured figure for the episode, plus a blocklist of plausible falsehoods. The accuracy gate checks against this. |
| `podcast-metadata.md` | Title options, show notes, chapters and tags for the released episode. |
| `podcast-steering-brief.md` | Episode brief. Structure, length, tone, hard accuracy rules, post-generation checklist. |
| `podcast-steering-paste.md` | **Paste this one.** The brief minus its checklist, 4,920 chars, fits NotebookLM's measured 5,000-char limit. |
| `podcast-steering-longer.md` | Experimental variant, 4,998 chars. Identical except it asks for 55–65 min and adds a two-host debate directive. |
| `podcast-steering-condensed.md` | Shorter fallbacks for a field under 5,000, plus what each drops. |
| `cold-open.md` | Recording timeline, timestamp anchors derived from saved addon data, candidate clip windows, ffmpeg commands. |
| `commit-history.md` | Snapshot of the session's twelve commit messages, each explaining what was wrong and why it was believed. |
| `highlight-reel-chapters-SOURCE-TIMESTAMPS.txt` | Raw Streamlabs Highlighter export. **Not usable as-is** — see below. |
| `highlight-reel-chapters.txt` | **Use this one.** Converted to reel positions from the render log, with titles rewritten from frames. |

## Assembling the publish folder

The episode is generated from a staging folder outside the repo
(`F:\videos\publish\`). That folder is an *assembly* of files that live here,
renamed to sort in reading order for the generator.

Nothing automates the copy, so it drifts. Rebuild it from this table:

| Repo file | Publish path | Upload as a source? |
| --- | --- | --- |
| `podcast-fact-sheet.md` | `01-FACT-SHEET.md` **and** `sources/01-FACT-SHEET.md` | **Yes** |
| `podcast-steering-brief.md` | `02-STEERING-BRIEF.md` | **No** — it is the prompt |
| `podcast-steering-paste.md` | `02c-STEERING-PASTE.md` | **No** — it is the prompt |
| `podcast-steering-longer.md` | `02d-STEERING-LONGER.md` | **No** — experimental prompt |
| `podcast-steering-condensed.md` | `02b-STEERING-CONDENSED.md` | **No** — fallback prompts |
| `cold-open.md` | `03-COLD-OPEN.md` | No |
| `commit-history.md` | `sources/03-commit-history.md` | **Yes** |
| `../posts/confidently-wrong.md` | `sources/04-post-confidently-wrong.md` | **Yes** |
| `../posts/forever-api-surface.md` | `sources/05-post-forever-api-surface.md` | **Yes** |
| `../../AGENTS.md` | `sources/06-working-rules.md` | **Yes** |
| `../../HANDOFF.md` | `sources/07-handoff-state.md` | **Yes** |
| `../../addons/AdventurerPlates/Probe.lua` | `sources/08-probe-source.md` | **Yes** |
| `../../addons/AdventurerPlates/Core.lua` | `sources/09-migration-source.md` | **Yes** |
| `../../addons/AdventurerPlates/Share.lua` | `sources/10-transport-source.md` | **Yes** |

The five `06`–`10` files are the repo originals wrapped with a one-line header
saying what each is and which error it belongs to. The `.lua` ones are fenced
inside Markdown because the generator will not ingest a bare `.lua`.

`sources/` therefore holds **nine** files: `01`, `03`–`10`.

### The gap at 02 is deliberate, and it has bitten once

The steering brief is the *customisation prompt*, not source material, so it is
the one numbered file that never goes into `sources/`.

That gap makes the folder look like it is missing a file, which is presumably
why `01-FACT-SHEET.md` was once left out of `sources/` entirely — leaving three
files where the instructions said four.

The consequence was not cosmetic. The brief tells the generator that **every
figure must come from the fact sheet**, and treats the fact sheet's
"Things that are NOT true" section as a **blocklist**. With the file absent,
both instructions pointed at nothing: no figures to cite, and no blocklist
stopping the episode repeating claims like "launched on CurseForge" or
"built with Cursor" — in an episode whose entire thesis is that confident
assertion is not verification.

**If `sources/` does not contain exactly nine files, do not generate.**

### Why nine and not four

The first generation ran on the four-file corpus — 7,147 words — and produced a
**15-minute** episode against a 30–40 minute target. Runtime scales with source
volume, and 7k words cannot sustain a Deep Dive.

The brief made it worse: it said *"Do not pad. If short on material, go deeper
rather than adding scope."* That instruction was written to prevent waffle and
it worked exactly as designed, on a corpus that could not fill the time anyway.

The five additions are on-thesis only. `Card.lua`, `Editor.lua`, `Data.lua`,
`content-pack.md` and the addon README were deliberately left out — they would
have added bulk by pulling the episode straight into its own out-of-scope list.

## Checking a generated episode

```bash
node scripts/check-episode.js transcript.txt
```

Runs the accuracy gate mechanically: required figures present, blocklist
phrases absent, rounding tells caught. Exit 0 clean, 1 on any failure.

Getting a transcript, in order of preference:

1. **NotebookLM's own transcript**, if the Audio Overview offers one
2. **Word** — Home → Dictate → Transcribe, upload the exported audio. Cloud,
   needs an M365 subscription, monthly upload cap.
3. **Local Whisper** — not currently possible here. The installed Python is
   3.8.5 **32-bit**, and ML wheels are 64-bit only. With a 64-bit Python the
   RTX 2070 SUPER would run `faster-whisper large-v3` comfortably.

### What it cannot check

It verifies that the right strings are present and the wrong ones absent. It
cannot tell you a figure was used in the right *context* — `housing-crash` only
confirms `GetMaxHouseLevel` is named, not that it was described as documented
**and** present **and** still crashing.

A passing transcript still needs one listen for tone, structure and flow. The
script means the facts are not wrong; it does not mean the episode is good.

## The chapter export is not usable as exported

`highlight-reel-chapters-SOURCE-TIMESTAMPS.txt` carries **source** timestamps
from the original Part 2 recording, not positions in the cut reel. Its last
marker reads `02:51:24`; the reel runs `31:32`.

Streamlabs Highlighter records where each clip came *from*, not where it
landed. Converting requires scene-detecting the export and mapping the markers
onto the reel timeline in order:

```bash
ffprobe -v quiet -show_frames -of csv=p=0 \
  -f lavfi "movie=REEL.mp4,select=gt(scene\,0.4)" \
  -show_entries frame=pkt_pts_time
```

24 clips should produce 23 internal boundaries. A mismatch means the mapping is
wrong and the chapters will drift.

The file is kept in its raw state, with the trap named in the filename, because
a plausible-looking chapter list is worse than an obviously missing one.

## What is deliberately not here

Consistent with the policy in `../README.md`:

- **Session audio** — `session-part1.mp3` (59 MB), `session-part2.mp3` (83 MB).
  `cold-open.md` documents how to regenerate both from the source recordings in
  one command.
- **Thumbnails and screenshots** — roughly 20 MB of source renders and crops.
  The four that ship in the blog posts are in the WordPress media library
  (IDs 2243–2246) and are reachable from `../content-pack.md`.

Git cannot delta-compress either, so committing them would bloat every clone
of this repo permanently in exchange for files that already live somewhere
addressable.
