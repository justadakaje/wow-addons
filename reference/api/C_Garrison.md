# C_Garrison

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`40` functions - `65` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddFollowerToMission

```lua
C_Garrison.AddFollowerToMission(missionID: number, followerID: GarrisonFollower, boardIndex?: number) -> followerAdded: bool
```

### GetAutoCombatDamageClassValues

```lua
C_Garrison.GetAutoCombatDamageClassValues() -> damageClassStrings: table
```

### GetAutoMissionBoardState

```lua
C_Garrison.GetAutoMissionBoardState(missionID: number) -> targetInfo: table
```

### GetAutoMissionEnvironmentEffect

```lua
C_Garrison.GetAutoMissionEnvironmentEffect(missionID: number) -> autoMissionEnvEffect?: AutoMissionEnvironmentEffect
```

### GetAutoMissionTargetingInfo

```lua
C_Garrison.GetAutoMissionTargetingInfo(missionID: number, followerID: GarrisonFollower, casterBoardIndex: number) -> targetInfo: table
```

### GetAutoMissionTargetingInfoForSpell

```lua
C_Garrison.GetAutoMissionTargetingInfoForSpell(missionID: number, autoCombatSpellID: number, casterBoardIndex: number) -> targetInfo: table
```

### GetAutoTroops

```lua
C_Garrison.GetAutoTroops(followerType: number) -> autoTroopInfo: table
```

### GetCombatLogSpellInfo

```lua
C_Garrison.GetCombatLogSpellInfo(autoCombatSpellID: number) -> spellInfo?: AutoCombatSpellInfo
```

### GetCurrentCypherEquipmentLevel

```lua
C_Garrison.GetCurrentCypherEquipmentLevel() -> equipmentLevel: number
```

### GetCurrentGarrTalentTreeFriendshipFactionID

```lua
C_Garrison.GetCurrentGarrTalentTreeFriendshipFactionID() -> currentGarrTalentTreeFriendshipFactionID?: number
```

### GetCurrentGarrTalentTreeID

```lua
C_Garrison.GetCurrentGarrTalentTreeID() -> currentGarrTalentTreeID?: number
```

### GetCyphersToNextEquipmentLevel

```lua
C_Garrison.GetCyphersToNextEquipmentLevel() -> cyphersToNext?: number
```

### GetFollowerAutoCombatSpells

```lua
C_Garrison.GetFollowerAutoCombatSpells(garrFollowerID: GarrisonFollower, followerLevel: number) -> autoCombatSpells: table, autoCombatAutoAttack?: AutoCombatSpellInfo
```

### GetFollowerAutoCombatStats

```lua
C_Garrison.GetFollowerAutoCombatStats(garrFollowerID: GarrisonFollower) -> autoCombatInfo?: FollowerAutoCombatStatsInfo
```

### GetFollowerMissionCompleteInfo

```lua
C_Garrison.GetFollowerMissionCompleteInfo(followerID: GarrisonFollower) -> followerMissionCompleteInfo: FollowerMissionCompleteInfo
```

### GetGarrisonPlotsInstancesForMap

```lua
C_Garrison.GetGarrisonPlotsInstancesForMap(uiMapID: number) -> garrisonPlotInstances: table
```

### GetGarrisonTalentTreeCurrencyTypes

```lua
C_Garrison.GetGarrisonTalentTreeCurrencyTypes(garrTalentTreeID: number) -> garrTalentTreeCurrencyType?: number
```

### GetGarrisonTalentTreeType

```lua
C_Garrison.GetGarrisonTalentTreeType(garrTalentTreeID: number) -> garrTalentTreeType: number
```

### GetMaxCypherEquipmentLevel

```lua
C_Garrison.GetMaxCypherEquipmentLevel() -> maxEquipmentLevel: number
```

### GetMissionCompleteEncounters

```lua
C_Garrison.GetMissionCompleteEncounters(missionID: number) -> encounters: table
```

### GetMissionDeploymentInfo

```lua
C_Garrison.GetMissionDeploymentInfo(missionID: number) -> missionDeploymentInfo: MissionDeploymentInfo
```

### GetMissionEncounterIconInfo

```lua
C_Garrison.GetMissionEncounterIconInfo(missionID: number) -> missionEncounterIconInfo: MissionEncounterIconInfo
```

### GetTalentInfo

```lua
C_Garrison.GetTalentInfo(talentID: number) -> info: GarrisonTalentInfo
```

