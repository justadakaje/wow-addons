#!/usr/bin/env node
//
// check-content-pack.js -- run the accuracy gate against WRITTEN content.
//
// Sibling of check-episode.js. That one checks a spoken transcript against
// hardcoded checks for the 2026-09-20/21 episode. This one checks markdown --
// blog drafts, show notes, social copy, listing text -- and takes its rules
// from two files instead of from its own source:
//
//   docs/facts-build-69913.md   the "Things that are NOT true" blocklist
//   dist/digest-*.json          the mechanical record for a commit range
//
// One blocklist, two gates. Adding a falsehood to the fact sheet's ❌ list is
// how you block it in both places; nothing is duplicated here.
//
//   node scripts/check-content-pack.js draft.md
//   node scripts/check-content-pack.js draft.md --digest dist/digest-a-b.json
//
// Exit 0 when every check passes, 1 on any failure, 2 on tool error.
//
// WHAT THIS DOES NOT DO: it grounds facts. It cannot detect a well-formed lie.
// An invented anecdote ("survived a muted mic panic") has no wrong token in it
// and passes clean -- one did, in a real draft, and only the author knew. It
// also cannot see implied causation built from two true facts. A pass means the
// figures and names are right, not that the piece is honest. Read it anyway.

'use strict';

const fs = require('fs');
const path = require('path');

// ---------------------------------------------------------------- args

const argv = process.argv.slice(2);
const flag = (name, fallback = null) => {
  const i = argv.indexOf(`--${name}`);
  return i > -1 && argv[i + 1] ? argv[i + 1] : fallback;
};
const packPath = argv.find((a) => !a.startsWith('--') && (argv.indexOf(a) === 0 || !argv[argv.indexOf(a) - 1].startsWith('--')));
const digestPath = flag('digest');
const factsPath = flag('facts', path.join('docs', 'facts-build-69913.md'));
const contactsPath = flag('contacts', path.join('docs', 'media', 'contacts.yml'));
const warnOnly = argv.includes('--warn-only');

if (!packPath) {
  console.error('usage: node scripts/check-content-pack.js <pack.md> [--digest dist/digest-a-b.json]');
  console.error('                                          [--facts docs/facts-build-69913.md]');
  console.error('                                          [--contacts docs/media/contacts.yml] [--warn-only]');
  process.exit(2);
}
if (!fs.existsSync(packPath)) {
  console.error(`check-content-pack: no such file: ${packPath}`);
  process.exit(2);
}

const pack = fs.readFileSync(packPath, 'utf8');
const lines = pack.split(/\r?\n/);

// ---------------------------------------------------------------- grounding

// The corpus a claim must appear in to count as grounded. The digest when there
// is one, the fact sheet always -- so the gate still works before any digest has
// been generated, just with fewer rules active.
let digest = null;
if (digestPath) {
  if (!fs.existsSync(digestPath)) {
    console.error(`check-content-pack: no such digest: ${digestPath}`);
    process.exit(2);
  }
  digest = JSON.parse(fs.readFileSync(digestPath, 'utf8'));
}
const facts = fs.existsSync(factsPath) ? fs.readFileSync(factsPath, 'utf8') : null;
if (!facts) {
  console.error(`check-content-pack: fact sheet not found at ${factsPath} -- blocklist rules disabled`);
}

const corpus = [digest ? JSON.stringify(digest) : '', facts || ''].join('\n').toLowerCase();
const grounded = (s) => corpus.includes(String(s).toLowerCase());

const findings = [];
const push = (level, line, rule, message, extra) =>
  findings.push({ level, line, rule, message, extra: extra || null });

