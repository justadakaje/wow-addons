# C_HousingCustomizeMode

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`32` functions - `6` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ApplyDyeToSelectedDecor

```lua
C_HousingCustomizeMode.ApplyDyeToSelectedDecor(dyeSlotID: number, dyeColorID?: number)
```

### ApplyPetToSelectedDecor

```lua
C_HousingCustomizeMode.ApplyPetToSelectedDecor(petID?: WOWGUID, petBehavior: HousingPetBehaviorType)
```

### ApplyThemeToRoom

```lua
C_HousingCustomizeMode.ApplyThemeToRoom(themeSetID: number)
```

### ApplyThemeToSelectedRoomComponent

```lua
C_HousingCustomizeMode.ApplyThemeToSelectedRoomComponent(themeSetID: number)
```

### ApplyWallpaperToAllWalls

```lua
C_HousingCustomizeMode.ApplyWallpaperToAllWalls(roomComponentTextureRecID: number)
```

### ApplyWallpaperToSelectedRoomComponent

```lua
C_HousingCustomizeMode.ApplyWallpaperToSelectedRoomComponent(roomComponentTextureRecID: number)
```

### CancelActiveEditing

```lua
C_HousingCustomizeMode.CancelActiveEditing()
```

### ClearDyesForSelectedDecor

```lua
C_HousingCustomizeMode.ClearDyesForSelectedDecor()
```

### ClearTargetRoomComponent

```lua
C_HousingCustomizeMode.ClearTargetRoomComponent()
```

### CommitDyesForSelectedDecor

```lua
C_HousingCustomizeMode.CommitDyesForSelectedDecor() -> hasChanges: bool
```

### GetHoveredDecorInfo

```lua
C_HousingCustomizeMode.GetHoveredDecorInfo() -> info?: HousingDecorInstanceInfo
```

### GetHoveredRoomComponentInfo

```lua
C_HousingCustomizeMode.GetHoveredRoomComponentInfo() -> info?: HousingRoomComponentInstanceInfo
```

### GetNumDyesToRemoveOnSelectedDecor

```lua
C_HousingCustomizeMode.GetNumDyesToRemoveOnSelectedDecor() -> numDyesToRemove: number
```

### GetNumDyesToSpendOnSelectedDecor

```lua
C_HousingCustomizeMode.GetNumDyesToSpendOnSelectedDecor() -> numDyesToSpend: number
```

### GetPreviewDyesOnSelectedDecor

```lua
C_HousingCustomizeMode.GetPreviewDyesOnSelectedDecor() -> previewDyes: table
```

### GetRecentlyUsedDyes

```lua
C_HousingCustomizeMode.GetRecentlyUsedDyes() -> recentDyes: table
```

### GetRecentlyUsedThemeSets

```lua
C_HousingCustomizeMode.GetRecentlyUsedThemeSets() -> recentThemeSets: table
```

### GetRecentlyUsedWallpapers

```lua
C_HousingCustomizeMode.GetRecentlyUsedWallpapers() -> recentWallpapers: table
```

### GetSelectedDecorInfo

```lua
C_HousingCustomizeMode.GetSelectedDecorInfo() -> info?: HousingDecorInstanceInfo
```

### GetSelectedDecorPetInfo

```lua
C_HousingCustomizeMode.GetSelectedDecorPetInfo() -> petID?: WOWGUID, petBehavior: HousingPetBehaviorType
```

### GetSelectedRoomComponentInfo

```lua
C_HousingCustomizeMode.GetSelectedRoomComponentInfo() -> info?: HousingRoomComponentInstanceInfo
```

### GetThemeSetInfo

```lua
C_HousingCustomizeMode.GetThemeSetInfo(themeSetID: number) -> name?: string
```

### GetWallpapersForRoomComponentType

```lua
C_HousingCustomizeMode.GetWallpapersForRoomComponentType(type: HousingRoomComponentType) -> availableWallpapers: table
```

### IsDecorSelected

```lua
C_HousingCustomizeMode.IsDecorSelected() -> hasSelectedDecor: bool
```

### IsHouseExteriorDoorHovered

```lua
C_HousingCustomizeMode.IsHouseExteriorDoorHovered() -> isHouseExteriorDoorHovered: bool
```

### IsHoveringDecor

```lua
C_HousingCustomizeMode.IsHoveringDecor() -> isHoveringDecor: bool
```

### IsHoveringRoomComponent

```lua
C_HousingCustomizeMode.IsHoveringRoomComponent() -> isHovering: bool
```

### IsRoomComponentSelected

```lua
C_HousingCustomizeMode.IsRoomComponentSelected() -> hasSelectedComponent: bool
```

### RoomComponentSupportsVariant

```lua
C_HousingCustomizeMode.RoomComponentSupportsVariant(componentID: number, variant: number) -> variantSupported: bool
```

### RoomConnectionSupportsDoorType

```lua
C_HousingCustomizeMode.RoomConnectionSupportsDoorType(roomGUID: WOWGUID, componentID: number, newDoortype: HousingRoomComponentDoorType) -> doorTypeSupported: bool
```

### SetRoomComponentCeilingType

```lua
C_HousingCustomizeMode.SetRoomComponentCeilingType(roomGUID: WOWGUID, componentID: number, ceilingType: HousingRoomComponentCeilingType)
```

### SetRoomComponentDoorType

```lua
C_HousingCustomizeMode.SetRoomComponentDoorType(roomGUID: WOWGUID, componentID: number, newDoortype: HousingRoomComponentDoorType)
```

## Events

### HousingCustomizeModeHoveredTargetChanged

Fires as `HOUSING_CUSTOMIZE_MODE_HOVERED_TARGET_CHANGED`.

```lua
payload: hasHoveredTarget: bool, targetType: HousingCustomizeModeTargetType
```

### HousingCustomizeModeSelectedTargetChanged

Fires as `HOUSING_CUSTOMIZE_MODE_SELECTED_TARGET_CHANGED`.

```lua
payload: hasSelectedTarget: bool, targetType: HousingCustomizeModeTargetType
```

### HousingDecorCustomizationChanged

Fires as `HOUSING_DECOR_CUSTOMIZATION_CHANGED`.

```lua
payload: decorGUID: WOWGUID
```

### HousingDecorDyeFailure

Fires as `HOUSING_DECOR_DYE_FAILURE`.

```lua
payload: decorGUID: WOWGUID, housingResult: HousingResult
```

### HousingRoomComponentCustomizationChanged

Fires as `HOUSING_ROOM_COMPONENT_CUSTOMIZATION_CHANGED`.

```lua
payload: roomGUID: WOWGUID, componentID: number
```

### HousingRoomComponentCustomizationChangeFailed

Fires as `HOUSING_ROOM_COMPONENT_CUSTOMIZATION_CHANGE_FAILED`.

```lua
payload: roomGUID: WOWGUID, componentID: number, housingResult: HousingResult
```
