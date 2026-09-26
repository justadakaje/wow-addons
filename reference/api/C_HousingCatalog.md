# C_HousingCatalog

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`34` functions - `8` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CreateCatalogSearcher

```lua
C_HousingCatalog.CreateCatalogSearcher() -> searcher: HousingCatalogSearcher
```

### DeletePreviewCartDecor

```lua
C_HousingCatalog.DeletePreviewCartDecor(decorGUID: WOWGUID)
```

### DestroyEntry

```lua
C_HousingCatalog.DestroyEntry(entryVariantID: HousingCatalogEntryVariantID, destroyAll: bool)
```

### GetAllFilterTagGroups

```lua
C_HousingCatalog.GetAllFilterTagGroups() -> filterTagGroups: table
```

### GetAllVariantInfosForEntry

```lua
C_HousingCatalog.GetAllVariantInfosForEntry(entryID: HousingCatalogEntryID) -> variantInfos: table
```

### GetBundleInfo

```lua
C_HousingCatalog.GetBundleInfo(bundleCatalogShopProductID: number) -> bundleInfo?: HousingBundleInfo
```

### GetCartSizeLimit

```lua
C_HousingCatalog.GetCartSizeLimit() -> cartSizeLimit: number
```

### GetCatalogCategoryAndSubcategoryNames

```lua
C_HousingCatalog.GetCatalogCategoryAndSubcategoryNames(subcategoryID: number) -> categoryName: string, subcategoryName: string
```

### GetCatalogCategoryInfo

```lua
C_HousingCatalog.GetCatalogCategoryInfo(categoryID: number) -> info?: HousingCatalogCategoryInfo
```

### GetCatalogEntryInfo

```lua
C_HousingCatalog.GetCatalogEntryInfo(entryID: HousingCatalogEntryID) -> info?: HousingCatalogEntryInfo
```

### GetCatalogEntryInfoByItem

```lua
C_HousingCatalog.GetCatalogEntryInfoByItem(itemInfo: ItemInfo) -> info?: HousingCatalogEntryInfo
```

### GetCatalogEntryInfoByRecordID

```lua
C_HousingCatalog.GetCatalogEntryInfoByRecordID(entryType: HousingCatalogEntryType, recordID: number) -> info?: HousingCatalogEntryInfo
```

### GetCatalogEntryRefundTimeStampByRecordID

```lua
C_HousingCatalog.GetCatalogEntryRefundTimeStampByRecordID(entryType: HousingCatalogEntryType, recordID: number) -> refundTimeStamp?: time_t
```

### GetCatalogEntryVariantInfo

```lua
C_HousingCatalog.GetCatalogEntryVariantInfo(entryVariantID: HousingCatalogEntryVariantID) -> info?: HousingCatalogEntryVariantInfo
```

### GetCatalogSubcategoryInfo

```lua
C_HousingCatalog.GetCatalogSubcategoryInfo(subcategoryID: number) -> info?: HousingCatalogSubcategoryInfo
```

### GetDecorMaxOwnedCount

```lua
C_HousingCatalog.GetDecorMaxOwnedCount() -> maxOwnedCount: number
```

### GetDecorTotalOwnedCount

```lua
C_HousingCatalog.GetDecorTotalOwnedCount() -> totalOwnedCount: number, exemptDecorCount: number
```

### GetDestroyableInstanceCount

```lua
C_HousingCatalog.GetDestroyableInstanceCount(entryVariantID: HousingCatalogEntryVariantID) -> destroyableInstanceCount: number
```

### GetFeaturedBundles

```lua
C_HousingCatalog.GetFeaturedBundles() -> bundleInfos: table
```

### GetFeaturedSmallProducts

```lua
C_HousingCatalog.GetFeaturedSmallProducts() -> infos: table
```

### GetMarketInfoForDecor

```lua
C_HousingCatalog.GetMarketInfoForDecor(decorID: number) -> marketInfo?: HousingMarketInfo
```

### HasFeaturedEntries

```lua
C_HousingCatalog.HasFeaturedEntries() -> hasEntries: bool
```

### HousingMarketActionAddToCart

```lua
C_HousingCatalog.HousingMarketActionAddToCart(productID: number, withPreview: bool)
```

### HousingMarketActionClearCart

```lua
C_HousingCatalog.HousingMarketActionClearCart()
```

### HousingMarketActionRemoveFromCart

```lua
C_HousingCatalog.HousingMarketActionRemoveFromCart(productID: number)
```

### HousingMarketActionViewBundle

```lua
C_HousingCatalog.HousingMarketActionViewBundle(productID: number)
```

### HousingMarketActionViewInStore

```lua
C_HousingCatalog.HousingMarketActionViewInStore(productID: number)
```

### IsPreviewCartItemShown

```lua
C_HousingCatalog.IsPreviewCartItemShown(decorGUID: WOWGUID) -> isShown: bool
```

### PromotePreviewDecor

```lua
C_HousingCatalog.PromotePreviewDecor(decorID: number, previewDecorGUID: WOWGUID) -> success: bool
```

### RequestHousingMarketInfoRefresh

```lua
C_HousingCatalog.RequestHousingMarketInfoRefresh()
```

### RequestHousingMarketRefundInfo

```lua
C_HousingCatalog.RequestHousingMarketRefundInfo()
```

### SearchCatalogCategories

```lua
C_HousingCatalog.SearchCatalogCategories(searchParams: HousingCategorySearchInfo) -> categoryIDs: table
```

### SearchCatalogSubcategories

```lua
C_HousingCatalog.SearchCatalogSubcategories(searchParams: HousingCategorySearchInfo) -> subcategoryIDs: table
```

### SetPreviewCartItemShown

```lua
C_HousingCatalog.SetPreviewCartItemShown(decorGUID: WOWGUID, shown: bool)
```

## Events

### HousingCatalogCategoryUpdated

Fires as `HOUSING_CATALOG_CATEGORY_UPDATED`.

```lua
payload: categoryID: number
```

### HousingCatalogSubcategoryUpdated

Fires as `HOUSING_CATALOG_SUBCATEGORY_UPDATED`.

```lua
payload: subcategoryID: number
```

### HousingDecorAddToPreviewList

Fires as `HOUSING_DECOR_ADD_TO_PREVIEW_LIST`.

```lua
payload: previewItemData: HousingPreviewItemData
```

### HousingDecorPreviewListRemoveFromWorld

Fires as `HOUSING_DECOR_PREVIEW_LIST_REMOVE_FROM_WORLD`.

```lua
payload: decorGUID: WOWGUID
```

### HousingDecorPreviewListUpdated

Fires as `HOUSING_DECOR_PREVIEW_LIST_UPDATED`.

No payload.

### HousingRefundListUpdated

Fires as `HOUSING_REFUND_LIST_UPDATED`.

No payload.

### HousingStorageEntryUpdated

Fires as `HOUSING_STORAGE_ENTRY_UPDATED`.

```lua
payload: entryVariantID: HousingCatalogEntryVariantID
```

### HousingStorageUpdated

Fires as `HOUSING_STORAGE_UPDATED`.

No payload.
