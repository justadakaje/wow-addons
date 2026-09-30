# Podcast episode metadata — GoldFinder spotlight

Fill in the release date to compute the episode number: channel convention
`S26.E{MMDD}`. As drafted, using **2026-09-30** → **S26.E0930** — change the
date and the number together if it publishes on a different day.

---

## Title — three options

**A — the pivot (recommended)**
```
S26.E0930 – We Almost Forked Auctionator. A License Check Stopped Us.
```

**B — plain product framing**
```
S26.E0930 – GoldFinder: Find Underpriced Materials Without Scanning
```

**C — catalogue style**
```
S26.E0930 – GoldFinder Is Live on CurseForge (Beta) — What It Does and How
```

---

## Short description

For podcast apps. Keep under ~300 characters.

```
GoldFinder just shipped to CurseForge (beta) for WoW: Forever — it watches
your normal auction house scans and flags materials priced well below
typical, without ever scanning itself. The plan was to fork another addon
first. A license check changed that. What got built instead, how the deal
math works, and how to send feedback.
```

---

## Show notes

```
GoldFinder is live on CurseForge (beta) for World of Warcraft: Forever. It
adds one tab to the auction house that finds crafting materials listed well
below their usual price — using scans you're already running, never its own.

THE PIVOT
The original plan was to fork Auctionator and patch in support for this
client. That plan died the moment its license was checked: Auctionator is
All Rights Reserved, with no public source. GoldFinder was built standalone
instead, on Blizzard's own C_AuctionHouse API, sharing only the auction
house's tab row (via the MIT-licensed LibAHTab) — no shared code.

HOW A DEAL IS JUDGED
- Typical price: the median of an item's earlier prices
- A deal: at least 30% below typical
- Needs 3 earlier prices, at least 10 minutes apart, before it judges anything
- Not judged if unseen in the last 30 minutes
Click a deal and it opens in Blizzard's own Buy tab — GoldFinder never buys
for you.

TESTED AND CONFIRMED (build 70009)
- Recorded 249 materials from one Auctionator Full Scan
- Listed 21 real underpriced materials after four scans
- Clicking a deal and buying through it works, confirmed live

STILL EARLY
This is a beta. "Typical" price is a median of as few as three data points on
a small server economy — check a deal in the Buy view before buying it.
Non-commodity item pricing (per unit vs. per stack) is still unverified, and
the full-snapshot event path has never been exercised by any scanner used
so far.

GET IT / GIVE FEEDBACK
- CurseForge: https://www.curseforge.com/wow/addons/goldfinder
- Bugs and feature requests: https://github.com/justadakaje/wow-addons/issues
- Source: https://github.com/justadakaje/wow-addons (addons/GoldFinder)

MIT licensed. Not affiliated with Blizzard Entertainment.
```

---

## Tags

```
World of Warcraft, WoW addon, WoW: Forever, auction house, CurseForge,
GoldFinder, AI-assisted development, Claude Code, beta release, open source
```

---

## Distribution checklist (mirrors `docs/content-pack.md`'s pattern)

- [ ] Generate audio via NotebookLM using `podcast-steering-brief-goldfinder.md`
      as the customisation prompt and the sources it lists
- [ ] Manual accuracy check against the post-generation checklist in the
      steering brief (the automated gate isn't available for this episode yet
      — see the note there)
- [ ] Publish; capture Apple + Spotify URLs and the Spotify embed ID onto the
      🔗 URL Ledger (Trello, AIVibecoding board)
- [ ] Show notes above go out as-is; update the CurseForge URL if the
      project slug ever changes
- [ ] Optional: cross-link from the CurseForge listing description or a
      GitHub README badge once the episode URL exists
