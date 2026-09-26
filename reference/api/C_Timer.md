# C_Timer

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`4` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### After

```lua
C_Timer.After(seconds: number, callback: TimerCallback)
```

### NewTicker

```lua
C_Timer.NewTicker(seconds: number, callback: TickerCallback, iterations?: number) -> cbObject: TickerCallback
```

### NewTimedSignalMap

```lua
C_Timer.NewTimedSignalMap(callback: TimedSignalMapCallback) -> signalMap: TimedSignalMap
```

### NewTimer

```lua
C_Timer.NewTimer(seconds: number, callback: TickerCallback) -> cbObject: TickerCallback
```
