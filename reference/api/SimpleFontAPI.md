# SimpleFontAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`24` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CopyFontObject

```lua
CopyFontObject(sourceFont: SimpleFont)
```

### GetAlpha

```lua
GetAlpha() -> alpha: SingleColorValue
```

### GetFont

```lua
GetFont() -> fontFile: cstring, height: uiFontHeight, flags: TBFFlags
```

### GetFontHeight

```lua
GetFontHeight() -> height: number
```

### GetFontObject

```lua
GetFontObject() -> font: SimpleFont
```

### GetFontObjectForAlphabet

```lua
GetFontObjectForAlphabet(alphabet: FontAlphabet) -> font: SimpleFont
```

### GetIndentedWordWrap

```lua
GetIndentedWordWrap() -> wordWrap: bool
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

### SetAlpha

```lua
SetAlpha(alpha: SingleColorValue)
```

### SetFont

```lua
SetFont(fontFile: cstring, height: uiFontHeight, flags: TBFFlags)
```

### SetFontHeight

```lua
SetFontHeight(height: number)
```

### SetFontObject

```lua
SetFontObject(font: SimpleFont)
```

### SetIndentedWordWrap

```lua
SetIndentedWordWrap(wordWrap: bool)
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
