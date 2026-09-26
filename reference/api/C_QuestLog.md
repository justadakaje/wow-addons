# C_QuestLog

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`93` functions - `17` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AbandonQuest

```lua
C_QuestLog.AbandonQuest()
```

### AddQuestWatch

```lua
C_QuestLog.AddQuestWatch(questID: number) -> wasWatched: bool
```

### AddWorldQuestWatch

```lua
C_QuestLog.AddWorldQuestWatch(questID: number, watchType?: QuestWatchType) -> wasWatched: bool
```

### CanAbandonQuest

```lua
C_QuestLog.CanAbandonQuest(questID: number) -> canAbandon: bool
```

### DoesQuestAwardReputationWithFaction

```lua
C_QuestLog.DoesQuestAwardReputationWithFaction(questID: number, targetFactionID: number) -> awardsReputation: bool
```

### GetAbandonQuest

```lua
C_QuestLog.GetAbandonQuest() -> questID: number
```

### GetAbandonQuestItems

```lua
C_QuestLog.GetAbandonQuestItems() -> itemIDs: table
```

### GetActivePreyQuest

```lua
C_QuestLog.GetActivePreyQuest() -> questID: number
```

### GetActiveThreatMaps

```lua
C_QuestLog.GetActiveThreatMaps() -> uiMapIDs: table
```

### GetAllCompletedQuestIDs

```lua
C_QuestLog.GetAllCompletedQuestIDs() -> quests: table
```

### GetBountiesForMapID

```lua
C_QuestLog.GetBountiesForMapID(uiMapID: number) -> bounties?: table
```

### GetBountySetInfoForMapID

```lua
C_QuestLog.GetBountySetInfoForMapID(uiMapID: number) -> displayLocation: MapOverlayDisplayLocation, lockQuestID: number, bountySetID: number, isActivitySet: bool
```

### GetDistanceSqToQuest

```lua
C_QuestLog.GetDistanceSqToQuest(questID: number) -> distanceSq: number, onContinent: bool
```

### GetHeaderIndexForQuest

```lua
C_QuestLog.GetHeaderIndexForQuest(questID: number) -> index?: luaIndex
```

### GetInfo

```lua
C_QuestLog.GetInfo(questLogIndex: luaIndex) -> info?: QuestInfo
```

### GetLogIndexForQuestID

```lua
C_QuestLog.GetLogIndexForQuestID(questID: number) -> questLogIndex?: luaIndex
```

### GetMapForQuestPOIs

```lua
C_QuestLog.GetMapForQuestPOIs() -> uiMapID: number
```

### GetMaxNumQuests

```lua
C_QuestLog.GetMaxNumQuests() -> maxNumQuests: number
```

### GetMaxNumQuestsCanAccept

```lua
C_QuestLog.GetMaxNumQuestsCanAccept() -> maxNumQuestsCanAccept: number
```

### GetNextWaypoint

```lua
C_QuestLog.GetNextWaypoint(questID: number) -> mapID: number, x: number, y: number
```

### GetNextWaypointForMap

```lua
C_QuestLog.GetNextWaypointForMap(questID: number, uiMapID: number) -> x: number, y: number
```

### GetNextWaypointText

```lua
C_QuestLog.GetNextWaypointText(questID: number) -> waypointText: string
```

### GetNumQuestLogEntries

```lua
C_QuestLog.GetNumQuestLogEntries() -> numShownEntries: number, numQuests: number
```

### GetNumQuestObjectives

```lua
C_QuestLog.GetNumQuestObjectives(questID: number) -> leaderboardCount: number
```

### GetNumQuestWatches

```lua
C_QuestLog.GetNumQuestWatches() -> numQuestWatches: number
```

### GetNumWorldQuestWatches

```lua
C_QuestLog.GetNumWorldQuestWatches() -> numQuestWatches: number
```

### GetQuestAdditionalHighlights

