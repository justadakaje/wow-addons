# C_Commentator

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`144` functions - `10` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddPlayerOverrideName

```lua
C_Commentator.AddPlayerOverrideName(playerName: string, overrideName: string)
```

### AddTrackedDefensiveAuras

```lua
C_Commentator.AddTrackedDefensiveAuras(spellIDs: table)
```

### AddTrackedOffensiveAuras

```lua
C_Commentator.AddTrackedOffensiveAuras(spellIDs: table)
```

### AreTeamsSwapped

```lua
C_Commentator.AreTeamsSwapped() -> teamsAreSwapped: bool
```

### AssignPlayersToTeam

```lua
C_Commentator.AssignPlayersToTeam(playerName: table, teamName: string)
```

### AssignPlayersToTeamInCurrentInstance

```lua
C_Commentator.AssignPlayersToTeamInCurrentInstance(teamIndex: luaIndex, teamName: string)
```

### AssignPlayerToTeam

```lua
C_Commentator.AssignPlayerToTeam(playerName: string, teamName: string)
```

### CanUseCommentatorCheats

```lua
C_Commentator.CanUseCommentatorCheats() -> canUseCommentatorCheats: bool
```

### ClearCameraTarget

```lua
C_Commentator.ClearCameraTarget()
```

### ClearFollowTarget

```lua
C_Commentator.ClearFollowTarget()
```

### ClearLookAtTarget

```lua
C_Commentator.ClearLookAtTarget(lookAtIndex?: luaIndex)
```

### EnterInstance

```lua
C_Commentator.EnterInstance()
```

### ExitInstance

```lua
C_Commentator.ExitInstance()
```

### FindSpectatedUnit

```lua
C_Commentator.FindSpectatedUnit(unitToken: UnitToken) -> playerIndex: luaIndex, teamIndex: luaIndex, isPet: bool
```

### FindTeamNameInCurrentInstance

```lua
C_Commentator.FindTeamNameInCurrentInstance(teamIndex: luaIndex) -> teamName?: string
```

### FindTeamNameInDirectory

```lua
C_Commentator.FindTeamNameInDirectory(playerNames: table) -> teamName?: string
```

### FlushCommentatorHistory

```lua
C_Commentator.FlushCommentatorHistory()
```

### FollowPlayer

```lua
C_Commentator.FollowPlayer(factionIndex: luaIndex, playerIndex: luaIndex, forceInstantTransition?: bool)
```

### FollowUnit

```lua
C_Commentator.FollowUnit(token: string)
```

### ForceFollowTransition

```lua
C_Commentator.ForceFollowTransition()
```

### GetAdditionalCameraWeight

```lua
C_Commentator.GetAdditionalCameraWeight() -> teamIndex: luaIndex, playerIndex: luaIndex
```

### GetAdditionalCameraWeightByToken

```lua
C_Commentator.GetAdditionalCameraWeightByToken(unitToken: UnitToken) -> weight: number
```

### GetAllPlayerOverrideNames

```lua
C_Commentator.GetAllPlayerOverrideNames() -> nameEntries: table
```

### GetCamera

```lua
C_Commentator.GetCamera() -> xPos: number, yPos: number, zPos: number, yaw: number, pitch: number, roll: number, fov: number
```

### GetCameraCollision

```lua
C_Commentator.GetCameraCollision() -> isColliding: bool
```

### GetCameraPosition

```lua
C_Commentator.GetCameraPosition() -> xPos: number, yPos: number, zPos: number
```

### GetCombatEventInfo

```lua
C_Commentator.GetCombatEventInfo()
```

### GetCommentatorHistory

```lua
C_Commentator.GetCommentatorHistory() -> history: CommentatorHistory
```

### GetCommentatorMatchDataState

```lua
C_Commentator.GetCommentatorMatchDataState() -> state: CommentatorMatchDataState
```

### GetCurrentMapID

```lua
C_Commentator.GetCurrentMapID() -> mapID?: number
```

### GetDampeningPercent

```lua
C_Commentator.GetDampeningPercent() -> percentage: number
```

### GetDistanceBeforeForcedHorizontalConvergence

```lua
C_Commentator.GetDistanceBeforeForcedHorizontalConvergence() -> distance: number
```

### GetDurationToForceHorizontalConvergence

```lua
C_Commentator.GetDurationToForceHorizontalConvergence() -> ms: number
```

