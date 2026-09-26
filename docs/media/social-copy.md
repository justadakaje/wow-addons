# Social copy and listing draft — Adventurer Plates session

The artifacts from the corrected content pack that are **not** covered elsewhere
in `docs/`. The blog posts are in `../posts/`, the episode metadata is in
`podcast-metadata.md`, and the video chapters are in `highlight-reel-chapters.txt`.
This file holds only social copy and the store listing.

Checked with `node scripts/check-content-pack.js docs/media/social-copy.md --digest <digest>`.
Before posting any of it, read the accuracy rules in `podcast-steering-brief.md` —
they apply to written copy too.

**Publication order:** these are leaves in `../content-pack.md`'s dependency
graph, so they go out *after* the blog posts have URLs. Every `[Link]` below is a
blocking placeholder.

---

## LinkedIn

> Needs: blog post URL, podcast URL.

This one started with somebody else's request. Shobek asked publicly for an
FFXIV-style Adventurer Plate in WoW: Forever, so I built one — and I have a
working version that shares cards between players, plus a clear reason not to
publish it yet.

Three things from the session worth more than the velocity:

**The ground truth was wrong before the code was.** I develop against a local
MCP server I built, serving a generated index of this client's API. Namespace
shadowing meant one namespace reported 2 functions where it has 55. Fixed. The
residue is operational: three known function counts as a canary, checked before
trusting the index, because the server's build output is gitignored and a session
that pulls the fix without rebuilding still gets a confident wrong answer. That
server's job is verification, not speed — it is there to stop me writing an API
call that does not exist.

**One measurement closed a dependency argument, because the threshold was written
down first.** Serialize, compress, encode, count transport chunks. At two chunks,
add nothing; above two, take the compression library. It came in at two. One
dependency never entered the tree — and the compression step stayed, on the same
evidence, because skipping it would have produced a third chunk.

**A UI fix was quietly covering the error window.** I had promoted a panel to the
highest dialog layer to stop text bleeding through it. That also outranked the
error-reporting addon. An error message is the one thing on screen that must stay
readable; competing for layer was the wrong move, and competing for level within
a layer was the right one.

And the part I would rather not write: roughly a third of the card's fields have
never displayed real data. The test character has no guild and none of 111
titles, so those rows have only ever rendered their empty states. The release zip
is built. It is not uploaded. That gap is in the changelog under its own heading,
not left for the first user to find.

Shobek — you asked for this. What would make it usable in the open world, and
what did I miss? And if anyone is running the Forever beta and wants to be the
second character that finally exercises the sharing path, I need exactly one of
you.

*(Starter comment)* Technical deep-dive: [Link] · Runtime Reality episode:
[Link] · Code, changelog and the full unverified-surface list:
github.com/justadakaje/wow-addons

---

## Threads

> Needs: blog post URL.

Built a character card addon for the WoW: Forever beta — portrait, playstyle
tags, active-hours grid, motto. v0.3 shares them between players. Not on
CurseForge, on purpose.

Roughly a third of the card's fields have never shown real data — no guild, 0 of
111 titles on the test character. The zip is built and sitting there.

@shobek asked for this feature publicly and I built it. Need a second beta
character to finally test sharing. 👇

---

## X — reply to the origin post

> Reply to x.com/Shobektv status 2101665615115153745.

@Shobektv built this because you asked for it. Adventurer Plates for Forever:
landscape card, live portrait, playstyle tags, active-hours grid, motto.
Pull-only sharing — you ask one person, they decide, nothing broadcasts.

Not on CurseForge yet: a third of the fields have never had real data to show.
Need a second beta character to test sharing with.

---

## CurseForge listing — draft, for when the project is claimed

> Blocked on `../content-pack.md` Phase 0 and on a sharing test with a second
> character. Do not upload before both.

**Adventurer Plates** — a character card for WoW: Forever, modelled on Final
Fantasy XIV's Adventurer Plate. Portrait, name and realm, title, guild and rank,
level/race/class, playstyle tags, a weekday/weekend active-hours grid, and a
motto.

Out-of-character by design. This is social matchmaking — when you play, what you
play, what you are looking for — not a character-sheet or in-character profile
addon. If you want in-character roleplay profiles, this is not that addon — Total RP 3
is the established project there, and it does not run on Forever.

**Sharing is pull-only.** `/advplate ask <name>`, or target someone and omit the
name. Nothing is ever sent unasked and there is no hidden channel. Privacy is
enforced on the responder — a requester cannot claim to be your guildmate, so
your client checks locally before answering. Default is Guild & Friends. Anyone
on your ignore list gets no reply at all, because a refusal would confirm you are
online.

Everything arriving over the wire is treated as untrusted: colour codes,
hyperlinks, textures and control characters are stripped, numbers are clamped,
and unknown playstyle tags are dropped. A sender cannot draw arbitrary badges or
inject markup into your interface.

**Forever only** (`## Interface: 16001`, tested on 1.60.1 build 69913). Not
Classic Era — the encoding API the sharing design is built on has no Classic
equivalent.

**What is not yet tested, stated plainly:**

- Sharing has not been exercised between two real characters. It is written,
  reviewed and unrun.
- Guild and title display have never rendered real data — the development
  character has no guild and knows none of 111 titles.
- The portrait's fallback message has never appeared, because the model has
  loaded on every run.
- Playstyle badges are coloured two-letter glyphs, not icon art: no verified
  source of category artwork exists on this client yet.
- English only.

MIT licensed. Chomp (ISC), LibStub (public domain), CallbackHandler-1.0
(BSD-3-Clause) and ChatThrottleLib (public domain) are vendored; each license
text travels with the code it covers.
