# SimpleScriptRegionResizingAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`13` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AdjustPointsOffset

```lua
AdjustPointsOffset(x: uiUnit, y: uiUnit)
```

### ClearAllPoints

```lua
ClearAllPoints()
```

### ClearPoint

```lua
ClearPoint(point: FramePoint)
```

### ClearPointsOffset

```lua
ClearPointsOffset()
```

### GetNumPoints

```lua
GetNumPoints() -> numPoints: number
```

### GetPoint

```lua
GetPoint(anchorIndex: luaIndex, resolveCollapsed: bool) -> point: FramePoint, relativeTo: ScriptRegion, relativePoint: FramePoint, offsetX: uiUnit, offsetY: uiUnit
```

### GetPointByName

```lua
GetPointByName(point: FramePoint, resolveCollapsed: bool) -> point: FramePoint, relativeTo: ScriptRegion, relativePoint: FramePoint, offsetX: uiUnit, offsetY: uiUnit
```

### SetAllPoints

```lua
SetAllPoints(relativeTo: ScriptRegion, doResize: bool)
```

### SetHeight

```lua
SetHeight(height: uiUnit)
```

### SetPoint

```lua
SetPoint(point: FramePoint, relativeTo: ScriptRegion, relativePoint: FramePoint, offsetX: uiUnit, offsetY: uiUnit)
```

### SetPointsOffset

```lua
SetPointsOffset(x: uiUnit, y: uiUnit)
```

### SetSize

```lua
SetSize(x: uiUnit, y: uiUnit)
```

### SetWidth

```lua
SetWidth(width: uiUnit)
```
