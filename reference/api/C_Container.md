# C_Container

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`47` functions - `17` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CalculateTotalNumberOfFreeBagSlots

```lua
C_Container.CalculateTotalNumberOfFreeBagSlots() -> totalFreeSlots: number
```

### ContainerIDToInventoryID

```lua
C_Container.ContainerIDToInventoryID(containerID: BagIndex) -> inventoryID: luaIndex
```

### ContainerRefundItemPurchase

```lua
C_Container.ContainerRefundItemPurchase(containerIndex: BagIndex, slotIndex: luaIndex, isEquipped: bool)
```

### GetBackpackAutosortDisabled

```lua
C_Container.GetBackpackAutosortDisabled() -> isDisabled: bool
```

### GetBackpackSellJunkDisabled

```lua
C_Container.GetBackpackSellJunkDisabled() -> isDisabled: bool
```

### GetBagName

```lua
C_Container.GetBagName(bagIndex: BagIndex) -> name: cstring
```

### GetBagSlotFlag

```lua
C_Container.GetBagSlotFlag(bagIndex: BagIndex, flag: BagSlotFlags) -> isSet: bool
```

### GetBankAutosortDisabled

```lua
C_Container.GetBankAutosortDisabled() -> isDisabled: bool
```

### GetContainerFreeSlots

```lua
C_Container.GetContainerFreeSlots(containerIndex: BagIndex) -> freeSlots: table
```

### GetContainerItemCooldown

```lua
C_Container.GetContainerItemCooldown(containerIndex: BagIndex, slotIndex: luaIndex) -> startTime: number, duration: number, enable: number
```

### GetContainerItemDurability

```lua
C_Container.GetContainerItemDurability(containerIndex: BagIndex, slotIndex: luaIndex) -> durability: number, maxDurability: number
```

### GetContainerItemEquipmentSetInfo

```lua
C_Container.GetContainerItemEquipmentSetInfo(containerIndex: BagIndex, slotIndex: luaIndex) -> inSet: bool, setList: string
```

### GetContainerItemID

```lua
C_Container.GetContainerItemID(containerIndex: BagIndex, slotIndex: luaIndex) -> containerID: number
```

### GetContainerItemInfo

```lua
C_Container.GetContainerItemInfo(containerIndex: BagIndex, slotIndex: luaIndex) -> containerInfo: ContainerItemInfo
```

### GetContainerItemLink

```lua
C_Container.GetContainerItemLink(containerIndex: BagIndex, slotIndex: luaIndex) -> itemLink: cstring
```

### GetContainerItemPurchaseCurrency

```lua
C_Container.GetContainerItemPurchaseCurrency(containerIndex: BagIndex, slotIndex: luaIndex, itemIndex: luaIndex, isEquipped: bool) -> currencyInfo: ItemPurchaseCurrency
```

### GetContainerItemPurchaseInfo

```lua
C_Container.GetContainerItemPurchaseInfo(containerIndex: BagIndex, slotIndex: luaIndex, isEquipped: bool) -> info: ItemPurchaseInfo
```

### GetContainerItemPurchaseItem

```lua
C_Container.GetContainerItemPurchaseItem(containerIndex: BagIndex, slotIndex: luaIndex, itemIndex: luaIndex, isEquipped: bool) -> itemInfo: ItemPurchaseItem
```

### GetContainerItemQuestInfo

```lua
C_Container.GetContainerItemQuestInfo(containerIndex: BagIndex, slotIndex: luaIndex) -> questInfo: ItemQuestInfo
```

### GetContainerNumFreeSlots

```lua
C_Container.GetContainerNumFreeSlots(bagIndex: BagIndex) -> numFreeSlots: number, bagFamily?: number
```

### GetContainerNumSlots

```lua
C_Container.GetContainerNumSlots(containerIndex: BagIndex) -> numSlots: number
```

### GetInsertItemsLeftToRight

```lua
C_Container.GetInsertItemsLeftToRight() -> isEnabled: bool
```

### GetItemCooldown

```lua
C_Container.GetItemCooldown(itemID: number) -> startTime: number, duration: number, enable: number
```

### GetMaxArenaCurrency

```lua
C_Container.GetMaxArenaCurrency() -> maxCurrency: number
```

### GetSortBagsRightToLeft

```lua
C_Container.GetSortBagsRightToLeft() -> isEnabled: bool
```

### HasContainerItem

```lua
C_Container.HasContainerItem(containerIndex: BagIndex, slotIndex: luaIndex) -> hasItem: bool
```

### IsBattlePayItem

```lua
C_Container.IsBattlePayItem(containerIndex: BagIndex, slotIndex: luaIndex) -> isBattlePayItem: bool
```

### IsContainerFiltered

