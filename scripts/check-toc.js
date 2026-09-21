#!/usr/bin/env node
//
// check-toc.js -- verify every file a .toc references actually exists.
//
// A .toc that names a missing file does not warn: the game silently skips it,
// and the addon half-loads with confusing symptoms. Worse, a .toc listing
// `libs\Foo\Foo.lua` with a mangled path looks plausible when you read it.
//
//   node scripts/check-toc.js                 # every addon under addons/
//   node scripts/check-toc.js addons/Foo      # one addon
//
// Exit 0 when every reference resolves, 1 when any does not, 2 on tool error.
//
// Also checks the rule the CI workflow enforces: each .toc must carry an
// "## Interface:" line, since an addon without one will not load at all.

"use strict";

const fs = require("fs");
const path = require("path");

function findTocs(dir, out) {
  let entries;
  try {
    entries = fs.readdirSync(dir, { withFileTypes: true });
  } catch (e) {
    console.error(`check-toc: cannot read ${dir}: ${e.message}`);
    process.exitCode = 2;
    return;
  }
  for (const e of entries) {
    if (e.name === "node_modules" || e.name === ".git") continue;
    const full = path.join(dir, e.name);
    if (e.isDirectory()) findTocs(full, out);
    else if (e.name.toLowerCase().endsWith(".toc")) out.push(full);
  }
}

function checkToc(tocPath) {
  const dir = path.dirname(tocPath);
  const rel = path.relative(process.cwd(), tocPath).replace(/\\/g, "/");
  const lines = fs.readFileSync(tocPath, "utf8").split(/\r?\n/);

  const problems = [];
  let refs = 0;
  let hasInterface = false;

  for (const raw of lines) {
    const line = raw.trim();
    if (!line) continue;

    if (line.startsWith("##")) {
      if (/^##\s*Interface\s*:/i.test(line)) hasInterface = true;
      continue;
    }
    // '#' alone is a comment; '##' is metadata, handled above.
    if (line.startsWith("#")) continue;
    if (!/\.(lua|xml)$/i.test(line)) continue;

    refs++;
    // .toc paths use Windows separators; normalise for the filesystem check.
    const target = path.join(dir, line.replace(/\\/g, path.sep));
    if (!fs.existsSync(target)) problems.push(line);
  }

  if (!hasInterface) problems.push("(no '## Interface:' line)");

  return { rel, refs, problems };
}

function main() {
  const args = process.argv.slice(2).filter((a) => !a.startsWith("-"));
  const roots = args.length > 0 ? args : ["addons"];

  const tocs = [];
  for (const r of roots) {
    if (fs.existsSync(r) && fs.statSync(r).isFile()) tocs.push(r);
    else findTocs(r, tocs);
  }

  if (tocs.length === 0) {
    console.error(`check-toc: no .toc files found under ${roots.join(", ")}`);
    process.exit(2);
  }

  let failed = 0;
  for (const t of tocs) {
    const r = checkToc(t);
    if (r.problems.length === 0) {
      console.log(`  ok   ${r.rel}  (${r.refs} file${r.refs === 1 ? "" : "s"})`);
    } else {
      failed++;
      console.log(`  FAIL ${r.rel}`);
      for (const p of r.problems) console.log(`         missing: ${p}`);
    }
  }

  console.log("");
  if (failed === 0) {
    console.log(`check-toc: ${tocs.length} .toc file(s) verified.`);
    return;
  }
  console.error(`check-toc: ${failed} of ${tocs.length} .toc file(s) have problems.`);
  process.exit(1);
}

main();
