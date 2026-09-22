# Content pack — Adventurer Plates session

One development session, five published artifacts. This is the release order,
what blocks what, and the URLs each piece needs before it can go out.

Session recorded 2026-09-20 / 09-21. Pack assembled 2026-09-22.

## The pieces

| # | Artifact | Where | Who publishes |
| --- | --- | --- | --- |
| 1 | Source, tooling, findings | GitHub `master` | me |
| 2 | VOD Part 1 (`02:03:23`) | YouTube | you |
| 3 | VOD Part 2 (`02:53:31`) | YouTube | you |
| 4 | Runtime Reality episode | Apple + Spotify | you |
| 5 | Blog post — *Confidently Wrong* | musingsofmy.today `2234` | me |
| 6 | Blog post — *Absent from the Docs* | musingsofmy.today `2235` | me |

## The circular-reference problem

Everything wants to link to everything else. The blog posts embed the VODs and
the podcast; the VOD descriptions link the blog; the show notes link both.
Nothing can be first if every piece must ship complete.

**Resolution: publish leaves first, hub last, then backfill the leaves.**

```
            GitHub  ──────────────┐
              │                   │
              ▼                   │
        VOD 1 + VOD 2 ────────┐   │   (descriptions: blog link TBD)
              │               │   │
              ▼               │   │
        Podcast episode ──┐   │   │   (show notes: blog link TBD)
              │           │   │   │
              ▼           ▼   ▼   ▼
        Blog posts ── embed and link all of the above
              │
              ▼
        BACKFILL: add blog URLs to VOD descriptions and show notes
```

GitHub goes first because it is the only artifact with **no inbound
dependencies** — nothing it links to needs to exist yet, and everything else
links to it.

---

## Phase 0 — GitHub

**Blocks:** everything.

- [x] CI green on PR #2 (`validate` passes: 4 `.toc`, 20 Lua files)
- [ ] Merge PR #2 → `master`

Merging matters for link durability: `.../blob/master/...` survives, a branch
URL does not once the branch is deleted.

**Produces:**

```
https://github.com/justadakaje/wow-addons
https://github.com/justadakaje/wow-addons/tree/master/addons/AdventurerPlates
https://github.com/justadakaje/wow-addons/blob/master/docs/facts-build-69913.md
```

## Phase 1 — YouTube VODs

**Blocked by:** Phase 0 (descriptions cite the repo).
**Blocks:** podcast show notes, blog embeds.

- [x] Part 1 — **live** at `https://youtu.be/guSsG1I_XX0`, title and metadata verified
- [ ] Part 2 — not yet uploaded
- [ ] Both set public, chapters applied, descriptions from the corrected metadata

**Leave the blog link as a placeholder.** It does not exist yet and is
backfilled in Phase 4.

**Do not upload** `2026-09-21_00-44-14.mkv` — corrupt, `ffprobe` cannot read it.

**Produces:** two `youtu.be` URLs.

## Phase 2 — Runtime Reality episode

**Blocked by:** Phase 1 (show notes cite the VODs).
**Blocks:** blog embeds — the posts carry a Spotify player.

- [ ] Generate from `F:\videos\publish\sources\` using `02-STEERING-BRIEF.md`
- [ ] Run the accuracy checklist against `01-FACT-SHEET.md`
- [ ] Optional cold open — see `docs/media/cold-open.md`
- [ ] Publish; capture Apple and Spotify episode URLs

Episode numbering follows the channel convention `S26.E{MMDD}`.

**Produces:** Apple Podcasts URL, Spotify episode URL, Spotify embed ID.

## Phase 3 — Blog posts

**Blocked by:** Phases 0–2. This is the hub; it links everything.

Publish **2235 first**, then **2234**, then edit 2235 to add the back-link.
Two passes, because neither has a permalink until it is published.

### Styling gap to close first

Both drafts are currently plain prose. The house style — read from
`The Illusion of Containment` (post 2194) — carries considerably more:

| Element | In drafts | Needed |
| --- | --- | --- |
| `Executive Summary:` lead | ✗ | ✓ |
| Podcast callout box (cyan left border) | ✗ | ✓ |
| Spotify episode embed | ✗ | ✓ |
| YouTube embed mid-body | ✗ | ✓ |
| Inline images as section breaks (2–3) | ✗ | ✓ |
| Button-list checklist | ✗ | ✓ (post 1) |
| `Sources Cited:` list | ✗ | ✓ |
| Featured image + alt text | ✓ | done |
| Categories + tags | ✓ | done |
| SEO description | ✓ | done |

**Inline images still to produce.** Two per post. Post 2 is a reference
article, so real screenshots from the session — the rendered card, the probe
output in chat — will serve it better than generated art.

## Phase 4 — Backfill

**Blocked by:** Phase 3.

- [ ] Add both blog URLs to VOD Part 1 and Part 2 descriptions
- [ ] Add both blog URLs to the podcast show notes
- [ ] Cross-link the two blog posts to each other

---

## URL ledger

Fill these in as each phase completes. Everything downstream reads from here.

```
GitHub repo          https://github.com/justadakaje/wow-addons
GitHub PR            https://github.com/justadakaje/wow-addons/pull/2

VOD Part 1           https://youtu.be/guSsG1I_XX0        LIVE 2026-09-22
VOD Part 2           TBD

Podcast (Apple)      TBD
Podcast (Spotify)    TBD
Spotify embed ID     TBD

Blog - Confidently Wrong        TBD   (draft id 2234)
Blog - Absent from the Docs     TBD   (draft id 2235)
```

## Division of labour

**I can do:** merge the PR, restructure and publish both blog posts, apply
embeds once URLs exist, set featured images, alt text, tags, categories, SEO
fields, and the Phase 4 blog cross-links.

**You do:** YouTube uploads and descriptions, podcast generation and
distribution, and the Phase 4 backfill into YouTube and podcast show notes —
no connector here reaches those.

**Binary transfer is the one hard wall.** The WordPress connector accepts
base64 only and tool output caps at 30,000 characters, so a full-quality image
cannot pass through me. Upload images in WP admin; I wire up everything else.

## Honesty constraint

Every piece in this pack states that roughly a third of the addon is
unverified — sharing never tested with a second player, guild and title display
never rendered real data. The blog post argues that verification beats
confident assertion. It would be self-refuting to overstate the completeness of
the thing it describes.

Keep that caveat in all five artifacts.
