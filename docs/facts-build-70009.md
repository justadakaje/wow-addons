# Fact Sheet — GoldFinder and sharing session, 2026-09-27

**Single source of truth for every number from this session.** Same rules as
[`facts-build-69913.md`](facts-build-69913.md): every figure below was measured
in-client or read from a file, and says how. Anything not measured is in
"Still unverified", not here.

> Everything in the 69913 sheet that is **not** contradicted here is still the
> best record we have; nothing below re-measured it.

---

## Client under test

| Fact | Value |
| --- | --- |
| Game | World of Warcraft: Forever (beta) |
| Version | 1.60.1 |
| Build | **70009** (was 69913 on 2026-09-21; the patch landed between sessions) |
| Interface | **16001** — unchanged; measured by ForeverProbe on 70009 |
| `WOW_PROJECT_ID` | 1 (equals `WOW_PROJECT_MAINLINE`) |
| Test characters | Aeldorath Zephrai (Ken), Hunter, level 10 · Erica Cartwoman (Ava), Warrior, level 10 — both Windshaper Skyborne |
| Realm | ClassicBetaPvE2 |
| Guild | none (either character) |
| Titles known | 0 (Aeldorath: "No titles earned on this character yet") |

## What 70009 changed in the API

ForeverProbe dump 69913 (`.bak`, 2026-09-21) against 70009 (2026-09-27):

```
names         69913: 10801    70009: 10840
removed  3    C_GameRules.SelectClassicExperiencePreset
              C_GameRules.SelectModernExperiencePreset
              MasterLooterPlayerFrame_OnClick
added   42    mostly gamepad / raid-frame UI, a new C_Flyout namespace,
              C_GameRules.Get/SetForeverExperiencePreset,
              C_NameUtil.ReplaceSurnameSeparatorWithLinkSeparator
C_AuctionHouse   unchanged
```

The parser total (10840) matches ForeverProbe's own count on 70009: 5913
globals + 4927 `C_` functions.

**A name diff cannot see a changed return value.** The change that mattered
most tonight (below) does not appear in it.

## The name change — the session's spine

`UnitFullName("player")`, measured in-client:

| build | returns |
| --- | --- |
| 69913 | `"Aeldorath Zephrai"`, `"ClassicBetaPvE2"` |
| 70009 | `"Aeldorath"`, `"Zephrai"` — **the surname sits in the realm slot** |

Same measurement, 70009:

```
UnitName("player")                  "Aeldorath"
GetNormalizedRealmName()            "ClassicBetaPvE2"
C_PlayerInfo.ShouldDisplaySurname() true
```

Consequences found live, all fixed in AdventurerPlates 0.3.1 / 0.3.2:

1. **The saved card went blank.** The plate key became `Aeldorath-Zephrai`;
   the card was stored under `Aeldorath Zephrai-ClassicBetaPvE2`. No data was
   lost — the fix rebuilds the old key.
2. **Ask by target or first name failed:** `Chomp.NameMergedRealm: expected a
   full name`. Chomp detects regional unique names and requires the surname in
   a whisper target; `UnitName("target")` returns the first name only.
3. **A received card never opened.** Request stored as typed
   (`erica cartwoman`), reply from `Erica Cartwoman`: the case mismatch made it
   look unsolicited, which is never shown.
