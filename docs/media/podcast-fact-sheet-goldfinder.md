# Fact Sheet — GoldFinder episode

**Single source of truth for every number in this episode.** Same rules as
[`facts-build-69913.md`](../facts-build-69913.md) and
[`facts-build-70009.md`](../facts-build-70009.md): every figure below was
measured in-client, read from a shipped file, or confirmed against a live
GitHub/CurseForge state — never estimated. Anything not confirmed is in
"Still unverified," not here.

Sources: `docs/facts-build-70009.md`, `addons/GoldFinder/README.md`,
`addons/GoldFinder/CHANGELOG.md`, `docs/curseforge/goldfinder.md`,
`docs/releasing.md`, `addons/GoldFinder/GoldFinder.toc`, `git tag
goldfinder-v0.1.0-beta` (confirmed present on `origin`).

---

## What GoldFinder is

| Fact | Value |
| --- | --- |
| Title | GoldFinder |
| Version | 0.1.0 |
| Client | WoW: Forever only — `## Interface: 16001` |
| Tested build | 1.60.1.70009 |
| License | MIT (repo-wide; vendored libs listed below) |
| CurseForge project ID | 1715781 |
| CurseForge page | https://www.curseforge.com/wow/addons/goldfinder |
| Release tag | `goldfinder-v0.1.0-beta` — confirmed on `origin` |
| Release channel | **Beta**, not Release — a `beta` tag uploads as Beta per `docs/releasing.md` |
| Release date | 2026-09-28 (workflow run `36381144592`, "Success!") |
| Not affiliated with | Blizzard Entertainment |
| Episode numbering | Channel convention `S26.E{MMDD}` (`docs/content-pack.md`). Publishing 2026-09-30 → **S26.E0930**. |

## What it does

GoldFinder adds one **GoldFinder** tab to the WoW: Forever auction house,
next to Blizzard's tabs and any other addon's. It finds crafting materials
(trade goods and reagents) currently listed well below their normal price.

**It never scans the auction house itself.** It records the results of scans
and searches already run through other means — Auctionator's Full Scan, the
Buy tab, anything — and builds a price history from them. One scan feeds
every addon watching; GoldFinder never spends the AH's own scan cooldown.

## How a deal is judged

| Rule | Value |
| --- | --- |
| Typical price | Median of an item's *earlier* prices (current excluded) |
| Deal threshold | Current lowest price at least **30% below** typical |
| Evidence required | **3 earlier prices**, each at least **10 minutes apart** |
| Freshness window | Not judged if unseen in the last **30 minutes** |
| History cap | Up to 30 recorded prices per item |

Anything that cannot yet be judged is explained on the tab in a sentence —
never an empty list or a silent zero.

## Buying a deal

Click a deal to open its listings in **Blizzard's own Buy tab**; the purchase
happens there with Blizzard's own confirmation. GoldFinder does not place
bids or purchases itself.

## Why it was built this way — the pivot that matters

- The original plan (recorded in `HANDOFF.md`) was to fork **Auctionator**
  and add a `camelot` load gate to its five `AllowLoadGameType` lists, since
  build 70009 confirmed `C_AuctionHouse` is fully present under the
  `camelot` game-type token.
- That plan was **ruled out, not attempted**: Auctionator is **All Rights
  Reserved**, with no public source repository. Forking it would redistribute
  someone else's code without permission. Its own bundled `AGENTS.md` states
  the authors do not permit using it as a basis or reference. GoldFinder's
  source was never read.
- GoldFinder is **standalone**, built on Blizzard's own `C_AuctionHouse` API,
  sharing only the auction house *window* with Auctionator — no shared code.
- The auction-house **tab row** itself is shared through **LibAHTab** (MIT,
  `TheMouseNest/LibAHTab`, vendored at commit `24090a7`), so GoldFinder's tab
  lines up beside Auctionator's four tabs instead of drawing over them.
  GoldFinder also detects and warns about an addon that adds a tab *without*
  that library, where tabs could visually overlap.

## Tested and confirmed (build 70009)

- Tab renders fifth, after Auctionator's four LibAHTab tabs; selection
  switches cleanly; reopening the auction house does not duplicate it.
