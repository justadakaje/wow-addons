# C_TooltipInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`82` functions - `3` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetAchievementByID

```lua
C_TooltipInfo.GetAchievementByID(achievementID: number) -> data: TooltipData
```

### GetAction

```lua
C_TooltipInfo.GetAction(actionID: luaIndex) -> data: TooltipData
```

### GetArtifactItem

```lua
C_TooltipInfo.GetArtifactItem() -> data: TooltipData
```

### GetArtifactPowerByID

```lua
C_TooltipInfo.GetArtifactPowerByID(powerID: number) -> data: TooltipData
```

### GetAzeriteEssence

```lua
C_TooltipInfo.GetAzeriteEssence(essenceID: number, rank?: number) -> data: TooltipData
```

### GetAzeriteEssenceSlot

```lua
C_TooltipInfo.GetAzeriteEssenceSlot(slot: AzeriteEssenceSlot) -> data: TooltipData
```

### GetAzeritePower

```lua
C_TooltipInfo.GetAzeritePower(itemID: number, itemLevel: number, powerID: number, owningItemLink?: cstring) -> data: TooltipData
```

### GetBackpackToken

```lua
C_TooltipInfo.GetBackpackToken(index: luaIndex) -> data: TooltipData
```

### GetBagItem

```lua
C_TooltipInfo.GetBagItem(bagIndex: BagIndex, slotIndex: luaIndex) -> data: TooltipData
```

### GetBagItemChild

```lua
C_TooltipInfo.GetBagItemChild(bagIndex: BagIndex, slotIndex: luaIndex, equipSlotIndex: luaIndex) -> data: TooltipData
```

### GetBuybackItem

```lua
C_TooltipInfo.GetBuybackItem(index: luaIndex) -> data: TooltipData
```

### GetCompanionPet

```lua
C_TooltipInfo.GetCompanionPet(petGUID: WOWGUID) -> data: TooltipData
```

### GetConduit

```lua
C_TooltipInfo.GetConduit(conduitID: number, conduitRank: number) -> data: TooltipData
```

### GetCurrencyByID

```lua
C_TooltipInfo.GetCurrencyByID(currencyID: number, amount?: number) -> data: TooltipData
```

### GetCurrencyToken

```lua
C_TooltipInfo.GetCurrencyToken(tokenIndex: luaIndex) -> data: TooltipData
```

### GetEnhancedConduit

```lua
C_TooltipInfo.GetEnhancedConduit(conduitID: number, rank: number) -> data: TooltipData
```

### GetEquipmentSet

```lua
C_TooltipInfo.GetEquipmentSet(setID: number) -> data: TooltipData
```

### GetExistingSocketGem

```lua
C_TooltipInfo.GetExistingSocketGem(index: luaIndex, toDestroy?: bool) -> data: TooltipData
```

### GetGuildBankItem

```lua
C_TooltipInfo.GetGuildBankItem(tab: luaIndex, slot: luaIndex) -> data: TooltipData
```

### GetHeirloomByItemID

```lua
C_TooltipInfo.GetHeirloomByItemID(itemID: number) -> data: TooltipData
```

### GetHyperlink

```lua
C_TooltipInfo.GetHyperlink(hyperlink: cstring, optionalArg1?: number, optionalArg2?: number, hideVendorPrice?: bool) -> data: TooltipData
```

### GetInboxItem

```lua
C_TooltipInfo.GetInboxItem(messageIndex: luaIndex, attachmentIndex?: luaIndex) -> data: TooltipData
```

### GetInstanceLockEncountersComplete

```lua
C_TooltipInfo.GetInstanceLockEncountersComplete(index: luaIndex) -> data: TooltipData
```

### GetInventoryItem

```lua
C_TooltipInfo.GetInventoryItem(unit: UnitToken, slot: luaIndex, hideUselessStats?: bool) -> data: TooltipData
```

### GetInventoryItemByID

```lua
C_TooltipInfo.GetInventoryItemByID(itemID: number) -> data: TooltipData
```

### GetItemByGUID

```lua
C_TooltipInfo.GetItemByGUID(guid: WOWGUID) -> data: TooltipData
```

### GetItemByID

```lua
C_TooltipInfo.GetItemByID(itemID: number, quality?: number, itemContext?: number, treasureContextLevel?: number) -> data: TooltipData
```

### GetItemByItemModifiedAppearanceID

```lua
C_TooltipInfo.GetItemByItemModifiedAppearanceID(itemModifiedAppearanceID: number) -> data: TooltipData
```

### GetItemInteractionItem

```lua
C_TooltipInfo.GetItemInteractionItem() -> data: TooltipData
```

### GetItemKey

