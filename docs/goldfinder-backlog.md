# GoldFinder Feature Backlog

Public feature requests and planned enhancements for GoldFinder on the WoW: Forever Auction House.

Issue tracking is hosted on GitHub: [justadakaje/wow-addons Issues](https://github.com/justadakaje/wow-addons/issues?q=is%3Aissue+is%3Aopen+label%3Agoldfinder)

---

## Active Backlog Items (Planned for Future Milestones)

### 1. [#14] Direct quick-buy for commodity deals (Shift-Click purchase)
- **Status:** Backlog / High Impact (Awaiting live auctioneer test)
- **GitHub Issue:** [#14](https://github.com/justadakaje/wow-addons/issues/14)
- **Goal:** Enable rapid buyout for time-critical material snipes directly from the GoldFinder tab.
- **Details:**
  - For commodity listings, enable Shift-Click on a deal row to purchase directly without manual navigation to Blizzard's Buy tab.
  - Uses `C_AuctionHouse.StartCommoditiesPurchase` and `ConfirmCommoditiesPurchase`.
  - Includes a configurable safety spend cap (e.g. max 50g per quick-buy) to guard against accidental high-value purchases.

### 2. [#17] Undercut detection for active player auctions
- **Status:** Backlog / Trader QoL (Awaiting live auctioneer test)
- **GitHub Issue:** [#17](https://github.com/justadakaje/wow-addons/issues/17)
- **Goal:** Alert players when their active listings have been undercut by competitors.
- **Details:**
  - Compares `C_AuctionHouse.GetOwnedAuctions()` against lowest scan prices for each item.
  - Flags undercut auctions on an "Undercuts" subview or badge.
  - One-click cancel shortcut via `C_AuctionHouse.CancelAuction()`.

### 3. [#12] Category filters (Herbs, Mining, Cloth, etc.) and item watchlist
- **Status:** Backlog / Medium Priority
- **GitHub Issue:** [#12](https://github.com/justadakaje/wow-addons/issues/12)
- **Goal:** Keep the deals list focused on specific markets and starred materials.
- **Details:**
  - Filter by material subclass using `C_AuctionHouse.GetAuctionItemSubClasses(Enum.ItemClass.Tradegoods)` or `C_Item.GetItemInfoInstant`.
  - Add quick category toggle pills along the top of the GoldFinder tab.
  - Add a Star/Favorite icon to each row with a "Show Starred Only" toggle, integrating with `C_AuctionHouse.IsFavoriteItem` or local watchlist.

### 4. [#18] Crafting cost vs sell value profitability (Reagent conversion arbitrage)
- **Status:** Backlog / Major Feature (Phase 2)
- **GitHub Issue:** [#18](https://github.com/justadakaje/wow-addons/issues/18)
- **Goal:** Fulfill the second half of GoldFinder's core goal: find profitable crafting and conversion opportunities where sell value exceeds reagent costs.
- **Details:**
  - Phase 1: High-volume raw conversions (Smelting ores $\rightarrow$ bars, Milling herbs $\rightarrow$ inks/pigments, Transmutes).
  - Phase 2: Full profession craftable margins.
  - Profit = `(Crafted Typical * 0.95) - Reagent Costs`.

---

## Shipped in v0.2.0 (Forever Launch Build)

- **[#10] Display estimated net profit & flip value:** Calculates `((typical * 0.95) - lowestNow) * quantity`. Adds `Est. Profit` column, interactive header sorting, and rich hover tooltips. *(Closed)*
- **[#11] Configurable deal threshold % and history sensitivity:** Exposes settings in `GoldFinderDB.settings` and provides `/goldfinder` and `/gf` slash commands (`/gf ratio`, `/gf minscans`, `/gf sort`, `/gf preset`). *(Closed)*
- **[#13] Audio chime and chat summary notification:** Plays audio chime on scan complete and prints summary of deals found with top item and net profit. *(Closed)*
- **[#15] Price trend indicator (Detect falling knives):** Evaluates short-term vs long-term median price trajectories (`▲ Rising`, `▶ Steady`, `▼ Falling`) with warning alerts and recent sightings history. *(Closed)*
- **[#16] Bag and world item tooltip price integration:** Automatically shows GoldFinder typical market and lowest prices on item tooltips across bags and vendor frames. *(Closed)*
- **[#19] Data hygiene, database pruning and CSV data export:** In-game CSV export window (`/gf export`), database pruning (`/gf prune [days]`), and item reset (`/gf resetitem`). *(Closed)*
