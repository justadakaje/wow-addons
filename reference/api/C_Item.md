# C_Item

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`121` functions - `19` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ActionBindsItem

```lua
C_Item.ActionBindsItem()
```

### BindEnchant

```lua
C_Item.BindEnchant()
```

### CanBeRefunded

```lua
C_Item.CanBeRefunded(itemLocation: ItemLocation) -> canBeRefunded: bool
```

### CanItemTransmogAppearance

```lua
C_Item.CanItemTransmogAppearance(itemLoc: ItemLocation) -> canTransmog: bool, errorCode: TransmogOutfitSlotError
```

### CanScrapItem

```lua
C_Item.CanScrapItem(itemLoc: ItemLocation) -> canBeScrapped: bool
```

### CanViewItemPowers

```lua
C_Item.CanViewItemPowers(itemLoc: ItemLocation) -> isItemViewable: bool
```

### ConfirmBindOnUse

```lua
C_Item.ConfirmBindOnUse()
```

### ConfirmDeleteItem

```lua
C_Item.ConfirmDeleteItem(itemGUID: WOWGUID)
```

### ConfirmNoRefundOnUse

```lua
C_Item.ConfirmNoRefundOnUse()
```

### ConfirmOnUse

```lua
C_Item.ConfirmOnUse()
```

### DeleteItem

```lua
C_Item.DeleteItem(itemGUID: WOWGUID)
```

### DoesItemContainSpec

```lua
C_Item.DoesItemContainSpec(itemInfo: ItemInfo, classID: number, specID: number) -> result: bool
```

### DoesItemExist

```lua
C_Item.DoesItemExist(emptiableItemLocation: EmptiableItemLocation) -> itemExists: bool
```

### DoesItemExistByID

```lua
C_Item.DoesItemExistByID(itemInfo: ItemInfo) -> itemExists: bool
```

### DoesItemMatchBonusTreeReplacement

```lua
C_Item.DoesItemMatchBonusTreeReplacement(itemLoc: ItemLocation) -> matchesBonusTree: bool
```

### DoesItemMatchSpellItemCondition

```lua
C_Item.DoesItemMatchSpellItemCondition(itemLoc: ItemLocation) -> matches: bool
```

### DoesItemMatchTargetEnchantingSpell

```lua
C_Item.DoesItemMatchTargetEnchantingSpell(itemLoc: ItemLocation) -> matchesTargetEnchantingSpell: bool
```

### DoesItemMatchTrackJump

```lua
C_Item.DoesItemMatchTrackJump(itemLoc: ItemLocation) -> matchesTrackJump: bool
```

### DropItemOnUnit

```lua
C_Item.DropItemOnUnit(unitGUID: UnitToken)
```

### EndBoundTradeable

```lua
C_Item.EndBoundTradeable(type: cstring)
```

### EndRefund

```lua
C_Item.EndRefund(type: number)
```

### EquipItemByName

```lua
C_Item.EquipItemByName(itemInfo: ItemInfo, dstSlot?: luaIndex)
```

### GetAppliedItemTransmogInfo

```lua
C_Item.GetAppliedItemTransmogInfo(itemLoc: ItemLocation) -> info?: ItemTransmogInfo
```

### GetBaseItemTransmogInfo

```lua
C_Item.GetBaseItemTransmogInfo(itemLoc: ItemLocation) -> info?: ItemTransmogInfo
```

### GetCurrentItemLevel

```lua
C_Item.GetCurrentItemLevel(itemLocation: ItemLocation) -> currentItemLevel?: number
```

### GetCurrentItemTransmogInfo

```lua
C_Item.GetCurrentItemTransmogInfo(itemLoc: ItemLocation) -> info?: ItemTransmogInfo
```

### GetDelvePreviewItemLink

```lua
C_Item.GetDelvePreviewItemLink(itemID: number, context: ItemCreationContext) -> itemLink?: string
```

### GetDelvePreviewItemQuality

```lua
C_Item.GetDelvePreviewItemQuality(itemID: number, context: ItemCreationContext) -> itemQuality: ItemQuality
```

### GetDetailedItemLevelInfo

