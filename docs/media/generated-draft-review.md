# Review — the generated content draft, 2026-09-22

A content pack for the 2026-09-20/21 session was drafted by Gemini from a chat
transcript, then checked against this repository. **21 factual errors.** This
records what they were, what caught each one, and the two that nothing
mechanical could have caught.

It is filed here because the errors are reproducible: `scripts/check-content-pack.js`
against the draft returns 24 failures, and every rule in that script exists
because of a specific line below.

Long-form version, with the corrected artifacts: Google Doc
`1-J8EvxKCNWbOYZ0PCkqbDXwXEbRElMn7rHly30h20Y0` — *Adventurer Plates: Content Pack
Review (rev 2, corrected)*. It was renamed on 2026-09-26 because the working
title led with a claim the fact sheet blocks <!-- check:quote --> — see the table
at the end. A document title is content too.

---

## Why a transcript-sourced draft fails this way

Every error below is *plausible*. None is a hallucination in the obvious sense —
each is the kind of thing that would be true of a similar project. The draft
said Classic because most WoW addons are for Classic; it said CurseForge
release because sessions that build a release zip usually upload it; it said
MIT-versus-GPL because that is a real debate addon authors have.

This is the same failure mode `posts/confidently-wrong.md` documents inside the
session — confidence tracking plausibility rather than verification — reappearing
one layer up, in content *about* the session. The fix is the same: check against
a record, not against a recollection.

## Premise-breaking

**1. The client. Said "World of Warcraft Classic" six times.**
`X-Target-Client: WoW: Forever (camelot)`, Interface 16001, build 1.60.1.69913.
The addon README is explicit that Classic Era cannot run it: `C_EncodingUtil` is
the spine of the sharing design and Classic has no equivalent without
LibSerialize and LibDeflate. Caught by `client-name`.

**2. The release. Claimed a packaged CurseForge release, and a "PUBLISHED" badge in a video prompt.**
Not published — deliberately held. `package-addon.ps1` produces a verified zip;
the project has not been claimed. The repo carries no tags at all, so the
changelog's `[0.1.0]` link points at a tag that does not exist. Caught by
`release-claim`.

**3. Chomp, inverted. Said it was scrapped for a local-only v0.1.**
`9ae20b1` pinned Chomp as the v0.3 transport at 19:11 EDT — two hours *before*
v0.1 was built — and `8003d0e` shipped it. Four libraries, 2,522 vendored lines,
~61% of the shipped addon. It was scheduled, not dodged, and the cost came in
larger than the original decision assumed. Caught by `factsheet-blocklist`
("Chomp was deferred for stability").

**4. The dependency that actually died was LibDeflate, and the draft never mentions it.**
Pre-registered rule: two chunks → stay native. Measured CBOR 386 B → Deflate
293 B → Base64 392 B, 2 chunks at 240 B, lossless. It came in at two, so no
LibDeflate. Deflate stayed on the same evidence — Base64 of raw CBOR is ≈515 B,
three chunks. Omission; no rule catches a missing story.

## Technically wrong in ways the audience notices

**5. The UI problem. Said "anchor collisions" and overlap with the minimap.**
It was frame strata versus frame level. The editor had been jumped to
`FULLSCREEN_DIALOG` to stop plate text punching through its panel; that also
outranked every other `DIALOG` frame including BugSack at level 1000 — an editor
panel able to cover the error window. Fix: stay in `DIALOG`, claim the anchor's
frame level + 20, read at open time because levels are assigned by the client.
Then `SetToplevel(true)` on all four windows, and both addons stopped defaulting
to `CENTER` so they no longer stacked exactly. The minimap was never involved.

**6. `ANCHOR_TOPLEFT` / `ANCHOR_BOTTOMRIGHT` are not frame anchor points.**
Frame points are the bare strings `"TOPLEFT"` and `"BOTTOMRIGHT"`; the `ANCHOR_*`
constants belong to `GameTooltip`. The draft put them on screen as the fix.
Caught by `ungrounded-symbol` — neither appears in any file in this repo.

