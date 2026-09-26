#!/usr/bin/env node
//
// wow-api-mcp-server -- grounds WoW: Forever API lookups in the real client.
//
// Forever (1.60.1) has no public API reference. Wiki data, model training data
// and every addon author's habits predate it, and it removed most legacy
// globals: GetItemInfo, GetSpellInfo, UnitAura and QueryAuctionItems are all
// gone, while IsSpellKnown survives. Recalling a signature from memory is
// therefore unreliable in a way that is hard to notice. This server answers
// from Blizzard's own in-game documentation, harvested out of the running
// client by addons/ForeverProbe.
//
// Tool names deliberately match the contract already written into this repo's
// AGENTS.md and the wow-addon-partner skill (lookup_api, search_api, ...)
// rather than the {service}_{action} convention, because those callers
// hardcode them.

import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { z } from "zod";

import { ApiIndex } from "./data.js";
import {
  clamp,
  eventBlock,
  functionBlock,
  pageFooter,
  paginate,
  signature,
  systemTitle,
  tableBlock,
} from "./format.js";

let index: ApiIndex;
try {
  index = new ApiIndex();
} catch (err) {
  // stdio transport owns stdout; diagnostics must go to stderr.
  console.error(String(err instanceof Error ? err.message : err));
  process.exit(1);
}

const CLIENT = index.client;

const Format = z
  .enum(["markdown", "json"])
  .default("markdown")
  .describe("markdown (default, readable) or json (structured)");

const READ_ONLY = {
  readOnlyHint: true,
  destructiveHint: false,
  idempotentHint: true,
  openWorldHint: false,
} as const;

function text(body: string) {
  return { content: [{ type: "text" as const, text: clamp(body) }] };
}

function json(value: unknown) {
  return text(JSON.stringify({ client: CLIENT, ...(value as object) }, null, 2));
}

function md(body: string) {
  return text(`${body}\n\n---\n_${CLIENT}_`);
}

const server = new McpServer({ name: "wow-api-mcp-server", version: "1.0.0" });

// --------------------------------------------------------------- lookup_api

server.registerTool(
  "lookup_api",
  {
    title: "Look up a WoW API function",
    description:
      "Get the verified signature of a WoW: Forever API function: argument names, types, " +
      "nilability and return types. Accepts a qualified name (C_Housing.GetMaxHouseLevel) " +
      "or a bare one (GetMaxHouseLevel), in which case every namespace defining it is " +
      "returned. Use this before writing any call rather than recalling a signature from " +
      "memory. If a function is absent it does not exist on this client.",
    inputSchema: {
      name: z.string().min(1).describe("Function name, qualified or bare"),
      response_format: Format,
    },
    annotations: READ_ONLY,
  },
  async ({ name, response_format }) => {
    const hits = index.lookupFunction(name);
    const status = index.globalStatus(name);
    if (!hits.length) {
      const near = index.suggest(name);
      const hint = near.length ? ` Did you mean: ${near.join(", ")}?` : "";
      // The watchlist outranks the documentation here. "May still exist but be
      // undocumented" is the right hedge for an unknown name and the wrong one
      // for a name the client was checked for.
      if (status === "removed") {
        return text(
          `The global "${name}" does not exist on ${CLIENT}. ForeverProbe verified it ` +
            `resolves to nil, so calling it is an immediate error.${hint}`,
        );
      }
      if (status === "present") {
        return text(
          `"${name}" is verified present on ${CLIENT}, but Blizzard's documentation has no ` +
            `function signature under that name. It may be an undocumented function, or a ` +
            `table or namespace — try get_namespace. Do not assume a signature for it.${hint}`,
        );
      }
      return text(
        `No function named "${name}" exists on ${CLIENT}.${hint}\n\n` +
          `Absence here is meaningful: this index is the client's own documentation. ` +
          `Note it may still exist but be undocumented — see reference/undocumented.md ` +
          `(627 such functions). Do not assume a signature for it.`,
      );
    }
    if (response_format === "json") {
      return json({
        query: name,
        // true = verified nil; false = verified present, or a qualified name;
        // null = no presence record. Kept for callers that test `=== true`.
        // globalStatus carries the distinction a boolean cannot.
        globalRemoved: status === "removed" ? true : status === "unverified" ? null : false,
        globalStatus: status,
        matches: hits.map((h) => ({
          system: h.system,
          namespace: h.namespace,
          name: h.fn.Name,
          signature: signature(h.namespace, h.fn),
          arguments: h.fn.Arguments ?? [],
          returns: h.fn.Returns ?? [],
        })),
      });
    }
    const body = hits
      .map((h) => `## ${h.namespace ? `${h.namespace}.${h.fn.Name}` : h.fn.Name}\n\nSystem: \`${h.system}\`\n\n${functionBlock(h.namespace, h.fn)}`)
      .join("\n\n");

    // Without a note, a bare lookup that finds documented matches reads as
    // confirmation that the bare global exists. That is only true when the
    // capture says so: "GetItemInfo" finds four matches and the global is nil,
    // and "LoadAddOn" finds one while the capture has no record of the global.
    const notes: Record<typeof status, string> = {
      removed:
        `> **The global \`${name}\` does not exist on this client.** It resolves to \`nil\`; ` +
        `calling it is an immediate error. The matches below are namespaced functions that ` +
        `merely share the name — use one of those instead.\n\n`,
      unverified:
        `> **Unverified: this capture has no presence record for a bare global \`${name}\`.** ` +
        `The matches below are documented, which is not evidence the bare global resolves. ` +
        `Check \`type(${name})\` in-game before calling it bare, or use a namespaced form.\n\n`,
      present: `> The bare global \`${name}\` is verified present on this client.\n\n`,
      qualified: "",
    };

    return md(notes[status] + (hits.length > 1 ? `Found ${hits.length} matches.\n\n${body}` : body));
  },
);

