# SimpleMessageFrameAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`33` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddMessage

```lua
AddMessage(text: cstring, colorR: number, colorG: number, colorB: number, a?: SingleColorValue, messageID?: number)
```

### Clear

```lua
Clear()
```

### GetFadeDuration

```lua
GetFadeDuration() -> fadeDurationSeconds: number
```

### GetFadePower

```lua
GetFadePower() -> fadePower: number
```

### GetFading

```lua
GetFading() -> isFading: bool
```

### GetFont

```lua
GetFont() -> fontFile: cstring, height: uiFontHeight, flags: TBFFlags
```

### GetFontObject

```lua
GetFontObject() -> font: SimpleFont
```

### GetFontStringByID

```lua
GetFontStringByID(messageID: number) -> fontString: SimpleFontString
```

### GetIndentedWordWrap

```lua
GetIndentedWordWrap() -> wordWrap: bool
```

### GetInsertMode

```lua
GetInsertMode() -> mode: InsertMode
```

### GetJustifyH

```lua
GetJustifyH() -> justifyH: JustifyHorizontal
```

### GetJustifyV

```lua
GetJustifyV() -> justifyV: JustifyVertical
```

### GetShadowColor

```lua
GetShadowColor() -> colorR: number, colorG: number, colorB: number, colorA: number
```

### GetShadowOffset

```lua
GetShadowOffset() -> offsetX: number, offsetY: number
```

### GetSpacing

```lua
GetSpacing() -> spacing: uiUnit
```

### GetTextColor

```lua
GetTextColor() -> colorR: number, colorG: number, colorB: number, colorA: number
```

### GetTimeVisible

```lua
GetTimeVisible() -> timeVisibleSeconds: number
```

### HasMessageByID

```lua
HasMessageByID(messageID: number) -> hasMessage: bool
```

### ResetMessageFadeByID

```lua
ResetMessageFadeByID(messageID: number)
```

### SetFadeDuration

```lua
SetFadeDuration(fadeDurationSeconds: number)
```

### SetFadePower

```lua
SetFadePower(fadePower: number)
```

### SetFading

```lua
SetFading(fading: bool)
```

### SetFont

```lua
SetFont(fontFile: cstring, height: uiFontHeight, flags: TBFFlags)
```

### SetFontObject

```lua
SetFontObject(font: SimpleFont)
```

### SetIndentedWordWrap

```lua
SetIndentedWordWrap(wordWrap: bool)
```

### SetInsertMode

```lua
SetInsertMode(mode: InsertMode)
```

### SetJustifyH

```lua
SetJustifyH(justifyH: JustifyHorizontal)
```

### SetJustifyV

```lua
SetJustifyV(justifyV: JustifyVertical)
```

### SetShadowColor

```lua
SetShadowColor(colorR: number, colorG: number, colorB: number, a?: SingleColorValue)
```

### SetShadowOffset

```lua
SetShadowOffset(offsetX: number, offsetY: number)
```

### SetSpacing

```lua
SetSpacing(spacing: uiUnit)
```

### SetTextColor

```lua
SetTextColor(colorR: number, colorG: number, colorB: number, a?: SingleColorValue)
```

### SetTimeVisible

```lua
SetTimeVisible(timeVisibleSeconds: number)
```
