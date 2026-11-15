# ForeverProbe

Read-only diagnostic addon for **WoW: Forever** (`1.60.1`, Interface `16001`) that snapshots the live client API surface, global enums, `WOW_PROJECT_*` constants, watchlist symbols, and runtime events into SavedVariables without modifying game state.

## What It Captures

1. **API & Schema Snapshot (`ForeverProbe.lua` -> `ForeverProbeDB`):**
   - Loads `Blizzard_APIDocumentation` and `Blizzard_APIDocumentationGenerated` via `C_AddOns.LoadAddOn` (and calls `APIDocumentation_LoadUI` when present) to harvest every documented system, function signature (`Arguments`, `Returns`), event payload + `LiteralName`, and type/struct/enum table (`Fields` with `EnumValue`).
   - Snapshots runtime values from `_G.Enum`, `WOW_PROJECT_*` constants, globals, `C_*` tables, and explicit probe entries in `WATCHLIST`.
2. **Passive Event & Housing Recorder (`Events.lua` -> `ForeverProbeEventsDB`):**
   - Calls `RegisterAllEvents()` into three bounded buckets: `counts` (tallies for all events including high-frequency noisy ones), `firstSeen` (first firing payload of each distinct non-noisy event), and `log` (capped full payloads for Housing/Campsite/neighborhood-matching events).
   - Evaluates an explicit read-only allowlist of safe `C_Housing` getters (`SAFE_GETTERS`) so destructive/mutating functions (`ResetHouse`, `RelinquishHouse`, etc.) are never invoked.

## Slash Commands

| Command | Action |
| --- | --- |
| `/fprobe` | Triggers a fresh read-only API capture and prints the summary (persists to `ForeverProbeDB` on `/reload` or logout) |
| `/fpevents [housing]` | Summarizes captured event counts and recent interesting events (pass `housing` to filter housing/camp events) |
| `/fphouse` | Runs the explicit read-only `C_Housing` safe-getter snapshot into `ForeverProbeEventsDB` |

## Extracting Documentation & Feeding `wow-api` MCP

After running `/reload` or logging out so WoW flushes SavedVariables:

```bash
node scripts/extract-api.js "<WoW>/.../SavedVariables/ForeverProbe.lua"
```

This regenerates [reference/api.json](../../reference/api.json), [reference/README.md](../../reference/README.md), [reference/undocumented.md](../../reference/undocumented.md), and `reference/api/*.md`, which directly back the [wow-api MCP server](../../mcp/README.md).
