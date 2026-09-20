# C_TooltipComparison

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`3` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CompareItem

```lua
C_TooltipComparison.CompareItem(comparisonItem: TooltipComparisonItem, tooltip: Tooltip, anchorFrame?: SimpleFrame)
```

### GetItemComparisonDelta

```lua
C_TooltipComparison.GetItemComparisonDelta(comparisonItem: TooltipComparisonItem, equippedItem: TooltipComparisonItem, pairedItem?: TooltipComparisonItem, addPairedStats?: bool) -> lines: table
```

### GetItemComparisonInfo

```lua
C_TooltipComparison.GetItemComparisonInfo(comparisonItem: TooltipComparisonItem) -> info: TooltipItemComparisonInfo
```

## Events

### TooltipShowItemComparison

Fires as `TOOLTIP_SHOW_ITEM_COMPARISON`.

```lua
payload: comparisonItem: TooltipComparisonItem, tooltip: Tooltip, anchorFrame?: SimpleFrame
```
