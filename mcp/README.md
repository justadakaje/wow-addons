# wow-api-mcp-server

An MCP server that answers WoW: Forever API questions from the **live client**
rather than from memory or the wiki.

## Why

Forever (1.60.1) has no public API reference. Wiki data, model training data and
every addon author's habits predate it — and it is not a small drift:

- `GetItemInfo`, `GetSpellInfo`, `UnitAura`, `QueryAuctionItems`,
  `GetContainerItemInfo`, `GetAddOnMetadata`, `IsAddOnLoaded` and `LoadAddOn`
  are all **gone**. Only the `C_*` forms exist.
- `IsSpellKnown` survives as a global while `GetSpellInfo` does not. The split
  is not systematic, so it cannot be reasoned about — only checked.
- Events are documented under a CamelCase name that is **not** the string
  `RegisterEvent` wants (`AddNeighborhoodCharterSignature` fires as
  `ADD_NEIGHBORHOOD_CHARTER_SIGNATURE`).

Recalling a signature from memory is therefore wrong in ways that are hard to
notice. This server removes the guessing.

## Where the data comes from

```
live client → addons/ForeverProbe → SavedVariables → scripts/extract-api.js → reference/api.json
```

`ForeverProbe` loads `Blizzard_APIDocumentation` **and**
`Blizzard_APIDocumentationGenerated` (the framework ships without its data, so
loading only the first yields nothing) and dumps Blizzard's own documentation
tables. Currently **397 systems, 6,577 functions, 1,802 events**, plus **1,738 type
definitions** and **1,886 enums (10,350 members)** with their real numeric
values read from the global `Enum` table.

Every response carries the build it describes, so an answer can never be
silently applied to the wrong client.

## Build

```bash
cd mcp && npm install && npm run build
```

Verify it end to end — this speaks real MCP over stdio and exercises every tool:

```bash
node smoke.mjs
```

## Configure

Claude Code:

```bash
claude mcp add wow-api -- node D:/Code/GitHub/wow-addons/mcp/dist/index.js
```

Claude Desktop (`claude_desktop_config.json`):

```json
{
  "mcpServers": {
    "wow-api": {
      "command": "node",
      "args": ["D:/Code/GitHub/wow-addons/mcp/dist/index.js"]
    }
  }
}
```

`reference/api.json` is found relative to the server. Override with the
`WOW_API_JSON` environment variable to point at a different capture.

## Tools

| Tool | Purpose |
| --- | --- |
| `lookup_api` | Verified signature for a function, qualified or bare |
| `search_api` | Substring search over functions, events and systems |
| `get_namespace` | Everything in one namespace, or list all systems |
| `get_event` | Payload **and** the exact `RegisterEvent` string |
| `get_widget_methods` | Methods on a documented widget type |
| `get_enum` | Resolve a non-primitive type, and who uses it |
| `list_deprecated` | Legacy globals verified absent from the client |

All are read-only and take `response_format` (`markdown`, default, or `json`).
`search_api` and `get_namespace` paginate with `limit`/`offset`.

Tool names match the contract already written into `AGENTS.md` and the
`wow-addon-partner` skill rather than the usual `{service}_{action}`
convention, because those callers hardcode them.

### The case that motivated `lookup_api`'s warning

Asking for `GetItemInfo` returns four namespaced matches and *looks* like
confirmation. The global is gone. So a bare lookup whose name is on the
verified-removed list leads with:

> **The global `GetItemInfo` does not exist on this client.** It resolves to
> `nil`; calling it is an immediate error.

Without that, this server would produce exactly the bug it exists to prevent.

## Known gaps

- **118 of 778 referenced types have no definition** — 85% resolve. The
  remainder are opaque handles (`ItemLocation`, `ClubId`, `SpellIdentifier`,
  `TooltipData`) that you obtain from another call rather than construct;
  Blizzard documents no fields for them. `get_enum` says so explicitly and
  lists the functions that produce the type, instead of implying a stale
  capture.
- **`get_widget_methods` covers only the 18 `FrameAPI*` families** Blizzard
  documents. Common frame methods (`SetPoint`, `Show`, `SetScript`) are not in
  the documentation tables at all.
- **There is no deprecation metadata anywhere in Blizzard's data.** On this
  client removal is the norm, so `list_deprecated` reports verified *absence*
  from the live client — which is the honest signal — not a deprecation list.
- **627 `C_*` functions exist but are undocumented** (see
  `reference/undocumented.md`). `lookup_api` says so when a name misses, because
  "not documented" and "not present" are different claims.

## Regenerating after a patch

This describes exactly one build. After any client patch:

1. `/reload` in game so ForeverProbe recaptures, then log out to flush.
2. `node scripts/extract-api.js "<WoW>/WTF/Account/<id>/SavedVariables/ForeverProbe.lua"`
3. `cd mcp && npm run build && node smoke.mjs`

The build string in every response is how you confirm it took.
