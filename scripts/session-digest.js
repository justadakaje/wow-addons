#!/usr/bin/env node
//
// session-digest.js -- extract the checkable record for a commit range.
//
// Companion to docs/facts-build-69913.md, not a replacement for it. That file
// is hand-compiled, is the single source of truth for the 2026-09-20/21
// session, and is better than anything a script produces: it carries judgement
// about which facts matter. What it is not is cheap. Someone assembled it by
// reading the whole session back.
//
// This produces the same SHAPE mechanically, for any range, so the next
// session's fact sheet starts as a filled-in skeleton rather than a blank file.
// Curation still happens by hand. Transcription does not.
//
// No LLM, no network, no dependencies. Same range in, same digest out.
//
//   node scripts/session-digest.js --range 9ae20b1..1a5e613
//   node scripts/session-digest.js --since '2026-09-20 18:00' --branch master
//
// Output: dist/digest-<first>-<last>.json (gitignored), or --out - for stdout.

'use strict';

const { execFileSync } = require('child_process');
const { existsSync, mkdirSync, readFileSync, writeFileSync } = require('fs');
const { basename, join } = require('path');

const RECORD_SECTIONS = [
  // HANDOFF.md / README.md headings whose bodies are lifted verbatim. Verbatim
  // matters: these are the paragraphs the author already wrote carefully, and
  // paraphrasing them is where drift starts.
  'Known gaps',
  'What is verified in game, and what is not',
  'Decisions already made — do not relitigate',
  'Measured, not estimated',
  'Next steps, in order',
  'Two traps found the hard way',
  'Environment facts',
  'This work is being recorded',
];

function arg(name, fallback = null) {
  const i = process.argv.indexOf(`--${name}`);
  return i > -1 && process.argv[i + 1] ? process.argv[i + 1] : fallback;
}

function git(repo, args) {
  return execFileSync('git', ['-C', repo, ...args], {
    encoding: 'utf8',
    maxBuffer: 64 * 1024 * 1024,
  }).trimEnd();
}

function gitOrNull(repo, args) {
  try {
    return git(repo, args);
  } catch {
    return null;
  }
}

// ---------------------------------------------------------------- commits

// ASCII record/unit separators. Not NUL: Node refuses NUL bytes in spawn args,
// and these cannot occur in a git commit message in practice.
const COMMIT_SEP = '\u001e';
const FIELD_SEP = '\u001f';

function commits(repo, range) {
  // Two passes on purpose. Interleaving --name-only with a multi-line %b makes
  // the boundary between body and file list ambiguous, and a parser that is
  // "usually right" about the record is worse than one extra git call.
  const raw = git(repo, [
    'log',
    '--no-merges',
    `--format=${COMMIT_SEP}%H${FIELD_SEP}%h${FIELD_SEP}%aI${FIELD_SEP}%an${FIELD_SEP}%s${FIELD_SEP}%b`,
    range,
  ]);

  return raw
    .split(COMMIT_SEP)
    .filter((c) => c.trim())
    .map((chunk) => {
      const [sha, short, authored, author, subject, bodyRaw = ''] = chunk.split(FIELD_SEP);

      const body = bodyRaw
        .split('\n')
        .filter((l) => !/^(Co-Authored-By|Claude-Session|Signed-off-by|Content-Beat):/i.test(l.trim()))
        .join('\n')
        .trim();

      // Content-Beat: <one line> — the author's own marker that a commit
      // carries a story. Cheap to add, and it saves writing rationale twice.
      const beats = bodyRaw
        .split('\n')
        .filter((l) => /^Content-Beat:/i.test(l.trim()))
        .map((l) => l.replace(/^Content-Beat:\s*/i, '').trim());

      const files = (gitOrNull(repo, ['show', '--name-only', '--format=', sha]) ?? '')
        .split('\n')
        .map((f) => f.trim())
        .filter(Boolean);

      return {
        sha,
        short,
        authored, // ISO 8601 WITH the author's local offset — never normalize to UTC
        author,
        subject,
        body,
        beats,
        files,
      };
    })
    .reverse(); // oldest first: the narrative order
}

// ---------------------------------------------------------------- .toc