// --------------------------------------------------------------- search_api

server.registerTool(
  "search_api",
  {
    title: "Search the WoW API",
    description:
      "Substring search across function names, event names and system names on " +
      "WoW: Forever. Use when you know roughly what a call is called, or to discover " +
      "what exists in an area (e.g. 'auction', 'housing', 'tradeskill'). Returns " +
      "signatures, paginated.",
    inputSchema: {
      query: z.string().min(2).describe("Substring to match, case-insensitive"),
      kind: z
        .enum(["all", "functions", "events", "systems"])
        .default("all")
        .describe("Restrict results to one kind"),
      limit: z.number().int().min(1).max(100).default(25).describe("Max results (default 25)"),
      offset: z.number().int().min(0).default(0).describe("Results to skip, for paging"),
      response_format: Format,
    },
    annotations: READ_ONLY,
  },
  async ({ query, kind, limit, offset, response_format }) => {
    const fns = kind === "all" || kind === "functions" ? index.searchFunctions(query) : [];
    const evs = kind === "all" || kind === "events" ? index.searchEvents(query) : [];
    const sys = kind === "all" || kind === "systems" ? index.searchSystems(query) : [];

    const rows = [
      ...fns.map((h) => ({
        kind: "function" as const,
        name: h.namespace ? `${h.namespace}.${h.fn.Name}` : h.fn.Name,
        system: h.system,
        signature: signature(h.namespace, h.fn),
      })),
      ...evs.map((h) => ({
        kind: "event" as const,
        name: h.ev.Name,
        system: h.system,
        signature: `RegisterEvent("${h.ev.LiteralName ?? h.ev.Name}")`,
      })),
      ...sys.map((s) => ({
        kind: "system" as const,
        name: systemTitle(s),
        system: systemTitle(s),
        signature: `${(s.Functions ?? []).length} functions, ${(s.Events ?? []).length} events`,
      })),
    ];

    const page = paginate(rows, limit, offset);
    if (!page.total) {
      return text(
        `Nothing matches "${query}" on ${CLIENT}. Try a shorter substring, ` +
          `or search_api with kind="systems" to see what areas exist.`,
      );
    }
    if (response_format === "json") {
      return json({ query, kind, ...page });
    }
    const body = page.items
      .map((r) => `- **${r.name}** _(${r.kind}, ${r.system})_\n  \`${r.signature}\``)
      .join("\n");
    return md(`# Matches for "${query}"\n\n${body}\n${pageFooter(page)}`);
  },
);

