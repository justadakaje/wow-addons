# HousingCatalogSearcherAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`46` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetAllSearchItems

```lua
GetAllSearchItems() -> matchingEntryVariantIDs: table
```

### GetCatalogSearchResults

```lua
GetCatalogSearchResults() -> matchingEntryVariantIDs: table
```

### GetEditorModeContext

```lua
GetEditorModeContext() -> editorModeContext?: HouseEditorMode
```

### GetFilteredCategoryID

```lua
GetFilteredCategoryID() -> categoryID?: number
```

### GetFilteredSubcategoryID

```lua
GetFilteredSubcategoryID() -> subcategoryID?: number
```

### GetFilterTagStatus

```lua
GetFilterTagStatus(groupID: number, tagID: number) -> active: bool
```

### GetNumSearchItems

```lua
GetNumSearchItems() -> numSearchItems: number
```

### GetSearchCount

```lua
GetSearchCount() -> searchCount: number
```

### GetSearchText

```lua
GetSearchText() -> searchText?: string
```

### GetSortType

```lua
GetSortType() -> sortType: HousingCatalogSortType
```

### IsAllowedIndoorsActive

```lua
IsAllowedIndoorsActive() -> isActive: bool
```

### IsAllowedOutdoorsActive

```lua
IsAllowedOutdoorsActive() -> isActive: bool
```

### IsBaseVariantOnlyActive

```lua
IsBaseVariantOnlyActive() -> isActive: bool
```

### IsCollectedActive

```lua
IsCollectedActive() -> isActive: bool
```

### IsCustomizableOnlyActive

```lua
IsCustomizableOnlyActive() -> isActive: bool
```

### IsFirstAcquisitionBonusOnlyActive

```lua
IsFirstAcquisitionBonusOnlyActive() -> isActive: bool
```

### IsSearchInProgress

```lua
IsSearchInProgress() -> isSearchInProgress: bool
```

### IsStoredOnlyActive

```lua
IsStoredOnlyActive() -> isActive: bool
```

### IsUncollectedActive

```lua
IsUncollectedActive() -> isActive: bool
```

### RunSearch

```lua
RunSearch()
```

### SetAllInFilterTagGroup

```lua
SetAllInFilterTagGroup(groupID: number, active: bool)
```

### SetAllowedIndoors

```lua
SetAllowedIndoors(isActive: bool)
```

### SetAllowedOutdoors

```lua
SetAllowedOutdoors(isActive: bool)
```

### SetAutoUpdateOnParamChanges

```lua
SetAutoUpdateOnParamChanges(autoUpdateActive: bool)
```

### SetBaseVariantOnly

```lua
SetBaseVariantOnly(isActive: bool)
```

### SetCollected

```lua
SetCollected(isActive: bool)
```

### SetCustomizableOnly

```lua
SetCustomizableOnly(isActive: bool)
```

### SetEditorModeContext

```lua
SetEditorModeContext(editorModeContext?: HouseEditorMode)
```

### SetFilteredCategoryID

```lua
SetFilteredCategoryID(categoryID?: number)
```

### SetFilteredSubcategoryID

```lua
SetFilteredSubcategoryID(subcategoryID?: number)
```

### SetFilterTagStatus

```lua
SetFilterTagStatus(groupID: number, tagID: number, active: bool)
```

### SetFirstAcquisitionBonusOnly

```lua
SetFirstAcquisitionBonusOnly(isActive: bool)
```

### SetResultsUpdatedCallback

```lua
SetResultsUpdatedCallback(callback: HousingCatalogSearchResultsUpdatedCallback)
```

### SetSearchText

```lua
SetSearchText(searchText?: string)
```

### SetSortType

```lua
SetSortType(sortType: HousingCatalogSortType)
```

### SetStoredOnly

```lua
SetStoredOnly(isActive: bool)
```

### SetUncollected

```lua
SetUncollected(isActive: bool)
```

### ToggleAllowedIndoors

```lua
ToggleAllowedIndoors()
```

### ToggleAllowedOutdoors

```lua
ToggleAllowedOutdoors()
```

### ToggleBaseVariantOnly

```lua
ToggleBaseVariantOnly()
```

### ToggleCollected

```lua
ToggleCollected()
```

### ToggleCustomizableOnly

```lua
ToggleCustomizableOnly()
```

### ToggleFilterTag

```lua
ToggleFilterTag(groupID: number, tagID: number)
```

### ToggleFirstAcquisitionBonusOnly

```lua
ToggleFirstAcquisitionBonusOnly()
```

### ToggleStoredOnly

```lua
ToggleStoredOnly()
```

### ToggleUncollected

```lua
ToggleUncollected()
```