**7. The real layout collision, which the draft missed.**
The **ACTIVE HOURS** heading shared a line with the `12:00 a.m.` row label, is
wider than the 78 px label gutter, and overran it — swallowing the leading "1"
so the label read `2:00 a.m.` Heading moved to its own line; card grew 420 → 448
so a two-line motto clears the action row.

**8. The landscape change was a fork, not painful re-anchoring.**
`f6efd95` built it as a *separate addon* with its own SavedVariables and slash
command so both layouts could run side by side and be compared live; `af2333e`
promoted landscape and shelved the portrait — shelved, not deleted, still
installable. Sharing no globals was verified mechanically, not by eye. The
reason was design, measured against a real FFXIV plate: ~2:1, portrait as
full-height hero at 290 px with `SetPortraitZoom(0.06)` rather than `0.35`, two
hour labels instead of four. The draft replaced a reversibility story with a
suffering story.

**9. Licensing. Said MIT-versus-GPL-2.0.**
There is no GPL in the tree. Addon is MIT; vendored libraries are Chomp ISC,
LibStub public domain, CallbackHandler-1.0 BSD-3-Clause, ChatThrottleLib public
domain. The MIT license has been here since 2020 — `8c0e3c6` changed only the
copyright year. Caught by `license-name` and `factsheet-blocklist`.

**10. The MCP server. Described as an off-the-shelf accelerator.**
It is `mcp/` in this repo, named `wow-api` in `dce2bcb`, serving a reference
generated from the same build as the probe dump. And it was wrong: namespace
shadowing made `get_namespace` under-report until `740a476` keyed by namespace
and merged. Canary: `C_PartyInfo` 55, `C_PlayerInfo` 40, `C_SocialQueue` 10.
Live trap — `mcp/dist/` is gitignored, so a session that pulled the fix without
rebuilding still reads the old index and gets a confident wrong answer. Its
value was correctness, not speed. Caught by `factsheet-blocklist`.

## Omissions — the strongest material, absent

**11. "Absent from the index" does not mean "absent from the client."**
`Menu.ModifyMenu` exists; the "zero occurrences" claim was true of the
documentation index and false of the client. Two independent blind spots: the
index documents the C API and `Menu` is a FrameXML Lua table; the `_G` dump walks
top-level functions and `C_*` namespaces, so a plain non-`C_` global table is
invisible. Only an in-client `type()` check answers it. The picture is inverted —
the modern API is live, the legacy path is gutted (`UnitPopupButtons` is `nil`),
and `UnitPopupMenus` holds 39 menus.

**12. The migration that would have destroyed the probe data.**
`InitDB` wiped the database on any schema mismatch; the probe results had just
been written into it; the next change bumped `DB_SCHEMA` 1 → 2. Fixed with
forward-walking migrations keyed by source schema — an unknown version disables
features and leaves data alone. Same shape as an earlier addon losing a
98-minute session to a `PLAYER_LOGOUT` crasher: the act of saving destroyed the
data.

**13. The rename plan was inverted.**
`AdventurerPlatesDB` held 6 tags, hours and a full motto;
`AdventurerPlatesCardDB` held 0 tags, empty motto, `updated 0`. On-screen data
had never been flushed — WoW writes SavedVariables at `/reload` or logout *then*
loads addons, so the file always lags memory by one reload. The planned
migration would have rescued the empty table over the real one. Keeping the name
kept the variable: zero migration code.

**14. The crash model.**
`C_Housing.GetMaxHouseLevel` access-violates the client, and it is *documented*
and *present at runtime*. So `if C_Foo and C_Foo.Bar then` is a nil-guard, not a
crash-guard, and `pcall` catches Lua errors but not access violations.

**15. The privacy model — the best engineering in the project.**
Pull-only: you ask one person, they decide, that is the protocol. Privacy
enforced on the responder, because a requester cannot assert identity — guild and
friend status looked up locally, default Guild & Friends. Anyone on the ignore
list gets **no reply at all**, not a refusal, because a refusal confirms you are
online and running the addon. A received plate opens a window only if you asked;
unsolicited messages cache silently. Everything off the wire is untrusted: colour
codes, hyperlinks, textures and control characters stripped, numbers clamped,
unknown tags dropped, six-tag cap re-enforced on receipt.

