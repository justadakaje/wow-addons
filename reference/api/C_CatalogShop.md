# C_CatalogShop

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`38` functions - `18` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### BulkPurchaseProducts

```lua
C_CatalogShop.BulkPurchaseProducts(productIDs: table) -> canPurchaseProducts: bool
```

### BulkRefundDecors

```lua
C_CatalogShop.BulkRefundDecors(decorGUIDs: table)
```

### CloseCatalogShopInteraction

```lua
C_CatalogShop.CloseCatalogShopInteraction()
```

### ConfirmHousingPurchase

```lua
C_CatalogShop.ConfirmHousingPurchase(productIDs: table)
```

### FindBestCurrencyProductForNeededAmount

```lua
C_CatalogShop.FindBestCurrencyProductForNeededAmount(vcCurrencyCode: string, amountNeeded: number) -> vcProductID?: number
```

### GetAvailableCategoryIDs

```lua
C_CatalogShop.GetAvailableCategoryIDs() -> categoryIDs: table
```

### GetAvailableTransmogRaceInfos

```lua
C_CatalogShop.GetAvailableTransmogRaceInfos() -> raceIDs: table
```

### GetCatalogShopProductDisplayInfo

```lua
C_CatalogShop.GetCatalogShopProductDisplayInfo(catalogShopProductID: number) -> item: CatalogShopProductDisplayInfo
```

### GetCategoryInfo

```lua
C_CatalogShop.GetCategoryInfo(categoryID: number) -> categoryInfo: CatalogShopCategoryInfo
```

### GetCategorySectionInfo

```lua
C_CatalogShop.GetCategorySectionInfo(categoryID: number, sectionID: number) -> sectionInfo: CatalogShopSectionInfo
```

### GetFailureInfo

```lua
C_CatalogShop.GetFailureInfo() -> errorResultEnum?: StoreError, errorResultRaw?: number
```

### GetFirstCategoryByProductID

```lua
C_CatalogShop.GetFirstCategoryByProductID(productID: number) -> categoryInfo?: CatalogShopCategoryInfo
```

### GetNewProducts

```lua
C_CatalogShop.GetNewProducts() -> newProducts: table
```

### GetProductAvailabilityTimeRemainingSecs

```lua
C_CatalogShop.GetProductAvailabilityTimeRemainingSecs(catalogShopProductID: number) -> timeRemainingSecs?: number
```

### GetProductIDsForBundle

```lua
C_CatalogShop.GetProductIDsForBundle(bundleProductID: number) -> childIDs: table
```

### GetProductIDsForCategory

```lua
C_CatalogShop.GetProductIDsForCategory(categoryID: number) -> productIDs: table
```

### GetProductIDsForCategorySection

```lua
C_CatalogShop.GetProductIDsForCategorySection(categoryID: number, sectionID: number) -> productIDs: table
```

### GetProductInfo

```lua
C_CatalogShop.GetProductInfo(productID: number) -> productInfo?: CatalogShopProductInfo
```

### GetProductSortOrder

```lua
C_CatalogShop.GetProductSortOrder(categoryID: number, sectionID: number, productID: number) -> sortOrder?: number
```

### GetRefundableDecors

```lua
C_CatalogShop.GetRefundableDecors(productIdFilterOpt?: number) -> refundableDecorInfos: table, minTimeRemainingSeconds: time_t
```

### GetSectionIDsForCategory

```lua
C_CatalogShop.GetSectionIDsForCategory(categoryID: number) -> sectionIDs: table
```

### GetSpellVisualInfoForMount

```lua
C_CatalogShop.GetSpellVisualInfoForMount(spellVisualID: number) -> spellVisualInfo: CatalogShopSpellVisualInfo
```

### GetVCProductInfos

```lua
C_CatalogShop.GetVCProductInfos() -> vcProductInfos: table
```

### GetVirtualCurrencyBalance

```lua
C_CatalogShop.GetVirtualCurrencyBalance(currencyCode: string) -> balance?: string
```

### HasNewProducts

```lua
C_CatalogShop.HasNewProducts() -> hasNewProducts: bool
```

### IsProductIncludedInAnyBundle

```lua
C_CatalogShop.IsProductIncludedInAnyBundle(productID: number) -> isIncludedInAnyBundle: bool
```

### IsShop2Enabled

```lua
C_CatalogShop.IsShop2Enabled() -> value?: bool
```

### OnLegalDisclaimerClicked

```lua
C_CatalogShop.OnLegalDisclaimerClicked(catalogShopProductID: number)
```