### GetTalentPointsSpentInTalentTree

```lua
C_Garrison.GetTalentPointsSpentInTalentTree(garrTalentTreeID: number) -> talentPoints: number
```

### GetTalentTreeIDsByClassID

```lua
C_Garrison.GetTalentTreeIDsByClassID(garrType: number, classID: number) -> treeIDs: table
```

### GetTalentTreeInfo

```lua
C_Garrison.GetTalentTreeInfo(treeID: number) -> info: GarrisonTalentTreeInfo
```

### GetTalentTreeResetInfo

```lua
C_Garrison.GetTalentTreeResetInfo(garrTalentTreeID: number) -> goldCost: number, currencyCosts: table
```

### GetTalentTreeTalentPointResearchInfo

```lua
C_Garrison.GetTalentTreeTalentPointResearchInfo(garrTalentID: number, researchRank: number, garrTalentTreeID: number, talentPointIndex: number, isRespec: bool) -> goldCost: number, currencyCosts: table, durationSecs: number
```

### GetTalentUnlockWorldQuest

```lua
C_Garrison.GetTalentUnlockWorldQuest(talentID: number) -> worldQuestID: number
```

### HasAdventures

```lua
C_Garrison.HasAdventures() -> hasAdventures: bool
```

### IsAtGarrisonMissionNPC

```lua
C_Garrison.IsAtGarrisonMissionNPC() -> atGarrisonMissionNPC: bool
```

### IsEnvironmentCountered

```lua
C_Garrison.IsEnvironmentCountered(missionID: number) -> environmentCountered: bool
```

### IsFollowerOnCompletedMission

```lua
C_Garrison.IsFollowerOnCompletedMission(followerID: GarrisonFollower) -> followerOnCompletedMission: bool
```

### IsLandingPageMinimapButtonVisible

```lua
C_Garrison.IsLandingPageMinimapButtonVisible(garrType: number) -> isLandingPageMinimapButtonVisible: bool
```

### IsTalentConditionMet

```lua
C_Garrison.IsTalentConditionMet(talentID: number) -> isMet: bool, failureString?: cstring
```

### RegenerateCombatLog

```lua
C_Garrison.RegenerateCombatLog(missionID: number) -> success: bool
```

### RemoveFollowerFromMission

```lua
C_Garrison.RemoveFollowerFromMission(missionID: number, followerID: GarrisonFollower, boardIndex?: number)
```

### RushHealAllFollowers

```lua
C_Garrison.RushHealAllFollowers(followerType: number)
```

### RushHealFollower

```lua
C_Garrison.RushHealFollower(garrFollowerID: GarrisonFollower)
```

### SetAutoCombatSpellFastForward

```lua
C_Garrison.SetAutoCombatSpellFastForward(state: bool)
```

## Events

### GarrisonArchitectClosed

Fires as `GARRISON_ARCHITECT_CLOSED`.

No payload.

### GarrisonArchitectOpened

Fires as `GARRISON_ARCHITECT_OPENED`.

```lua
payload: followerTypeID: number
```

### GarrisonBuildingActivatable

Fires as `GARRISON_BUILDING_ACTIVATABLE`.

```lua
payload: buildingName: cstring, garrisonType: number
```

### GarrisonBuildingActivated

Fires as `GARRISON_BUILDING_ACTIVATED`.

```lua
payload: garrisonPlotInstanceID: number, garrisonBuildingID: number
```

### GarrisonBuildingError

Fires as `GARRISON_BUILDING_ERROR`.

No payload.

### GarrisonBuildingListUpdate

Fires as `GARRISON_BUILDING_LIST_UPDATE`.

```lua
payload: categoryID: number
```

### GarrisonBuildingPlaced

Fires as `GARRISON_BUILDING_PLACED`.

```lua
payload: garrisonPlotInstanceID: number, newPlacement: bool
```

### GarrisonBuildingRemoved

Fires as `GARRISON_BUILDING_REMOVED`.

```lua
payload: garrPlotInstanceID: number, garrBuildingID: number
```

### GarrisonBuildingUpdate

Fires as `GARRISON_BUILDING_UPDATE`.

```lua
payload: garrisonBuildingID: number, garrPlotInstanceID?: number
```

### GarrisonFollowerAdded

Fires as `GARRISON_FOLLOWER_ADDED`.

```lua
payload: followerDbID: GarrisonFollower, followerName: cstring, followerClassName: cstring, followerLevel: number, followerQuality: number, isUpgraded: bool, textureKit: textureKit, followerTypeID: number
```

