# FrameAPICooldown

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`46` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### Clear

```lua
Clear()
```

### GetCooldownDisplayDuration

```lua
GetCooldownDisplayDuration() -> duration: number
```

### GetCooldownDuration

```lua
GetCooldownDuration() -> duration: number
```

### GetCooldownTimes

```lua
GetCooldownTimes() -> start: number, duration: number
```

### GetCountdownAbbrevThreshold

```lua
GetCountdownAbbrevThreshold() -> seconds: Seconds
```

### GetCountdownFontString

```lua
GetCountdownFontString() -> countdownString: SimpleFontString
```

### GetCountdownFormatter

```lua
GetCountdownFormatter() -> formatter?: NumericFormatter
```

### GetCountdownMillisecondsThreshold

```lua
GetCountdownMillisecondsThreshold() -> seconds: Seconds
```

### GetDrawBling

```lua
GetDrawBling() -> drawBling: bool
```

### GetDrawEdge

```lua
GetDrawEdge() -> drawEdge: bool
```

### GetDrawSwipe

```lua
GetDrawSwipe() -> drawSwipe: bool
```

### GetEdgeScale

```lua
GetEdgeScale() -> edgeScale: number
```

### GetHideCountdownNumbers

```lua
GetHideCountdownNumbers() -> hideNumbers: bool
```

### GetMinimumCountdownDuration

```lua
GetMinimumCountdownDuration() -> milliseconds: Milliseconds
```

### GetReverse

```lua
GetReverse() -> reverse: bool
```

### GetRotation

```lua
GetRotation() -> rotationRadians: number
```

### GetUseAuraDisplayTime

```lua
GetUseAuraDisplayTime() -> useAuraDisplayTime: bool
```

### IsPaused

```lua
IsPaused() -> isPaused: bool
```

### Pause

```lua
Pause()
```

### Resume

```lua
Resume()
```

### SetBlingTexture

```lua
SetBlingTexture(texture: FileAsset, colorR: number, colorG: number, colorB: number, colorA: number)
```

### SetCooldown

```lua
SetCooldown(start: Seconds, duration: Seconds, modRate: number)
```

### SetCooldownDuration

```lua
SetCooldownDuration(duration: Seconds, modRate: number)
```

### SetCooldownFromDurationObject

```lua
SetCooldownFromDurationObject(duration: LuaDurationObject, clearIfZero: bool)
```

### SetCooldownFromExpirationTime

```lua
SetCooldownFromExpirationTime(expirationTime: Seconds, duration: Seconds, modRate: number)
```

### SetCooldownUNIX

```lua
SetCooldownUNIX(start: number, duration: number, modRate: number)
```

### SetCountdownAbbrevThreshold

```lua
SetCountdownAbbrevThreshold(seconds: Seconds)
```

### SetCountdownFont

```lua
SetCountdownFont(fontName: cstring)
```

### SetCountdownFormatter

```lua
SetCountdownFormatter(formatter?: NumericFormatter)
```

### SetCountdownMillisecondsThreshold

```lua
SetCountdownMillisecondsThreshold(seconds: Seconds)
```

### SetDrawBling

```lua
SetDrawBling(drawBling: bool)
```

### SetDrawEdge

```lua
SetDrawEdge(drawEdge: bool)
```

### SetDrawSwipe

```lua
SetDrawSwipe(drawSwipe: bool)
```

### SetEdgeColor

```lua
SetEdgeColor(colorR: number, colorG: number, colorB: number, a?: SingleColorValue)
```

### SetEdgeScale

```lua
SetEdgeScale(scale: number)
```

### SetEdgeTexture

```lua
SetEdgeTexture(texture: FileAsset, colorR: number, colorG: number, colorB: number, colorA: number)
```

### SetHideCountdownNumbers

```lua
SetHideCountdownNumbers(hideNumbers: bool)
```

### SetMinimumCountdownDuration

```lua
SetMinimumCountdownDuration(milliseconds: Milliseconds)
```

### SetPaused

```lua
SetPaused(paused: bool)
```

### SetReverse

```lua
SetReverse(reverse: bool)
```

### SetRotation

```lua
SetRotation(rotationRadians: number)
```

### SetSwipeColor

```lua
SetSwipeColor(colorR: number, colorG: number, colorB: number, a?: SingleColorValue)
```

### SetSwipeTexture

```lua
SetSwipeTexture(texture?: FileAsset, colorR: number, colorG: number, colorB: number, colorA: number)
```

### SetTexCoordRange

```lua
SetTexCoordRange(low: vector2, high: vector2)
```

### SetUseAuraDisplayTime

```lua
SetUseAuraDisplayTime(useAuraDisplayTime: bool)
```

### SetUseCircularEdge

```lua
SetUseCircularEdge(useCircularEdge: bool)
```
