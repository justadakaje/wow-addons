# SimpleAnimAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`36` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetDuration

```lua
GetDuration() -> durationSec: number
```

### GetElapsed

```lua
GetElapsed() -> elapsedSec: number
```

### GetEndDelay

```lua
GetEndDelay() -> delaySec: number
```

### GetOrder

```lua
GetOrder() -> order: number
```

### GetProgress

```lua
GetProgress() -> progress: number
```

### GetRegionParent

```lua
GetRegionParent() -> region: CScriptObject
```

### GetScript

```lua
GetScript(scriptTypeName: ScriptTypeName, bindingType: ScriptBindingType) -> script: LuaFunctionReference
```

### GetSmoothing

```lua
GetSmoothing() -> weights: SmoothingType
```

### GetSmoothProgress

```lua
GetSmoothProgress() -> progress: number
```

### GetStartDelay

```lua
GetStartDelay() -> delaySec: number
```

### GetTarget

```lua
GetTarget() -> target: CScriptObject
```

### HasScript

```lua
HasScript(scriptName: cstring) -> hasScript: bool
```

### HookScript

```lua
HookScript(scriptTypeName: ScriptTypeName, script: LuaFunctionReference, bindingType: ScriptBindingType) -> success: bool
```

### IsDelaying

```lua
IsDelaying() -> isDelaying: bool
```

### IsDone

```lua
IsDone() -> isDone: bool
```

### IsPaused

```lua
IsPaused() -> isPaused: bool
```

### IsPlaying

```lua
IsPlaying() -> isPlaying: bool
```

### IsStopped

```lua
IsStopped() -> isStopped: bool
```

### Pause

```lua
Pause()
```

### Play

```lua
Play()
```

### Restart

```lua
Restart()
```

### SetChildKey

```lua
SetChildKey(childKey: cstring) -> success: bool
```

### SetDuration

```lua
SetDuration(durationSec: number, recomputeGroupDuration: bool)
```

### SetEndDelay

```lua
SetEndDelay(delaySec: number, recomputeGroupDuration: bool)
```

### SetOrder

```lua
SetOrder(newOrder: number)
```

### SetParent

```lua
SetParent(parent: SimpleAnimGroup, order?: number)
```

### SetPlaying

```lua
SetPlaying(play: bool)
```

### SetScript

```lua
SetScript(scriptTypeName: ScriptTypeName, script?: LuaFunctionReference)
```

### SetSmoothing

```lua
SetSmoothing(weights: SmoothingType)
```

### SetSmoothProgress

```lua
SetSmoothProgress(durationSec: number)
```

### SetStartDelay

```lua
SetStartDelay(delaySec: number, recomputeGroupDuration: bool)
```

### SetTarget

```lua
SetTarget(target: CScriptObject) -> success: bool
```

### SetTargetKey

```lua
SetTargetKey(key: cstring) -> success: bool
```

### SetTargetName

```lua
SetTargetName(name: cstring) -> success: bool
```

### SetTargetParent

```lua
SetTargetParent() -> success: bool
```

### Stop

```lua
Stop()
```
