# C_NamePlateManager

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`4` functions - `7` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetNamePlateHitTestInsets

```lua
C_NamePlateManager.GetNamePlateHitTestInsets(type: NamePlateType) -> left: uiUnit, right: uiUnit, top: uiUnit, bottom: uiUnit
```

### IsNamePlateUnitBehindCamera

```lua
C_NamePlateManager.IsNamePlateUnitBehindCamera(unitToken: UnitTokenNamePlate) -> isBehindCamera: bool
```

### SetNamePlateHitTestInsets

```lua
C_NamePlateManager.SetNamePlateHitTestInsets(type: NamePlateType, left: uiUnit, right: uiUnit, top: uiUnit, bottom: uiUnit)
```

### SetNamePlateSimplified

```lua
C_NamePlateManager.SetNamePlateSimplified(unitToken: UnitTokenNamePlate, isSimplified: bool)
```

## Events

### ForbiddenNamePlateCreated

Fires as `FORBIDDEN_NAME_PLATE_CREATED`.

```lua
payload: namePlateFrame: NamePlateFrame
```

### ForbiddenNamePlateUnitAdded

Fires as `FORBIDDEN_NAME_PLATE_UNIT_ADDED`.

```lua
payload: unitToken: UnitTokenType
```

### ForbiddenNamePlateUnitRemoved

Fires as `FORBIDDEN_NAME_PLATE_UNIT_REMOVED`.

```lua
payload: unitToken: UnitTokenType
```

### NamePlateCreated

Fires as `NAME_PLATE_CREATED`.

```lua
payload: namePlateFrame: NamePlateFrame
```

### NamePlateUnitAdded

Fires as `NAME_PLATE_UNIT_ADDED`.

```lua
payload: unitToken: UnitTokenType
```

### NamePlateUnitBehindCameraChanged

Fires as `NAME_PLATE_UNIT_BEHIND_CAMERA_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant, isBehindCamera: bool
```

### NamePlateUnitRemoved

Fires as `NAME_PLATE_UNIT_REMOVED`.

```lua
payload: unitToken: UnitTokenType
```
