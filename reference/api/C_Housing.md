# C_Housing

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`62` functions - `39` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AcceptNeighborhoodOwnership

```lua
C_Housing.AcceptNeighborhoodOwnership()
```

### CanEditCharter

```lua
C_Housing.CanEditCharter() -> canEditCharter: bool
```

### CanTakeReportScreenshot

```lua
C_Housing.CanTakeReportScreenshot(plotIndex: number) -> reason: InvalidPlotScreenshotReason
```

### CreateGuildNeighborhood

```lua
C_Housing.CreateGuildNeighborhood(neighborhoodName: cstring)
```

### CreateNeighborhoodCharter

```lua
C_Housing.CreateNeighborhoodCharter(neighborhoodName: cstring)
```

### DeclineNeighborhoodOwnership

```lua
C_Housing.DeclineNeighborhoodOwnership()
```

### DoesFactionMatchNeighborhood

```lua
C_Housing.DoesFactionMatchNeighborhood(neighborhoodGUID: WOWGUID) -> factionMatches: bool
```

### EditNeighborhoodCharter

```lua
C_Housing.EditNeighborhoodCharter(neighborhoodName: cstring)
```

### GetCurrentHouseInfo

```lua
C_Housing.GetCurrentHouseInfo() -> houseInfo?: HouseInfo
```

### GetCurrentHouseLevelFavor

```lua
C_Housing.GetCurrentHouseLevelFavor(houseGuid: WOWGUID)
```

### GetCurrentHouseRefundAmount

```lua
C_Housing.GetCurrentHouseRefundAmount() -> refundAmount: number
```

### GetCurrentNeighborhoodGUID

```lua
C_Housing.GetCurrentNeighborhoodGUID() -> neighborhoodGUID?: WOWGUID
```

### GetHouseLevelFavorForLevel

```lua
C_Housing.GetHouseLevelFavorForLevel(level: number) -> houseFavor: number
```

### GetHouseLevelRewardsForLevel

```lua
C_Housing.GetHouseLevelRewardsForLevel(level: number)
```

### GetHousingAccessFlags

```lua
C_Housing.GetHousingAccessFlags() -> accessFlags: HouseSettingFlags
```

### GetMaxHouseLevel

```lua
C_Housing.GetMaxHouseLevel() -> level: number
```

### GetNeighborhoodTextureSuffix

```lua
C_Housing.GetNeighborhoodTextureSuffix(neighborhoodGUID: WOWGUID) -> neighborhoodTextureSuffix: cstring
```

### GetOthersOwnedHouses

```lua
C_Housing.GetOthersOwnedHouses(playerGUID?: WOWGUID, bnetID?: number, isInPlayersGuild: bool)
```

### GetPlayerOwnedHouses

```lua
C_Housing.GetPlayerOwnedHouses()
```

### GetTrackedHouseGuid

```lua
C_Housing.GetTrackedHouseGuid() -> trackedHouse?: WOWGUID
```

### GetUIMapIDForNeighborhood

```lua
C_Housing.GetUIMapIDForNeighborhood(neighborhoodGuid: WOWGUID) -> uiMapID?: number
```

### GetVisitCooldownInfo

```lua
C_Housing.GetVisitCooldownInfo() -> spellCooldownInfo: SpellCooldownInfo
```

### HasHousingExpansionAccess

```lua
C_Housing.HasHousingExpansionAccess() -> hasAccess: bool
```

### HouseFinderDeclineNeighborhoodInvitation

```lua
C_Housing.HouseFinderDeclineNeighborhoodInvitation()
```

### HouseFinderIgnoreNeighborhood

```lua
C_Housing.HouseFinderIgnoreNeighborhood(neighborhoodGuid: WOWGUID)
```

### HouseFinderRequestNeighborhoods

```lua
C_Housing.HouseFinderRequestNeighborhoods()
```

### HouseFinderRequestReservationAndPort

```lua
C_Housing.HouseFinderRequestReservationAndPort(neighborhoodGuid: WOWGUID, plotID: number)
```

### IsHousingMarketCartFullRemoveEnabled

```lua
C_Housing.IsHousingMarketCartFullRemoveEnabled() -> isHousingMarketCartFullRemoveEnabled: bool
```

### IsHousingMarketEnabled

```lua
C_Housing.IsHousingMarketEnabled() -> isHousingMarketEnabled: bool
```

### IsHousingMarketShopEnabled

```lua
C_Housing.IsHousingMarketShopEnabled() -> isHousingMarketShopEnabled: bool
```

### IsHousingServiceEnabled

```lua
C_Housing.IsHousingServiceEnabled() -> isAvailable: bool
```

### IsInsideHouse

```lua
C_Housing.IsInsideHouse() -> isInside: bool
```

### IsInsideHouseOrPlot

```lua
C_Housing.IsInsideHouseOrPlot() -> isInside: bool
```

### IsInsideOwnedHouse

```lua
C_Housing.IsInsideOwnedHouse() -> isInsideOwnedHouse: bool
```

### IsInsideOwnedHouseOrPlot

