# C_AddOnProfiler

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`10` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddMeasuredCallEvent

```lua
C_AddOnProfiler.AddMeasuredCallEvent(name: stringView)
```

### AddPerformanceMessageShown

```lua
C_AddOnProfiler.AddPerformanceMessageShown(msg: AddOnPerformanceMessage)
```

### CheckForPerformanceMessage

```lua
C_AddOnProfiler.CheckForPerformanceMessage() -> msg: AddOnPerformanceMessage
```

### GetAddOnMetric

```lua
C_AddOnProfiler.GetAddOnMetric(name: cstring, metric: AddOnProfilerMetric) -> result: number
```

### GetApplicationMetric

```lua
C_AddOnProfiler.GetApplicationMetric(metric: AddOnProfilerMetric) -> result: number
```

### GetOverallMetric

```lua
C_AddOnProfiler.GetOverallMetric(metric: AddOnProfilerMetric) -> result: number
```

### GetTicksPerSecond

```lua
C_AddOnProfiler.GetTicksPerSecond() -> frequency: BigInteger
```

### GetTopKAddOnsForMetric

```lua
C_AddOnProfiler.GetTopKAddOnsForMetric(metric: AddOnProfilerMetric, k: number) -> results: table
```

### IsEnabled

```lua
C_AddOnProfiler.IsEnabled() -> enabled: bool
```

### MeasureCall

```lua
C_AddOnProfiler.MeasureCall(func: LuaValueVariant, arguments: LuaValueVariant) -> results: AddOnProfilerCallResults, returns: LuaValueVariant
```
