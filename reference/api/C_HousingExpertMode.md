# C_HousingExpertMode

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`18` functions - `6` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CancelActiveEditing

```lua
C_HousingExpertMode.CancelActiveEditing()
```

### CommitDecorMovement

```lua
C_HousingExpertMode.CommitDecorMovement()
```

### CommitHouseExteriorPosition

```lua
C_HousingExpertMode.CommitHouseExteriorPosition()
```

### GetHoveredDecorInfo

```lua
C_HousingExpertMode.GetHoveredDecorInfo() -> info?: HousingDecorInstanceInfo
```

### GetPrecisionSubmode

```lua
C_HousingExpertMode.GetPrecisionSubmode() -> activeSubMode?: HousingPrecisionSubmode
```

### GetPrecisionSubmodeRestriction

```lua
C_HousingExpertMode.GetPrecisionSubmodeRestriction(subMode: HousingPrecisionSubmode) -> restriction: HousingExpertSubmodeRestriction
```

### GetSelectedDecorInfo

```lua
C_HousingExpertMode.GetSelectedDecorInfo() -> info?: HousingDecorInstanceInfo
```

### IsDecorSelected

```lua
C_HousingExpertMode.IsDecorSelected() -> hasSelectedDecor: bool
```

### IsGridVisible

```lua
C_HousingExpertMode.IsGridVisible() -> gridVisible: bool
```

### IsHouseExteriorHovered

```lua
C_HousingExpertMode.IsHouseExteriorHovered() -> isHouseExteriorHovered: bool
```

### IsHouseExteriorSelected

```lua
C_HousingExpertMode.IsHouseExteriorSelected() -> isHouseExteriorSelected: bool
```

### IsHoveringDecor

```lua
C_HousingExpertMode.IsHoveringDecor() -> isHoveringDecor: bool
```

### RemoveSelectedDecor

```lua
C_HousingExpertMode.RemoveSelectedDecor()
```

### ResetPrecisionChanges

```lua
C_HousingExpertMode.ResetPrecisionChanges(activeSubmodeOnly: bool)
```

### SelectNextRotationAxis

```lua
C_HousingExpertMode.SelectNextRotationAxis()
```

### SetGridVisible

```lua
C_HousingExpertMode.SetGridVisible(gridVisible: bool)
```

### SetPrecisionIncrementingActive

```lua
C_HousingExpertMode.SetPrecisionIncrementingActive(incrementType: HousingIncrementType, active: bool)
```

### SetPrecisionSubmode

```lua
C_HousingExpertMode.SetPrecisionSubmode(subMode: HousingPrecisionSubmode)
```

## Events

### HousingDecorPrecisionManipulationEvent

Fires as `HOUSING_DECOR_PRECISION_MANIPULATION_EVENT`.

```lua
payload: event: TransformManipulatorEvent
```

### HousingDecorPrecisionManipulationStatusChanged

Fires as `HOUSING_DECOR_PRECISION_MANIPULATION_STATUS_CHANGED`.

```lua
payload: isManipulatingSelection: bool
```

### HousingDecorPrecisionSubmodeChanged

Fires as `HOUSING_DECOR_PRECISION_SUBMODE_CHANGED`.

```lua
payload: activeSubmode?: HousingPrecisionSubmode
```

### HousingExpertModeHoveredTargetChanged

Fires as `HOUSING_EXPERT_MODE_HOVERED_TARGET_CHANGED`.

```lua
payload: hasHoveredTarget: bool, targetType: HousingExpertModeTargetType
```

### HousingExpertModePlacementFlagsUpdated

Fires as `HOUSING_EXPERT_MODE_PLACEMENT_FLAGS_UPDATED`.

```lua
payload: targetType: HousingExpertModeTargetType, activeFlags: HousingDecorPlacementRestriction
```

### HousingExpertModeSelectedTargetChanged

Fires as `HOUSING_EXPERT_MODE_SELECTED_TARGET_CHANGED`.

```lua
payload: hasSelectedTarget: bool, targetType: HousingExpertModeTargetType
```
