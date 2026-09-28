# content-ops — generating session content without drifting

How a development session becomes publishable content, and what stops the
content being wrong. Two gates, one blocklist, no chat transcripts.

Written after a Gemini-drafted content pack was checked against this repo and
found to contain 21 factual errors — see `media/generated-draft-review.md` for
the list. The mechanism below is the response to it.

## The failure this prevents

A generator reading a **chat transcript** produces claims nothing downstream can
check. The transcript is not addressable, not diffable, and gone next week.

A generator reading the **repository record** produces claims that can be
checked, because the record is versioned. That is the whole design.

```
  the record                        mechanical                 probabilistic
  ──────────                        ──────────                 ─────────────
  facts-build-69913.md  ──────┬───► (already curated)  ──────► /content-pack
  .toc / CHANGELOG /          │                                      │
  README / HANDOFF /          └───► session-digest.js ──┐            │
  commit bodies                        (JSON)           │            ▼
                                                        ├──► check-content-pack.js   (written)
                                                        └──► check-episode.js        (spoken)
                                                                     │
                                                        exit 0 ──────┴────── exit 1
                                                        read it            fix it
```

Generation stays probabilistic — that is what it is good at. Verification is
deterministic, and it is the half that makes the output trustworthy.

## The two inputs

**`facts-build-69913.md` is the source of truth and outranks everything.** It is
hand-compiled, it carries judgement about which facts matter, and it has now
caught errors in two independent drafts — including one written by someone who had
read the whole repository first. Its *Things that are NOT true* section is the
single most load-bearing thing in this pipeline: both gates parse it, so adding a
falsehood there blocks it in written *and* spoken content with no code change.

**A digest is the cheap mechanical version, for sessions that do not have a fact
sheet yet.** `session-digest.js` takes a commit range and emits the same shape
automatically: commits with author-local timestamps and bodies, per-addon `.toc`
metadata, changelog sections, the vendored-library license table, named HANDOFF
sections verbatim, release state, and a vocabulary block the gate builds its
allowlists from.

It does not replace curation. It means the next session's fact sheet starts as a
filled-in skeleton instead of a blank file.

```bash
node scripts/session-digest.js --range 9ae20b1..1a5e613
node scripts/session-digest.js --since '2026-09-20 18:00' --branch master
node scripts/session-digest.js --out -            # stdout
```

Output lands in `dist/` (gitignored). Timestamps keep the author's UTC offset —
normalising to UTC puts the build window in the wrong hours and nobody catches it
until someone compares it to a VOD.

## The two gates

| | `check-content-pack.js` | `check-episode.js` |
| --- | --- | --- |
| Input | markdown drafts | episode transcript |
| Rules from | fact sheet blocklist + digest | hardcoded, tuned for this episode |
| Tolerates | markdown, quoted claims | speech-to-text artifacts, spoken numbers |
| Fails on | ungrounded facts | wrong or missing figures |

```bash
node scripts/check-content-pack.js docs/media/social-copy.md \
  --digest dist/digest-9ae20b1-1a5e613.json
```

Without `--digest` it still runs the blocklist, handle and caveat rules and
reports the seven it skipped, rather than passing silently.

### The rules, and why each exists

| Rule | Fails when | The draft that caused it |
| --- | --- | --- |
| `factsheet-blocklist` | a claim in *Things that are NOT true* appears un-negated | six of the seven fired on one draft |
| `client-name` | a client not in `X-Target-Client` is asserted | called a Forever addon "World of Warcraft Classic", six times |
| `release-claim` | release language with no git tag | "packaged CurseForge release"; nothing was uploaded |
| `license-name` | a license not on the addon or its vendored libs | "MIT vs GPL-2.0"; there is no GPL in the tree |
| `ungrounded-symbol` | an API identifier absent from the record | `ANCHOR_TOPLEFT` — not a frame anchor point in any WoW API |
| `ungrounded-number` | byte/pixel/chunk/line/count figures absent from the record | caught two out-of-range citations in the corrected draft |
| `version-string` | a version matching no `.toc` or changelog heading | — |
| `unknown-handle` | an @-mention outside `media/contacts.yml` | tagged a reviewer instead of crediting the person who requested the feature |
| `platform-claim` | a streaming platform not on record | cited "Twitch VODs"; the stream is YouTube |
| `duration-drift` | a stated hour figure more than 1 h from the digest | — |
| `caveats-dropped` | the unverified surface is documented and the draft omits it | read as a finished product while a third of the fields had never held real data |

