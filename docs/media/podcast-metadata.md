# Podcast episode metadata — Runtime Reality

Release date **2026-09-25**. Channel convention `S26.E{MMDD}` → **S26.E0925**.

⚠️ **Chapters below are for the 36:56 cut.** If the 47:15 version ships instead,
they need regenerating from that transcript — the section boundaries move.
Everything else on this page applies to either.

---

## Title — three options

Your two best-performing videos (124 and 55 views) both name a **concrete
incident** in the title. Everything titled by topic sits at 3–6. Option A leans
into that.

**A — concrete hook (recommended)**
```
S26.E0925 – An AI Said the Function Didn't Exist. It Did. Four Errors in Four Hours.
```

**B — catalogue style**
```
S26.E0925 – Four Confident Wrong Answers, a Beta Client, and the Limits of Plausible Reasoning
```

**C — generator's own**
```
S26.E0925 – Why Plausible AI Logic Fails Verification
```

---

## Short description

For podcast apps. Keep under ~300 characters.

```
An AI made four confident, plausible, completely wrong claims during one
development session on a beta game client. None were caught by better
reasoning. Each was caught by reading a primary source at the moment the
answer felt already known.
```

---

## Show notes

```
Four and a half hours of AI-assisted development on World of Warcraft: Forever
build 69913 — a beta client where most legacy Lua APIs have been removed and
the survivors were kept inconsistently.

The addon works. That is not the story. The story is that the AI produced four
confident claims that were false, and every one was caught the same way.

ERROR 1 — An API documented as absent
The project's own notes recorded "zero occurrences in this client's surface"
as established fact. A three-line type() check found it immediately. Two
independent sources of truth were structurally blind in different ways: the
API index covers the C API, and a runtime _G walk sees functions and C_*
namespaces. A Lua table inside a plain global falls through both.

ERROR 2 — A migration that would have destroyed what it was upgrading
Wiping stored data on a schema mismatch reads as reasonable defensive coding.
The capability probe had just written its results into that table. Bumping the
schema would have deleted the evidence justifying the upgrade.

ERROR 3 — The textbook-correct answer that broke every message
ASCII 31, the unit separator, is the character the standard provides for
exactly this purpose. Chomp's CheckLoggedContents rejects the range it sits in
and throws on every send. Caught by opening the library source instead of
assuming.

ERROR 4 — A rescue plan that had it backwards
Two saved files, and the one visible on screen was empty on disk. WoW flushes
SavedVariables at /reload or logout, so the file lags memory by one reload.
The migration would have faithfully overwritten the full dataset with nothing.

THE PATTERN
Not one of these was caught by reasoning — every error was arrived at by sound
reasoning from its inputs. Not by general caution either; being careful is a
disposition, it does not tell you which file to open. What caught all four was
the same act in four costumes: reading the specific primary source at the
moment the answer felt already known.

MEASURED IN THIS EPISODE
Build 69913. ASCII 31. CBOR 386 bytes, Deflate 293, Base64 392 — the encoded
output larger than the input it started from, paying for a chunk boundary
rather than for compression. Two chunks at 240. Race ID 96.

HONEST CAVEAT
Roughly a third of the addon's fields were never exercised. Sharing has never
been tested with a second player; guild and title display have never rendered
real data. An episode about verification that overstated its own completeness
would be self-refuting.

LINKS
Source, tooling and commit history — https://github.com/justadakaje/wow-addons
Measured findings for build 69913 —
  https://github.com/justadakaje/wow-addons/blob/master/docs/facts-build-69913.md
Unedited session, Part 1 — https://youtu.be/guSsG1I_XX0
Unedited session, Part 2 — https://youtu.be/lAFS9JJeLPA
Written version — [BLOG URL, backfilled in Phase 4]

Tool used: Claude Code. The MCP server verified API calls against a custom
index — correctness, not speed.
```

---

## Chapters — 36:56 cut

Derived from the transcript, not estimated.

```
00:00  "Zero occurrences in this client's surface"
03:42  The thesis: plausible is not verified
06:18  Error 1 — two sources of truth, both blind
11:58  Error 2 — the migration that ate its own evidence
17:31  Error 3 — ASCII 31, the textbook answer that failed
23:17  Error 4 — the rescue plan that had it backwards
30:48  What this means for AI-assisted engineering
35:48  What was never verified
```

---

## Tags / keywords

```
AI-assisted development, AI coding assistant, verification, primary sources,
Claude Code, MCP, World of Warcraft addon, Lua, beta software, undocumented
APIs, schema migration, data loss, SavedVariables, wire format, CBOR, Base64,
software engineering, technical debt, code review
```

---

## Before publishing

- [ ] Accuracy gate passed — `node scripts/check-episode.js transcript.txt`
- [ ] Listened once for tone and flow (the script checks facts, not quality)
- [ ] Blog link left as a placeholder — it does not exist yet
- [ ] Both VODs confirmed embeddable, not age-restricted

## After publishing

Capture **three** values onto the URL Ledger:

```
Podcast (Apple)     https://...
Podcast (Spotify)   https://...
Spotify embed ID    ...
```

The **embed ID** is the one that is easy to forget and the one Phase 3 needs —
both blog posts carry a player, not just a link. Nothing downstream moves until
all three are recorded.