// ------------------------------------------------------------ get_namespace

server.registerTool(
  "get_namespace",
  {
    title: "List a WoW API namespace",
    description:
      "List every documented function and event in one namespace or system " +
      "(e.g. C_Housing, C_AuctionHouse, C_Item). Accepts the C_ prefix or not. " +
      "Call with no name to list all available systems.",
    inputSchema: {
      name: z
        .string()
        .optional()
        .describe("Namespace, e.g. 'C_Housing' or 'Housing'. Omit to list all systems."),
      include: z
        .enum(["all", "functions", "events"])
        .default("all")
        .describe("Restrict to functions or events"),
      limit: z.number().int().min(1).max(500).default(200).describe("Max entries (default 200)"),
      offset: z.number().int().min(0).default(0).describe("Entries to skip, for paging"),
      response_format: Format,
    },
    annotations: READ_ONLY,
  },
  async ({ name, include, limit, offset, response_format }) => {
    if (!name) {
      const names = index.systemNames();
      const page = paginate(names, limit, offset);
      if (response_format === "json") return json({ systems: page.items, ...page, items: undefined });
      return md(`# Systems (${names.length})\n\n${page.items.join("\n")}\n${pageFooter(page)}`);
    }

    const sys = index.getSystem(name);
    if (!sys) {
      const near = index.searchSystems(name).slice(0, 5).map(systemTitle);
      return text(
        `No system named "${name}" on ${CLIENT}.` +
          (near.length ? ` Did you mean: ${near.join(", ")}?` : ` Call get_namespace with no name to list all.`),
      );
    }

    const title = systemTitle(sys);
    const ns = sys.Namespace ?? "";
    const entries = [
      ...(include === "events" ? [] : (sys.Functions ?? []).map((fn) => ({ kind: "function", text: signature(ns, fn) }))),
      ...(include === "functions" ? [] : (sys.Events ?? []).map((ev) => ({ kind: "event", text: `${ev.LiteralName ?? ev.Name}` }))),
    ];
    const page = paginate(entries, limit, offset);

    if (response_format === "json") {
      return json({
        system: title,
        namespace: ns,
        functions: include === "events" ? [] : (sys.Functions ?? []),
        events: include === "functions" ? [] : (sys.Events ?? []),
      });
    }
    const fnLines = page.items.filter((e) => e.kind === "function").map((e) => e.text);
    const evLines = page.items.filter((e) => e.kind === "event").map((e) => e.text);
    const parts = [`# ${title}`];
    if (fnLines.length) parts.push(`## Functions (${(sys.Functions ?? []).length})`, "```lua", fnLines.join("\n"), "```");
    if (evLines.length) parts.push(`## Events (${(sys.Events ?? []).length})`, "```", evLines.join("\n"), "```");
    return md(`${parts.join("\n\n")}\n${pageFooter(page)}`);
  },
);

// ------------------------------------------------------------- get_event

server.registerTool(
  "get_event",
  {
    title: "Look up a WoW event",
    description:
      "Get an event's payload and, critically, the exact string to pass to " +
      "RegisterEvent. Blizzard documents events under a CamelCase name that differs " +
      "from the SCREAMING_SNAKE literal the client actually fires " +
      "(AddNeighborhoodCharterSignature vs ADD_NEIGHBORHOOD_CHARTER_SIGNATURE); " +
      "either form is accepted here.",
    inputSchema: {
      name: z.string().min(1).describe("Event name, documented or literal form"),
      response_format: Format,
    },
    annotations: READ_ONLY,
  },
  async ({ name, response_format }) => {
    const hit = index.getEvent(name);
    if (!hit) {
      const near = index.searchEvents(name).slice(0, 5).map((h) => h.ev.LiteralName ?? h.ev.Name);
      return text(
        `No event named "${name}" is documented on ${CLIENT}.` +
          (near.length ? ` Did you mean: ${near.join(", ")}?` : ""),
      );
    }
    if (response_format === "json") {
      return json({
        system: hit.system,
        name: hit.ev.Name,
        registerEventName: hit.ev.LiteralName ?? hit.ev.Name,
        payload: hit.ev.Payload ?? [],
      });
    }
    return md(eventBlock(hit.system, hit.ev));
  },
);

