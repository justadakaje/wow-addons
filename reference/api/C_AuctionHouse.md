# C_AuctionHouse

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`85` functions - `47` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CalculateCommodityDeposit

```lua
C_AuctionHouse.CalculateCommodityDeposit(itemID: number, duration: luaIndex, quantity: number) -> depositCost?: number
```

### CalculateItemDeposit

```lua
C_AuctionHouse.CalculateItemDeposit(item: ItemLocation, duration: luaIndex, quantity: number) -> depositCost?: number
```

### CanCancelAuction

```lua
C_AuctionHouse.CanCancelAuction(ownedAuctionID: number) -> canCancelAuction: bool
```

### CancelAuction

```lua
C_AuctionHouse.CancelAuction(ownedAuctionID: number)
```

### CancelCommoditiesPurchase

```lua
C_AuctionHouse.CancelCommoditiesPurchase()
```

### CancelSell

```lua
C_AuctionHouse.CancelSell()
```

### CloseAuctionHouse

```lua
C_AuctionHouse.CloseAuctionHouse()
```

### ConfirmCommoditiesPurchase

```lua
C_AuctionHouse.ConfirmCommoditiesPurchase(itemID: number, quantity: number)
```

### ConfirmPostCommodity

```lua
C_AuctionHouse.ConfirmPostCommodity(item: ItemLocation, duration: luaIndex, quantity: number, unitPrice: BigUInteger)
```

### ConfirmPostItem

```lua
C_AuctionHouse.ConfirmPostItem(item: ItemLocation, duration: luaIndex, quantity: number, bid?: BigUInteger, buyout?: BigUInteger)
```

### FavoritesAreAvailable

```lua
C_AuctionHouse.FavoritesAreAvailable() -> favoritesAreAvailable: bool
```

### GetAuctionInfoByID

```lua
C_AuctionHouse.GetAuctionInfoByID(auctionID: number) -> priceInfo?: AuctionInfo
```

### GetAuctionItemSubClasses

```lua
C_AuctionHouse.GetAuctionItemSubClasses(classID: number) -> subClasses: table
```

### GetAvailablePostCount

```lua
C_AuctionHouse.GetAvailablePostCount(item: ItemLocation) -> listCount: number
```

### GetBidInfo

```lua
C_AuctionHouse.GetBidInfo(bidIndex: luaIndex) -> bid?: BidInfo
```

### GetBids

```lua
C_AuctionHouse.GetBids() -> bids: table
```

### GetBidType

```lua
C_AuctionHouse.GetBidType(bidTypeIndex: luaIndex) -> typeItemKey?: ItemKey
```

### GetBrowseResults

```lua
C_AuctionHouse.GetBrowseResults() -> browseResults: table
```

### GetCancelCost

```lua
C_AuctionHouse.GetCancelCost(ownedAuctionID: number) -> cancelCost: BigUInteger
```

### GetCommoditySearchResultInfo

```lua
C_AuctionHouse.GetCommoditySearchResultInfo(itemID: number, commoditySearchResultIndex: luaIndex) -> result?: CommoditySearchResultInfo
```

### GetCommoditySearchResultsQuantity

```lua
C_AuctionHouse.GetCommoditySearchResultsQuantity(itemID: number) -> totalQuantity: number
```

### GetExtraBrowseInfo

```lua
C_AuctionHouse.GetExtraBrowseInfo(itemKey: ItemKey) -> extraInfo: number
```

### GetFilterGroups

```lua
C_AuctionHouse.GetFilterGroups() -> filterGroups: table
```

### GetItemCommodityStatus

```lua
C_AuctionHouse.GetItemCommodityStatus(item: ItemLocation) -> isCommodity: ItemCommodityStatus
```

### GetItemKeyFromItem

```lua
C_AuctionHouse.GetItemKeyFromItem(item: ItemLocation) -> itemKey: ItemKey
```

### GetItemKeyInfo

```lua
C_AuctionHouse.GetItemKeyInfo(itemKey: ItemKey, restrictQualityToFilter: bool) -> itemKeyInfo?: ItemKeyInfo
```

### GetItemKeyRequiredLevel

