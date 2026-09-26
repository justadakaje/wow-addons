# C_PvP

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`113` functions - `42` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ArePvpTalentsUnlocked

```lua
C_PvP.ArePvpTalentsUnlocked() -> arePvpTalentsUnlocked: bool
```

### AreTrainingGroundsEnabled

```lua
C_PvP.AreTrainingGroundsEnabled() -> areTrainingGroundsEnabled: bool
```

### CanDisplayDeaths

```lua
C_PvP.CanDisplayDeaths() -> canDisplay: bool
```

### CanDisplayHonorableKills

```lua
C_PvP.CanDisplayHonorableKills() -> canDisplay: bool
```

### CanPlayerUseRatedPVPUI

```lua
C_PvP.CanPlayerUseRatedPVPUI() -> canUse: bool, failureReason: string
```

### CanPlayerUseTrainingGroundsUI

```lua
C_PvP.CanPlayerUseTrainingGroundsUI() -> canUseTrainingGroundsUI: bool, failureReason: string
```

### CanSurrenderArena

```lua
C_PvP.CanSurrenderArena() -> CanSurrenderArena: bool
```

### CanToggleWarMode

```lua
C_PvP.CanToggleWarMode(toggle: bool) -> canTogglePvP: bool
```

### CanToggleWarModeInArea

```lua
C_PvP.CanToggleWarModeInArea() -> canTogglePvPInArea: bool
```

### DoesMatchOutcomeAffectRating

```lua
C_PvP.DoesMatchOutcomeAffectRating() -> doesAffect: bool
```

### GetActiveBrawlInfo

```lua
C_PvP.GetActiveBrawlInfo() -> brawlInfo?: PvpBrawlInfo
```

### GetActiveMatchBracket

```lua
C_PvP.GetActiveMatchBracket() -> bracket: number
```

### GetActiveMatchDuration

```lua
C_PvP.GetActiveMatchDuration() -> seconds: time_t
```

### GetActiveMatchState

```lua
C_PvP.GetActiveMatchState() -> state: PvPMatchState
```

### GetActiveMatchWinner

```lua
C_PvP.GetActiveMatchWinner() -> winner: number
```

### GetArenaCrowdControlDuration

```lua
C_PvP.GetArenaCrowdControlDuration(playerToken: UnitToken) -> duration: LuaDurationObject
```

### GetArenaCrowdControlInfo

```lua
C_PvP.GetArenaCrowdControlInfo(playerToken: UnitToken) -> spellID: number, startTime: number, duration: number
```

### GetArenaRewards

```lua
C_PvP.GetArenaRewards(teamSize: number) -> honor: number, experience: number, itemRewards?: table, currencyRewards?: table, roleShortageBonus?: RoleShortageReward
```

### GetArenaSkirmishRewards

```lua
C_PvP.GetArenaSkirmishRewards() -> honor: number, experience: number, itemRewards?: table, currencyRewards?: table, roleShortageBonus?: RoleShortageReward
```

### GetAssignedSpecForBattlefieldQueue

```lua
C_PvP.GetAssignedSpecForBattlefieldQueue(queueID: number) -> specializationID?: number
```

### GetAvailableBrawlInfo

```lua
C_PvP.GetAvailableBrawlInfo() -> brawlInfo?: PvpBrawlInfo
```

### GetBattlefieldFlagPosition

```lua
C_PvP.GetBattlefieldFlagPosition(flagIndex: luaIndex, uiMapId: number) -> uiPosx?: number, uiPosy?: number, flagTexture: number
```

### GetBattlefieldVehicleInfo

```lua
C_PvP.GetBattlefieldVehicleInfo(vehicleIndex: luaIndex, uiMapID: number) -> info: BattlefieldVehicleInfo
```

### GetBattlefieldVehicles

```lua
C_PvP.GetBattlefieldVehicles(uiMapID: number) -> vehicles: table
```

### GetBattlegroundInfo

```lua
C_PvP.GetBattlegroundInfo(battlegroundIndex: luaIndex) -> battlegroundInfo?: BattlegroundInfo
```

### GetBrawlRewards

```lua
C_PvP.GetBrawlRewards(brawlType: BrawlType) -> honor: number, experience: number, itemRewards?: table, currencyRewards?: table, roleShortageBonus?: RoleShortageReward, hasWon: bool
```

### GetBrawlSoloRBGMinItemLevel

```lua
C_PvP.GetBrawlSoloRBGMinItemLevel() -> minItemLevel: number
```

### GetCustomVictoryStatID

```lua
C_PvP.GetCustomVictoryStatID() -> statID: number
```

