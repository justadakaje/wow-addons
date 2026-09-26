// End-to-end check: speaks real MCP over stdio and exercises every tool.
//   node smoke.mjs
// Exits non-zero if a tool is missing or an expected assertion fails.
import { Client } from "@modelcontextprotocol/sdk/client/index.js";
import { StdioClientTransport } from "@modelcontextprotocol/sdk/client/stdio.js";

const client = new Client({ name: "smoke", version: "1.0.0" });
await client.connect(new StdioClientTransport({ command: "node", args: ["dist/index.js"] }));

const { tools } = await client.listTools();
const expected = ["lookup_api", "search_api", "get_namespace", "get_event",
                  "get_widget_methods", "get_enum", "list_deprecated"];
const missing = expected.filter((t) => !tools.some((x) => x.name === t));
if (missing.length) { console.error("MISSING TOOLS: " + missing.join(", ")); process.exit(1); }

const body = async (name, args) =>
  (await client.callTool({ name, arguments: args })).content.map((c) => c.text).join("\n");

let failed = 0;
async function check(label, name, args, predicate) {
  const out = await body(name, args);
  const ok = predicate(out);
  console.log((ok ? "  ok   " : "  FAIL ") + label);
  if (!ok) { failed++; console.log(out.split("\n").slice(0, 6).join("\n")); }
}

console.log(`${tools.length} tools\n`);
await check("known function resolves", "lookup_api", { name: "C_Housing.GetMaxHouseLevel" },
  (o) => o.includes("-> level: number"));
await check("removed global is flagged", "lookup_api", { name: "GetItemInfo" },
  (o) => o.includes("does not exist on this client"));
await check("namespaced twin is NOT flagged", "lookup_api", { name: "C_Item.GetItemInfo" },
  (o) => !o.includes("does not exist on this client"));
await check("unknown name suggests", "lookup_api", { name: "GetMaxHouseLevl" },
  (o) => o.includes("Did you mean"));
await check("event gives RegisterEvent string", "get_event", { name: "AddNeighborhoodCharterSignature" },
  (o) => o.includes("ADD_NEIGHBORHOOD_CHARTER_SIGNATURE"));
await check("search paginates", "search_api", { query: "commodity", limit: 3 },
  (o) => o.includes("Showing 1-3"));
await check("namespace lists", "get_namespace", { name: "Housing" },
  (o) => o.includes("# C_Housing"));
await check("widget methods", "get_widget_methods", { widget_type: "Cooldown" },
  (o) => o.includes("GetCooldownTimes"));
await check("enum reports usage", "get_enum", { name: "InvalidPlotScreenshotReason" },
  (o) => o.includes("Used by"));
await check("deprecated lists removals", "list_deprecated", {},
  (o) => o.includes("QueryAuctionItems"));
await check("json format", "lookup_api", { name: "GetItemInfo", response_format: "json" },
  (o) => JSON.parse(o).globalRemoved === true);

await client.close();
console.log(failed ? `\n${failed} FAILED` : "\nall checks passed");
process.exit(failed ? 1 : 0);
