# WoW: Forever Addon Copilot & DevKit Setup

This repository includes a self-contained developer toolkit for building addons on **World of Warcraft: Forever** (`1.60.1`, Interface `16001`) without guessing deprecated or removed APIs.

WoW: Forever runs a modern engine over Classic-era content: legacy globals like `GetItemInfo`, `GetSpellInfo`, `UnitAura`, and `QueryAuctionItems` resolve to `nil`, while modern `C_*` namespaces, `C_EncodingUtil`, `C_AuctionHouse`, and Housing APIs exist (with a subset of undocumented `C_*` functions). Standard wikis and model memory are systematically wrong for this client.

---

## What Is Included

| Component | Path | Purpose |
| --- | --- | --- |
| **`wow-api` MCP Server** | `mcp/` | Read-only MCP server (`7` tools) backed directly by live client API dumps |
| **Live API Reference** | `reference/` | Machine-readable `api.json`, per-system Markdown pages (`reference/api/*.md`), system index (`reference/README.md`), and `reference/undocumented.md` |
| **Client Harvester** | `addons/ForeverProbe/` | In-game read-only probe (`/fprobe`, `/fpevents`, `/fphouse`) capturing `_G`, enums, events, watchlist checks, and `Blizzard_APIDocumentation*` |
| **Schema & Reference Extractor** | `scripts/extract-api.js` | Parses `ForeverProbe.lua` SavedVariables into `reference/api.json` + `reference/api/*.md` |
| **Static Validators** | `scripts/check-toc.js`, `scripts/check-lua.js`, `.luacheckrc` | Verifies `.toc` manifest file paths and parses Lua 5.1 syntax cleanly before launch |
| **AI Copilot Skill** | `.claude/skills/wow-addon-partner/SKILL.md` | Prompts AI assistants to verify every call through `wow-api` MCP before writing Lua |

Current indexed snapshot in `reference/api.json`: **WoW: Forever 1.60.1 (build 70862), Interface 16001** — **396 systems, 6,621 documented functions, 1,816 events, 1,759 table definitions, 1,912 global `Enum` tables (10,450 members), and 624 undocumented `C_*` functions**.

---

## Option 1: Build a Portable DevKit Zip to Share

From the repository root on Windows (PowerShell):

```powershell
# Build compiled MCP server and package a clean redistributable zip into dist/
.\scripts\package-devkit.ps1
```

This creates:

```text
dist/wow-forever-copilot-devkit-1.60.1-b70862.zip
```

Optional flags:

- `-IncludeNodeModules` — bundle `mcp/node_modules/` (production runtime dependencies or full `mcp/node_modules`) so the recipient does not even need `npm install` (larger zip).
- `-SkipBuild` — package the already-built `mcp/dist/` without invoking `npm run build`.
- `-OutDir <path>` — write the zip to a custom directory instead of `dist/`.

The zip unzips into a single `wow-forever-copilot-devkit/` directory with everything already arranged so `mcp/dist/data.js` locates `reference/api.json` automatically via its relative `../../reference/api.json` path.

### Recipient 3-Step Setup (after unzipping)

Requires **Node.js 20+**.

1. Install runtime dependencies (skip if built with `-IncludeNodeModules`):
   ```bash
   cd wow-forever-copilot-devkit/mcp
   npm install --omit=dev
   node smoke.mjs
   ```
   `smoke.mjs` speaks real MCP over stdio and runs all 18 tool verification checks against `reference/api.json`.
2. Register the MCP server with your AI tool (replace `<PATH_TO_DEVKIT>` with the extracted folder path, using forward slashes on Windows JSON configs):

   **Claude Code:**
   ```bash
   claude mcp add wow-api -- node <PATH_TO_DEVKIT>/mcp/dist/index.js
   ```

   **Claude Desktop / Cursor / Antigravity (`mcpServers` JSON):**
   ```json
   {
     "mcpServers": {
       "wow-api": {
         "command": "node",
         "args": ["<PATH_TO_DEVKIT>/mcp/dist/index.js"]
       }
     }
   }
   ```
   *(The zip also includes a pre-filled `mcp.json.example` at its root.)*
3. Copy `.claude/skills/wow-addon-partner/SKILL.md` and `AGENTS.template.md` (rename to `AGENTS.md` in your addon repo) into your addon project so your coding agent knows the WoW: Forever (`16001`) rules and `wow-api` tool names.

---

## Option 2: Use Directly From This Repository

```bash
git clone https://github.com/justadakaje/wow-addons.git
cd wow-addons/mcp
npm install
npm run build
node smoke.mjs
```

Register `node <repo>/mcp/dist/index.js` as `wow-api` in your MCP client config (see [mcp/README.md](../mcp/README.md)).

To run syntax and manifest validators in any checkout:

```bash
node scripts/check-toc.js
npm install --no-save luaparse
node scripts/check-lua.js
```

---

## Refreshing Data After a WoW: Forever Patch

1. Copy or symlink `addons/ForeverProbe` into `<WoW>/_forever_/Interface/AddOns/ForeverProbe` (or `<WoW>/_classic_beta_/Interface/AddOns/ForeverProbe`).
2. Log in (or `/reload`), wait for ForeverProbe's login summary, then log out or `/reload` again so WoW flushes `SavedVariables\ForeverProbe.lua`.
3. Extract updated Markdown and `reference/api.json`:
   ```bash
   npm install --no-save luaparse
   node scripts/extract-api.js "<WoW>/.../SavedVariables/ForeverProbe.lua"
   ```
4. Re-run `node mcp/smoke.mjs` — the footer on every MCP response (`WoW: Forever 1.60.1 (build ...), Interface 16001`) confirms the updated capture is live.

---

## Minimal WoW: Forever Starter `.toc`

```ini
## Interface: 16001
## Title: MyAddon
## Notes: Description of your addon.
## Author: YourName
## Version: 0.1.0
## SavedVariables: MyAddonDB
## X-Target-Client: WoW: Forever (camelot)

Core.lua
```

- Always use **`16001`** for WoW: Forever (`11601` is a known CurseForge digit-transposition bug and will be treated as out-of-date).
- Do not use `[AllowLoadGameType mainline]` or `[AllowLoadGameType vanilla]` thinking it matches Forever's Lua `WOW_PROJECT_ID = 1`: Forever's `.toc` loader expects `camelot`.

---

## MCP Tool Cheat Sheet

| Tool | When to Use |
| --- | --- |
| `lookup_api` | Before calling any global or `C_*` function; verifies signature & flags removed legacy globals (`GetItemInfo`, etc.) |
| `search_api` | Substring discovery across functions, events, and systems |
| `get_namespace` | List every documented function and event in one `C_*` namespace |
| `get_event` | Get payload fields **and** exact `RegisterEvent` literal string (`SCREAMING_SNAKE_CASE`) |
| `get_widget_methods` | Methods on Blizzard's 18 documented `FrameAPI*` widget families |
| `get_enum` | Resolve enum member numeric values (`Enum.*`) or structure fields referenced in signatures |
| `list_deprecated` | Inspect ForeverProbe's live-verified removed vs surviving legacy global watchlist |