```lua
C_Item.GetDetailedItemLevelInfo(itemInfo: ItemInfo) -> actualItemLevel: number, previewLevel: bool, sparseItemLevel: number
```

### GetFirstTriggeredSpellForItem

```lua
C_Item.GetFirstTriggeredSpellForItem(itemID: number, itemQuality: number) -> spellID?: number
```

### GetItemChildInfo

```lua
C_Item.GetItemChildInfo(itemInfo: ItemInfo, slotID?: luaIndex) -> result: table
```

### GetItemClassInfo

```lua
C_Item.GetItemClassInfo(itemClassID: number) -> result: cstring
```

### GetItemConversionOutputIcon

```lua
C_Item.GetItemConversionOutputIcon(itemLoc: ItemLocation) -> icon?: fileID
```

### GetItemCooldown

```lua
C_Item.GetItemCooldown(itemInfo: ItemInfo) -> startTimeSeconds: number, durationSeconds: number, enableCooldownTimer: bool
```

### GetItemCount

```lua
C_Item.GetItemCount(itemInfo: ItemInfo, includeBank: bool, includeUses: bool, includeReagentBank: bool, includeAccountBank: bool) -> count: number
```

### GetItemCreationContext

```lua
C_Item.GetItemCreationContext(itemInfo: ItemInfo) -> itemID: number, creationContext: cstring
```

### GetItemFamily

```lua
C_Item.GetItemFamily(itemInfo: ItemInfo) -> result?: number
```

### GetItemGem

```lua
C_Item.GetItemGem(hyperlink: cstring, index: luaIndex) -> gemName: string, gemLink: cstring
```

### GetItemGemID

```lua
C_Item.GetItemGemID(itemInfo: ItemInfo, index: luaIndex) -> gemID: number
```

### GetItemGUID

```lua
C_Item.GetItemGUID(itemLocation: ItemLocation) -> itemGUID: WOWGUID
```

### GetItemIcon

```lua
C_Item.GetItemIcon(itemLocation: ItemLocation) -> icon?: fileID
```

### GetItemIconByID

```lua
C_Item.GetItemIconByID(itemInfo: ItemInfo) -> icon?: fileID
```

### GetItemID

```lua
C_Item.GetItemID(itemLocation: ItemLocation) -> itemID: number
```

### GetItemIDByGUID

```lua
C_Item.GetItemIDByGUID(itemGUID: WOWGUID) -> itemID?: number
```

### GetItemIDForItemInfo

```lua
C_Item.GetItemIDForItemInfo(itemInfo: ItemInfo) -> itemID: number
```

### GetItemInfo

```lua
C_Item.GetItemInfo(itemInfo: ItemInfo) -> itemName: cstring, itemLink: cstring, itemQuality: ItemQuality, itemLevel: number, itemMinLevel: number, itemType: cstring, itemSubType: cstring, itemStackCount: number, itemEquipLoc: cstring, itemTexture: fileID, sellPrice: number, classID: number, subclassID: number, bindType: number, expansionID: number, setID?: number, isCraftingReagent: bool, itemDescription: cstring
```

### GetItemInfoInstant

```lua
C_Item.GetItemInfoInstant(itemInfo: ItemInfo) -> itemID: number, itemType: cstring, itemSubType: cstring, itemEquipLoc: cstring, icon: fileID, classID: number, subClassID: number
```

### GetItemInventorySlotInfo

```lua
C_Item.GetItemInventorySlotInfo(inventorySlot: InventoryType) -> result: cstring
```

### GetItemInventorySlotKey

```lua
C_Item.GetItemInventorySlotKey(inventorySlot: InventoryType) -> result: cstring
```

### GetItemInventoryType

```lua
C_Item.GetItemInventoryType(itemLocation: ItemLocation) -> inventoryType?: InventoryType
```

### GetItemInventoryTypeByID

```lua
C_Item.GetItemInventoryTypeByID(itemInfo: ItemInfo) -> inventoryType?: InventoryType
```

### GetItemLearnTransmogSet

```lua
C_Item.GetItemLearnTransmogSet(itemInfo: ItemInfo) -> setID?: number
```

### GetItemLink