Checks are per line. A line that negates or contrasts may name what it rules out,
so "not Classic Era" stays legal — the same call `check-episode.js` makes via
`hit.negated`. Review documents pass `--exempt-heading`; a single line can carry
`<!-- check:quote -->`. The handle and caveat rules are never exempt.

### Regression fixture

```
original Gemini draft    24 FAILED    exit 1
docs/media/social-copy.md     PASSED  exit 0
```

Reproducible against this repo with a digest of `9ae20b1..1a5e613`.

## The one discipline this asks for

A `Content-Beat:` trailer on commits that carry a story:

```
Order the editor by frame level, not by strata

The editor had been jumped to FULLSCREEN_DIALOG to stop plate text punching
through its panel. That worked, and overreached: it also outranked every
other DIALOG frame, including BugSack, which sits at DIALOG level 1000.

Content-Beat: promoting a panel to the top layer put it over the error window
```

One line, written while the fix is in hand. The digest collects them into
`beats[]`. It is the difference between a generator inferring a narrative from a
diff and being handed one.

Everything else the pipeline needs, this repo already does: a Keep a Changelog
file, `X-` fields in the `.toc`, a handoff with named sections, and commit bodies
that explain rather than restate. That is why it works at all.

## What neither gate can do

They ground facts. Neither detects a well-formed lie.

- **Invented anecdotes pass.** One draft claimed a muted-mic incident during the
  session. It did not happen, and no rule catches it, because the claim has no
  wrong token in it. Only the author knew.
- **Implied causation passes.** "We pivoted to landscape and it resolved the
  collisions" builds a false link from two true facts. The layout changed for
  design reasons; the collisions were fixed separately.
- **Tone passes.** A draft can be factually clean and still sound like nobody
  involved.

A green gate means the figures and names are right. It is a floor. Nothing ships
without a human read — `check-episode.js` says the same thing in its own header,
and it is the more important half of both.

## Failure modes

- **Digest range too narrow.** A true figure from earlier work reads as
  ungrounded. Widen `--range`; do not delete the fact.
- **Thin commit messages.** The ceiling is the record's quality. A repo of "fix
  stuff" commits produces a thin pack, correctly.
- **Concurrent sessions.** Two agents on one branch means a digest can miss
  commits landing after it ran, and a file read early in a session can be stale
  by the end. `HANDOFF.md` already warns about this; it has happened twice,
  including to the session that wrote this file. Re-digest before generating.
- **Rules drifting into censorship.** If the gate starts blocking true
  statements, the fix is a better digest or a more precise blocklist entry, not a
  looser rule. Permanent `--warn-only` is the same as deleting it.

## Scheduling

**Capture automatically, generate on request.** A `SessionEnd` hook writing a
digest is free, deterministic and runs while the commit range is still
recoverable — worth wiring up. Generating a pack every session produces drafts
nobody reads and trains you to stop reading them.

```json
{
  "hooks": {
    "SessionEnd": [
      { "hooks": [{ "type": "command", "timeout": 60,
          "command": "mkdir -p dist && node scripts/session-digest.js --repo . 2>>dist/session-digest.log || true" }] }
    ]
  }
}
```

Not enabled in this repo — merge it into `.claude/settings.json` if you want it.
`mkdir -p dist` is load-bearing: the redirect is evaluated before node runs, so
without it the whole command fails on a clean checkout and `|| true` hides that.

## Publishing to Google Docs

**The Drive connector cannot edit an existing Google Doc's body.** It creates
files and changes a file's title and parent; there is no body update and no
comment write. So "regenerate into the same Doc" is not available.

Markdown here stays canonical; publish to Drive per revision and treat the Doc as
a distribution copy. Drive's markdown conversion also mangles some emoji — a 👇
came back as `ð` — so check anything containing them after upload, or add emoji at
posting time instead.