### GetExcludeDistance

```lua
C_Commentator.GetExcludeDistance() -> excludeDistance: number
```

### GetHardlockWeight

```lua
C_Commentator.GetHardlockWeight() -> weight: number
```

### GetHorizontalAngleThresholdToSmooth

```lua
C_Commentator.GetHorizontalAngleThresholdToSmooth() -> angle: number
```

### GetIndirectSpellID

```lua
C_Commentator.GetIndirectSpellID(trackedSpellID: number) -> indirectSpellID: number
```

### GetInstanceInfo

```lua
C_Commentator.GetInstanceInfo(mapIndex: luaIndex, instanceIndex: luaIndex) -> mapID: number, mapName?: string, status: number, instanceIDLow: number, instanceIDHigh: number
```

### GetLookAtLerpAmount

```lua
C_Commentator.GetLookAtLerpAmount() -> amount: number
```

### GetMapInfo

```lua
C_Commentator.GetMapInfo(mapIndex: luaIndex) -> teamSize: number, minLevel: number, maxLevel: number, numInstances: number
```

### GetMatchDuration

```lua
C_Commentator.GetMatchDuration() -> seconds: time_t
```

### GetMaxNumPlayersPerTeam

```lua
C_Commentator.GetMaxNumPlayersPerTeam() -> maxNumPlayersPerTeam: number
```

### GetMaxNumTeams

```lua
C_Commentator.GetMaxNumTeams() -> maxNumTeams: number
```

### GetMode

```lua
C_Commentator.GetMode() -> commentatorMode: number
```

### GetMsToHoldForHorizontalMovement

```lua
C_Commentator.GetMsToHoldForHorizontalMovement() -> ms: number
```

### GetMsToHoldForVerticalMovement

```lua
C_Commentator.GetMsToHoldForVerticalMovement() -> ms: number
```

### GetMsToSmoothHorizontalChange

```lua
C_Commentator.GetMsToSmoothHorizontalChange() -> ms: number
```

### GetMsToSmoothVerticalChange

```lua
C_Commentator.GetMsToSmoothVerticalChange() -> ms: number
```

### GetNumMaps

```lua
C_Commentator.GetNumMaps() -> numMaps: number
```

### GetNumPlayers

```lua
C_Commentator.GetNumPlayers(factionIndex: luaIndex) -> numPlayers: number
```

### GetOrCreateSeries

```lua
C_Commentator.GetOrCreateSeries(teamName1: string, teamName2: string) -> data: CommentatorSeries
```

### GetPlayerAuraInfo

```lua
C_Commentator.GetPlayerAuraInfo(teamIndex: luaIndex, playerIndex: luaIndex, spellID: number) -> startTime: number, duration: number, enable: bool
```

### GetPlayerAuraInfoByUnit

```lua
C_Commentator.GetPlayerAuraInfoByUnit(token: UnitToken, spellID: number) -> startTime: number, duration: number, enable: bool
```

### GetPlayerCooldownInfo

```lua
C_Commentator.GetPlayerCooldownInfo(teamIndex: luaIndex, playerIndex: luaIndex, spellID: number) -> startTime: number, duration: number, enable: bool
```

### GetPlayerCooldownInfoByUnit

```lua
C_Commentator.GetPlayerCooldownInfoByUnit(unitToken: UnitToken, spellID: number) -> startTime: number, duration: number, enable: bool
```

### GetPlayerCrowdControlInfo

```lua
C_Commentator.GetPlayerCrowdControlInfo(teamIndex: luaIndex, playerIndex: luaIndex) -> spellID: number, expiration: number, duration: number
```

### GetPlayerCrowdControlInfoByUnit

```lua
C_Commentator.GetPlayerCrowdControlInfoByUnit(token: UnitToken) -> spellID: number, expiration: number, duration: number
```

### GetPlayerData

```lua
C_Commentator.GetPlayerData(teamIndex: luaIndex, playerIndex: luaIndex) -> info?: CommentatorPlayerData
```

### GetPlayerFlagInfo

```lua
C_Commentator.GetPlayerFlagInfo(teamIndex: luaIndex, playerIndex: luaIndex) -> hasFlag: bool
```

### GetPlayerFlagInfoByUnit

```lua
C_Commentator.GetPlayerFlagInfoByUnit(unitToken: UnitToken) -> hasFlag: bool
```

### GetPlayerItemCooldownInfo

