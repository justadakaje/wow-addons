# C_HousingBasicMode

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`22` functions - `6` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CancelActiveEditing

```lua
C_HousingBasicMode.CancelActiveEditing()
```

### CommitDecorMovement

```lua
C_HousingBasicMode.CommitDecorMovement()
```

### CommitHouseExteriorPosition

```lua
C_HousingBasicMode.CommitHouseExteriorPosition()
```

### FinishPlacingNewDecor

```lua
C_HousingBasicMode.FinishPlacingNewDecor()
```

### GetHoveredDecorInfo

```lua
C_HousingBasicMode.GetHoveredDecorInfo() -> info?: HousingDecorInstanceInfo
```

### GetSelectedDecorInfo

```lua
C_HousingBasicMode.GetSelectedDecorInfo() -> info?: HousingDecorInstanceInfo
```

### IsDecorSelected

```lua
C_HousingBasicMode.IsDecorSelected() -> hasSelectedDecor: bool
```

### IsFreePlaceEnabled

```lua
C_HousingBasicMode.IsFreePlaceEnabled() -> freePlaceEnabled: bool
```

### IsGridSnapEnabled

```lua
C_HousingBasicMode.IsGridSnapEnabled() -> isGridSnapEnabled: bool
```

### IsGridVisible

```lua
C_HousingBasicMode.IsGridVisible() -> gridVisible: bool
```

### IsHouseExteriorHovered

```lua
C_HousingBasicMode.IsHouseExteriorHovered() -> isHouseExteriorHovered: bool
```

### IsHouseExteriorSelected

```lua
C_HousingBasicMode.IsHouseExteriorSelected() -> isHouseExteriorSelected: bool
```

### IsHoveringDecor

```lua
C_HousingBasicMode.IsHoveringDecor() -> isHoveringDecor: bool
```

### IsPlacingNewDecor

```lua
C_HousingBasicMode.IsPlacingNewDecor() -> hasPendingDecor: bool
```

### RemoveSelectedDecor

```lua
C_HousingBasicMode.RemoveSelectedDecor()
```

### RotateDecor

```lua
C_HousingBasicMode.RotateDecor(rotDegrees: number)
```

### RotateHouseExterior

```lua
C_HousingBasicMode.RotateHouseExterior(rotDegrees: number)
```

### SetFreePlaceEnabled

```lua
C_HousingBasicMode.SetFreePlaceEnabled(freePlaceEnabled: bool)
```

### SetGridSnapEnabled

```lua
C_HousingBasicMode.SetGridSnapEnabled(isGridSnapEnabled: bool)
```

### SetGridVisible

```lua
C_HousingBasicMode.SetGridVisible(gridVisible: bool)
```

### StartPlacingNewDecor

```lua
C_HousingBasicMode.StartPlacingNewDecor(catalogEntryVariantID: HousingCatalogEntryVariantID)
```

### StartPlacingPreviewDecor

```lua
C_HousingBasicMode.StartPlacingPreviewDecor(decorRecordID: number, bundleCatalogShopProductID?: number)
```

## Events

### HousingBasicModeHoveredTargetChanged

Fires as `HOUSING_BASIC_MODE_HOVERED_TARGET_CHANGED`.

```lua
payload: hasHoveredTarget: bool, targetType: HousingBasicModeTargetType
```

### HousingBasicModePlacementFlagsUpdated

Fires as `HOUSING_BASIC_MODE_PLACEMENT_FLAGS_UPDATED`.

```lua
payload: targetType: HousingBasicModeTargetType, activeFlags: HousingDecorPlacementRestriction
```

### HousingBasicModeSelectedTargetChanged

Fires as `HOUSING_BASIC_MODE_SELECTED_TARGET_CHANGED`.

```lua
payload: hasSelectedTarget: bool, targetType: HousingBasicModeTargetType, isPreview: bool
```

### HousingDecorFreePlaceStatusChanged

Fires as `HOUSING_DECOR_FREE_PLACE_STATUS_CHANGED`.

```lua
payload: isFreePlaceEnabled: bool
```

### HousingDecorGridSnapOccurred

Fires as `HOUSING_DECOR_GRID_SNAP_OCCURRED`.

No payload.

### HousingDecorGridSnapStatusChanged

Fires as `HOUSING_DECOR_GRID_SNAP_STATUS_CHANGED`.

```lua
payload: isGridSnapEnabled: bool
```
