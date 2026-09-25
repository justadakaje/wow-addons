#!/usr/bin/env node
//
// check-episode.js -- run the accuracy gate against an episode transcript.
//
// The Runtime Reality episode argues that an AI's confidence tracks how
// plausible a claim is, not how verified it is. If the episode itself drifts on
// one figure -- ASCII 30 instead of 31, "about 400 bytes" instead of 392 -- it
// refutes its own thesis in the most quotable way available.
//
// Listening for that is unreliable. Nobody notices a correct number, and the
// wrong ones sound knowledgeable: "a control character in the thirties" passes
// a human ear and destroys the point, because the whole story is that the
// TEXTBOOK-CORRECT answer failed.
//
//   node scripts/check-episode.js transcript.txt
//
// Exit 0 when every check passes, 1 on any failure, 2 on tool error.
//
// WHAT THIS DOES NOT DO: it checks that the right strings are present and the
// wrong ones absent. It cannot tell you the episode is well argued, correctly
// structured, or that a figure is used in the right context. A transcript that
// passes still needs a human listen for tone and flow -- this just means the
// facts are not wrong.

"use strict";

const fs = require("fs");
const path = require("path");

// Spoken numbers come back from speech-to-text either way depending on the
// engine and the surrounding phrasing, so every numeric check accepts both.
const CHECKS = [
  // ---------------------------------------------------------------- required
  {
    id: "ascii-31",
    kind: "require",
    any: [/ASCII[\s-]*31\b/i, /\bunit separator\b/i, /ASCII thirty[\s-]?one/i],
    correct: "ASCII 31, the unit separator",
    why: "The story is that the textbook-correct separator is the one that failed.",
  },
  {
    id: "wire-cbor",
    kind: "require",
    any: [/\b386\b/, /three hundred (and )?eighty[\s-]?six/i],
    correct: "386 bytes (CBOR)",
  },
  {
    id: "wire-deflate",
    kind: "require",
    any: [/\b293\b/, /two hundred (and )?ninety[\s-]?three/i],
    correct: "293 bytes (Deflate)",
  },
  {
    id: "wire-base64",
    kind: "require",
    any: [/\b392\b/, /three hundred (and )?ninety[\s-]?two/i],
    correct: "392 bytes (Base64)",
    why: "392 being LARGER than the 386 it started from is the counter-intuitive beat.",
  },
  {
    id: "wire-chunks",
    kind: "require",
    any: [/\b240\b/, /two hundred (and )?forty/i],
    correct: "2 chunks at 240 B",
  },
  {
    id: "build",
    kind: "require",
    any: [/\b69913\b/, /sixty[\s-]?nine (thousand )?nine( hundred)? ?(and )?thirteen/i],
    correct: "build 69913",
  },
  {
    id: "interface",
    kind: "require",
    any: [/\b16001\b/, /sixteen thousand (and )?one\b/i],
    correct: "Interface 16001",
  },
  {
    id: "race-id",
    kind: "require",
    any: [/\bSkyborne\b/i],
    correct: "Skyborne, race ID 96",
    why: "Race ID 96 alone is too noisy to match; this checks the name is named.",
  },
  {
    id: "auction-house",
    kind: "require",
    any: [/\b85\b/, /eighty[\s-]?five/i],
    correct: "85 C_AuctionHouse functions",
  },
  {
    id: "housing-crash",
    kind: "require",
    any: [/GetMaxHouseLevel/i, /C_Housing/i],
    correct: "C_Housing.GetMaxHouseLevel named",
    why: "Must be described as documented AND present AND still crashing. Verify that by ear -- presence of the name is all this can check.",
  },
  {
    id: "honesty-caveat",
    kind: "require",
    any: [/\ba third\b/i, /one[\s-]?third/i, /never (been )?tested/i, /unverified/i],
    correct: "the roughly-a-third-unverified caveat",
    why: "An episode about verification that overstates its own completeness is self-refuting.",
  },

  // --------------------------------------------------------------- forbidden
  {
    id: "block-cursor",
    kind: "forbid",
    any: [/\bCursor\b/, /\bCopilot\b/i, /\bChatGPT\b/i],
    correct: "Claude Code",
  },
  {
    id: "block-roleplay",
    kind: "forbid",
    any: [/\brole[\s-]?play/i, /\bRP addon\b/i],
    correct: "out-of-character social matchmaking",
  },
  {
    id: "block-blank-ide",
    kind: "forbid",
    any: [/blank IDE/i, /zero to MVP/i, /from scratch/i],
    correct: "the addon already existed; the probe had never run",
  },
  {
    id: "block-license-debate",
    kind: "forbid",
    any: [/MIT vs\.? GPL/i, /GPL/i],
    correct: "MIT existed since 2020; only the year changed",
  },
  {
    id: "block-rounding",
    kind: "forbid",
    any: [
      /about (four hundred|400)/i,
      /around (four hundred|400)/i,
      /roughly (four hundred|400)/i,
      /about (three hundred|300)/i,
      /control character in the (thirties|30s)/i,
    ],
    correct: "exact figures, never rounded",
  },
  {
    id: "block-wrong-ascii",
    kind: "forbid",
    any: [/ASCII[\s-]*30\b/i, /ASCII[\s-]*32\b/i],
    correct: "ASCII 31",
  },

  // -------------------------------------------------------------------- warn
  {
    id: "warn-curseforge",
    kind: "warn",
    any: [/CurseForge/i],
    correct: "package built and verified only -- NOT published",
    why: "Mentioning CurseForge is allowed; claiming it shipped is not. Read each hit in context.",
  },
  {
    id: "warn-accelerate",
    kind: "warn",
    any: [/acceler/i, /\bfaster\b/i, /\bsped up\b/i],
    correct: "the MCP server VERIFIED API calls -- correctness, not speed",
    why: "Check any hit is not describing the MCP server.",
  },
];