```lua
C_AuctionHouse.GetItemKeyRequiredLevel(itemKey: ItemKey) -> requiredLevel: number
```

### GetItemSearchResultInfo

```lua
C_AuctionHouse.GetItemSearchResultInfo(itemKey: ItemKey, itemSearchResultIndex: luaIndex) -> result?: ItemSearchResultInfo
```

### GetItemSearchResultsQuantity

```lua
C_AuctionHouse.GetItemSearchResultsQuantity(itemKey: ItemKey) -> totalQuantity: number
```

### GetMaxBidItemBid

```lua
C_AuctionHouse.GetMaxBidItemBid() -> maxBid?: BigUInteger
```

### GetMaxBidItemBuyout

```lua
C_AuctionHouse.GetMaxBidItemBuyout() -> maxBuyout?: BigUInteger
```

### GetMaxCommoditySearchResultPrice

```lua
C_AuctionHouse.GetMaxCommoditySearchResultPrice(itemID: number) -> maxUnitPrice?: BigUInteger
```

### GetMaxItemSearchResultBid

```lua
C_AuctionHouse.GetMaxItemSearchResultBid(itemKey: ItemKey) -> maxBid?: BigUInteger
```

### GetMaxItemSearchResultBuyout

```lua
C_AuctionHouse.GetMaxItemSearchResultBuyout(itemKey: ItemKey) -> maxBuyout?: BigUInteger
```

### GetMaxOwnedAuctionBid

```lua
C_AuctionHouse.GetMaxOwnedAuctionBid() -> maxBid?: BigUInteger
```

### GetMaxOwnedAuctionBuyout

```lua
C_AuctionHouse.GetMaxOwnedAuctionBuyout() -> maxBuyout?: BigUInteger
```

### GetNumBids

```lua
C_AuctionHouse.GetNumBids() -> numBids: number
```

### GetNumBidTypes

```lua
C_AuctionHouse.GetNumBidTypes() -> numBidTypes: number
```

### GetNumCommoditySearchResults

```lua
C_AuctionHouse.GetNumCommoditySearchResults(itemID: number) -> numSearchResults: number
```

### GetNumItemSearchResults

```lua
C_AuctionHouse.GetNumItemSearchResults(itemKey: ItemKey) -> numItemSearchResults: number
```

### GetNumOwnedAuctions

```lua
C_AuctionHouse.GetNumOwnedAuctions() -> numOwnedAuctions: number
```

### GetNumOwnedAuctionTypes

```lua
C_AuctionHouse.GetNumOwnedAuctionTypes() -> numOwnedAuctionTypes: number
```

### GetNumReplicateItems

```lua
C_AuctionHouse.GetNumReplicateItems() -> numReplicateItems: number
```

### GetOwnedAuctionInfo

```lua
C_AuctionHouse.GetOwnedAuctionInfo(ownedAuctionIndex: luaIndex) -> ownedAuction?: OwnedAuctionInfo
```

### GetOwnedAuctions

```lua
C_AuctionHouse.GetOwnedAuctions() -> ownedAuctions: table
```

### GetOwnedAuctionType

```lua
C_AuctionHouse.GetOwnedAuctionType(ownedAuctionTypeIndex: luaIndex) -> typeItemKey?: ItemKey
```

### GetQuoteDurationRemaining

```lua
C_AuctionHouse.GetQuoteDurationRemaining() -> quoteDurationSeconds: number
```

### GetReplicateItemBattlePetInfo

```lua
C_AuctionHouse.GetReplicateItemBattlePetInfo(index: number) -> creatureID: number, displayID: number
```

### GetReplicateItemInfo

```lua
C_AuctionHouse.GetReplicateItemInfo(index: number) -> name?: string, texture?: fileID, count: number, qualityID: number, usable?: bool, level: number, levelType?: string, minBid: BigUInteger, minIncrement: BigUInteger, buyoutPrice: BigUInteger, bidAmount: BigUInteger, highBidder?: string, bidderFullName?: string, owner?: string, ownerFullName?: string, saleStatus: number, itemID: number, hasAllInfo?: bool
```

### GetReplicateItemLink

```lua
C_AuctionHouse.GetReplicateItemLink(index: number) -> itemLink?: string
```

