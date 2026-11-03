# GoldFinder Feature Backlog

Public feature requests and planned enhancements for GoldFinder on the WoW: Forever Auction House.

Issue tracking is hosted on GitHub: [justadakaje/wow-addons Issues](https://github.com/justadakaje/wow-addons/issues?q=is%3Aissue+is%3Aopen+label%3Agoldfinder)

---

## Active Backlog Items

### 1. [#10] Display estimated net profit & flip value (accounting for 5% AH cut)
- **Status:** Backlog / Planned
- **GitHub Issue:** [#10](https://github.com/justadakaje/wow-addons/issues/10)
- **Goal:** Surface the actual gold-making potential of deals rather than discount percentage alone.
- **Details:**
  - Calculate unit net profit: `(typical * 0.95) - current.min`
  - Calculate total net profit: `math.max(0, unitNetProfit * current.qty)`
  - Display net profit in row or hover tooltip (`GameTooltip:AddDoubleLine("Est. Flip Profit:", Money(d.totalNetProfit))`).
  - Add sort toggle between **Sort by Discount %** and **Sort by Net Gold Gain**.

### 2. [#11] Configurable deal threshold % and history sensitivity
- **Status:** Backlog / Planned
- **GitHub Issue:** [#11](https://github.com/justadakaje/wow-addons/issues/11)
- **Goal:** Allow players to customize deal thresholds according to their realm's economy and trading style.
- **Details:**
  - Make `DEAL_RATIO` (default 30% discount / 0.70) and `MIN_PRIOR` (default 3 scans) player-configurable in `GoldFinderDB`.
  - Slash command support: `/gf ratio <percent>` (e.g. `/gf ratio 20`) and `/gf minscans <count>`.
  - Presets: *Snipe Mode (50%+ off)*, *Standard Deal (30%+ off)*, *Volume Flip (15%+ off)*.

### 3. [#12] Category filters (Herbs, Mining, Cloth, etc.) and item watchlist
- **Status:** Backlog / Planned
- **GitHub Issue:** [#12](https://github.com/justadakaje/wow-addons/issues/12)
- **Goal:** Keep the deals list focused on specific markets and starred materials.
- **Details:**
  - Filter by material subclass using `C_AuctionHouse.GetAuctionItemSubClasses(Enum.ItemClass.Tradegoods)` or `C_Item.GetItemInfoInstant`.
  - Add quick category toggle pills along the top of the GoldFinder tab.
  - Add a Star/Favorite icon to each row with a "Show Starred Only" toggle, integrating with `C_AuctionHouse.IsFavoriteItem` or local watchlist.

### 4. [#13] Audio chime and chat summary notification when deals are found
- **Status:** Backlog / Planned
- **GitHub Issue:** [#13](https://github.com/justadakaje/wow-addons/issues/13)
- **Goal:** Alert players who are alt-tabbed or looking at other tabs when high-value snipes appear.
- **Details:**
  - When browse results settle and new qualifying deals are detected, play an in-game sound (e.g. `PlaySound(SOUNDKIT.AUCTION_WINDOW_OPEN)`).
  - Print a concise chat line: `[GoldFinder] 3 deals found! Top: Thorium Ore (42% off, +18g net)`.
  - Toggleable via settings (`/gf sound on/off`, `/gf chat on/off`).

### 5. [#14] Direct quick-buy for commodity deals (Shift-Click purchase)
- **Status:** Backlog / Planned
- **GitHub Issue:** [#14](https://github.com/justadakaje/wow-addons/issues/14)
- **Goal:** Enable rapid buyout for time-critical material snipes directly from the GoldFinder tab.
- **Details:**
  - For commodity listings, enable Shift-Click on a deal row to purchase directly without manual navigation to Blizzard's Buy tab.
  - Uses `C_AuctionHouse.StartCommoditiesPurchase` and `ConfirmCommoditiesPurchase`.
  - Includes a configurable safety spend cap (e.g. max 50g per quick-buy) to guard against accidental high-value purchases.