function parseToc(text) {
  const meta = {};
  const files = [];
  for (const line of text.split(/\r?\n/)) {
    const t = line.trim();
    if (!t) continue;
    const m = t.match(/^##\s*([^:]+):\s*(.*)$/);
    if (m) {
      meta[m[1].trim()] = m[2].trim();
    } else if (!t.startsWith('#')) {
      files.push(t);
    }
  }
  return { meta, files };
}

function addonsTouched(repo, commitList) {
  const names = new Set();
  for (const c of commitList) {
    for (const f of c.files) {
      const m = f.match(/^addons\/([^/]+)\//);
      if (m) names.add(m[1]);
    }
  }
  const out = {};
  for (const name of names) {
    const tocPath = join(repo, 'addons', name, `${name}.toc`);
    if (!existsSync(tocPath)) continue;
    const { meta, files } = parseToc(readFileSync(tocPath, 'utf8'));
    out[name] = {
      folder: name,
      toc: `addons/${name}/${name}.toc`,
      title: meta.Title ?? null,
      version: meta.Version ?? null,
      interface: meta.Interface ?? null,
      notes: meta.Notes ?? null,
      // X- fields are the client/license contract. The verifier reads these to
      // decide which game names and license names a pack may use at all.
      targetClient: meta['X-Target-Client'] ?? null,
      testedBuild: meta['X-Tested-Build'] ?? null,
      license: meta['X-License'] ?? null,
      savedVariables: meta.SavedVariables ?? null,
      loadOrder: files,
      vendoredLibFiles: files.filter((f) => /^libs[\\/]/i.test(f)),
    };
  }
  return out;
}

// ---------------------------------------------------------------- markdown

function sections(text, wanted = RECORD_SECTIONS) {
  const lines = text.split(/\r?\n/);
  const found = {};
  let current = null;
  let depth = 0;
  let buf = [];

  const flush = () => {
    if (current) found[current] = buf.join('\n').trim();
    current = null;
    buf = [];
  };

  for (const line of lines) {
    const h = line.match(/^(#{1,6})\s+(.*)$/);
    if (h) {
      const level = h[1].length;
      const title = h[2].replace(/[*_`]/g, '').trim();
      if (current && level <= depth) flush();
      const hit = wanted.find((w) => title.toLowerCase() === w.toLowerCase());
      if (hit) {
        flush();
        current = hit;
        depth = level;
        continue;
      }
    }
    if (current) buf.push(line);
  }
  flush();
  return found;
}

function changelogVersions(text) {
  // Keep a Changelog: "## [0.3.0] - 2026-09-20"
  const out = {};
  const lines = text.split(/\r?\n/);
  let cur = null;
  let buf = [];
  const flush = () => {
    if (cur) out[cur.version] = { ...cur, body: buf.join('\n').trim() };
    cur = null;
    buf = [];
  };
  for (const line of lines) {
    const m = line.match(/^##\s*\[([^\]]+)\]\s*-?\s*(.*)$/);
    if (m) {
      flush();
      cur = { version: m[1].trim(), date: m[2].trim() || null };
      continue;
    }
    if (cur) buf.push(line);
  }
  flush();
  return out;
}

function libsTable(text) {
  // | Library | Version | License | Upstream |
  const rows = [];
  for (const line of text.split(/\r?\n/)) {
    if (!line.trim().startsWith('|')) continue;
    const cells = line.split('|').slice(1, -1).map((c) => c.trim());
    if (cells.length < 3) continue;
    if (/^-+$/.test(cells[0].replace(/[\s:]/g, ''))) continue;
    if (/^library$/i.test(cells[0])) continue;
    rows.push({
      library: cells[0].replace(/[[\]]/g, ''),
      version: cells[1],
      license: cells[2],
      upstream: (cells[3] ?? '').replace(/^\[.*?\]\(|\)$/g, ''),
    });
  }
  return rows;
}

// ---------------------------------------------------------------- release state

function releaseState(repo, addons) {
  const tags = (gitOrNull(repo, ['tag', '-l']) ?? '').split('\n').filter(Boolean);
  const dist = join(repo, 'dist');
  let zips = [];
  if (existsSync(dist)) {
    try {
      zips = execFileSync('ls', [dist], { encoding: 'utf8' })
        .split('\n')
        .filter((f) => f.endsWith('.zip'));
    } catch { /* dist unreadable; treat as empty */ }
  }

  // "published" is never inferred. A pack may only claim a release when a tag
  // exists for that addon+version. A built zip is not a release.
  const published = {};
  for (const [name, a] of Object.entries(addons)) {
    const slug = name.toLowerCase();
    const want = a.version ? `${slug}-v${a.version}` : null;
    published[name] = {
      version: a.version,
      expectedTag: want,
      tagExists: want ? tags.includes(want) : false,
      zipBuilt: zips.some((z) => z.toLowerCase().includes(slug)),
    };
  }

  return { tags, zipsInDist: zips, published, anyPublished: Object.values(published).some((p) => p.tagExists) };
}

// ---------------------------------------------------------------- main

const repo = arg('repo', process.cwd());
const branch = arg('branch', null);
let range = arg('range', null);
const since = arg('since', null);
const out = arg('out', null);

if (!range) {
  if (since) {
    const ref = branch ?? 'HEAD';
    const first = gitOrNull(repo, ['log', '--format=%H', '--reverse', `--since=${since}`, ref])?.split('\n')[0];
    if (!first) {
      console.error(`session-digest: no commits on ${ref} since ${since}`);
      process.exit(2);
    }
    range = `${first}~1..${ref}`;
  } else {
    // Default: everything on the current branch not on the default branch.
    const head = branch ?? git(repo, ['rev-parse', '--abbrev-ref', 'HEAD']);
    const base = gitOrNull(repo, ['rev-parse', '--verify', '-q', 'origin/master'])
      ? 'origin/master'
      : 'origin/main';
    range = `${base}..${head}`;
  }
}

const commitList = commits(repo, range);
if (!commitList.length) {
  console.error(`session-digest: range ${range} contains no non-merge commits`);
  process.exit(2);
}

const addons = addonsTouched(repo, commitList);
const read = (p) => (existsSync(join(repo, p)) ? readFileSync(join(repo, p), 'utf8') : null);

const primary = Object.keys(addons)[0] ?? null;
const changelogText = primary ? read(`addons/${primary}/CHANGELOG.md`) : null;
const addonReadme = primary ? read(`addons/${primary}/README.md`) : null;
const libsReadme = primary ? read(`addons/${primary}/libs/README.md`) : null;
const handoff = read('HANDOFF.md');

const first = commitList[0];
const last = commitList[commitList.length - 1];
const spanMs = new Date(last.authored) - new Date(first.authored);

const digest = {
  schema: 'session-digest/1',
  generatedAt: new Date().toISOString(),
  repo: {
    path: repo,
    name: basename(repo),
    origin: gitOrNull(repo, ['remote', 'get-url', 'origin']),
    branch: branch ?? gitOrNull(repo, ['rev-parse', '--abbrev-ref', 'HEAD']),
    head: git(repo, ['rev-parse', 'HEAD']),
    licenseFirstLine: (read('LICENSE') ?? '').split('\n')[0].trim() || null,
  },
  range: {
    spec: range,
    firstCommit: { sha: first.short, authored: first.authored },
    lastCommit: { sha: last.short, authored: last.authored },
    commitCount: commitList.length,
    // Author-local timestamps, kept as-is. A build window reported in the wrong
    // timezone is the kind of error nobody catches until someone checks a VOD.
    durationMinutes: Math.round(spanMs / 60000),
    durationHuman: `${Math.floor(spanMs / 3600000)} h ${Math.round((spanMs % 3600000) / 60000)} m`,
  },
  commits: commitList,
  beats: commitList.flatMap((c) => c.beats.map((b) => ({ sha: c.short, beat: b }))),
  addons,
  release: releaseState(repo, addons),
  changelog: changelogText ? changelogVersions(changelogText) : {},
  vendoredLibs: libsReadme ? libsTable(libsReadme) : [],
  record: {
    handoff: handoff ? sections(handoff) : {},
    addonReadme: addonReadme ? sections(addonReadme) : {},
    changelogKnownGaps: changelogText ? sections(changelogText) : {},
  },
  // Everything a pack is allowed to name. The verifier builds its allowlists
  // from these, so a symbol or a client name absent here is a hard failure.
  vocabulary: {
    clients: [...new Set(Object.values(addons).map((a) => a.targetClient).filter(Boolean))],
    versions: [...new Set(Object.values(addons).map((a) => a.version).filter(Boolean))],
    interfaces: [...new Set(Object.values(addons).map((a) => a.interface).filter(Boolean))],
    licenses: [
      ...new Set([
        ...Object.values(addons).map((a) => a.license).filter(Boolean),
        ...(libsReadme ? libsTable(libsReadme).map((r) => r.license) : []),
      ]),
    ],
    symbols: [
      ...new Set(
        [changelogText, addonReadme, libsReadme, handoff]
          .filter(Boolean)
          .join('\n')
          .match(/\b(?:C_[A-Za-z]+(?:\.[A-Za-z_]+)?|[A-Z][A-Za-z]*\.[A-Za-z_]+|Lib[A-Za-z0-9]+|[A-Z][A-Z0-9_]{3,})\b/g) ?? [],
      ),
    ].sort(),
  },
};

const json = JSON.stringify(digest, null, 2);
if (out === '-') {
  process.stdout.write(`${json}\n`);
} else {
  const dir = out ? join(out, '..') : join(repo, 'dist');
  const file = out ?? join(repo, 'dist', `digest-${first.short}-${last.short}.json`);
  mkdirSync(dir, { recursive: true });
  writeFileSync(file, `${json}\n`);
  console.error(
    `session-digest: ${commitList.length} commits, ${Object.keys(addons).length} addon(s), ` +
      `${digest.range.durationHuman}, published=${digest.release.anyPublished} -> ${file}`,
  );
}