// ------------------------------------------------------- get_widget_methods

server.registerTool(
  "get_widget_methods",
  {
    title: "List widget methods",
    description:
      "List the documented methods of a UI widget type (Cooldown, Blob, CinematicModel, " +
      "...), i.e. what you can call on a frame of that type. Call with no type to list " +
      "the widget types that carry documentation. Note this covers only the widget " +
      "families Blizzard documents as FrameAPI systems, not every frame method.",
    inputSchema: {
      widget_type: z
        .string()
        .optional()
        .describe("Widget type, e.g. 'Cooldown'. Omit to list documented types."),
      response_format: Format,
    },
    annotations: READ_ONLY,
  },
  async ({ widget_type, response_format }) => {
    if (!widget_type) {
      const types = index.widgetTypes();
      if (response_format === "json") return json({ widget_types: types });
      return md(
        `# Documented widget types (${types.length})\n\n${types.join("\n")}\n\n` +
          `_Only families documented as FrameAPI* systems appear here._`,
      );
    }
    const sys = index.getWidget(widget_type);
    if (!sys) {
      return text(
        `No documented widget type "${widget_type}" on ${CLIENT}. ` +
          `Call get_widget_methods with no argument to list the ${index.widgetTypes().length} that are documented. ` +
          `Most frame methods (SetPoint, Show, SetScript) are not in Blizzard's documentation tables at all.`,
      );
    }
    const fns = sys.Functions ?? [];
    if (response_format === "json") {
      return json({ widget_type, system: systemTitle(sys), methods: fns });
    }
    const lines = fns.map((fn) => signature("", fn));
    return md(`# ${systemTitle(sys)} (${fns.length} methods)\n\n\`\`\`lua\n${lines.join("\n")}\n\`\`\``);
  },
);

// ---------------------------------------------------------------- get_enum

server.registerTool(
  "get_enum",
  {
    title: "Look up an enum or structure type",
    description:
      "Resolve a non-primitive type that appears in a signature (e.g. " +
      "InvalidPlotScreenshotReason, ItemLocation). Returns its values or fields when " +
      "the capture includes them, and always reports which functions use the type.",
    inputSchema: {
      name: z.string().min(1).describe("Type name as it appears in a signature"),
      response_format: Format,
    },
    annotations: READ_ONLY,
  },
  async ({ name, response_format }) => {
    const table = index.getTable(name);
    const refs = index.typeReferences(name);
    const values = index.enumValues(name);

    if (!table && !refs.length && !values) {
      return text(
        `Type "${name}" does not appear in any signature on ${CLIENT}. ` +
          `Check the spelling against a signature from lookup_api.`,
      );
    }

    if (response_format === "json") {
      return json({
        type: name,
        definition: table?.table ?? null,
        definitionAvailable: Boolean(table),
        runtimeValues: values ?? null,
        referencedBy: refs.map((r) => ({ function: r.qualified, role: r.role })),
      });
    }

    const parts = [`# ${name}`];
    // For an enumeration the runtime values are a strict superset of the
    // documented member list, so showing both just prints the names twice.
    const supersededByRuntime = Boolean(values) && table?.table.Type === "Enumeration";
    if (table && !supersededByRuntime) parts.push(tableBlock(table.table));

    // Runtime values beat documented ones: this is what the client compares
    // against, and Blizzard's docs name enum members without their numbers.
    if (values) {
      const rows = Object.entries(values).sort((a, b) =>
        typeof a[1] === "number" && typeof b[1] === "number" ? a[1] - b[1] : a[0].localeCompare(b[0]),
      );
      parts.push(
        table ? "\n## Runtime values (global `Enum`)" : "",
        "```lua",
        rows.map(([k, v]) => `Enum.${name}.${k} = ${String(v)}`).join("\n"),
        "```",
      );
    }

    if (!table && !values) {
      // Distinguish "we never captured definitions" from "Blizzard defines none
      // for this type" -- conflating them sends the reader to re-run a probe
      // that would not help.
      parts.push(
        index.hasTables
          ? `**Referenced in signatures, but Blizzard's documentation defines no values or fields for it.** ` +
            `About 129 of the 778 referenced types are like this — typically opaque handles ` +
            `(\`ItemLocation\`, \`ClubId\`, \`SpellIdentifier\`) that you obtain from another call ` +
            `rather than construct. Treat it as a token to pass through, and check the functions below ` +
            `for one that produces it.`
          : `**No type definitions in this capture.** Re-run ForeverProbe 0.6.0+ and regenerate ` +
            `\`reference/api.json\` to populate enum and structure definitions.`,
      );
    }
    // An empty "Used by (0)" section is noise; a type can be reachable through
    // the global Enum table without appearing in any documented signature.
    if (refs.length) {
      const shown = refs.slice(0, 30);
      parts.push(
        "",
        `## Used by (${refs.length})`,
        "",
        shown.map((r) => `- \`${r.qualified}\` (${r.role} \`${r.param.Name ?? "?"}\`)`).join("\n"),
        refs.length > shown.length ? `\n_…and ${refs.length - shown.length} more._` : "",
      );
    }
    return md(parts.filter((p) => p !== "").join("\n"));
  },
);

