# Changelog

All notable changes to GoldFinder. Format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions follow
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-11-07

### Added

- **Interactive Feature Tour & Onboarding Walkthrough ([#51](https://github.com/justadakaje/wow-addons/issues/51)):** Added a clean, 6-step interactive onboarding walkthrough (`Tour.lua`) guiding users through GoldFinder's passive scanning architecture, discount calculation, Quick-Buy vs Cart staging, live Snipe mode, Sell tab price helper, and mailbox collection with Goblin P&L accounting. Accessible anytime via `/gf tour` or from the Info dashboard.
- **Character-Specific Profile Persistence (HUD Edit Mode Style):** Added full profile persistence in `GoldFinderDB.profiles` and `GoldFinderDB.profileKeys`. Added a top profile management bar in GoldFinder Options featuring an active profile indicator (`Default (Account-Wide)` vs `<Character> (Character-Specific)`), a one-click `Character-Specific Settings` toggle matching WoW's native HUD Edit Mode architecture, and a `[Copy From...]` quick sync button. Fixed an options window display bug where slider and checkbox controls were not visibly refreshed upon window opening after `/reload`.
- **Multi-Language Localization Engine ([#52](https://github.com/justadakaje/wow-addons/issues/52)):** Integrated full localization support (`Localization.lua`) supporting 8 regional locales (`deDE`, `frFR`, `esES`, `esMX`, `zhCN`, `zhTW`, `koKR`, `ruRU`) with metamethod-driven graceful fallback to `enUS`. Covers all UI headers, filters, tooltips, price helper cards, and slash command diagnostics.
- **Performance Profiling, Benchmarking & GC Certification ([#53](https://github.com/justadakaje/wow-addons/issues/53)):** Added performance benchmarking slash commands (`/gf bench`, `/gf memory`) and real-time telemetry. Validates memory working set (strictly <5MB ceiling, typically <1.5MB) and sub-millisecond deal calculation latency across full commodity databases with zero frame stutter or memory leaks.
- **Journalator-Style Info & Diagnostics Dashboard ([#54](https://github.com/justadakaje/wow-addons/issues/54)):** Added a polished project dashboard (`Info.lua`) accessible via `/gf info`, `/gf about`, or the `[About / Info]` button in GoldFinder Options. Features copyable edit boxes for Discord, GitHub issues, and CurseForge; translator acknowledgments; and a live system diagnostic card displaying current memory usage, tracked reagents, historical price counts, realm partition, client interface build, and AH architecture.
- **Dedicated Chat Window Tab Option:** Added `/gf chat tab` and a settings toggle in GoldFinder Options to cleanly route all GoldFinder deal notifications, snipes, and system notices into an isolated, dedicated "GoldFinder" chat tab.
- **Blizzard Sell Tab Price Helper Layout Overhaul:** Rebuilt fontstring anchoring with fixed 115px label widths and left-aligned values (`SellHelper.lua`), permanently eliminating text and coin texture overhang on the right border.
- **Extended Slider Ranges for Early Progression:** Lowered GoldFinder Options slider minimum bounds so players can set Quick-Buy Spend Caps as low as 1g and Minimum Profit Floors down to 0g.
- **Non-Tainting Export Copy Pattern:** Replaced protected `CopyToClipboard` API calls in the profile export modal with native `EditBox:HighlightText()` focus patterns to prevent UI taint.

## [0.9.0] - 2026-11-07

### Added

- **Base64 Profile String Export & Import ([#48](https://github.com/justadakaje/wow-addons/issues/48)):** Added portable profile serialization (`Profiles.lua`) allowing full trading configurations, custom material categories, watchlists, shopping lists, and restock levels to be shared across characters, accounts, or friends via copy-pasteable Base64 strings. Accessible via `/gf profile [export|import]` and a dedicated `[ Profile Import / Export ]` button in GoldFinder Options. Includes an interactive multiline dialog with instant copy-to-clipboard focus.
- **Multi-Account & Cross-Character Database Merger ([#49](https://github.com/justadakaje/wow-addons/issues/49)):** Added external scan database synchronization engine (`ns.MergeScanDatabase()`). Ingests external scan dumps and price records, performing chronological deduplication across sightings (10-minute window) to synthesize shared market intelligence across multiple accounts without overwriting local history. Accessible via `/gf merge <data_string>`.
- **Database Compaction & Automated Vacuum Maintenance ([#50](https://github.com/justadakaje/wow-addons/issues/50)):** Implemented a rigorous database compaction engine (`ns.VacuumDatabase()`) guaranteeing SavedVariables storage stays well below 2MB. Prunes historical sightings older than 30 days, deduplicates same-day stagnant price points, trims excessive history arrays (capped at 30 entries per item), and purges orphaned unreferenced items. Runs automatically on login every 7 days and manually via `/gf vacuum [days]` or the `[ Compact & Vacuum DB ]` Options button.
## [0.8.0] - 2026-11-07

### Added

- **Live Snipe Mode & High-Value Deal Alarm ([#44](https://github.com/justadakaje/wow-addons/issues/44)):** Added live background Snipe Mode with a dedicated `[ Snipe: OFF / ON ]` header toggle and `/gf snipe [on|off]`. Automatically watches incoming auction scans for "Mega Snipes" (discounts >= 70% or estimated net profit >= 100g, customizable via `/gf snipethreshold <amt>`), immediately triggering high-urgency audio alarms (`SOUNDKIT.RAID_WARNING`), on-screen RaidWarning banners, and Epic Purple chat notices.
- **Inventory Restock & Stockout Safety Level Warnings ([#45](https://github.com/justadakaje/wow-addons/issues/45)):** Added material safety stock tracking via `GoldFinderDB.restock`. Automatically counts current bag and bank stock via `C_Item.GetItemCount()`. Displays `[LOW]` restock tags directly on deal rows, low stock alerts in broker tooltips, safety stock targets on item tooltips, and management via `/gf restock <link|id> <minQty>`, `/gf unrestock`, and `/gf restock`.
- **Fixed Vendor Reagent Cost Integration ([#46](https://github.com/justadakaje/wow-addons/issues/46)):** Integrated a curated database (`Vendors.lua`) of unlimited-stock NPC trade reagents (Coal, Weak/Strong Flux, Threads, Vials, Spices, Flour). Injects exact vendor purchase costs into multi-step crafting conversions, flags overpriced AH listings on tooltips (`[OVERPRICED NPC ITEM: Buy from Vendor for X]`), and automatically suppresses overpriced vendor reagents from false deal alerts.
- **Multi-Item Quick-Buy Staging Cart ([#47](https://github.com/justadakaje/wow-addons/issues/47)):** Added a multi-deal batch purchase staging cart (`Cart.lua`). Alt-Click any deal row to stage materials into the cart. Includes a dedicated `[ Cart (N) ]` header button, interactive staging cart modal with live total cost and estimated flip profit KPIs, and sequential throttled `[ Buy All Items ]` execution protected by quick-buy spend cap limits.

## [0.7.0] - 2026-11-07

### Added

- **Mailbox One-Click Deal Collector & Cost Tracking ([#40](https://github.com/justadakaje/wow-addons/issues/40)):** Adds a native `[ Collect Deals (N) ]` button to the `MailFrame` header. Automatically processes buyer invoice item deliveries and seller sale payouts sequentially with `C_Mail.IsCommandPending()` safety pacing. Ingests purchase cost basis into `GoldFinderDB.costBasis` upon pickup.
- **Realized Profit & Loss (P&L) Goblin Ledger ([#41](https://github.com/justadakaje/wow-addons/issues/41)):** Complete financial accounting dashboard accessible via `/gf ledger`, `/gf pnl`, or the GoldFinder Options panel. Displays 4 KPI metric cards (Lifetime Net Profit, Average Flip ROI %, Total Flips, Total Gross Revenue), top 3 all-time flips banner, a 12-row scrollable recent flips transaction table with hover breakdowns (gross sold price, Blizzard 5% AH cut, net revenue, acquisition cost basis, realized net profit, ROI %), and a one-click [Export CSV] action.
- **Inventory Cost Basis Tooltip Overlay ([#42](https://github.com/justadakaje/wow-addons/issues/42)):** Displays average unit cost basis (`GoldFinder Cost Basis: <price> (<qty>x bought)`) and live unrealized net margins against typical market baselines (`Unrealized Margin: +<profit> (<roi>%)`) directly on bag, bank, and inventory item tooltips. Configurable via Options panel and `/gf cost <link|id>`.
- **Expired Auction Relist Advisor ([#43](https://github.com/justadakaje/wow-addons/issues/43)):** Evaluates returned and expired auctions upon mailbox inspection. Classifies items into actionable guidance: `[HOLD - BELOW COST]` when current market drops below cost basis, `[RELIST - HEALTHY MARKET]` when price has recovered, and `[WAIT - UNDERCUT WAVE]` during temporary competitor dumps. Displays recommendations in chat during collection and overlays advice directly on mailbox item tooltips.

## [0.6.0] - 2026-11-07

### Added

- **Alternative Valuation Engine ([#38](https://github.com/justadakaje/wow-addons/issues/38)):** Added configurable valuation models to calculate typical market baselines: Standard Median, Trimmed Mean (10% outlier trim), and 7-Day Exponential Moving Average (EMA). Switchable via Options panel dropdown or `/gf valuation <median|trimmed|ema>`.
- **Custom Category Builder & Group Editor ([#39](https://github.com/justadakaje/wow-addons/issues/39)):** Dynamic multi-line wrapping category bar in the GoldFinder AH tab, in-game `[+ Group]` modal dialog, Shift+Right-Click item assignment from deal rows, right-click group deletion with confirmation, and slash commands `/gf group create|delete|add|remove|list`.

## [0.5.0] - 2026-11-07

### Added

- **Graphical Options & Configuration Panel ([#36](https://github.com/justadakaje/wow-addons/issues/36)):** Added a native graphical settings interface accessible via `/gf config`, `/gf options`, the [Options] button in the GoldFinder AH tab header, or right-clicking the minimap button. Features interactive sliders for discount threshold (5%–50%), minimum prior scans (1–20), minimum profit floor (0–50g), and quick-buy spend cap (0–500g); sighting confidence rating filters; a 6-option sound kit picker with instant audio preview [Test Sound] button; sound throttle cooldown slider; cross-faction market sharing toggle; minimap icon toggle; and a [Reset Defaults] action.
- **Selling & Relisting Price Helper on Blizzard Sell Tab ([#33](https://github.com/justadakaje/wow-addons/issues/33)):** Automatically overlays a GoldFinder Market Card when dropping items into Blizzard's `ItemSellFrame` and `CommoditiesSellFrame`. Displays typical median price, current lowest market price, historical trend (Rising / Falling / Steady), market health warnings (e.g. crashed market relisting alerts), and one-click quick-fill buttons (`[-1c Cut]`, `[Match]`, `[Typical]`). Configurable via `/gf helper [on|off]`.
- **Market Depth & Sighting Confidence Score ([#34](https://github.com/justadakaje/wow-addons/issues/34)):** Implemented a 3-tier statistical confidence evaluation rating based on sample count $N$, observation time span, and coefficient of variation ($CV = \sigma / \mu$) to identify thin, manipulated, or erratic markets. Displays badges (`[HIGH]`, `[MED]`, `[THIN]`) in deal tooltips and item tooltips, with customizable filtering via `/gf minconf <any|med|high>`.
- **Cross-Character & Faction Market Data Sharing ([#27](https://github.com/justadakaje/wow-addons/issues/27)):** Upgraded database architecture (Schema 4) with transparent realm partitioning (`GoldFinderDB.realms[realm]`). Scans performed on bank alts immediately inform price tooltips and deal detection on leveling or gathering characters on the same server without cross-realm contamination. Added `/gf factionshare [on|off]` to toggle neutral vs faction AH partitioning and `/gf sync` to inspect database sharing scope.
- **Item Blacklist & Market Ignore Filter ([#35](https://github.com/justadakaje/wow-addons/issues/35)):** Added permanent item ignore filtering in `GoldFinderDB.blacklist` to suppress vanity, low-liquidity, or high-deposit manipulation items from cluttering deals and alerts. Includes `/gf ignore <link|id>`, `/gf unignore`, `/gf blacklist`, and an instant `Alt+Right-Click` shortcut directly on deal rows.
- **LibDataBroker (LDB) Feed & Minimap Button ([#23](https://github.com/justadakaje/wow-addons/issues/23)):** Integrated with `LibDataBroker-1.1` and `LibDBIcon-1.0` to display active deal counts and top flip profit estimates in broker panels (Titan Panel, ChocolateBar, Bazooka) and provide a coin minimap shortcut with instant hover deal summaries, AH navigation, and CSV export shortcuts. Configurable via `/gf minimap [on|off]`.
- **Customizable Audio Alerts & Cooldown Throttle ([#26](https://github.com/justadakaje/wow-addons/issues/26)):** Added configurable sound kit selection (`auction`, `coins`, `whisper`, `raid`, `loot`) with instant audio playback on selection via `/gf sound <choice>`. Added configurable audio alert cooldown throttle (default: 30 seconds) via `/gf soundthrottle <seconds>` to prevent rapid chime spam during frequent manual browsing.

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
