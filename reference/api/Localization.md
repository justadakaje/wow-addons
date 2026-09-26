# Localization

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`11` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AbbreviateLargeNumbers

```lua
AbbreviateLargeNumbers(number: number, options?: NumberAbbrevOptions) -> result: string
```

### AbbreviateNumbers

```lua
AbbreviateNumbers(number: number, options?: NumberAbbrevOptions) -> result: string
```

### BreakUpLargeNumbers

```lua
BreakUpLargeNumbers(largeNumber: number, natural: bool) -> result: string
```

### CaseAccentInsensitiveParse

```lua
CaseAccentInsensitiveParse(name: cstring) -> result: string
```

### CreateAbbreviateConfig

```lua
CreateAbbreviateConfig(data: table) -> config: AbbreviateConfig
```

### DeclineName

```lua
DeclineName(name: cstring, gender?: UnitSex, declensionSet: luaIndex, namePartType?: NamePartType) -> declinedNames: string
```

### GetDefaultAbbreviationBreakpoints

```lua
GetDefaultAbbreviationBreakpoints(locale?: WowLocale) -> breakpoints: table
```

### GetNumDeclensionSets

```lua
GetNumDeclensionSets(name: cstring, gender?: UnitSex, namePartType?: NamePartType) -> numDeclensionSets: number
```

### IsEuropeanNumbers

```lua
IsEuropeanNumbers() -> enabled: bool
```

### LocalizedClassList

```lua
LocalizedClassList(isFemale: bool) -> result: LuaValueVariant
```

### SetEuropeanNumbers

```lua
SetEuropeanNumbers(enabled: bool)
```
