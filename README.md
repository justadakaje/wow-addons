# wow-addons

Repo for my World of Warcraft AddOns work — also the code behind the
"WoW AddOns Development via Claude" YouTube series.

See `AGENTS.md` for environment facts, verified research, and current goals before
picking up any work here (human or agent).

## Layout

- `addons/AddonSmokeTest/` — minimal addon confirming the dev/link/reload loop works.
- `addons/GoldFinder/` — in-progress: Auction House tab surfacing raw-material flips
  and profitable known-recipe crafts, built on top of Auctionator.
- `scripts/link-addons.ps1` — symlinks `addons/*` into your local WoW AddOns folder.

## Local dev loop

```powershell
.\scripts\link-addons.ps1
```

Then `/reload` in-game after editing any file under `addons/`.
