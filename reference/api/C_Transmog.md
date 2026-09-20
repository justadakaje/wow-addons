# C_Transmog

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`7` functions - `15` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanHaveSecondaryAppearanceForSlotID

```lua
C_Transmog.CanHaveSecondaryAppearanceForSlotID(slotID: luaIndex) -> canHaveSecondaryAppearance: bool
```

### ExtractTransmogIDList

```lua
C_Transmog.ExtractTransmogIDList(input: cstring) -> transmogIDList: table
```

### GetAllSetAppearancesByID

```lua
C_Transmog.GetAllSetAppearancesByID(setID: number) -> setItems?: table
```

### GetItemIDForSource

```lua
C_Transmog.GetItemIDForSource(itemModifiedAppearanceID: number) -> itemID?: number
```

### GetSlotForInventoryType

```lua
C_Transmog.GetSlotForInventoryType(inventoryType: luaIndex) -> slot: luaIndex
```

### GetSlotVisualInfo

```lua
C_Transmog.GetSlotVisualInfo(transmogLocation: TransmogLocation) -> slotVisualInfo: TransmogSlotVisualInfo
```

### IsAtTransmogNPC

```lua
C_Transmog.IsAtTransmogNPC() -> isAtNPC: bool
```

## Events

### TransmogCollectionCameraUpdate

Fires as `TRANSMOG_COLLECTION_CAMERA_UPDATE`.

No payload.

### TransmogCollectionItemFavoriteUpdate

Fires as `TRANSMOG_COLLECTION_ITEM_FAVORITE_UPDATE`.

```lua
payload: itemAppearanceID: number, isFavorite: bool
```

### TransmogCollectionItemUpdate

Fires as `TRANSMOG_COLLECTION_ITEM_UPDATE`.

No payload.

### TransmogCollectionSourceAdded

Fires as `TRANSMOG_COLLECTION_SOURCE_ADDED`.

```lua
payload: itemModifiedAppearanceID: number
```

### TransmogCollectionSourceRemoved

Fires as `TRANSMOG_COLLECTION_SOURCE_REMOVED`.

```lua
payload: itemModifiedAppearanceID: number
```

### TransmogCollectionUpdated

Fires as `TRANSMOG_COLLECTION_UPDATED`.

```lua
payload: collectionIndex?: luaIndex, modID?: number, itemAppearanceID?: number, reason?: cstring
```

### TransmogCosmeticCollectionSourceAdded

Fires as `TRANSMOG_COSMETIC_COLLECTION_SOURCE_ADDED`.

```lua
payload: itemModifiedAppearanceID: number
```

### TransmogrifyClose

Fires as `TRANSMOGRIFY_CLOSE`.

No payload.

### TransmogrifyItemUpdate

Fires as `TRANSMOGRIFY_ITEM_UPDATE`.

No payload.

### TransmogrifyOpen

Fires as `TRANSMOGRIFY_OPEN`.

No payload.

### TransmogrifySuccess

Fires as `TRANSMOGRIFY_SUCCESS`.

```lua
payload: transmogLocation: TransmogLocation
```

### TransmogrifyUpdate

Fires as `TRANSMOGRIFY_UPDATE`.

```lua
payload: transmogLocation?: TransmogLocation, action?: cstring
```

### TransmogSearchUpdated

Fires as `TRANSMOG_SEARCH_UPDATED`.

```lua
payload: searchType: TransmogSearchType, collectionType?: TransmogCollectionType
```

### TransmogSetsUpdateFavorite

Fires as `TRANSMOG_SETS_UPDATE_FAVORITE`.

No payload.

### TransmogSourceCollectabilityUpdate

Fires as `TRANSMOG_SOURCE_COLLECTABILITY_UPDATE`.

```lua
payload: itemModifiedAppearanceID: number, collectable: bool
```
