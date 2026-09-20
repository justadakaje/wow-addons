# C_DateAndTime

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`11` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AdjustTimeByDays

```lua
C_DateAndTime.AdjustTimeByDays(date: CalendarTime, days: number) -> newDate: CalendarTime
```

### AdjustTimeByMinutes

```lua
C_DateAndTime.AdjustTimeByMinutes(date: CalendarTime, minutes: number) -> newDate: CalendarTime
```

### AdjustTimeByMonths

```lua
C_DateAndTime.AdjustTimeByMonths(date: CalendarTime, months: number) -> newDate: CalendarTime
```

### CompareCalendarTime

```lua
C_DateAndTime.CompareCalendarTime(lhsCalendarTime: CalendarTime, rhsCalendarTime: CalendarTime) -> comparison: number
```

### GetCalendarTimeFromEpoch

```lua
C_DateAndTime.GetCalendarTimeFromEpoch(epoch: BigUInteger) -> date: CalendarTime
```

### GetCurrentCalendarTime

```lua
C_DateAndTime.GetCurrentCalendarTime() -> date: CalendarTime
```

### GetSecondsUntilDailyReset

```lua
C_DateAndTime.GetSecondsUntilDailyReset() -> seconds: time_t
```

### GetSecondsUntilWeeklyReset

```lua
C_DateAndTime.GetSecondsUntilWeeklyReset() -> seconds: time_t
```

### GetServerTimeLocal

```lua
C_DateAndTime.GetServerTimeLocal() -> serverTimeLocal: time_t
```

### GetWeeklyResetStartTime

```lua
C_DateAndTime.GetWeeklyResetStartTime() -> seconds: time_t
```

### IsDayTime

```lua
C_DateAndTime.IsDayTime() -> isDayTime: bool
```

## Events

### DielCycleChanged

Fires as `DIEL_CYCLE_CHANGED`.

```lua
payload: isDayTime: bool
```
