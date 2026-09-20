# LuaColorCurveObjectAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`11` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddPoint

```lua
AddPoint(x: number, y: colorRGBA)
```

### ClearPoints

```lua
ClearPoints()
```

### Copy

```lua
Copy() -> curve: LuaColorCurveObject
```

### Evaluate

```lua
Evaluate(x: number) -> y: colorRGBA
```

### EvaluateUnpacked

```lua
EvaluateUnpacked(x: number) -> yR: number, yG: number, yB: number, yA: number
```

### GetPoint

```lua
GetPoint(index: luaIndex) -> point?: LuaColorCurvePoint
```

### GetPointCount

```lua
GetPointCount() -> count: size
```

### GetPoints

```lua
GetPoints() -> point: table
```

### RemovePoint

```lua
RemovePoint(index: luaIndex)
```

### SetPoints

```lua
SetPoints(point: table)
```

### SetToDefaults

```lua
SetToDefaults()
```
