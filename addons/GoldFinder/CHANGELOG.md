# Changelog

All notable changes to GoldFinder. Format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions follow
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.5.0] - 2026-11-07

### Added

- **Selling & Relisting Price Helper on Blizzard Sell Tab ([#33](https://github.com/justadakaje/wow-addons/issues/33)):** Automatically overlays a GoldFinder Market Card when dropping items into Blizzard's `ItemSellFrame` and `CommoditiesSellFrame`. Displays typical median price, current lowest market price, historical trend (Rising / Falling / Steady), market health warnings (e.g. crashed market relisting alerts), and one-click quick-fill buttons (`[-1c Cut]`, `[Match]`, `[Typical]`). Configurable via `/gf helper [on|off]`.
- **Market Depth & Sighting Confidence Score ([#34](https://github.com/justadakaje/wow-addons/issues/34)):** Implemented a 3-tier statistical confidence evaluation rating based on sample count $N$, observation time span, and coefficient of variation ($CV = \sigma / \mu$) to identify thin, manipulated, or erratic markets. Displays badges (`[HIGH]`, `[MED]`, `[THIN]`) in deal tooltips and item tooltips, with customizable filtering via `/gf minconf <any|med|high>`.
- **Cross-Character & Faction Market Data Sharing ([#27](https://github.com/justadakaje/wow-addons/issues/27)):** Upgraded database architecture (Schema 4) with transparent realm partitioning (`GoldFinderDB.realms[realm]`). Scans performed on bank alts immediately inform price tooltips and deal detection on leveling or gathering characters on the same server without cross-realm contamination. Added `/gf factionshare [on|off]` to toggle neutral vs faction AH partitioning and `/gf sync` to inspect database sharing scope.
- **Item Blacklist & Market Ignore Filter ([#35](https://github.com/justadakaje/wow-addons/issues/35)):** Added permanent item ignore filtering in `GoldFinderDB.blacklist` to suppress vanity, low-liquidity, or high-deposit manipulation items from cluttering deals and alerts. Includes `/gf ignore <link|id>`, `/gf unignore`, `/gf blacklist`, and an instant `Alt+Right-Click` shortcut directly on deal rows.
- **LibDataBroker (LDB) Feed & Minimap Button ([#23](https://github.com/justadakaje/wow-addons/issues/23)):** Integrated with `LibDataBroker-1.1` and `LibDBIcon-1.0` to display active deal counts and top flip profit estimates in broker panels (Titan Panel, ChocolateBar, Bazooka) and provide a coin minimap shortcut with instant hover deal summaries, AH navigation, and CSV export shortcuts. Configurable via `/gf minimap [on|off]`.

## [0.4.0] - 2026-11-07

### Added

- **Direct Quick-Buy for Commodities ([#14](https://github.com/justadakaje/wow-addons/issues/14)):** Added Shift-Left-Click shortcut on deal rows to purchase commodity items instantly without navigating to Blizzard's Buy tab. Built on `C_AuctionHouse.StartCommoditiesPurchase` and `ConfirmCommoditiesPurchase` with full two-step server price verification and coin audio confirmation.
- **Crafting Conversion & Arbitrage ([#18](https://github.com/justadakaje/wow-addons/issues/18)):** Implemented the second core pillar of GoldFinder: detecting profitable reagent conversions where output market sell value exceeds total ingredient costs. Added high-volume deterministic recipes for Smelting (Copper, Tin, Bronze, Iron, Steel, Gold, Mithril, Truesilver, Thorium, Dark Iron), Tailoring (Linen, Wool, Silk, Mageweave, Runecloth bolts), and Alchemy (Transmute Arcanite). Added dedicated `[ Crafts ]` category sub-tab with ROI % calculations and detailed reagent cost breakdowns on hover.
- **Active Auction Undercut Detection ([#17](https://github.com/justadakaje/wow-addons/issues/17)):** Integrated player auction tracking via `C_AuctionHouse.GetOwnedAuctions()` to cross-examine active listings against current lowest browse prices. Added dedicated `[ Undercuts ]` sub-tab displaying competitor undercut margins and a one-click cancel shortcut via `C_AuctionHouse.CancelAuction()` to immediately free up capital and relist.
- **Shopping Lists & Material Quota Tracker ([#22](https://github.com/justadakaje/wow-addons/issues/22)):** Added goal-oriented material acquisition tracking stored in `GoldFinderDB.shoppingLists`. Features real-time bag and bank inventory counting via `C_Item.GetItemCount()`, `/gf buy <link|itemID> <targetQty> [maxUnitPrice]` target configuration, `/gf unbuy` and `/gf shopping` progress inspection, and a dedicated `[ Shopping ]` sub-tab tracking fulfillment progress, remaining units, and total required gold. Automatic live refreshes on `BAG_UPDATE_DELAYED`.
- **Configurable Quick-Buy Spend Cap:** Added `/gf maxspend <amount>` (and `/gf quickbuy <amount>`) to establish a safety spend threshold (default: `50g`, supports values like `100g`, `25g50s`, or `0` to disable), guarding against accidental high-value purchases on large lots.

## [0.3.0] - 2026-11-05

### Added

- **Minimum Profit Threshold Filter ([#30](https://github.com/justadakaje/wow-addons/issues/30)):** Added `/gf minprofit <amount>` slash command (supporting denominations like `5g`, `50s`, `1g50s`, or plain gold amounts like `10`, with `0` to disable) to filter out low-margin micro-deals and focus exclusively on high-yield flips in `ns.FindDeals` and the AH tab.
- **Visual Tier Highlights ([#25](https://github.com/justadakaje/wow-addons/issues/25)):** Implemented auction row highlights with Epic Purple `[SNIPE]` (deals with >= 500g profit or >= 70% discount), Rare Blue `[GREAT]`, and Good Value tinting, backed by sound alerts and chat frame notifications.
- **Category Filter Tabs & Watchlist ([#12](https://github.com/justadakaje/wow-addons/issues/12)):** Added native dark bronze inset sub-tabs matching Blizzard AH design (`All`, `Herbs`, `Mining`, `Cloth`, `Leather`, `Watchlist`) and per-row persistent star bookmarking using native `ReputationStar` textures.
- **Blizzard AddOn List Categorization:** Added `## Category: Auctions` metadata to `GoldFinder.toc` for native hierarchical grouping in WoW Forever build 70707.
- **Lexical Scope Hotfix:** Forward-declared `ItemName` in `Tab.lua` (line 112) to prevent unassigned global lookup crashes on star click.
- **Multi-Client Manifest Unification:** Unified multi-client interfaces into a single authoritative `GoldFinder.toc` supporting interface 16001 (Forever), Retail (110007–110200, 120100), Classic Era (11506–11509), and MoP Classic (50400–50504).

## [0.2.0] - 2026-11-04

### Added

- **Estimated Net Profit & Yield Display ([#10](https://github.com/justadakaje/wow-addons/issues/10)):** Deals now calculate unit and total flip profit after accounting for the 5% Auction House cut (`((typical * 0.95) - lowestNow) * quantity`).
- **Interactive Column Sorting:** Added "Est. Profit" column to the GoldFinder tab. Players can click either "Below" or "Est. Profit" column headers (or use `/gf sort`) to toggle between sorting by highest net profit or deepest discount.
- **Configurable Thresholds & Settings ([#11](https://github.com/justadakaje/wow-addons/issues/11)):** Slash commands `/goldfinder` and `/gf` allow customizing the discount percentage (`/gf ratio <5-95>`), required historical scan points (`/gf minscans <1-20>`), or applying trading presets (`/gf preset snipe | standard | volume`).
- **Deal Alert Chimes & Chat Notifications ([#13](https://github.com/justadakaje/wow-addons/issues/13)):** Plays a subtle audio chime and prints an in-game chat summary when scans complete and find deals meeting the configured threshold. Can be toggled with `/gf sound` and `/gf chat`.
- **Price Trend Trajectory ([#15](https://github.com/justadakaje/wow-addons/issues/15)):** Analyzes median prices across historical scans to detect whether an item's market is rising, steady, or falling; row tooltips now highlight price direction and recent sighting prices to protect against "falling knives."
- **Item Tooltip Price Integration ([#16](https://github.com/justadakaje/wow-addons/issues/16)):** Appends GoldFinder's recorded typical market price and lowest seen price directly to item tooltips in bags, vendor screens, and item links. Toggleable via `/gf tooltip [on|off]`.
- **Data Hygiene & CSV Export ([#19](https://github.com/justadakaje/wow-addons/issues/19)):** Added `/gf export` dialog with one-click copy of deals data to CSV for Google Sheets/Excel, `/gf prune [days]` to purge stale entries older than 30 days, and `/gf resetitem <link>` to reset an item's history.

## [0.1.0] - 2026-09-27

First release. Finds crafting materials listed well below their normal price
on the WoW: Forever auction house. Tested on build 70009.

### Added

- A **GoldFinder** tab on the auction house, added through
  [LibAHTab](https://github.com/TheMouseNest/LibAHTab) so it lines up beside
  Blizzard's tabs and other auction house addons' tabs instead of overlapping
  them.
- **Price history from scans you already run.** GoldFinder never searches the
  auction house itself. It records the results of Auctionator's Full Scan, the
  Buy tab, or any other search, so it never uses up the scan cooldown.
- **Deals:** a material whose lowest listing is at least 30% below the median
  of its earlier prices. An item needs three earlier prices, taken at least 10
  minutes apart, before it is judged; one not seen in the last 30 minutes is
  not judged.
- **Click a deal** to open its listings in Blizzard's Buy tab, where the
  purchase happens with Blizzard's own confirmation.
- Anything that cannot be judged is explained on the tab in a sentence. Hover
  the footer for details of the last scan and the tab row.

### Known limitations

- "Typical" is the median of as few as three scans, which is noisy on a small
  market. **Check a deal in the Buy view before buying it** — a click takes you
  there.
- Prices are measured as per unit for commodities. Other materials are not
  measured yet.
