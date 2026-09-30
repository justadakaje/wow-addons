# Video Overview prompt — GoldFinder (Short)

For NotebookLM's Video Overview. Companion to
[`podcast-steering-brief-goldfinder.md`](podcast-steering-brief-goldfinder.md);
same fact sheet, [`podcast-fact-sheet-goldfinder.md`](podcast-fact-sheet-goldfinder.md).

## Settings

- **Format:** Short (portrait, about 60 seconds, one topic).
- **Focus:** Custom topic. The preset "Finding Auction Deals" has no guardrails,
  and the video generates its own visuals and on-screen text.
- **Sources:** the fact sheet, the GoldFinder `README.md`, `CHANGELOG.md`, and
  `docs/curseforge/goldfinder.md`. Do not select the podcast steering brief; its
  12–18 minute structure conflicts with a 60-second format.

## Prompt

Paste into "Describe your own". About 1,000 characters; if the box truncates it,
keep the first paragraph and the Rules line.

```
One single topic: how to use GoldFinder, the WoW: Forever auction house addon, now on CurseForge as a beta.

The story, in order: you scan the auction house the way you already do. GoldFinder quietly records those results and never scans the auction house itself, so it never spends the scan cooldown. When a crafting material's lowest price is at least 30% below its typical price, it appears as a deal on a new GoldFinder tab. Click a deal and it opens in Blizzard's own Buy tab, where you buy with Blizzard's own confirmation. End on the caveat: it is a beta, so check a deal in the Buy tab before buying it. Bugs and feature requests go to GitHub Issues on justadakaje/wow-addons.

Rules: WoW: Forever only. Use only facts from the sources; anything the sources mark as unverified is not claimed. Do not invent numbers, item names, prices or in-game screenshots; show simple graphics instead of fabricated data. Never say it is a fork of, or based on, Auctionator. Never say it buys automatically. Say beta, not released. No hype.
```

## Alternate topic — for a longer format

A Cinematic or Explainer video has room for the pivot: the plan was to fork
Auctionator, a license check ruled that out, and GoldFinder was built standalone
on Blizzard's own auction house API, sharing only the tab row through LibAHTab.
Reuse the Rules line above.

## After it renders

No automated gate exists for video. Check by eye:

- [ ] Any on-screen price, item name or in-game UI is real, not generated.
- [ ] If a figure appears, it is 30%.
- [ ] It says "beta", not "released".
- [ ] It never says "fork", "based on Auctionator" or "buys for you".
- [ ] It names only WoW: Forever.
- [ ] The feedback destination shown is GitHub Issues on `justadakaje/wow-addons`.
