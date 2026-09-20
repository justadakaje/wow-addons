# wow-addons

Personal World of Warcraft addon development — QoL/interface improvements, plus an in-progress Auction House gold-opportunity tool.

## Layout

This is a monorepo: one folder per addon under `addons/`, each self-contained and independently installable.

```
wow-addons/
  addons/
    <AddonName>/
      <AddonName>.toc        # and/or <AddonName>_<Client>.toc for multi-client addons
      *.lua
      Knowledge/              # curated, sourced data only — see AGENTS.md
      tests/                  # optional, per-addon
  scripts/
    link-addons.ps1           # symlinks addons/* into your local WoW install(s)
  .github/workflows/
    validate.yml               # structure checks on push/PR
  AGENTS.md                    # working rules for any AI agent (or human) touching this repo
  HANDOFF.md                   # research/status log from planning conversations — read this first
```

## Local dev setup

1. Clone the repo (already done — this is `D:\Code\GitHub\wow-addons`).
2. Run `scripts/link-addons.ps1 -WowPath "<path to your Interface\AddOns folder>"` to symlink every addon in `addons/` into your live WoW install. Symlinks mean you edit in the repo and test in-game with no copy step, and removing an addon from the game is just deleting the symlink — nothing destructive.
3. For addons that use the WoW API, this repo assumes the `wow-api` MCP server is attached (package `wow-api-mcp-server`, source in `mcp/`) (Claude Desktop or Claude Code) so API calls are verified against real signatures rather than guessed. See `AGENTS.md`.

## Addons

| Addon | Client(s) | Status |
| --- | --- | --- |
| AddonSmokeTest | Classic Era (Interface 20506) | Proof-of-life, working |

## Related repos

- [GoldCopilot](https://github.com/stryker-max/GoldCopilot) (fork target, upstream: `stryker-max/GoldCopilot`) — MoP Classic port planned. Not yet forked. Kept as its own fork rather than folded into this monorepo, to preserve upstream history and MIT attribution and to allow pulling upstream fixes.