### OnLegalPersonalizedOptOutClicked

```lua
C_CatalogShop.OnLegalPersonalizedOptOutClicked()
```

### OpenCatalogShopInteractionFromHouse

```lua
C_CatalogShop.OpenCatalogShopInteractionFromHouse() -> shoppingSessionUUIDStr: string
```

### OpenCatalogShopInteractionFromShop

```lua
C_CatalogShop.OpenCatalogShopInteractionFromShop() -> shoppingSessionUUIDStr: string
```

### ProductDisplayedTelemetry

```lua
C_CatalogShop.ProductDisplayedTelemetry(categoryId: number, sectionId: number, catalogShopProductID: number)
```

### ProductSelectedTelemetry

```lua
C_CatalogShop.ProductSelectedTelemetry(categoryId: number, sectionId: number, catalogShopProductID: number, wasCodeSelection: bool)
```

### PurchaseProduct

```lua
C_CatalogShop.PurchaseProduct(productID: number) -> canPurchase: bool
```

### RefreshRefundableDecors

```lua
C_CatalogShop.RefreshRefundableDecors()
```

### RefreshVirtualCurrencyBalance

```lua
C_CatalogShop.RefreshVirtualCurrencyBalance(currencyCode: string)
```

### ShouldShowHousingWarning

```lua
C_CatalogShop.ShouldShowHousingWarning() -> shouldShowHousingWarning: bool
```

### StartHousingVCPurchaseConfirmation

```lua
C_CatalogShop.StartHousingVCPurchaseConfirmation(productID: number)
```

## Events

### BulkPurchaseResultReceived

Fires as `BULK_PURCHASE_RESULT_RECEIVED`.

```lua
payload: result: BulkPurchaseResult, productResults: table, bestTopUpProductID?: number, totalCost?: number
```

### BulkRefundResultReceived

Fires as `BULK_REFUND_RESULT_RECEIVED`.

```lua
payload: result: BulkRefundResult
```

### CatalogShopAddPendingProduct

Fires as `CATALOG_SHOP_ADD_PENDING_PRODUCT`.

```lua
payload: productID: number
```

### CatalogShopDataRefresh

Fires as `CATALOG_SHOP_DATA_REFRESH`.

```lua
payload: shoppingSessionUUIDStr?: string
```

### CatalogShopDisabled

Fires as `CATALOG_SHOP_DISABLED`.

No payload.

### CatalogShopFetchFailure

Fires as `CATALOG_SHOP_FETCH_FAILURE`.

```lua
payload: shoppingSessionUUIDStr?: string
```

### CatalogShopFetchSuccess

Fires as `CATALOG_SHOP_FETCH_SUCCESS`.

```lua
payload: shoppingSessionUUIDStr?: string
```

### CatalogShopOpenSimpleCheckout

Fires as `CATALOG_SHOP_OPEN_SIMPLE_CHECKOUT`.

```lua
payload: checkoutID: number
```

### CatalogShopPurchaseSuccess

Fires as `CATALOG_SHOP_PURCHASE_SUCCESS`.

```lua
payload: productID: number
```

### CatalogShopRebuildScrollBox

Fires as `CATALOG_SHOP_REBUILD_SCROLL_BOX`.

No payload.

### CatalogShopRefundableDecorsUpdated

Fires as `CATALOG_SHOP_REFUNDABLE_DECORS_UPDATED`.

No payload.

### CatalogShopRemovePendingProduct

Fires as `CATALOG_SHOP_REMOVE_PENDING_PRODUCT`.

```lua
payload: productID: number
```

### CatalogShopResultError

Fires as `CATALOG_SHOP_RESULT_ERROR`.

No payload.

### CatalogShopSpecificProductRefresh

Fires as `CATALOG_SHOP_SPECIFIC_PRODUCT_REFRESH`.

```lua
payload: productID: number
```

### CatalogShopVirtualCurrencyBalanceUpdate

Fires as `CATALOG_SHOP_VIRTUAL_CURRENCY_BALANCE_UPDATE`.

```lua
payload: currencyCode: string, balance: string
```

### CatalogShopVirtualCurrencyBalanceUpdateFailure

Fires as `CATALOG_SHOP_VIRTUAL_CURRENCY_BALANCE_UPDATE_FAILURE`.

```lua
payload: currencyCode: string
```

### SetSeenProducts

Fires as `SET_SEEN_PRODUCTS`.

```lua
payload: productIds: table
```

### ShowNewProductNotification

Fires as `SHOW_NEW_PRODUCT_NOTIFICATION`.

No payload.
