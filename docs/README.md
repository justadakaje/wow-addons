# docs/

Written output *about* this repo — findings, published posts, and media
production notes. No addon code lives here.

`AGENTS.md` keeps each addon self-contained under `addons/<AddonName>/` and
forbids reaching across addon folders. This directory sits outside that rule
because none of it is loaded by the game; it exists so the evidence gathered
while building the addons is findable without replaying a chat transcript.

## Contents

| Path | What it is |
| --- | --- |
| `facts-build-69913.md` | **Start here.** Every measured fact about WoW: Forever build 69913, in one place. |
| `posts/` | Published blog posts, as the Markdown they were written from. |
| `media/` | Podcast and video production notes for the recorded sessions. |
| `content-pack.md` | Release order for the five artifacts from one session, and what blocks what. |
| `content-ops.md` | How session content gets generated and gated. Two checkers, one blocklist. |
| `trello-board-readme.md` | Conventions for the AIVibecoding Trello board. Served as its Read Me Power-Up. |

## `facts-build-69913.md`

The condensed, checkable version of what `HANDOFF.md` records in prose: API
surface, the crash model, measured wire-format numbers, namespace coverage,
model widget support, auction house findings, and an explicit list of claims
that are **not** true.

It was built as a fact-check sheet for a podcast episode, which forced it into
a useful shape — every figure traceable, and a blocklist of plausible-sounding
falsehoods. That makes it the fastest way to sanity-check a claim about this
client without re-deriving it.

Where this file and `HANDOFF.md` disagree, `HANDOFF.md` is the working document
and wins on anything about *current project state*. This file wins on
*measurements*, because it was compiled from the saved probe output directly.

## `posts/`

- `confidently-wrong.md` — four AI errors during one session and what caught
  each. The argument: verification beats reasoning where documentation is
  incomplete.
- `forever-api-surface.md` — reference. What this client removed, kept,
  silently broke, and exposes undocumented.

Published at [musingsofmy.today](https://musingsofmy.today). Kept here so the
written record is version-controlled alongside the code it describes.

## `content-ops.md`

The mechanism that keeps generated content from drifting: `facts-build-69913.md`
as the source of truth, `scripts/session-digest.js` to extract the same shape for
any commit range, and two gates that share one blocklist —
`scripts/check-content-pack.js` for markdown, `scripts/check-episode.js` for
audio.

It exists because a content pack drafted from a chat transcript contained 21
factual errors. `media/generated-draft-review.md` lists them.

## `media/`

- `podcast-fact-sheet.md` — every measured figure for the episode, plus a
  blocklist of plausible falsehoods. The accuracy gate checks against this.
- `podcast-steering-brief.md` — episode brief with hard accuracy rules and a
  post-generation checklist.
- `cold-open.md` — recording timeline, timestamp anchors derived from saved
  addon data, candidate clip windows, and the ffmpeg commands to cut them.
- `commit-history.md` — the session's commit messages, each explaining what was
  wrong and why it was believed.
- `highlight-reel-chapters-SOURCE-TIMESTAMPS.txt` — raw Streamlabs export.
  Not usable as exported; the filename says why.

See `media/README.md` for how the out-of-repo staging folder is assembled from
these files, and which of them are uploaded as generator sources. Getting that
wrong has already cost one silent defect.

Large binaries — recordings, extracted audio, thumbnail renders — deliberately
stay out of the repo. `cold-open.md` documents how to regenerate the audio from
the source recordings in one command.
