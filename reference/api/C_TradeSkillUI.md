# C_TradeSkillUI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`89` functions - `20` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CancelProfessionRespec

```lua
C_TradeSkillUI.CancelProfessionRespec()
```

### CanStoreEnchantInItem

```lua
C_TradeSkillUI.CanStoreEnchantInItem(itemGUID: WOWGUID) -> canStore: bool
```

### CanTradeSkillShowCraftingUI

```lua
C_TradeSkillUI.CanTradeSkillShowCraftingUI(tradeSkillSpellID: number) -> canShow: bool
```

### CheckRespecNPC

```lua
C_TradeSkillUI.CheckRespecNPC() -> canInteract: bool
```

### CloseTradeSkill

```lua
C_TradeSkillUI.CloseTradeSkill()
```

### ConfirmProfessionRespec

```lua
C_TradeSkillUI.ConfirmProfessionRespec()
```

### CraftEnchant

```lua
C_TradeSkillUI.CraftEnchant(recipeSpellID: number, numCasts: number, craftingReagents?: table, itemTarget?: ItemLocation, applyConcentration?: bool)
```

### CraftRecipe

```lua
C_TradeSkillUI.CraftRecipe(recipeSpellID: number, numCasts: number, craftingReagents?: table, recipeLevel?: luaIndex, orderID?: BigUInteger, applyConcentration?: bool)
```

### CraftSalvage

```lua
C_TradeSkillUI.CraftSalvage(recipeSpellID: number, numCasts: number, itemTarget: ItemLocation, craftingReagents?: table, applyConcentration?: bool)
```

### DoesRecraftingRecipeAcceptItem

```lua
C_TradeSkillUI.DoesRecraftingRecipeAcceptItem(itemLocation: ItemLocation, recipeID: number) -> result: bool
```

### GetAllProfessionTradeSkillLines

```lua
C_TradeSkillUI.GetAllProfessionTradeSkillLines() -> skillLineID: table
```

### GetBaseProfessionInfo

```lua
C_TradeSkillUI.GetBaseProfessionInfo() -> info: ProfessionInfo
```

### GetChildProfessionInfo

```lua
C_TradeSkillUI.GetChildProfessionInfo() -> info: ProfessionInfo
```

### GetChildProfessionInfos

```lua
C_TradeSkillUI.GetChildProfessionInfos() -> infos: table
```

### GetConcentrationCurrencyID

```lua
C_TradeSkillUI.GetConcentrationCurrencyID(skillLineID: number) -> currencyType: number
```

### GetCraftableCount

```lua
C_TradeSkillUI.GetCraftableCount(recipeSpellID: number, recipeLevel?: luaIndex) -> numAvailable: number
```

### GetCraftingOperationInfo

```lua
C_TradeSkillUI.GetCraftingOperationInfo(recipeID: number, craftingReagents: table, allocationItemGUID?: WOWGUID, applyConcentration: bool) -> info?: CraftingOperationInfo
```

### GetCraftingOperationInfoForOrder

```lua
C_TradeSkillUI.GetCraftingOperationInfoForOrder(recipeID: number, craftingReagents: table, orderID: BigUInteger, applyConcentration: bool) -> info?: CraftingOperationInfo
```

### GetCraftingReagentBonusText

```lua
C_TradeSkillUI.GetCraftingReagentBonusText(recipeSpellID: number, craftingReagentIndex: luaIndex, craftingReagents: table, allocationItemGUID?: WOWGUID) -> bonusText: table
```

### GetCraftingTargetItems

```lua
C_TradeSkillUI.GetCraftingTargetItems(itemIDs: table) -> items: table
```

### GetDependentReagents

```lua
C_TradeSkillUI.GetDependentReagents(reagent: CraftingReagent) -> reagents: table
```

### GetEnchantItems

```lua
C_TradeSkillUI.GetEnchantItems(recipeID: number, craftingReagents?: table) -> items: table
```

### GetFactionSpecificOutputItem

```lua
C_TradeSkillUI.GetFactionSpecificOutputItem(recipeSpellID: number) -> itemID?: number
```

### GetGatheringOperationInfo

```lua
C_TradeSkillUI.GetGatheringOperationInfo(recipeID: number) -> info?: GatheringOperationInfo
```

### GetHideUnownedFlags

```lua
C_TradeSkillUI.GetHideUnownedFlags(recipeID: number) -> cannotModifyHideUnowned: bool, alwaysShowUnowned: bool
```

### GetItemCraftedQualityByItemInfo

```lua
C_TradeSkillUI.GetItemCraftedQualityByItemInfo(itemInfo: ItemInfo) -> quality?: number
```

