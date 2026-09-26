# C_GamepadUI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`5` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetFirstGamepadActionBarStorageSlotIndexForActiveStance

```lua
C_GamepadUI.GetFirstGamepadActionBarStorageSlotIndexForActiveStance() -> activeStanceFirstGamepadStorageSlotIndex?: luaIndex
```

### GetFirstGamepadActionStorageSlotIndex

```lua
C_GamepadUI.GetFirstGamepadActionStorageSlotIndex() -> firstGamepadActionStorageSlotIndex: luaIndex
```

### GetFirstGamepadPetActionStorageSlotIndex

```lua
C_GamepadUI.GetFirstGamepadPetActionStorageSlotIndex() -> firstGamepadPetActionStorageSlotID: luaIndex
```

### IsValidGamepadActionStorageSlotIndex

```lua
C_GamepadUI.IsValidGamepadActionStorageSlotIndex(gamepadActionStorageSlotIndex: luaIndex) -> isValid: bool
```

### IsValidGamepadPossessBarStorageSlotIndex

```lua
C_GamepadUI.IsValidGamepadPossessBarStorageSlotIndex(gamepadPossessBarStorageSlotIndex: luaIndex) -> isValid: bool
```

## Events

### GamepadPossessBarOverrideChanged

Fires as `GAMEPAD_POSSESS_BAR_OVERRIDE_CHANGED`.

```lua
payload: oldOverride: GamepadPossessBarOverride, newOverride: GamepadPossessBarOverride
```

### GamepadStanceBarOverrideChanged

Fires as `GAMEPAD_STANCE_BAR_OVERRIDE_CHANGED`.

```lua
payload: oldOverride: GamepadStanceBarOverride, newOverride: GamepadStanceBarOverride
```
