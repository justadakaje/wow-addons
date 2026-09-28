**Adventurer Plates** gives your character a card you can share: a live 3D portrait, your playstyle, the hours you usually play, and a short motto. Ask another player for theirs and it opens on your screen. It is built for **finding people who play like you** — out of character, not roleplay.

## What's on a card

- **Portrait** — your character's 3D model, drawn live
- **Name, realm, level, race and class**, plus your **title** and **guild** if you have them
- **Playstyle & Focus** — up to six tags from a list of 14, such as Dungeon Delver, Casual Leveling, Gold Making, Mentor, Explorer or Professions & Crafting, shown as coloured badges
- **Active Hours** — the hours you are usually online, weekdays and weekends separately, in server time
- **Motto** — up to 140 characters

## How to use it

| Command | What it does |
| --- | --- |
| `/advplate` | list of commands (also `/aplate`) |
| `/advplate show` | show or hide your card |
| `/advplate edit` | edit your card |
| `/advplate ask Name Surname` | ask someone for their card — or target them and type `/advplate ask` |
| `/advplate privacy` | who may see your card: `everyone`, `guild`, `friends` or `nobody` |

On realms with surnames, a name needs its surname: `/advplate ask Erica Cartwoman`, not `/advplate ask Erica`. Targeting the player fills it in for you.

## Privacy

- **Nothing is sent unless someone asks**, and only to that one person. There is no broadcast and no hidden channel.
- **You decide who can see your card.** The default is **Guild & Friends**. Your own client checks the requester, so nobody can claim to be your friend.
- **Players on your ignore list get no reply at all** — not even a refusal, which would tell them you are online.
- **A card only opens if you asked for it.** Anything else is stored quietly and never pops up.
- Everything that arrives is cleaned before it is shown: no colour codes, links, textures or oversized fields.

## Tested, and not yet tested

Tested on **WoW: Forever build 70009**, including a two-player test of sharing: asking by target and by name, correct portraits both ways, the "everyone" and "nobody" privacy settings, the ignore list, and special characters in mottos.

**Not yet seen working:**

- **Guild and title display.** The test characters have no guild and no titles, so only the "none" case has been seen.
- **The "guild" and "friends" privacy settings.**
- When someone asks for your card while you are out of sight and not grouped, their portrait area shows a sentence explaining why there is no model, rather than a picture.

Please report anything odd — especially with guilds or titles — in the comments.

## Compatibility

- **WoW: Forever only** (Interface 16001).
- It does not read or change any other addon's data.

## Credits and licence

MIT licensed. Sharing uses [Chomp](https://github.com/wow-rp-addons/Chomp) (ISC) with LibStub, CallbackHandler-1.0 and ChatThrottleLib, all included. The source and the issue tracker are on GitHub — see the project links.

Inspired by the Adventurer Plate in Final Fantasy XIV. Not affiliated with Blizzard Entertainment or Square Enix.
