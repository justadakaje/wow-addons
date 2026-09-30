# Steering Brief — GoldFinder episode

Paste this as the customisation prompt when generating the Audio Overview
(NotebookLM), alongside the sources listed below. Written to be handed to a
generator verbatim.

---

## EPISODE BRIEF

You are producing an episode of **Runtime Reality**, a technical podcast
about building software with AI assistance. This episode is a **product
spotlight**, not an investigation — different shape from prior episodes.
The audience already knows what an addon, an auction house, and an API are.

### Subject

**GoldFinder**, a WoW: Forever auction-house addon just released (beta) on
CurseForge. What it does, how it decides something is a deal, why it was
built the way it was, and how listeners can use it and give feedback.

### Thesis — state it, then earn it

> The interesting decision in GoldFinder is not the deal-finding math — it's
> the one that got made *before any code shipped*: the plan was to fork
> Auctionator, and that plan was abandoned the moment its license was
> actually checked. What got built instead is smaller, safer, and shares
> better with other addons than the fork would have.

### Required structure

1. **Cold open (20–40s).** What GoldFinder does, in one breath: it watches
   your normal auction house scans and tells you when something is
   underpriced, without ever scanning itself.
2. **Setup (2–3 min).** WoW: Forever's auction house: modern `C_AuctionHouse`
   is fully present; Auctionator's tabs load via LibAHTab. Why that matters —
   it's the surface GoldFinder is built on.
3. **The pivot (4–6 min).** The fork-Auctionator plan, and why it died on
   contact with Auctionator's license (All Rights Reserved, no public repo,
   its own `AGENTS.md` forbidding use as a basis). What got built instead:
   standalone, on `C_AuctionHouse`, sharing only the tab row via LibAHTab
   (MIT). This is the spine of the episode — spend real time here.
4. **How it works (6–8 min).** Passive recording, never spends the scan
   cooldown. The deal rule: median of earlier prices, 30% threshold, 3 data
   points 10 minutes apart, 30-minute freshness window. Click a deal, buy in
   Blizzard's own Buy tab — GoldFinder never buys for you.
5. **What's confirmed working, and what isn't yet (4–5 min).** Real numbers
   from real scans (see fact sheet). Then the honesty beat: "typical" on a
   thin beta market is noisy — check a deal in the Buy view before buying.
6. **Try it / give feedback (2–3 min).** Where to get it (CurseForge, project
   1715781), that it's a beta release, and where to file a bug or request a
   feature: GitHub Issues on the addon's home repository. Invite listeners to
   report which items look wrong on their server — that's exactly the kind
   of signal a beta needs.
7. **Close (30–60s).** One sentence tying back to the thesis: checking the
   license before writing the code was the highest-leverage decision in the
   whole build.

### Target length

**12–18 minutes.** This is a spotlight, not a deep investigation — do not
pad it to match a longer episode's runtime. Depth on the pivot and the deal
rule; brevity everywhere else.

### Hard accuracy rules

- **Every figure must come from `podcast-fact-sheet-goldfinder.md`.** If a
  number is not in the sources, say so rather than inventing one.
- Do not round: **30%** threshold, not "about a third"; **21 deals**, not
  "around 20"; **2054 items**, not "roughly 2000."
- The fact sheet's **"Things that are NOT true"** section is a blocklist.
- **Never say GoldFinder is a fork of, or based on, Auctionator.** They share
  a window, not code. Auctionator's license was never violated because its
  source was never read.
- **Never say GoldFinder scans the auction house.** It only records results
  from scans run some other way.
- **Never say GoldFinder buys things automatically.** A click opens
  Blizzard's Buy tab; the purchase is the player's, confirmed by Blizzard.
- **Say "beta,"** not "released" or "out of beta" — the CurseForge upload is
  tagged and classified as Beta.
- **WoW: Forever only** — do not imply Classic Era, Retail, or any other
  client is supported.
- The tool used to build it was **Claude Code**.

### Tone

Warm and practical — this is a spotlight meant to get people to try the
addon, not a takedown or an investigation. Still precise on numbers. A little
pride in the pivot is earned: turning down a fork because of a license check,
then shipping something better anyway, is a good story told straight.

### Explicitly out of scope

The Menu.ModifyMenu / ASCII-31 / four-errors story from the prior episode.
That is a different episode's thesis; do not blend them. Sharing/plates
(AdventurerPlates) is a different addon — mention it only if introducing the
channel, never as GoldFinder's feature.

### Honesty requirement

State plainly, near the "what isn't confirmed yet" beat, that "typical"
price is a median of as few as 3 data points on a small beta market, and that
users should check a deal in the Buy view before buying. Also name at least
one item still **unverified** per the fact sheet — non-commodity pricing
(per unit vs. per stack) has not been measured, and the full-snapshot event
path has never been exercised by any scanner used so far. An episode
promoting a price-finding tool that skips this is giving worse advice than
silence.

---

## Sources for this generation

Upload as sources (not as the customisation prompt):

```
docs/media/podcast-fact-sheet-goldfinder.md
addons/GoldFinder/README.md
addons/GoldFinder/CHANGELOG.md
docs/curseforge/goldfinder.md
```

Do **not** upload this steering brief itself as a source — it is the prompt,
not material to summarize.

## Post-generation checklist

Before publishing, confirm against `podcast-fact-sheet-goldfinder.md`:

- [ ] 30% deal threshold, 3 earlier prices, 10 minutes apart, 30-minute
      freshness window — all stated correctly
- [ ] Not called a fork of, or based on, Auctionator
- [ ] Not described as scanning the auction house itself
- [ ] Not described as buying automatically
- [ ] Called "beta," not "released" / "out of beta"
- [ ] WoW: Forever only, Interface 16001 — no other client named
- [ ] CurseForge project **1715781** / the live listing URL is correct
- [ ] Feedback channel named correctly: GitHub Issues on
      `justadakaje/wow-addons`, not a nonexistent separate repo
- [ ] The "check a deal before buying" caveat is present
- [ ] Claude Code named correctly, if the tool is mentioned

`scripts/check-episode.js` in this repo is currently **hardcoded to the
prior (build-69913) episode's facts** — running it against a GoldFinder
transcript will fail on unrelated checks (ASCII 31, wire-format bytes) that
don't apply here. It needs generalizing (take a `--facts`/`--facts-json`
flag, the way `check-content-pack.js` already does) before it can gate this
episode's audio. Until then, the checklist above is the gate.
