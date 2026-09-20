# C_QuestOffer

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`4` functions - `5` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetHideRequiredItems

```lua
C_QuestOffer.GetHideRequiredItems() -> hideRequiredItems: bool
```

### GetQuestOfferMajorFactionReputationRewards

```lua
C_QuestOffer.GetQuestOfferMajorFactionReputationRewards() -> reputationRewards: table
```

### GetQuestRequiredCurrencyInfo

```lua
C_QuestOffer.GetQuestRequiredCurrencyInfo(questRewardIndex: luaIndex) -> questRequiredCurrencyInfo?: QuestRequiredCurrencyInfo
```

### GetQuestRewardCurrencyInfo

```lua
C_QuestOffer.GetQuestRewardCurrencyInfo(questInfoType: cstring, questRewardIndex: luaIndex) -> questRewardCurrencyInfo?: QuestRewardCurrencyInfo
```

## Events

### QuestAcceptConfirm

Fires as `QUEST_ACCEPT_CONFIRM`.

```lua
payload: name: cstring, questTitle: cstring, questID: number
```

### QuestFinished

Fires as `QUEST_FINISHED`.

No payload.

### QuestGreeting

Fires as `QUEST_GREETING`.

No payload.

### QuestItemUpdate

Fires as `QUEST_ITEM_UPDATE`.

No payload.

### QuestProgress

Fires as `QUEST_PROGRESS`.

No payload.
