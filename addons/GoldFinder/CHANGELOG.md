# Changelog

All notable changes to GoldFinder. Format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions follow
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- **Real-Time In-Tab Search Box ([#24](https://github.com/justadakaje/wow-addons/issues/24)):** Added a native SearchBoxTemplate editbox to the top-right of the GoldFinder AH tab. Filters deals live by material name as you type, updates deal counts dynamically, and includes Escape/Enter unfocus handling and clear button support.

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
