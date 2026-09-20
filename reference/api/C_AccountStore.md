# C_AccountStore

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`11` functions - `5` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### BeginPurchase

```lua
C_AccountStore.BeginPurchase(itemID: number) -> purchaseStarted: bool
```

### GetCategories

```lua
C_AccountStore.GetCategories(storeFrontID: number) -> categories: table
```

### GetCategoryInfo

```lua
C_AccountStore.GetCategoryInfo(categoryID: number) -> info: AccountStoreCategoryInfo
```

### GetCategoryItems

```lua
C_AccountStore.GetCategoryItems(categoryID: number) -> itemIDs: table
```

### GetCurrencyAvailable

```lua
C_AccountStore.GetCurrencyAvailable(currencyID: number) -> amount: number
```

### GetCurrencyIDForStore

```lua
C_AccountStore.GetCurrencyIDForStore(storeFrontID: number) -> currencyID?: number
```

### GetCurrencyInfo

```lua
C_AccountStore.GetCurrencyInfo(currencyID: number) -> info: AccountStoreCurrencyInfo
```

### GetItemInfo

```lua
C_AccountStore.GetItemInfo(itemID: number) -> info?: AccountStoreItemInfo
```

### GetStoreFrontState

```lua
C_AccountStore.GetStoreFrontState(storeFrontID: number) -> state: AccountStoreState
```

### RefundItem

```lua
C_AccountStore.RefundItem(itemID: number) -> refundStarted: bool
```

### RequestStoreFrontInfoUpdate

```lua
C_AccountStore.RequestStoreFrontInfoUpdate(storeFrontID: number)
```

## Events

### AccountStoreCurrencyAvailableUpdated

Fires as `ACCOUNT_STORE_CURRENCY_AVAILABLE_UPDATED`.

```lua
payload: currencyID: number
```

### AccountStoreFrontUpdated

Fires as `ACCOUNT_STORE_FRONT_UPDATED`.

```lua
payload: storeFrontID: number
```

### AccountStoreItemInfoUpdated

Fires as `ACCOUNT_STORE_ITEM_INFO_UPDATED`.

```lua
payload: itemID: number
```

### AccountStoreTransactionError

Fires as `ACCOUNT_STORE_TRANSACTION_ERROR`.

```lua
payload: result: AccountStoreTransactionResult
```

### StoreFrontStateUpdated

Fires as `STORE_FRONT_STATE_UPDATED`.

```lua
payload: storeFrontID: number
```
