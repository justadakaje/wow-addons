# C_FrameManager

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`1` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetFrameVisibilityState

```lua
C_FrameManager.GetFrameVisibilityState(frameType: UIFrameType) -> shouldShow: bool
```

## Events

### FrameManagerUpdateAll

Fires as `FRAME_MANAGER_UPDATE_ALL`.

No payload.

### FrameManagerUpdateFrame

Fires as `FRAME_MANAGER_UPDATE_FRAME`.

```lua
payload: type: UIFrameType, show: bool
```
