# Commit history — Adventurer Plates session

Twelve commits, 2026-09-20 into 2026-09-21. These messages deliberately
record what was WRONG and why it was believed, not just what changed.
That is the densest available account of the session's reasoning.

---

## Add a Lua syntax checker to the repo

```
There is no Lua interpreter and no C compiler on this dev machine, so the
only way to catch a syntax error before the game does is to parse it here.
The checker had been living in a session scratchpad; it belongs in the repo.

Wraps luaparse (pure JS, Lua 5.1). Walks addons/ by default, takes explicit
paths otherwise, exits 1 on any failure.

Carries the luaparse 0.3.1 workaround: it rejects `break;` under
luaVersion '5.1' although Lua 5.1 accepts it, since `break` is a laststat and
the grammar allows a trailing semicolon. Verified reproducible rather than
taken on faith. Neutralised by replacing the `;` with a space, which keeps
byte offsets identical so reported line and column numbers stay accurate.

Parsing only proves a file is well-formed; it says nothing about whether the
API it calls exists on this client. That remains the wow-api MCP server's job.

Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>
```

## Drop the stale get_namespace warning from AGENTS.md

```
Commit 740a476 fixed the namespace shadowing: mcp/src/data.ts now keys by
namespace and merges, and reference/api/ was regenerated. The warning was
left in place at the time only to avoid a concurrent-edit collision.

Verified against a rebuilt server before removing it, rather than trusting
the commit message: C_PartyInfo reports 55 functions, C_PlayerInfo 40 and
C_SocialQueue 10 -- exactly the "real functions" column in HANDOFF.md.

Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>
```

## Harden the capability probe before its first run

```
Three changes, all Tier A.

Split the model method list in two, because "absent" means opposite things
for each. DOCUMENTED is the full 24-method FrameAPICharacterModelBase surface
transcribed from get_widget_methods; a missing one is the client diverging
from its own documentation. SPECULATIVE is the legacy Model camera surface,
which carries no documentation here, so its PRESENCE is the finding and what
v0.2 Portraits would be built on. Previously both were averaged into one
present/missing tally that could not distinguish the two.

Probe CanSetUnit across six unit tokens, one deliberately invalid. It is
documented on FrameAPICharacterModelBase, so the portrait-eligibility
question is answerable in Tier A rather than by inference.

Fix a breach of Tier A's own contract: it called GetAverageItemLevel, which
is not in the index for this client. Tier A promises documented API only, and
pcall catches a Lua error but not a native crash -- which is the entire
reason Tier B exists. Item level is not a v0.1 plate field, so Tier A now
reports whether the symbol exists and leaves calling it to a deliberate
Tier B decision. Reading a global is not calling one.

Every other Tier A global was re-audited against the rebuilt index; the rest
all resolve. Method probing now indexes through pcall.

Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>
```

## Build AdventurerPlates v0.1: plate, editor, persistence

```
Portrait, name/realm, title, guild + rank, level/race/class, Playstyle &
Focus tags, weekday/weekend active-hours grid and motto. Local only; no
network code, as planned.

Live facts and stored fields are kept strictly apart. Level, guild, class and
race are re-read on every render and never persisted -- a stored copy goes
stale the moment you level or join a guild, and a stale plate is worse than
no plate. Only tags, hours, motto and chosen title reach SavedVariables.

Schema 1 -> 2 is a real migration, not a wipe. The previous InitDB discarded
the whole database on any schema mismatch, which would have destroyed the
capability probe results the moment DB_SCHEMA moved -- the act of upgrading
destroying the data being upgraded. Migrations are now keyed by source
schema and walked forward one step at a time; an unknown version disables
plate features and leaves stored data alone rather than deleting it.

The editor edits a working copy, so Cancel is a real cancel and a
half-finished edit never reaches disk.

Every missing value resolves to a sentence: "Not in a guild.", "No titles
earned on this character yet.", "No motto written yet." Never a blank field,
never a guessed number.

The portrait calls SetKeepModelOnHide(true) on a shown frame before SetUnit.
The probe's SetUnit test hid the frame first, which is why it returned false
with displayID 0; that was a confound, not a client limitation.

No class-crest artwork: that needs a texture path, and guessing one from
memory is the mistake this repo's rules exist to prevent. The portrait
fallback is a sentence naming the race and class until a path is verified.

Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>
```

