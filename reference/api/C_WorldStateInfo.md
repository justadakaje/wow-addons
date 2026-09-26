# C_WorldStateInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`0` functions - `6` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Events

### CancelPlayerCountdown

Fires as `CANCEL_PLAYER_COUNTDOWN`.

```lua
payload: initiatedBy: WOWGUID, informChat: bool, initiatedByName?: string
```

### StartPlayerCountdown

Fires as `START_PLAYER_COUNTDOWN`.

```lua
payload: initiatedBy: WOWGUID, timeRemaining: time_t, totalTime: time_t, informChat: bool, initiatedByName?: string
```

### StartTimer

Fires as `START_TIMER`.

```lua
payload: timerType: StartTimerType, timeRemaining: time_t, totalTime: time_t
```

### StopTimerOfType

Fires as `STOP_TIMER_OF_TYPE`.

```lua
payload: timerType: StartTimerType
```

### WorldStateTimerStart

Fires as `WORLD_STATE_TIMER_START`.

```lua
payload: timerID: number
```

### WorldStateTimerStop

Fires as `WORLD_STATE_TIMER_STOP`.

```lua
payload: timerID: number
```