### GetItemCraftedQualityInfo

```lua
C_TradeSkillUI.GetItemCraftedQualityInfo(itemInfo: ItemInfo) -> info?: CraftingQualityInfo
```

### GetItemReagentQualityByItemInfo

```lua
C_TradeSkillUI.GetItemReagentQualityByItemInfo(itemInfo: ItemInfo) -> quality?: number
```

### GetItemReagentQualityInfo

```lua
C_TradeSkillUI.GetItemReagentQualityInfo(itemInfo: ItemInfo) -> info?: CraftingQualityInfo
```

### GetItemSlotModifications

```lua
C_TradeSkillUI.GetItemSlotModifications(itemGUID: WOWGUID) -> slotMods: table
```

### GetItemSlotModificationsForOrder

```lua
C_TradeSkillUI.GetItemSlotModificationsForOrder(orderID: BigUInteger) -> slotMods: table
```

### GetOriginalCraftRecipeID

```lua
C_TradeSkillUI.GetOriginalCraftRecipeID(itemGUID: WOWGUID) -> recipeID?: number, skillLineAbilityID?: number
```

### GetProfessionByInventorySlot

```lua
C_TradeSkillUI.GetProfessionByInventorySlot(slot: luaIndex) -> profession?: Profession
```

### GetProfessionChildSkillLineID

```lua
C_TradeSkillUI.GetProfessionChildSkillLineID() -> skillLineID: number
```

### GetProfessionForCursorItem

```lua
C_TradeSkillUI.GetProfessionForCursorItem() -> profession?: Profession
```

### GetProfessionInfoByRecipeID

```lua
C_TradeSkillUI.GetProfessionInfoByRecipeID(recipeID: number) -> info: ProfessionInfo
```

### GetProfessionInfoBySkillLineID

```lua
C_TradeSkillUI.GetProfessionInfoBySkillLineID(skillLineID: number) -> info: ProfessionInfo
```

### GetProfessionInventorySlots

```lua
C_TradeSkillUI.GetProfessionInventorySlots() -> invSlots: table
```

### GetProfessionNameForSkillLineAbility

```lua
C_TradeSkillUI.GetProfessionNameForSkillLineAbility(skillLineAbilityID: number) -> professionNmae: cstring
```

### GetProfessionSkillLineID

```lua
C_TradeSkillUI.GetProfessionSkillLineID(profession: Profession) -> skillLineID: number
```

### GetProfessionSlots

```lua
C_TradeSkillUI.GetProfessionSlots(profession: Profession) -> slots: table
```

### GetProfessionSpells

```lua
C_TradeSkillUI.GetProfessionSpells(professionID: number, skillLineID?: number) -> knownSpells: table
```

### GetQualitiesForRecipe

```lua
C_TradeSkillUI.GetQualitiesForRecipe(recipeID: number) -> qualityIDs?: table
```

### GetReagentDifficultyText

```lua
C_TradeSkillUI.GetReagentDifficultyText(craftingReagentIndex: luaIndex, craftingReagents: table) -> bonusText: string
```

### GetReagentSlotStatus

```lua
C_TradeSkillUI.GetReagentSlotStatus(mcrSlotID: number, recipeSpellID: number, skillLineAbilityID: number) -> locked: bool, lockedReason: string
```

### GetRecipeDescription

```lua
C_TradeSkillUI.GetRecipeDescription(recipeID: number, craftingReagents: table, allocationItemGUID?: WOWGUID) -> description: string
```

### GetRecipeInfo

```lua
C_TradeSkillUI.GetRecipeInfo(recipeSpellID: number, recipeLevel?: luaIndex) -> recipeInfo?: TradeSkillRecipeInfo
```

### GetRecipeInfoForSkillLineAbility

```lua
C_TradeSkillUI.GetRecipeInfoForSkillLineAbility(skillLineAbilityID: number, recipeLevel?: luaIndex) -> recipeInfo?: TradeSkillRecipeInfo
```

### GetRecipeItemQualityInfo

```lua
C_TradeSkillUI.GetRecipeItemQualityInfo(recipeID: number, quality: number) -> info?: CraftingQualityInfo
```

### GetRecipeOutputItemData

```lua
C_TradeSkillUI.GetRecipeOutputItemData(recipeSpellID: number, reagents?: table, allocationItemGUID?: WOWGUID, overrideQualityID?: number, recraftOrderID?: BigUInteger) -> outputInfo: CraftingRecipeOutputInfo
```

### GetRecipeQualityItemIDs