```lua
C_Commentator.GetPlayerItemCooldownInfo(teamIndex: luaIndex, playerIndex: luaIndex, itemID: number) -> startTime: number, duration: number, enable: bool
```

### GetPlayerItemCooldownInfoByUnit

```lua
C_Commentator.GetPlayerItemCooldownInfoByUnit(unitToken: UnitToken, itemID: number) -> startTime: number, duration: number, enable: bool
```

### GetPlayerOverrideName

```lua
C_Commentator.GetPlayerOverrideName(originalName: string) -> overrideName: string
```

### GetPlayerSpellCharges

```lua
C_Commentator.GetPlayerSpellCharges(teamIndex: luaIndex, playerIndex: luaIndex, spellID: number) -> charges: number, maxCharges: number, startTime: number, duration: number
```

### GetPlayerSpellChargesByUnit

```lua
C_Commentator.GetPlayerSpellChargesByUnit(unitToken: UnitToken, spellID: number) -> charges: number, maxCharges: number, startTime: number, duration: number
```

### GetPositionLerpAmount

```lua
C_Commentator.GetPositionLerpAmount() -> amount: number
```

### GetSmoothFollowTransitioning

```lua
C_Commentator.GetSmoothFollowTransitioning() -> enabled: bool
```

### GetSoftlockWeight

```lua
C_Commentator.GetSoftlockWeight() -> weight: number
```

### GetSpeedFactor

```lua
C_Commentator.GetSpeedFactor() -> factor: number
```

### GetStartLocation

```lua
C_Commentator.GetStartLocation(mapID: number) -> pos: vector3
```

### GetTeamColor

```lua
C_Commentator.GetTeamColor(teamIndex: luaIndex) -> color: colorRGB
```

### GetTeamColorByUnit

```lua
C_Commentator.GetTeamColorByUnit(unitToken: UnitToken) -> color: colorRGB
```

### GetTimeLeftInMatch

```lua
C_Commentator.GetTimeLeftInMatch() -> timeLeft?: number
```

### GetTrackedSpellID

```lua
C_Commentator.GetTrackedSpellID(indirectSpellID: number) -> trackedSpellID: number
```

### GetTrackedSpells

```lua
C_Commentator.GetTrackedSpells(teamIndex: luaIndex, playerIndex: luaIndex, category: TrackedSpellCategory) -> spells?: table, result: TrackedSpellsResult
```

### GetTrackedSpellsByUnit

```lua
C_Commentator.GetTrackedSpellsByUnit(unitToken: UnitToken, category: TrackedSpellCategory) -> spells?: table, result: TrackedSpellsResult
```

### GetUnitData

```lua
C_Commentator.GetUnitData(unitToken: UnitToken) -> data: CommentatorUnitData
```

### GetWargameInfo

```lua
C_Commentator.GetWargameInfo(listID: number) -> name: string, minPlayers: number, maxPlayers: number, isArena: bool
```

### HasTrackedAuras

```lua
C_Commentator.HasTrackedAuras(token: UnitToken) -> hasOffensiveAura: bool, hasDefensiveAura: bool
```

### IsSmartCameraLocked

```lua
C_Commentator.IsSmartCameraLocked() -> isSmartCameraLocked: bool
```

### IsSpectating

```lua
C_Commentator.IsSpectating() -> isSpectating: bool
```

### IsTrackedDefensiveAura

```lua
C_Commentator.IsTrackedDefensiveAura(spellID: number) -> isDefensiveTrigger: bool
```

### IsTrackedOffensiveAura

```lua
C_Commentator.IsTrackedOffensiveAura(spellID: number) -> isOffensiveTrigger: bool
```

### IsTrackedSpell

```lua
C_Commentator.IsTrackedSpell(teamIndex: luaIndex, playerIndex: luaIndex, spellID: number, category: TrackedSpellCategory) -> isTracked: bool
```

### IsTrackedSpellByUnit

```lua
C_Commentator.IsTrackedSpellByUnit(unitToken: UnitToken, spellID: number, category: TrackedSpellCategory) -> isTracked: bool
```

### IsUsingSmartCamera

```lua
C_Commentator.IsUsingSmartCamera() -> isUsingSmartCamera: bool
```

### LookAtPlayer

```lua
C_Commentator.LookAtPlayer(factionIndex: luaIndex, playerIndex: luaIndex, lookAtIndex?: luaIndex)
```

