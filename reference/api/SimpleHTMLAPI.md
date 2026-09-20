# SimpleHTMLAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`23` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetContentHeight

```lua
GetContentHeight() -> height: uiUnit
```

### GetFont

```lua
GetFont(textType: HTMLTextType) -> fontFile: cstring, height: uiFontHeight, flags: TBFFlags
```

### GetFontObject

```lua
GetFontObject(textType: HTMLTextType) -> font: SimpleFont
```

### GetHyperlinkFormat

```lua
GetHyperlinkFormat() -> format: cstring
```

### GetIndentedWordWrap

```lua
GetIndentedWordWrap(textType: HTMLTextType) -> wordWrap: bool
```

### GetJustifyH

```lua
GetJustifyH(textType: HTMLTextType) -> justifyH: JustifyHorizontal
```

### GetJustifyV

```lua
GetJustifyV(textType: HTMLTextType) -> justifyV: JustifyVertical
```

### GetShadowColor

```lua
GetShadowColor(textType: HTMLTextType) -> colorR: number, colorG: number, colorB: number, colorA: number
```

### GetShadowOffset

```lua
GetShadowOffset(textType: HTMLTextType) -> offsetX: number, offsetY: number
```

### GetSpacing

```lua
GetSpacing(textType: HTMLTextType) -> spacing: uiUnit
```

### GetTextColor

```lua
GetTextColor(textType: HTMLTextType) -> colorR: number, colorG: number, colorB: number, colorA: number
```

### GetTextData

```lua
GetTextData() -> content: table
```

### SetFont

```lua
SetFont(textType: HTMLTextType, fontFile: cstring, height: uiFontHeight, flags: TBFFlags)
```

### SetFontObject

```lua
SetFontObject(textType: HTMLTextType, font: SimpleFont)
```

### SetHyperlinkFormat

```lua
SetHyperlinkFormat(format: cstring)
```

### SetIndentedWordWrap

```lua
SetIndentedWordWrap(textType: HTMLTextType, wordWrap: bool)
```

### SetJustifyH

```lua
SetJustifyH(textType: HTMLTextType, justifyH: JustifyHorizontal)
```

### SetJustifyV

```lua
SetJustifyV(textType: HTMLTextType, justifyV: JustifyVertical)
```

### SetShadowColor

```lua
SetShadowColor(textType: HTMLTextType, colorR: number, colorG: number, colorB: number, a?: SingleColorValue)
```

### SetShadowOffset

```lua
SetShadowOffset(textType: HTMLTextType, offsetX: number, offsetY: number)
```

### SetSpacing

```lua
SetSpacing(textType: HTMLTextType, spacing: uiUnit)
```

### SetText

```lua
SetText(text: cstring, ignoreMarkup: bool)
```

### SetTextColor

```lua
SetTextColor(textType: HTMLTextType, colorR: number, colorG: number, colorB: number, a?: SingleColorValue)
```
