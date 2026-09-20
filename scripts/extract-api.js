#!/usr/bin/env node
//
// Turns a ForeverProbe SavedVariables dump into a readable API reference.
//
//   node scripts/extract-api.js <path to ForeverProbe.lua> [outDir]
//
// WoW: Forever has no public API reference. ForeverProbe harvests Blizzard's
// own in-game documentation tables from the running client; this renders them.
// Re-run it whenever the build bumps -- the output is generated, never edited.
//
// Requires: npm install luaparse
//
// Parsing note: the dump is a 2 MB nested Lua table written CRLF. It is parsed
// with a real Lua parser rather than regex, because the file contains both a
// flat globalFunctions list and per-namespace member lists, and an unscoped
// pattern match confuses the two.

const fs = require('fs');
const path = require('path');

let luaparse;
try {
  luaparse = require('luaparse');
} catch (e) {
  console.error('luaparse not found. Run: npm install luaparse');
  process.exit(1);
}

// ---------------------------------------------------------------- Lua -> JS

function litValue(node) {
  if (node.value !== undefined && node.value !== null) return node.value;
  if (node.type === 'StringLiteral' && node.raw) return node.raw.slice(1, -1);
  return null;
}

function toJS(node) {
  switch (node.type) {
    case 'TableConstructorExpression': {
      const arr = [];
      const obj = {};
      let isArray = true;
      for (const f of node.fields) {
        if (f.type === 'TableValue') {
          arr.push(toJS(f.value));
        } else {
          isArray = false;
          const key = f.type === 'TableKeyString' ? f.key.name : litValue(f.key);
          obj[key] = toJS(f.value);
        }
      }
      if (isArray) return arr;
      if (arr.length) obj._array = arr;
      return obj;
    }
    case 'StringLiteral': return litValue(node);
    case 'NumericLiteral': return node.value;
    case 'BooleanLiteral': return node.value;
    case 'NilLiteral': return null;
    case 'UnaryExpression':
      return node.operator === '-' ? -toJS(node.argument) : toJS(node.argument);
    default: return null;
  }
}

function readGlobal(file, globalName) {
  const src = fs.readFileSync(file, 'utf8').replace(/^﻿/, '');
  const ast = luaparse.parse(src, { luaVersion: '5.1', comments: false });
  for (const stmt of ast.body) {
    if (stmt.type === 'AssignmentStatement' &&
        stmt.variables[0] && stmt.variables[0].name === globalName) {
      return toJS(stmt.init[0]);
    }
  }
  return null;
}

// ------------------------------------------------------------- formatting

// A nilable parameter is rendered `name?: Type`, matching how the client's own
// documentation distinguishes them.
function param(p) {
  if (!p || !p.Name) return '?';
  return p.Name + (p.Nilable ? '?' : '') + ': ' + (p.Type || 'unknown');
}

function signature(ns, fn) {
  const args = (fn.Arguments || []).map(param).join(', ');
  const rets = (fn.Returns || []).map(param).join(', ');
  const call = (ns ? ns + '.' : '') + fn.Name + '(' + args + ')';
  return rets ? call + ' -> ' + rets : call;
}

function slug(s) {
  return String(s).replace(/[^A-Za-z0-9_.-]/g, '_');
}

// ------------------------------------------------------------------- main

const [dumpPath, outDirArg] = process.argv.slice(2);
if (!dumpPath) {
  console.error('usage: node scripts/extract-api.js <ForeverProbe.lua> [outDir]');
  process.exit(1);
}
const outDir = outDirArg || path.join(__dirname, '..', 'reference');
const apiDir = path.join(outDir, 'api');

const db = readGlobal(dumpPath, 'ForeverProbeDB');
if (!db) { console.error('ForeverProbeDB not found in ' + dumpPath); process.exit(1); }

const build = db.build || {};
const doc = db.documentation || {};
const systems = Array.isArray(doc.systems) ? doc.systems : [];
if (!systems.length) {
  console.error('No documented systems in this dump. The capture likely loaded');
  console.error('Blizzard_APIDocumentation without Blizzard_APIDocumentationGenerated.');
  process.exit(1);
}

fs.mkdirSync(apiDir, { recursive: true });
for (const f of fs.readdirSync(apiDir)) {
  if (f.endsWith('.md')) fs.unlinkSync(path.join(apiDir, f)); // regenerate clean
}

const stamp = 'WoW: Forever ' + (build.version || '?') +
              ' (build ' + (build.build || '?') + ') - Interface ' +
              (build.tocVersion || '?');

// Every function the client actually exposes, so we can report what the
// documentation does NOT cover -- knowing where you are flying blind matters
// as much as the signatures themselves.
const documented = new Set();
const rows = [];

