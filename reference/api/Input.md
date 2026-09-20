# Input

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`29` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetCursorDelta

```lua
GetCursorDelta() -> deltaX: number, deltaY: number
```

### GetCursorPosition

```lua
GetCursorPosition() -> posX: number, posY: number
```

### GetMouseButtonClicked

```lua
GetMouseButtonClicked() -> buttonName: cstring
```

### GetMouseButtonName

```lua
GetMouseButtonName(button: mouseButton) -> buttonName: cstring
```

### GetMouseFoci

```lua
GetMouseFoci() -> region: table
```

### GetStringFromModifiers

```lua
GetStringFromModifiers(modifiers: number) -> modifierString: string
```

### IsAltKeyDown

```lua
IsAltKeyDown() -> down: bool
```

### IsControlKeyDown

```lua
IsControlKeyDown() -> down: bool
```

### IsKeyDown

```lua
IsKeyDown(keyOrMouseName: cstring, excludeBindingState: bool) -> down?: bool
```

### IsLeftAltKeyDown

```lua
IsLeftAltKeyDown() -> down: bool
```

### IsLeftControlKeyDown

```lua
IsLeftControlKeyDown() -> down: bool
```

### IsLeftMetaKeyDown

```lua
IsLeftMetaKeyDown() -> down: bool
```

### IsLeftShiftKeyDown

```lua
IsLeftShiftKeyDown() -> down: bool
```

### IsMetaKeyDown

```lua
IsMetaKeyDown() -> down: bool
```

### IsModifierKeyDown

```lua
IsModifierKeyDown() -> down: bool
```

### IsMouseButtonDown

```lua
IsMouseButtonDown(button?: mouseButton) -> down: bool
```

### IsRightAltKeyDown

```lua
IsRightAltKeyDown() -> down: bool
```

### IsRightControlKeyDown

```lua
IsRightControlKeyDown() -> down: bool
```

### IsRightMetaKeyDown

```lua
IsRightMetaKeyDown() -> down: bool
```

### IsRightShiftKeyDown

```lua
IsRightShiftKeyDown() -> down: bool
```

### IsShiftKeyDown

```lua
IsShiftKeyDown() -> down: bool
```

### IsUsingGamepad

```lua
IsUsingGamepad() -> down: bool
```

### IsUsingMouse

```lua
IsUsingMouse() -> down: bool
```

### MakeModifiers

```lua
MakeModifiers() -> modifiers: number
```

### SetCursorPosition

```lua
SetCursorPosition(xPosition: uiUnit, yPosition: uiUnit)
```

### SimulateMouseClick

```lua
SimulateMouseClick(button: mouseButton)
```

### SimulateMouseDown

```lua
SimulateMouseDown(button: mouseButton)
```

### SimulateMouseUp

```lua
SimulateMouseUp(button: mouseButton)
```

### SimulateMouseWheel

```lua
SimulateMouseWheel(delta: number)
```

## Events

### InputDeviceInterfaceTransition

Fires as `INPUT_DEVICE_INTERFACE_TRANSITION`.

```lua
payload: newMode: InputDeviceInterfaceType, oldMode: InputDeviceInterfaceType
```