## Fork AdventurerPlatesCard: landscape card layout

```
A deliberate fork, not a replacement. Both addons install and run side by
side with separate SavedVariables and separate slash commands, so the
portrait layout stays available and comparable rather than living only in
git history.

Reshaped after a real FFXIV Adventurer Plate:

- 800x448 landscape. The proportion is why it reads as a card rather than a
  settings panel, and it was the single biggest gap against the reference.
- Portrait is the hero: 290px, full height, bleeding to the border, with a
  much wider camera (SetPortraitZoom 0.06 rather than 0.35) so a figure is
  in frame instead of a face.
- Level and class are typographic: small LEVEL n above a large class-coloured
  class name, race beneath -- a focal point instead of a flat sentence.
- Two hour labels, 12am and 12pm, not four. Four turned the strip into a
  chart; two keeps it a shape you read at a glance. Ticks are taller than
  wide and more tightly spaced.
- Realm moved top-right, freeing the most valuable vertical space.
- Playstyle is a row of badges rather than a wrapped list of text.

The badges are coloured fields with two-letter glyphs, NOT icon art. Icon art
means a texture path, and there is no verified source of playstyle-category
art on this client; guessing an Interface\ICONS\ string from memory is the
same class of mistake that produced the Menu.ModifyMenu error. abbr and rgb
now sit on D.TAGS, so swapping in real art later is a texture call rather
than a re-layout.

Every global that would collide if both addons are enabled was renamed and
then verified mechanically: SavedVariables name, the SLASH_* globals and
SlashCmdList key, and the global frame names. The overlap between the two
addons is empty. Lua's per-addon namespace handles everything else.

Probe.lua is duplicated rather than shared because AGENTS.md requires each
addon to be self-contained and forbids reaching across addon folders.

Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>
```

## Record probe results; correct the Menu.ModifyMenu claim

```
The capability probe ran on build 69913. Both tiers completed, nothing
crashed. Documentation moves from "verified against the index" to "observed
on the running client", with the measured numbers.

Wire format decision CLOSED in favour of native Base64. Measured CBOR 386 B
-> Deflate 293 B -> Base64 392 B = 2 chunks at 240 B, round trip lossless.
The pre-registered rule was "two chunks -> stay native", and it came in at
two, so no LibDeflate dependency. Deflate still earns its place: Base64 of
raw CBOR would be ~515 B, i.e. three chunks.

Menu.ModifyMenu EXISTS. The earlier "zero occurrences in this client's
surface" claim was true of the documentation index and false of the client,
and the wrong claim is struck through rather than deleted so the mistake
stays legible. Two independent blind spots produced it: Menu is a FrameXML
Lua table while the index documents the C API, and the ForeverProbe dump
walks top-level functions and C_* namespaces, so a plain non-C_ global table
was invisible to both. The picture is inverted from the assumption -- the
modern API is live and it is UnitPopupButtons that is nil.

Recorded as a general rule: absent from lookup_api means absent from the C
API, not absent from the client.

Also recorded: all six model widget types exist including PlayerModel, with
no documented method missing on any of them; ModelScene correctly carries
none of the character-model surface; all four undocumented Tier B globals
returned cleanly; GetProfessionInfo yields real skill-line IDs; achievements
are confirmed not player-facing here.

Two model readings are explicitly NOT answers. SetUnit returned false on a
frame the probe had hidden, which is a confounded test rather than a client
limitation. CanSetUnit returned nil for every token including an invalid
one, and its documented signature lists no return value, so it is not a
predicate here and cannot serve as a portrait-eligibility test.

Character shape surprises worth designing around: names contain a space
(Forever has surnames) and race Skyborne ID 96 is not a Classic race.

Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>
```

