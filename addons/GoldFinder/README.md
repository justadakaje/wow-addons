# GoldFinder

Finds crafting materials listed well below their normal price on the WoW:
Forever auction house. It adds one **GoldFinder** tab to the auction house
window, beside Blizzard's tabs and any other addon's.

GoldFinder never searches the auction house itself. It records the results
of scans and searches you already run (Auctionator's Full Scan, the Buy tab,
anything) and builds a price history from them. One scan feeds every addon,
and GoldFinder never uses up the auction house's scan cooldown.

## What counts as a deal

For each material (trade goods and reagents), GoldFinder keeps up to 30 recorded
prices: the lowest listing seen in each scan.

- **Typical price** is the **median** of that item's *earlier* prices. The
  current price is left out, so a sudden cheap listing cannot drag its own
  baseline down. Median rather than average, so one listing at 1 copper or
  999 gold barely moves it.
- **A deal** is a current lowest price at least **30% below** typical.
- **Evidence first:** an item needs **3 earlier prices** before it is judged.
  Two sightings within 10 minutes count as one, so in practice that means
  scans on at least 4 separate occasions.
- **Freshness:** an item not seen in the last 30 minutes is not judged. It has
  probably sold.

Anything that cannot be judged is explained on the tab in a sentence, never
shown as an empty list or a zero.

## Sharing the tab row

The tab is added through [LibAHTab](https://github.com/TheMouseNest/LibAHTab)
(MIT). Every addon that uses the library shares one row of tabs, so they line
up side by side instead of drawing over each other. GoldFinder also:

- adds its tab once, however many times the auction house is opened;
- refuses to add a tab if another addon already uses its ID;
- detects an addon that adds a tab *without* the library, where tabs may
  overlap, and says so on the tab and in chat.

## Status

Tested on WoW: Forever 1.60.1, **build 70009**.

**Run and confirmed working:**

- The GoldFinder tab renders fifth, after Auctionator's four; selection switches
  cleanly; reopening the auction house does not duplicate it
- Prices are recorded from Auctionator's Full Scan: one scan recorded 249
  materials across 249 items
- The panel: centred "Building price history" empty state, a footer clear of
  the money display, and a details tooltip on hover
- **The deal table, on real data**: after four scans on separate occasions it
  listed 21 underpriced materials, deepest discount first, with names, prices
  and quantities

**Measured along the way:**

- Auctionator's "Full Scan (summary mode)" arrives as browse results (1 update
  and 9 pages), not a full snapshot. GoldFinder records both kinds.
- Browse results are per item *variant* (item + level + suffix): one Full Scan
  gave 4460 results covering 2054 distinct items. Auctionator reported 2059
  items for the same scan; the gap of 5 is unexplained.

**Written and NOT yet seen working:**

- **Whether the prices in the table are right.** Some first results look
  implausible -- Wool Cloth at 30c against a typical 2s 90c (90% below) with
  6368 listed -- which suggests browse prices mix per-unit and per-stack
  values on this client. **Check a deal in the Buy tab before buying it**
  until this is measured.
- **The full-snapshot path** (`REPLICATE_ITEM_LIST_UPDATE`). No scanner used by
  the author triggers it. Until the snapshot's index numbering is measured, it
  reads every listing but one, to avoid an out-of-range call.

## Client support

Forever only (`## Interface: 16001`). Other clients are untested.

## Licence

MIT, like the rest of this repository.

GoldFinder is **not** based on Auctionator. Auctionator's licence is All Rights
Reserved; none of its code is used or was read. The two only share the
auction house window. LibAHTab is a separate MIT-licensed project, vendored
in `libs/` with its licence; see [`libs/README.md`](libs/README.md).