### GetGlobalPvpScalingInfoForSpecID

```lua
C_PvP.GetGlobalPvpScalingInfoForSpecID(specializationID: number) -> pvpScalingData: table
```

### GetHonorRewardInfo

```lua
C_PvP.GetHonorRewardInfo(honorLevel: number) -> info?: HonorRewardInfo
```

### GetLevelUpBattlegrounds

```lua
C_PvP.GetLevelUpBattlegrounds(level: number) -> battlefields: table
```

### GetMatchPVPStatColumn

```lua
C_PvP.GetMatchPVPStatColumn(pvpStatID: number) -> info?: MatchPVPStatColumn
```

### GetMatchPVPStatColumns

```lua
C_PvP.GetMatchPVPStatColumns() -> columns: table
```

### GetNextHonorLevelForReward

```lua
C_PvP.GetNextHonorLevelForReward(honorLevel: number) -> nextHonorLevelWithReward?: number
```

### GetOutdoorPvPWaitTime

```lua
C_PvP.GetOutdoorPvPWaitTime(uiMapID: number) -> pvpWaitTime: time_t
```

### GetPersonalRatedBGBlitzSpecStats

```lua
C_PvP.GetPersonalRatedBGBlitzSpecStats() -> specStats?: RatedBGBlitzSpecStats
```

### GetPersonalRatedSoloShuffleSpecStats

```lua
C_PvP.GetPersonalRatedSoloShuffleSpecStats() -> specStats?: RatedSoloShuffleSpecStats
```

### GetPostMatchCurrencyRewards

```lua
C_PvP.GetPostMatchCurrencyRewards() -> rewards: table
```

### GetPostMatchItemRewards

```lua
C_PvP.GetPostMatchItemRewards() -> rewards: table
```

### GetPVPActiveMatchPersonalRatedInfo

```lua
C_PvP.GetPVPActiveMatchPersonalRatedInfo() -> info?: PVPPersonalRatedInfo
```

### GetPVPActiveRatedMatchDeserterPenalty

```lua
C_PvP.GetPVPActiveRatedMatchDeserterPenalty() -> deserterPenalty?: RatedMatchDeserterPenalty
```

### GetPVPSeasonRewardAchievementID

```lua
C_PvP.GetPVPSeasonRewardAchievementID() -> achievementID: number
```

### GetPvpTalentsUnlockedLevel

```lua
C_PvP.GetPvpTalentsUnlockedLevel() -> unlockLevel: number
```

### GetPvpTierID

```lua
C_PvP.GetPvpTierID(tierEnum: number, bracketEnum: luaIndex) -> id?: number
```

### GetPvpTierInfo

```lua
C_PvP.GetPvpTierInfo(tierID: number) -> pvpTierInfo?: PvpTierInfo
```

### GetRandomBGInfo

```lua
C_PvP.GetRandomBGInfo() -> info: RandomBGInfo
```

### GetRandomBGRewards

```lua
C_PvP.GetRandomBGRewards() -> honor: number, experience: number, itemRewards?: table, currencyRewards?: table, roleShortageBonus?: RoleShortageReward
```

### GetRandomEpicBGInfo

```lua
C_PvP.GetRandomEpicBGInfo() -> info: RandomBGInfo
```

### GetRandomEpicBGRewards

```lua
C_PvP.GetRandomEpicBGRewards() -> honor: number, experience: number, itemRewards?: table, currencyRewards?: table, roleShortageBonus?: RoleShortageReward
```

### GetRandomTrainingGroundArenaRewards

```lua
C_PvP.GetRandomTrainingGroundArenaRewards() -> honor: number, experience: number, itemRewards?: table, currencyRewards?: table, roleShortageBonus?: RoleShortageReward
```

### GetRandomTrainingGroundBGRewards

```lua
C_PvP.GetRandomTrainingGroundBGRewards() -> honor: number, experience: number, itemRewards?: table, currencyRewards?: table, roleShortageBonus?: RoleShortageReward
```

### GetRatedBGRewards

```lua
C_PvP.GetRatedBGRewards() -> honor: number, experience: number, itemRewards?: table, currencyRewards?: table, roleShortageBonus?: RoleShortageReward
```

### GetRatedSoloRBGMinItemLevel

```lua
C_PvP.GetRatedSoloRBGMinItemLevel() -> minItemLevel: number
```

### GetRatedSoloRBGRewards

```lua
C_PvP.GetRatedSoloRBGRewards() -> honor: number, experience: number, itemRewards?: table, currencyRewards?: table, roleShortageBonus?: RoleShortageReward
```

### GetRatedSoloShuffleMinItemLevel

