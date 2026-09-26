# C_CurveUtil

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`5` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CreateColorCurve

```lua
C_CurveUtil.CreateColorCurve() -> curve: LuaColorCurveObject
```

### CreateCurve

```lua
C_CurveUtil.CreateCurve() -> curve: LuaCurveObject
```

### EvaluateColorFromBoolean

```lua
C_CurveUtil.EvaluateColorFromBoolean(boolean: bool, valueIfTrue: colorRGBA, valueIfFalse: colorRGBA) -> value: colorRGBA
```

### EvaluateColorValueFromBoolean

```lua
C_CurveUtil.EvaluateColorValueFromBoolean(boolean: bool, valueIfTrue: SingleColorValue, valueIfFalse: SingleColorValue) -> value: SingleColorValue
```

### EvaluateGameCurve

```lua
C_CurveUtil.EvaluateGameCurve(curveID: number, x: number) -> y: number
```
