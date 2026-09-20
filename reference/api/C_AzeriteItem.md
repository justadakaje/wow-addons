# C_AzeriteItem

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`10` functions - `3` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### FindActiveAzeriteItem

```lua
C_AzeriteItem.FindActiveAzeriteItem() -> activeAzeriteItemLocation: AzeriteItemLocation
```

### GetAzeriteItemXPInfo

```lua
C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation: AzeriteItemLocation) -> xp: number, totalLevelXP: number
```

### GetPowerLevel

```lua
C_AzeriteItem.GetPowerLevel(azeriteItemLocation: AzeriteItemLocation) -> powerLevel: number
```

### GetUnlimitedPowerLevel

```lua
C_AzeriteItem.GetUnlimitedPowerLevel(azeriteItemLocation: AzeriteItemLocation) -> powerLevel: number
```

### HasActiveAzeriteItem

```lua
C_AzeriteItem.HasActiveAzeriteItem() -> hasActiveAzeriteItem: bool
```

### IsAzeriteItem

```lua
C_AzeriteItem.IsAzeriteItem(itemLocation: ItemLocation) -> isAzeriteItem: bool
```

### IsAzeriteItemAtMaxLevel

```lua
C_AzeriteItem.IsAzeriteItemAtMaxLevel() -> isAtMax: bool
```

### IsAzeriteItemByID

```lua
C_AzeriteItem.IsAzeriteItemByID(itemInfo: ItemInfo) -> isAzeriteItem: bool
```

### IsAzeriteItemEnabled

```lua
C_AzeriteItem.IsAzeriteItemEnabled(azeriteItemLocation: AzeriteItemLocation) -> isEnabled: bool
```

### IsUnlimitedLevelingUnlocked

```lua
C_AzeriteItem.IsUnlimitedLevelingUnlocked() -> isUnlimitedLevelingUnlocked: bool
```

## Events

### AzeriteItemEnabledStateChanged

Fires as `AZERITE_ITEM_ENABLED_STATE_CHANGED`.

```lua
payload: enabled: bool
```

### AzeriteItemExperienceChanged

Fires as `AZERITE_ITEM_EXPERIENCE_CHANGED`.

```lua
payload: azeriteItemLocation: AzeriteItemLocation, oldExperienceAmount: number, newExperienceAmount: number
```

### AzeriteItemPowerLevelChanged

Fires as `AZERITE_ITEM_POWER_LEVEL_CHANGED`.

```lua
payload: azeriteItemLocation: AzeriteItemLocation, oldPowerLevel: number, newPowerLevel: number, unlockedEmpoweredItemsInfo: table, azeriteItemID: number
```
