# C_HousingNeighborhood

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`30` functions - `13` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CancelInviteToNeighborhood

```lua
C_HousingNeighborhood.CancelInviteToNeighborhood(playerName: cstring)
```

### CanReturnAfterVisitingHouse

```lua
C_HousingNeighborhood.CanReturnAfterVisitingHouse() -> canReturn: bool
```

### DemoteToResident

```lua
C_HousingNeighborhood.DemoteToResident(playerGUID: WOWGUID)
```

### GetCornerstoneHouseInfo

```lua
C_HousingNeighborhood.GetCornerstoneHouseInfo() -> houseInfo: HouseInfo
```

### GetCornerstoneNeighborhoodInfo

```lua
C_HousingNeighborhood.GetCornerstoneNeighborhoodInfo() -> neighborhoodInfo: NeighborhoodInfo
```

### GetCornerstonePurchaseMode

```lua
C_HousingNeighborhood.GetCornerstonePurchaseMode() -> purchaseMode: CornerstonePurchaseMode
```

### GetCurrentNeighborhoodTextureSuffix

```lua
C_HousingNeighborhood.GetCurrentNeighborhoodTextureSuffix() -> neighborhoodTextureSuffix: cstring
```

### GetDiscountedMovePrice

```lua
C_HousingNeighborhood.GetDiscountedMovePrice() -> movePrice: number
```

### GetMoveCooldownTime

```lua
C_HousingNeighborhood.GetMoveCooldownTime() -> movecooldownTime: number
```

### GetNeighborhoodMapData

```lua
C_HousingNeighborhood.GetNeighborhoodMapData() -> neighborhoodPlots: table
```

### GetNeighborhoodName

```lua
C_HousingNeighborhood.GetNeighborhoodName() -> neighborhoodName: string
```

### GetNeighborhoodPlotName

```lua
C_HousingNeighborhood.GetNeighborhoodPlotName(plotIndex: number) -> neighborhoodName: string
```

### GetPreviousHouseIdentifier

```lua
C_HousingNeighborhood.GetPreviousHouseIdentifier() -> previousHouseIdentifier: string
```

### HasPermissionToPurchase

```lua
C_HousingNeighborhood.HasPermissionToPurchase() -> cantPurchaseReason: PurchaseHouseDisabledReason
```

### InvitePlayerToNeighborhood

```lua
C_HousingNeighborhood.InvitePlayerToNeighborhood(playerName: cstring)
```

### IsNeighborhoodManager

```lua
C_HousingNeighborhood.IsNeighborhoodManager() -> isManager: bool
```

### IsNeighborhoodOwner

```lua
C_HousingNeighborhood.IsNeighborhoodOwner() -> isOwner: bool
```

### IsPlayerInOtherPlayersPlot

```lua
C_HousingNeighborhood.IsPlayerInOtherPlayersPlot() -> isInUnownedPlot: bool
```

### IsPlotAvailableForPurchase

```lua
C_HousingNeighborhood.IsPlotAvailableForPurchase() -> isAvailable: bool
```

### IsPlotOwnedByPlayer

```lua
C_HousingNeighborhood.IsPlotOwnedByPlayer() -> isPlayerOwned: bool
```

### OnBulletinBoardClosed

```lua
C_HousingNeighborhood.OnBulletinBoardClosed()
```

### OnCornerstoneClosed

```lua
C_HousingNeighborhood.OnCornerstoneClosed()
```

### PromoteToManager

```lua
C_HousingNeighborhood.PromoteToManager(playerGUID: WOWGUID)
```

### RequestNeighborhoodInfo

```lua
C_HousingNeighborhood.RequestNeighborhoodInfo()
```

### RequestNeighborhoodRoster

```lua
C_HousingNeighborhood.RequestNeighborhoodRoster()
```

### RequestPendingNeighborhoodInvites

```lua
C_HousingNeighborhood.RequestPendingNeighborhoodInvites()
```

### TransferNeighborhoodOwnership

```lua
C_HousingNeighborhood.TransferNeighborhoodOwnership(playerGUID: WOWGUID)
```

### TryEvictPlayer

```lua
C_HousingNeighborhood.TryEvictPlayer(plotID: number)
```

### TryMoveHouse

```lua
C_HousingNeighborhood.TryMoveHouse()
```

### TryPurchasePlot

```lua
C_HousingNeighborhood.TryPurchasePlot()
```

## Events

### CancelNeighborhoodInviteResponse

Fires as `CANCEL_NEIGHBORHOOD_INVITE_RESPONSE`.

```lua
payload: result: NeighborhoodInviteResult, playerName?: cstring
```

### ClosePlotCornerstone

Fires as `CLOSE_PLOT_CORNERSTONE`.

No payload.

### NeighborhoodInfoUpdated

Fires as `NEIGHBORHOOD_INFO_UPDATED`.

```lua
payload: neighborhoodInfo: NeighborhoodInfo
```

### NeighborhoodInviteResponse

Fires as `NEIGHBORHOOD_INVITE_RESPONSE`.

```lua
payload: result: NeighborhoodInviteResult
```

### NeighborhoodMapDataUpdated

Fires as `NEIGHBORHOOD_MAP_DATA_UPDATED`.

No payload.

### NeighborhoodNameUpdated

Fires as `NEIGHBORHOOD_NAME_UPDATED`.

```lua
payload: neighborhoodGuid: WOWGUID, neighborhoodName: cstring
```

### OpenPlotCornerstone

Fires as `OPEN_PLOT_CORNERSTONE`.

No payload.

### PendingNeighborhoodInvitesRecieved

Fires as `PENDING_NEIGHBORHOOD_INVITES_RECIEVED`.

```lua
payload: result: NeighborhoodInviteResult, pendingInviteList?: table
```

### PurchasePlotResult

Fires as `PURCHASE_PLOT_RESULT`.

```lua
payload: result: number
```

### ShowPlayerEvictedDialog

Fires as `SHOW_PLAYER_EVICTED_DIALOG`.

No payload.

### UpdateBulletinBoardMemberType

Fires as `UPDATE_BULLETIN_BOARD_MEMBER_TYPE`.

```lua
payload: player: WOWGUID, residentType: ResidentType
```

### UpdateBulletinBoardRoster

Fires as `UPDATE_BULLETIN_BOARD_ROSTER`.

```lua
payload: neighborhoodInfo: NeighborhoodInfo, rosterMemberList: table
```

### UpdateBulletinBoardRosterStatuses

Fires as `UPDATE_BULLETIN_BOARD_ROSTER_STATUSES`.

```lua
payload: rosterMemberList: table
```
