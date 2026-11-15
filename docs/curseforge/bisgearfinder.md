# BiSGearFinder — BoE Best-in-Slot Radar, Scarcity Tracker & Upgrade Advisor

**BiSGearFinder** (BGF) tracks curated Best-in-Slot (BiS) Bind-on-Equip (BoE) armor, world drop weapons, and twink tournament gear across your realm. It features an interactive in-game browser, targeted 1-click Auction House batch scanning, passive inventory monopoly alerts, and live market intelligence.

---

## Why BiSGearFinder?

High-value BoE equipment (like *Edgemaster's Handguards*, *Lionheart Helm*, *Krol Blade*, *Flurry Axe*, *Freezing Band*, and twink staples like *Shadowfang* and *Assassin's Blade*) represents the highest-margin items in World of Warcraft. However:
1. **Blind Market Valuation:** Unlisted items often get undersold by players who don't realize there are zero competitors on the realm.
2. **Scattered Information:** Checking which BoEs are true Pre-Raid BiS or bracket-defining twink gear usually requires digging through third-party websites outside the game.
3. **Auction House Lag:** Browsing dozens of items individually wastes time and risks Blizzard query throttling.

BiSGearFinder solves this by packaging an offline curated database into an interactive in-game browser and marrying it to Blizzard's modern Auction House APIs for instant realm scarcity tracking.

---

## Key Features

### 🎯 Curated BiS BoE Matrix & In-Game Browser (`/bgf`)
- **43+ Verified High-Value BoEs:** Pre-Raid BiS crafted & world drops, iconic epic weapons (*Teebu's Blazing Longsword*, *Alcor's Sunrazor*, *Skullflame Shield*), and Level 19 / 39 bracket twink essentials.
- **Smart Class Filtering:** One-click `"My Class"` toggle instantly filters the browser to gear your character can equip (Warrior, Rogue, Mage, Hunter, Paladin, Priest, Shaman, Warlock, Druid).
- **Tier Tabs:** Quickly toggle between `[All]`, `[Pre-Raid]`, `[Epics]`, and `[Twinks]`.
- **Search Query Bar:** Search by item name or item ID in real time.

### 🔍 1-Click AH Batch Scanner (`Scan AH Now`)
- **Multi-Key Search:** Queries all 43 tracked BiS items simultaneously using Blizzard's batch search APIs in a single request.
- **Live Buyout Intelligence:** Automatically identifies lowest buyout price, total quantity available, and single-seller listings.
- **Instant `[UNLISTED]` Scarcity Tagging:** Immediately stamps items that have zero active realm listings in red text, letting you spot monopoly opportunities at a glance.
- **Click-to-Search:** Clicking any item row in the BGF window automatically loads that specific item in the Blizzard Auction House window.

### 📡 Scarcity & Monopoly Radar
- **Bag Inventory Watcher:** Passively monitors your bags when visiting the Auction House. If you hold an item that is currently unlisted on your realm, BiSGearFinder alerts you with a recommended scarcity pricing premium (+25% to +50%).
- **Single-Seller Warning:** Flags items with only 1 active listing (`(1 left)`) so buyers know they are paying a monopoly price.

### 🏷️ Resilient Tooltip Integration & Cold-Cache Fallback
- **Tooltip Enhancements:** Adds clean BiS tier tags (`[Pre-Raid BiS]`, `[Top BoE Epic]`, `[L19 Twink BiS]`), target classes, and curated stat notes to item tooltips.
- **Zero "Retrieving item information" Freezes:** Even if an item is not yet cached in your local game memory, BiSGearFinder renders curated offline stats immediately, seamlessly upgrading to full Blizzard server stats once loaded.
- **Genuine Icon Fallbacks:** Never shows broken red question mark icons (`134400`), even on cold client caches.

### 🤝 GoldFinder Market Bridge
- **Cross-Addon Synergy:** When used alongside **GoldFinder**, BiSGearFinder automatically reads historical pricing baselines and median market values without running duplicate full scans.
- **Standalone Capability:** Operates 100% independently if GoldFinder is not installed.

### 🩺 Diagnostic & Logging Suite (`/bgf debug` & `/bgf dump`)
- **Built-in Diagnostics:** Easily verify item cache status, network load results, and event logs.
- **Copy-Pasteable In-Game Dump:** Use `/bgf dump` to open a clean text window with a "Select All" button to share diagnostics or verify addon health.

---

## Slash Commands

| Command | Description |
|---|---|
| `/bgf` or `/bis` | Toggle the interactive BiS BoE browser window |
| `/bgf scan` | Start a targeted Auction House batch scan |
| `/bgf radar` | Check inventory for unlisted items & print realm scarcity |
| `/bgf list [class\|tier]` | Print matching items to chat (e.g. `/bgf list warrior`, `/bgf list twink`) |
| `/bgf check <link\|id>` | Look up an item in the curated BiS matrix |
| `/bgf tooltip` | Toggle item tooltip annotations on/off |
| `/bgf info` | Display database status and bridge connectivity |
| `/bgf debug` | Capture diagnostic snapshot to SavedVariables |
| `/bgf dump` | Open in-game copy-pasteable diagnostic window |
| `/bgf preload` | Force server data requests for all tracked items |

---

## Supported Game Clients

BiSGearFinder is built with zero code duplication for multi-client compatibility:

- **WoW: Forever** (1.60.1 Beta, Build 70862, Interface `16001`)
- **Classic Era & Season of Discovery** (Interface `11506`–`11509`, `20506`)
- **Retail / The War Within** (Interface `110007`–`110200`, `120100`)
- **Mists of Pandaria Classic** (Interface `50400`–`50504`)

---

## License

BiSGearFinder is released under the **MIT License**.
