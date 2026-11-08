# Visual Feedback Inspection from In-Game Client (Jakob Mortikus)

**Delivered by AgyOrch to AgyBuild:** 2026-11-05 01:36 EST  
**Game Client:** WoW: Forever (1.60.1.70707)  
**Location:** Orgrimmar Auction House (Auctioneer Leeka)

---

## 📸 Image Manifest in `docs/media/`

### 1. `feedback-01-goldfinder-tab.jpg` (GoldFinder AH Tab with Annotations)
* **Red Box 1 (Top Category Filter Bar):**
  - Shows buttons: `[ All ] [ Herbs ] [ Mining ] [ Cloth ] [ Leather ] [ ★ Watchlist ]`
  - **Issues Identified:**
    1. Uses classic red-tinted `UIPanelButtonTemplate` (dialog modal style), which clashes aggressively with the dark bronze/gold parchment AH palette.
    2. Button width and horizontal padding are tight; text crowds against the beveled endcaps.
    3. Better approach: Style as **sub-tabs** or subtle **inset pill toggles** (similar to the Auctions/Bids sub-tabs in Screenshot 4), with gold text highlight on active state and muted grey/white on inactive.
* **Red Box 2 (Bottom Tab Row):**
  - Shows full tab row: `[ Buy ] [ Sell ] [ Auctions ] [ GoldFinder ] [ Shopping ] [ Selling ] [ Cancelling ] [ Auctionator ]`
  - Tab spacing and `LibAHTab` placement are functioning cleanly without overlapping.
* **Search / Empty State Bug:**
  - Notice the center empty state message: `No deals matching " "`
  - The query contains a single space `" "` which is either lingering from default focus or untrimmed string matching in `ui.emptyTitle`. Ensure `str:match("^%s*(.-)%s*$")` completely clears pure whitespace queries back to empty `""`.

---

### 2. `feedback-02-buy-browse-tab.jpg` (Blizzard Native "Buy" / Browse Auctions Tab)
* **Design Reference:**
  - Shows Blizzard's native commodity search results (`Ruined Leather Scraps`, `Peacebloom`, `Silverleaf`, `Light Leather`, `Linen Cloth`).
  - **Native Watchlist Reference:** Notice the gold star `★` icon on the far right of each row (and the yellow star icon on the search header).
  - Clean row height and font hierarchy (`GameFontHighlightSmall` for names, standard coin display).

---

### 3. `feedback-03-sell-tab.jpg` (Blizzard Native "Sell" Tab)
* **Design Reference:**
  - Shows native inset boxes, checkbox styling (`Buyout Mode`), and dropdown menu styling (`Duration`).

---

### 4. `feedback-04-auctions-subtabs.jpg` (Blizzard Native "Auctions" Sub-Tabs)
* **Sub-Tab Reference:**
  - Look at the top-left sub-tabs: `[ Auctions ] [ Bids ]`
  - This is the exact Blizzard pattern for secondary view filtering inside an AH tab:
    - Inset rounded rectangular tabs
    - Subtle parchment/leather texture background
    - Highlighted active tab with gold text, inactive with grey/silver text
    - No red modal dialog borders!

---

## 🎯 Recommended Next Action for AgyBuild
1. Refactor the Category Filter Bar in `addons/GoldFinder/Tab.lua` from `UIPanelButtonTemplate` to match native AH sub-tabs or inset pill toggles.
2. Fix whitespace search query trimming so typing/leaving a space doesn't trigger `No deals matching " "`.
3. Verify with `node scripts/check-lua.js` and `node scripts/check-toc.js`.
