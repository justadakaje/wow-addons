---
name: content-pack
description: Draft written content — blog post, show notes, social copy, store listing — from a development session in this repo. Use when asked to write up a session, draft a post, produce social copy, or build a content pack. Reads the fact sheet and a session digest, never a chat transcript.
---

# content-pack

Draft written content about a session in this repo, from the record rather than
from recollection.

**The chat transcript is not a source.** It is unaddressable, gone next week, and
summarizing it is what produced the 21 errors in
`docs/media/generated-draft-review.md` — including the wrong game client six
times and a release that never happened. Read `docs/facts-build-69913.md` and a
session digest instead.

## Before writing anything

1. **`docs/facts-build-69913.md`** — every measured figure, and a
   *Things that are NOT true* blocklist. This outranks everything else on
   numbers. Read the blocklist first; it is shorter than the fact list and it is
   where drafts fail.
2. **`docs/README.md`** — check whether the artifact already exists. Two blog
   posts and the episode metadata are written and published. Producing a
   competing draft of published work is worse than producing nothing: it invites
   someone to ship the wrong one.
3. **A digest**, for anything outside the 2026-09-20/21 session:

   ```
   node scripts/session-digest.js --range <A..B>
   ```

   Widen the range rather than citing a figure from memory — the gate rejects an
   ungrounded number, and it is right to.

## Writing

One markdown file under `docs/media/` (social, listing, production copy) or
`docs/posts/` (blog). Lead with what the piece needs before it can ship —
`docs/content-pack.md` holds the dependency order, and most social copy is a
leaf that cannot go out until the blog URLs exist.

Draw the narrative, in order of value:

- `docs/facts-build-69913.md` — *The four errors* section is the spine of this
  session's story. It is already shaped for narrative use.
- `commits[].body` in the digest, or `docs/media/commit-history.md` — the commit
  messages explain what was wrong and why it was believed. Prefer them over
  inventing a framing.
- `record.handoff["Decisions already made — do not relitigate"]` — decisions with
  their costs.
- `record.handoff["Two traps found the hard way"]` — the anecdotes.
- `changelog[version]` — what shipped, in the author's own words.

**Carry the caveats.** The fact sheet's *Still unverified* section goes into the
piece, not just the footnotes. Roughly a third of the card's fields have never
displayed real data. Content that omits this reads as a finished product and the
gate fails it.

## Then gate it

```
node scripts/check-content-pack.js <file.md> --digest dist/digest-<a>-<b>.json
```

Non-zero exit means do not deliver. Fix the draft, or widen the digest range if
the claim is true but out of scope. Never delete a rule or add `--warn-only` to
get green.

A review or corrections document has to quote the claims it refutes. Pass
`--exempt-heading 'Heading One,Heading Two'` for those sections, or mark a single
line with `<!-- check:quote -->`. The handle and caveats rules are never exempt.

For anything spoken, `scripts/check-episode.js` is the gate instead — same
blocklist, tuned for speech-to-text.

## Hard rules

Each one is an error that shipped. The gate catches most; you are the only check
on the last two.

1. **Never name a client that is not in the `.toc`'s `X-Target-Client`**, except
   in a clause that rules it out. This is WoW: Forever, not Classic.
2. **Never say released, published or shipped** unless a git tag exists. A built
   zip is not a release, and this addon is deliberately unpublished.
3. **Never say the addon started from nothing.** It already existed; the
   capability probe had been written and never run.
4. **Never describe a dependency as dropped** if it is in the `.toc` or
   `libs/README.md`. Chomp was adopted, and it is ~61% of the shipped addon.
5. **Never say the MCP server accelerated development.** It verified API calls.
   Correctness, not speed.
6. **Never call this an RP addon.** Out-of-character social matchmaking,
   distinguished from Total RP 3.
7. **Never name a license outside `libs/README.md` and the repo `LICENSE`.** MIT
   has been here since 2020; only the copyright year changed.
8. **Never write an API identifier that is not in the record** — not in prose and
   not in an image prompt. `ANCHOR_TOPLEFT` is not a frame anchor point.
9. **Never @-mention a handle outside `docs/media/contacts.yml`.**
10. **Never round a figure.** 392 bytes, not "about 400". ASCII 31, not "a
    control character in the thirties". The whole argument is that the
    textbook-correct answer failed, and rounding destroys it.
11. **Never invent an anecdote.** If it is not in a commit body, the fact sheet
    or the handoff, it did not happen. A draft claimed a muted-mic incident that
    never occurred; no rule catches that, because an invented story contains no
    wrong token.
12. **Art prompts follow every rule above.** Two of the 21 errors existed only in
    image prompts, and those are the part most people see.

## What the gate cannot do

It grounds facts. It passes a well-formed lie, an implied causation assembled
from two true facts, and a tone the author would not use. A pass means the
figures and names are right. Nothing ships without the author reading it.
