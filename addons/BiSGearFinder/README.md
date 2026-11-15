# BiSGearFinder

Best-in-Slot (BiS) BoE equipment browser, Auction House scanner, realm scarcity radar, and tooltip helper for **WoW: Forever** (`1.60.1`, Interface `16001`).

## Features

- **Curated BoE BiS Knowledge Base (`Knowledge/Data.lua`):** Tracks `43+` Best-in-Slot equipment items across Pre-Raid BiS, Epic World Drops, crafted BiS (such as `Lionheart Helm`, `Devilsaur Leggings`), and twink gear, tagged by class, role, slot, armor type, and acquisition source.
- **Interactive Browser (`/bgf`, `/bgf browse`, `/bis`):** Filter tracked BiS gear by tier (`PRE_RAID`, `EPIC`, `TWINK`), class, or text search (`UI.lua`).
- **Targeted AH Scanner & Passive Market Observer (`Scanner.lua`):** Queries `C_AuctionHouse` for tracked BiS BoEs and caches lowest buyouts and listing counts in `BiSGearFinderDB`, falling back to `GoldFinderDB` history when available.
- **Scarcity & Monopoly Radar (`Radar.lua`):** Flags unlisted (`SCARCE`) or single-seller BiS items and alerts players holding unlisted BiS gear in their bags.
- **Tooltips & GoldFinder Bridge (`Core.lua`, `Bridge.lua`):** Annotates item tooltips (`TooltipDataProcessor` / `GameTooltip` fallback) with BiS notes and optionally adds a `[ BiS BoEs ]` AH bridge when **GoldFinder** is loaded.

## Slash Commands

| Command | Action |
| --- | --- |
| `/bgf`, `/bgf browse`, `/bgf ui`, `/bis` | Toggles the interactive BiS Gear browser window |
| `/bgf scan` | Starts a targeted Auction House scan for tracked BiS BoEs |
| `/bgf radar` | Prints scarcity report (unlisted, single-seller, active) and checks bags for unlisted BiS items |
| `/bgf list [filter]` | Lists matching BiS items in chat (filter by class or tier) |
| `/bgf debug` | Captures a diagnostic snapshot into `BiSGearFinderDB` |

## Development & Tests

- SavedVariables: `BiSGearFinderDB`
- CurseForge copy: [docs/curseforge/bisgearfinder.md](../../docs/curseforge/bisgearfinder.md)
- Unit specs in `tests/` run via `scripts/run-tests.ps1` (`luacheck` + `busted`).