```lua
C_Housing.IsInsideOwnedHouseOrPlot() -> isInsideOwnedHouseOrPlot: bool
```

### IsInsideOwnedPlot

```lua
C_Housing.IsInsideOwnedPlot() -> isInside: bool
```

### IsInsidePlot

```lua
C_Housing.IsInsidePlot() -> isInside: bool
```

### IsOnNeighborhoodMap

```lua
C_Housing.IsOnNeighborhoodMap() -> isOnNeighborhoodMap: bool
```

### LeaveHouse

```lua
C_Housing.LeaveHouse()
```

### OnCharterConfirmationAccepted

```lua
C_Housing.OnCharterConfirmationAccepted()
```

### OnCharterConfirmationClosed

```lua
C_Housing.OnCharterConfirmationClosed()
```

### OnCreateCharterNeighborhoodClosed

```lua
C_Housing.OnCreateCharterNeighborhoodClosed()
```

### OnCreateGuildNeighborhoodClosed

```lua
C_Housing.OnCreateGuildNeighborhoodClosed()
```

### OnHouseFinderClickPlot

```lua
C_Housing.OnHouseFinderClickPlot(plotID: number)
```

### OnRequestSignatureClicked

```lua
C_Housing.OnRequestSignatureClicked()
```

### OnSignCharterClicked

```lua
C_Housing.OnSignCharterClicked(charterOwnerGUID: WOWGUID)
```

### RelinquishHouse

```lua
C_Housing.RelinquishHouse(houseGuid: WOWGUID)
```

### RequestCurrentHouseInfo

```lua
C_Housing.RequestCurrentHouseInfo()
```

### RequestHouseFinderNeighborhoodData

```lua
C_Housing.RequestHouseFinderNeighborhoodData(neighborhoodGuid: WOWGUID, neighborhoodName: cstring)
```

### RequestPlayerCharacterList

```lua
C_Housing.RequestPlayerCharacterList()
```

### ResetHouse

```lua
C_Housing.ResetHouse(resetScope: HousingHouseScope)
```

### ReturnAfterVisitingHouse

```lua
C_Housing.ReturnAfterVisitingHouse()
```

### SaveHouseSettings

```lua
C_Housing.SaveHouseSettings(playerGUID: WOWGUID, accessFlags: HouseSettingFlags)
```

### SearchBNetFriendNeighborhoods

```lua
C_Housing.SearchBNetFriendNeighborhoods(bnetName: cstring) -> isValidBnetFriend: bool
```

### SearchBNetFriendNeighborhoodsByID

```lua
C_Housing.SearchBNetFriendNeighborhoodsByID(bnetID: number) -> isValidBnetFriend: bool
```

### SetTrackedHouseGuid

```lua
C_Housing.SetTrackedHouseGuid(trackedHouse?: WOWGUID)
```

### StartTutorial

```lua
C_Housing.StartTutorial()
```

### TeleportHome

```lua
C_Housing.TeleportHome(neighborhoodGUID: WOWGUID, houseGUID: WOWGUID, plotID: number)
```

### TryRenameNeighborhood

```lua
C_Housing.TryRenameNeighborhood(neighborhoodName: cstring)
```

### ValidateCreateGuildNeighborhoodSize

```lua
C_Housing.ValidateCreateGuildNeighborhoodSize()
```

### ValidateNeighborhoodName

```lua
C_Housing.ValidateNeighborhoodName(neighborhoodName: cstring)
```

### VisitHouse

```lua
C_Housing.VisitHouse(neighborhoodGUID: WOWGUID, houseGUID: WOWGUID, plotID: number)
```

## Events

### AddNeighborhoodCharterSignature

Fires as `ADD_NEIGHBORHOOD_CHARTER_SIGNATURE`.

```lua
payload: signature: cstring
```

### BNetNeighborhoodListUpdated

Fires as `B_NET_NEIGHBORHOOD_LIST_UPDATED`.

```lua
payload: result: HousingResult, neighborhoodInfos?: table
```

### CloseCharterConfirmationUI

Fires as `CLOSE_CHARTER_CONFIRMATION_UI`.

No payload.

### CloseCreateCharterNeighborhoodUI

Fires as `CLOSE_CREATE_CHARTER_NEIGHBORHOOD_UI`.

No payload.

### CloseCreateGuildNeighborhoodUI

Fires as `CLOSE_CREATE_GUILD_NEIGHBORHOOD_UI`.

No payload.

### CreateNeighborhoodResult

Fires as `CREATE_NEIGHBORHOOD_RESULT`.

```lua
payload: result: HousingResult, neighborhoodName?: cstring
```

### CurrentHouseInfoRecieved

Fires as `CURRENT_HOUSE_INFO_RECIEVED`.

```lua
payload: houseInfo: HouseInfo
```

### CurrentHouseInfoUpdated

Fires as `CURRENT_HOUSE_INFO_UPDATED`.

```lua
payload: houseInfo: HouseInfo
```

### DeclineNeighborhoodInvitationResponse

