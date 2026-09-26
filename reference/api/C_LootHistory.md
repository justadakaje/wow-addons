# C_LootHistory

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`5` functions - `5` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetAllEncounterInfos

```lua
C_LootHistory.GetAllEncounterInfos() -> infos: table
```

### GetInfoForEncounter

```lua
C_LootHistory.GetInfoForEncounter(encounterID: number) -> info?: EncounterLootInfo
```

### GetLootHistoryTime

```lua
C_LootHistory.GetLootHistoryTime() -> time: number
```

### GetSortedDropsForEncounter

```lua
C_LootHistory.GetSortedDropsForEncounter(encounterID: number) -> drops?: table
```

### GetSortedInfoForDrop

```lua
C_LootHistory.GetSortedInfoForDrop(encounterID: number, lootListKey: number) -> info?: EncounterLootDropInfo
```

## Events

### LootHistoryClearHistory

Fires as `LOOT_HISTORY_CLEAR_HISTORY`.

No payload.

### LootHistoryGoToEncounter

Fires as `LOOT_HISTORY_GO_TO_ENCOUNTER`.

```lua
payload: encounterID: number
```

### LootHistoryOneHundredRoll

Fires as `LOOT_HISTORY_ONE_HUNDRED_ROLL`.

```lua
payload: encounterID: number, lootListKey: number
```

### LootHistoryUpdateDrop

Fires as `LOOT_HISTORY_UPDATE_DROP`.

```lua
payload: encounterID: number, lootListKey: number
```

### LootHistoryUpdateEncounter

Fires as `LOOT_HISTORY_UPDATE_ENCOUNTER`.

```lua
payload: encounterID: number
```
