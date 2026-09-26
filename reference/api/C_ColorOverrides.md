# C_ColorOverrides

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`6` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearColorOverrides

```lua
C_ColorOverrides.ClearColorOverrides()
```

### GetColorForQuality

```lua
C_ColorOverrides.GetColorForQuality(quality: ItemQuality) -> color: colorRGBA
```

### GetColorOverrideInfo

```lua
C_ColorOverrides.GetColorOverrideInfo(overrideType: ColorOverride) -> overrideInfo?: ColorOverrideInfo
```

### GetDefaultColorForQuality

```lua
C_ColorOverrides.GetDefaultColorForQuality(quality: ItemQuality) -> color: colorRGBA
```

### RemoveColorOverride

```lua
C_ColorOverrides.RemoveColorOverride(overrideType: ColorOverride)
```

### SetColorOverride

```lua
C_ColorOverrides.SetColorOverride(overrideType: ColorOverride, color: colorRGBA)
```

## Events

### ColorOverridesReset

Fires as `COLOR_OVERRIDES_RESET`.

No payload.

### ColorOverrideUpdated

Fires as `COLOR_OVERRIDE_UPDATED`.

```lua
payload: overrideType: ColorOverride
```
