# C_StringUtil

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`14` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CreateAbbreviatedNumberFormatter

```lua
C_StringUtil.CreateAbbreviatedNumberFormatter() -> formatter: AbbreviatedNumberFormatter
```

### CreateNumericRuleFormatter

```lua
C_StringUtil.CreateNumericRuleFormatter() -> formatter: NumericRuleFormatter
```

### CreateSecondsFormatter

```lua
C_StringUtil.CreateSecondsFormatter() -> formatter: SecondsFormatter
```

### EscapeDecimalNonPrintables

```lua
C_StringUtil.EscapeDecimalNonPrintables(text: stringView) -> escapedText: string
```

### EscapeLuaFormatString

```lua
C_StringUtil.EscapeLuaFormatString(text: string) -> escapedText: stringView
```

### EscapeLuaPatterns

```lua
C_StringUtil.EscapeLuaPatterns(text: stringView) -> escapedText: string
```

### EscapeQuotedCodes

```lua
C_StringUtil.EscapeQuotedCodes(text: string) -> escaped: stringView
```

### FloorToNearestString

```lua
C_StringUtil.FloorToNearestString(number: number) -> text: string
```

### RemoveContiguousSpaces

```lua
C_StringUtil.RemoveContiguousSpaces(text: stringView, maxAllowedSpaces: number) -> trimmedText: string
```

### RoundToNearestString

```lua
C_StringUtil.RoundToNearestString(number: number) -> text: string
```

### StripHyperlinks

```lua
C_StringUtil.StripHyperlinks(text: string, maintainColor: bool, maintainBrackets: bool, stripNewlines: bool, maintainAtlases: bool, maintainTextures: bool) -> stripped: stringView
```

### StripTextureMarkupForLooseFiles

```lua
C_StringUtil.StripTextureMarkupForLooseFiles(text: string) -> stripped: stringView
```

### TruncateWhenZero

```lua
C_StringUtil.TruncateWhenZero(number: number) -> text: string
```

### WrapString

```lua
C_StringUtil.WrapString(infix: stringView, prefix?: stringView, suffix?: stringView) -> text: string
```