// A line that negates or contrasts may name what it is ruling out. "Not Classic
// Era" has to stay legal, and so does a corrections log entry quoting the claim
// it refutes. check-episode.js reaches the same conclusion via hit.negated.
const NEGATED = /\b(not|no|never|isn't|is not|unlike|rather than|instead of|has no|without|absent|un-?supported|excludes?|wrong|incorrect|corrected?|false|refut|myth|the draft|draft said|claimed)\b/i;

// Quarantine: a corrections log cannot be written without quoting wrong claims.
const ASSERTION_RULES = new Set([
  'factsheet-blocklist', 'client-name', 'release-claim', 'license-name',
  'platform-claim', 'ungrounded-symbol', 'ungrounded-number', 'version-string',
  'duration-drift',
]);
const QUOTE_MARK = /<!--\s*check:quote\s*-->/i;
const exemptHeadings = (flag('exempt-heading', 'Corrections Log,Corrections,Errata,What the draft got wrong') || '')
  .split(',').map((s) => s.trim()).filter(Boolean)
  .map((s) => new RegExp(s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), 'i'));

const quarantined = new Set();
{
  let depth = 0;
  let inside = false;
  lines.forEach((text, i) => {
    const h = text.match(/^(#{1,6})\s+(.*)$/);
    if (h) {
      const level = h[1].length;
      const title = h[2].replace(/[*_`]/g, '').trim();
      if (inside && level <= depth) inside = false;
      if (exemptHeadings.some((re) => re.test(title))) {
        inside = true;
        depth = level;
      }
    }
    if (inside || QUOTE_MARK.test(text)) quarantined.add(i + 1);
  });
}

const report = (level, line, rule, message, extra) => {
  if (line && quarantined.has(line) && ASSERTION_RULES.has(rule)) return;
  push(level, line, rule, message, extra);
};

// ---------------------------------------------------------------- rule 1

// The fact sheet's blocklist, parsed rather than restated. Each bullet reads
//   - ❌ "The claim." Why it is wrong.
// The quoted claim becomes the pattern; the sentence after it becomes the
// message, so the gate tells you what IS true instead of only what is not.
// Some blocked claims recur in wording the fact sheet's phrase does not cover:
// it says "It's an RP addon", a draft writes "roleplay-centric". These are the
// aliases, keyed by a distinctive substring of the fact sheet's own claim, so
// they stay traceable to the bullet they extend rather than floating free.
// The spoken-word equivalents live in check-episode.js; keep the two in step.
const BLOCK_ALIASES = {
  'RP addon': [/\brole[\s-]?play/i, /\bRP[\s-]?(?:addon|centric|focused)/i],
  'blank IDE': [/\bfrom scratch\b.{0,40}add[\s-]?on/i, /add[\s-]?on.{0,40}\bfrom scratch\b/i, /\bblank (?:text )?file\b/i, /\bfrom nothing\b/i, /\bfrom zero\b/i],
  'MIT vs GPL': [/\bMIT\b.{0,30}\bGPL/i, /\bGPL.{0,30}\bMIT\b/i, /chose?\s+(?:the\s+)?MIT/i],
  'Chomp was deferred': [/(?:avoid|drop|scrap|remov|reject)\w*\b.{0,40}\bChomp\b/i, /\bChomp\b.{0,40}(?:avoided|dropped|scrapped|removed|rejected)\b/i],
  'accelerated development': [/MCP server\b.{0,40}(?:acceler|sped up|faster|speed)/i, /(?:acceler|sped up)\w*\b.{0,40}MCP server/i],
  // Scoped to claims about what BUILT the addon. Naming another model as the
  // tool that generated a bad content draft is legitimate and has to stay
  // sayable -- docs/media/generated-draft-review.md does exactly that.
  'Used Cursor': [
    /\bCursor\b/,
    /(?:built|build|coded|wrote|written|developed|using|used|with)\b.{0,30}\b(?:Copilot|ChatGPT)\b/i,
    /\b(?:Copilot|ChatGPT)\b.{0,30}\b(?:built|coded|wrote|developed)\b/i,
  ],
};

function blocklistFromFacts(text) {
  if (!text) return [];
  const out = [];
  const section = text.split(/^##\s+Things that are NOT true.*$/im)[1];
  if (!section) return out;
  const body = section.split(/^##\s+/m)[0];

  // Bullets wrap. Join continuation lines onto their bullet before parsing, or
  // the "why it is wrong" half gets truncated mid-sentence in the output.
  const joined = [];
  for (const raw of body.split(/\r?\n/)) {
    if (/^\s*[-*]\s/.test(raw)) joined.push(raw.trimEnd());
    else if (joined.length && raw.trim()) joined[joined.length - 1] += ` ${raw.trim()}`;
  }

  for (const raw of joined) {
    const m = raw.match(/^\s*[-*]\s*❌\s*["“](.+?)["”]\s*(.*)$/);
    if (!m) continue;
    const claim = m[1].trim();
    const because = m[2].trim();

    // One bullet can block several phrasings: "blank IDE / zero to MVP".
    const phrases = claim.split(/\s*\/\s*/).map((p) => p.trim()).filter((p) => p.length > 3);
    const patterns = phrases.map((p) => {
      // Loosen to a phrase match: collapse whitespace, drop trailing punctuation,
      // allow "add-on"/"addon" and straight/curly apostrophes to vary.
      const core = p
        .replace(/[.!?]+$/, '')
        .replace(/[.*+?^${}()|[\]\\]/g, '\\$&')
        .replace(/\s+/g, '\\s+')
        .replace(/add-?on/gi, 'add[\\s-]?on')
        .replace(/['’]/g, "['’]");
      return new RegExp(core, 'i');
    });

    for (const [key, extra] of Object.entries(BLOCK_ALIASES)) {
      if (claim.toLowerCase().includes(key.toLowerCase())) patterns.push(...extra);
    }

    out.push({ claim, because, patterns });
  }
  return out;
}

const blocklist = blocklistFromFacts(facts);
for (const entry of blocklist) {
  lines.forEach((text, i) => {
    if (NEGATED.test(text)) return;
    for (const re of entry.patterns) {
      if (re.test(text)) {
        report('FAIL', i + 1, 'factsheet-blocklist',
          `blocked claim: "${entry.claim}"`,
          entry.because || 'listed under "Things that are NOT true" in the fact sheet');
        return;
      }
    }
  });
}

// ---------------------------------------------------------------- rules 2-10
// These need a digest. Without one they are skipped and reported as skipped,
// rather than silently passing.

const skipped = [];
const declared = (k) => (digest && digest.vocabulary && digest.vocabulary[k]) || [];

if (digest) {
  // 2. Client / game name.
  const CLIENT_TOKENS = [
    'World of Warcraft Classic', 'WoW Classic', 'Classic Era', 'Classic',
    'Retail', 'Dragonflight', 'The War Within', 'Wrath of the Lich King',
    'Cataclysm', 'Mists of Pandaria', 'Season of Discovery',
  ];
  const declaredClients = declared('clients').join(' ').toLowerCase();
  lines.forEach((text, i) => {
    for (const tok of CLIENT_TOKENS) {
      if (!new RegExp(`\\b${tok.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}\\b`, 'i').test(text)) continue;
      if (declaredClients.includes(tok.toLowerCase())) continue;
      if (NEGATED.test(text)) continue;
      report('FAIL', i + 1, 'client-name',
        `asserts "${tok}"`, `X-Target-Client is "${declared('clients').join(', ') || 'unset'}"`);
    }
  });

  // 3. Release claims. A built zip is not a release; only a tag is.
  const RELEASE_CLAIMS = [
    /\bshipped to CurseForge\b/i,
    /\b(?:published|live|released|available) on CurseForge\b/i,
    /\bCurseForge release\b/i,
    /\bto CurseForge in\b/i,
    /\bPUBLISHED\b/,
    /\bpackaged (?:CurseForge )?release\b/i,
  ];
  const pub = (digest.release && digest.release.published) || {};
  if (!(digest.release && digest.release.anyPublished)) {
    lines.forEach((text, i) => {
      for (const re of RELEASE_CLAIMS) {
        if (re.test(text) && !NEGATED.test(text)) {
          report('FAIL', i + 1, 'release-claim', 'claims a release',
            `no git tag exists (expected ${Object.values(pub).map((p) => p.expectedTag).filter(Boolean).join(', ') || 'none'})`);
        }
      }
    });
  }

  // 4. Version strings.
  const allowedVersions = new Set([
    ...declared('versions'),
    ...Object.keys(digest.changelog || {}),
  ]);
  lines.forEach((text, i) => {
    for (const m of text.matchAll(/\bv?(\d+\.\d+(?:\.\d+)?)\b/g)) {
      const v = m[1];
      if (/\d+:\d/.test(text)) continue; // aspect ratios
      const ok = allowedVersions.has(v) || allowedVersions.has(`${v}.0`) ||
        [...allowedVersions].some((a) => a.startsWith(v)) || grounded(v);
      if (!ok) {
        report('WARN', i + 1, 'version-string', `"${m[0]}" matches no version on record`,
          `.toc and CHANGELOG know: ${[...allowedVersions].join(', ')}`);
      }
    }
  });

  // 5. API symbols. The rule that catches an invented constant.
  const SYMBOL_RE = /\b(?:C_[A-Za-z][A-Za-z0-9]*(?:\.[A-Za-z_][A-Za-z0-9_]*)?|[A-Z][A-Za-z0-9]*\.[A-Za-z_][A-Za-z0-9_]*|Lib[A-Z][A-Za-z0-9]+|[A-Z][A-Z0-9]*_[A-Z0-9_]+)\b/g;
  const IGNORE = new Set(['README.md', 'CHANGELOG.md', 'HANDOFF.md', 'LICENSE.txt', 'AGENTS.md']);
  const unknown = new Map();
  lines.forEach((text, i) => {
    for (const m of text.matchAll(SYMBOL_RE)) {
      const sym = m[0];
      if (IGNORE.has(sym)) continue;
      if (/\.(md|lua|xml|json|toc|ps1|mjs|js|zip|yml|png|mkv|txt)$/i.test(sym)) continue;
      if (grounded(sym)) continue;
      if (!unknown.has(sym)) unknown.set(sym, i + 1);
    }
  });
  for (const [sym, line] of unknown) {
    report('FAIL', line, 'ungrounded-symbol', `"${sym}" appears in no source on record`,
      'invented, misremembered, or the digest range is too narrow');
  }

  // 6. Load-bearing numbers.
  const NUMBER_CONTEXT = [
    /(\d[\d,]*)\s*(?:B|bytes)\b/gi,
    /(\d+)\s*(?:px|pixels?)\b/gi,
    /(\d+)\s*chunks?\b/gi,
    /(\d+)\s*of\s*(\d+)\b/gi,
    /(\d[\d,]*)\s*functions?\b/gi,
    /(\d[\d,]*)\s*systems?\b/gi,
    /(\d[\d,]*)\s*lines\b/gi,
    /(\d+)\s*%/g,
    /\bbuild\s*(\d{4,})\b/gi,
    /\b(\d+)\s*x\s*(\d+)\b/gi,
  ];
  lines.forEach((text, i) => {
    for (const re of NUMBER_CONTEXT) {
      for (const m of text.matchAll(re)) {
        for (const g of m.slice(1).filter(Boolean)) {
          const n = g.replace(/,/g, '');
          if (n.length < 2) continue;
          if (grounded(n) || grounded(g)) continue;
          report('WARN', i + 1, 'ungrounded-number', `"${m[0].trim()}"`,
            `${n} appears in neither the digest nor the fact sheet`);
        }
      }
    }
  });

  // 7. Licenses.
  const LICENSE_TOKENS = ['GPL-2.0', 'GPL-3.0', 'GPLv2', 'GPLv3', 'GPL', 'AGPL', 'LGPL',
    'Apache-2.0', 'Apache 2.0', 'MPL', 'Unlicense', 'CC0', 'Proprietary'];
  const declaredLicenses = declared('licenses').join(' ').toLowerCase();
  lines.forEach((text, i) => {
    for (const tok of LICENSE_TOKENS) {
      if (!new RegExp(`\\b${tok.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}\\b`, 'i').test(text)) continue;
      if (declaredLicenses.includes(tok.toLowerCase())) continue;
      if (NEGATED.test(text)) continue;
      report('FAIL', i + 1, 'license-name', `names "${tok}"`,
        `the tree declares ${declared('licenses').join(', ') || 'no licenses'}`);
    }
  });

  // 8. Duration drift.
  const durH = Math.floor(((digest.range && digest.range.durationMinutes) || 0) / 60);
  lines.forEach((text, i) => {
    for (const m of text.matchAll(/\b(\d{1,2})[- ]hour\b/gi)) {
      const claimed = Number(m[1]);
      if (durH && Math.abs(claimed - durH) > 1 && !grounded(`${claimed} h`)) {
        report('WARN', i + 1, 'duration-drift', `claims ${claimed} h`,
          `digest range is ${digest.range.durationHuman} (${digest.range.spec})`);
      }
    }
  });
} else {
  skipped.push('client-name', 'release-claim', 'version-string', 'ungrounded-symbol',
    'ungrounded-number', 'license-name', 'duration-drift');
}

// ---------------------------------------------------------------- rule 9

// Handles. An allowlist, because tagging the wrong account is the one
// publishing error that cannot be quietly edited afterwards.
if (fs.existsSync(contactsPath)) {
  const allow = new Set(
    fs.readFileSync(contactsPath, 'utf8')
      .split(/\r?\n/)
      .map((l) => l.replace(/#.*/, '').trim())
      .filter((l) => l && !l.endsWith(':'))
      .map((l) => l.replace(/^-\s*/, '').split(/\s+/)[0].replace(/^@/, '').toLowerCase()),
  );
  lines.forEach((text, i) => {
    for (const m of text.matchAll(/@([A-Za-z0-9_.]{2,30})\b/g)) {
      if (!allow.has(m[1].toLowerCase())) {
        push('FAIL', i + 1, 'unknown-handle', `@${m[1]} is not on the allowlist`,
          `add it to ${contactsPath} if it is correct`);
      }
    }
  });
} else {
  skipped.push('unknown-handle');
}

// ---------------------------------------------------------------- rule 10

// A pack may not drop the caveats. The fact sheet carries an unverified-surface
// section; content that omits it reads as a finished product when a third of the
// card's fields have never displayed real data.
if (facts && /^##\s+Still unverified/im.test(facts)) {
  const lower = pack.toLowerCase();
  const signals = ['unverified', 'never exercised', 'not tested', 'never been tested',
    'known gap', 'never run', 'has not been', 'never displayed'];
  if (!signals.some((s) => lower.includes(s))) {
    push('FAIL', 0, 'caveats-dropped',
      'the fact sheet documents unverified surface and this draft never says so',
      'a pack that omits the gaps is not publishable');
  }
}

// ---------------------------------------------------------------- output

console.log(`check-content-pack: ${packPath}`);
console.log(`  facts:  ${facts ? factsPath : '(none)'}${blocklist.length ? ` -- ${blocklist.length} blocked claim(s)` : ''}`);
console.log(`  digest: ${digest ? `${digestPath} (${digest.range.spec}, ${digest.range.durationHuman})` : '(none -- 7 rules skipped)'}`);
console.log('');

const fails = findings.filter((f) => f.level === 'FAIL');
const warns = findings.filter((f) => f.level === 'WARN');

for (const f of [...fails, ...warns]) {
  const loc = f.line ? `${packPath}:${f.line}` : packPath;
  console.log(`  ${f.level === 'FAIL' ? 'FAIL' : 'WARN'} ${f.rule}  ${loc}`);
  console.log(`         ${f.message}`);
  if (f.extra) console.log(`         ${f.extra}`);
}

if (skipped.length) {
  console.log('');
  console.log(`  skipped (no digest): ${[...new Set(skipped)].join(', ')}`);
}

console.log('');
if (fails.length === 0) {
  console.log(`check-content-pack: PASSED${warns.length ? ` -- ${warns.length} warning(s) to read in context` : ''}.`);
  console.log('Figures and names are clean. It cannot tell you the piece is honest:');
  console.log('an invented anecdote passes this gate. Read it before anything ships.');
  process.exit(0);
}

console.error(`check-content-pack: ${fails.length} FAILED, ${warns.length} warning(s).`);
console.error('');
console.error('Fix the draft, or widen --digest if the claim is true but out of range.');
console.error('Do not delete a rule to get green -- every one of them is here because');
console.error('a real draft shipped that exact error.');
process.exit(warnOnly ? 0 : 1);
