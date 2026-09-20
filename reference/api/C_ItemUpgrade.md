# C_ItemUpgrade

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`16` functions - `3` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanUpgradeItem

```lua
C_ItemUpgrade.CanUpgradeItem(baseItem: ItemLocation) -> isValid: bool
```

### ClearItemUpgrade

```lua
C_ItemUpgrade.ClearItemUpgrade()
```

### CloseItemUpgrade

```lua
C_ItemUpgrade.CloseItemUpgrade()
```

### GetHighWatermarkForItem

```lua
C_ItemUpgrade.GetHighWatermarkForItem(itemInfo: ItemInfo) -> characterHighWatermark: number, accountHighWatermark: number
```

### GetHighWatermarkForSlot

```lua
C_ItemUpgrade.GetHighWatermarkForSlot(itemRedundancySlot: number) -> characterHighWatermark: number, accountHighWatermark: number
```

### GetHighWatermarkSlotForItem

```lua
C_ItemUpgrade.GetHighWatermarkSlotForItem(itemInfo: ItemInfo) -> itemRedundancySlot: number
```

### GetItemHyperlink

```lua
C_ItemUpgrade.GetItemHyperlink() -> link: cstring
```

### GetItemUpgradeCurrentLevel

```lua
C_ItemUpgrade.GetItemUpgradeCurrentLevel() -> itemLevel: number, isPvpItemLevel: bool
```

### GetItemUpgradeEffect

```lua
C_ItemUpgrade.GetItemUpgradeEffect(effectIndex: number, numUpgradeLevels?: number) -> outBaseEffect: string, outUpgradedEffect: string
```

### GetItemUpgradeItemInfo

```lua
C_ItemUpgrade.GetItemUpgradeItemInfo() -> itemInfo: ItemUpgradeItemInfo
```

### GetItemUpgradePvpItemLevelDeltaValues

```lua
C_ItemUpgrade.GetItemUpgradePvpItemLevelDeltaValues(numUpgradeLevels: number) -> currentPvPItemLevel: number, upgradedPvPItemLevel: number
```

### GetNumItemUpgradeEffects

```lua
C_ItemUpgrade.GetNumItemUpgradeEffects() -> numItemUpgradeEffects: number
```

### IsItemBound

```lua
C_ItemUpgrade.IsItemBound() -> isBound: bool
```

### SetItemUpgradeFromCursorItem

```lua
C_ItemUpgrade.SetItemUpgradeFromCursorItem()
```

### SetItemUpgradeFromLocation

```lua
C_ItemUpgrade.SetItemUpgradeFromLocation(itemToSet: ItemLocation)
```

### UpgradeItem

```lua
C_ItemUpgrade.UpgradeItem(numUpgrades: number)
```

## Events

### ItemUpgradeFailed

Fires as `ITEM_UPGRADE_FAILED`.

No payload.

### ItemUpgradeMasterSetItem

Fires as `ITEM_UPGRADE_MASTER_SET_ITEM`.

No payload.

### ItemUpgradeMasterUpdate

Fires as `ITEM_UPGRADE_MASTER_UPDATE`.

No payload.
