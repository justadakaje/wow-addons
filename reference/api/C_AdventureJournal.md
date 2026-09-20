# C_AdventureJournal

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`0` functions - `14` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Events

### AjDungeonAction

Fires as `AJ_DUNGEON_ACTION`.

```lua
payload: lfgDungeonID: number
```

### AjOpen

Fires as `AJ_OPEN`.

No payload.

### AjOpenCollectionsAction

Fires as `AJ_OPEN_COLLECTIONS_ACTION`.

No payload.

### AjPveLfgAction

Fires as `AJ_PVE_LFG_ACTION`.

No payload.

### AjPvpAction

Fires as `AJ_PVP_ACTION`.

```lua
payload: battleMasterListID: number
```

### AjPvpLfgAction

Fires as `AJ_PVP_LFG_ACTION`.

No payload.

### AjPvpRbgAction

Fires as `AJ_PVP_RBG_ACTION`.

No payload.

### AjPvpSkirmishAction

Fires as `AJ_PVP_SKIRMISH_ACTION`.

No payload.

### AjPvpSpecialBgAction

Fires as `AJ_PVP_SPECIAL_BG_ACTION`.

No payload.

### AjPvpTrainingGroundsAction

Fires as `AJ_PVP_TRAINING_GROUNDS_ACTION`.

No payload.

### AjQuestLogOpen

Fires as `AJ_QUEST_LOG_OPEN`.

```lua
payload: questID: number, uiMapID: number
```

### AjRaidAction

Fires as `AJ_RAID_ACTION`.

```lua
payload: lfgDungeonID: number
```

### AjRefreshDisplay

Fires as `AJ_REFRESH_DISPLAY`.

```lua
payload: newAdventureNotice: bool
```

### AjRewardDataReceived

Fires as `AJ_REWARD_DATA_RECEIVED`.

No payload.
