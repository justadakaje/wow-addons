# FrameAPIModelSceneFrameActor

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`31` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AttachToMount

```lua
AttachToMount(rider: ModelSceneFrameActor, animation: AnimationDataEnum, spellKitVisualID?: number) -> success: bool
```

### CalculateMountScale

```lua
CalculateMountScale(rider: ModelSceneFrameActor) -> scale: number
```

### DetachFromMount

```lua
DetachFromMount(rider: ModelSceneFrameActor) -> success: bool
```

### Dress

```lua
Dress()
```

### DressPlayerSlot

```lua
DressPlayerSlot(invSlot: luaIndex)
```

### GetAutoDress

```lua
GetAutoDress() -> autoDress: bool
```

### GetItemTransmogInfo

```lua
GetItemTransmogInfo(inventorySlots: number) -> itemTransmogInfo?: ItemTransmogInfo
```

### GetItemTransmogInfoList

```lua
GetItemTransmogInfoList() -> infoList: table
```

### GetObeyHideInTransmogFlag

```lua
GetObeyHideInTransmogFlag() -> obey: bool
```

### GetPaused

```lua
GetPaused() -> paused: bool, globalPaused: bool
```

### GetSheathed

```lua
GetSheathed() -> sheathed: bool
```

### GetUseTransmogChoices

```lua
GetUseTransmogChoices() -> use: bool
```

### GetUseTransmogSkin

```lua
GetUseTransmogSkin() -> use: bool
```

### IsGeoReady

```lua
IsGeoReady() -> isReady: bool
```

### IsSlotAllowed

```lua
IsSlotAllowed(inventorySlots: number) -> allowed: bool
```

### IsSlotVisible

```lua
IsSlotVisible(inventorySlots: number) -> visible: bool
```

### ReleaseFrontEndCharacterDisplays

```lua
ReleaseFrontEndCharacterDisplays() -> success: bool
```

### ResetNextHandSlot

```lua
ResetNextHandSlot()
```

### SetAutoDress

```lua
SetAutoDress(autoDress: bool)
```

### SetFrontEndLobbyModelFromDefaultCharacterDisplay

```lua
SetFrontEndLobbyModelFromDefaultCharacterDisplay(characterIndex: number) -> success: bool
```

### SetItemTransmogInfo

```lua
SetItemTransmogInfo(transmogInfo: ItemTransmogInfo, inventorySlots?: number, ignoreChildItems: bool) -> result: ItemTryOnReason
```

### SetModelByHyperlink

```lua
SetModelByHyperlink(link: cstring) -> success: bool
```

### SetObeyHideInTransmogFlag

```lua
SetObeyHideInTransmogFlag(obey: bool)
```

### SetPaused

```lua
SetPaused(paused: bool, affectsGlobalPause: bool)
```

### SetSheathed

```lua
SetSheathed(sheathed: bool, hidden: bool)
```

### SetSheathedCategory

```lua
SetSheathedCategory(inventorySlots: number, category: TransmogOutfitSlotOptionSheatheCategory)
```

### SetUseTransmogChoices

```lua
SetUseTransmogChoices(use: bool)
```

### SetUseTransmogSkin

```lua
SetUseTransmogSkin(use: bool)
```

### Undress

```lua
Undress(includeWeapons: bool)
```

### UndressSlot

```lua
UndressSlot(inventorySlots: number)
```

### UseUnitSheatheCategory

```lua
UseUnitSheatheCategory(useCategory: bool)
```
