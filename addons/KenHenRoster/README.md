# KenHenRoster

Multi-client World of Warcraft character roster metadata exporter and chroma-key portrait studio built for **WoW: Forever** (`1.60.1`, Interface `16001`), **Retail** (`120105`), and **Classic Era / TBC Anniversary** (`11508`, `20506`) — companion addon for **[KenHen.Win Roster Grid Studio](https://kenhen.win)**.

## Features

- **Automatic Alt Roster Capture (`KenHenRosterDB`):** Listens to `PLAYER_LOGIN`, `PLAYER_ENTERING_WORLD`, `PLAYER_LEVEL_UP`, and `PLAYER_GUILD_UPDATE` to record character name, **WoW: Forever surname** (via `UnitFullName("player")` while guarding `GetNormalizedRealmName()`), level, faction, race, class, spec, realm, and guild.
- **One-Command Compact Export (`/khr`, `/kenhenroster`):** Opens `KenHenRosterExportFrame` with a pre-highlighted copy-paste string:
  - `KHR1:<base64>` (native `C_EncodingUtil.SerializeJSON` -> Deflate -> Base64 when supported)
  - `KHR1J:<base64>` (uncompressed Base64 JSON fallback)
  - Raw JSON button (`Show Raw JSON`)
  - Or upload `WTF/Account/<ACCOUNT>/SavedVariables/KenHenRoster.lua` directly in [KenHen.Win](https://kenhen.win).
- **Chroma-Key Portrait Studio (`/khr studio` or `/khr chroma`):** Full-screen `PlayerModel` booth with **Green `#00b140`** and **Blue `#0047bb`** backdrops matching the **KenHen.Win Narcissus Chroma-Key Cutter** — drag left-mouse to rotate (`yaw`) and mouse-wheel to zoom.

## Usage

1. Install or symlink `addons/KenHenRoster` into your WoW `Interface\AddOns\KenHenRoster` folder (`scripts/link-addons.ps1`).
2. Log briefly into each alt you want included in your roster.
3. Run `/khr` to copy your `KHR1:` / JSON export string (or click **Chroma Studio** / run `/khr studio` for chroma-key screenshots).
4. Paste into **Import / Addon / Sample** on **[kenhen.win](https://kenhen.win)**.

## Development & Tests

- SavedVariables: `KenHenRosterDB`
- Unit specs in `tests/kenhen_roster_spec.lua` run via `scripts/run-tests.ps1` (`luacheck` + `busted`).
