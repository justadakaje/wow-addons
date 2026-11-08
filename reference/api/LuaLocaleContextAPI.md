# LuaLocaleContextAPI

WoW: Forever 1.60.1 (build 70862) - Interface 16001

`22` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CompareStrings

```lua
CompareStrings(left: cstring, right: cstring, strength: CollationStrength) -> result: number
```

### FindBreaks

```lua
FindBreaks(text: cstring, breakType: BreakType) -> byteOffsets: table
```

### FindStringMatches

```lua
FindStringMatches(text: cstring, pattern: cstring, strength: CollationStrength) -> byteOffsets: table
```

### FoldCase

```lua
FoldCase(text: cstring) -> result: string
```

### FormatCurrency

```lua
FormatCurrency(number: number, currencyCode: cstring) -> result: string
```

### FormatDate

```lua
FormatDate(unixTimeSeconds: number, style: DateTimeStyle, timeZone: cstring) -> result: string
```

### FormatDateTime

```lua
FormatDateTime(unixTimeSeconds: number, dateStyle: DateTimeStyle, timeStyle: DateTimeStyle, timeZone: cstring) -> result: string
```

### FormatNumber

```lua
FormatNumber(number: number, style: NumberStyle) -> result: string
```

### FormatTime

```lua
FormatTime(unixTimeSeconds: number, style: DateTimeStyle, timeZone: cstring) -> result: string
```

### GetCurrencyName

```lua
GetCurrencyName(currencyCode: cstring, style: CurrencyNameStyle) -> result: string
```

### GetDisplayName

```lua
GetDisplayName(displayLocale: cstring) -> result: string
```

### GetLocale

```lua
GetLocale() -> result: string
```

### GetSortKey

```lua
GetSortKey(text: cstring, strength: CollationStrength) -> result: string
```

### Length

```lua
Length(text: cstring) -> result: number
```

### ParseCurrency

```lua
ParseCurrency(text: cstring) -> result: CurrencyParseResult
```

### ParseNumber

```lua
ParseNumber(text: cstring, style: NumberStyle) -> result: number
```

### SelectPlural

```lua
SelectPlural(number: number, pluralType: PluralType) -> result: string
```

### SetLocale

```lua
SetLocale(locale: cstring) -> success: bool
```

### ToLower

```lua
ToLower(text: cstring) -> result: string
```

### ToTitle

```lua
ToTitle(text: cstring) -> result: string
```

### ToUpper

```lua
ToUpper(text: cstring) -> result: string
```

### TransformLocale

```lua
TransformLocale(transform: LocaleTransform) -> result: string
```
