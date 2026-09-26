# LuaCurveObjectAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`10` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddPoint

```lua
AddPoint(pointX: number, pointY: number)
```

### ClearPoints

```lua
ClearPoints()
```

### Copy

```lua
Copy() -> curve: LuaCurveObject
```

### Evaluate

```lua
Evaluate(x: number) -> y: number
```

### GetPoint

```lua
GetPoint(index: luaIndex) -> point?: vector2
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