// ----------------------------------------------------------- list_deprecated

server.registerTool(
  "list_deprecated",
  {
    title: "List removed legacy APIs",
    description:
      "Report legacy global functions that no longer exist on WoW: Forever, verified " +
      "against the live client, with their modern replacements where known. On this " +
      "client removal rather than deprecation is the norm: most legacy globals were " +
      "deleted outright in favour of C_* namespaces. Covers only the names ForeverProbe " +
      "was told to check: a name on neither list was never probed, which is not evidence " +
      "it exists. For one specific name, lookup_api reports which case it is.",
    inputSchema: { response_format: Format },
    annotations: READ_ONLY,
  },
  async ({ response_format }) => {
    const watchlist = index.file.watchlist;
    if (!watchlist || !Object.keys(watchlist).length) {
      return text(
        `This capture carries no presence data, so removals cannot be reported.\n\n` +
          `Blizzard's documentation tables contain no deprecation metadata at all — the ` +
          `only reliable signal is whether a name resolves in the live client. Regenerate ` +
          `reference/api.json with a current scripts/extract-api.js, which records ` +
          `ForeverProbe's presence watchlist.\n\n` +
          `Meanwhile: lookup_api returning nothing for a legacy global is itself the answer.`,
      );
    }

    const gone = Object.entries(watchlist)
      .filter(([, present]) => !present)
      .map(([name]) => name)
      .sort();
    const present = Object.entries(watchlist)
      .filter(([, p]) => p)
      .map(([name]) => name)
      .sort();

    // Coverage is stated in the output, not just the description: a list with no
    // stated bounds reads as exhaustive, and this one is ForeverProbe's
    // hand-curated WATCHLIST. Counted rather than named -- a hardcoded example
    // of a missing name goes stale the moment the watchlist gains it.
    const coverage =
      `Covers only the ${index.watchlistSize} names ForeverProbe's watchlist checks, not ` +
      `every legacy global. A name on neither list was never probed — that is not evidence ` +
      `it exists.`;

    if (response_format === "json") {
      return json({
        removed: gone,
        present,
        probed: index.watchlistSize,
        note: `Verified against the live client, not inferred. ${coverage}`,
      });
    }
    return md(
      `# Removed on ${CLIENT}\n\n` +
        `These resolve to \`nil\`. Using them is an immediate error.\n\n\`\`\`\n${gone.join("\n")}\n\`\`\`\n\n` +
        `## Still present\n\n\`\`\`\n${present.join("\n")}\n\`\`\`\n\n` +
        `Note \`IsSpellKnown\` survives as a global while \`GetSpellInfo\` does not — ` +
        `the split is not systematic, so verify each name rather than assuming a pattern.\n\n` +
        `**Coverage.** ${coverage} For one specific name, \`lookup_api\` says which it is: ` +
        `removed, present, or unverified.`,
    );
  },
);

const transport = new StdioServerTransport();
await server.connect(transport);
console.error(`wow-api-mcp-server ready — ${CLIENT} (${index.path})`);
