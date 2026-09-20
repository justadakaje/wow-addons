# SimpleAnimGroupAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`28` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CreateAnimation

```lua
CreateAnimation(animationType?: cstring, name?: cstring, templateName?: cstring) -> anim: SimpleAnim
```

### Finish

```lua
Finish()
```

### GetAnimations

```lua
GetAnimations() -> anims: SimpleAnim
```

### GetAnimationSpeedMultiplier

```lua
GetAnimationSpeedMultiplier() -> animationSpeedMultiplier: number
```

### GetDuration

```lua
GetDuration() -> durationSec: number
```

### GetElapsed

```lua
GetElapsed() -> elapsedSec: number
```

### GetLooping

```lua
GetLooping() -> loopType: LoopType
```

### GetLoopState

```lua
GetLoopState() -> loopState: cstring
```

### GetProgress

```lua
GetProgress() -> progress: number
```

### GetScript

```lua
GetScript(scriptTypeName: ScriptTypeName, bindingType: ScriptBindingType) -> script: LuaFunctionReference
```

### HasScript

```lua
HasScript(scriptName: cstring) -> hasScript: bool
```

### HookScript

```lua
HookScript(scriptTypeName: ScriptTypeName, script: LuaFunctionReference, bindingType: ScriptBindingType) -> success: bool
```

### IsDone

```lua
IsDone() -> isDone: bool
```

### IsPaused

```lua
IsPaused() -> isPaused: bool
```

### IsPendingFinish

```lua
IsPendingFinish() -> isPendingFinish: bool
```

### IsPlaying

```lua
IsPlaying() -> isPlaying: bool
```

### IsReverse

```lua
IsReverse() -> isReverse: bool
```

### IsSetToFinalAlpha

```lua
IsSetToFinalAlpha() -> isSetToFinalAlpha: bool
```

### Pause

```lua
Pause()
```

### Play

```lua
Play(reverse: bool, offset: number)
```

### RemoveAnimations

```lua
RemoveAnimations()
```

### Restart

```lua
Restart(reverse: bool, offset: number)
```

### SetAnimationSpeedMultiplier

```lua
SetAnimationSpeedMultiplier(animationSpeedMultiplier: number)
```

### SetLooping

```lua
SetLooping(loopType: LoopType)
```

### SetPlaying

```lua
SetPlaying(play: bool)
```

### SetScript

```lua
SetScript(scriptTypeName: ScriptTypeName, script?: LuaFunctionReference)
```

### SetToFinalAlpha

```lua
SetToFinalAlpha(setToFinalAlpha: bool)
```

### Stop

```lua
Stop()
```
