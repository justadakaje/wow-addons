# C_Intl

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`27` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CompareStrings

```lua
C_Intl.CompareStrings(left: cstring, right: cstring, strength: CollationStrength) -> result: number
```

### CreateLocaleContext

```lua
C_Intl.CreateLocaleContext(locale: cstring) -> context: LuaLocaleContext
```

### FindBreaks

```lua
C_Intl.FindBreaks(text: cstring, breakType: BreakType) -> byteOffsets: table
```

### FindStringMatches

```lua
C_Intl.FindStringMatches(text: cstring, pattern: cstring, strength: CollationStrength) -> byteOffsets: table
```

### FoldCase

```lua
C_Intl.FoldCase(text: cstring) -> result: string
```

### FormatCurrency

```lua
C_Intl.FormatCurrency(number: number, currencyCode: cstring) -> result: string
```

### FormatDate

```lua
C_Intl.FormatDate(unixTimeSeconds: number, style: DateTimeStyle, timeZone: cstring) -> result: string
```

### FormatDateTime

```lua
C_Intl.FormatDateTime(unixTimeSeconds: number, dateStyle: DateTimeStyle, timeStyle: DateTimeStyle, timeZone: cstring) -> result: string
```

### FormatNumber

```lua
C_Intl.FormatNumber(number: number, style: NumberStyle) -> result: string
```

### FormatTime

```lua
C_Intl.FormatTime(unixTimeSeconds: number, style: DateTimeStyle, timeZone: cstring) -> result: string
```

### GetCharacterProperties

```lua
C_Intl.GetCharacterProperties(text: cstring) -> result: CharacterProperties
```

### GetCurrencyFractionDigits

```lua
C_Intl.GetCurrencyFractionDigits(currencyCode: cstring) -> result: number
```

### GetCurrencyName

```lua
C_Intl.GetCurrencyName(currencyCode: cstring, nameStyle: CurrencyNameStyle) -> result: string
```

### GetCurrentLocale

```lua
C_Intl.GetCurrentLocale() -> result: cstring
```

### GetDisplayName

```lua
C_Intl.GetDisplayName(displayLocale: cstring) -> result: string
```

### GetSortKey

```lua
C_Intl.GetSortKey(text: cstring, strength: CollationStrength) -> sortKey: string
```

### IsNormalized

```lua
C_Intl.IsNormalized(text: cstring, form: NormalizationForm) -> isNormalized: bool
```

### Length

```lua
C_Intl.Length(text: cstring) -> result: number
```

### Normalize

```lua
C_Intl.Normalize(text: cstring, form: NormalizationForm) -> result: string
```

### ParseCurrency

```lua
C_Intl.ParseCurrency(text: cstring) -> result: CurrencyParseResult
```

### ParseNumber

```lua
C_Intl.ParseNumber(text: cstring, style: NumberStyle) -> result: number
```

### SelectPlural

```lua
C_Intl.SelectPlural(number: number, pluralType: PluralType) -> result: string
```

### ToLower

```lua
C_Intl.ToLower(text: cstring) -> result: string
```

### ToTitle

```lua
C_Intl.ToTitle(text: cstring) -> result: string
```

### ToUpper

```lua
C_Intl.ToUpper(text: cstring) -> result: string
```

### TransformLocale

```lua
C_Intl.TransformLocale(transform: LocaleTransform) -> result: string
```

### Transliterate

```lua
C_Intl.Transliterate(text: cstring, transliteratorID: cstring) -> result: string
```
