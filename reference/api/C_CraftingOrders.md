# C_CraftingOrders

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`36` functions - `24` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AreOrderNotesDisabled

```lua
C_CraftingOrders.AreOrderNotesDisabled() -> areNotesDisabled: bool
```

### CalculateCraftingOrderPostingFee

```lua
C_CraftingOrders.CalculateCraftingOrderPostingFee(skillLineAbilityID: number, orderType: CraftingOrderType, orderDuration: CraftingOrderDuration) -> deposit: WOWMONEY
```

### CancelOrder

```lua
C_CraftingOrders.CancelOrder(orderID: BigUInteger)
```

### CanOrderSkillAbility

```lua
C_CraftingOrders.CanOrderSkillAbility(skillLineAbilityID: number) -> canOrder: bool
```

### ClaimOrder

```lua
C_CraftingOrders.ClaimOrder(orderID: BigUInteger, profession: Profession)
```

### CloseCrafterCraftingOrders

```lua
C_CraftingOrders.CloseCrafterCraftingOrders()
```

### CloseCustomerCraftingOrders

```lua
C_CraftingOrders.CloseCustomerCraftingOrders()
```

### FulfillOrder

```lua
C_CraftingOrders.FulfillOrder(orderID: BigUInteger, crafterNote: string, profession: Profession)
```

### GetClaimedOrder

```lua
C_CraftingOrders.GetClaimedOrder() -> order?: CraftingOrderInfo
```

### GetCrafterBuckets

```lua
C_CraftingOrders.GetCrafterBuckets() -> buckets: table
```

### GetCrafterOrders

```lua
C_CraftingOrders.GetCrafterOrders() -> orders: table
```

### GetCraftingOrderTime

```lua
C_CraftingOrders.GetCraftingOrderTime() -> time: BigUInteger
```

### GetCustomerCategories

```lua
C_CraftingOrders.GetCustomerCategories() -> categories: table
```

### GetCustomerOptions

```lua
C_CraftingOrders.GetCustomerOptions(params: CraftingOrderCustomerSearchParams) -> results: CraftingOrderCustomerSearchResults
```

### GetCustomerOrders

```lua
C_CraftingOrders.GetCustomerOrders() -> customerOrders: table
```

### GetDefaultOrdersSkillLine

```lua
C_CraftingOrders.GetDefaultOrdersSkillLine() -> skillLineID?: number
```

### GetMyOrders

```lua
C_CraftingOrders.GetMyOrders() -> myOrders: table
```

### GetNumFavoriteCustomerOptions

```lua
C_CraftingOrders.GetNumFavoriteCustomerOptions() -> numFavorites: BigUInteger
```

### GetOrderClaimInfo

```lua
C_CraftingOrders.GetOrderClaimInfo(profession: Profession) -> claimInfo: CraftingOrderClaimsRemainingInfo
```

### GetPersonalOrdersInfo

```lua
C_CraftingOrders.GetPersonalOrdersInfo() -> infos: table
```

### HasFavoriteCustomerOptions

```lua
C_CraftingOrders.HasFavoriteCustomerOptions() -> hasFavorites: bool
```

### IsCustomerOptionFavorited

```lua
C_CraftingOrders.IsCustomerOptionFavorited(recipeID: number) -> favorited: bool
```

### ListMyOrders

```lua
C_CraftingOrders.ListMyOrders(request: CraftingOrderRequestMyOrdersInfo)
```

### OpenCrafterCraftingOrders

```lua
C_CraftingOrders.OpenCrafterCraftingOrders()
```

### OpenCustomerCraftingOrders

```lua
C_CraftingOrders.OpenCustomerCraftingOrders()
```

### OrderCanBeRecrafted

```lua
C_CraftingOrders.OrderCanBeRecrafted(orderID: BigUInteger) -> recraftable: bool
```

### ParseCustomerOptions

```lua
C_CraftingOrders.ParseCustomerOptions()
```

### PlaceNewOrder

```lua
C_CraftingOrders.PlaceNewOrder(orderInfo: NewCraftingOrderInfo)
```

### RejectOrder

```lua
C_CraftingOrders.RejectOrder(orderID: BigUInteger, crafterNote: string, profession: Profession)
```

### ReleaseOrder

```lua
C_CraftingOrders.ReleaseOrder(orderID: BigUInteger, profession: Profession)
```

### RequestCrafterOrders

```lua
C_CraftingOrders.RequestCrafterOrders(request: CraftingOrderRequestInfo)
```

### RequestCustomerOrders

```lua
C_CraftingOrders.RequestCustomerOrders(request: CraftingOrderRequestInfo)
```

### SetCustomerOptionFavorited

```lua
C_CraftingOrders.SetCustomerOptionFavorited(recipeID: number, favorited: bool)
```

