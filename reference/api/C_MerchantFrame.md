# C_MerchantFrame

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`7` functions - `4` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetBuybackItemID

```lua
C_MerchantFrame.GetBuybackItemID(buybackSlotIndex: luaIndex) -> buybackItemID: number
```

### GetItemInfo

```lua
C_MerchantFrame.GetItemInfo(index: luaIndex) -> info: MerchantItemInfo
```

### GetMerchantCurrencies

```lua
C_MerchantFrame.GetMerchantCurrencies() -> currencies: table
```

### GetNumJunkItems

```lua
C_MerchantFrame.GetNumJunkItems() -> numJunkItems: number
```

### IsMerchantItemRefundable

```lua
C_MerchantFrame.IsMerchantItemRefundable(index: luaIndex) -> refundable: bool
```

### IsSellAllJunkEnabled

```lua
C_MerchantFrame.IsSellAllJunkEnabled() -> enabled: bool
```

### SellAllJunkItems

```lua
C_MerchantFrame.SellAllJunkItems()
```

## Events

### MerchantClosed

Fires as `MERCHANT_CLOSED`.

No payload.

### MerchantFilterItemUpdate

Fires as `MERCHANT_FILTER_ITEM_UPDATE`.

```lua
payload: itemID: number
```

### MerchantShow

Fires as `MERCHANT_SHOW`.

No payload.

### MerchantUpdate

Fires as `MERCHANT_UPDATE`.

No payload.