### RemoveAllOverrideNames

```lua
C_Commentator.RemoveAllOverrideNames()
```

### RemovePlayerOverrideName

```lua
C_Commentator.RemovePlayerOverrideName(originalPlayerName: string)
```

### RequestPlayerCooldownInfo

```lua
C_Commentator.RequestPlayerCooldownInfo(teamIndex: luaIndex, playerIndex: luaIndex)
```

### ResetFoVTarget

```lua
C_Commentator.ResetFoVTarget()
```

### ResetSeriesScores

```lua
C_Commentator.ResetSeriesScores(teamName1: string, teamName2: string)
```

### ResetSettings

```lua
C_Commentator.ResetSettings()
```

### ResetTrackedAuras

```lua
C_Commentator.ResetTrackedAuras()
```

### SendAddonMessage

```lua
C_Commentator.SendAddonMessage(prefix: cstring, message: cstring, chatType?: cstring, target?: cstring) -> result: SendAddonMessageResult
```

### SendAddonMessageLogged

```lua
C_Commentator.SendAddonMessageLogged(prefix: cstring, message: cstring, chatType?: cstring, target?: cstring) -> result?: SendAddonMessageResult
```

### SetAdditionalCameraWeight

```lua
C_Commentator.SetAdditionalCameraWeight(teamIndex: luaIndex, playerIndex: luaIndex, weight: number)
```

### SetAdditionalCameraWeightByToken

```lua
C_Commentator.SetAdditionalCameraWeightByToken(unitToken: UnitToken, weight: number)
```

### SetBlocklistedAuras

```lua
C_Commentator.SetBlocklistedAuras(spellIDs: table)
```

### SetBlocklistedCooldowns

```lua
C_Commentator.SetBlocklistedCooldowns(specID: number, spellIDs: table)
```

### SetBlocklistedItemCooldowns

```lua
C_Commentator.SetBlocklistedItemCooldowns(itemIDs: table)
```

### SetCamera

```lua
C_Commentator.SetCamera(xPos: number, yPos: number, zPos: number, yaw: number, pitch: number, roll: number, fov: number)
```

### SetCameraCollision

```lua
C_Commentator.SetCameraCollision(collide: bool)
```

### SetCameraPosition

```lua
C_Commentator.SetCameraPosition(xPos: number, yPos: number, zPos: number, snapToLocation: bool)
```

### SetCheatsEnabled

```lua
C_Commentator.SetCheatsEnabled(enableCheats: bool)
```

### SetCommentatorHistory

```lua
C_Commentator.SetCommentatorHistory(history: CommentatorHistory)
```

### SetDistanceBeforeForcedHorizontalConvergence

```lua
C_Commentator.SetDistanceBeforeForcedHorizontalConvergence(distance: number)
```

### SetDurationToForceHorizontalConvergence

```lua
C_Commentator.SetDurationToForceHorizontalConvergence(ms: number)
```

### SetExcludeDistance

```lua
C_Commentator.SetExcludeDistance(excludeDistance: number)
```

### SetFollowCameraSpeeds

```lua
C_Commentator.SetFollowCameraSpeeds(elasticSpeed: number, minSpeed: number)
```

### SetHardlockWeight

```lua
C_Commentator.SetHardlockWeight(weight: number)
```

### SetHorizontalAngleThresholdToSmooth

```lua
C_Commentator.SetHorizontalAngleThresholdToSmooth(angle: number)
```

### SetLookAtLerpAmount

```lua
C_Commentator.SetLookAtLerpAmount(amount: number)
```

### SetMapAndInstanceIndex

```lua
C_Commentator.SetMapAndInstanceIndex(mapIndex: luaIndex, instanceIndex: luaIndex)
```

### SetMouseDisabled

```lua
C_Commentator.SetMouseDisabled(disabled: bool)
```

### SetMoveSpeed

```lua
C_Commentator.SetMoveSpeed(newSpeed: number)
```

### SetMsToHoldForHorizontalMovement

```lua
C_Commentator.SetMsToHoldForHorizontalMovement(ms: number)
```

### SetMsToHoldForVerticalMovement

```lua
C_Commentator.SetMsToHoldForVerticalMovement(ms: number)
```

### SetMsToSmoothHorizontalChange

```lua
C_Commentator.SetMsToSmoothHorizontalChange(ms: number)
```

### SetMsToSmoothVerticalChange

