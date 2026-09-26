# C_TaskQuest

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`12` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### DoesMapShowTaskQuestObjectives

```lua
C_TaskQuest.DoesMapShowTaskQuestObjectives(uiMapID: number) -> showsTaskQuestObjectives: bool
```

### GetQuestInfoByQuestID

```lua
C_TaskQuest.GetQuestInfoByQuestID(questID: number) -> questTitle: cstring, factionID?: number, capped?: bool, displayAsObjective?: bool
```

### GetQuestLocation

```lua
C_TaskQuest.GetQuestLocation(questID: number, uiMapID: number) -> locationX: number, locationY: number
```

### GetQuestProgressBarInfo

```lua
C_TaskQuest.GetQuestProgressBarInfo(questID: number) -> progress: number
```

### GetQuestsOnMap

```lua
C_TaskQuest.GetQuestsOnMap(uiMapID: number) -> taskPOIs: table
```

### GetQuestTimeLeftMinutes

```lua
C_TaskQuest.GetQuestTimeLeftMinutes(questID: number) -> minutesLeft: number
```

### GetQuestTimeLeftSeconds

```lua
C_TaskQuest.GetQuestTimeLeftSeconds(questID: number) -> secondsLeft: number
```

### GetQuestUIWidgetSetByType

```lua
C_TaskQuest.GetQuestUIWidgetSetByType(questID: number, type: MapIconUIWidgetSetType) -> widgetSet: number
```

### GetQuestZoneID

```lua
C_TaskQuest.GetQuestZoneID(questID: number) -> uiMapID: number
```

### GetThreatQuests

```lua
C_TaskQuest.GetThreatQuests() -> quests: table
```

### IsActive

```lua
C_TaskQuest.IsActive(questID: number) -> active: bool
```

### RequestPreloadRewardData

```lua
C_TaskQuest.RequestPreloadRewardData(questID: number)
```