```lua
C_PvP.GetRatedSoloShuffleMinItemLevel() -> minItemLevel: number
```

### GetRatedSoloShuffleRewards

```lua
C_PvP.GetRatedSoloShuffleRewards() -> honor: number, experience: number, itemRewards?: table, currencyRewards?: table, roleShortageBonus?: RoleShortageReward
```

### GetRewardItemLevelsByTierEnum

```lua
C_PvP.GetRewardItemLevelsByTierEnum(pvpTierEnum: number) -> activityItemLevel: number, weeklyItemLevel: number
```

### GetScoreInfo

```lua
C_PvP.GetScoreInfo(offsetIndex: luaIndex) -> info?: PVPScoreInfo
```

### GetScoreInfoByPlayerGuid

```lua
C_PvP.GetScoreInfoByPlayerGuid(guid: WOWGUID) -> info?: PVPScoreInfo
```

### GetSeasonBestInfo

```lua
C_PvP.GetSeasonBestInfo() -> tierID: number, nextTierID?: number
```

### GetSkirmishInfo

```lua
C_PvP.GetSkirmishInfo(pvpBracket: number) -> battlemasterListInfo: BattlemasterListInfo
```

### GetSpecialEventBrawlInfo

```lua
C_PvP.GetSpecialEventBrawlInfo() -> brawlInfo?: PvpBrawlInfo
```

### GetTeamInfo

```lua
C_PvP.GetTeamInfo(factionIndex: number) -> info?: PVPTeamInfo
```

### GetTrainingGrounds

```lua
C_PvP.GetTrainingGrounds() -> trainingGrounds: table
```

### GetUIDisplaySeason

```lua
C_PvP.GetUIDisplaySeason() -> uiDisplaySeason: number
```

### GetWarModeRewardBonus

```lua
C_PvP.GetWarModeRewardBonus() -> rewardBonus: number
```

### GetWarModeRewardBonusDefault

```lua
C_PvP.GetWarModeRewardBonusDefault() -> defaultBonus: number
```

### GetWeeklyChestInfo

```lua
C_PvP.GetWeeklyChestInfo() -> rewardAchieved: bool, lastWeekRewardAchieved: bool, lastWeekRewardClaimed: bool, pvpTierMaxFromWins: number
```

### GetZonePVPInfo

```lua
C_PvP.GetZonePVPInfo() -> pvpType: cstring, isSubZonePvP: bool, factionName?: cstring
```

### HasArenaSkirmishWinToday

```lua
C_PvP.HasArenaSkirmishWinToday() -> hasArenaSkirmishWinToday: bool
```

### HasMatchStarted

```lua
C_PvP.HasMatchStarted() -> hasStarted: bool
```

### HasRandomTrainingGroundArenaWinToday

```lua
C_PvP.HasRandomTrainingGroundArenaWinToday() -> hasRandomTrainingGroundArenaWinToday: bool
```

### HasRandomTrainingGroundBGWinToday

```lua
C_PvP.HasRandomTrainingGroundBGWinToday() -> hasRandomTrainingGroundBGWinToday: bool
```

### IsActiveBattlefield

```lua
C_PvP.IsActiveBattlefield() -> isActiveBattlefield: bool
```

### IsActiveMatchRegistered

```lua
C_PvP.IsActiveMatchRegistered() -> registered: bool
```

### IsArena

```lua
C_PvP.IsArena() -> isArena: bool
```

### IsBattleground

```lua
C_PvP.IsBattleground() -> isBattleground: bool
```

### IsBattlegroundEnlistmentBonusActive

```lua
C_PvP.IsBattlegroundEnlistmentBonusActive() -> battlegroundActive: bool, brawlActive: bool
```

### IsBrawlSoloRBG

```lua
C_PvP.IsBrawlSoloRBG() -> isBrawlSoloRBG: bool
```

### IsBrawlSoloShuffle

```lua
C_PvP.IsBrawlSoloShuffle() -> isBrawlSoloShuffle: bool
```

### IsInBrawl

```lua
C_PvP.IsInBrawl() -> isInBrawl: bool
```

### IsInRatedMatchWithDeserterPenalty

```lua
C_PvP.IsInRatedMatchWithDeserterPenalty() -> isInRatedMatchWithDeserterPenalty: bool
```

### IsMatchActive

```lua
C_PvP.IsMatchActive() -> isActive: bool
```

### IsMatchComplete

```lua
C_PvP.IsMatchComplete() -> isComplete: bool
```

### IsMatchConsideredArena

```lua
C_PvP.IsMatchConsideredArena() -> asArena: bool
```

