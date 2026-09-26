# C_EventToastManager

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`3` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetLevelUpDisplayToastsFromLevel

```lua
C_EventToastManager.GetLevelUpDisplayToastsFromLevel(level: number) -> toastInfo: table
```

### GetNextToastToDisplay

```lua
C_EventToastManager.GetNextToastToDisplay() -> toastInfo: EventToastInfo
```

### RemoveCurrentToast

```lua
C_EventToastManager.RemoveCurrentToast()
```

## Events

### DisplayEventToastLink

Fires as `DISPLAY_EVENT_TOAST_LINK`.

```lua
payload: link: string
```

### DisplayEventToasts

Fires as `DISPLAY_EVENT_TOASTS`.

No payload.
