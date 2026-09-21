# Vendored libraries

Third-party code, embedded so the addon works on install rather than depending
on the user having found four separate downloads first.

**Nothing in this folder is ours.** Do not edit these files. To update one,
replace it wholesale from its upstream and record the new version below.

| Library | Version | License | Upstream |
| --- | --- | --- | --- |
| Chomp | 37 | ISC | [wow-rp-addons/Chomp](https://github.com/wow-rp-addons/Chomp) |
| LibStub | 2 | Public Domain | [wowace.com/wiki/LibStub](https://www.wowace.com/wiki/LibStub) |
| CallbackHandler-1.0 | 8 | BSD-3-Clause (Ace3) | [CurseForge: callbackhandler](https://www.curseforge.com/wow/addons/callbackhandler) |
| ChatThrottleLib | 32 | Public Domain | [CurseForge: chatthrottlelib](https://www.curseforge.com/wow/addons/chatthrottlelib) |

License texts travel with the code they cover: `Chomp/LICENSE.txt` and
`CallbackHandler-1.0/LICENSE.txt`. LibStub and ChatThrottleLib carry their
public-domain notices in the file header, as their authors wrote them.

## Why all four, when the decision was "use Chomp"

Chomp's own `Libs/` folder is **empty in its git repository** — it contains
only a `.gitkeep`. The three dependencies are fetched at package time by
CurseForge's packager, driven by Chomp's `.pkgmeta`:

```yaml
externals:
  Libs/CallbackHandler-1.0: https://repos.curseforge.com/wow/callbackhandler/trunk/CallbackHandler-1.0
  Libs/ChatThrottleLib:     https://repos.curseforge.com/wow/chatthrottlelib/trunk
  Libs/LibStub:             https://repos.curseforge.com/wow/libstub/trunk
```

So a plain `git clone` of Chomp is **not runnable**. All three are hard
requirements, not optional despite the `## OptionalDeps` line in Chomp's own
`.toc`:

- `Internal.lua:24` — `LibStub:NewLibrary("Chomp", VERSION)`
- `Internal.lua:35` — `LibStub:GetLibrary("CallbackHandler-1.0"):New(Internal)`
- `Public.lua:59`   — `ChatThrottleLib:SendAddonMessage(...)`

Miss any and Chomp errors on load.

## Provenance

Chomp came from a shallow clone of its GitHub repository.

The other three were taken from the **Ace3** installation on the development
machine, because there is no `svn` client here to check out the CurseForge
trunks that Chomp's `.pkgmeta` names. They are real shipped versions rather
than reconstructions, and each is its own upstream project that Ace3 also
embeds — which is exactly how Chomp consumes them.

If you have `svn`, checking the three out from the URLs above is the more
direct source and worth preferring on the next update.

## Duplicate loading is expected and safe

A user with Ace3, or with any other addon embedding these, will have two
copies on disk. All four libraries are built for this: LibStub and
CallbackHandler version-check through LibStub and the newer wins, and
ChatThrottleLib checks `_G.ChatThrottleLib.version` and returns early if a
newer copy already loaded. That is the normal state of affairs for a WoW
library and needs no handling from us.
