# C_UI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`7` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### DoesAnyDisplayHaveNotch

```lua
C_UI.DoesAnyDisplayHaveNotch() -> notchPresent: bool
```

### GetTopLeftNotchSafeRegion

```lua
C_UI.GetTopLeftNotchSafeRegion() -> left: number, right: number, top: number, bottom: number
```

### GetTopRightNotchSafeRegion

```lua
C_UI.GetTopRightNotchSafeRegion() -> left: number, right: number, top: number, bottom: number
```

### GetUIParent

```lua
C_UI.GetUIParent() -> uiParent: SimpleFrame
```

### GetWorldFrame

```lua
C_UI.GetWorldFrame() -> worldFrame: SimpleFrame
```

### Reload

```lua
C_UI.Reload()
```

### ShouldUIParentAvoidNotch

```lua
C_UI.ShouldUIParentAvoidNotch() -> willAvoidNotch: bool
```

## Events

### NotchedDisplayModeChanged

Fires as `NOTCHED_DISPLAY_MODE_CHANGED`.

No payload.

### UiScaleChanged

Fires as `UI_SCALE_CHANGED`.

No payload.