## Order the editor by frame level, not by strata

```
The editor had been jumped to FULLSCREEN_DIALOG to stop plate text punching
through its panel. That worked, and overreached: it also outranked every
other DIALOG frame, including BugSack, which sits at DIALOG level 1000.
An editor panel covering the error window is precisely backwards -- an error
is the one thing that must stay readable.

Within a strata, ordering is by frame level. The plate and card never claimed
one, so they got a single-digit default and lost to anything explicit. The
editor now stays in DIALOG and claims its anchor's level plus 20, read at
open time rather than cached, since levels are assigned by the client.

That orders the two frames we own without outranking frames we do not.
BugSack goes back on top where it belongs.

Also fixes a card layout collision: the ACTIVE HOURS heading sat on the same
line as the 12:00 a.m. label and is wider than the 78px row-label gutter, so
it overran the label and swallowed its leading "1". The heading now has its
own line, and the card grew 420 -> 448 so a two-line motto stays clear of the
action row.

Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>
```

## Make the plate windows click-to-front and stop them stacking

```
With both addons installed, four windows can be open at once and they pile
up unusably. Two independent causes, fixed separately.

Ordering: every window sat in DIALOG at a level it never explicitly claimed,
so four frames from two addons that cannot coordinate ended up interleaved
with no way to reach the one underneath. All four now call SetToplevel(true),
so a click raises that frame within its strata -- the behaviour every other
window on screen already has. Verified SetToplevel is live on this client
(Ace3 uses it) rather than assumed.

Position: both addons defaulted to CENTER, so opening the plate and the card
together stacked them exactly. They now offset in opposite directions --
plate up-left, card down-right -- so both title bars stay grabbable. Neither
addon knows about the other; each just declines to sit dead centre.

Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>
```

## Promote the landscape card to canonical; shelve the portrait layout

```
The landscape card is the decided design, so it takes the AdventurerPlates
name. The portrait layout moves to AdventurerPlatesPortrait -- shelved, not
deleted, so the two designs stay comparable rather than one living only in
git history.

No migration code was needed, and checking the saved data first is why.

The assumption going in was that the card's data would be orphaned by the
rename. The opposite was true: AdventurerPlatesDB (owned by the portrait
addon) held the real dataset -- six tags, the hours, the motto, updated
1789952629 -- while AdventurerPlatesCardDB was empty at updated 0. The card
data visible on screen had never been flushed; SavedVariables are written by
the client on /reload or logout, so an in-memory edit is not yet a saved one.

Because the canonical addon keeps the name AdventurerPlates, it keeps the
variable AdventurerPlatesDB and the file that holds it, and inherits that
dataset intact. Both layouts already persisted an identical shape, so the
card code loads the portrait's saved plate without conversion. Verified by
reading both SavedVariables files before moving anything, and both were
copied out first.

The shelved portrait starts empty, which is correct for an archive: the
dataset it used to own now belongs to the supported addon.

Every colliding global was renamed on both sides and the overlap verified
empty: SavedVariables name, SLASH_* globals, the SlashCmdList key and the
global frame names. Commands are now /advplate for the card and /advportrait
for the shelf.

Git's rename detection pairs some of these files oddly. The fork was a
near-identical copy, so its similarity heuristic has ambiguous candidates;
the content on disk is correct and was spot-checked per folder.

Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>
```

## Add changelog and release packaging; extend LICENSE year

```
The repo already carried an MIT LICENSE; only the copyright year needed
extending to cover active development. No license decision was required.

Adds a CHANGELOG for AdventurerPlates, including its known gaps rather than
only its features: guild and title display have never rendered real data (the
test character has neither), and the portrait fallback path has never fired
because the model has loaded every time.

Adds scripts/package-addon.ps1, which builds a CurseForge-ready zip. It stages
the addon, drops development-only files, rewrites the .toc so it no longer
references them, adds the LICENSE, and produces a zip containing exactly one
top-level folder named after the addon.

Probe.lua does not ship. /advplate risky calls undocumented globals and says
plainly that it can crash the client -- a reasonable thing for the author to
run deliberately, and a bad thing for a curious user to find in a command
list. Its findings are already recorded in the README, so shipping it buys
nothing and costs a crash report nobody can reproduce. The README now splits
its command table into shipped and development-only to match.

Verified by unzipping the built package: one top-level folder, every .lua the
.toc references is present, nothing references the stripped file, and all four
shipped files parse clean.

Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>
```

