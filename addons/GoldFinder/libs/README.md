# Vendored libraries

Third-party code, embedded so the addon works on install.

**Nothing in this folder is ours.** Do not edit these files. To update one,
replace it wholesale from its upstream and record the new version below.

| Library | Version | License | Upstream |
| --- | --- | --- | --- |
| LibAHTab | LibStub minor 4, commit `24090a7` (2025-04-08) | MIT | [TheMouseNest/LibAHTab](https://github.com/TheMouseNest/LibAHTab) |
| LibStub | 2 | Public Domain | [wowace.com/wiki/LibStub](https://www.wowace.com/wiki/LibStub) |

`LibAHTab/LICENSE` travels with the code it covers. LibStub carries its
public-domain notice in the file header.

## Why LibAHTab

It is the collision strategy. Adding an auction house tab with the standard
`PanelTemplates_SetNumTabs` path taints the player's bags (per its README), and
two addons doing it independently draw tabs on top of each other. LibAHTab is
a LibStub singleton: every addon that embeds it shares one tab row, so
GoldFinder's tab lines up beside theirs instead of colliding.

LibAHTab is a separate MIT-licensed project. It is **not** Auctionator, whose
license is All Rights Reserved and whose source this repo does not read or use.
