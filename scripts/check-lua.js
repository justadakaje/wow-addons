#!/usr/bin/env node
//
// check-lua.js -- syntax-check addon Lua before it reaches the client.
//
// There is no Lua interpreter and no C compiler on the dev machine, so the
// only way to catch a syntax error before the game does is to parse it here.
// `luaparse` is pure JavaScript and targets Lua 5.1, which is what WoW runs.
//
//   node scripts/check-lua.js                 # every .lua under addons/
//   node scripts/check-lua.js addons/Foo      # one addon
//   node scripts/check-lua.js a.lua b.lua     # specific files
//
// Exit code is 0 when everything parsed, 1 when anything failed, 2 when the
// tool itself could not run. Intended to be cheap enough to run every time.
//
// WHAT THIS DOES NOT DO: parsing proves the file is well-formed Lua. It says
// nothing about whether the API it calls exists on this client -- that is what
// the wow-api MCP server is for, and AGENTS.md requires checking it there.
// A file can parse perfectly and still be a pile of nil-index errors in game.

"use strict";

const fs = require("fs");
const path = require("path");

let luaparse;
try {
  luaparse = require("luaparse");
} catch (e) {
  console.error("check-lua: cannot load luaparse.");
  console.error("  Run `npm install luaparse` at the repo root and retry.");
  process.exit(2);
}

// ---------------------------------------------------------------- workaround
//
// luaparse 0.3.1 rejects `break;` under luaVersion '5.1', but Lua 5.1 accepts
// it: the grammar is `block ::= {stat [';']} [laststat [';']]`, and `break` is
// a laststat, so the optional semicolon is legal. The parser is wrong, not the
// code.
//
// Neutralise the token before parsing. Replacing the `;` with a space keeps
// every byte offset identical, so reported line and column numbers still point
// at the right place in the real file.
//
// This is a blunt textual pass, so it can also hit a `break;` sitting inside a
// string literal or comment. That is harmless: it only ever turns `;` into a
// space, which cannot change whether the file parses -- "break;" becomes
// "break " and is still a perfectly good string. We never write the result
// back to disk.
const BREAK_SEMI = /\bbreak\b;/g;

function normalise(src) {
  return src.replace(BREAK_SEMI, (m) => m.slice(0, -1) + " ");
}

// ------------------------------------------------------------------ walking

function collect(target, out) {
  let st;
  try {
    st = fs.statSync(target);
  } catch (e) {
    console.error(`check-lua: no such path: ${target}`);
    process.exitCode = 2;
    return;
  }

  if (st.isDirectory()) {
    for (const entry of fs.readdirSync(target).sort()) {
      if (entry === "node_modules" || entry === ".git") continue;
      collect(path.join(target, entry), out);
    }
  } else if (target.toLowerCase().endsWith(".lua")) {
    out.push(target);
  }
}

// ------------------------------------------------------------------ checking

function check(file) {
  let src;
  try {
    src = fs.readFileSync(file, "utf8");
  } catch (e) {
    return { file, ok: false, message: `unreadable: ${e.message}` };
  }

  try {
    luaparse.parse(normalise(src), {
      luaVersion: "5.1",
      comments: false,
      scope: false,
      locations: true,
    });
    return { file, ok: true, bytes: src.length };
  } catch (e) {
    // luaparse throws a SyntaxError carrying line/column when it can.
    const where =
      typeof e.line === "number"
        ? `:${e.line}${typeof e.column === "number" ? ":" + e.column : ""}`
        : "";
    return { file, ok: false, message: e.message, where };
  }
}

// --------------------------------------------------------------------- main

function main() {
  const args = process.argv.slice(2).filter((a) => !a.startsWith("-"));
  const roots = args.length > 0 ? args : ["addons"];

  const files = [];
  for (const r of roots) collect(r, files);

  if (files.length === 0) {
    console.error(`check-lua: no .lua files found under ${roots.join(", ")}`);
    process.exit(2);
  }

  const failures = [];
  for (const f of files) {
    const r = check(f);
    const rel = path.relative(process.cwd(), r.file).replace(/\\/g, "/");
    if (r.ok) {
      console.log(`  ok   ${rel}`);
    } else {
      failures.push(r);
      console.log(`  FAIL ${rel}${r.where || ""}`);
    }
  }

  console.log("");
  if (failures.length === 0) {
    console.log(`check-lua: ${files.length} file(s) parsed clean.`);
    return;
  }

  for (const f of failures) {
    const rel = path.relative(process.cwd(), f.file).replace(/\\/g, "/");
    console.error(`${rel}${f.where || ""}  ${f.message}`);
  }
  console.error("");
  console.error(`check-lua: ${failures.length} of ${files.length} file(s) failed.`);
  process.exit(1);
}

main();
