# Confidently Wrong: Four AI Errors a Beta Game Client Caught in Four Hours

*Blog post draft — musingsofmy.today. Narrative source for the episode.*

---

The interesting failure mode of an AI coding assistant is not that it writes
broken code. Broken code announces itself. The interesting failure mode is that
it writes *plausible* code, attached to a confident claim, that is wrong in a
way nothing will surface until much later.

Over roughly four hours I built an addon for **World of Warcraft: Forever** — a
beta client, build 69913, where most legacy Lua APIs have been removed and the
survivors were kept inconsistently. `GetItemInfo`, `GetSpellInfo` and
`UnitAura` all resolve to `nil`. `IsSpellKnown` survives. There is no pattern
to it.

The addon works. That is not the story. The story is that in those four hours
the AI — Claude Code, working against a custom API index — produced **four
confident claims that were false**, and every single one was caught the same
way: by reading a primary source at the exact moment it would have been easiest
not to.

## Error one: the API that was documented as absent, and wasn't

The project's own notes recorded, as established fact, that `Menu.ModifyMenu` —
the modern right-click context-menu API — *had zero occurrences in this
client's surface*. An entire design decision rested on it: use the legacy
dropdown family instead.

It exists. A three-line in-game `type()` check found it immediately.

What makes this worth more than an erratum is *why* it was believed, because
the reason generalises. There were two independent sources of truth, and both
were blind for different structural reasons:

- The **API index** documents the client's **C** API. `Menu` is a FrameXML
  **Lua** table, so searching it correctly returned nothing.
- The **runtime `_G` dump** walks top-level *functions* and `C_*` namespaces.
  `Menu` is a plain non-`C_` global *table*, so its contents were invisible.

Neither source lied. Each answered a narrower question than the one being
asked, and the gap between them had a real API sitting in it. The comfortable
inference — *absent from the index means absent from the client* — is true only
of the C API. Stated without that qualifier it manufactures confident false
negatives, and a false negative here means architecting around a capability you
already have.

The actual situation turned out to be *inverted* from the assumption. The
modern menu API is live. It is the legacy path that is gutted —
`UnitPopupButtons` is `nil`, so the approach the notes recommended could not
have worked at all.

## Error two: the migration that would have destroyed the data it was upgrading

The addon stores data in SavedVariables under a schema version. The existing
initialisation code did this on a version mismatch:

```lua
if db.schema ~= nil and db.schema ~= ns.DB_SCHEMA then
    ns.Warn("stored data is schema %s, this build expects %s -- starting fresh.")
    AdventurerPlatesDB = {}
end
```

That reads as reasonable defensive programming. It is a data-loss bug with a
delay fuse.

Earlier that same session, a capability probe had run in-game for the first
time and written its results into that table — measurements that cost a live
client session to obtain. The very next change was to add a feature, which
meant bumping `DB_SCHEMA` from 1 to 2. On the next reload, the upgrade path
would have deleted the results of the upgrade's own justification.

This is the same shape as an incident already in the project's notes: an
earlier addon lost a 98-minute session to a crash handler sitting in
`PLAYER_LOGOUT`, where the act of saving destroyed the data being saved.

The replacement is a forward-walking migration table keyed by source schema. On
an unrecognised version it **refuses and disables features** rather than wiping,
because *"I do not understand this data"* has never been a good reason to
delete it.

## Error three: the separator that was textbook-correct and broke every message

The addon shares data between players over the game's addon-message channel,
using the Chomp messaging library. Messages need a field separator. I used
**ASCII 31** — the unit separator, the character that exists in the standard
for precisely this purpose, and invisible so it cannot collide with display
text.

Then I opened Chomp's source instead of assuming:

```lua
if text:find("[%z\001-\009\011-\031\127]") then
    return false, "ASCII_CONTROL"
```

ASCII 31 is inside that rejected range. Not a dropped message — a thrown Lua
error on *every single send*. The feature would have been completely
non-functional, and the failure would have looked like a transport problem
rather than a one-character mistake.

The replacement is `~`, which satisfies four constraints at once: outside the
Base64 alphabet so it cannot occur inside a payload, not `|` so it is not a WoW
text escape, no special meaning in a Lua pattern, and illegal in a character or
realm name. The textbook answer failed the only constraint I had not thought to
check.

## Error four: the rescue plan that would have overwritten the real data with an empty table

Late in the session the layout changed direction and two addon folders needed
renaming, which meant the SavedVariables keys changed too. I flagged a
data-migration hazard, correctly, and set out to write a migration that would
rescue the newer dataset.

Before writing it, I read both files. They said the opposite of what the screen
said:

```
AdventurerPlatesDB      6 tags, hours, full motto, updated 1789952629
AdventurerPlatesCardDB  0 tags, empty motto,       updated 0
```

The data visible on screen — tags, hours, a long motto, a recent "last edited"
timestamp — **had never been written to disk**. WoW flushes SavedVariables from
memory at `/reload` or logout and *then* loads addons, so the file always
reflects the state as of the previous reload. A screenshot shows memory. The
file shows the last save. They are routinely different, and the difference is
invisible unless you look.

The migration I was about to write would have faithfully rescued the empty
table over the real one. Reading the files first turned a risky refactor into a
no-op: the canonical addon kept its original name, so it kept its original
variable and inherited the full dataset with **zero migration code**.

## The pattern

Four errors. Look at what did *not* catch them.

Not reasoning. Every one of these was *arrived at* by reasoning, and the
reasoning was sound given its inputs. ASCII 31 *is* the correct separator in
general. Wiping on schema mismatch *is* a defensible stance in isolation. The
rename plan *was* right about there being a hazard.

Not caution in general, either. I was being careful the whole time. Being
careful is a disposition; it does not tell you *which artifact to open*.

What caught all four was the same act in four costumes: **reading the specific
primary source at the moment the answer felt already known.** Chomp's
`StringManip.lua`. The old `InitDB` function. The two `.lua` files sitting in
the WTF folder. A `type()` check in a running client.

> The expensive artifact in this kind of work is not the code. It is the
> evidence about what the system actually does.

That belief shaped how the work got recorded. The commit messages say what was
*wrong* and why it was believed, not just what changed. A future session
reading `git log` learns that a particular test failure was a confounded
experiment rather than a real client limitation — and so does not spend an
afternoon designing around a constraint that never existed.

## What this says about AI pair-programming

The lazy conclusions are both wrong. "The AI was wrong four times, so don't
trust it" ignores that it also shipped a working addon with a non-destructive
migration system, a sanitising trust boundary on untrusted network input, and
three reusable build tools in the same four hours. "It caught its own mistakes,
so it's fine" ignores that it caught them *only where a primary source was
available and someone insisted on opening it*.

The useful conclusion is narrower and more actionable. An AI's confidence is
calibrated to how *plausible* a claim is, not to how *verified* it is, and
those two things come apart hardest exactly where documentation is incomplete —
beta software, undocumented APIs, third-party libraries, anything where the map
and the territory have drifted.

Which is, inconveniently, most of the work worth doing.

So the discipline that mattered was not "check the AI's work." It was
**structural**: build the verification tool first, wire it into the loop, and
treat any claim that cannot be traced to a primary source as provisional no
matter how confidently it is stated — including, especially, the ones already
written down as established fact.
