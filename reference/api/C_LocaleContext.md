# C_LocaleContext

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`22` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CompareStrings

```lua
C_LocaleContext.CompareStrings(left: cstring, right: cstring, strength: CollationStrength) -> result: number
```

### FindBreaks

```lua
C_LocaleContext.FindBreaks(text: cstring, breakType: BreakType) -> byteOffsets: table
```

### FindStringMatches

```lua
C_LocaleContext.FindStringMatches(text: cstring, pattern: cstring, strength: CollationStrength) -> byteOffsets: table
```

### FoldCase

```lua
C_LocaleContext.FoldCase(text: cstring) -> result: string
```

### FormatCurrency

```lua
C_LocaleContext.FormatCurrency(number: number, currencyCode: cstring) -> result: string
```

### FormatDate

```lua
C_LocaleContext.FormatDate(unixTimeSeconds: number, style: DateTimeStyle, timeZone: cstring) -> result: string
```

### FormatDateTime

```lua
C_LocaleContext.FormatDateTime(unixTimeSeconds: number, dateStyle: DateTimeStyle, timeStyle: DateTimeStyle, timeZone: cstring) -> result: string
```

### FormatNumber

```lua
C_LocaleContext.FormatNumber(number: number, style: NumberStyle) -> result: string
```

### FormatTime

```lua
C_LocaleContext.FormatTime(unixTimeSeconds: number, style: DateTimeStyle, timeZone: cstring) -> result: string
```

### GetCurrencyName

```lua
C_LocaleContext.GetCurrencyName(currencyCode: cstring, style: CurrencyNameStyle) -> result: string
```

### GetDisplayName

```lua
C_LocaleContext.GetDisplayName(displayLocale: cstring) -> result: string
```

### GetLocale

```lua
C_LocaleContext.GetLocale() -> result: string
```

### GetSortKey

```lua
C_LocaleContext.GetSortKey(text: cstring, strength: CollationStrength) -> result: string
```

### Length

```lua
C_LocaleContext.Length(text: cstring) -> result: number
```

### ParseCurrency

```lua
C_LocaleContext.ParseCurrency(text: cstring) -> result: CurrencyParseResult
```

### ParseNumber

```lua
C_LocaleContext.ParseNumber(text: cstring, style: NumberStyle) -> result: number
```

### SelectPlural

```lua
C_LocaleContext.SelectPlural(number: number, pluralType: PluralType) -> result: string
```

### SetLocale

```lua
C_LocaleContext.SetLocale(locale: cstring) -> success: bool
```

### ToLower

```lua
C_LocaleContext.ToLower(text: cstring) -> result: string
```

### ToTitle

```lua
C_LocaleContext.ToTitle(text: cstring) -> result: string
```

### ToUpper

```lua
C_LocaleContext.ToUpper(text: cstring) -> result: string
```

### TransformLocale

```lua
C_LocaleContext.TransformLocale(transform: LocaleTransform) -> result: string
```
