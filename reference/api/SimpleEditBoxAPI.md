# SimpleEditBoxAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`79` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddHistoryLine

```lua
AddHistoryLine(text: cstring)
```

### ClearFocus

```lua
ClearFocus()
```

### ClearHighlightText

```lua
ClearHighlightText()
```

### ClearHistory

```lua
ClearHistory()
```

### Disable

```lua
Disable()
```

### Enable

```lua
Enable()
```

### GetAltArrowKeyMode

```lua
GetAltArrowKeyMode() -> altMode: bool
```

### GetBlinkSpeed

```lua
GetBlinkSpeed() -> cursorBlinkSpeedSec: number
```

### GetCursorPosition

```lua
GetCursorPosition() -> cursorPosition: number
```

### GetDisplayText

```lua
GetDisplayText() -> displayText: string
```

### GetFont

```lua
GetFont() -> name: cstring, fontHeight: uiUnit, flags: TBFFlags
```

### GetFontObject

```lua
GetFontObject() -> font: SimpleFont
```

### GetHighlightColor

```lua
GetHighlightColor() -> colorR: number, colorG: number, colorB: number, colorA: number
```

### GetHistoryLines

```lua
GetHistoryLines() -> numHistoryLines: number
```

### GetIndentedWordWrap

```lua
GetIndentedWordWrap() -> isIndented: bool
```

### GetInputLanguage

```lua
GetInputLanguage() -> language: cstring
```

### GetJustifyH

```lua
GetJustifyH() -> justifyH: JustifyHorizontal
```

### GetJustifyV

```lua
GetJustifyV() -> justifyV: JustifyVertical
```

### GetMaxBytes

```lua
GetMaxBytes() -> maxBytes: number
```

### GetMaxLetters

```lua
GetMaxLetters() -> maxLetters: number
```

### GetNumber

```lua
GetNumber() -> number?: number
```

### GetNumLetters

```lua
GetNumLetters() -> numLetters: number
```

### GetNumLines

```lua
GetNumLines() -> lines: number
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
GetSpacing() -> fontHeight: uiUnit
```

### GetText

```lua
GetText() -> text: cstring
```

### GetTextColor

```lua
GetTextColor() -> colorR: number, colorG: number, colorB: number, colorA: number
```

### GetTextInsets

```lua
GetTextInsets() -> left: uiUnit, right: uiUnit, top: uiUnit, bottom: uiUnit
```

### GetUTF8CursorPosition

```lua
GetUTF8CursorPosition() -> cursorPosition: number
```

### GetVisibleTextByteLimit

```lua
GetVisibleTextByteLimit() -> maxVisibleBytes: number
```

### HasFocus

```lua
HasFocus() -> hasFocus: bool
```

### HasText

```lua
HasText() -> hasText: bool
```

### HighlightText

```lua
HighlightText(start: number, stop: number)
```

### Insert

```lua
Insert(text: cstring)
```

### IsAlphabeticOnly

```lua
IsAlphabeticOnly() -> enabled: bool
```

### IsAutoFocus

```lua
IsAutoFocus() -> autoFocus: bool
```

### IsCountInvisibleLetters

```lua
IsCountInvisibleLetters() -> countInvisibleLetters: bool
```

### IsEnabled

```lua
IsEnabled() -> isEnabled: bool
```

### IsInIMECompositionMode

```lua
IsInIMECompositionMode() -> isInIMECompositionMode: bool
```

### IsMultiLine

```lua
IsMultiLine() -> multiline: bool
```

### IsNumeric

```lua
IsNumeric() -> isNumeric: bool
```

### IsNumericFullRange

```lua
IsNumericFullRange() -> isNumeric: bool
```

### IsPassword

```lua
IsPassword() -> isPassword: bool
```

### IsSecureText

```lua
IsSecureText() -> isSecure: bool
```

### ResetInputMode

```lua
ResetInputMode()
```

### SetAlphabeticOnly

```lua
SetAlphabeticOnly(enabled: bool)
```

### SetAltArrowKeyMode

```lua
SetAltArrowKeyMode(altMode: bool)
```

### SetAutoFocus

```lua
SetAutoFocus(autoFocus: bool)
```

### SetBlinkSpeed

```lua
SetBlinkSpeed(cursorBlinkSpeedSec: number)
```

### SetCountInvisibleLetters

```lua
SetCountInvisibleLetters(countInvisibleLetters: bool)
```

### SetCursorPosition

```lua
SetCursorPosition(cursorPosition: number)
```

### SetEnabled

```lua
SetEnabled(enabled: bool)
```

### SetFocus

```lua
SetFocus()
```

### SetFont

```lua
SetFont(fontFile: cstring, height: uiFontHeight, flags: TBFFlags) -> success: bool
```

### SetFontObject

```lua
SetFontObject(font: SimpleFont)
```

### SetHighlightColor

```lua
SetHighlightColor(colorR: number, colorG: number, colorB: number, a?: SingleColorValue)
```

### SetHistoryLines

```lua
SetHistoryLines(numHistoryLines: number)
```

### SetIndentedWordWrap

```lua
SetIndentedWordWrap(isIndented: bool)
```

### SetJustifyH

```lua
SetJustifyH(justifyH: JustifyHorizontal)
```

### SetJustifyV

```lua
SetJustifyV(justifyV: JustifyVertical)
```

### SetMaxBytes

```lua
SetMaxBytes(maxBytes: number)
```

### SetMaxLetters

```lua
SetMaxLetters(maxLetters: number)
```

### SetMultiLine

```lua
SetMultiLine(multiline: bool)
```

### SetNumber

```lua
SetNumber(number: number)
```

### SetNumeric

```lua
SetNumeric(isNumeric: bool)
```

### SetNumericFullRange

```lua
SetNumericFullRange(isNumeric: bool)
```

### SetPassword

```lua
SetPassword(isPassword: bool)
```

### SetSecureText

```lua
SetSecureText(isSecure: bool)
```

### SetSecurityDisablePaste

```lua
SetSecurityDisablePaste()
```

### SetSecurityDisableSetText

```lua
SetSecurityDisableSetText()
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
SetSpacing(fontHeight: uiUnit)
```

### SetText

```lua
SetText(text: cstring)
```

### SetTextColor

```lua
SetTextColor(colorR: number, colorG: number, colorB: number, a?: SingleColorValue)
```

### SetTextInsets

```lua
SetTextInsets(left: uiUnit, right: uiUnit, top: uiUnit, bottom: uiUnit)
```

### SetVisibleTextByteLimit

```lua
SetVisibleTextByteLimit(maxVisibleBytes: number)
```

### ToggleInputLanguage

```lua
ToggleInputLanguage()
```
