# C_TransmogCollection

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`84` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AccountCanCollectSource

```lua
C_TransmogCollection.AccountCanCollectSource(sourceID: number) -> hasItemData: bool, canCollect: bool
```

### AreAllCollectionTypeFiltersChecked

```lua
C_TransmogCollection.AreAllCollectionTypeFiltersChecked() -> areAllCollectionTypeFiltersChecked: bool
```

### AreAllSourceTypeFiltersChecked

```lua
C_TransmogCollection.AreAllSourceTypeFiltersChecked() -> areAllSourceTypeFiltersChecked: bool
```

### CanAppearanceHaveIllusion

```lua
C_TransmogCollection.CanAppearanceHaveIllusion(appearanceID: number) -> canHaveIllusion: bool
```

### ClearNewAppearance

```lua
C_TransmogCollection.ClearNewAppearance(visualID: number)
```

### ClearSearch

```lua
C_TransmogCollection.ClearSearch(searchType: TransmogSearchType) -> completed: bool
```

### DeleteCustomSet

```lua
C_TransmogCollection.DeleteCustomSet(customSetID: number)
```

### EndSearch

```lua
C_TransmogCollection.EndSearch()
```

### GetAllAppearanceSources

```lua
C_TransmogCollection.GetAllAppearanceSources(itemAppearanceID: number) -> itemModifiedAppearanceIDs: table
```

### GetAllFactionsShown

```lua
C_TransmogCollection.GetAllFactionsShown() -> shown: bool
```

### GetAllRacesShown

```lua
C_TransmogCollection.GetAllRacesShown() -> shown: bool
```

### GetAppearanceCameraID

```lua
C_TransmogCollection.GetAppearanceCameraID(itemAppearanceID: number, variation?: TransmogCameraVariation) -> cameraID: number
```

### GetAppearanceCameraIDBySource

```lua
C_TransmogCollection.GetAppearanceCameraIDBySource(itemModifiedAppearanceID: number, variation?: TransmogCameraVariation) -> cameraID: number
```

### GetAppearanceInfoBySource

```lua
C_TransmogCollection.GetAppearanceInfoBySource(itemModifiedAppearanceID: number) -> info: TransmogAppearanceInfoBySourceData
```

### GetAppearanceSourceDrops

```lua
C_TransmogCollection.GetAppearanceSourceDrops(itemModifiedAppearanceID: number) -> encounterInfo: table
```

### GetAppearanceSourceInfo

```lua
C_TransmogCollection.GetAppearanceSourceInfo(itemModifiedAppearanceID: number) -> info: TransmogAppearanceSourceInfoData
```

### GetAppearanceSources

```lua
C_TransmogCollection.GetAppearanceSources(appearanceID: number, categoryType?: TransmogCollectionType, transmogLocation?: TransmogLocation) -> sources: table
```

### GetArtifactAppearanceStrings

```lua
C_TransmogCollection.GetArtifactAppearanceStrings(appearanceID: number) -> name: cstring, hyperlink: cstring
```

### GetCategoryAppearances

```lua
C_TransmogCollection.GetCategoryAppearances(category: TransmogCollectionType, transmogLocation?: TransmogLocation, option?: TransmogOutfitSlotOption) -> appearances: table
```

### GetCategoryCollectedCount

```lua
C_TransmogCollection.GetCategoryCollectedCount(category: TransmogCollectionType) -> count: number
```

### GetCategoryForItem

```lua
C_TransmogCollection.GetCategoryForItem(itemModifiedAppearanceID: number) -> collectionCategory: TransmogCollectionType
```

### GetCategoryInfo

```lua
C_TransmogCollection.GetCategoryInfo(category: TransmogCollectionType) -> name: cstring, isWeapon: bool, canHaveIllusions: bool, canMainHand: bool, canOffHand: bool, canRanged: bool
```

### GetCategoryTotal

```lua
C_TransmogCollection.GetCategoryTotal(category: TransmogCollectionType) -> total: number
```

### GetClassFilter

```lua
C_TransmogCollection.GetClassFilter() -> classID: number
```

### GetCollectedShown

```lua
C_TransmogCollection.GetCollectedShown() -> shown: bool
```

### GetCustomSetHyperlinkFromItemTransmogInfoList

```lua
C_TransmogCollection.GetCustomSetHyperlinkFromItemTransmogInfoList(itemTransmogInfoList: table) -> hyperlink: cstring
```

