# C_Loot

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`2` functions - `37` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetLootRollDuration

```lua
C_Loot.GetLootRollDuration(rollID: number) -> duration?: number
```

### IsLegacyLootModeEnabled

```lua
C_Loot.IsLegacyLootModeEnabled() -> isLegacyLootModeEnabled: bool
```

## Events

### AzeriteEmpoweredItemLooted

Fires as `AZERITE_EMPOWERED_ITEM_LOOTED`.

```lua
payload: itemLink: cstring
```

### BonusRollActivate

Fires as `BONUS_ROLL_ACTIVATE`.

No payload.

### BonusRollDeactivate

Fires as `BONUS_ROLL_DEACTIVATE`.

No payload.

### BonusRollFailed

Fires as `BONUS_ROLL_FAILED`.

No payload.

### BonusRollResult

Fires as `BONUS_ROLL_RESULT`.

```lua
payload: typeIdentifier: cstring, itemLink: cstring, quantity: number, specID: number, sex: number, personalLootToast: bool, currencyID?: number, isSecondaryResult: bool, corrupted: bool
```

### BonusRollStarted

Fires as `BONUS_ROLL_STARTED`.

No payload.

### CancelAllLootRolls

Fires as `CANCEL_ALL_LOOT_ROLLS`.

No payload.

### CancelLootRoll

Fires as `CANCEL_LOOT_ROLL`.

```lua
payload: rollID: number
```

### ConfirmDisenchantRoll

Fires as `CONFIRM_DISENCHANT_ROLL`.

```lua
payload: rollID: number, rollType: number
```

### ConfirmLootRoll

Fires as `CONFIRM_LOOT_ROLL`.

```lua
payload: rollID: number, rollType: number, confirmReason: cstring
```

### EncounterLootReceived

Fires as `ENCOUNTER_LOOT_RECEIVED`.

```lua
payload: encounterID: number, itemID: number, itemLink: cstring, quantity: number, itemName: cstring, fileName: cstring
```

### GarrisonMissionBonusRollLoot

Fires as `GARRISON_MISSION_BONUS_ROLL_LOOT`.

```lua
payload: itemID: number, quantity: number
```

### ItemPush

Fires as `ITEM_PUSH`.

```lua
payload: bagSlot: luaIndex, iconFileID: number
```

### LegacyLootRulesChanged

Fires as `LEGACY_LOOT_RULES_CHANGED`.

```lua
payload: isLegacyLootModeEnabled: bool
```

### LootBindConfirm

Fires as `LOOT_BIND_CONFIRM`.

```lua
payload: lootSlot: luaIndex
```

### LootClosed

Fires as `LOOT_CLOSED`.

No payload.

### LootItemAvailable

Fires as `LOOT_ITEM_AVAILABLE`.

```lua
payload: itemTooltip: cstring, lootHandle: number
```

### LootItemRollWon

Fires as `LOOT_ITEM_ROLL_WON`.

```lua
payload: itemLink: cstring, rollQuantity: number, rollType: number, roll: number, upgraded: bool
```

### LootOpened

Fires as `LOOT_OPENED`.

```lua
payload: autoLoot: bool, isFromItem: bool
```

### LootReady

Fires as `LOOT_READY`.

```lua
payload: autoloot: bool
```

### LootRollsComplete

Fires as `LOOT_ROLLS_COMPLETE`.

```lua
payload: lootHandle: number
```

### LootSlotChanged

Fires as `LOOT_SLOT_CHANGED`.

```lua
payload: lootSlot: luaIndex
```

### LootSlotCleared

Fires as `LOOT_SLOT_CLEARED`.

```lua
payload: lootSlot: luaIndex
```

### MainSpecNeedRoll

Fires as `MAIN_SPEC_NEED_ROLL`.

```lua
payload: rollID: number, roll: number, isWinning: bool
```

### OpenMasterLootList

Fires as `OPEN_MASTER_LOOT_LIST`.

No payload.

### PetBattleLootReceived

Fires as `PET_BATTLE_LOOT_RECEIVED`.

```lua
payload: typeIdentifier: cstring, itemLink: cstring, quantity: number
```

### PlayerLootSpecUpdated

Fires as `PLAYER_LOOT_SPEC_UPDATED`.

No payload.

### QuestCurrencyLootReceived

Fires as `QUEST_CURRENCY_LOOT_RECEIVED`.

```lua
payload: questID: number, currencyId: number, quantity: number
```

### QuestLootReceived

Fires as `QUEST_LOOT_RECEIVED`.

```lua
payload: questID: number, itemLink: cstring, quantity: number
```

### ShowLootToast

Fires as `SHOW_LOOT_TOAST`.

```lua
payload: typeIdentifier: cstring, itemLink: cstring, quantity: number, specID: number, sex: number, personalLootToast: bool, toastMethod: number, lessAwesome: bool, upgraded: bool, corrupted: bool
```

### ShowLootToastLegendaryLooted

Fires as `SHOW_LOOT_TOAST_LEGENDARY_LOOTED`.

```lua
payload: itemLink: cstring
```

### ShowLootToastUpgrade

Fires as `SHOW_LOOT_TOAST_UPGRADE`.

```lua
payload: itemLink: cstring, quantity: number, specID: number, sex: number, baseQuality: number, personalLootToast: bool, lessAwesome: bool
```

### ShowPvpFactionLootToast

Fires as `SHOW_PVP_FACTION_LOOT_TOAST`.

```lua
payload: typeIdentifier: cstring, itemLink: cstring, quantity: number, specID: number, sex: number, personalLootToast: bool, lessAwesome: bool
```

### ShowRatedPvpRewardToast

Fires as `SHOW_RATED_PVP_REWARD_TOAST`.

```lua
payload: typeIdentifier: cstring, itemLink: cstring, quantity: number, specID: number, sex: number, personalLootToast: bool, lessAwesome: bool
```

### StartLootRoll

Fires as `START_LOOT_ROLL`.

```lua
payload: rollID: number, rollTime: number, lootHandle?: number
```

### TrialCapReachedMoney

Fires as `TRIAL_CAP_REACHED_MONEY`.

No payload.

### UpdateMasterLootList

Fires as `UPDATE_MASTER_LOOT_LIST`.

No payload.
