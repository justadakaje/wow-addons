# C_EncounterJournal

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`22` functions - `3` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetBaseDifficultyID

```lua
C_EncounterJournal.GetBaseDifficultyID(difficultyID: number) -> baseDifficultyID: number
```

### GetDungeonEntrancesForMap

```lua
C_EncounterJournal.GetDungeonEntrancesForMap(uiMapID: number) -> dungeonEntrances: table
```

### GetEncounterJournalLink

```lua
C_EncounterJournal.GetEncounterJournalLink(linkType: JournalLinkTypes, ID: number, displayText: string, difficultyID: number) -> link: string
```

### GetEncountersOnMap

```lua
C_EncounterJournal.GetEncountersOnMap(uiMapID: number) -> encounters: table
```

### GetInstanceForGameMap

```lua
C_EncounterJournal.GetInstanceForGameMap(mapID: number) -> journalInstanceID?: number
```

### GetLootInfo

```lua
C_EncounterJournal.GetLootInfo(id: number) -> itemInfo: EncounterJournalItemInfo
```

### GetLootInfoByIndex

```lua
C_EncounterJournal.GetLootInfoByIndex(index: luaIndex, encounterIndex?: luaIndex) -> itemInfo: EncounterJournalItemInfo
```

### GetSectionIconFlags

```lua
C_EncounterJournal.GetSectionIconFlags(sectionID: number) -> iconFlags?: table
```

### GetSectionInfo

```lua
C_EncounterJournal.GetSectionInfo(sectionID: number) -> info: EncounterJournalSectionInfo
```

### GetSlotFilter

```lua
C_EncounterJournal.GetSlotFilter() -> filter: ItemSlotFilterType
```

### InitalizeSelectedTier

```lua
C_EncounterJournal.InitalizeSelectedTier()
```

### InstanceHasDifficultyID

```lua
C_EncounterJournal.InstanceHasDifficultyID(difficultyID: number) -> hasDifficultyID: bool
```

### InstanceHasLoot

```lua
C_EncounterJournal.InstanceHasLoot(instanceID?: number) -> hasLoot: bool
```

### IsEncounterComplete

```lua
C_EncounterJournal.IsEncounterComplete(journalEncounterID: number) -> isEncounterComplete: bool
```

### OnClose

```lua
C_EncounterJournal.OnClose()
```

### OnOpen

```lua
C_EncounterJournal.OnOpen()
```

### ResetSlotFilter

```lua
C_EncounterJournal.ResetSlotFilter()
```

### SetPreviewMythicPlusLevel

```lua
C_EncounterJournal.SetPreviewMythicPlusLevel(level: number)
```

### SetPreviewPvpTier

```lua
C_EncounterJournal.SetPreviewPvpTier(tier: number)
```

### SetSlotFilter

```lua
C_EncounterJournal.SetSlotFilter(filterSlot: ItemSlotFilterType)
```

### SetTab

```lua
C_EncounterJournal.SetTab(tabIdx: number)
```

### StartArathiRPE

```lua
C_EncounterJournal.StartArathiRPE()
```

## Events

### EjDifficultyUpdate

Fires as `EJ_DIFFICULTY_UPDATE`.

```lua
payload: difficultyID: number
```

### EjLootDataRecieved

Fires as `EJ_LOOT_DATA_RECIEVED`.

```lua
payload: itemID?: number
```

### ShowJourneysUI

Fires as `SHOW_JOURNEYS_UI`.

```lua
payload: factionID: number
```