```lua
C_Item.GetItemLink(itemLocation: ItemLocation) -> itemLink?: string
```

### GetItemLinkByGUID

```lua
C_Item.GetItemLinkByGUID(itemGUID: WOWGUID) -> itemLink?: string
```

### GetItemLocation

```lua
C_Item.GetItemLocation(itemGUID: WOWGUID) -> itemLocation?: ItemLocation
```

### GetItemMaxStackSize

```lua
C_Item.GetItemMaxStackSize(itemLocation: ItemLocation) -> stackSize?: number
```

### GetItemMaxStackSizeByID

```lua
C_Item.GetItemMaxStackSizeByID(itemInfo: ItemInfo) -> stackSize?: number
```

### GetItemName

```lua
C_Item.GetItemName(itemLocation: ItemLocation) -> itemName?: string
```

### GetItemNameByID

```lua
C_Item.GetItemNameByID(itemInfo: ItemInfo) -> itemName?: string
```

### GetItemNumAddedSockets

```lua
C_Item.GetItemNumAddedSockets(itemInfo: ItemInfo) -> socketCount: number
```

### GetItemNumSockets

```lua
C_Item.GetItemNumSockets(itemInfo: ItemInfo) -> socketCount: number
```

### GetItemQuality

```lua
C_Item.GetItemQuality(itemLocation: ItemLocation) -> itemQuality?: ItemQuality
```

### GetItemQualityByID

```lua
C_Item.GetItemQualityByID(itemInfo: ItemInfo) -> itemQuality?: ItemQuality
```

### GetItemQualityColor

```lua
C_Item.GetItemQualityColor(quality: ItemQuality) -> colorRGBR: number, colorRGBG: number, colorRGBB: number, qualityString: cstring
```

### GetItemSetInfo

```lua
C_Item.GetItemSetInfo(setID: number) -> result: cstring
```

### GetItemSpecInfo

```lua
C_Item.GetItemSpecInfo(itemInfo: ItemInfo) -> specTable: table
```

### GetItemSpell

```lua
C_Item.GetItemSpell(itemInfo: ItemInfo) -> spellName: cstring, spellID: number
```

### GetItemStatDelta

```lua
C_Item.GetItemStatDelta(itemLink1: cstring, itemLink2: cstring) -> statTable: LuaValueVariant
```

### GetItemStats

```lua
C_Item.GetItemStats(itemLink: cstring) -> statTable: LuaValueVariant
```

### GetItemSubClassInfo

```lua
C_Item.GetItemSubClassInfo(itemClassID: number, itemSubClassID: number) -> subClassName: cstring, subClassUsesInvType: bool
```

### GetItemUniqueness

```lua
C_Item.GetItemUniqueness(itemInfo: ItemInfo) -> limitCategory: number, limitMax: number
```

### GetItemUniquenessByID

```lua
C_Item.GetItemUniquenessByID(itemInfo: ItemInfo) -> isUnique: bool, limitCategoryName?: cstring, limitCategoryCount?: number, limitCategoryID?: number
```

### GetItemUpgradeInfo

```lua
C_Item.GetItemUpgradeInfo(itemInfo: ItemInfo) -> itemUpgradeInfo?: ItemUpgradeInfo
```

### GetLimitedCurrencyItemInfo

```lua
C_Item.GetLimitedCurrencyItemInfo(itemInfo: ItemInfo) -> name: cstring, icon: fileID, quantity: number, maxQuantity: number, totalEarned: number
```

### GetSetBonusesForSpecializationByItemID

```lua
C_Item.GetSetBonusesForSpecializationByItemID(specID: number, itemID: number) -> itemSetSpellIDs: table
```

### GetStackCount

```lua
C_Item.GetStackCount(itemLocation: ItemLocation) -> stackCount: number
```

### GetWeaponEnchantInfo

```lua
C_Item.GetWeaponEnchantInfo(weaponSlot: WeaponSlot) -> enchants: table
```

### IsAnimaItemByID

```lua
C_Item.IsAnimaItemByID(itemInfo: ItemInfo) -> isAnimaItem: bool
```

### IsArtifactPowerItem

