# Changelog

All notable changes to GoldFinder. Format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions follow
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
