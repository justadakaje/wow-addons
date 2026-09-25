## EPISODE BRIEF

You are producing an episode of **Runtime Reality**, a technical podcast for
senior platform and software engineers. Do not explain what an API is, what Lua is, or what version control does.

### Subject

Four and a half hours of AI-assisted development building a World of Warcraft
addon on a beta game client, during which the AI made **four confident,
plausible, completely wrong claims** — each caught not by better reasoning but
by reading a primary source.

### Thesis — state it, then earn it

> An AI's confidence tracks how **plausible** a claim is, not how **verified**
> it is. Those two things come apart hardest exactly where documentation is
> incomplete — beta software, undocumented APIs, third-party libraries — which
> is most of the work worth doing.

The episode is **not** a build log. Do not narrate features in sequence. The addon is evidence for an argument about verification.

### Required structure

1. **Cold open (1–2 min).** The `Menu.ModifyMenu` moment. A documented claim,
   recorded in the project's own notes as established fact, proven false by a
   three-line check. Land the hook before any framing.
2. **Setup (4–5 min).** The client: WoW: Forever build 69913, most legacy Lua
   APIs removed, survivors kept inconsistently. Why this is a stress test for
   AI-assisted work — the training data describes a game that no longer exists.
3. **The four errors (32–38 min, roughly equal time).**
   - `Menu.ModifyMenu` — two sources of truth, both structurally blind
   - The migration that would have destroyed the data it was upgrading
   - ASCII 31 — the textbook-correct answer that broke every message
   - The rename plan that would have rescued an empty table over a full one
4. **The turn (6–8 min).** What did *not* catch these. Not reasoning — every
   error was arrived at by sound reasoning from its inputs. Not general
   caution — being careful is a disposition, it does not tell you which file to
   open. What caught all four was the same act: reading the specific primary
   source at the moment the answer felt already known.
5. **Implications (8–10 min).** Both lazy conclusions are wrong. "Don't trust
   it" ignores a working addon, a non-destructive migration system, a
   sanitising trust boundary and three build tools. "It
   self-corrected, so it's fine" ignores that it only self-corrected where a
   primary source existed and someone insisted on opening it.
6. **Close (2 min).** The discipline is structural, not attitudinal: build the
   verification tool first, wire it into the loop, treat any claim without a
   traceable source as provisional — *including the ones already written down
   as established fact.*

### Target length

**55–65 minutes.** The sources include the probe source, the migration code,
the transport layer and the project handoff — enough to sustain that on
substance.

Fill time with **depth, never scope**. Two hosts in genuine disagreement: one
states the belief as it was actually held, the other presses on why it looked
right, before the evidence lands. Do not summarise where you could dissect.

Work each error as five beats — the belief, why it was reasonable, what the
evidence actually said, what shipping it would have cost, and what caught it.
Spend real time on the cost: what would have reached players uncaught. Quote
the code; the migration table, the separator comment and the probe's tiers are
all in the sources.

Never invent a figure, never restate a point, never enter the out-of-scope list.

### Hard accuracy rules

- **Every figure must come from the fact sheet.** If a number is not in the
  sources, say so out loud rather than producing one.
- Do not round. It is **392 bytes**, not "about 400". It is **ASCII 31**, not
  "a control character in the thirties". It is **build 69913**.
- The fact sheet's **"Things that are NOT true"** section is a blocklist. Not
  even as a passing aside.
- Do not claim the addon was published to CurseForge. It was not.
- Do not call it a roleplay addon. It is out-of-character social matchmaking.
- The tool was **Claude Code**. Not Cursor, not Copilot, not ChatGPT.
- The MCP server **verified** API calls. It did not "accelerate development."

### Tone

Analytical and specific: lead with verified data, puncture the comfortable
assumption, resist the moral. Dry humour where earned — the ASCII 31 story is
funny because the textbook answer is the one that fails.

Avoid hype and AI-doom alike. The claim is narrow and technical.

### Explicitly out of scope

The feature list, UI layout and frame strata, packaging and licensing,
anything about publishing or CurseForge. These happened; they are not this
episode.

### Honesty requirement

Near the close, state plainly that **roughly a third of the addon's fields were
never exercised** — sharing untested with a second
player, guild and title display never rendering real data. An episode about verification
that overstates its own completeness would be self-refuting.
