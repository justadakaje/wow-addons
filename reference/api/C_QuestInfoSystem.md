# C_QuestInfoSystem

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`9` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetQuestClassification

```lua
C_QuestInfoSystem.GetQuestClassification(questID?: number, questInfoID?: number) -> classification: QuestClassification
```

### GetQuestHasShortExpirationWarning

```lua
C_QuestInfoSystem.GetQuestHasShortExpirationWarning(questID?: number) -> hasShortExpirationWarning: bool
```

### GetQuestLogRewardFavor

```lua
C_QuestInfoSystem.GetQuestLogRewardFavor(questID?: number, clampFavorToCycleCap?: bool) -> amount: number
```

### GetQuestRewardCurrencies

```lua
C_QuestInfoSystem.GetQuestRewardCurrencies(questID?: number) -> questRewardCurrencyInfo: table
```

### GetQuestRewardSpellInfo

```lua
C_QuestInfoSystem.GetQuestRewardSpellInfo(questID?: number, spellID: number) -> info?: QuestRewardSpellInfo
```

### GetQuestRewardSpells

```lua
C_QuestInfoSystem.GetQuestRewardSpells(questID?: number) -> spellIDs: table
```

### GetQuestShouldToastCompletion

```lua
C_QuestInfoSystem.GetQuestShouldToastCompletion(questID?: number) -> shouldToast: bool
```

### HasQuestRewardCurrencies

```lua
C_QuestInfoSystem.HasQuestRewardCurrencies(questID?: number) -> hasQuestRewardCurrencies: bool
```

### HasQuestRewardSpells

```lua
C_QuestInfoSystem.HasQuestRewardSpells(questID?: number) -> hasRewardSpells: bool
```
