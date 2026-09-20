# TimedSignalMapAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`8` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CancelAllSignals

```lua
CancelAllSignals()
```

### CancelSignal

```lua
CancelSignal(key: number)
```

### GetNextSignal

```lua
GetNextSignal() -> key: number, time: FrameTime
```

### GetSignalCount

```lua
GetSignalCount() -> count: size
```

### GetSignalTime

```lua
GetSignalTime(key: number) -> time?: FrameTime
```

### HasSignal

```lua
HasSignal(key: number) -> hasSignal: bool
```

### SignalAfter

```lua
SignalAfter(key: number, secondsFromNow: Seconds)
```

### SignalAt

```lua
SignalAt(key: number, time: FrameTime)
```
