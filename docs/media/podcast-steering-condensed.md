# Condensed steering prompts

**Measured 2026-09-22: NotebookLM's Audio Overview "Customize" field truncates
at exactly 5,000 characters.** Not bytes — characters.

## Use `02c-STEERING-PASTE.md` (4,920 chars)

That is the full brief with the post-generation checklist removed. It ends
cleanly on the honesty requirement and leaves 80 characters of headroom.

Pasting the full `02-STEERING-BRIEF.md` (5,521 chars) also works: only the
last 521 are lost, and those are the 10-point checklist — an instruction for
the producer, not the generator. But it truncates mid-word, leaving a dangling
"confirm against `01-FACT-" that the generator may try to act on. The paste
version avoids that.

**Nothing the generator needs is lost either way.** Audience, thesis, all six
structure sections, target length, the accuracy rules, tone, out-of-scope and
the honesty requirement all fit inside 5,000.

## Bytes are not characters

`wc -c` reports bytes. The brief is 5,569 bytes but 5,521 characters — em
dashes and arrows cost 3 bytes each and 1 character each. A 48-character
overstatement does not matter at 5,521, and matters a great deal at 4,920 with
80 to spare. Measure characters when checking against a field limit.

## The tiers below are for a shorter field elsewhere

A Gem system instruction, a different tool, or any box under 5,000. They are
ordered by what survives compression: audience, thesis, structure, then the
accuracy rules.

---

## TIER 1 — 414 chars

Senior engineer audience; skip the basics. Thesis: an AI's confidence tracks
how plausible a claim is, not how verified it is. Cold open on the
Menu.ModifyMenu moment, then four errors at equal time. 30-40 min. Every figure
from the fact sheet, never rounded: ASCII 31, 392 bytes, build 69913. Never
claim CurseForge, an RP addon, or Cursor - it was Claude Code. Close by saying
a third of the addon is unverified.

---

## TIER 2 — 873 chars

Audience: senior engineers. Do not explain what an API, Lua, or version control
is.

Thesis: an AI's confidence tracks how PLAUSIBLE a claim is, not how VERIFIED it
is, and those two come apart hardest where documentation is incomplete.

Cold open, 30-60s: the Menu.ModifyMenu moment - a claim recorded in the
project's own notes as established fact, disproved by a three-line check. Hook
before framing.

Then the four errors, roughly equal time. This is an argument, not a build log.

Target 30-40 minutes.

Every figure must come from the fact sheet. Never round: ASCII 31, not "a
control character". 392 bytes, not "about 400". Build 69913.

Never say: launched on CurseForge (it was not), an RP addon (it is
out-of-character social matchmaking), or built with Cursor (it was Claude
Code).

Close by stating plainly that roughly a third of the addon was never verified.

---

## What is lost at each tier

**Tier 2 drops:** the per-section time budget, the "resist the moral" tone
note, the explicit out-of-scope list (features, UI, packaging), and the
reasoning behind the structure.

**Tier 1 also drops:** the parenthetical corrections, the cold-open duration,
and the instruction to say out loud when a figure is not in the sources.

Every tier keeps the four things that make the episode fail if lost: the
thesis, the cold open, no rounding, and the blocklist.

## If the generator drifts anyway

Do not patch the audio. Regenerate with the failing figure named explicitly in
the prompt. A spliced correction is audible, and this episode is trading on
exactly the credibility that a visible patch would undermine.
