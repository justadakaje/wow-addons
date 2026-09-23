# docs/media/

Production material for the recorded sessions: the podcast episode brief, the
fact sheet it is checked against, and the notes for cutting video.

Everything here is text. Recordings and rendered images stay out of the repo —
see **What is deliberately not here**, below.

## Contents

| File | What it is |
| --- | --- |
| `podcast-fact-sheet.md` | Every measured figure for the episode, plus a blocklist of plausible falsehoods. The accuracy gate checks against this. |
| `podcast-steering-brief.md` | Episode brief. Structure, length, tone, hard accuracy rules, post-generation checklist. |
| `cold-open.md` | Recording timeline, timestamp anchors derived from saved addon data, candidate clip windows, ffmpeg commands. |
| `commit-history.md` | Snapshot of the session's twelve commit messages, each explaining what was wrong and why it was believed. |
| `highlight-reel-chapters-SOURCE-TIMESTAMPS.txt` | Raw Streamlabs Highlighter export. **Not usable as-is** — see below. |

## Assembling the publish folder

The episode is generated from a staging folder outside the repo
(`F:\videos\publish\`). That folder is an *assembly* of files that live here,
renamed to sort in reading order for the generator.

Nothing automates the copy, so it drifts. Rebuild it from this table:

| Repo file | Publish path | Upload as a source? |
| --- | --- | --- |
| `podcast-fact-sheet.md` | `01-FACT-SHEET.md` **and** `sources/01-FACT-SHEET.md` | **Yes** |
| `podcast-steering-brief.md` | `02-STEERING-BRIEF.md` | **No** — it is the prompt |
| `cold-open.md` | `03-COLD-OPEN.md` | No |
| `commit-history.md` | `sources/03-commit-history.md` | **Yes** |
| `../posts/confidently-wrong.md` | `sources/04-post-confidently-wrong.md` | **Yes** |
| `../posts/forever-api-surface.md` | `sources/05-post-forever-api-surface.md` | **Yes** |

`sources/` therefore holds **four** files: `01`, `03`, `04`, `05`.

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

**If `sources/` does not contain exactly four files, do not generate.**

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