```lua
C_TooltipInfo.GetItemKey(itemID: number, itemLevel: number, itemSuffix: number, requiredLevel?: number) -> data: TooltipData
```

### GetLFGDungeonReward

```lua
C_TooltipInfo.GetLFGDungeonReward(dungeonID: number, lootIndex: luaIndex) -> data: TooltipData
```

### GetLFGDungeonShortageReward

```lua
C_TooltipInfo.GetLFGDungeonShortageReward(dungeonID: number, shortageSeverity: luaIndex, lootIndex: luaIndex) -> data: TooltipData
```

### GetLootCurrency

```lua
C_TooltipInfo.GetLootCurrency(slot: luaIndex) -> data: TooltipData
```

### GetLootItem

```lua
C_TooltipInfo.GetLootItem(slot: luaIndex) -> data: TooltipData
```

### GetLootRollItem

```lua
C_TooltipInfo.GetLootRollItem(id: number) -> data: TooltipData
```

### GetMerchantCostItem

```lua
C_TooltipInfo.GetMerchantCostItem(slot: luaIndex, costIndex: luaIndex) -> data: TooltipData
```

### GetMerchantItem

```lua
C_TooltipInfo.GetMerchantItem(slot: luaIndex) -> data: TooltipData
```

### GetMinimapMouseover

```lua
C_TooltipInfo.GetMinimapMouseover() -> data: TooltipData
```

### GetMountBySpellID

```lua
C_TooltipInfo.GetMountBySpellID(spellID: SpellIdentifier, checkIndoors?: bool) -> data: TooltipData
```

### GetOutfit

```lua
C_TooltipInfo.GetOutfit(outfitID: number) -> data: TooltipData
```

### GetOwnedItemByID

```lua
C_TooltipInfo.GetOwnedItemByID(itemID: number) -> data: TooltipData
```

### GetPetAction

```lua
C_TooltipInfo.GetPetAction(slot: luaIndex) -> data: TooltipData
```

### GetPossession

```lua
C_TooltipInfo.GetPossession(slot: luaIndex) -> data: TooltipData
```

### GetPvpBrawl

```lua
C_TooltipInfo.GetPvpBrawl(isSpecial?: bool) -> data: TooltipData
```

### GetPvpTalent

```lua
C_TooltipInfo.GetPvpTalent(talentID: number, isInspect?: bool, groupIndex?: luaIndex, talentIndex?: number) -> data: TooltipData
```

### GetQuestCurrency

```lua
C_TooltipInfo.GetQuestCurrency(type: cstring, currencyIndex: luaIndex) -> data: TooltipData
```

### GetQuestItem

```lua
C_TooltipInfo.GetQuestItem(type: cstring, itemIndex: luaIndex, allowCollectionText?: bool) -> data: TooltipData
```

### GetQuestLogCurrency

```lua
C_TooltipInfo.GetQuestLogCurrency(type: cstring, currencyIndex: luaIndex, questID?: number) -> data: TooltipData
```

### GetQuestLogItem

```lua
C_TooltipInfo.GetQuestLogItem(type: cstring, itemIndex: luaIndex, questID?: number, allowCollectionText?: bool) -> data: TooltipData
```

### GetQuestLogSpecialItem

```lua
C_TooltipInfo.GetQuestLogSpecialItem(questIndex: luaIndex) -> data: TooltipData
```

### GetQuestPartyProgress

```lua
C_TooltipInfo.GetQuestPartyProgress(questID: number, omitTitle?: bool, ignoreActivePlayer?: bool) -> data: TooltipData
```

### GetRecipeRankInfo

```lua
C_TooltipInfo.GetRecipeRankInfo(recipeID: number, rank: number) -> data: TooltipData
```

### GetRecipeReagentItem

```lua
C_TooltipInfo.GetRecipeReagentItem(recipeSpellID: number, dataSlotIndex: luaIndex) -> data: TooltipData
```

### GetRecipeResultItem

```lua
C_TooltipInfo.GetRecipeResultItem(recipeID: number, reagentInfos?: table, recraftItemGUID?: WOWGUID, recipeLevel?: luaIndex, overrideQualityID?: number) -> data: TooltipData
```

### GetRecipeResultItemForOrder

```lua
C_TooltipInfo.GetRecipeResultItemForOrder(recipeID: number, reagentInfos?: table, orderID?: BigUInteger, recipeLevel?: luaIndex, overrideQualityID?: number) -> data: TooltipData
```

### GetRuneforgeResultItem

```lua
C_TooltipInfo.GetRuneforgeResultItem(itemGUID: WOWGUID, itemLevel: number, powerID?: number, modifiers?: table) -> data: TooltipData
```

### GetSendMailItem