for (const sys of systems) {
  const ns = sys.Namespace || '';
  const title = ns || sys.Name || 'Global';
  const fns = (sys.Functions || []).slice().sort((a, b) => a.Name.localeCompare(b.Name));
  const evs = (sys.Events || []).slice().sort((a, b) => a.Name.localeCompare(b.Name));
  if (!fns.length && !evs.length) continue;

  for (const fn of fns) documented.add((ns ? ns + '.' : '') + fn.Name);

  const out = [];
  out.push('# ' + title);
  out.push('');
  out.push(stamp);
  out.push('');
  out.push('`' + fns.length + '` functions - `' + evs.length + '` events');
  out.push('');
  out.push('> Generated from the live client by `scripts/extract-api.js`. Do not edit.');
  out.push('');

  if (fns.length) {
    out.push('## Functions');
    out.push('');
    for (const fn of fns) {
      out.push('### ' + fn.Name);
      out.push('');
      out.push('```lua');
      out.push(signature(ns, fn));
      out.push('```');
      out.push('');
    }
  }

  if (evs.length) {
    out.push('## Events');
    out.push('');
    for (const ev of evs) {
      out.push('### ' + ev.Name);
      out.push('');
      if (ev.LiteralName && ev.LiteralName !== ev.Name) {
        out.push('Fires as `' + ev.LiteralName + '`.');
        out.push('');
      }
      const payload = ev.Payload || [];
      if (payload.length) {
        out.push('```lua');
        out.push('payload: ' + payload.map(param).join(', '));
        out.push('```');
      } else {
        out.push('No payload.');
      }
      out.push('');
    }
  }

  const fileName = slug(title) + '.md';
  fs.writeFileSync(path.join(apiDir, fileName), out.join('\n'));
  rows.push({ title, file: fileName, fns: fns.length, evs: evs.length });
}

// Namespaced functions the client exposes but the documentation omits.
const undocumented = [];
const nsMap = db.namespaces || {};
for (const ns of Object.keys(nsMap).sort()) {
  const members = nsMap[ns];
  if (!Array.isArray(members)) continue;
  for (const m of members) {
    if (!documented.has(ns + '.' + m)) undocumented.push(ns + '.' + m);
  }
}

rows.sort((a, b) => a.title.localeCompare(b.title));
const totalFns = rows.reduce((n, r) => n + r.fns, 0);
const totalEvs = rows.reduce((n, r) => n + r.evs, 0);

const idx = [];
idx.push('# WoW: Forever API reference');
idx.push('');
idx.push(stamp);
idx.push('');
idx.push('Harvested from the running client by `addons/ForeverProbe`, rendered by');
idx.push('`scripts/extract-api.js`. Forever has no public API reference; this is');
idx.push("Blizzard's own in-game documentation, extracted.");
idx.push('');
idx.push('- **' + rows.length + '** systems');
idx.push('- **' + totalFns + '** documented functions');
idx.push('- **' + totalEvs + '** documented events');
idx.push('- **' + undocumented.length + '** namespaced functions that exist but are **not** documented');
idx.push('');
idx.push('Regenerate after a build bump:');
idx.push('');
idx.push('```bash');
idx.push('npm install luaparse');
idx.push('node scripts/extract-api.js "<WoW>/WTF/Account/<id>/SavedVariables/ForeverProbe.lua"');
idx.push('```');
idx.push('');
idx.push('## Systems');
idx.push('');
idx.push('| System | Functions | Events |');
idx.push('| --- | ---: | ---: |');
for (const r of rows) {
  idx.push('| [' + r.title + '](api/' + r.file + ') | ' + r.fns + ' | ' + r.evs + ' |');
}
idx.push('');
fs.writeFileSync(path.join(outDir, 'README.md'), idx.join('\n'));

// The machine-readable seed. Minified: it is an artifact, not a document.
fs.writeFileSync(path.join(outDir, 'api.json'), JSON.stringify({
  build: build,
  generated: new Date().toISOString().slice(0, 10),
  counts: { systems: rows.length, functions: totalFns, events: totalEvs },
  // Presence of legacy globals, verified against the live client. Blizzard's
  // documentation carries no deprecation metadata, so whether a name resolves
  // is the only reliable signal -- and it is what list_deprecated reports.
  watchlist: db.watchlist || {},
  // Enum/structure definitions. Empty for captures from ForeverProbe < 0.6.0.
  tables: Array.isArray(doc.tables) ? doc.tables : [],
  undocumented: undocumented,
  systems: systems,
}));

fs.writeFileSync(path.join(outDir, 'undocumented.md'), [
  '# Undocumented functions',
  '',
  stamp,
  '',
  'These `C_*` functions exist in the running client but carry no entry in',
  "Blizzard's documentation tables. Calling them means guessing at the",
  'signature -- and `C_Housing.GetMaxHouseLevel` proved a documented function',
  'can still crash the client, so an undocumented one deserves more caution,',
  'not less.',
  '',
  '**' + undocumented.length + '** functions.',
  '',
  '```',
  undocumented.join('\n'),
  '```',
  '',
].join('\n'));

console.log('systems:      ' + rows.length);
console.log('functions:    ' + totalFns);
console.log('events:       ' + totalEvs);
console.log('undocumented: ' + undocumented.length);
console.log('written to:   ' + outDir);
