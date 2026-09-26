# UnitHealPredictionCalculatorAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`35` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### EvaluateCurrentHealthPercent

```lua
EvaluateCurrentHealthPercent(curve: LuaCurveObjectBase) -> result: LuaCurveEvaluatedResult
```

### EvaluateMissingHealthPercent

```lua
EvaluateMissingHealthPercent(curve: LuaCurveObjectBase) -> result: LuaCurveEvaluatedResult
```

### GetCurrentHealth

```lua
GetCurrentHealth() -> currentHealth: number
```

### GetCurrentHealthPercent

```lua
GetCurrentHealthPercent() -> currentHealthPercent: number
```

### GetDamageAbsorbClampMode

```lua
GetDamageAbsorbClampMode() -> damageAbsorbClampMode: UnitDamageAbsorbClampMode
```

### GetDamageAbsorbs

```lua
GetDamageAbsorbs() -> amount: number, clamped: bool
```

### GetHealAbsorbClampMode

```lua
GetHealAbsorbClampMode() -> healAbsorbClampMode: UnitHealAbsorbClampMode
```

### GetHealAbsorbMode

```lua
GetHealAbsorbMode() -> healAbsorbMode: UnitHealAbsorbMode
```

### GetHealAbsorbs

```lua
GetHealAbsorbs() -> amount: number, clamped: bool
```

### GetIncomingHealClampMode

```lua
GetIncomingHealClampMode() -> incomingHealClampMode: UnitIncomingHealClampMode
```

### GetIncomingHealOverflowPercent

```lua
GetIncomingHealOverflowPercent() -> incomingHealOverflowPercent: number
```

### GetIncomingHeals

```lua
GetIncomingHeals() -> amount: number, amountFromHealer: number, amountFromOthers: number, clamped: bool
```

### GetMaximumDamageAbsorbs

```lua
GetMaximumDamageAbsorbs() -> maximumDamageAbsorbs: number
```

### GetMaximumHealAbsorbs

```lua
GetMaximumHealAbsorbs() -> maximumHealAbsorbs: number
```

### GetMaximumHealth

```lua
GetMaximumHealth() -> maximumHealth: number
```

### GetMaximumHealthMode

```lua
GetMaximumHealthMode() -> maximumHealthMode: UnitMaximumHealthMode
```

### GetMaximumIncomingHeals

```lua
GetMaximumIncomingHeals() -> maximumIncomingHeals: number
```

### GetMissingHealth

```lua
GetMissingHealth() -> missingHealth: number
```

### GetMissingHealthPercent

```lua
GetMissingHealthPercent() -> missingHealthPercent: number
```

### GetPredictedValues

```lua
GetPredictedValues() -> predictedValues: UnitHealPredictionValues
```

### GetTotalDamageAbsorbs

```lua
GetTotalDamageAbsorbs() -> totalDamageAbsorbs: number
```

### GetTotalHealAbsorbs

```lua
GetTotalHealAbsorbs() -> totalHealAbsorbs: number
```

### GetTotalIncomingHeals

```lua
GetTotalIncomingHeals() -> totalIncomingHeals: number
```

### GetTotalIncomingHealsFromHealer

```lua
GetTotalIncomingHealsFromHealer() -> totalIncomingHealsFromHealer: number
```

### HasSecretValues

```lua
HasSecretValues() -> hasSecretValues: bool
```

### Reset

```lua
Reset()
```

### ResetPredictedValues

```lua
ResetPredictedValues()
```

### SetDamageAbsorbClampMode

```lua
SetDamageAbsorbClampMode(damageAbsorbClampMode: UnitDamageAbsorbClampMode)
```

### SetHealAbsorbClampMode

```lua
SetHealAbsorbClampMode(healAbsorbClampMode: UnitHealAbsorbClampMode)
```

### SetHealAbsorbMode

```lua
SetHealAbsorbMode(healAbsorbMode: UnitHealAbsorbMode)
```

### SetIncomingHealClampMode

```lua
SetIncomingHealClampMode(incomingHealClampMode: UnitIncomingHealClampMode)
```

### SetIncomingHealOverflowPercent

```lua
SetIncomingHealOverflowPercent(incomingHealOverflowPercent: number)
```

### SetMaximumHealthMode

```lua
SetMaximumHealthMode(maximumHealthMode: UnitMaximumHealthMode)
```

### SetPredictedValues

```lua
SetPredictedValues(predictedValues: UnitHealPredictionValues)
```

### SetToDefaults

```lua
SetToDefaults()
```
