# GoldFinder Feature Backlog

Public feature requests and planned enhancements for GoldFinder on the WoW: Forever Auction House.

Issue tracking is hosted on GitHub: [justadakaje/wow-addons Issues](https://github.com/justadakaje/wow-addons/issues?q=is%3Aissue+is%3Aopen+label%3Agoldfinder)

---

## Active Backlog Items

### 1. [#10] Display estimated net profit & flip value (accounting for 5% AH cut)
- **Status:** Backlog / High Priority
- **GitHub Issue:** [#10](https://github.com/justadakaje/wow-addons/issues/10)
- **Goal:** Surface the actual gold-making potential of deals rather than discount percentage alone.
- **Details:**
  - Calculate unit net profit: `(typical * 0.95) - current.min`
  - Calculate total net profit: `math.max(0, unitNetProfit * current.qty)`
  - Display net profit in row or hover tooltip (`GameTooltip:AddDoubleLine("Est. Flip Profit:", Money(d.totalNetProfit))`).
  - Add sort toggle between **Sort by Discount %** and **Sort by Net Gold Gain**.

### 2. [#11] Configurable deal threshold % and history sensitivity
- **Status:** Backlog / High Priority
- **GitHub Issue:** [#11](https://github.com/justadakaje/wow-addons/issues/11)
- **Goal:** Allow players to customize deal thresholds according to their realm's economy and trading style.
- **Details:**
  - Make `DEAL_RATIO` (default 30% discount / 0.70) and `MIN_PRIOR` (default 3 scans) player-configurable in `GoldFinderDB`.
  - Slash command support: `/gf ratio <percent>` (e.g. `/gf ratio 20`) and `/gf minscans <count>`.
  - Presets: *Snipe Mode (50%+ off)*, *Standard Deal (30%+ off)*, *Volume Flip (15%+ off)*.

### 3. [#12] Category filters (Herbs, Mining, Cloth, etc.) and item watchlist
- **Status:** Backlog / Medium Priority
- **GitHub Issue:** [#12](https://github.com/justadakaje/wow-addons/issues/12)
- **Goal:** Keep the deals list focused on specific markets and starred materials.
- **Details:**
  - Filter by material subclass using `C_AuctionHouse.GetAuctionItemSubClasses(Enum.ItemClass.Tradegoods)` or `C_Item.GetItemInfoInstant`.
  - Add quick category toggle pills along the top of the GoldFinder tab.
  - Add a Star/Favorite icon to each row with a "Show Starred Only" toggle, integrating with `C_AuctionHouse.IsFavoriteItem` or local watchlist.

### 4. [#13] Audio chime and chat summary notification when deals are found
- **Status:** Backlog / Quick Win
- **GitHub Issue:** [#13](https://github.com/justadakaje/wow-addons/issues/13)
- **Goal:** Alert players who are alt-tabbed or looking at other tabs when high-value snipes appear.
- **Details:**
  - When browse results settle and new qualifying deals are detected, play an in-game sound (e.g. `PlaySound(SOUNDKIT.AUCTION_WINDOW_OPEN)`).
  - Print a concise chat line: `[GoldFinder] 3 deals found! Top: Thorium Ore (42% off, +18g net)`.
  - Toggleable via settings (`/gf sound on/off`, `/gf chat on/off`).

### 5. [#14] Direct quick-buy for commodity deals (Shift-Click purchase)
- **Status:** Backlog / High Impact
- **GitHub Issue:** [#14](https://github.com/justadakaje/wow-addons/issues/14)
- **Goal:** Enable rapid buyout for time-critical material snipes directly from the GoldFinder tab.
- **Details:**
  - For commodity listings, enable Shift-Click on a deal row to purchase directly without manual navigation to Blizzard's Buy tab.
  - Uses `C_AuctionHouse.StartCommoditiesPurchase` and `ConfirmCommoditiesPurchase`.
  - Includes a configurable safety spend cap (e.g. max 50g per quick-buy) to guard against accidental high-value purchases.

### 6. [#15] Price trend indicator (Detect falling knives vs genuine bargains)
- **Status:** Backlog / Analytical
- **GitHub Issue:** [#15](https://github.com/justadakaje/wow-addons/issues/15)
- **Goal:** Help players distinguish between temporary underpriced dips and collapsing markets.
- **Details:**
  - Compare recent scan medians vs older scan medians across the 30-point history.
  - Display trajectory tags: `▲ Rising`, `▶ Steady`, `▼ Falling`.
  - Add an ASCII sparkline `[ ▂▃▅█ ]` or historical table in the row tooltip.

### 7. [#16] Bag and world item tooltip price integration
- **Status:** Backlog / High QoL
- **GitHub Issue:** [#16](https://github.com/justadakaje/wow-addons/issues/16)
- **Goal:** Show GoldFinder's recorded typical and lowest prices directly on GameTooltip when hovering items in bags, vendor screens, or quest rewards.
- **Details:**
  - Hooks GameTooltip / `TooltipDataProcessor`.
  - Displays: `GoldFinder Typical: 12g 50s`, `GoldFinder Lowest: 8g 20s (15m ago)`.
  - Configurable toggle: `/gf tooltip on/off`.

### 8. [#17] Undercut detection for active player auctions
- **Status:** Backlog / Trader QoL
- **GitHub Issue:** [#17](https://github.com/justadakaje/wow-addons/issues/17)
- **Goal:** Alert players when their active listings have been undercut by competitors.
- **Details:**
  - Compares `C_AuctionHouse.GetOwnedAuctions()` against lowest scan prices for each item.
  - Flags undercut auctions on an "Undercuts" subview or badge.
  - One-click cancel shortcut via `C_AuctionHouse.CancelAuction()`.

### 9. [#18] Crafting cost vs sell value profitability (Reagent conversion arbitrage)
- **Status:** Backlog / Major Feature
- **GitHub Issue:** [#18](https://github.com/justadakaje/wow-addons/issues/18)
- **Goal:** Fulfill the second half of GoldFinder's core goal: find profitable crafting and conversion opportunities where sell value exceeds reagent costs.
- **Details:**
  - Phase 1: High-volume raw conversions (Smelting ores $\rightarrow$ bars, Milling herbs $\rightarrow$ inks/pigments, Transmutes).
  - Phase 2: Full profession craftable margins.
  - Profit = `(Crafted Typical * 0.95) - Reagent Costs`.

### 10. [#19] Data hygiene, database pruning and CSV data export
- **Status:** Backlog / Utility
- **GitHub Issue:** [#19](https://github.com/justadakaje/wow-addons/issues/19)
- **Goal:** Keep SavedVariables lean, eliminate outlier troll prices, and export pricing data for spreadsheet modeling.
- **Details:**
  - Prune items older than 30 days (`/gf prune`).
  - Delete individual item history (`/gf resetitem <link|id>`).
  - Copy-paste CSV/TSV export editbox for external analysis in Google Sheets or Excel.