**16. The ASCII 31 trap.** Chomp's `CheckLoggedContents` rejects
`[%z\001-\009\011-\031\127]` as `ASCII_CONTROL` and *errors the send* — a thrown
Lua error on every call, not a dropped message. Found by reading
`StringManip.lua`, not by testing. Separator became `~`.

**17. Chomp's `Libs/` is empty in git** and `## OptionalDeps` is not optional.
Filled at package time from CurseForge SVN via `.pkgmeta`, so a plain clone does
not run. All three deps are called on specific lines and miss-any errors on load.

**18. Roughly a third of the card's fields have never displayed real data.**
Sharing never exercised — no plate sent or received, needs a second player. Guild
display: test character has no guild; `GetGuildInfo` observed returning all-nil.
Titles: 0 of 111 known, level 20 beta cap may make one unobtainable. Portrait
fallback: the model loaded every run, so the failure sentence has never appeared.
The draft read as a finished product. Caught by `caveats-dropped`.

**19. Version numbers were reserved by feature, so v0.3 shipped before v0.2.**
v0.2 is Portraits — unbuilt but unblocked, the probe confirmed the full legacy
model camera surface on all five model widget types. Unexplained, this looks
like a mistake.

## Attribution and sourcing

**20. Shobek is the origin of the idea, not a reviewer to solicit.**
The addon README's Origin line: a post by Shobek (x.com/Shobektv) asking for the
feature in Forever. Both social drafts treated him as someone to ask for
feedback. Credit belongs in the first line. The blocking dependency the record
names is a second character or account, for the sharing test.

**21. The stream is YouTube, not Twitch.**
Sources Cited said "Runtime Reality Twitch/YouTube VODs." Streamlabs Desktop,
YouTube, channel "Kenneth Henseler", on-screen label "Adventurer Plates Addon
Dev". Caught by `platform-claim`. Worth stating in the content itself that
Forever beta is confirmed NDA-free, because a reader's first objection is
whether this can be shown at all.

**22. Cover art: the test character is a Hunter of race Windshaper Skyborne (race ID 96).**
The draft specified a Night Elf in a Classic tavern — contradicting error 1 in the
thumbnail, before anyone presses play.

**23. The "muted mic panic" did not happen.**
The Threads draft claimed it. Nothing in the repository or session record
corroborated it, and the author confirmed on 2026-09-26 that there was no such
incident. Fabricated outright.

**No mechanical rule catches this one.** An invented anecdote contains no wrong
figure, no wrong name, and no ungrounded symbol — `check-content-pack.js` passes
it clean. It is the reason that script's header says a pass means the facts are
not wrong, not that the piece is honest.

---

## What the gate caught in the corrected draft

The rewrite was checked against `facts-build-69913.md` and failed four times.
Worth recording, because they are the same class of error as the ones above,
made by someone who had just finished cataloguing them:

| Claim | Why it was wrong |
| --- | --- |
| Titled "From Zero to v0.3"; "from nothing to a working sharing version" | Blocked: the addon already existed. The probe had been written and never run. |
| "That probe is why the rest of the day was fast" | Blocked: the MCP server and probe **verified** API calls. Correctness, not speed. |
| Cited a 5 h 17 m build window as the session length | The commit window is 5 h 17 m; recorded content is **4 h 56 m 54 s** across two files, plus a third that is corrupt and unreadable. Different measures, and the fact sheet's is the one to publish. |
| Blog post and podcast metadata written from scratch | Both already exist and are published — `posts/confidently-wrong.md`, `posts/forever-api-surface.md`, `media/podcast-metadata.md`. Competing drafts of published work invite someone to ship the wrong one. |

The corrected artifacts that were *not* already covered — social copy and the
CurseForge listing draft — are in `social-copy.md`.

## What to reuse

- **A hand-compiled fact sheet is worth what it costs.** `facts-build-69913.md`
  caught errors in two independent drafts, one of them written by someone who had
  read the whole repository first.
- **Blocklists travel further than fact lists.** "Things that are NOT true"
  turned out to be the section both gates lean on hardest, because plausible
  falsehoods recur across generators in near-identical wording.
- **Art direction is content.** Two of these errors were only in image prompts,
  and those are the parts most people see.