```lua
C_TooltipInfo.GetSendMailItem(attachmentIndex?: luaIndex) -> data: TooltipData
```

### GetShapeshift

```lua
C_TooltipInfo.GetShapeshift(slot: luaIndex) -> data: TooltipData
```

### GetSlottedKeystone

```lua
C_TooltipInfo.GetSlottedKeystone() -> data: TooltipData
```

### GetSocketedItem

```lua
C_TooltipInfo.GetSocketedItem() -> data: TooltipData
```

### GetSocketedRelic

```lua
C_TooltipInfo.GetSocketedRelic(slotIndex: luaIndex) -> data: TooltipData
```

### GetSocketGem

```lua
C_TooltipInfo.GetSocketGem(index: luaIndex) -> data: TooltipData
```

### GetSpellBookItem

```lua
C_TooltipInfo.GetSpellBookItem(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> data: TooltipData
```

### GetSpellByID

```lua
C_TooltipInfo.GetSpellByID(spellID: SpellIdentifier, isPet?: bool, showSubtext?: bool, dontOverride?: bool, difficultyID?: number, isLink?: bool) -> data: TooltipData
```

### GetTalent

```lua
C_TooltipInfo.GetTalent(talentID: number, isInspect?: bool, groupIndex?: luaIndex) -> data: TooltipData
```

### GetTotem

```lua
C_TooltipInfo.GetTotem(slot: luaIndex) -> data: TooltipData
```

### GetToyByItemID

```lua
C_TooltipInfo.GetToyByItemID(itemID: number) -> data: TooltipData
```

### GetTradePlayerItem

```lua
C_TooltipInfo.GetTradePlayerItem(slot: luaIndex) -> data: TooltipData
```

### GetTradeTargetItem

```lua
C_TooltipInfo.GetTradeTargetItem(slot: luaIndex) -> data: TooltipData
```

### GetTrainerService

```lua
C_TooltipInfo.GetTrainerService(serviceIndex: luaIndex) -> data: TooltipData
```

### GetTraitEntry

```lua
C_TooltipInfo.GetTraitEntry(entryID: number, rank?: number) -> data: TooltipData
```

### GetUnit

```lua
C_TooltipInfo.GetUnit(unit: UnitTokenPvPRestrictedForAddOns, hideStatus?: bool) -> data: TooltipData
```

### GetUnitAura

```lua
C_TooltipInfo.GetUnitAura(unitToken: UnitTokenRestrictedForAddOns, index: luaIndex, filter?: AuraFilters) -> data: TooltipData
```

### GetUnitAuraByAuraInstanceID

```lua
C_TooltipInfo.GetUnitAuraByAuraInstanceID(unitToken: UnitTokenRestrictedForAddOns, auraInstanceID: number, filter?: AuraFilters) -> data: TooltipData
```

### GetUnitBuff

```lua
C_TooltipInfo.GetUnitBuff(unitToken: UnitTokenRestrictedForAddOns, index: luaIndex, filter?: AuraFilters) -> data: TooltipData
```

### GetUnitBuffByAuraInstanceID

```lua
C_TooltipInfo.GetUnitBuffByAuraInstanceID(unitToken: UnitTokenRestrictedForAddOns, auraInstanceID: number, filter?: AuraFilters) -> data: TooltipData
```

### GetUnitDebuff

```lua
C_TooltipInfo.GetUnitDebuff(unitToken: UnitTokenRestrictedForAddOns, index: luaIndex, filter?: AuraFilters) -> data: TooltipData
```

### GetUnitDebuffByAuraInstanceID

```lua
C_TooltipInfo.GetUnitDebuffByAuraInstanceID(unitToken: UnitTokenRestrictedForAddOns, auraInstanceID: number, filter?: AuraFilters) -> data: TooltipData
```

### GetUpgradeItem

```lua
C_TooltipInfo.GetUpgradeItem() -> data: TooltipData
```

### GetWeeklyReward

```lua
C_TooltipInfo.GetWeeklyReward(itemDBID: WeeklyRewardItemDBID) -> data: TooltipData
```

### GetWorldCursor

```lua
C_TooltipInfo.GetWorldCursor() -> data: TooltipData
```

### GetWorldLootObject

```lua
C_TooltipInfo.GetWorldLootObject(unitTokenString: cstring) -> data: TooltipData
```

## Events

### HideHyperlinkTooltip

Fires as `HIDE_HYPERLINK_TOOLTIP`.

No payload.

### ShowHyperlinkTooltip

Fires as `SHOW_HYPERLINK_TOOLTIP`.

```lua
payload: hyperlink: string
```

### TooltipDataUpdate

Fires as `TOOLTIP_DATA_UPDATE`.

```lua
payload: dataInstanceID?: number
```