```lua
C_Item.IsArtifactPowerItem(itemInfo: ItemInfo) -> result: bool
```

### IsBound

```lua
C_Item.IsBound(itemLocation: ItemLocation) -> isBound: bool
```

### IsBoundToAccountUntilEquip

```lua
C_Item.IsBoundToAccountUntilEquip(itemLocation: ItemLocation) -> isBoundToAccountUntilEquip: bool
```

### IsConsumableItem

```lua
C_Item.IsConsumableItem(itemInfo: ItemInfo) -> result: bool
```

### IsCorruptedItem

```lua
C_Item.IsCorruptedItem(itemInfo: ItemInfo) -> result?: bool
```

### IsCosmeticItem

```lua
C_Item.IsCosmeticItem(itemInfo: ItemInfo) -> result?: bool
```

### IsCurioItem

```lua
C_Item.IsCurioItem(itemInfo: ItemInfo) -> result?: bool
```

### IsCurrentItem

```lua
C_Item.IsCurrentItem(itemInfo: ItemInfo) -> result: bool
```

### IsDecorItem

```lua
C_Item.IsDecorItem(itemInfo: ItemInfo) -> isDecor?: bool
```

### IsDressableItemByID

```lua
C_Item.IsDressableItemByID(itemInfo: ItemInfo) -> isDressableItem: bool
```

### IsEquippableItem

```lua
C_Item.IsEquippableItem(itemInfo: ItemInfo) -> result: bool
```

### IsEquippedItem

```lua
C_Item.IsEquippedItem(itemInfo: ItemInfo) -> result: bool
```

### IsEquippedItemType

```lua
C_Item.IsEquippedItemType(type: cstring) -> result: bool
```

### IsHarmfulItem

```lua
C_Item.IsHarmfulItem(itemInfo: ItemInfo) -> result: bool
```

### IsHelpfulItem

```lua
C_Item.IsHelpfulItem(itemInfo: ItemInfo) -> result: bool
```

### IsItemBindToAccount

```lua
C_Item.IsItemBindToAccount(itemInfo: ItemInfo) -> isItemBindToAccount: bool
```

### IsItemBindToAccountUntilEquip

```lua
C_Item.IsItemBindToAccountUntilEquip(itemInfo: ItemInfo) -> isItemBindToAccountUntilEquip: bool
```

### IsItemConduit

```lua
C_Item.IsItemConduit(itemLoc: ItemLocation) -> isConduit: bool
```

### IsItemConvertibleAndValidForPlayer

```lua
C_Item.IsItemConvertibleAndValidForPlayer(itemLoc: ItemLocation) -> isItemConvertibleAndValidForPlayer: bool
```

### IsItemCorrupted

```lua
C_Item.IsItemCorrupted(itemLoc: ItemLocation) -> isCorrupted: bool
```

### IsItemCorruptionRelated

```lua
C_Item.IsItemCorruptionRelated(itemLoc: ItemLocation) -> isCorruptionRelated: bool
```

### IsItemCorruptionResistant

```lua
C_Item.IsItemCorruptionResistant(itemLoc: ItemLocation) -> isCorruptionResistant: bool
```

### IsItemDataCached

```lua
C_Item.IsItemDataCached(itemLocation: ItemLocation) -> isCached: bool
```

### IsItemDataCachedByID

```lua
C_Item.IsItemDataCachedByID(itemInfo: ItemInfo) -> isCached: bool
```

### IsItemGUIDInInventory

```lua
C_Item.IsItemGUIDInInventory(itemGUID: WOWGUID) -> valid: bool
```

### IsItemInRange

```lua
C_Item.IsItemInRange(itemInfo: ItemInfo, targetToken: cstring) -> result?: bool
```

### IsItemKeystoneByID

```lua
C_Item.IsItemKeystoneByID(itemInfo: ItemInfo) -> isKeystone: bool
```

### IsItemSpecificToPlayerClass

```lua
C_Item.IsItemSpecificToPlayerClass(itemInfo: ItemInfo) -> isItemSpecificToPlayerClass: bool
```

### IsLocked

```lua
C_Item.IsLocked(itemLocation: ItemLocation) -> isLocked: bool
```