Fires as `DECLINE_NEIGHBORHOOD_INVITATION_RESPONSE`.

```lua
payload: success: bool
```

### ForceRefreshHouseFinder

Fires as `FORCE_REFRESH_HOUSE_FINDER`.

No payload.

### HouseFinderNeighborhoodDataRecieved

Fires as `HOUSE_FINDER_NEIGHBORHOOD_DATA_RECIEVED`.

```lua
payload: neighborhoodPlots: table
```

### HouseInfoUpdated

Fires as `HOUSE_INFO_UPDATED`.

No payload.

### HouseLevelChanged

Fires as `HOUSE_LEVEL_CHANGED`.

```lua
payload: newHouseLevelInfo?: HouseLevelInfo
```

### HouseLevelFavorUpdated

Fires as `HOUSE_LEVEL_FAVOR_UPDATED`.

```lua
payload: houseLevelFavor: HouseLevelFavor
```

### HousePlotEntered

Fires as `HOUSE_PLOT_ENTERED`.

No payload.

### HousePlotExited

Fires as `HOUSE_PLOT_EXITED`.

No payload.

### HouseReservationResponseRecieved

Fires as `HOUSE_RESERVATION_RESPONSE_RECIEVED`.

```lua
payload: result: HousingResult
```

### HouseResetCompleted

Fires as `HOUSE_RESET_COMPLETED`.

No payload.

### HouseResetFailed

Fires as `HOUSE_RESET_FAILED`.

```lua
payload: result: HousingResult
```

### HousingMarketAvailabilityUpdated

Fires as `HOUSING_MARKET_AVAILABILITY_UPDATED`.

No payload.

### HousingServicesAvailabilityUpdated

Fires as `HOUSING_SERVICES_AVAILABILITY_UPDATED`.

No payload.

### IgnoreNeighborhoodResponse

Fires as `IGNORE_NEIGHBORHOOD_RESPONSE`.

```lua
payload: success: bool, neighborhoodGuid: WOWGUID
```

### MoveOutReservationUpdated

Fires as `MOVE_OUT_RESERVATION_UPDATED`.

No payload.

### NeighborhoodGuildSizeValidated

Fires as `NEIGHBORHOOD_GUILD_SIZE_VALIDATED`.

```lua
payload: approved: bool
```

### NeighborhoodListUpdated

Fires as `NEIGHBORHOOD_LIST_UPDATED`.

```lua
payload: result: HousingResult, neighborhoodInfos?: table
```

### NeighborhoodNameValidated

Fires as `NEIGHBORHOOD_NAME_VALIDATED`.

```lua
payload: approved: bool
```

### NewHousingItemAcquired

Fires as `NEW_HOUSING_ITEM_ACQUIRED`.

```lua
payload: itemType: HousingItemToastType, itemName: cstring, icon?: fileID
```

### OpenCharterConfirmationUI

Fires as `OPEN_CHARTER_CONFIRMATION_UI`.

```lua
payload: neighborhoodName: string, locationName: string
```

### OpenCreateCharterNeighborhoodUI

Fires as `OPEN_CREATE_CHARTER_NEIGHBORHOOD_UI`.

```lua
payload: locationName: cstring
```

### OpenCreateGuildNeighborhoodUI

Fires as `OPEN_CREATE_GUILD_NEIGHBORHOOD_UI`.

```lua
payload: locationName: cstring
```

### OpenNeighborhoodCharter

Fires as `OPEN_NEIGHBORHOOD_CHARTER`.

```lua
payload: neighborhoodInfo: NeighborhoodInfo, signatures: table, requiredSignatures: number
```

### OpenNeighborhoodCharterSignatureRequest

Fires as `OPEN_NEIGHBORHOOD_CHARTER_SIGNATURE_REQUEST`.

```lua
payload: neighborhoodInfo: NeighborhoodInfo
```

### PlayerCharacterListUpdated

Fires as `PLAYER_CHARACTER_LIST_UPDATED`.

```lua
payload: characterInfos: table, ownerListIndex: number
```

### PlayerHouseListUpdated

Fires as `PLAYER_HOUSE_LIST_UPDATED`.

```lua
payload: houseInfos: table
```

### ReceivedHouseLevelRewards

Fires as `RECEIVED_HOUSE_LEVEL_REWARDS`.

```lua
payload: level: number, rewards: table
```

### RemoveNeighborhoodCharterSignature

Fires as `REMOVE_NEIGHBORHOOD_CHARTER_SIGNATURE`.

```lua
payload: signature: cstring
```

### ShowNeighborhoodOwnershipTransferDialog

Fires as `SHOW_NEIGHBORHOOD_OWNERSHIP_TRANSFER_DIALOG`.

```lua
payload: neighborhoodName: cstring, cosmeticOwnerName: cstring
```

### TrackedHouseChanged

Fires as `TRACKED_HOUSE_CHANGED`.

```lua
payload: trackedHouse?: WOWGUID
```

### ViewHousesListRecieved

Fires as `VIEW_HOUSES_LIST_RECIEVED`.

```lua
payload: houseInfos: table
```
