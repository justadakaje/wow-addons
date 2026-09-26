# C_IslandsQueue

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`6` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CloseIslandsQueueScreen

```lua
C_IslandsQueue.CloseIslandsQueueScreen()
```

### GetIslandDifficultyInfo

```lua
C_IslandsQueue.GetIslandDifficultyInfo() -> islandDifficultyInfo: table
```

### GetIslandsMaxGroupSize

```lua
C_IslandsQueue.GetIslandsMaxGroupSize() -> maxGroupSize: number
```

### GetIslandsWeeklyQuestID

```lua
C_IslandsQueue.GetIslandsWeeklyQuestID() -> questID?: number
```

### QueueForIsland

```lua
C_IslandsQueue.QueueForIsland(difficultyID: number)
```

### RequestPreloadRewardData

```lua
C_IslandsQueue.RequestPreloadRewardData(questId: number)
```

## Events

### IslandsQueueClose

Fires as `ISLANDS_QUEUE_CLOSE`.

No payload.

### IslandsQueueOpen

Fires as `ISLANDS_QUEUE_OPEN`.

No payload.
