# SimpleRegionAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`16` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetAlpha

```lua
GetAlpha() -> alpha: SingleColorValue
```

### GetDrawLayer

```lua
GetDrawLayer() -> layer: DrawLayer, sublayer: number
```

### GetEffectiveScale

```lua
GetEffectiveScale() -> effectiveScale: number
```

### GetScale

```lua
GetScale() -> scale: number
```

### GetVertexColor

```lua
GetVertexColor() -> colorR: number, colorG: number, colorB: number, colorA: number
```

### IsIgnoringParentAlpha

```lua
IsIgnoringParentAlpha() -> isIgnoring: bool
```

### IsIgnoringParentScale

```lua
IsIgnoringParentScale() -> isIgnoring: bool
```

### IsObjectLoaded

```lua
IsObjectLoaded() -> isLoaded: bool
```

### SetAlpha

```lua
SetAlpha(alpha: SingleColorValue)
```

### SetAlphaFromBoolean

```lua
SetAlphaFromBoolean(value: bool, alphaIfTrue: SingleColorValue, alphaIfFalse: SingleColorValue)
```

### SetDrawLayer

```lua
SetDrawLayer(layer: DrawLayer, sublevel: number)
```

### SetIgnoreParentAlpha

```lua
SetIgnoreParentAlpha(ignore: bool)
```

### SetIgnoreParentScale

```lua
SetIgnoreParentScale(ignore: bool)
```

### SetScale

```lua
SetScale(scale: number)
```

### SetVertexColor

```lua
SetVertexColor(colorR: number, colorG: number, colorB: number, a?: SingleColorValue)
```

### SetVertexColorFromBoolean

```lua
SetVertexColorFromBoolean(value: bool, colorIfTrue: colorRGBA, colorIfFalse: colorRGBA)
```
