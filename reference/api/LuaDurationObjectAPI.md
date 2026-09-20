# LuaDurationObjectAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`31` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### Assign

```lua
Assign(other: LuaDurationObject)
```

### Copy

```lua
Copy() -> copy: LuaDurationObject
```

### EvaluateElapsedDuration

```lua
EvaluateElapsedDuration(curve: LuaCurveObjectBase, modifier: DurationTimeModifier) -> result: LuaCurveEvaluatedResult
```

### EvaluateElapsedPercent

```lua
EvaluateElapsedPercent(curve: LuaCurveObjectBase, modifier: DurationTimeModifier) -> result: LuaCurveEvaluatedResult
```

### EvaluateRemainingDuration

```lua
EvaluateRemainingDuration(curve: LuaCurveObjectBase, modifier: DurationTimeModifier) -> result: LuaCurveEvaluatedResult
```

### EvaluateRemainingPercent

```lua
EvaluateRemainingPercent(curve: LuaCurveObjectBase, modifier: DurationTimeModifier) -> result: LuaCurveEvaluatedResult
```

### EvaluateTotalDuration

```lua
EvaluateTotalDuration(curve: LuaCurveObjectBase, modifier: DurationTimeModifier) -> result: LuaCurveEvaluatedResult
```

### FormatElapsedDuration

```lua
FormatElapsedDuration(formatter: NumericFormatter, modifier: DurationTimeModifier) -> formatted: string
```

### FormatRemainingDuration

```lua
FormatRemainingDuration(formatter: NumericFormatter, modifier: DurationTimeModifier) -> formatted: string
```

### FormatTotalDuration

```lua
FormatTotalDuration(formatter: NumericFormatter, modifier: DurationTimeModifier) -> formatted: string
```

### GetClock

```lua
GetClock() -> clock?: LuaDurationClock
```

### GetClockTime

```lua
GetClockTime() -> clockTime: FrameTime
```

### GetElapsedDuration

```lua
GetElapsedDuration(modifier: DurationTimeModifier) -> elapsedDuration: Seconds
```

### GetElapsedPercent

```lua
GetElapsedPercent(modifier: DurationTimeModifier) -> elapsedPercent: number
```

### GetEndTime

```lua
GetEndTime(modifier: DurationTimeModifier) -> endTime: FrameTime
```

### GetModRate

```lua
GetModRate() -> modRate: number
```

### GetRemainingDuration

```lua
GetRemainingDuration(modifier: DurationTimeModifier) -> remainingDuration: Seconds
```

### GetRemainingPercent

```lua
GetRemainingPercent(modifier: DurationTimeModifier) -> remainingPercent: number
```

### GetStartTime

```lua
GetStartTime(modifier: DurationTimeModifier) -> startTime: FrameTime
```

### GetTotalDuration

```lua
GetTotalDuration(modifier: DurationTimeModifier) -> totalDuration: Seconds
```

### HasExpired

```lua
HasExpired(modifier: DurationTimeModifier) -> hasExpired: bool
```

### HasSecretValues

```lua
HasSecretValues() -> hasSecretValues: bool
```

### HasStarted

```lua
HasStarted(modifier: DurationTimeModifier) -> hasStarted: bool
```

### IsActive

```lua
IsActive(modifier: DurationTimeModifier) -> isActive: bool
```

### IsZero

```lua
IsZero() -> isZero: bool
```

### Reset

```lua
Reset()
```

### SetClock

```lua
SetClock(clock?: LuaDurationClock)
```

### SetTimeFromEnd

```lua
SetTimeFromEnd(endTime: FrameTime, duration: Seconds, modRate: number)
```

### SetTimeFromStart

```lua
SetTimeFromStart(startTime: FrameTime, duration: Seconds, modRate: number)
```

### SetTimeSpan

```lua
SetTimeSpan(startTime: FrameTime, endTime: FrameTime)
```

### SetToDefaults

```lua
SetToDefaults()
```
