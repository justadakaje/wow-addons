# C_TransmogSets

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`42` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearLatestSource

```lua
C_TransmogSets.ClearLatestSource()
```

### ClearNewSource

```lua
C_TransmogSets.ClearNewSource(sourceID: number)
```

### ClearSetNewSourcesForSlot

```lua
C_TransmogSets.ClearSetNewSourcesForSlot(transmogSetID: number, slot: luaIndex)
```

### GetAllSets

```lua
C_TransmogSets.GetAllSets() -> sets: table
```

### GetAllSourceIDs

```lua
C_TransmogSets.GetAllSourceIDs(transmogSetID: number) -> sources: table
```

### GetAvailableSets

```lua
C_TransmogSets.GetAvailableSets() -> sets: table
```

### GetBaseSetID

```lua
C_TransmogSets.GetBaseSetID(transmogSetID: number) -> baseTransmogSetID: number
```

### GetBaseSets

```lua
C_TransmogSets.GetBaseSets() -> sets: table
```

### GetBaseSetsFilter

```lua
C_TransmogSets.GetBaseSetsFilter(index: luaIndex) -> isChecked: bool
```

### GetCameraIDs

```lua
C_TransmogSets.GetCameraIDs() -> detailsCameraID?: number, vendorCameraID?: number
```

### GetFilteredBaseSetsCounts

```lua
C_TransmogSets.GetFilteredBaseSetsCounts() -> numCollected: number, numTotal: number
```

### GetFullBaseSetsCounts

```lua
C_TransmogSets.GetFullBaseSetsCounts() -> numCollected: number, numTotal: number
```

### GetIsFavorite

```lua
C_TransmogSets.GetIsFavorite(transmogSetID: number) -> isFavorite: bool, isGroupFavorite: bool
```

### GetLatestSource

```lua
C_TransmogSets.GetLatestSource() -> sourceID: number
```

### GetSetInfo

```lua
C_TransmogSets.GetSetInfo(transmogSetID: number) -> set: TransmogSetInfo
```

### GetSetNewSources

```lua
C_TransmogSets.GetSetNewSources(transmogSetID: number) -> sourceIDs: table
```

### GetSetPrimaryAppearances

```lua
C_TransmogSets.GetSetPrimaryAppearances(transmogSetID: number) -> apppearances: table
```

### GetSetsContainingSourceID

```lua
C_TransmogSets.GetSetsContainingSourceID(sourceID: number) -> setIDs: table
```

### GetSetsFilter

```lua
C_TransmogSets.GetSetsFilter(index: luaIndex) -> isChecked: bool
```

### GetSourceIDsForSlot

```lua
C_TransmogSets.GetSourceIDsForSlot(transmogSetID: number, slot: luaIndex) -> sources: table
```

### GetSourcesForSlot

```lua
C_TransmogSets.GetSourcesForSlot(transmogSetID: number, slot: luaIndex) -> sources: table
```

### GetTransmogSetsClassFilter

```lua
C_TransmogSets.GetTransmogSetsClassFilter() -> classID: number
```

### GetUsableSets

```lua
C_TransmogSets.GetUsableSets() -> sets: table
```

### GetValidBaseSetsCountsForCharacter

```lua
C_TransmogSets.GetValidBaseSetsCountsForCharacter() -> numCollected: number, numTotal: number
```

### GetValidClassForSet

```lua
C_TransmogSets.GetValidClassForSet(transmogSetID: number) -> classID?: number
```

### GetVariantSets

```lua
C_TransmogSets.GetVariantSets(transmogSetID: number) -> sets: table
```

### HasAnyValidSets

```lua
C_TransmogSets.HasAnyValidSets() -> hasAnyValidSets: bool
```

### HasAvailableSets

```lua
C_TransmogSets.HasAvailableSets() -> hasAvailableSets: bool
```

### HasUsableSets

```lua
C_TransmogSets.HasUsableSets() -> hasUsableSets: bool
```

### IsBaseSetCollected

```lua
C_TransmogSets.IsBaseSetCollected(transmogSetID: number) -> isCollected: bool
```

### IsNewSource

```lua
C_TransmogSets.IsNewSource(sourceID: number) -> isNew: bool
```

### IsSetVisible

```lua
C_TransmogSets.IsSetVisible(transmogSetID: number) -> isVisible: bool
```

### IsUsingDefaultBaseSetsFilters

```lua
C_TransmogSets.IsUsingDefaultBaseSetsFilters() -> isUsingDefaultBaseSetsFilters: bool
```

### IsUsingDefaultSetsFilters

```lua
C_TransmogSets.IsUsingDefaultSetsFilters() -> isUsingDefaultSetsFilters: bool
```

### SetBaseSetsFilter

```lua
C_TransmogSets.SetBaseSetsFilter(index: luaIndex, isChecked: bool)
```

### SetDefaultBaseSetsFilters

```lua
C_TransmogSets.SetDefaultBaseSetsFilters()
```

### SetDefaultSetsFilters

```lua
C_TransmogSets.SetDefaultSetsFilters()
```

### SetHasNewSources

```lua
C_TransmogSets.SetHasNewSources(transmogSetID: number) -> hasNewSources: bool
```

### SetHasNewSourcesForSlot

```lua
C_TransmogSets.SetHasNewSourcesForSlot(transmogSetID: number, slot: luaIndex) -> hasNewSources: bool
```

### SetIsFavorite

```lua
C_TransmogSets.SetIsFavorite(transmogSetID: number, isFavorite: bool)
```

### SetSetsFilter

```lua
C_TransmogSets.SetSetsFilter(index: luaIndex, isChecked: bool)
```

### SetTransmogSetsClassFilter

```lua
C_TransmogSets.SetTransmogSetsClassFilter(classID: number)
```
