# C_HousingBlueprint

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`19` functions - `14` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanExportRoom

```lua
C_HousingBlueprint.CanExportRoom(roomGUID: WOWGUID) -> canExport: bool
```

### CanExportTypeFromCurrentLocation

```lua
C_HousingBlueprint.CanExportTypeFromCurrentLocation(type: HousingBlueprintType) -> locationValid: bool
```

### CanImportTypeFromCurrentLocation

```lua
C_HousingBlueprint.CanImportTypeFromCurrentLocation(type: HousingBlueprintType) -> locationValid: bool
```

### DeleteBlueprint

```lua
C_HousingBlueprint.DeleteBlueprint(blueprintID: BigUInteger)
```

### ExportBlueprint

```lua
C_HousingBlueprint.ExportBlueprint(type: HousingBlueprintType, name: cstring)
```

### ExportRoomBlueprint

```lua
C_HousingBlueprint.ExportRoomBlueprint(name: cstring, roomGUID: WOWGUID)
```

### GetBlueprintHyperlink

```lua
C_HousingBlueprint.GetBlueprintHyperlink(blueprintShareCode: cstring) -> hyperLink: string
```

### GetBlueprintTypeForCode

```lua
C_HousingBlueprint.GetBlueprintTypeForCode(shareCode: cstring) -> type: HousingBlueprintType
```

### GetExportAvailability

```lua
C_HousingBlueprint.GetExportAvailability() -> availability: HousingResult
```

### GetFeatureAvailability

```lua
C_HousingBlueprint.GetFeatureAvailability() -> blueprintsAvailability: HousingResult
```

### GetImportAvailability

```lua
C_HousingBlueprint.GetImportAvailability() -> availability: HousingResult
```

### ImportBlueprint

```lua
C_HousingBlueprint.ImportBlueprint(shareCode: cstring)
```

### IsShareCodeValid

```lua
C_HousingBlueprint.IsShareCodeValid(shareCode: cstring) -> isValid: bool
```

### RenameBlueprint

```lua
C_HousingBlueprint.RenameBlueprint(blueprintID: BigUInteger, newName: cstring)
```

### RequestBlueprintCollection

```lua
C_HousingBlueprint.RequestBlueprintCollection()
```

### RequestBlueprintContents

```lua
C_HousingBlueprint.RequestBlueprintContents(shareCode: cstring)
```

### RequestBlueprintContentsForContext

```lua
C_HousingBlueprint.RequestBlueprintContentsForContext(shareCode: cstring, optionalHouseGUID?: WOWGUID)
```

### StartImportRoomBlueprint

```lua
C_HousingBlueprint.StartImportRoomBlueprint(shareCode: cstring)
```

### UpdateBlueprintStringFromInput

```lua
C_HousingBlueprint.UpdateBlueprintStringFromInput(inputShareCode: cstring) -> updatedShareCode: string
```

## Events

### HousingBlueprintCollectionFailure

Fires as `HOUSING_BLUEPRINT_COLLECTION_FAILURE`.

```lua
payload: result: HousingResult
```

### HousingBlueprintCollectionReceived

Fires as `HOUSING_BLUEPRINT_COLLECTION_RECEIVED`.

```lua
payload: collection: HousingBlueprintCollection
```

### HousingBlueprintContentsFailure

Fires as `HOUSING_BLUEPRINT_CONTENTS_FAILURE`.

```lua
payload: blueprintShareCode: string, result: HousingResult
```

### HousingBlueprintContentsReceived

Fires as `HOUSING_BLUEPRINT_CONTENTS_RECEIVED`.

```lua
payload: contentInfo: HousingBlueprintContentInfo
```

### HousingBlueprintDeleteFailure

Fires as `HOUSING_BLUEPRINT_DELETE_FAILURE`.

```lua
payload: blueprintID: BigUInteger, result: HousingResult
```

### HousingBlueprintDeleteSuccess

Fires as `HOUSING_BLUEPRINT_DELETE_SUCCESS`.

```lua
payload: blueprintID: BigUInteger
```

### HousingBlueprintExportFailure

Fires as `HOUSING_BLUEPRINT_EXPORT_FAILURE`.

```lua
payload: result: HousingResult
```

### HousingBlueprintExportSuccess

Fires as `HOUSING_BLUEPRINT_EXPORT_SUCCESS`.

```lua
payload: blueprintShareCode: string
```

### HousingBlueprintImportFailure

Fires as `HOUSING_BLUEPRINT_IMPORT_FAILURE`.

```lua
payload: result: HousingResult
```

### HousingBlueprintImportStarted

Fires as `HOUSING_BLUEPRINT_IMPORT_STARTED`.

No payload.

### HousingBlueprintImportSuccess

Fires as `HOUSING_BLUEPRINT_IMPORT_SUCCESS`.

No payload.

### HousingBlueprintRenameFailure

Fires as `HOUSING_BLUEPRINT_RENAME_FAILURE`.

```lua
payload: blueprintID: BigUInteger, result: HousingResult
```

### HousingBlueprintRenameSuccess

Fires as `HOUSING_BLUEPRINT_RENAME_SUCCESS`.

```lua
payload: blueprintID: BigUInteger, name: string
```

### HousingBlueprintsAvailabilityChanged

Fires as `HOUSING_BLUEPRINTS_AVAILABILITY_CHANGED`.

No payload.