4. **A remote card showed the viewer's own model.** `isRemote and
   VisibleUnitFor(...) or "player"` falls through to `"player"` when the other
   player is not visible. **Predates 70009** — never seen before because
   sharing had never had a second player.

## Other names, measured on 70009

| Call / context | Result |
| --- | --- |
| `C_FriendList.IsIgnored("Erica Cartwoman")` | `true` |
| `C_FriendList.IsIgnored("Erica")` | **`false`** |
| `C_FriendList.IsOnIgnoredList("Erica Cartwoman")` | `true` |
| `C_FriendList.GetIgnoreName(1)` | `"Erica Cartwoman"` — stored as the full name |
| Right-click, party member's target frame | menu tag **`MENU_UNIT_PARTY`**, `unit = "target"`, `name = "Erica"` (first name only) |
| Grouped player, out of sight | model still renders via `party1` |

## Sharing — first two-player test

Aeldorath Zephrai and Erica Cartwoman, 23:00–23:45 local, AdventurerPlates
0.3.2 on both clients.

| # | Test | Result |
| --- | --- | --- |
| 1 | `/advplate ask` with target | card opens, correct model |
| 2 | First name only | refused with "On this realm a name needs its surname too" |
| 3 | Lowercase full name | card opens |
| 4 | Out of sight, **not grouped** | portrait fallback sentence, no model — **first time on screen** |
| 5 | Ava views Aeldorath's card | correct Hunter model |
| 6 | Motto containing `~` | arrived intact — **first round trip of the separator fix** |
| — | Privacy "nobody" | "Aeldorath Zephrai is not sharing their plate." |
| 7 | Requester on the ignore list | "no answer from aeldorath zephrai" only — no card, no refusal |

## Auction house

**Auctionator's AH tabs load on 70009** — Shopping, Selling, Cancelling,
Auctionator, via LibAHTab. On 69913 its AH layer did not load. Cause not
investigated: Auctionator is All Rights Reserved and its source is not read.

Auctionator "Full Scan (summary mode)", recorded by GoldFinder's event counter:

```
AUCTION_HOUSE_BROWSE_RESULTS_UPDATED    1
AUCTION_HOUSE_BROWSE_RESULTS_ADDED      9
REPLICATE_ITEM_LIST_UPDATE              0
```

| Fact | Value |
| --- | --- |
| Browse results per Full Scan | 4460 results covering **2054** distinct items; Auctionator reported 2059 items |
| What a browse "result" is | one item *variant* (item + level + suffix) — not a repeat |
| Re-delivery | each click in Auctionator's Selling tab fired `_UPDATED`, and `GetBrowseResults()` returned the previous Full Scan |
| Commodity price units | per unit: Raptor Egg browse `minPrice` 2s = Buy view "Unit Price 2s 0c" |
| `AuctionHouseFrame` | exists; `IsMovable()` false; `#Tabs` 3 (Buy, Sell, Auctions); managed by `UIPanelWindows` |
| `SelectBrowseResult` | exists; opens Blizzard's commodity Buy view for a `BrowseResultInfo`-shaped table |
| Purchase from that view | goes through — 1 Raptor Egg, no action blocked |
| Auctionator Current Prices rows | cannot be selected on 70009, **with GoldFinder disabled too** |
| `GameTooltip` | `SetOwner`, `AddLine`, `AddDoubleLine`, `Show`, `Hide` all functions |

## GoldFinder

| Fact | Value |
| --- | --- |
| Version | 0.1.0 (local; not pushed, not published) |
| Package | `dist/GoldFinder-0.1.0.zip`, 20.7 KB |
| Tab library | LibAHTab, MIT, vendored at `24090a7` |
| Cost (AddOn List, read at v0.0.4) | 0.01% average CPU, 388 KB |
| First deal table | 21 underpriced materials after four scans on separate occasions |

## Licences, checked

- **Auctionator: All Rights Reserved** (plusmouse, borjamacare). No public
  repository. Its bundled `AGENTS.md` states the authors do not permit its use
  as a basis or reference.
- **LibAHTab: MIT** (`TheMouseNest/LibAHTab`).

## The PC

A 16 GB machine hit its **commit limit** (24.5 of 32.8 GB committed with WoW and
Streamlabs already gone) and both WoW ("Not enough memory") and Streamlabs
crashed together. The local MKV recording survived intact: 68 min 19 s.

## Things that are NOT true

- ❌ "We forked Auctionator." **Ruled out** — All Rights Reserved. GoldFinder is
  standalone and never read its source.
- ❌ "I tried to fork it." It was **planned**; the licence check stopped it
  before any fork.
- ❌ "GoldFinder is on GitHub." **Local only** at session end.
- ❌ "The result count was inflated by repeats." Wrong diagnosis at the time;
  de-duplicating moved it by 5. Results are item variants.
- ❌ "0.3.1 has no code changes." It fixes the blank card.
- ❌ "The portrait falls back to a class-crest composition." It was **decided,
  never built**: the fallback is a sentence only.
- ❌ "GoldFinder's deals are verified correct." Current commodity prices are;
  "typical" on a thin market is not.

## Still unverified at session end

- **Guild display** — neither character is in a guild.
- **Title display** — 0 titles known.
- **Class-crest fallback** — not built.
- **GoldFinder "typical" on a thin market** — median of as few as 3 scans;
  Raptor Egg 9s 80 typical vs 2s now.
- **Non-commodity materials** — per unit or per stack.
- **`GetReplicateItemInfo` index base** — 0 or 1; GoldFinder reads 1..n-1.
- **Menu tags other than `MENU_UNIT_PARTY`** — e.g. a player not in the group.
- **Cross-realm names** — whether a second `UnitFullName` value can be a realm.

Sharing — the largest item in the 69913 sheet's list — is **no longer here**.