### IsMatchFactional

```lua
C_PvP.IsMatchFactional() -> isFactional: bool
```

### IsPVPMap

```lua
C_PvP.IsPVPMap() -> isPVPMap: bool
```

### IsRatedArena

```lua
C_PvP.IsRatedArena() -> isRatedArena: bool
```

### IsRatedBattleground

```lua
C_PvP.IsRatedBattleground() -> isRatedBattleground: bool
```

### IsRatedMap

```lua
C_PvP.IsRatedMap() -> isRatedMap: bool
```

### IsRatedSoloRBG

```lua
C_PvP.IsRatedSoloRBG() -> isRatedSoloRBG: bool
```

### IsRatedSoloShuffle

```lua
C_PvP.IsRatedSoloShuffle() -> isRatedSoloShuffle: bool
```

### IsSoloRBG

```lua
C_PvP.IsSoloRBG() -> isSoloRBG: bool
```

### IsSoloShuffle

```lua
C_PvP.IsSoloShuffle() -> isSoloShuffle: bool
```

### IsSubZonePVPPOI

```lua
C_PvP.IsSubZonePVPPOI() -> result: bool
```

### IsTrainingGroundsArena

```lua
C_PvP.IsTrainingGroundsArena(lfgDungeonsID: number) -> isTrainingGroundsArena: bool
```

### IsTrainingGroundsBG

```lua
C_PvP.IsTrainingGroundsBG(lfgDungeonsID: number) -> isTrainingGroundsBG: bool
```

### IsWarModeActive

```lua
C_PvP.IsWarModeActive() -> warModeActive: bool
```

### IsWarModeDesired

```lua
C_PvP.IsWarModeDesired() -> warModeDesired: bool
```

### IsWarModeFeatureEnabled

```lua
C_PvP.IsWarModeFeatureEnabled() -> warModeEnabled: bool
```

### JoinBattlefield

```lua
C_PvP.JoinBattlefield(battlemasterListId: number)
```

### JoinBrawl

```lua
C_PvP.JoinBrawl(isSpecialBrawl: bool)
```

### JoinRandomTrainingGroundArena

```lua
C_PvP.JoinRandomTrainingGroundArena()
```

### JoinRandomTrainingGroundBG

```lua
C_PvP.JoinRandomTrainingGroundBG()
```

### JoinRatedBGBlitz

```lua
C_PvP.JoinRatedBGBlitz()
```

### JoinTrainingGround

```lua
C_PvP.JoinTrainingGround(trainingGroundID: number)
```

### RequestCrowdControlSpell

```lua
C_PvP.RequestCrowdControlSpell(playerToken: UnitToken)
```

### SetPVP

```lua
C_PvP.SetPVP(enablePVP: bool)
```

### SetWarModeDesired

```lua
C_PvP.SetWarModeDesired(warModeDesired: bool)
```

### StartSoloRBGWarGameByName

```lua
C_PvP.StartSoloRBGWarGameByName(args: cstring) -> success: number
```

### StartSpectatorSoloRBGWarGame

```lua
C_PvP.StartSpectatorSoloRBGWarGame(opaqueID1: number, opaqueID2: number, specifiedMap: cstring, tournamentRules: bool) -> success: number
```

### TogglePVP

```lua
C_PvP.TogglePVP()
```

### ToggleWarMode

```lua
C_PvP.ToggleWarMode()
```

## Events

### ArenaOpponentUpdate

Fires as `ARENA_OPPONENT_UPDATE`.

```lua
payload: unitToken: cstring, updateReason: cstring
```

### ArenaPrepOpponentSpecializations

Fires as `ARENA_PREP_OPPONENT_SPECIALIZATIONS`.

No payload.

### ArenaSeasonWorldState

Fires as `ARENA_SEASON_WORLD_STATE`.

No payload.

### BattlefieldAutoQueue

Fires as `BATTLEFIELD_AUTO_QUEUE`.

No payload.

### BattlefieldAutoQueueEject

Fires as `BATTLEFIELD_AUTO_QUEUE_EJECT`.

No payload.

### BattlefieldQueueTimeout

Fires as `BATTLEFIELD_QUEUE_TIMEOUT`.

No payload.

### BattlefieldsClosed

Fires as `BATTLEFIELDS_CLOSED`.

No payload.

### BattlefieldsShow

Fires as `BATTLEFIELDS_SHOW`.

```lua
payload: isArena?: bool, battleMasterListID?: number
```

### BattlegroundObjectivesUpdate

Fires as `BATTLEGROUND_OBJECTIVES_UPDATE`.

No payload.