```lua
C_QuestLog.GetQuestAdditionalHighlights(questID: number) -> uiMapID: number, worldQuests: bool, worldQuestsElite: bool, dungeons: bool, treasures: bool
```

### GetQuestDetailsTheme

```lua
C_QuestLog.GetQuestDetailsTheme(questID: number) -> theme?: QuestTheme
```

### GetQuestDifficultyLevel

```lua
C_QuestLog.GetQuestDifficultyLevel(questID: number) -> level: number
```

### GetQuestIDForLogIndex

```lua
C_QuestLog.GetQuestIDForLogIndex(questLogIndex: luaIndex) -> questID?: number
```

### GetQuestIDForQuestWatchIndex

```lua
C_QuestLog.GetQuestIDForQuestWatchIndex(questWatchIndex: luaIndex) -> questID?: number
```

### GetQuestIDForWorldQuestWatchIndex

```lua
C_QuestLog.GetQuestIDForWorldQuestWatchIndex(questWatchIndex: luaIndex) -> questID?: number
```

### GetQuestLogMajorFactionReputationRewards

```lua
C_QuestLog.GetQuestLogMajorFactionReputationRewards(questID: number) -> reputationRewards: table
```

### GetQuestLogPortraitGiver

```lua
C_QuestLog.GetQuestLogPortraitGiver(questLogIndex?: luaIndex) -> portraitGiver: number, portraitGiverText: cstring, portraitGiverName: cstring, portraitGiverMount: number, portraitGiverModelSceneID?: number
```

### GetQuestObjectives

```lua
C_QuestLog.GetQuestObjectives(questID: number) -> objectives: table
```

### GetQuestRewardCurrencies

```lua
C_QuestLog.GetQuestRewardCurrencies(questID: number) -> questRewardCurrencies: table
```

### GetQuestRewardCurrencyInfo

```lua
C_QuestLog.GetQuestRewardCurrencyInfo(questID: number, currencyIndex: luaIndex, isChoice: bool) -> questRewardCurrencyInfo?: QuestRewardCurrencyInfo
```

### GetQuestsOnMap

```lua
C_QuestLog.GetQuestsOnMap(uiMapID: number) -> quests: table
```

### GetQuestTagInfo

```lua
C_QuestLog.GetQuestTagInfo(questID: number) -> info?: QuestTagInfo
```

### GetQuestTimers

```lua
C_QuestLog.GetQuestTimers() -> questTimers: table
```

### GetQuestType

```lua
C_QuestLog.GetQuestType(questID: number) -> questType?: number
```

### GetQuestWatchType

```lua
C_QuestLog.GetQuestWatchType(questID: number) -> watchType?: QuestWatchType
```

### GetRequiredMoney

```lua
C_QuestLog.GetRequiredMoney(questID?: number) -> requiredMoney: number
```

### GetSelectedQuest

```lua
C_QuestLog.GetSelectedQuest() -> questID: number
```

### GetSuggestedGroupSize

```lua
C_QuestLog.GetSuggestedGroupSize(questID: number) -> suggestedGroupSize: number
```

### GetTimeAllowed

```lua
C_QuestLog.GetTimeAllowed(questID: number) -> totalTime: number, elapsedTime: number
```

### GetTitleForLogIndex

```lua
C_QuestLog.GetTitleForLogIndex(questLogIndex: luaIndex) -> title?: cstring
```

### GetTitleForQuestID

```lua
C_QuestLog.GetTitleForQuestID(questID: number) -> title?: cstring
```

### GetTrivialRange

```lua
C_QuestLog.GetTrivialRange() -> range: number
```

### GetZoneStoryInfo

```lua
C_QuestLog.GetZoneStoryInfo(uiMapID: number) -> achievementID: number, storyMapID: number
```

### HasActiveThreats

```lua
C_QuestLog.HasActiveThreats() -> hasActiveThreats: bool
```

### IsAccountQuest

```lua
C_QuestLog.IsAccountQuest(questID: number) -> isAccountQuest: bool
```