### ShouldShowCraftingOrderTab

```lua
C_CraftingOrders.ShouldShowCraftingOrderTab() -> showTab: bool
```

### SkillLineHasOrders

```lua
C_CraftingOrders.SkillLineHasOrders(skillLineID: number) -> hasOrders: bool
```

### UpdateIgnoreList

```lua
C_CraftingOrders.UpdateIgnoreList()
```

## Events

### CraftingHouseDisabled

Fires as `CRAFTING_HOUSE_DISABLED`.

No payload.

### CraftingordersCanRequest

Fires as `CRAFTINGORDERS_CAN_REQUEST`.

No payload.

### CraftingordersClaimedOrderAdded

Fires as `CRAFTINGORDERS_CLAIMED_ORDER_ADDED`.

No payload.

### CraftingordersClaimedOrderRemoved

Fires as `CRAFTINGORDERS_CLAIMED_ORDER_REMOVED`.

No payload.

### CraftingordersClaimedOrderUpdated

Fires as `CRAFTINGORDERS_CLAIMED_ORDER_UPDATED`.

```lua
payload: orderID: BigUInteger
```

### CraftingordersClaimOrderResponse

Fires as `CRAFTINGORDERS_CLAIM_ORDER_RESPONSE`.

```lua
payload: result: CraftingOrderResult, orderID: BigUInteger
```

### CraftingordersCraftOrderResponse

Fires as `CRAFTINGORDERS_CRAFT_ORDER_RESPONSE`.

```lua
payload: result: CraftingOrderResult, orderID: BigUInteger
```

### CraftingordersCustomerFavoritesChanged

Fires as `CRAFTINGORDERS_CUSTOMER_FAVORITES_CHANGED`.

No payload.

### CraftingordersCustomerOptionsParsed

Fires as `CRAFTINGORDERS_CUSTOMER_OPTIONS_PARSED`.

No payload.

### CraftingordersDisplayCrafterFulfilledMsg

Fires as `CRAFTINGORDERS_DISPLAY_CRAFTER_FULFILLED_MSG`.

```lua
payload: orderTypeString: cstring, itemNameString: cstring, playerNameString: cstring, tipAmount: WOWMONEY, quantityCrafted: number
```

### CraftingordersFulfillOrderResponse

Fires as `CRAFTINGORDERS_FULFILL_ORDER_RESPONSE`.

```lua
payload: result: CraftingOrderResult, orderID: BigUInteger
```

### CraftingordersHideCrafter

Fires as `CRAFTINGORDERS_HIDE_CRAFTER`.

No payload.

### CraftingordersHideCustomer

Fires as `CRAFTINGORDERS_HIDE_CUSTOMER`.

No payload.

### CraftingordersOrderCancelResponse

Fires as `CRAFTINGORDERS_ORDER_CANCEL_RESPONSE`.

```lua
payload: result: CraftingOrderResult
```

### CraftingordersOrderPlacementResponse

Fires as `CRAFTINGORDERS_ORDER_PLACEMENT_RESPONSE`.

```lua
payload: result: CraftingOrderResult
```

### CraftingordersRejectOrderResponse

Fires as `CRAFTINGORDERS_REJECT_ORDER_RESPONSE`.

```lua
payload: result: CraftingOrderResult, orderID: BigUInteger
```

### CraftingordersReleaseOrderResponse

Fires as `CRAFTINGORDERS_RELEASE_ORDER_RESPONSE`.

```lua
payload: result: CraftingOrderResult, orderID: BigUInteger
```

### CraftingordersShowCrafter

Fires as `CRAFTINGORDERS_SHOW_CRAFTER`.

No payload.

### CraftingordersShowCustomer

Fires as `CRAFTINGORDERS_SHOW_CUSTOMER`.

No payload.

### CraftingordersUnexpectedError

Fires as `CRAFTINGORDERS_UNEXPECTED_ERROR`.

No payload.

### CraftingordersUpdateCustomerName

Fires as `CRAFTINGORDERS_UPDATE_CUSTOMER_NAME`.

```lua
payload: customerName: cstring, orderID: BigUInteger
```

### CraftingordersUpdateOrderCount

Fires as `CRAFTINGORDERS_UPDATE_ORDER_COUNT`.

```lua
payload: orderType: CraftingOrderType, numOrders: number
```

### CraftingordersUpdatePersonalOrderCounts

Fires as `CRAFTINGORDERS_UPDATE_PERSONAL_ORDER_COUNTS`.

No payload.

### CraftingordersUpdateRewards

Fires as `CRAFTINGORDERS_UPDATE_REWARDS`.

```lua
payload: npcOrderRewards: table, orderID: BigUInteger
```
