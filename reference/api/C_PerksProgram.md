# C_PerksProgram

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`24` functions - `15` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearFrozenPerksVendorItem

```lua
C_PerksProgram.ClearFrozenPerksVendorItem()
```

### CloseInteraction

```lua
C_PerksProgram.CloseInteraction()
```

### GetAvailableCategoryIDs

```lua
C_PerksProgram.GetAvailableCategoryIDs() -> categoryIDs: table
```

### GetAvailableVendorItemIDs

```lua
C_PerksProgram.GetAvailableVendorItemIDs() -> vendorItemIDs: table
```

### GetCategoryInfo

```lua
C_PerksProgram.GetCategoryInfo(categoryID: number) -> categoryInfo: PerksVendorCategoryInfo
```

### GetCurrencyAmount

```lua
C_PerksProgram.GetCurrencyAmount() -> currencyAmount: number
```

### GetDraggedPerksVendorItem

```lua
C_PerksProgram.GetDraggedPerksVendorItem() -> perksVendorItemID: number
```

### GetFrozenPerksVendorItemInfo

```lua
C_PerksProgram.GetFrozenPerksVendorItemInfo() -> vendorItemInfo: PerksVendorItemInfo
```

### GetPendingChestRewards

```lua
C_PerksProgram.GetPendingChestRewards() -> pendingRewards: table
```

### GetPerksProgramItemDisplayInfo

```lua
C_PerksProgram.GetPerksProgramItemDisplayInfo(id: number) -> item: PerksProgramItemDisplayInfo
```

### GetTimeRemaining

```lua
C_PerksProgram.GetTimeRemaining(vendorItemID: number) -> timeRemaining: time_t
```

### GetVendorItemInfo

```lua
C_PerksProgram.GetVendorItemInfo(vendorItemID: number) -> vendorItemInfo: PerksVendorItemInfo
```

### GetVendorItemInfoRefundTimeLeft

```lua
C_PerksProgram.GetVendorItemInfoRefundTimeLeft(vendorItemID: number) -> refundTimeRemaining: time_t
```

### IsAttackAnimToggleEnabled

```lua
C_PerksProgram.IsAttackAnimToggleEnabled() -> isAttackAnimToggleEnabled: bool
```

### IsFrozenPerksVendorItem

```lua
C_PerksProgram.IsFrozenPerksVendorItem(perksVendorItemID: number) -> isFrozen: bool
```

### IsMountSpecialAnimToggleEnabled

```lua
C_PerksProgram.IsMountSpecialAnimToggleEnabled() -> isMountSpecialAnimToggleEnabled: bool
```

### ItemSelectedTelemetry

```lua
C_PerksProgram.ItemSelectedTelemetry(perksVendorItemID: number)
```

### PickupPerksVendorItem

```lua
C_PerksProgram.PickupPerksVendorItem(perksVendorItemID: number)
```

### RequestCartCheckout

```lua
C_PerksProgram.RequestCartCheckout(perksVendorItemIDs: table)
```

### RequestPendingChestRewards

```lua
C_PerksProgram.RequestPendingChestRewards()
```

### RequestPurchase

```lua
C_PerksProgram.RequestPurchase(perksVendorItemID: number)
```

### RequestRefund

```lua
C_PerksProgram.RequestRefund(perksVendorItemID: number)
```

### ResetHeldItemDragAndDrop

```lua
C_PerksProgram.ResetHeldItemDragAndDrop()
```

### SetFrozenPerksVendorItem

```lua
C_PerksProgram.SetFrozenPerksVendorItem()
```

## Events

### ChestRewardsUpdatedFromServer

Fires as `CHEST_REWARDS_UPDATED_FROM_SERVER`.

No payload.

### PerksProgramAddPendingShopItem

Fires as `PERKS_PROGRAM_ADD_PENDING_SHOP_ITEM`.

```lua
payload: vendorItemID: number
```

### PerksProgramClose

Fires as `PERKS_PROGRAM_CLOSE`.

No payload.

### PerksProgramCurrencyAwarded

Fires as `PERKS_PROGRAM_CURRENCY_AWARDED`.

```lua
payload: value: number
```

### PerksProgramCurrencyRefresh

Fires as `PERKS_PROGRAM_CURRENCY_REFRESH`.

```lua
payload: oldValue: number, newValue: number
```

### PerksProgramDataRefresh

Fires as `PERKS_PROGRAM_DATA_REFRESH`.

No payload.

### PerksProgramDataSpecificItemRefresh

Fires as `PERKS_PROGRAM_DATA_SPECIFIC_ITEM_REFRESH`.

```lua
payload: vendorItemID: number
```

### PerksProgramDisabled

Fires as `PERKS_PROGRAM_DISABLED`.

No payload.

### PerksProgramOpen

Fires as `PERKS_PROGRAM_OPEN`.

No payload.

### PerksProgramPurchaseCartSuccess

Fires as `PERKS_PROGRAM_PURCHASE_CART_SUCCESS`.

```lua
payload: vendorItemIDs: table
```

### PerksProgramPurchaseSuccess

Fires as `PERKS_PROGRAM_PURCHASE_SUCCESS`.

```lua
payload: vendorItemID: number
```

### PerksProgramRefundSuccess

Fires as `PERKS_PROGRAM_REFUND_SUCCESS`.

```lua
payload: vendorItemID: number
```

### PerksProgramRemovePendingShopItem

Fires as `PERKS_PROGRAM_REMOVE_PENDING_SHOP_ITEM`.

```lua
payload: vendorItemID: number
```

### PerksProgramResultError

Fires as `PERKS_PROGRAM_RESULT_ERROR`.

No payload.

### PerksProgramSetFrozenItem

Fires as `PERKS_PROGRAM_SET_FROZEN_ITEM`.

```lua
payload: vendorItemID: number
```
