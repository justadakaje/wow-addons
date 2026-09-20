# C_QuestLine

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`7` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetAvailableQuestLines

```lua
C_QuestLine.GetAvailableQuestLines(uiMapID: number) -> questLines: table
```

### GetForceVisibleQuests

```lua
C_QuestLine.GetForceVisibleQuests(uiMapID: number) -> questIDs: table
```

### GetQuestLineInfo

```lua
C_QuestLine.GetQuestLineInfo(questID: number, uiMapID?: number, displayableOnly: bool) -> questLineInfo?: QuestLineInfo
```

### GetQuestLineQuests

```lua
C_QuestLine.GetQuestLineQuests(questLineID: number) -> questIDs: table
```

### IsComplete

```lua
C_QuestLine.IsComplete(questLineID: number) -> isComplete: bool
```

### QuestLineIgnoresAccountCompletedFiltering

```lua
C_QuestLine.QuestLineIgnoresAccountCompletedFiltering(uiMapID: number, questLineID: number) -> questLineIgnoresAccountCompletedFiltering: bool
```

### RequestQuestLinesForMap

```lua
C_QuestLine.RequestQuestLinesForMap(uiMapID: number)
```
