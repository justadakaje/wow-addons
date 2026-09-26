# SecondsFormatterAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`35` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanApproximate

```lua
CanApproximate(seconds: Seconds) -> canApproximate: bool
```

### CanRoundUpIntervals

```lua
CanRoundUpIntervals() -> canRound: bool
```

### CanRoundUpLastUnit

```lua
CanRoundUpLastUnit() -> canRound: bool
```

### EvaluateDesiredUnitCount

```lua
EvaluateDesiredUnitCount(seconds: Seconds) -> count: number
```

### EvaluateMaxInterval

```lua
EvaluateMaxInterval(seconds: Seconds) -> interval: SecondsFormatterInterval
```

### EvaluateMinInterval

```lua
EvaluateMinInterval(seconds: Seconds) -> interval: SecondsFormatterInterval
```

### Format

```lua
Format(seconds: Seconds, abbreviation?: SecondsFormatterAbbreviation) -> formattedSeconds: string
```

### FormatZero

```lua
FormatZero(abbreviation?: SecondsFormatterAbbreviation) -> formattedSeconds: string
```

### GetApproximationSeconds

```lua
GetApproximationSeconds() -> approximationSeconds: Seconds
```

### GetConvertToLower

```lua
GetConvertToLower() -> convert: bool
```

### GetDefaultAbbreviation

```lua
GetDefaultAbbreviation() -> abbreviation?: SecondsFormatterAbbreviation
```

### GetDesiredUnitCount

```lua
GetDesiredUnitCount() -> count?: number
```

### GetDesiredUnitCountCurve

```lua
GetDesiredUnitCountCurve() -> curve?: LuaCurveObject
```

### GetMaxInterval

```lua
GetMaxInterval() -> interval?: SecondsFormatterInterval
```

### GetMaxIntervalCurve

```lua
GetMaxIntervalCurve() -> curve?: LuaCurveObject
```

### GetMillisecondsThreshold

```lua
GetMillisecondsThreshold() -> threshold: Seconds
```

### GetMinInterval

```lua
GetMinInterval() -> interval?: SecondsFormatterInterval
```

### GetMinIntervalCurve

```lua
GetMinIntervalCurve() -> curve?: LuaCurveObject
```

### GetRounding

```lua
GetRounding() -> rounding: SecondsFormatterRounding
```

### GetStripIntervalWhitespace

```lua
GetStripIntervalWhitespace() -> strip: SecondsFormatterIntervalWhitespace
```

### Reset

```lua
Reset()
```

### SetApproximationSeconds

```lua
SetApproximationSeconds(seconds: Seconds)
```

### SetCanRoundUpIntervals

```lua
SetCanRoundUpIntervals(canRound: bool)
```

### SetCanRoundUpLastUnit

```lua
SetCanRoundUpLastUnit(canRound: bool)
```

### SetConvertToLower

```lua
SetConvertToLower(convert: bool)
```

### SetDefaultAbbreviation

```lua
SetDefaultAbbreviation(abbreviation: SecondsFormatterAbbreviation)
```

### SetDesiredUnitCount

```lua
SetDesiredUnitCount(count: number)
```

### SetDesiredUnitCountCurve

```lua
SetDesiredUnitCountCurve(curve: LuaCurveObject)
```

### SetMaxInterval

```lua
SetMaxInterval(interval: SecondsFormatterInterval)
```

### SetMaxIntervalCurve

```lua
SetMaxIntervalCurve(curve: LuaCurveObject)
```

### SetMillisecondsThreshold

```lua
SetMillisecondsThreshold(threshold: Seconds)
```

### SetMinInterval

```lua
SetMinInterval(interval: SecondsFormatterInterval)
```

### SetMinIntervalCurve

```lua
SetMinIntervalCurve(curve: LuaCurveObject)
```

### SetRounding

```lua
SetRounding(rounding: SecondsFormatterRounding)
```

### SetStripIntervalWhitespace

```lua
SetStripIntervalWhitespace(strip: SecondsFormatterIntervalWhitespace)
```