function contextFor(text, re, span = 70) {
  const m = re.exec(text);
  if (!m) return null;
  const s = Math.max(0, m.index - span);
  const e = Math.min(text.length, m.index + m[0].length + span);
  return ("…" + text.slice(s, e) + "…").replace(/\s+/g, " ");
}

function main() {
  const file = process.argv[2];
  if (!file) {
    console.error("usage: node scripts/check-episode.js <transcript.txt>");
    console.error("");
    console.error("Get a transcript from NotebookLM directly, or transcribe the");
    console.error("exported audio (Word: Home > Dictate > Transcribe).");
    process.exit(2);
  }

  let text;
  try {
    text = fs.readFileSync(file, "utf8");
  } catch (e) {
    console.error(`check-episode: cannot read ${file}: ${e.message}`);
    process.exit(2);
  }

  const words = text.split(/\s+/).filter(Boolean).length;
  const rel = path.relative(process.cwd(), file).replace(/\\/g, "/") || file;
  console.log(`check-episode: ${rel}  (${words.toLocaleString()} words)`);
  console.log("");

  let failed = 0;
  let warned = 0;

  for (const c of CHECKS) {
    const hit = c.any.find((re) => re.test(text));
    const ok = c.kind === "require" ? !!hit : !hit;

    if (c.kind === "warn") {
      if (hit) {
        warned++;
        console.log(`  WARN ${c.id}`);
        console.log(`         expected: ${c.correct}`);
        if (c.why) console.log(`         ${c.why}`);
        console.log(`         found: ${contextFor(text, hit)}`);
      } else {
        console.log(`  ok   ${c.id}`);
      }
      continue;
    }

    if (ok) {
      console.log(`  ok   ${c.id}`);
      continue;
    }

    failed++;
    console.log(`  FAIL ${c.id}`);
    console.log(`         expected: ${c.correct}`);
    if (c.why) console.log(`         ${c.why}`);
    if (c.kind === "forbid" && hit) {
      console.log(`         found: ${contextFor(text, hit)}`);
    }
    if (c.kind === "require") {
      console.log(`         not found anywhere in the transcript`);
    }
  }

  console.log("");
  if (failed === 0 && warned === 0) {
    console.log(`check-episode: all ${CHECKS.length} checks passed.`);
    console.log("Facts are clean. Still listen once for tone, structure and flow.");
    return;
  }
  if (failed === 0) {
    console.log(`check-episode: no failures, ${warned} warning(s) to read in context.`);
    console.log("Still listen once for tone, structure and flow.");
    return;
  }
  console.error(`check-episode: ${failed} FAILED, ${warned} warning(s).`);
  console.error("");
  console.error("Do not patch the audio. Regenerate with the failing item named");
  console.error("explicitly in the customisation prompt -- a spliced correction is");
  console.error("audible, and this episode trades on exactly the credibility that");
  console.error("would undermine.");
  process.exit(1);
}

main();