```lua
C_TradeSkillUI.GetRecipeQualityItemIDs(recipeSpellID: number) -> qualityItemIDs?: table
```

### GetRecipeQualityReagentLink

```lua
C_TradeSkillUI.GetRecipeQualityReagentLink(recipeID: number, dataSlotIndex: luaIndex, qualityIndex: luaIndex) -> link: cstring
```

### GetRecipeRequirements

```lua
C_TradeSkillUI.GetRecipeRequirements(recipeID: number) -> requirements: table
```

### GetRecipeSchematic

```lua
C_TradeSkillUI.GetRecipeSchematic(recipeSpellID: number, isRecraft: bool, recipeLevel?: luaIndex) -> schematic: CraftingRecipeSchematic
```

### GetRecipesTracked

```lua
C_TradeSkillUI.GetRecipesTracked(isRecraft: bool) -> recipeIDs: table
```

### GetRecraftItems

```lua
C_TradeSkillUI.GetRecraftItems(recipeID?: number) -> items: table
```

### GetRecraftRemovalWarnings

```lua
C_TradeSkillUI.GetRecraftRemovalWarnings(itemGUID: WOWGUID, replacedReagents: table) -> warnings: table
```

### GetRemainingRecasts

```lua
C_TradeSkillUI.GetRemainingRecasts() -> remaining: number
```

### GetSalvagableItemIDs

```lua
C_TradeSkillUI.GetSalvagableItemIDs(recipeID: number) -> itemIDs: table
```

### GetShowLearned

```lua
C_TradeSkillUI.GetShowLearned() -> flag: bool
```

### GetShowUnlearned

```lua
C_TradeSkillUI.GetShowUnlearned() -> flag: bool
```

### GetSkillLineForGear

```lua
C_TradeSkillUI.GetSkillLineForGear(itemInfo: ItemInfo) -> skillLineID?: number
```

### GetSourceTypeFilter

```lua
C_TradeSkillUI.GetSourceTypeFilter() -> sourceTypeFilter: number
```

### GetTradeSkillDisplayName

```lua
C_TradeSkillUI.GetTradeSkillDisplayName(skillLineID: number) -> professionDisplayName: cstring
```

### HasFavoriteOrderRecipes

```lua
C_TradeSkillUI.HasFavoriteOrderRecipes() -> hasFavorites: bool
```

### IsEnchantTargetValid

```lua
C_TradeSkillUI.IsEnchantTargetValid(recipeID: number, itemGUID: WOWGUID, craftingReagents?: table) -> valid: bool
```

### IsGuildTradeSkillsEnabled

```lua
C_TradeSkillUI.IsGuildTradeSkillsEnabled() -> enabled: bool
```

### IsNearProfessionSpellFocus

```lua
C_TradeSkillUI.IsNearProfessionSpellFocus(profession: Profession) -> nearFocus: bool
```

### IsNPCCrafting

```lua
C_TradeSkillUI.IsNPCCrafting() -> result: bool
```

### IsOriginalCraftRecipeLearned

```lua
C_TradeSkillUI.IsOriginalCraftRecipeLearned(itemGUID: WOWGUID) -> learned: bool
```

### IsRecipeFirstCraft

```lua
C_TradeSkillUI.IsRecipeFirstCraft(recipeID: number) -> result: bool
```

### IsRecipeInBaseSkillLine

```lua
C_TradeSkillUI.IsRecipeInBaseSkillLine(recipeID: number) -> result: bool
```

### IsRecipeInSkillLine

```lua
C_TradeSkillUI.IsRecipeInSkillLine(recipeID: number, skillLineID: number) -> result: bool
```

### IsRecipeProfessionLearned

```lua
C_TradeSkillUI.IsRecipeProfessionLearned(recipeID: number) -> recipeProfessionLearned: bool
```

### IsRecipeTracked

```lua
C_TradeSkillUI.IsRecipeTracked(recipeID: number, isRecraft: bool) -> tracked: bool
```

### IsRecraftItemEquipped

```lua
C_TradeSkillUI.IsRecraftItemEquipped(recraftItemGUID: WOWGUID) -> isEquipped: bool
```

### IsRecraftReagentValid

```lua
C_TradeSkillUI.IsRecraftReagentValid(itemGUID: WOWGUID, reagent: CraftingReagent) -> valid: bool
```

### IsRuneforging

```lua
C_TradeSkillUI.IsRuneforging() -> result: bool
```

### OpenRecipe

```lua
C_TradeSkillUI.OpenRecipe(recipeID: number)
```

### OpenTradeSkill

