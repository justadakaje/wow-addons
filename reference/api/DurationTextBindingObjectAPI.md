# DurationTextBindingObjectAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`30` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### Assign

```lua
Assign(other: DurationTextBinding)
```

### CanFormatText

```lua
CanFormatText() -> canFormatText: bool
```

### CanUpdateFontString

```lua
CanUpdateFontString() -> canUpdateText: bool
```

### ClearTextColorCurve

```lua
ClearTextColorCurve()
```

### Copy

```lua
Copy() -> copy: DurationTextBinding
```

### Disable

```lua
Disable()
```

### Enable

```lua
Enable()
```

### GetDuration

```lua
GetDuration() -> duration?: LuaDurationObject
```

### GetExpiredText

```lua
GetExpiredText() -> text?: string
```

### GetFontString

```lua
GetFontString() -> fontString?: SimpleFontString
```

### GetFormattedText

```lua
GetFormattedText() -> text: string
```

### GetFormattedTextColor

```lua
GetFormattedTextColor() -> color: colorRGBA
```

### GetTextColorCurve

```lua
GetTextColorCurve() -> curve: LuaColorCurveObject, property: DurationTextBindingProperty
```

### GetTimeModifier

```lua
GetTimeModifier() -> modifier: DurationTimeModifier
```

### GetUpdateInterval

```lua
GetUpdateInterval() -> updateInterval: number
```

### GetZeroDurationText

```lua
GetZeroDurationText() -> text?: string
```

### HasSecretValues

```lua
HasSecretValues() -> hasSecretValues: bool
```

### IsEnabled

```lua
IsEnabled() -> enabled: bool
```

### SetDuration

```lua
SetDuration(duration: LuaDurationObject)
```

### SetEnabled

```lua
SetEnabled(enabled: bool)
```

### SetExpiredText

```lua
SetExpiredText(text?: string)
```

### SetFontString

```lua
SetFontString(fontString: SimpleFontString)
```

### SetFormatter

```lua
SetFormatter(formatter: NumericFormatter)
```

### SetTextColorCurve

```lua
SetTextColorCurve(curve: LuaColorCurveObject, property: DurationTextBindingProperty)
```

### SetTextFormat

```lua
SetTextFormat(formatString: stringView, components: table)
```

### SetTimeModifier

```lua
SetTimeModifier(modifier: DurationTimeModifier)
```

### SetToDefaults

```lua
SetToDefaults()
```

### SetUpdateInterval

```lua
SetUpdateInterval(updateInterval: number)
```

### SetZeroDurationText

```lua
SetZeroDurationText(text?: string)
```

### UpdateFontString

```lua
UpdateFontString()
```
