# SimpleFontStringAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`57` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CalculateScreenAreaFromCharacterSpan

```lua
CalculateScreenAreaFromCharacterSpan(leftIndex: luaIndex, rightIndex: luaIndex) -> areas?: table
```

### CanNonSpaceWrap

```lua
CanNonSpaceWrap() -> wrap: bool
```

### CanWordWrap

```lua
CanWordWrap() -> wrap: bool
```

### ClearAlphaGradient

```lua
ClearAlphaGradient()
```

### ClearText

```lua
ClearText()
```

### FindCharacterIndexAtCoordinate

```lua
FindCharacterIndexAtCoordinate(x: uiUnit, y: uiUnit) -> characterIndex: luaIndex, inside: bool
```

### GetAlphaGradient

```lua
GetAlphaGradient() -> start: number, length: number
```

### GetFieldSize

```lua
GetFieldSize() -> fieldSize: number
```

### GetFont

```lua
GetFont() -> fontFile?: FontAsset, fontHeight: uiUnit, flags: TBFFlags
```

### GetFontHeight

```lua
GetFontHeight(calculated: bool) -> height: uiUnit
```

### GetFontObject

```lua
GetFontObject() -> font: SimpleFont
```

### GetIndentedWordWrap

```lua
GetIndentedWordWrap() -> wrap: bool
```

### GetJustifyH

```lua
GetJustifyH() -> justifyH: JustifyHorizontal
```

### GetJustifyV

```lua
GetJustifyV() -> justifyV: JustifyVertical
```

### GetLineHeight

```lua
GetLineHeight() -> lineHeight: uiUnit
```

### GetMaxLines

```lua
GetMaxLines() -> maxLines: number
```

### GetNumLines

```lua
GetNumLines() -> numLines: number
```

### GetRotation

```lua
GetRotation() -> radians: number
```

### GetScaleAnimationMode

```lua
GetScaleAnimationMode() -> scaleAnimationMode: FontStringScaleAnimationMode
```

### GetShadowColor

```lua
GetShadowColor() -> colorR: number, colorG: number, colorB: number, colorA: number
```

### GetShadowOffset

```lua
GetShadowOffset() -> offsetX: number, offsetY: number
```

### GetSmoothScaling

```lua
GetSmoothScaling() -> smoothScaling: bool
```

### GetSpacing

```lua
GetSpacing() -> spacing: uiUnit
```

### GetStringHeight

```lua
GetStringHeight() -> height: uiUnit
```

### GetStringWidth

```lua
GetStringWidth() -> width: uiUnit
```

### GetText

```lua
GetText() -> text: cstring
```

### GetTextColor

```lua
GetTextColor() -> colorR: number, colorG: number, colorB: number, colorA: number
```

### GetTextScale

```lua
GetTextScale() -> textScale: number
```

### GetUnboundedStringWidth

```lua
GetUnboundedStringWidth() -> width: uiUnit
```

### GetUnboundedStringWidthForText

```lua
GetUnboundedStringWidthForText(text: cstring) -> width: uiUnit
```

### GetWrappedWidth

```lua
GetWrappedWidth() -> width: uiUnit
```

### IsTruncated

```lua
IsTruncated() -> isTruncated: bool
```

### OnColorsUpdated

```lua
OnColorsUpdated()
```

### SetAlphaGradient

```lua
SetAlphaGradient(start: number, length: number) -> isWithinText: bool
```

### SetDesaturateEmbeddedTextures

```lua
SetDesaturateEmbeddedTextures(desaturate: bool)
```

### SetFixedColor

```lua
SetFixedColor(fixedColor: bool)
```

### SetFont

```lua
SetFont(fontFile: FontAsset, fontHeight: uiFontHeight, flags?: TBFFlags) -> success: bool
```

### SetFontHeight

```lua
SetFontHeight(height: uiUnit)
```

### SetFontObject

```lua
SetFontObject(font: SimpleFont)
```

### SetFormattedText

```lua
SetFormattedText(text: cstring)
```

### SetIndentedWordWrap

```lua
SetIndentedWordWrap(wrap: bool)
```

### SetJustifyH

```lua
SetJustifyH(justifyH: JustifyHorizontal)
```

### SetJustifyV

```lua
SetJustifyV(justifyV: JustifyVertical)
```

### SetMaxLines

```lua
SetMaxLines(maxLines: number)
```

### SetNonSpaceWrap

```lua
SetNonSpaceWrap(wrap: bool)
```

### SetRotation

```lua
SetRotation(radians: number)
```

### SetScaleAnimationMode

```lua
SetScaleAnimationMode(scaleAnimationMode: FontStringScaleAnimationMode)
```

### SetShadowColor

```lua
SetShadowColor(colorR: number, colorG: number, colorB: number, a?: SingleColorValue)
```

### SetShadowOffset

```lua
SetShadowOffset(offsetX: number, offsetY: number)
```

### SetSmoothScaling

```lua
SetSmoothScaling(smoothScaling: bool)
```

### SetSpacing

```lua
SetSpacing(spacing: uiUnit)
```

### SetText

```lua
SetText(text: cstring)
```

### SetTextColor

```lua
SetTextColor(colorR: number, colorG: number, colorB: number, a?: SingleColorValue)
```

### SetTextHeight

```lua
SetTextHeight(height: uiUnit)
```

### SetTextScale

```lua
SetTextScale(textScale: number)
```

### SetTextToFit

```lua
SetTextToFit(text: cstring)
```

### SetWordWrap

```lua
SetWordWrap(wrap: bool)
```
