# FrameAPIDressUpModel

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`20` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### Dress

```lua
Dress()
```

### GetAutoDress

```lua
GetAutoDress() -> enabled: bool
```

### GetItemTransmogInfo

```lua
GetItemTransmogInfo(inventorySlot: luaIndex) -> itemTransmogInfo: ItemTransmogInfo
```

### GetItemTransmogInfoList

```lua
GetItemTransmogInfoList() -> infoList: table
```

### GetObeyHideInTransmogFlag

```lua
GetObeyHideInTransmogFlag() -> enabled: bool
```

### GetSheathed

```lua
GetSheathed() -> sheathed: bool
```

### GetUseTransmogChoices

```lua
GetUseTransmogChoices() -> enabled: bool
```

### GetUseTransmogSkin

```lua
GetUseTransmogSkin() -> enabled: bool
```

### IsGeoReady

```lua
IsGeoReady() -> ready: bool
```

### IsSlotAllowed

```lua
IsSlotAllowed(slot: luaIndex) -> allowed: bool
```

### IsSlotVisible

```lua
IsSlotVisible(slot: luaIndex) -> visible: bool
```

### SetAutoDress

```lua
SetAutoDress(enabled: bool)
```

### SetItemTransmogInfo

```lua
SetItemTransmogInfo(itemTransmogInfo: ItemTransmogInfo, inventorySlot?: luaIndex, ignoreChildItems: bool) -> result: ItemTryOnReason
```

### SetObeyHideInTransmogFlag

```lua
SetObeyHideInTransmogFlag(enabled: bool)
```

### SetSheathed

```lua
SetSheathed(sheathed: bool, hideWeapons: bool)
```

### SetUseTransmogChoices

```lua
SetUseTransmogChoices(enabled: bool)
```

### SetUseTransmogSkin

```lua
SetUseTransmogSkin(enabled: bool)
```

### TryOn

```lua
TryOn(linkOrItemModifiedAppearanceID: IDOrLink, handSlotName?: cstring, spellEnchantID?: number) -> result?: ItemTryOnReason
```

### Undress

```lua
Undress()
```

### UndressSlot

```lua
UndressSlot(inventorySlot: luaIndex)
```
