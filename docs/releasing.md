# Releasing an addon to CurseForge

Pushing a release tag publishes that one addon. The workflow is
[`.github/workflows/release.yml`](../.github/workflows/release.yml); it runs
[BigWigsMods/packager](https://github.com/BigWigsMods/packager), which reads
`## Interface: 16001` as **WoW: Forever** (CurseForge game version 1.60.1).

## One-time setup (the repository owner, by hand)

1. **Create the project on CurseForge** for each addon. Note its numeric
   **project ID**.
2. **Add the ID to the addon's `.toc`:**
   ```
   ## X-Curse-Project-ID: 123456
   ```
3. **Create a CurseForge API token** in your CurseForge account settings and
   add it to this GitHub repository as the secret **`CF_API_TOKEN`**
   (Settings → Secrets and variables → Actions). Never commit it.

## Each release

1. Bump `## Version:` in the addon's `.toc` and add a `CHANGELOG.md` entry.
2. Merge to `master`.
3. Tag `master` and push the tag:
   ```
   git tag goldfinder-v0.1.0-beta
   git push origin goldfinder-v0.1.0-beta
   ```

| Tag prefix | Addon |
| --- | --- |
| `goldfinder-v` | `addons/GoldFinder` |
| `adventurerplates-v` | `addons/AdventurerPlates` |

- **Use `-`, never `/`** in a tag: the packager puts the tag in the file name.
- A tag containing **`beta`** uploads as Beta; **`alpha`** as Alpha; neither
  as Release.
- The workflow **refuses** a tag whose version does not match the `.toc`
  `## Version:` (the `-beta` suffix aside), and a `.toc` with no
  `X-Curse-Project-ID`.

## What the workflow does

1. Runs the same checks as local development: `check-lua`, `check-toc`.
2. Splits the addon's folder into its own repository with `git subtree split`.
   The packager only packages a directory that has its own `.git`, one addon
   per repository.
3. Adds the repository `LICENSE`, tags the split, and runs the packager, which
   uploads to CurseForge with the addon's `CHANGELOG.md` as the file's
   changelog.

Development-only files are kept out by each addon's `.pkgmeta` and by
`#@do-not-package@` blocks in its `.toc` — e.g. AdventurerPlates' `Probe.lua`.

## Verified before the first real release (2026-09-28)

The packager was dry-run locally (`-d -z`, no upload) on both addons: it
detected **version-forever, game version 1.60.1**, used the manual changelog,
and produced exactly the same file list as `scripts/package-addon.ps1`
(GoldFinder plus its new `CHANGELOG.md`); AdventurerPlates shipped without
`Probe.lua` and without its `.toc` line. `git subtree split` on the real
repository produced GoldFinder's 10 commits with the addon at the root.

**Not yet verified:** an actual upload. The first tag push is that test.

`scripts/package-addon.ps1` still builds a local zip for hand-testing (the
build sent to a second player, for example).
