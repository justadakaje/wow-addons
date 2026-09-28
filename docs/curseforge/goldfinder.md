**GoldFinder** adds a **GoldFinder** tab to the auction house that finds crafting materials listed well below their usual price. Click a deal and it opens in the Buy tab, ready to buy.

## How it works

1. **Scan as you normally do.** Run Auctionator's Full Scan, or search the Buy tab. GoldFinder never searches the auction house itself — it quietly records the results of scans you already run, so it never uses up the scan cooldown.
2. **GoldFinder builds a price history** for trade goods and reagents: the lowest listing each time it sees them.
3. **Open the GoldFinder tab.** Any material listed **at least 30% below** its typical price shows up, deepest discount first, with its current lowest price, typical price, discount and quantity listed.
4. **Click a deal** to open its listings in Blizzard's Buy tab. You buy there, with Blizzard's own confirmation.

Hover a deal for its prices; hover the grey line at the bottom of the tab for details of the last scan.

## What counts as a deal

- **Typical price** is the median of an item's *earlier* prices, so one listing at 1 copper or 999 gold barely moves it, and a new cheap listing cannot drag its own baseline down.
- An item needs **three earlier prices**, taken at least 10 minutes apart, before it can be judged. Your first few scans show "Building price history" instead of a list — that is expected.
- An item not seen in the **last 30 minutes** is not judged; it has probably sold.

## Tested, and not yet tested

Tested on **WoW: Forever build 70009**: the tab sits alongside Auctionator's tabs without overlapping, prices are recorded from Auctionator's Full Scan, deals are listed from real scans, and buying from a clicked deal works.

**Please check a deal in the Buy tab before buying it.** On a small beta market, three earlier scans can make a normal price swing look like a bargain. A click takes you straight there.

Not yet measured: whether prices for materials that are *not* commodities are per unit or per stack.

## Compatibility

- **WoW: Forever only** (Interface 16001).
- Works alongside Auctionator (tested): GoldFinder shares the auction house tab row through LibAHTab instead of drawing over other addons' tabs. It is also built to warn you if an addon adds a tab without that library, where tabs could overlap — not yet seen, since no such addon was installed.
- GoldFinder is not based on Auctionator and contains none of its code.

## Credits and licence

MIT licensed. The tab uses [LibAHTab](https://github.com/TheMouseNest/LibAHTab) (MIT) and LibStub, both included. The source and the issue tracker are on GitHub — see the project links.

Not affiliated with Blizzard Entertainment.
