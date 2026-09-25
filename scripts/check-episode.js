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
    // ASII is Word's transcription of "ASCII" -- tolerated so a speech-to-text
    // artifact does not read as an episode error.
    any: [/AS[CI]I+[\s-]*31\b/i, /\bunit separator\b/i, /ASCII thirty[\s-]?one/i],
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
    id: "race-id",
    kind: "require",
    // Speech-to-text drops the trailing "e" from Skyborne.
    any: [/\bSkyborne?\b/i, /race ID (of )?96/i],
    correct: "Skyborne, race ID 96",
  },
  {
    id: "honesty-caveat",
    kind: "require",
    // "1/3" is how a transcript renders "one third" when it is spoken as a
    // fraction. Bare /third/ is unusable -- it matches "third-party library".
    any: [
      /1\s*\/\s*3\b/,
      /one[\s-]?third/i,
      /a third of the/i,
      /never (been )?(exercised|tested)/i,
    ],
    correct: "the roughly-a-third-unverified caveat",
    why: "An episode about verification that overstates its own completeness is self-refuting.",
  },

  // ------------------------------------------------------------ informational
  //
  // These are in the fact sheet but NOT in the brief's required structure, so
  // an episode that omits them is behaving correctly. They report as INFO and
  // never fail. Requiring them was a bug: the gate must check the episode
  // against the brief it was given, not against everything known about the
  // project.
  {
    id: "info-interface",
    kind: "optional",
    any: [/\b16001\b/, /sixteen thousand (and )?one\b/i],
    correct: "Interface 16001",
  },
  {
    id: "info-auction-house",
    kind: "optional",
    any: [/C_AuctionHouse/i, /auction house/i],
    correct: "85 C_AuctionHouse functions -- if the topic comes up, the number must be 85",
  },
  {
    id: "info-housing-crash",
    kind: "optional",
    any: [/GetMaxHouseLevel/i, /C_Housing/i],
    correct: "documented AND present AND still crashing -- all three, if covered",
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
    // Bare /from scratch/ is too broad: the episode legitimately says the
    // session produced "reusable build tools from scratch", which is true and
    // is not the blocked claim. Tie it to the addon.
    any: [
      /blank IDE/i,
      /zero to MVP/i,
      /add[\s-]?on.{0,40}from scratch/i,
      /from scratch.{0,40}add[\s-]?on/i,
    ],
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
    any: [/acceler/i, /\bsped up\b/i],
    correct: "the MCP server VERIFIED API calls -- correctness, not speed",
    why: "Read the hit. Saying it was NOT used to accelerate development is correct and will trip this.",
  },

  // ------------------------------------------------------- transcript quality
  //
  // These flag likely speech-to-text errors, not episode errors. The audio
  // almost certainly says the right thing; the transcript does not. Worth
  // knowing so a mis-transcription is never mistaken for a factual mistake --
  // and so nobody "fixes" an episode that was already correct.
  {
    id: "stt-claude-code",
    kind: "stt",
    any: [/cloud code/i],
    correct: 'likely "Claude Code" misheard as "cloud code"',
  },
  {
    id: "stt-ascii",
    kind: "stt",
    any: [/\bASII\b/i, /\bASKI\b/i],
    correct: 'likely "ASCII" mistranscribed',
  },
  {
    id: "stt-chomp",
    kind: "stt",
    // "Chomp's" is the correct possessive and must not trip this.
    any: [/\bchamp\b/i, /\bchump\b/i],
    correct: 'likely "Chomp" misheard as "champ" or "chump"',
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
  let noted = 0;

  for (const c of CHECKS) {
    const hit = c.any.find((re) => re.test(text));
    const ok = c.kind === "require" ? !!hit : !hit;

    // Not in the brief's required structure. Report presence, never fail.
    if (c.kind === "optional") {
      console.log(`  ${hit ? "INFO" : "--  "} ${c.id}${hit ? "" : "   (not covered -- fine, the brief does not require it)"}`);
      if (hit) console.log(`         ${c.correct}`);
      continue;
    }

    // Transcript quality, not episode quality.
    if (c.kind === "stt") {
      if (hit) {
        noted++;
        console.log(`  NOTE ${c.id}`);
        console.log(`         ${c.correct}`);
        console.log(`         found: ${contextFor(text, hit)}`);
      }
      continue;
    }

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
  const extra = [
    warned ? `${warned} warning(s) to read in context` : null,
    noted ? `${noted} likely transcription artifact(s)` : null,
  ].filter(Boolean).join(", ");

  if (failed === 0) {
    console.log(`check-episode: PASSED${extra ? " — " + extra : ""}.`);
    console.log("Facts are clean. Still listen once for tone, structure and flow.");
    if (noted) {
      console.log("NOTE items are transcript errors, not episode errors — do not");
      console.log("regenerate over them. Confirm against the audio if it matters.");
    }
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