### BattlegroundPointsUpdate

Fires as `BATTLEGROUND_POINTS_UPDATE`.

No payload.

### GdfSimComplete

Fires as `GDF_SIM_COMPLETE`.

No payload.

### HonorLevelUpdate

Fires as `HONOR_LEVEL_UPDATE`.

```lua
payload: isHigherLevel: bool
```

### NotifyPvpAfkResult

Fires as `NOTIFY_PVP_AFK_RESULT`.

```lua
payload: offender: cstring, numBlackMarksOnOffender: number, numPlayersIHaveReported: number
```

### PlayerEnteringBattleground

Fires as `PLAYER_ENTERING_BATTLEGROUND`.

No payload.

### PlayerJoinedPvpMatch

Fires as `PLAYER_JOINED_PVP_MATCH`.

No payload.

### PostMatchCurrencyRewardUpdate

Fires as `POST_MATCH_CURRENCY_REWARD_UPDATE`.

```lua
payload: reward: PVPPostMatchCurrencyReward
```

### PostMatchItemRewardUpdate

Fires as `POST_MATCH_ITEM_REWARD_UPDATE`.

No payload.

### PvpBrawlInfoUpdated

Fires as `PVP_BRAWL_INFO_UPDATED`.

No payload.

### PvpMatchActive

Fires as `PVP_MATCH_ACTIVE`.

No payload.

### PvpMatchComplete

Fires as `PVP_MATCH_COMPLETE`.

```lua
payload: winner: number, duration: time_t
```

### PvpMatchInactive

Fires as `PVP_MATCH_INACTIVE`.

No payload.

### PvpMatchStateChanged

Fires as `PVP_MATCH_STATE_CHANGED`.

No payload.

### PvpqueueAnywhereShow

Fires as `PVPQUEUE_ANYWHERE_SHOW`.

No payload.

### PvpqueueAnywhereUpdateAvailable

Fires as `PVPQUEUE_ANYWHERE_UPDATE_AVAILABLE`.

No payload.

### PvpRatedStatsUpdate

Fires as `PVP_RATED_STATS_UPDATE`.

No payload.

### PvpRewardsUpdate

Fires as `PVP_REWARDS_UPDATE`.

No payload.

### PvpRolePopupHide

Fires as `PVP_ROLE_POPUP_HIDE`.

```lua
payload: readyCheckInfo?: PvpReadyCheckInfo
```

### PvpRolePopupShow

Fires as `PVP_ROLE_POPUP_SHOW`.

```lua
payload: readyCheckInfo: PvpReadyCheckInfo
```

### PvpRoleUpdate

Fires as `PVP_ROLE_UPDATE`.

No payload.

### PvpSpecialEventInfoUpdated

Fires as `PVP_SPECIAL_EVENT_INFO_UPDATED`.

No payload.

### PvpTypesEnabled

Fires as `PVP_TYPES_ENABLED`.

```lua
payload: wargameBattlegrounds: bool, ratedBattlegrounds: bool, ratedArenas: bool, ratedSoloShuffle: bool, ratedBGBlitz: bool
```

### PvpVehicleInfoUpdated

Fires as `PVP_VEHICLE_INFO_UPDATED`.

No payload.

### PvpWorldstateUpdate

Fires as `PVP_WORLDSTATE_UPDATE`.

No payload.

### TrainingGroundsEnabledStatusUpdated

Fires as `TRAINING_GROUNDS_ENABLED_STATUS_UPDATED`.

No payload.

### UpdateActiveBattlefield

Fires as `UPDATE_ACTIVE_BATTLEFIELD`.

No payload.

### UpdateBattlefieldScore

Fires as `UPDATE_BATTLEFIELD_SCORE`.

No payload.

### UpdateBattlefieldStatus

Fires as `UPDATE_BATTLEFIELD_STATUS`.

```lua
payload: battleFieldIndex: number
```

### WargameInviteSent

Fires as `WARGAME_INVITE_SENT`.

No payload.

### WargameRequested

Fires as `WARGAME_REQUESTED`.

```lua
payload: opposingPartyMemberName: cstring, battlegroundName: cstring, timeoutSeconds: time_t, tournamentRules: bool
```

### WargameRequestResponse

Fires as `WARGAME_REQUEST_RESPONSE`.

```lua
payload: responderGUID: WOWGUID, responderName?: cstring, accepted: bool
```

### WarModeStatusUpdate

Fires as `WAR_MODE_STATUS_UPDATE`.

```lua
payload: warModeEnabled: bool
```

### WorldPvpQueue

Fires as `WORLD_PVP_QUEUE`.

No payload.