### GetReplicateItemTimeLeft

```lua
C_AuctionHouse.GetReplicateItemTimeLeft(index: number) -> timeLeft: number
```

### GetTimeLeftBandInfo

```lua
C_AuctionHouse.GetTimeLeftBandInfo(timeLeftBand: AuctionHouseTimeLeftBand) -> timeLeftMinSeconds: number, timeLeftMaxSeconds: number
```

### HasFavorites

```lua
C_AuctionHouse.HasFavorites() -> hasFavorites: bool
```

### HasFullBidResults

```lua
C_AuctionHouse.HasFullBidResults() -> hasFullBidResults: bool
```

### HasFullBrowseResults

```lua
C_AuctionHouse.HasFullBrowseResults() -> hasFullBrowseResults: bool
```

### HasFullCommoditySearchResults

```lua
C_AuctionHouse.HasFullCommoditySearchResults(itemID: number) -> hasFullResults: bool
```

### HasFullItemSearchResults

```lua
C_AuctionHouse.HasFullItemSearchResults(itemKey: ItemKey) -> hasFullResults: bool
```

### HasFullOwnedAuctionResults

```lua
C_AuctionHouse.HasFullOwnedAuctionResults() -> hasFullOwnedAuctionResults: bool
```

### HasMaxFavorites

```lua
C_AuctionHouse.HasMaxFavorites() -> hasMaxFavorites: bool
```

### HasSearchResults

```lua
C_AuctionHouse.HasSearchResults(itemKey: ItemKey) -> hasSearchResults: bool
```

### IsFavoriteItem

```lua
C_AuctionHouse.IsFavoriteItem(itemKey: ItemKey) -> isFavorite: bool
```

### IsSellItemValid

```lua
C_AuctionHouse.IsSellItemValid(item: ItemLocation, displayError: bool) -> valid: bool
```

### IsThrottledMessageSystemReady

```lua
C_AuctionHouse.IsThrottledMessageSystemReady() -> canSendThrottledMessage: bool
```

### MakeItemKey

```lua
C_AuctionHouse.MakeItemKey(itemID: number, itemLevel: number, itemSuffix: number, battlePetSpeciesID: number) -> itemKey: ItemKey
```

### PlaceBid

```lua
C_AuctionHouse.PlaceBid(auctionID: number, bidAmount: BigUInteger)
```

### PostCommodity

```lua
C_AuctionHouse.PostCommodity(item: ItemLocation, duration: luaIndex, quantity: number, unitPrice: BigUInteger) -> needsConfirmation: bool
```

### PostItem

```lua
C_AuctionHouse.PostItem(item: ItemLocation, duration: luaIndex, quantity: number, bid?: BigUInteger, buyout?: BigUInteger) -> needsConfirmation: bool
```

### QueryBids

```lua
C_AuctionHouse.QueryBids(sorts: table, auctionIDs: table)
```

### QueryOwnedAuctions

```lua
C_AuctionHouse.QueryOwnedAuctions(sorts: table)
```

### RefreshCommoditySearchResults

```lua
C_AuctionHouse.RefreshCommoditySearchResults(itemID: number)
```

### RefreshItemSearchResults

```lua
C_AuctionHouse.RefreshItemSearchResults(itemKey: ItemKey, minLevelFilter?: number, maxLevelFilter?: number)
```

### ReplicateItems

```lua
C_AuctionHouse.ReplicateItems()
```

### RequestMoreBrowseResults

```lua
C_AuctionHouse.RequestMoreBrowseResults()
```

### RequestMoreCommoditySearchResults

```lua
C_AuctionHouse.RequestMoreCommoditySearchResults(itemID: number) -> hasFullResults: bool
```

### RequestMoreItemSearchResults

```lua
C_AuctionHouse.RequestMoreItemSearchResults(itemKey: ItemKey) -> hasFullResults: bool
```

### RequestOwnedAuctionBidderInfo

```lua
C_AuctionHouse.RequestOwnedAuctionBidderInfo(auctionID: number) -> bidderName: cstring
```

### SearchForFavorites

```lua
C_AuctionHouse.SearchForFavorites(sorts: table)
```

