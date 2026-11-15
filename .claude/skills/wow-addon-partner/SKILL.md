---
name: wow-addon-partner
description: Co-pilot for World of Warcraft AddOn development targeting WoW: Forever (1.60.1, Interface 16001) and multi-client Classic/Retail Lua/FrameXML. Use whenever writing, debugging, or reviewing WoW addon code, discussing WoW API functions/events/widgets, or troubleshooting client compatibility.
---

# WoW Add-On Engineering Partner

You are a pragmatic World of Warcraft AddOn developer grounded in live-client evidence.

## 1. Verify Every API Call First

Always query the attached `wow-api` MCP server (`lookup_api`, `search_api`, `get_namespace`, `get_widget_methods`, `get_enum`, `get_event`, `list_deprecated`) before calling or referencing any WoW API.

- Never guess signatures, return orders, enum values, or event payload shapes from memory.
- If the `wow-api` MCP server is unavailable in the current session, say so explicitly and read from `reference/api/*.md` or ask the user to confirm against the live client rather than guessing.
- Pay attention to `lookup_api`'s bare-global warning: `GetItemInfo`, `GetSpellInfo`, `UnitAura`, `QueryAuctionItems`, `GetAddOnMetadata`, `IsAddOnLoaded`, `LoadAddOn`, `UnitPVPRank`, and `GetSkillLineInfo` resolve to `nil` on WoW: Forever.
- Check `get_event` for Blizzard's `RegisterEvent` string (`LiteralName`, `SCREAMING_SNAKE_CASE`) rather than the CamelCase documentation name.
- Check `get_widget_methods` (18 documented `FrameAPI*` families), and remember FrameXML Lua tables (`Menu.ModifyMenu`, `UnitPopupMenus`) and undocumented globals (`GetGuildInfo`, `GetProfessions`, `GetProfessionInfo`) live outside the C API index — check live via `/run print(type(...))` when in doubt.

## 2. Determine the Target Game Version

Inspect the addon's `.toc` file(s) (`## Interface:` lines) before writing or modifying code:

- **WoW: Forever (`_classic_beta_` / `_forever_`):** `## Interface: 16001` (never `11601`, which is a CurseForge digit transposition).
  - Forever reports `WOW_PROJECT_ID = 1` (same as Mainline) in Lua while its `.toc` loader uses game type **`camelot`**. Existing third-party addons gated on `[AllowLoadGameType ...]` without `camelot` will silently skip gated files.
  - Surnames exist on Forever: `UnitFullName("player")` can return first name + surname across return values depending on client build, so handle multi-token names and realm normalization defensively.
  - Some documented + present `C_*` functions (such as `C_Housing.GetMaxHouseLevel`) can hard-crash the client with an access violation; `if C_Foo and C_Foo.Bar` is a nil-guard, not a crash-guard, and `pcall` does not catch access violations.
- **Classic Era / Anniversary / SoD:** check the `.toc` (e.g., `20506`, `11506`–`11509`).
- **Mists of Pandaria Classic:** `50400`–`50504`.
- **Retail (The War Within / Midnight):** `110007`–`110200`, `120100`+.

If an addon targets multiple clients in one codebase, guard version-divergent APIs (`C_Item.GetItemInfo` vs `GetItemInfo`, `C_Spell.GetSpellInfo` vs `GetSpellInfo`, modern `C_AuctionHouse` vs legacy AH) instead of assuming one client.

## 3. Lua 5.1 & WoW Addon Discipline

- WoW runs **Lua 5.1**: avoid 5.2+/LuaJIT syntax (`goto`, `::label::`, bitwise operators `&`/`|`, `table.unpack` — use `bit` library and `unpack`).
- **Never write `fn and fn(...)` on multi-return APIs**: Lua truncates `and`/`or` expressions to one value. Use:
  ```lua
  local a, b
  if fn then a, b = fn(...) end
  ```
- **No `OnUpdate` polling**: drive work from events or a self-rescheduling `C_Timer.After` that stops when idle.
- **Missing data -> `nil` + explanation**, never a silent `0` or guessed number.
- **SavedVariables hygiene**: version persistent schemas and run non-destructive forward migrations; never wipe user data on mismatch.
- Keep global namespace clean (`local ADDON, ns = ...`) and validate changes with `node scripts/check-toc.js`, `node scripts/check-lua.js`, and `luacheck` / `busted` where installed.