### IsComplete

```lua
C_QuestLog.IsComplete(questID: number) -> isComplete: bool
```

### IsEliteQuest

```lua
C_QuestLog.IsEliteQuest(questID: number) -> isEliteQuest: bool
```

### IsFailed

```lua
C_QuestLog.IsFailed(questID: number) -> isFailed: bool
```

### IsImportantQuest

```lua
C_QuestLog.IsImportantQuest(questID: number) -> isImportant: bool
```

### IsMetaQuest

```lua
C_QuestLog.IsMetaQuest(questID: number) -> isMeta: bool
```

### IsOnMap

```lua
C_QuestLog.IsOnMap(questID: number) -> onMap: bool, hasLocalPOI: bool
```

### IsOnQuest

```lua
C_QuestLog.IsOnQuest(questID: number) -> isOnQuest: bool
```

### IsPushableQuest

```lua
C_QuestLog.IsPushableQuest(questID: number) -> isPushable: bool
```

### IsQuestBounty

```lua
C_QuestLog.IsQuestBounty(questID: number) -> isBounty: bool
```

### IsQuestCalling

```lua
C_QuestLog.IsQuestCalling(questID: number) -> isCalling: bool
```

### IsQuestCriteriaForBounty

```lua
C_QuestLog.IsQuestCriteriaForBounty(questID: number, bountyQuestID: number) -> isCriteriaForBounty: bool
```

### IsQuestDisabledForSession

```lua
C_QuestLog.IsQuestDisabledForSession(questID: number) -> isDisabled: bool
```

### IsQuestFlaggedCompleted

```lua
C_QuestLog.IsQuestFlaggedCompleted(questID: number) -> isCompleted: bool
```

### IsQuestFlaggedCompletedOnAccount

```lua
C_QuestLog.IsQuestFlaggedCompletedOnAccount(questID: number) -> isCompletedOnAccount: bool
```

### IsQuestFromContentPush

```lua
C_QuestLog.IsQuestFromContentPush(questID: number) -> isFromContentPush: bool
```

### IsQuestInvasion

```lua
C_QuestLog.IsQuestInvasion(questID: number) -> isInvasion: bool
```

### IsQuestReplayable

```lua
C_QuestLog.IsQuestReplayable(questID: number) -> isReplayable: bool
```

### IsQuestReplayedRecently

```lua
C_QuestLog.IsQuestReplayedRecently(questID: number) -> recentlyReplayed: bool
```

### IsQuestTask

```lua
C_QuestLog.IsQuestTask(questID: number) -> isTask: bool
```

### IsQuestTrivial

```lua
C_QuestLog.IsQuestTrivial(questID: number) -> isTrivial: bool
```

### IsRepeatableQuest

```lua
C_QuestLog.IsRepeatableQuest(questID: number) -> isRepeatable: bool
```

### IsThreatQuest

```lua
C_QuestLog.IsThreatQuest(questID: number) -> isThreat: bool
```

### IsUnitOnQuest

```lua
C_QuestLog.IsUnitOnQuest(unit: UnitToken, questID: number) -> isOnQuest: bool
```

### IsWorldQuest

```lua
C_QuestLog.IsWorldQuest(questID: number) -> isWorldQuest: bool
```

### QuestCanHaveWarModeBonus

```lua
C_QuestLog.QuestCanHaveWarModeBonus(questID: number) -> hasBonus: bool
```

### QuestContainsFirstTimeRepBonusForPlayer

```lua
C_QuestLog.QuestContainsFirstTimeRepBonusForPlayer(questID: number) -> questContainsFirstTimeRepBonusForPlayer: bool
```

### QuestHasQuestSessionBonus

```lua
C_QuestLog.QuestHasQuestSessionBonus(questID: number) -> hasBonus: bool
```

### QuestHasWarModeBonus

```lua
C_QuestLog.QuestHasWarModeBonus(questID: number) -> hasBonus: bool
```