### GetCustomSetInfo

```lua
C_TransmogCollection.GetCustomSetInfo(customSetID: number) -> name: cstring, icon: fileID
```

### GetCustomSetItemTransmogInfoList

```lua
C_TransmogCollection.GetCustomSetItemTransmogInfoList(customSetID: number) -> list: table
```

### GetCustomSets

```lua
C_TransmogCollection.GetCustomSets() -> customSetID: table
```

### GetFallbackWeaponAppearance

```lua
C_TransmogCollection.GetFallbackWeaponAppearance() -> appearanceID?: number
```

### GetFilteredCategoryCollectedCount

```lua
C_TransmogCollection.GetFilteredCategoryCollectedCount(category: TransmogCollectionType) -> count: number
```

### GetFilteredCategoryTotal

```lua
C_TransmogCollection.GetFilteredCategoryTotal(category: TransmogCollectionType) -> total: number
```

### GetIllusionInfo

```lua
C_TransmogCollection.GetIllusionInfo(illusionID: number) -> info: TransmogIllusionInfo
```

### GetIllusions

```lua
C_TransmogCollection.GetIllusions(category?: TransmogCollectionType) -> illusions: table
```

### GetIllusionStrings

```lua
C_TransmogCollection.GetIllusionStrings(illusionID: number) -> name: string, hyperlink: string, sourceText?: string
```

### GetInspectItemTransmogInfoList

```lua
C_TransmogCollection.GetInspectItemTransmogInfoList() -> list: table
```

### GetIsAppearanceFavorite

```lua
C_TransmogCollection.GetIsAppearanceFavorite(itemAppearanceID: number) -> isFavorite: bool
```

### GetItemInfo

```lua
C_TransmogCollection.GetItemInfo(itemInfo: ItemInfo) -> itemAppearanceID: number, itemModifiedAppearanceID: number
```

### GetItemTransmogInfoListFromCustomSetHyperlink

```lua
C_TransmogCollection.GetItemTransmogInfoListFromCustomSetHyperlink(hyperlink: cstring) -> list: table
```

### GetLatestAppearance

```lua
C_TransmogCollection.GetLatestAppearance() -> visualID: number, category: TransmogCollectionType
```

### GetNumMaxCustomSets

```lua
C_TransmogCollection.GetNumMaxCustomSets() -> maxCustomSets: number
```

### GetNumTransmogSources

```lua
C_TransmogCollection.GetNumTransmogSources() -> count: number
```

### GetPairedArtifactAppearance

```lua
C_TransmogCollection.GetPairedArtifactAppearance(itemModifiedAppearanceID: number) -> pairedItemModifiedAppearanceID: number
```

### GetSourceIcon

```lua
C_TransmogCollection.GetSourceIcon(itemModifiedAppearanceID: number) -> icon: fileID
```

### GetSourceInfo

```lua
C_TransmogCollection.GetSourceInfo(sourceID: number) -> sourceInfo: AppearanceSourceInfo
```

### GetSourceItemID

```lua
C_TransmogCollection.GetSourceItemID(itemModifiedAppearanceID: number) -> itemID: number
```

### GetSourceRequiredHoliday

```lua
C_TransmogCollection.GetSourceRequiredHoliday(itemModifiedAppearanceID: number) -> holidayName: string
```

### GetUncollectedShown

```lua
C_TransmogCollection.GetUncollectedShown() -> shown: bool
```

### GetValidAppearanceSourcesForClass

```lua
C_TransmogCollection.GetValidAppearanceSourcesForClass(appearanceID: number, classID: number, categoryType?: TransmogCollectionType, transmogLocation?: TransmogLocation) -> sources: table
```

### HasAnyAppearance

```lua
C_TransmogCollection.HasAnyAppearance() -> hasAnyAppearance: bool
```

### HasFavorites

```lua
C_TransmogCollection.HasFavorites() -> hasFavorites: bool
```

### IsAppearanceHiddenVisual

```lua
C_TransmogCollection.IsAppearanceHiddenVisual(appearanceID: number) -> isHiddenVisual: bool
```

### IsCategoryValidForItem

```lua
C_TransmogCollection.IsCategoryValidForItem(category: TransmogCollectionType, itemInfo: ItemInfo) -> isValid: bool
```