```lua
C_Commentator.SetMsToSmoothVerticalChange(ms: number)
```

### SetPositionLerpAmount

```lua
C_Commentator.SetPositionLerpAmount(amount: number)
```

### SetRequestedDebuffCooldowns

```lua
C_Commentator.SetRequestedDebuffCooldowns(specID: number, spellIDs: table)
```

### SetRequestedDefensiveCooldowns

```lua
C_Commentator.SetRequestedDefensiveCooldowns(specID: number, spellIDs: table)
```

### SetRequestedItemCooldowns

```lua
C_Commentator.SetRequestedItemCooldowns(itemIDs: table)
```

### SetRequestedOffensiveCooldowns

```lua
C_Commentator.SetRequestedOffensiveCooldowns(specID: number, spellIDs: table)
```

### SetSeriesScore

```lua
C_Commentator.SetSeriesScore(teamName1: string, teamName2: string, scoringTeamName: string, score: number)
```

### SetSeriesScores

```lua
C_Commentator.SetSeriesScores(teamName1: string, teamName2: string, score1: number, score2: number)
```

### SetSmartCameraLocked

```lua
C_Commentator.SetSmartCameraLocked(locked: bool)
```

### SetSmoothFollowTransitioning

```lua
C_Commentator.SetSmoothFollowTransitioning(enabled: bool)
```

### SetSoftlockWeight

```lua
C_Commentator.SetSoftlockWeight(weight: number)
```

### SetSpeedFactor

```lua
C_Commentator.SetSpeedFactor(factor: number)
```

### SetTargetHeightOffset

```lua
C_Commentator.SetTargetHeightOffset(offset: number)
```

### SetUseSmartCamera

```lua
C_Commentator.SetUseSmartCamera(useSmartCamera: bool)
```

### SnapCameraLookAtPoint

```lua
C_Commentator.SnapCameraLookAtPoint()
```

### SpellUsesItemCharges

```lua
C_Commentator.SpellUsesItemCharges(spellID: number) -> spellUsesItemCharges: bool
```

### StartWargame

```lua
C_Commentator.StartWargame(listID: number, teamSize: number, tournamentRules: bool, teamOneCaptain: string, teamTwoCaptain: string)
```

### SwapTeamSides

```lua
C_Commentator.SwapTeamSides()
```

### ToggleCheats

```lua
C_Commentator.ToggleCheats()
```

### UpdateMapInfo

```lua
C_Commentator.UpdateMapInfo(targetPlayer?: string)
```

### UpdatePlayerInfo

```lua
C_Commentator.UpdatePlayerInfo()
```

### ZoomIn

```lua
C_Commentator.ZoomIn()
```

### ZoomIn_Position

```lua
C_Commentator.ZoomIn_Position(zoomAmount?: number)
```

### ZoomOut

```lua
C_Commentator.ZoomOut()
```

### ZoomOut_Position

```lua
C_Commentator.ZoomOut_Position(zoomAmount?: number)
```

## Events

### CommentatorCombatEvent

Fires as `COMMENTATOR_COMBAT_EVENT`.

No payload.

### CommentatorEnterWorld

Fires as `COMMENTATOR_ENTER_WORLD`.

No payload.

### CommentatorHistoryFlushed

Fires as `COMMENTATOR_HISTORY_FLUSHED`.

No payload.

### CommentatorImmediateFovUpdate

Fires as `COMMENTATOR_IMMEDIATE_FOV_UPDATE`.

```lua
payload: fov: number
```

### CommentatorMapUpdate

Fires as `COMMENTATOR_MAP_UPDATE`.

No payload.

### CommentatorPlayerNameOverrideUpdate

Fires as `COMMENTATOR_PLAYER_NAME_OVERRIDE_UPDATE`.

```lua
payload: nameToOverride: cstring, overrideName?: cstring
```

### CommentatorPlayerUpdate

Fires as `COMMENTATOR_PLAYER_UPDATE`.

No payload.

### CommentatorResetSettings

Fires as `COMMENTATOR_RESET_SETTINGS`.

No payload.

### CommentatorTeamNameUpdate

Fires as `COMMENTATOR_TEAM_NAME_UPDATE`.

```lua
payload: teamName: string
```

### CommentatorTeamsSwapped

Fires as `COMMENTATOR_TEAMS_SWAPPED`.

```lua
payload: swapped: bool
```