```lua
C_TradeSkillUI.OpenTradeSkill(skillLineID: number) -> opened: bool
```

### RecraftLimitCategoryValid

```lua
C_TradeSkillUI.RecraftLimitCategoryValid(reagent: CraftingReagent) -> recraftValid: bool
```

### RecraftRecipe

```lua
C_TradeSkillUI.RecraftRecipe(itemGUID: WOWGUID, craftingReagents?: table, removedModifications?: table, applyConcentration?: bool) -> result: bool
```

### RecraftRecipeForOrder

```lua
C_TradeSkillUI.RecraftRecipeForOrder(orderID: BigUInteger, itemGUID: WOWGUID, craftingReagents?: table, removedModifications?: table, applyConcentration?: bool) -> result: bool
```

### SetOnlyShowAvailableForOrders

```lua
C_TradeSkillUI.SetOnlyShowAvailableForOrders(flag: bool)
```

### SetProfessionChildSkillLineID

```lua
C_TradeSkillUI.SetProfessionChildSkillLineID(skillLineID: number)
```

### SetRecipeTracked

```lua
C_TradeSkillUI.SetRecipeTracked(recipeID: number, tracked: bool, isRecraft: bool)
```

### SetShowLearned

```lua
C_TradeSkillUI.SetShowLearned(flag: bool)
```

### SetShowUnlearned

```lua
C_TradeSkillUI.SetShowUnlearned(flag: bool)
```

### SetSourceTypeFilter

```lua
C_TradeSkillUI.SetSourceTypeFilter(sourceTypeFilter: number)
```

## Events

### CraftingDetailsUpdate

Fires as `CRAFTING_DETAILS_UPDATE`.

No payload.

### NewRecipeLearned

Fires as `NEW_RECIPE_LEARNED`.

```lua
payload: recipeID: number, recipeLevel?: luaIndex, baseRecipeID?: number
```

### ObliterumForgePendingItemChanged

Fires as `OBLITERUM_FORGE_PENDING_ITEM_CHANGED`.

No payload.

### OpenRecipeResponse

Fires as `OPEN_RECIPE_RESPONSE`.

```lua
payload: recipeID: number, skillLineID: number, expansionSkillLineID: number
```

### ProfessionRespecConfirmation

Fires as `PROFESSION_RESPEC_CONFIRMATION`.

```lua
payload: skillName: cstring
```

### TrackedRecipeUpdate

Fires as `TRACKED_RECIPE_UPDATE`.

```lua
payload: recipeID: number, tracked: bool
```

### TradeSkillClose

Fires as `TRADE_SKILL_CLOSE`.

No payload.

### TradeSkillCraftBegin

Fires as `TRADE_SKILL_CRAFT_BEGIN`.

```lua
payload: recipeSpellID: number
```

### TradeSkillCraftingReagentBonusTextUpdated

Fires as `TRADE_SKILL_CRAFTING_REAGENT_BONUS_TEXT_UPDATED`.

```lua
payload: itemID: number
```

### TradeSkillCurrencyRewardResult

Fires as `TRADE_SKILL_CURRENCY_REWARD_RESULT`.

```lua
payload: data: CraftingCurrencyResultData
```

### TradeSkillDataSourceChanged

Fires as `TRADE_SKILL_DATA_SOURCE_CHANGED`.

No payload.

### TradeSkillDataSourceChanging

Fires as `TRADE_SKILL_DATA_SOURCE_CHANGING`.

No payload.

### TradeSkillDetailsUpdate

Fires as `TRADE_SKILL_DETAILS_UPDATE`.

No payload.

### TradeSkillFavoritesChanged

Fires as `TRADE_SKILL_FAVORITES_CHANGED`.

```lua
payload: isFavorite: bool, recipeSpellID: number
```

### TradeSkillItemCraftedResult

Fires as `TRADE_SKILL_ITEM_CRAFTED_RESULT`.

```lua
payload: data: CraftingItemResultData
```

### TradeSkillItemUpdate

Fires as `TRADE_SKILL_ITEM_UPDATE`.

```lua
payload: itemGUID: WOWGUID
```

### TradeSkillListUpdate

Fires as `TRADE_SKILL_LIST_UPDATE`.

No payload.

### TradeSkillNameUpdate

Fires as `TRADE_SKILL_NAME_UPDATE`.

No payload.

### TradeSkillShow

Fires as `TRADE_SKILL_SHOW`.

No payload.

### UpdateTradeskillCastStopped

Fires as `UPDATE_TRADESKILL_CAST_STOPPED`.

```lua
payload: isScrapping: bool
```