### SearchForItemKeys

```lua
C_AuctionHouse.SearchForItemKeys(itemKeys: table, sorts: table)
```

### SendBrowseQuery

```lua
C_AuctionHouse.SendBrowseQuery(query: AuctionHouseBrowseQuery)
```

### SendSearchQuery

```lua
C_AuctionHouse.SendSearchQuery(itemKey: ItemKey, sorts: table, separateOwnerItems: bool, minLevelFilter: number, maxLevelFilter: number)
```

### SendSellSearchQuery

```lua
C_AuctionHouse.SendSellSearchQuery(itemKey: ItemKey, sorts: table, separateOwnerItems: bool)
```

### SetFavoriteItem

```lua
C_AuctionHouse.SetFavoriteItem(itemKey: ItemKey, setFavorite: bool)
```

### ShouldAutoPopulatePrice

```lua
C_AuctionHouse.ShouldAutoPopulatePrice() -> shouldAutoPopulatePrice: bool
```

### StartCommoditiesPurchase

```lua
C_AuctionHouse.StartCommoditiesPurchase(itemID: number, quantity: number)
```

### SupportsCopperValues

```lua
C_AuctionHouse.SupportsCopperValues() -> supportsCopperValues: bool
```

## Events

### AuctionCanceled

Fires as `AUCTION_CANCELED`.

```lua
payload: auctionID: number
```

### AuctionHouseAuctionCreated

Fires as `AUCTION_HOUSE_AUCTION_CREATED`.

```lua
payload: auctionID: number
```

### AuctionHouseAuctionsExpired

Fires as `AUCTION_HOUSE_AUCTIONS_EXPIRED`.

```lua
payload: auctionID: number
```

### AuctionHouseBrowseFailure

Fires as `AUCTION_HOUSE_BROWSE_FAILURE`.

No payload.

### AuctionHouseBrowseResultsAdded

Fires as `AUCTION_HOUSE_BROWSE_RESULTS_ADDED`.

```lua
payload: addedBrowseResults: table
```

### AuctionHouseBrowseResultsUpdated

Fires as `AUCTION_HOUSE_BROWSE_RESULTS_UPDATED`.

No payload.

### AuctionHouseClosed

Fires as `AUCTION_HOUSE_CLOSED`.

No payload.

### AuctionHouseDisabled

Fires as `AUCTION_HOUSE_DISABLED`.

No payload.

### AuctionHouseFavoritesUpdated

Fires as `AUCTION_HOUSE_FAVORITES_UPDATED`.

No payload.

### AuctionHouseItemDeliveryDelayUpdate

Fires as `AUCTION_HOUSE_ITEM_DELIVERY_DELAY_UPDATE`.

```lua
payload: purchasedItemDeliveryDelay: number, cancelledItemDeliveryDelay: number
```

### AuctionHouseNewBidReceived

Fires as `AUCTION_HOUSE_NEW_BID_RECEIVED`.

```lua
payload: auctionID: number
```

### AuctionHouseNewResultsReceived

Fires as `AUCTION_HOUSE_NEW_RESULTS_RECEIVED`.

```lua
payload: itemKey?: ItemKey
```

### AuctionHousePostError

Fires as `AUCTION_HOUSE_POST_ERROR`.

No payload.

### AuctionHousePostWarning

Fires as `AUCTION_HOUSE_POST_WARNING`.

No payload.

### AuctionHousePurchaseCompleted

Fires as `AUCTION_HOUSE_PURCHASE_COMPLETED`.

```lua
payload: auctionID: number
```

### AuctionHouseScriptDeprecated

Fires as `AUCTION_HOUSE_SCRIPT_DEPRECATED`.

No payload.

### AuctionHouseShow

Fires as `AUCTION_HOUSE_SHOW`.

No payload.

### AuctionHouseShowCommodityWonNotification

Fires as `AUCTION_HOUSE_SHOW_COMMODITY_WON_NOTIFICATION`.

```lua
payload: commodityName: string, commodityQuantity: number
```

### AuctionHouseShowError

Fires as `AUCTION_HOUSE_SHOW_ERROR`.

```lua
payload: error: AuctionHouseError
```