### QuestIgnoresAccountCompletedFiltering

```lua
C_QuestLog.QuestIgnoresAccountCompletedFiltering(questID: number) -> questIgnoresAccountCompletedFiltering: bool
```

### ReadyForTurnIn

```lua
C_QuestLog.ReadyForTurnIn(questID: number) -> readyForTurnIn?: bool
```

### RemoveQuestWatch

```lua
C_QuestLog.RemoveQuestWatch(questID: number) -> wasRemoved: bool
```

### RemoveWorldQuestWatch

```lua
C_QuestLog.RemoveWorldQuestWatch(questID: number) -> wasRemoved: bool
```

### RequestLoadQuestByID

```lua
C_QuestLog.RequestLoadQuestByID(questID: number)
```

### SetAbandonQuest

```lua
C_QuestLog.SetAbandonQuest()
```

### SetMapForQuestPOIs

```lua
C_QuestLog.SetMapForQuestPOIs(uiMapID: number)
```

### SetSelectedQuest

```lua
C_QuestLog.SetSelectedQuest(questID: number)
```

### ShouldDisplayTimeRemaining

```lua
C_QuestLog.ShouldDisplayTimeRemaining(questID: number) -> displayTimeRemaining: bool
```

### ShouldShowQuestRewards

```lua
C_QuestLog.ShouldShowQuestRewards(questID: number) -> shouldShow: bool
```

### SortQuestWatches

```lua
C_QuestLog.SortQuestWatches()
```

### UnitIsRelatedToActiveQuest

```lua
C_QuestLog.UnitIsRelatedToActiveQuest(unit: UnitToken) -> isRelatedToActiveQuest: bool
```

### UpdateCampaignHeaders

```lua
C_QuestLog.UpdateCampaignHeaders()
```

## Events

### QuestAccepted

Fires as `QUEST_ACCEPTED`.

```lua
payload: questId: number
```

### QuestAutocomplete

Fires as `QUEST_AUTOCOMPLETE`.

```lua
payload: questId: number
```

### QuestComplete

Fires as `QUEST_COMPLETE`.

No payload.

### QuestDataLoadResult

Fires as `QUEST_DATA_LOAD_RESULT`.

```lua
payload: questID: number, success: bool
```

### QuestDetail

Fires as `QUEST_DETAIL`.

```lua
payload: questStartItemID?: number
```

### QuestlineUpdate

Fires as `QUESTLINE_UPDATE`.

```lua
payload: requestRequired: bool
```

### QuestLogCriteriaUpdate

Fires as `QUEST_LOG_CRITERIA_UPDATE`.

```lua
payload: questID: number, specificTreeID: number, description: cstring, numFulfilled: number, numRequired: number
```

### QuestLogUpdate

Fires as `QUEST_LOG_UPDATE`.

No payload.

### QuestPoiUpdate

Fires as `QUEST_POI_UPDATE`.

No payload.

### QuestRemoved

Fires as `QUEST_REMOVED`.

```lua
payload: questID: number, wasReplayQuest: bool
```

### QuestTurnedIn

Fires as `QUEST_TURNED_IN`.

```lua
payload: questID: number, xpReward: number, moneyReward: number
```

### QuestWatchListChanged

Fires as `QUEST_WATCH_LIST_CHANGED`.

```lua
payload: questID?: number, added?: bool
```

### QuestWatchUpdate

Fires as `QUEST_WATCH_UPDATE`.

```lua
payload: questID: number
```

### TaskProgressUpdate

Fires as `TASK_PROGRESS_UPDATE`.

No payload.

### TreasurePickerCacheFlush

Fires as `TREASURE_PICKER_CACHE_FLUSH`.

No payload.

### WaypointUpdate

Fires as `WAYPOINT_UPDATE`.

No payload.

### WorldQuestCompletedBySpell

Fires as `WORLD_QUEST_COMPLETED_BY_SPELL`.

```lua
payload: questID: number
```
