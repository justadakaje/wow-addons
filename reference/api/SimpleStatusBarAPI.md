# SimpleStatusBarAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`28` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetFillStyle

```lua
GetFillStyle() -> fillStyle: StatusBarFillStyle
```

### GetInterpolatedValue

```lua
GetInterpolatedValue() -> value: number
```

### GetMinMaxValues

```lua
GetMinMaxValues() -> minValue: number, maxValue: number
```

### GetOrientation

```lua
GetOrientation() -> orientation: Orientation
```

### GetRenderMode

```lua
GetRenderMode() -> renderMode: StatusBarRenderMode
```

### GetReverseFill

```lua
GetReverseFill() -> isReverseFill: bool
```

### GetRotatesTexture

```lua
GetRotatesTexture() -> rotatesTexture: bool
```

### GetStatusBarColor

```lua
GetStatusBarColor() -> colorR: number, colorG: number, colorB: number, colorA: number
```

### GetStatusBarDesaturation

```lua
GetStatusBarDesaturation() -> desaturation: normalizedValue
```

### GetStatusBarTexture

```lua
GetStatusBarTexture() -> texture: SimpleTexture
```

### GetTimerDuration

```lua
GetTimerDuration() -> duration: LuaDurationObject
```

### GetValue

```lua
GetValue() -> value: number
```

### IsInterpolating

```lua
IsInterpolating() -> isInterpolating: bool
```

### IsStatusBarDesaturated

```lua
IsStatusBarDesaturated() -> desaturated: bool
```

### SetColorFill

```lua
SetColorFill(colorR: number, colorG: number, colorB: number, a?: SingleColorValue)
```

### SetFillStyle

```lua
SetFillStyle(fillStyle: StatusBarFillStyle)
```

### SetMinMaxValues

```lua
SetMinMaxValues(minValue: number, maxValue: number, interpolation: StatusBarInterpolation)
```

### SetOrientation

```lua
SetOrientation(orientation: Orientation)
```

### SetRenderMode

```lua
SetRenderMode(renderMode: StatusBarRenderMode)
```

### SetReverseFill

```lua
SetReverseFill(isReverseFill: bool)
```

### SetRotatesTexture

```lua
SetRotatesTexture(rotatesTexture: bool)
```

### SetStatusBarColor

```lua
SetStatusBarColor(colorR: number, colorG: number, colorB: number, a?: SingleColorValue)
```

### SetStatusBarDesaturated

```lua
SetStatusBarDesaturated(desaturated: bool)
```

### SetStatusBarDesaturation

```lua
SetStatusBarDesaturation(desaturation: normalizedValue)
```

### SetStatusBarTexture

```lua
SetStatusBarTexture(asset: TextureAsset) -> success: bool
```

### SetTimerDuration

```lua
SetTimerDuration(duration: LuaDurationObject, interpolation: StatusBarInterpolation, direction: StatusBarTimerDirection)
```

### SetToTargetValue

```lua
SetToTargetValue()
```

### SetValue

```lua
SetValue(value: number, interpolation: StatusBarInterpolation)
```