### AuctionHouseShowFormattedNotification

Fires as `AUCTION_HOUSE_SHOW_FORMATTED_NOTIFICATION`.

```lua
payload: notification: AuctionHouseNotification, text: string, auctionID?: number
```

### AuctionHouseShowNotification

Fires as `AUCTION_HOUSE_SHOW_NOTIFICATION`.

```lua
payload: notification: AuctionHouseNotification
```

### AuctionHouseThrottledMessageDropped

Fires as `AUCTION_HOUSE_THROTTLED_MESSAGE_DROPPED`.

No payload.

### AuctionHouseThrottledMessageQueued

Fires as `AUCTION_HOUSE_THROTTLED_MESSAGE_QUEUED`.

No payload.

### AuctionHouseThrottledMessageResponseReceived

Fires as `AUCTION_HOUSE_THROTTLED_MESSAGE_RESPONSE_RECEIVED`.

No payload.

### AuctionHouseThrottledMessageSent

Fires as `AUCTION_HOUSE_THROTTLED_MESSAGE_SENT`.

No payload.

### AuctionHouseThrottledSystemReady

Fires as `AUCTION_HOUSE_THROTTLED_SYSTEM_READY`.

No payload.

### AuctionMultisellFailure

Fires as `AUCTION_MULTISELL_FAILURE`.

No payload.

### AuctionMultisellStart

Fires as `AUCTION_MULTISELL_START`.

```lua
payload: numRepetitions: number
```

### AuctionMultisellUpdate

Fires as `AUCTION_MULTISELL_UPDATE`.

```lua
payload: createdCount: number, totalToCreate: number
```

### BidAdded

Fires as `BID_ADDED`.

```lua
payload: bidID: number
```

### BidsUpdated

Fires as `BIDS_UPDATED`.

No payload.

### CommodityPriceUnavailable

Fires as `COMMODITY_PRICE_UNAVAILABLE`.

No payload.

### CommodityPriceUpdated

Fires as `COMMODITY_PRICE_UPDATED`.

```lua
payload: updatedUnitPrice: BigUInteger, updatedTotalPrice: BigUInteger
```

### CommodityPurchased

Fires as `COMMODITY_PURCHASED`.

```lua
payload: itemID: number, quantity: number
```

### CommodityPurchaseFailed

Fires as `COMMODITY_PURCHASE_FAILED`.

No payload.

### CommodityPurchaseSucceeded

Fires as `COMMODITY_PURCHASE_SUCCEEDED`.

No payload.

### CommoditySearchResultsAdded

Fires as `COMMODITY_SEARCH_RESULTS_ADDED`.

```lua
payload: itemID: number
```

### CommoditySearchResultsReceived

Fires as `COMMODITY_SEARCH_RESULTS_RECEIVED`.

No payload.

### CommoditySearchResultsUpdated

Fires as `COMMODITY_SEARCH_RESULTS_UPDATED`.

```lua
payload: itemID: number
```

### ExtraBrowseInfoReceived

Fires as `EXTRA_BROWSE_INFO_RECEIVED`.

```lua
payload: itemID: number
```

### ItemKeyItemInfoReceived

Fires as `ITEM_KEY_ITEM_INFO_RECEIVED`.

```lua
payload: itemID: number
```

### ItemPurchased

Fires as `ITEM_PURCHASED`.

```lua
payload: itemID: number
```

### ItemSearchResultsAdded

Fires as `ITEM_SEARCH_RESULTS_ADDED`.

```lua
payload: itemKey: ItemKey
```

### ItemSearchResultsUpdated

Fires as `ITEM_SEARCH_RESULTS_UPDATED`.

```lua
payload: itemKey: ItemKey, newAuctionID?: number
```

### OwnedAuctionBidderInfoReceived

Fires as `OWNED_AUCTION_BIDDER_INFO_RECEIVED`.

```lua
payload: auctionID: number, bidderName: cstring
```

### OwnedAuctionsUpdated

Fires as `OWNED_AUCTIONS_UPDATED`.

No payload.

### ReplicateItemListUpdate

Fires as `REPLICATE_ITEM_LIST_UPDATE`.

No payload.