- One Auctionator Full Scan recorded **249 materials across 249 items**.
- The deal table, on real data: after **4 scans on separate occasions**, it
  listed **21 underpriced materials**, deepest discount first.
- Clicking a deal opens Blizzard's Buy tab (tab highlighted, Blizzard's
  title); a purchase there goes through — one Raptor Egg bought, no action
  blocked.
- Prices are per unit for commodities: Raptor Egg's recorded lowest price
  (2s) matched the Buy view's Unit Price (2s 0c).
- Cost, read at v0.0.4 via the AddOn List: **0.01% average CPU, 388 KB**.

## Measured along the way

- Auctionator's "Full Scan (summary mode)" arrives as **browse results** (1
  `AUCTION_HOUSE_BROWSE_RESULTS_UPDATED`, 9 `_ADDED`), not the full-snapshot
  event (`REPLICATE_ITEM_LIST_UPDATE`, which fired **zero** times in this
  session). GoldFinder listens for browse results as its primary feed.
- One Full Scan produced **4460 browse results covering 2054 distinct
  items**; Auctionator's own summary reported 2059 items for the same scan —
  a gap of 5, unexplained. A browse "result" is one item *variant* (item +
  level + suffix), not a repeat.
- Each click in Auctionator's own Selling tab re-fired the browse-results
  event with the *previous* Full Scan's data. GoldFinder now fingerprints and
  drops an identical re-delivery so it is not recorded or announced again.

## How users give feedback or request features

- **GitHub Issues** on the addon's home repository:
  https://github.com/justadakaje/wow-addons/issues — the repo the CurseForge
  listing's source and issue-tracker links point to. This is the only
  confirmed feedback channel; GoldFinder does not have a separate
  single-addon repository (the CurseForge package is built by splitting
  `addons/GoldFinder/` out at release time in CI — that split is not a
  separately published repo).
- **CurseForge's own comment section** on the project page, for casual
  feedback from people who install it there.

## Licenses, checked

- **Auctionator: All Rights Reserved** (plusmouse, borjamacare). No public
  repository. Its bundled `AGENTS.md` states its authors do not permit its
  use as a basis or reference.
- **LibAHTab: MIT** (`TheMouseNest/LibAHTab`).
- **LibStub: Public Domain.**
- **GoldFinder itself: MIT**, like the rest of the repository.

## Things that are NOT true — do not let these into the episode

- ❌ "GoldFinder is a fork of Auctionator" / "based on Auctionator." Ruled
  out before any fork was attempted; Auctionator's source was never read.
  They share only the auction house window.
- ❌ "GoldFinder scans the auction house." It never queries the AH itself —
  it only records results from scans already run through other means.
- ❌ "GoldFinder places bids or buys automatically." Clicking a deal opens
  Blizzard's own Buy tab; the purchase, and its confirmation, are Blizzard's.
- ❌ "This is a full release" / "out of beta." The CurseForge upload is
  tagged and classified as **Beta**.
- ❌ "GoldFinder works on Classic Era" or any client besides WoW: Forever.
  `## Interface: 16001` only; other clients are untested.
- ❌ "GoldFinder's deals are guaranteed correct." Current commodity prices
  are confirmed accurate; "typical" on a thin/volatile market is a median of
  as few as 3 data points and is explicitly not guaranteed (see below).
- ❌ Rounding any figure in this sheet — 21 deals, not "about 20"; 2054
  items, not "roughly 2000"; 30% threshold, not "about a third."

## Still unverified at episode time

- **Reliability of "typical" on a thin market.** It is the median of as few
  as 3 earlier scans; an early result showed Wool Cloth at 30c against a
  typical of 2s 90c on a small, volatile beta economy. Users should check a
  deal in the Buy view before buying — a click takes them straight there.
- **Non-commodity materials** — whether their browse price is per unit or
  per stack is not yet measured.
- **The full-snapshot path** (`REPLICATE_ITEM_LIST_UPDATE`) — no scanner used
  by the author has ever triggered it; GoldFinder reads it defensively but it
  has never been exercised live.
- **Any client other than WoW: Forever build 70009** — untested.

Carry at least one of these caveats in the episode. An episode promoting a
price-finding tool that omits "check it before you buy" undersells the one
safety instruction that matters most to a new user.