```lua
C_Container.IsContainerFiltered(containerIndex: BagIndex) -> isFiltered: bool
```

### PickupContainerItem

```lua
C_Container.PickupContainerItem(containerIndex: BagIndex, slotIndex: luaIndex)
```

### PlayerHasHearthstone

```lua
C_Container.PlayerHasHearthstone() -> itemID?: number
```

### SetBackpackAutosortDisabled

```lua
C_Container.SetBackpackAutosortDisabled(disable: bool)
```

### SetBackpackSellJunkDisabled

```lua
C_Container.SetBackpackSellJunkDisabled(disable: bool)
```

### SetBagPortraitTexture

```lua
C_Container.SetBagPortraitTexture(texture: SimpleTexture, bagIndex: BagIndex)
```

### SetBagSlotFlag

```lua
C_Container.SetBagSlotFlag(bagIndex: BagIndex, flag: BagSlotFlags, isSet: bool)
```

### SetBankAutosortDisabled

```lua
C_Container.SetBankAutosortDisabled(disable: bool)
```

### SetInsertItemsLeftToRight

```lua
C_Container.SetInsertItemsLeftToRight(enable: bool)
```

### SetItemSearch

```lua
C_Container.SetItemSearch(searchString: cstring)
```

### SetSortBagsRightToLeft

```lua
C_Container.SetSortBagsRightToLeft(enable: bool)
```

### ShowContainerSellCursor

```lua
C_Container.ShowContainerSellCursor(containerIndex: BagIndex, slotIndex: luaIndex)
```

### SocketContainerItem

```lua
C_Container.SocketContainerItem(containerIndex: BagIndex, slotIndex: luaIndex) -> success: bool
```

### SortAccountBankBags

```lua
C_Container.SortAccountBankBags()
```

### SortBags

```lua
C_Container.SortBags()
```

### SortBank

```lua
C_Container.SortBank(bankType: BankType)
```

### SortBankBags

```lua
C_Container.SortBankBags()
```

### SplitContainerItem

```lua
C_Container.SplitContainerItem(containerIndex: BagIndex, slotIndex: luaIndex, amount: number)
```

### UseContainerItem

```lua
C_Container.UseContainerItem(containerIndex: BagIndex, slotIndex: luaIndex, unitToken?: UnitToken, bankType?: BankType, reagentBankOpen: bool)
```

### UseHearthstone

```lua
C_Container.UseHearthstone() -> used: bool
```

## Events

### BagClosed

Fires as `BAG_CLOSED`.

```lua
payload: bagID: BagIndex
```

### BagContainerUpdate

Fires as `BAG_CONTAINER_UPDATE`.

No payload.

### BagNewItemsUpdated

Fires as `BAG_NEW_ITEMS_UPDATED`.

No payload.

### BagOpen

Fires as `BAG_OPEN`.

```lua
payload: bagID: number
```

### BagOverflowWithFullInventory

Fires as `BAG_OVERFLOW_WITH_FULL_INVENTORY`.

No payload.

### BagSlotFlagsUpdated

Fires as `BAG_SLOT_FLAGS_UPDATED`.

```lua
payload: slot: number
```

### BagUpdate

Fires as `BAG_UPDATE`.

```lua
payload: bagID: BagIndex
```

### BagUpdateCooldown

Fires as `BAG_UPDATE_COOLDOWN`.

No payload.

### BagUpdateDelayed

Fires as `BAG_UPDATE_DELAYED`.

No payload.

### EquipBindRefundableConfirm

Fires as `EQUIP_BIND_REFUNDABLE_CONFIRM`.

```lua
payload: slot: number, itemLocation: ItemLocation
```

### EquipBindTradeableConfirm

Fires as `EQUIP_BIND_TRADEABLE_CONFIRM`.

```lua
payload: slot: number, itemLocation: ItemLocation
```

### ExpandBagBarChanged

Fires as `EXPAND_BAG_BAR_CHANGED`.

```lua
payload: expandBagBar: bool
```

### InventorySearchUpdate

Fires as `INVENTORY_SEARCH_UPDATE`.

No payload.

### ItemLockChanged

Fires as `ITEM_LOCK_CHANGED`.

```lua
payload: bagOrSlotIndex: BagIndex, slotIndex?: luaIndex
```

### ItemLocked

Fires as `ITEM_LOCKED`.

```lua
payload: bagOrSlotIndex: BagIndex, slotIndex?: luaIndex
```

### ItemUnlocked

Fires as `ITEM_UNLOCKED`.

```lua
payload: bagOrSlotIndex: BagIndex, slotIndex?: luaIndex
```

### UseCombinedBagsChanged

Fires as `USE_COMBINED_BAGS_CHANGED`.

```lua
payload: useCombinedBags: bool
```