### GarrisonFollowerCategoriesUpdated

Fires as `GARRISON_FOLLOWER_CATEGORIES_UPDATED`.

No payload.

### GarrisonFollowerDurabilityChanged

Fires as `GARRISON_FOLLOWER_DURABILITY_CHANGED`.

```lua
payload: garrFollowerTypeID: number, followerDbID: GarrisonFollower, followerDurability: number
```

### GarrisonFollowerHealed

Fires as `GARRISON_FOLLOWER_HEALED`.

```lua
payload: followerID: GarrisonFollower
```

### GarrisonFollowerListUpdate

Fires as `GARRISON_FOLLOWER_LIST_UPDATE`.

```lua
payload: followerTypeID: number
```

### GarrisonFollowerRemoved

Fires as `GARRISON_FOLLOWER_REMOVED`.

```lua
payload: followerTypeID: number
```

### GarrisonFollowerUpgraded

Fires as `GARRISON_FOLLOWER_UPGRADED`.

```lua
payload: followerDbID: GarrisonFollower
```

### GarrisonFollowerXpChanged

Fires as `GARRISON_FOLLOWER_XP_CHANGED`.

```lua
payload: garrFollowerTypeID: number, followerDbID: GarrisonFollower, xpChange: number, oldFollowerXp: number, oldFollowerLevel: number, oldFollowerQuality: number
```

### GarrisonHideLandingPage

Fires as `GARRISON_HIDE_LANDING_PAGE`.

No payload.

### GarrisonInvasionAvailable

Fires as `GARRISON_INVASION_AVAILABLE`.

No payload.

### GarrisonInvasionUnavailable

Fires as `GARRISON_INVASION_UNAVAILABLE`.

No payload.

### GarrisonLandingpageShipments

Fires as `GARRISON_LANDINGPAGE_SHIPMENTS`.

No payload.

### GarrisonMissionAreaBonusAdded

Fires as `GARRISON_MISSION_AREA_BONUS_ADDED`.

```lua
payload: garrisonMissonBonusAbilityID: number
```

### GarrisonMissionBonusRollComplete

Fires as `GARRISON_MISSION_BONUS_ROLL_COMPLETE`.

```lua
payload: missionID: number, success: bool
```

### GarrisonMissionCompleteResponse

Fires as `GARRISON_MISSION_COMPLETE_RESPONSE`.

```lua
payload: missionID: number, canComplete: bool, success: bool, bonusRollSuccess: bool, followerDeaths: table, autoCombatResult?: AutoCombatResult
```

### GarrisonMissionFinished

Fires as `GARRISON_MISSION_FINISHED`.

```lua
payload: followerTypeID: number, missionID: number
```

### GarrisonMissionListUpdate

Fires as `GARRISON_MISSION_LIST_UPDATE`.

```lua
payload: garrFollowerTypeID: number
```

### GarrisonMissionNpcClosed

Fires as `GARRISON_MISSION_NPC_CLOSED`.

No payload.

### GarrisonMissionNpcOpened

Fires as `GARRISON_MISSION_NPC_OPENED`.

```lua
payload: followerTypeID: number
```

### GarrisonMissionRewardInfo

Fires as `GARRISON_MISSION_REWARD_INFO`.

```lua
payload: missionID: number, followerDbID: GarrisonFollower
```

### GarrisonMissionStarted

Fires as `GARRISON_MISSION_STARTED`.

```lua
payload: garrFollowerTypeID: number, missionID: number
```

### GarrisonMonumentCloseUi

Fires as `GARRISON_MONUMENT_CLOSE_UI`.

No payload.

### GarrisonMonumentListLoaded

Fires as `GARRISON_MONUMENT_LIST_LOADED`.

```lua
payload: success: bool
```

### GarrisonMonumentReplaced

Fires as `GARRISON_MONUMENT_REPLACED`.

```lua
payload: success: bool
```

### GarrisonMonumentSelectedTrophyIdLoaded

Fires as `GARRISON_MONUMENT_SELECTED_TROPHY_ID_LOADED`.

```lua
payload: success: bool
```

### GarrisonMonumentShowUi

Fires as `GARRISON_MONUMENT_SHOW_UI`.

No payload.

### GarrisonRandomMissionAdded

Fires as `GARRISON_RANDOM_MISSION_ADDED`.

```lua
payload: followerTypeID: number, missionID: number
```