## v0.3: share plates over Chomp, pull-only with responder-side privacy

```
/advplate ask <name> asks one person for their plate; they decide whether to
answer. Nothing is broadcast, nothing is sent unasked, and there is no hidden
channel.

Privacy is enforced on the RESPONDER, which is the only place it can be. A
requester cannot assert who they are, so the answering client looks up their
guild membership and friend status locally before sending anything. Default is
Guild & Friends. Anyone on the ignore list gets no reply at all rather than a
refusal, because a refusal confirms you are online and running the addon --
the one thing ignoring should prevent.

Everything arriving over the wire is untrusted input. Strings are stripped of
colour codes, hyperlinks, textures and control characters; numbers are
range-clamped; unknown tag keys are dropped and the six-tag cap is re-enforced
on receipt. A received plate opens a window only if this client asked for it;
an unsolicited message is cached silently, so a stranger cannot put a frame on
your screen.

Caught before it shipped: the field separator was ASCII 31, the conventional
unit separator. Chomp's CheckLoggedContents rejects [%z\001-\009\011-\031\127]
as ASCII_CONTROL and errors the send, so every message would have failed. Read
from its StringManip.lua rather than assumed. Now "~", which is outside the
Base64 alphabet, is not a WoW text escape, has no Lua pattern meaning, and
cannot appear in a character or realm name.

The card now renders either your own plate or a received one from a single
view table, rather than branching at every field. A remote portrait draws only
when the client can currently see that unit -- target, mouseover, focus or
party -- and otherwise says so in a sentence naming their race and class.

Vendors Chomp 37 plus LibStub 2, CallbackHandler-1.0 8 and ChatThrottleLib 32.
All four are required: Chomp's own Libs/ is empty in git and filled at package
time from CurseForge SVN, so a plain clone does not run. Licenses are ISC,
Public Domain, BSD-3 and Public Domain respectively, and travel with the code.
See libs/README.md.

Adds scripts/check-toc.js, which verifies every file a .toc references exists.
Written after a mangled path produced a .toc that read plausibly and silently
referenced nothing -- the game does not warn about this.

Schema 2 -> 3 adds the share settings and the received-plate cache. Additive;
existing plates are untouched.

Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>
```

## Update HANDOFF for the v0.1-through-v0.3 session

```
Rewrites the current-work section around what is now true: two addons, the
landscape card canonical and the portrait layout shelved, v0.3 sharing built.

Separates verified-in-game from written-but-unexercised, because that
distinction is the single most useful thing a cold session can be handed here.
Confirmed working: probe both tiers, plate and editor round-tripping through
SavedVariables, the live 3D portrait, migrations 1->2 and 2->3, window
layering, and v0.3 loading with all four vendored libraries. Never exercised:
all of sharing, guild display, title display, and the portrait fallback path --
roughly a third of the card's fields.

Records the correction that matters most as a general rule rather than a
one-off: absent from lookup_api means absent from the C API, not absent from
the client. Menu.ModifyMenu exists; both offline sources were structurally
blind to it for independent reasons.

Marks the gold/AH goal UNBLOCKED. An auctioneer was opened: modern
C_AuctionHouse with all 85 functions, browse queries returning results, zero
legacy AH events, and Auctionator degrading silently rather than erroring. The
event tape is quoted, and the five AllowLoadGameType gates a fork would need
are listed from the toc rather than inferred.

Adds the three new scripts to the inventory, each with the reason it exists,
and deduplicates two stale addon entries.

Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>
```