### IsNewAppearance

```lua
C_TransmogCollection.IsNewAppearance(visualID: number) -> isNew: bool
```

### IsSearchDBLoading

```lua
C_TransmogCollection.IsSearchDBLoading() -> isLoading: bool
```

### IsSearchInProgress

```lua
C_TransmogCollection.IsSearchInProgress(searchType: TransmogSearchType) -> inProgress: bool
```

### IsSourceTypeFilterChecked

```lua
C_TransmogCollection.IsSourceTypeFilterChecked(index: luaIndex) -> checked: bool
```

### IsSpellItemEnchantmentHiddenVisual

```lua
C_TransmogCollection.IsSpellItemEnchantmentHiddenVisual(spellItemEnchantmentID: number) -> isHiddenVisual: bool
```

### IsUsingDefaultFilters

```lua
C_TransmogCollection.IsUsingDefaultFilters() -> isUsingDefaultFilters: bool
```

### IsValidCustomSetName

```lua
C_TransmogCollection.IsValidCustomSetName(name: cstring) -> isApproved: bool
```

### IsValidTransmogSource

```lua
C_TransmogCollection.IsValidTransmogSource(source: TransmogSource) -> valid: bool
```

### ModifyCustomSet

```lua
C_TransmogCollection.ModifyCustomSet(customSetID: number, itemTransmogInfoList: table)
```

### NewCustomSet

```lua
C_TransmogCollection.NewCustomSet(name: cstring, icon: fileID, itemTransmogInfoList: table) -> customSetID?: number
```

### PlayerCanCollectSource

```lua
C_TransmogCollection.PlayerCanCollectSource(sourceID: number) -> hasItemData: bool, canCollect: bool
```

### PlayerHasTransmog

```lua
C_TransmogCollection.PlayerHasTransmog(itemID: number, itemAppearanceModID: number) -> hasTransmog: bool
```

### PlayerHasTransmogByItemInfo

```lua
C_TransmogCollection.PlayerHasTransmogByItemInfo(itemInfo: ItemInfo) -> hasTransmog: bool
```

### PlayerHasTransmogItemModifiedAppearance

```lua
C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance(itemModifiedAppearanceID: number) -> hasTransmog: bool
```

### PlayerKnowsSource

```lua
C_TransmogCollection.PlayerKnowsSource(sourceID: number) -> isKnown: bool
```

### RenameCustomSet

```lua
C_TransmogCollection.RenameCustomSet(customSetID: number, name: cstring)
```

### SearchProgress

```lua
C_TransmogCollection.SearchProgress(searchType: TransmogSearchType) -> progress: number
```

### SearchSize

```lua
C_TransmogCollection.SearchSize(searchType: TransmogSearchType) -> size: number
```

### SetAllCollectionTypeFilters

```lua
C_TransmogCollection.SetAllCollectionTypeFilters(checked: bool)
```

### SetAllFactionsShown

```lua
C_TransmogCollection.SetAllFactionsShown(shown: bool)
```

### SetAllRacesShown

```lua
C_TransmogCollection.SetAllRacesShown(shown: bool)
```

### SetAllSourceTypeFilters

```lua
C_TransmogCollection.SetAllSourceTypeFilters(checked: bool)
```

### SetClassFilter

```lua
C_TransmogCollection.SetClassFilter(classID: number)
```

### SetCollectedShown

```lua
C_TransmogCollection.SetCollectedShown(shown: bool)
```

### SetDefaultFilters

```lua
C_TransmogCollection.SetDefaultFilters()
```

### SetIsAppearanceFavorite

```lua
C_TransmogCollection.SetIsAppearanceFavorite(itemAppearanceID: number, isFavorite: bool)
```

### SetSearch

```lua
C_TransmogCollection.SetSearch(searchType: TransmogSearchType, searchText: string) -> completed: bool
```

### SetSearchAndFilterCategory

```lua
C_TransmogCollection.SetSearchAndFilterCategory(category: TransmogCollectionType)
```

### SetSourceTypeFilter

```lua
C_TransmogCollection.SetSourceTypeFilter(index: luaIndex, checked: bool)
```

### SetUncollectedShown

```lua
C_TransmogCollection.SetUncollectedShown(shown: bool)
```

### UpdateUsableAppearances

```lua
C_TransmogCollection.UpdateUsableAppearances()
```