### GarrisonRecallPortalLastUsedTime

Fires as `GARRISON_RECALL_PORTAL_LAST_USED_TIME`.

```lua
payload: success: bool, recallPortalLastUsedTime: number
```

### GarrisonRecallPortalUsed

Fires as `GARRISON_RECALL_PORTAL_USED`.

```lua
payload: success: bool
```

### GarrisonRecruitFollowerResult

Fires as `GARRISON_RECRUIT_FOLLOWER_RESULT`.

No payload.

### GarrisonRecruitmentFollowersGenerated

Fires as `GARRISON_RECRUITMENT_FOLLOWERS_GENERATED`.

No payload.

### GarrisonRecruitmentNpcClosed

Fires as `GARRISON_RECRUITMENT_NPC_CLOSED`.

No payload.

### GarrisonRecruitmentNpcOpened

Fires as `GARRISON_RECRUITMENT_NPC_OPENED`.

```lua
payload: followerTypeID: number
```

### GarrisonRecruitmentReady

Fires as `GARRISON_RECRUITMENT_READY`.

No payload.

### GarrisonShipmentReceived

Fires as `GARRISON_SHIPMENT_RECEIVED`.

No payload.

### GarrisonShipyardNpcClosed

Fires as `GARRISON_SHIPYARD_NPC_CLOSED`.

No payload.

### GarrisonShipyardNpcOpened

Fires as `GARRISON_SHIPYARD_NPC_OPENED`.

```lua
payload: followerTypeID: number
```

### GarrisonShowLandingPage

Fires as `GARRISON_SHOW_LANDING_PAGE`.

No payload.

### GarrisonSpecGroupsCleared

Fires as `GARRISON_SPEC_GROUPS_CLEARED`.

```lua
payload: garrTypeID: number
```

### GarrisonSpecGroupUpdated

Fires as `GARRISON_SPEC_GROUP_UPDATED`.

```lua
payload: garrTypeID: number, specID: number
```

### GarrisonTalentComplete

Fires as `GARRISON_TALENT_COMPLETE`.

```lua
payload: garrTypeID: number, doAlert: bool
```

### GarrisonTalentEventUpdate

Fires as `GARRISON_TALENT_EVENT_UPDATE`.

```lua
payload: eventType: number, eventID: number
```

### GarrisonTalentNpcClosed

Fires as `GARRISON_TALENT_NPC_CLOSED`.

No payload.

### GarrisonTalentNpcOpened

Fires as `GARRISON_TALENT_NPC_OPENED`.

```lua
payload: garrisonTypeID: number, garrisonTalentTreeID: number
```

### GarrisonTalentResearchStarted

Fires as `GARRISON_TALENT_RESEARCH_STARTED`.

```lua
payload: garrTypeID: number, garrisonTalentTreeID: number, garrTalentID: number
```

### GarrisonTalentUnlocksResult

Fires as `GARRISON_TALENT_UNLOCKS_RESULT`.

No payload.

### GarrisonTalentUpdate

Fires as `GARRISON_TALENT_UPDATE`.

```lua
payload: garrTypeID: number
```

### GarrisonTradeskillNpcClosed

Fires as `GARRISON_TRADESKILL_NPC_CLOSED`.

No payload.

### GarrisonUpdate

Fires as `GARRISON_UPDATE`.

No payload.

### GarrisonUpgradeableResult

Fires as `GARRISON_UPGRADEABLE_RESULT`.

```lua
payload: garrisonUpgradeable: bool
```

### GarrisonUsePartyGarrisonChanged

Fires as `GARRISON_USE_PARTY_GARRISON_CHANGED`.

No payload.

### ShipmentCrafterClosed

Fires as `SHIPMENT_CRAFTER_CLOSED`.

No payload.

### ShipmentCrafterInfo

Fires as `SHIPMENT_CRAFTER_INFO`.

```lua
payload: success: number, shipmentCount: number, maxShipments: number, ownedShipments: number, plotInstanceID: number
```

### ShipmentCrafterOpened

Fires as `SHIPMENT_CRAFTER_OPENED`.

```lua
payload: charShipmentContainerID: number
```

### ShipmentCrafterReagentUpdate

Fires as `SHIPMENT_CRAFTER_REAGENT_UPDATE`.

No payload.

### ShipmentUpdate

Fires as `SHIPMENT_UPDATE`.

```lua
payload: shipmentStarted?: bool, hasAttachedFollower?: bool
```
