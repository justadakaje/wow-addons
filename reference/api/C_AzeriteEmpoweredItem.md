# C_AzeriteEmpoweredItem

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`18` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanSelectPower

```lua
C_AzeriteEmpoweredItem.CanSelectPower(azeriteEmpoweredItemLocation: AzeriteEmpoweredItemLocation, powerID: number) -> canSelect: bool
```

### ConfirmAzeriteEmpoweredItemRespec

```lua
C_AzeriteEmpoweredItem.ConfirmAzeriteEmpoweredItemRespec(azeriteEmpoweredItemLocation: AzeriteEmpoweredItemLocation)
```

### GetAllTierInfo

```lua
C_AzeriteEmpoweredItem.GetAllTierInfo(azeriteEmpoweredItemLocation: AzeriteEmpoweredItemLocation) -> tierInfo: table
```

### GetAllTierInfoByItemID

```lua
C_AzeriteEmpoweredItem.GetAllTierInfoByItemID(itemInfo: ItemInfo, classID?: number) -> tierInfo: table
```

### GetAzeriteEmpoweredItemRespecCost

```lua
C_AzeriteEmpoweredItem.GetAzeriteEmpoweredItemRespecCost() -> cost: number
```

### GetPowerInfo

```lua
C_AzeriteEmpoweredItem.GetPowerInfo(powerID: number) -> powerInfo: AzeriteEmpoweredItemPowerInfo
```

### GetPowerText

```lua
C_AzeriteEmpoweredItem.GetPowerText(azeriteEmpoweredItemLocation: AzeriteEmpoweredItemLocation, powerID: number, level: AzeritePowerLevel) -> powerText: AzeriteEmpoweredItemPowerText
```

### GetSpecsForPower

```lua
C_AzeriteEmpoweredItem.GetSpecsForPower(powerID: number) -> specInfo: table
```

### HasAnyUnselectedPowers

```lua
C_AzeriteEmpoweredItem.HasAnyUnselectedPowers(azeriteEmpoweredItemLocation: AzeriteEmpoweredItemLocation) -> hasAnyUnselectedPowers: bool
```

### HasBeenViewed

```lua
C_AzeriteEmpoweredItem.HasBeenViewed(azeriteEmpoweredItemLocation: AzeriteEmpoweredItemLocation) -> hasBeenViewed: bool
```

### IsAzeriteEmpoweredItem

```lua
C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItem(itemLocation: ItemLocation) -> isAzeriteEmpoweredItem: bool
```

### IsAzeriteEmpoweredItemByID

```lua
C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemInfo: ItemInfo) -> isAzeriteEmpoweredItem: bool
```

### IsAzeritePreviewSourceDisplayable

```lua
C_AzeriteEmpoweredItem.IsAzeritePreviewSourceDisplayable(itemInfo: ItemInfo, classID?: number) -> isAzeritePreviewSourceDisplayable: bool
```

### IsHeartOfAzerothEquipped

```lua
C_AzeriteEmpoweredItem.IsHeartOfAzerothEquipped() -> isHeartOfAzerothEquipped: bool
```

### IsPowerAvailableForSpec

```lua
C_AzeriteEmpoweredItem.IsPowerAvailableForSpec(powerID: number, specID: number) -> isPowerAvailableForSpec: bool
```

### IsPowerSelected

```lua
C_AzeriteEmpoweredItem.IsPowerSelected(azeriteEmpoweredItemLocation: AzeriteEmpoweredItemLocation, powerID: number) -> isSelected: bool
```

### SelectPower

```lua
C_AzeriteEmpoweredItem.SelectPower(azeriteEmpoweredItemLocation: AzeriteEmpoweredItemLocation, powerID: number) -> success: bool
```

### SetHasBeenViewed

```lua
C_AzeriteEmpoweredItem.SetHasBeenViewed(azeriteEmpoweredItemLocation: AzeriteEmpoweredItemLocation)
```

## Events

### AzeriteEmpoweredItemEquippedStatusChanged

Fires as `AZERITE_EMPOWERED_ITEM_EQUIPPED_STATUS_CHANGED`.

```lua
payload: isHeartEquipped: bool
```

### AzeriteEmpoweredItemSelectionUpdated

Fires as `AZERITE_EMPOWERED_ITEM_SELECTION_UPDATED`.

```lua
payload: azeriteEmpoweredItemLocation: AzeriteEmpoweredItemLocation
```
