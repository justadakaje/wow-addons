# C_HousingDecor

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`35` functions - `11` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AnyDecorPlacedInRoom

```lua
C_HousingDecor.AnyDecorPlacedInRoom(roomGUID: WOWGUID) -> isPlaced: bool
```

### CancelActiveEditing

```lua
C_HousingDecor.CancelActiveEditing()
```

### CommitDecorMovement

```lua
C_HousingDecor.CommitDecorMovement()
```

### EnterPreviewState

```lua
C_HousingDecor.EnterPreviewState()
```

### ExitPreviewState

```lua
C_HousingDecor.ExitPreviewState()
```

### GetAllMaxPlacementBudgets

```lua
C_HousingDecor.GetAllMaxPlacementBudgets() -> interiorMaxBudgets?: table, exteriorMaxBudgets?: table
```

### GetAllPlacedDecor

```lua
C_HousingDecor.GetAllPlacedDecor() -> placedDecor: table
```

### GetAllSpentPlacementBudgets

```lua
C_HousingDecor.GetAllSpentPlacementBudgets() -> interiorSpentBudgets?: table, exteriorSpentBudgets?: table
```

### GetDecorAssignedPetName

```lua
C_HousingDecor.GetDecorAssignedPetName(decorGUID: WOWGUID) -> name?: string
```

### GetDecorCanAttachPet

```lua
C_HousingDecor.GetDecorCanAttachPet(decorID: number) -> canAttachPet: bool
```

### GetDecorHyperlink

```lua
C_HousingDecor.GetDecorHyperlink(decorID: number) -> hyperLink: string
```

### GetDecorIcon

```lua
C_HousingDecor.GetDecorIcon(decorID: number) -> icon: fileID
```

### GetDecorInstanceInfoForGUID

```lua
C_HousingDecor.GetDecorInstanceInfoForGUID(decorGUID: WOWGUID) -> info?: HousingDecorInstanceInfo
```

### GetDecorName

```lua
C_HousingDecor.GetDecorName(decorID: number) -> name: string
```

### GetHoveredDecorInfo

```lua
C_HousingDecor.GetHoveredDecorInfo() -> info?: HousingDecorInstanceInfo
```

### GetMaxPetPlacementBudget

```lua
C_HousingDecor.GetMaxPetPlacementBudget() -> maxBudget?: number
```

### GetMaxPlacementBudget

```lua
C_HousingDecor.GetMaxPlacementBudget() -> maxBudget?: number
```

### GetNumDecorPlaced

```lua
C_HousingDecor.GetNumDecorPlaced() -> numPlaced: number
```

### GetNumPreviewDecor

```lua
C_HousingDecor.GetNumPreviewDecor() -> numDecor: number
```

### GetSelectedDecorInfo

```lua
C_HousingDecor.GetSelectedDecorInfo() -> info?: HousingDecorInstanceInfo
```

### GetSpentPetPlacementBudget

```lua
C_HousingDecor.GetSpentPetPlacementBudget() -> totalCost?: number
```

### GetSpentPlacementBudget

```lua
C_HousingDecor.GetSpentPlacementBudget() -> totalCost?: number
```

### HasMaxPlacementBudget

```lua
C_HousingDecor.HasMaxPlacementBudget() -> hasMaxBudget: bool
```

### IsDecorSelected

```lua
C_HousingDecor.IsDecorSelected() -> hasSelectedDecor: bool
```

### IsGridVisible

```lua
C_HousingDecor.IsGridVisible() -> gridVisible: bool
```

### IsHouseExteriorDoorHovered

```lua
C_HousingDecor.IsHouseExteriorDoorHovered() -> isHouseExteriorDoorHovered: bool
```

### IsHouseExteriorHovered

```lua
C_HousingDecor.IsHouseExteriorHovered() -> isHouseExteriorHovered: bool
```

### IsHoveringDecor

```lua
C_HousingDecor.IsHoveringDecor() -> isHoveringDecor: bool
```

### IsModeDisabledForPreviewState

```lua
C_HousingDecor.IsModeDisabledForPreviewState(mode: HouseEditorMode) -> isModeDisabled: bool
```

### IsPreviewState

```lua
C_HousingDecor.IsPreviewState() -> isPreviewState: bool
```

### RemovePlacedDecorEntry

```lua
C_HousingDecor.RemovePlacedDecorEntry(decorGUID: WOWGUID)
```

### RemoveSelectedDecor

```lua
C_HousingDecor.RemoveSelectedDecor()
```

### SetGridVisible

```lua
C_HousingDecor.SetGridVisible(gridVisible: bool)
```

### SetPlacedDecorEntryHovered

```lua
C_HousingDecor.SetPlacedDecorEntryHovered(decorGUID: WOWGUID, hovered: bool)
```

### SetPlacedDecorEntrySelected

```lua
C_HousingDecor.SetPlacedDecorEntrySelected(decorGUID: WOWGUID, selected: bool)
```

## Events

### HouseDecorAddedToChest

Fires as `HOUSE_DECOR_ADDED_TO_CHEST`.

```lua
payload: decorGUID: WOWGUID, decorID: number
```

### HouseExteriorPositionFailure

Fires as `HOUSE_EXTERIOR_POSITION_FAILURE`.

```lua
payload: housingResult: HousingResult
```

### HouseExteriorPositionSuccess

Fires as `HOUSE_EXTERIOR_POSITION_SUCCESS`.

No payload.

### HousingDecorGridVisibilityStatusChanged

Fires as `HOUSING_DECOR_GRID_VISIBILITY_STATUS_CHANGED`.

```lua
payload: isGridVisible: bool
```

### HousingDecorPlaceFailure

Fires as `HOUSING_DECOR_PLACE_FAILURE`.

```lua
payload: housingResult: HousingResult
```

### HousingDecorPlaceSuccess

Fires as `HOUSING_DECOR_PLACE_SUCCESS`.

```lua
payload: decorGUID: WOWGUID, size: HousingCatalogEntrySize, isNew: bool, isPreview: bool
```

### HousingDecorPreviewStateChanged

Fires as `HOUSING_DECOR_PREVIEW_STATE_CHANGED`.

```lua
payload: isPreviewState: bool
```

### HousingDecorRemoved

Fires as `HOUSING_DECOR_REMOVED`.

```lua
payload: decorGUID: WOWGUID
```

### HousingDecorSelectResponse

Fires as `HOUSING_DECOR_SELECT_RESPONSE`.

```lua
payload: result: HousingResult
```

### HousingNewDecorPlaceComplete

Fires as `HOUSING_NEW_DECOR_PLACE_COMPLETE`.

```lua
payload: decorGUID: WOWGUID
```

### HousingNumDecorPlacedChanged

Fires as `HOUSING_NUM_DECOR_PLACED_CHANGED`.

No payload.