### IsRelicItem

```lua
C_Item.IsRelicItem(itemInfo: ItemInfo) -> result?: bool
```

### IsUsableItem

```lua
C_Item.IsUsableItem(itemInfo: ItemInfo) -> usable: bool, noMana: bool
```

### ItemHasRange

```lua
C_Item.ItemHasRange(itemInfo: ItemInfo) -> result: bool
```

### LockItem

```lua
C_Item.LockItem(itemLocation: ItemLocation)
```

### LockItemByGUID

```lua
C_Item.LockItemByGUID(itemGUID: WOWGUID)
```

### PickupItem

```lua
C_Item.PickupItem(itemInfo: ItemInfo)
```

### ReplaceEnchant

```lua
C_Item.ReplaceEnchant()
```

### ReplaceTradeEnchant

```lua
C_Item.ReplaceTradeEnchant()
```

### ReplaceTradeskillEnchant

```lua
C_Item.ReplaceTradeskillEnchant()
```

### RequestLoadItemData

```lua
C_Item.RequestLoadItemData(itemLocation: ItemLocation)
```

### RequestLoadItemDataByID

```lua
C_Item.RequestLoadItemDataByID(itemInfo: ItemInfo)
```

### UnlockItem

```lua
C_Item.UnlockItem(itemLocation: ItemLocation)
```

### UnlockItemByGUID

```lua
C_Item.UnlockItemByGUID(itemGUID: WOWGUID)
```

### UseItemByName

```lua
C_Item.UseItemByName(itemInfo: ItemInfo, target?: cstring)
```

## Events

### ActionWillBindItem

Fires as `ACTION_WILL_BIND_ITEM`.

No payload.

### BindEnchant

Fires as `BIND_ENCHANT`.

No payload.

### CharacterItemFixupNotification

Fires as `CHARACTER_ITEM_FIXUP_NOTIFICATION`.

```lua
payload: fixupVersion: number
```

### ConfirmBeforeUse

Fires as `CONFIRM_BEFORE_USE`.

No payload.

### ConvertToBindToAccountConfirm

Fires as `CONVERT_TO_BIND_TO_ACCOUNT_CONFIRM`.

No payload.

### DeleteItemConfirm

Fires as `DELETE_ITEM_CONFIRM`.

```lua
payload: itemName: cstring, qualityID: number, bonding: number, questWarn: number, itemGUID?: WOWGUID
```

### EndBoundTradeable

Fires as `END_BOUND_TRADEABLE`.

```lua
payload: reason: cstring
```

### GetItemInfoReceived

Fires as `GET_ITEM_INFO_RECEIVED`.

```lua
payload: itemID: number, success: bool
```

### ItemChanged

Fires as `ITEM_CHANGED`.

```lua
payload: previousHyperlink: string, newHyperlink: string
```

### ItemConversionDataReady

Fires as `ITEM_CONVERSION_DATA_READY`.

```lua
payload: itemGUID: WOWGUID
```

### ItemCountChanged

Fires as `ITEM_COUNT_CHANGED`.

```lua
payload: itemID: number
```

### ItemDataLoadResult

Fires as `ITEM_DATA_LOAD_RESULT`.

```lua
payload: itemID: number, success: bool
```

### MerchantConfirmTradeTimerRemoval

Fires as `MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL`.

```lua
payload: itemLink: cstring
```

### ReplaceEnchant

Fires as `REPLACE_ENCHANT`.

```lua
payload: existingStr: cstring, replacementStr: cstring
```

### ReplaceTradeskillEnchant

Fires as `REPLACE_TRADESKILL_ENCHANT`.

```lua
payload: existing: cstring, replacement: cstring
```

### TradeReplaceEnchant

Fires as `TRADE_REPLACE_ENCHANT`.

```lua
payload: existing: cstring, replacement: cstring
```

### UseBindConfirm

Fires as `USE_BIND_CONFIRM`.

No payload.

### UseNoRefundConfirm

Fires as `USE_NO_REFUND_CONFIRM`.

No payload.

### WeaponEnchantChanged

Fires as `WEAPON_ENCHANT_CHANGED`.

No payload.
