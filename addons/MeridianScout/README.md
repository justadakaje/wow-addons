# MeridianScout

Lightweight, read-only character progress and route-planning exporter for **WoW: Forever** (`1.60.1`, Interface `16001`).

## Features

- **Flight Master Route Recorder:** Listens to `TAXIMAP_OPENED` and records `"CURRENT"` and `"REACHABLE"` taxi node names into the per-character SavedVariable `MeridianScoutFlights` across continents as you visit flight masters.
- **One-Command Text Export (`/meridianscout`):** Opens a pre-highlighted copy-paste dialog (`MeridianScoutExport`) containing:
  - Character header: `<Name>-<Realm>|L<Level>|<XP>/<MaxXP>|<Faction>|<Race>|<Class>|<Zone>`
  - Active quest log (`Q:<questID>:<level>:<isComplete>:<title> | <objectives>`) using `C_QuestLog.GetNumQuestLogEntries`, `C_QuestLog.GetInfo`, `C_QuestLog.IsComplete`, and `C_QuestLog.GetQuestObjectives` (with Classic global fallbacks)
  - Completed quest ID list (`DONE(<count>):<id1,id2,...>`) via `C_QuestLog.GetAllCompletedQuestIDs()`
  - Hearthstone bind (`BIND: <location>`)
  - Current map ID, subzone, and coordinates (`POSITION: <mapID> <subZone> <x,y>`)
  - Sorted list of observed flight points (`OBSERVED TAXIS: <name1> | <name2> ...`)

## Usage

1. Enable **MeridianScout** on the character selection screen.
2. Open a flight master's taxi map on each continent you want included.
3. Run `/meridianscout` and press `Ctrl+C` to copy the export block.

## Development & Tests

- SavedVariablesPerCharacter: `MeridianScoutFlights`
- Unit specs in `tests/` run via `scripts/run-tests.ps1` (`luacheck` + `busted`).
