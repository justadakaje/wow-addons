// Loads and indexes the harvested WoW: Forever API surface.
//
// The data is produced by addons/ForeverProbe reading Blizzard's own in-game
// documentation tables out of the running client, then rendered to JSON by
// scripts/extract-api.js. It describes exactly one build and nothing else --
// every response carries that build so a caller can never silently apply it
// to the wrong client.

import { readFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

export interface Param {
  Name?: string;
  Type?: string;
  Nilable?: boolean;
  Default?: unknown;
}

export interface ApiFunction {
  Name: string;
  Arguments?: Param[];
  Returns?: Param[];
}

export interface ApiEvent {
  Name: string;
  LiteralName?: string;
  Payload?: Param[];
}

/** Enum/structure definitions. Absent from captures before ForeverProbe 0.6.0. */
export interface ApiTable {
  Name?: string;
  Type?: string;
  Fields?: Param[];
  Values?: { Name?: string; Value?: unknown; EnumValue?: unknown }[];
}

export interface ApiSystem {
  Name?: string;
  Namespace?: string;
  Functions?: ApiFunction[];
  Events?: ApiEvent[];
  Tables?: ApiTable[];
}

export interface ApiFile {
  build?: { version?: string; build?: string; buildDate?: string; tocVersion?: number };
  generated?: string;
  counts?: { systems?: number; functions?: number; events?: number };
  /** Enum/structure definitions. Present only for ForeverProbe 0.6.0+ captures. */
  tables?: ApiTable[];
  watchlist?: Record<string, boolean>;
  systems: ApiSystem[];
}

export interface FunctionHit {
  system: string;
  namespace: string;
  fn: ApiFunction;
}

export interface EventHit {
  system: string;
  ev: ApiEvent;
}

const here = dirname(fileURLToPath(import.meta.url));

function locate(): string {
  const override = process.env.WOW_API_JSON;
  if (override) return override;
  // dist/ sits one level under mcp/, which sits beside reference/
  return resolve(here, "..", "..", "reference", "api.json");
}

export class ApiIndex {
  readonly file: ApiFile;
  readonly path: string;

  /** "c_housing.getmaxhouselevel" -> hit */
  private byQualified = new Map<string, FunctionHit>();
  /** "getmaxhouselevel" -> hits (a bare name can live in several namespaces) */
  private byBareName = new Map<string, FunctionHit[]>();
  /** "c_housing" and "housing" -> system */
  private bySystem = new Map<string, ApiSystem>();
  /** documented name AND literal name both resolve */
  private byEvent = new Map<string, EventHit>();
  /** widget type ("cooldown") -> system, from the FrameAPI* families */
  private byWidget = new Map<string, ApiSystem>();
  /** type name -> functions that mention it */
  private byType = new Map<string, { qualified: string; role: "argument" | "return"; param: Param }[]>();
  private tables = new Map<string, { system: string; table: ApiTable }>();

  constructor(path?: string) {
    this.path = path ?? locate();
    let raw: string;
    try {
      raw = readFileSync(this.path, "utf8");
    } catch {
      throw new Error(
        `Could not read the API data at ${this.path}. Generate it with ` +
          `'node scripts/extract-api.js <ForeverProbe.lua>', or point WOW_API_JSON at an existing api.json.`,
      );
    }
    this.file = JSON.parse(raw) as ApiFile;
    if (!Array.isArray(this.file.systems)) {
      throw new Error(`${this.path} has no 'systems' array; it is not a ForeverProbe API export.`);
    }
    this.build();
  }

  private build(): void {
    // Enum/structure definitions are harvested as one flat list rather than
    // per-system, so they are indexed before the systems are walked.
    for (const tbl of this.file.tables ?? []) {
      if (tbl?.Name) this.tables.set(tbl.Name.toLowerCase(), { system: "(global)", table: tbl });
    }

    for (const sys of this.file.systems) {
      const title = sys.Namespace || sys.Name || "";
      if (!title) continue;
      this.bySystem.set(title.toLowerCase(), sys);
      // C_Housing is also reachable as "housing"
      if (/^C_/.test(title)) this.bySystem.set(title.slice(2).toLowerCase(), sys);

      // Widget methods are documented as FrameAPI<Type> systems with no namespace.
      const widget = /^FrameAPI(.+)$/.exec(sys.Name || "");
      if (widget) this.byWidget.set(widget[1].toLowerCase(), sys);

      const ns = sys.Namespace || "";
      for (const fn of sys.Functions ?? []) {
        if (!fn?.Name) continue;
        const qualified = ns ? `${ns}.${fn.Name}` : fn.Name;
        const hit: FunctionHit = { system: title, namespace: ns, fn };
        this.byQualified.set(qualified.toLowerCase(), hit);
        const bare = fn.Name.toLowerCase();
        const list = this.byBareName.get(bare);
        if (list) list.push(hit);
        else this.byBareName.set(bare, [hit]);

        for (const [role, params] of [
          ["argument", fn.Arguments ?? []],
          ["return", fn.Returns ?? []],
        ] as const) {
          for (const p of params) {
            if (!p?.Type) continue;
            const key = p.Type.toLowerCase();
            const refs = this.byType.get(key) ?? [];
            refs.push({ qualified, role, param: p });
            this.byType.set(key, refs);
          }
        }
      }

      for (const ev of sys.Events ?? []) {
        if (!ev?.Name) continue;
        const hit: EventHit = { system: title, ev };
        this.byEvent.set(ev.Name.toLowerCase(), hit);
        if (ev.LiteralName) this.byEvent.set(ev.LiteralName.toLowerCase(), hit);
      }

      for (const tbl of sys.Tables ?? []) {
        if (tbl?.Name) this.tables.set(tbl.Name.toLowerCase(), { system: title, table: tbl });
      }
    }
  }

  get client(): string {
    const b = this.file.build ?? {};
    return `WoW: Forever ${b.version ?? "?"} (build ${b.build ?? "?"}), Interface ${b.tocVersion ?? "?"}`;
  }

  get hasTables(): boolean {
    return this.tables.size > 0;
  }

  /** Exact match on a qualified name, else every namespace carrying that bare name. */
  lookupFunction(name: string): FunctionHit[] {
    const key = name.trim().toLowerCase().replace(/[:]/g, ".");
    const exact = this.byQualified.get(key);
    if (exact) return [exact];
    const bare = key.includes(".") ? key.slice(key.lastIndexOf(".") + 1) : key;
    return this.byBareName.get(bare) ?? [];
  }

  /** Legacy-global presence, verified in the live client by ForeverProbe. */
  private get watchlist(): Record<string, boolean> {
    return this.file.watchlist ?? {};
  }

  /**
   * True when a bare global of this name was verified ABSENT from the client.
   * `GetItemInfo` is the case that matters: the global is gone but
   * `C_Item.GetItemInfo` exists, so a bare lookup finds matches and looks
   * fine while the obvious call is still an immediate error.
   */
  globalRemoved(name: string): boolean {
    const bare = name.trim().toLowerCase();
    if (bare.includes(".")) return false;
    for (const [key, present] of Object.entries(this.watchlist)) {
      if (!key.includes(".") && key.toLowerCase() === bare) return present === false;
    }
    return false;
  }

  /** Near-misses for a name that did not resolve, so errors can suggest a fix. */
  suggest(name: string, limit = 5): string[] {
    const bare = name.trim().toLowerCase().replace(/^.*[.:]/, "");
    if (bare.length < 3) return [];
    const out: string[] = [];
    const push = (h: FunctionHit) => {
      const label = h.namespace ? `${h.namespace}.${h.fn.Name}` : h.fn.Name;
      if (!out.includes(label)) out.push(label);
    };
    // Substring first -- exact-ish containment is the strongest signal.
    for (const [key, hits] of this.byBareName) {
      if (key.includes(bare) || bare.includes(key)) push(hits[0]);
      if (out.length >= limit) return out;
    }
    // Then shared prefix, which catches a typo that breaks containment
    // ("GetMaxHouseLevl" vs "GetMaxHouseLevel").
    const minPrefix = Math.min(6, bare.length);
    for (const [key, hits] of this.byBareName) {
      let i = 0;
      while (i < key.length && i < bare.length && key[i] === bare[i]) i++;
      if (i >= minPrefix) push(hits[0]);
      if (out.length >= limit) break;
    }
    return out;
  }

  searchFunctions(q: string): FunctionHit[] {
    const needle = q.toLowerCase();
    const out: FunctionHit[] = [];
    for (const [key, hit] of this.byQualified) {
      if (key.includes(needle)) out.push(hit);
    }
    return out.sort((a, b) => a.fn.Name.length - b.fn.Name.length);
  }

  searchEvents(q: string): EventHit[] {
    const needle = q.toLowerCase();
    const seen = new Set<ApiEvent>();
    const out: EventHit[] = [];
    for (const [key, hit] of this.byEvent) {
      if (key.includes(needle) && !seen.has(hit.ev)) {
        seen.add(hit.ev);
        out.push(hit);
      }
    }
    return out.sort((a, b) => a.ev.Name.length - b.ev.Name.length);
  }

  searchSystems(q: string): ApiSystem[] {
    const needle = q.toLowerCase();
    const seen = new Set<ApiSystem>();
    for (const [key, sys] of this.bySystem) {
      if (key.includes(needle)) seen.add(sys);
    }
    return [...seen];
  }

  getSystem(name: string): ApiSystem | undefined {
    return this.bySystem.get(name.trim().toLowerCase());
  }

  systemNames(): string[] {
    return this.file.systems.map((s) => s.Namespace || s.Name || "").filter(Boolean).sort();
  }

  getEvent(name: string): EventHit | undefined {
    return this.byEvent.get(name.trim().toLowerCase());
  }

  getWidget(type: string): ApiSystem | undefined {
    const key = type.trim().toLowerCase().replace(/^frameapi/, "");
    return this.byWidget.get(key);
  }

  widgetTypes(): string[] {
    return [...this.byWidget.keys()].sort();
  }

  getTable(name: string): { system: string; table: ApiTable } | undefined {
    return this.tables.get(name.trim().toLowerCase());
  }

  typeReferences(name: string) {
    return this.byType.get(name.trim().toLowerCase()) ?? [];
  }

  knownTypeNames(): string[] {
    return [...this.byType.keys()].sort();
  }
}
