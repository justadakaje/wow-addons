# AIVibecoding

Kanban for the **WoW: Forever / Adventurer Plates** content pack — one
4.5-hour AI-assisted dev session turned into six published artifacts.

Board: <https://trello.com/b/8c97BkqP/aivibecoding>
Repo mirror: `docs/content-pack.md` in `justadakaje/wow-addons`

## Columns

| Column | Means |
| --- | --- |
| 📋 Project Info | Reference. Never moves. |
| Backlog | Real work, not prioritised. |
| Ready | Dependencies met. Can start today. |
| In Progress | Hard limit, set by the List Limits Power-Up. Finish before starting. |
| ⛔ Blocked | Every card names its blocker in line 1. |
| 🔍 Review / Verify | Built, not yet checked. Never skipped. |
| ✅ Done | Shipped, verified, URL recorded. |

Cards sort top-down by priority. In **Ready** and **⛔ Blocked**, the top card
is the critical path.

## Card prefixes

`P2` podcast · `P3` blog posts · `P4` backfill · `VOD` / `REEL` YouTube ·
`REPO` GitHub · `ADDON` in-game verification · `HK` housekeeping

## The critical path

Strictly sequential — each step waits on the one above it.

1. Generate the episode
2. Run the 10-point accuracy gate
3. Publish episode, capture three URLs
4. Insert callout + Spotify embed into both posts
5. Publish 2235 → 2234 → back-link
6. Backfill blog URLs into VODs and show notes

**Step 3 is the pinch point.** Nothing downstream moves until the Spotify
*embed ID* reaches the URL Ledger — not just the episode link.

`VOD · Finalise` sits off the path but must land before step 5: the posts carry
four YouTube embeds, and non-public videos render as "Video unavailable."

## Parallel tracks

**Reel** — off the critical path, blocks nothing. `REEL · Convert chapter
markers` → `REEL · Publish`. The Streamlabs export carries *source*
timestamps, not reel positions; its last marker reads `02:51:24` against a
`31:32` video, so it needs scene-detection first.

**Independent:** `HK · Machine housekeeping`, plus two Backlog cards for addon
verification that would shrink the "unverified third" caveat.

## Definition of Done

All four must hold:

1. Published and reachable at a real URL
2. That URL recorded on the 🔗 URL Ledger card
3. Every claim traceable to `docs/media/podcast-fact-sheet.md`
4. Public content carries the "roughly a third unverified" caveat

## Division of labour

Claude handles WordPress — inserts, publishing, cross-links, media metadata —
and the repo. Anything reaching YouTube or the podcast host is yours: no
connector in the session gets there.

## Repo conventions

Every GitHub PR gets a card here, and the card carries the PR URL. Merges and
pushes land on the board as they happen, not batched at the end.

Record the **commit SHA and timestamp**, not a tick. A SHA can be verified
later. A tick cannot.

## Why Review / Verify is a column

The pack's thesis is that verification beats confident assertion, and every
artifact repeats it. One factual error refutes all six in the most quotable way
available — so checking is a stage, not a checkbox.

## This board has already been wrong

`REPO · Merge PR #2` was created in Ready for work that had been finished for
thirteen hours. The board was built from a planning doc whose box was still
unticked, and nobody re-read the PR until the merge was attempted.

A tracker is a claim about the world, not the world. It goes stale silently and
in exactly one direction: work gets done, the box stays unchecked.

**Before trusting a checkbox here, check the primary source** — `gh pr view`,
`git log`, the live post, the actual folder.
