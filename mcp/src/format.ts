// Rendering helpers. Markdown is the default because these responses are read
// by an agent deciding whether a call is safe to write; JSON is available for
// programmatic use.

import type { ApiEvent, ApiFunction, ApiSystem, ApiTable, Param } from "./data.js";

/** Responses beyond this are truncated with an explicit note, never silently. */
export const CHARACTER_LIMIT = 40_000;

export function param(p: Param): string {
  if (!p?.Name) return p?.Type ?? "?";
  return `${p.Name}${p.Nilable ? "?" : ""}: ${p.Type ?? "unknown"}`;
}

export function signature(namespace: string, fn: ApiFunction): string {
  const args = (fn.Arguments ?? []).map(param).join(", ");
  const rets = (fn.Returns ?? []).map(param).join(", ");
  const call = `${namespace ? namespace + "." : ""}${fn.Name}(${args})`;
  return rets ? `${call} -> ${rets}` : call;
}

export function eventSignature(ev: ApiEvent): string {
  const payload = (ev.Payload ?? []).map(param).join(", ");
  return payload ? `payload: ${payload}` : "no payload";
}

export function functionBlock(namespace: string, fn: ApiFunction): string {
  const lines = ["```lua", signature(namespace, fn), "```"];
  if ((fn.Arguments ?? []).some((a) => a.Nilable)) {
    lines.push("", "`?` marks a nilable parameter.");
  }
  return lines.join("\n");
}

export function eventBlock(system: string, ev: ApiEvent): string {
  const lines = [`**${ev.Name}**${system ? ` — ${system}` : ""}`];
  if (ev.LiteralName && ev.LiteralName !== ev.Name) {
    lines.push("", `RegisterEvent name: \`${ev.LiteralName}\``);
  } else {
    lines.push("", `RegisterEvent name: \`${ev.Name}\``);
  }
  lines.push("", "```lua", eventSignature(ev), "```");
  return lines.join("\n");
}

export function systemTitle(sys: ApiSystem): string {
  return sys.Namespace || sys.Name || "(unnamed)";
}

export function tableBlock(tbl: ApiTable): string {
  const lines = [`**${tbl.Name ?? "(unnamed)"}**${tbl.Type ? ` — ${tbl.Type}` : ""}`, ""];
  if (tbl.Values?.length) {
    lines.push("```");
    for (const v of tbl.Values) {
      lines.push(`${v.Name ?? "?"} = ${String(v.EnumValue ?? v.Value ?? "?")}`);
    }
    lines.push("```");
  } else if (tbl.Fields?.length) {
    lines.push("```lua");
    for (const f of tbl.Fields) lines.push(param(f));
    lines.push("```");
  } else {
    lines.push("_No values or fields recorded._");
  }
  return lines.join("\n");
}

/** Truncates at a line boundary and says so, so a caller never sees a silent cut. */
export function clamp(text: string, limit = CHARACTER_LIMIT): string {
  if (text.length <= limit) return text;
  const cut = text.lastIndexOf("\n", limit);
  return (
    text.slice(0, cut > 0 ? cut : limit) +
    `\n\n_…truncated at ${limit} characters. Narrow the query, or page with limit/offset._`
  );
}

export interface Page<T> {
  items: T[];
  total: number;
  offset: number;
  has_more: boolean;
  next_offset: number | null;
}

export function paginate<T>(all: T[], limit: number, offset: number): Page<T> {
  const items = all.slice(offset, offset + limit);
  const end = offset + items.length;
  return {
    items,
    total: all.length,
    offset,
    has_more: end < all.length,
    next_offset: end < all.length ? end : null,
  };
}

export function pageFooter(p: Page<unknown>): string {
  if (!p.total) return "";
  const shown = `${p.offset + 1}-${p.offset + p.items.length} of ${p.total}`;
  return p.has_more
    ? `\n_Showing ${shown}. More available — call again with offset=${p.next_offset}._`
    : `\n_Showing ${shown}._`;
}
