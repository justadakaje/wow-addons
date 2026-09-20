# Unit

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`217` functions - `142` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanEjectPassengerFromSeat

```lua
CanEjectPassengerFromSeat(virtualSeatIndex: luaIndex) -> result: bool
```

### CanSwitchVehicleSeat

```lua
CanSwitchVehicleSeat() -> result: bool
```

### ClosestGameObjectPosition

```lua
ClosestGameObjectPosition(gameObjectID: number) -> xPos: number, yPos: number, distance: number
```

### ClosestUnitPosition

```lua
ClosestUnitPosition(creatureID: number) -> xPos: number, yPos: number, distance: number
```

### CreateUnitHealPredictionCalculator

```lua
CreateUnitHealPredictionCalculator() -> healPredictionCalculator: UnitHealPredictionCalculator
```

### EjectPassengerFromSeat

```lua
EjectPassengerFromSeat(virtualSeatIndex: luaIndex)
```

### GetComboPoints

```lua
GetComboPoints(unit: UnitTokenPvPRestrictedForAddOns, target: UnitTokenPvPRestrictedForAddOns) -> result: number
```

### GetNegativeCorruptionEffectInfo

```lua
GetNegativeCorruptionEffectInfo() -> corruptionEffects: table
```

### GetUnitChargedPowerPoints

```lua
GetUnitChargedPowerPoints(unit: UnitToken) -> pointIndices: table
```

### GetUnitEmpowerHoldAtMaxTime

```lua
GetUnitEmpowerHoldAtMaxTime(unit: UnitToken) -> holdAtMaxTime: number
```

### GetUnitEmpowerMinHoldTime

```lua
GetUnitEmpowerMinHoldTime(unit: UnitToken) -> minHoldTime: number
```

### GetUnitEmpowerStageDuration

```lua
GetUnitEmpowerStageDuration(unit: UnitToken, index: number) -> duration: number
```

### GetUnitHealthModifier

```lua
GetUnitHealthModifier(unit: UnitToken) -> result: number
```

### GetUnitMaxHealthModifier

```lua
GetUnitMaxHealthModifier(unit: UnitToken) -> result: number
```

### GetUnitPowerBarInfo

```lua
GetUnitPowerBarInfo(unitToken: UnitToken) -> info: UnitPowerBarInfo
```

### GetUnitPowerBarInfoByID

```lua
GetUnitPowerBarInfoByID(barID: number) -> info: UnitPowerBarInfo
```

### GetUnitPowerBarStrings

```lua
GetUnitPowerBarStrings(unitToken: UnitToken) -> name?: cstring, tooltip?: cstring, cost?: cstring
```

### GetUnitPowerBarStringsByID

```lua
GetUnitPowerBarStringsByID(barID: number) -> name?: cstring, tooltip?: cstring, cost?: cstring
```

### GetUnitPowerBarTextureInfo

```lua
GetUnitPowerBarTextureInfo(unitToken: UnitToken, textureIndex: luaIndex, timerIndex?: luaIndex) -> texture: fileID, colorR: number, colorG: number, colorB: number, colorA: number
```

### GetUnitPowerBarTextureInfoByID

```lua
GetUnitPowerBarTextureInfoByID(barID: number, textureIndex: luaIndex) -> texture: fileID, colorR: number, colorG: number, colorB: number, colorA: number
```

### GetUnitPowerModifier

```lua
GetUnitPowerModifier(unit: UnitToken) -> result: number
```

### GetUnitSpeed

```lua
GetUnitSpeed(unit: UnitToken) -> currentSpeed: number, runSpeed: number, flightSpeed: number, swimSpeed: number
```

### GetUnitTotalModifiedMaxHealthPercent

```lua
GetUnitTotalModifiedMaxHealthPercent(unit: UnitToken) -> result: number
```

### GetVehicleUIIndicator

```lua
GetVehicleUIIndicator(vehicleIndicatorID: number) -> backgroundTextureID: fileID, numSeatIndicators: number
```

### GetVehicleUIIndicatorSeat

```lua
GetVehicleUIIndicatorSeat(vehicleIndicatorID: number, indicatorSeatIndex: luaIndex) -> virtualSeatIndex: number, xPos: number, yPos: number
```

### IsFalling

```lua
IsFalling(unit?: UnitToken) -> result: bool
```

### IsFlying

```lua
IsFlying(unit?: UnitToken) -> result: bool
```

### IsPlayerInGuildFromGUID

```lua
IsPlayerInGuildFromGUID(playerGUID: WOWGUID) -> IsInGuild: bool
```

### IsSubmerged

```lua
IsSubmerged(unit?: UnitToken) -> result: bool
```

### IsSwimming

```lua
IsSwimming(unit?: UnitToken) -> result: bool
```

### IsUnitModelReadyForUI

```lua
IsUnitModelReadyForUI(unitToken: UnitToken) -> isReady: bool
```

### PlayerIsPVPInactive

```lua
PlayerIsPVPInactive(unit: UnitToken) -> result: bool
```

### PlayerIsSpellTarget

```lua
PlayerIsSpellTarget(unit: UnitToken) -> result: bool
```

### PlayerVehicleHasComboPoints

```lua
PlayerVehicleHasComboPoints() -> vehicleHasComboPoints: bool
```

### RegionalUniqueNamesEnabled

```lua
RegionalUniqueNamesEnabled() -> result: bool
```

### ReportPlayerIsPVPAFK

```lua
ReportPlayerIsPVPAFK(unit: UnitToken)
```

### ResistancePercent

```lua
ResistancePercent(resistance: number, casterLevel: number) -> result: number
```

### SetPortraitTexture

```lua
SetPortraitTexture(textureObject: SimpleTexture, unitToken: UnitToken, disableMasking: bool)
```

### SetPortraitTextureFromCreatureDisplayID

```lua
SetPortraitTextureFromCreatureDisplayID(textureObject: SimpleTexture, creatureDisplayID: number)
```

### SetUnitCursorTexture

```lua
SetUnitCursorTexture(textureObject: SimpleTexture, unit: UnitToken, style?: CursorStyle, includeLowPriority?: bool, preferGamepadIcon?: bool) -> hasCursor: bool
```

### UnitAffectingCombat

```lua
UnitAffectingCombat(unit: UnitToken) -> result: bool
```

### UnitAlliedRaceInfo

```lua
UnitAlliedRaceInfo(unit: UnitToken) -> isAlliedRace: bool, hasHeritageArmorUnlocked: bool
```

### UnitArmor

```lua
UnitArmor(unit: UnitToken) -> base: number, effective: number, real: number, bonus: number
```

### UnitAttackPower

```lua
UnitAttackPower(unit: UnitToken) -> attackPower: number, posBuff: number, negBuff: number
```

### UnitAttackSpeed

```lua
UnitAttackSpeed(unit: UnitToken) -> attackSpeed: number, offhandAttackSpeed?: number, rangedAttackSpeed?: number
```

### UnitBattlePetLevel

```lua
UnitBattlePetLevel(unit: UnitToken) -> result?: number
```

### UnitBattlePetSpeciesID

```lua
UnitBattlePetSpeciesID(unit: UnitToken) -> result?: number
```

### UnitBattlePetType

```lua
UnitBattlePetType(unit: UnitToken) -> result?: number
```

### UnitCanAssist

```lua
UnitCanAssist(unit: UnitToken, target: UnitToken, canAssistImmunePC: bool, canAssistUninteractable: bool) -> result: bool
```

### UnitCanAttack

```lua
UnitCanAttack(unit: UnitToken, target: UnitToken) -> result: bool
```

### UnitCanCooperate

```lua
UnitCanCooperate(unit: UnitToken, target: UnitToken) -> result: bool
```

### UnitCanPetBattle

```lua
UnitCanPetBattle(unit: UnitToken, target: UnitToken) -> result: bool
```

### UnitCastingDuration

```lua
UnitCastingDuration(unit: UnitTokenPvPRestrictedForAddOns) -> duration: LuaDurationObject
```

### UnitCastingInfo

```lua
UnitCastingInfo(unit: UnitTokenPvPRestrictedForAddOns) -> name: cstring, displayName: string, textureID: fileID, startTimeMs: number, endTimeMs: number, isTradeskill: bool, castID: WOWGUID, notInterruptible?: bool, castingSpellID: number, castBarID?: UnitCastBarID, delayTimeMs: number
```

### UnitChannelDuration

```lua
UnitChannelDuration(unit: UnitTokenPvPRestrictedForAddOns) -> duration: LuaDurationObject
```

### UnitChannelInfo

```lua
UnitChannelInfo(unit: UnitTokenPvPRestrictedForAddOns) -> name: cstring, displayName: cstring, textureID: fileID, startTimeMs: number, endTimeMs: number, isTradeskill: bool, notInterruptible?: bool, spellID: number, isEmpowered: bool, numEmpowerStages: number, castBarID?: UnitCastBarID
```

### UnitChromieTimeID

```lua
UnitChromieTimeID(unit: UnitToken) -> ID: number
```

### UnitClass

```lua
UnitClass(unit: UnitToken) -> className: cstring, classFilename: cstring, classID: number
```

### UnitClassBase

```lua
UnitClassBase(unit: UnitToken) -> classFilename: cstring, classID: number
```

### UnitClassFromGUID

```lua
UnitClassFromGUID(unitGUID: WOWGUID) -> className: cstring, classFilename: cstring, classID: number
```

### UnitClassification

```lua
UnitClassification(unit: UnitToken) -> result: cstring
```

### UnitControllingVehicle

```lua
UnitControllingVehicle(unit: UnitToken) -> result: bool
```

### UnitCreatureFamily

```lua
UnitCreatureFamily(unit: UnitToken) -> name: cstring, id: number
```

### UnitCreatureID

```lua
UnitCreatureID(unit: UnitToken) -> creatureID?: number
```

### UnitCreatureType

```lua
UnitCreatureType(unit: UnitToken) -> name: cstring, id: number
```

### UnitDamage

```lua
UnitDamage(unit: UnitToken) -> minDamage: number, maxDamage: number, offhandMinDamage: number, offhandMaxDamage: number, posBuff: number, negBuff: number, percent: number
```

### UnitDefenseSkill

```lua
UnitDefenseSkill(unit: UnitToken) -> base: number, modifier: number
```

### UnitDetailedThreatSituation

```lua
UnitDetailedThreatSituation(unit: UnitToken, mobGUID: UnitToken) -> isTanking: bool, status: number, scaledPercentage: number, rawPercentage: number, rawThreat: number
```

### UnitDistanceSquared

```lua
UnitDistanceSquared(unit: UnitToken) -> distance: number, checkedDistance: bool
```

### UnitEffectiveLevel

```lua
UnitEffectiveLevel(name: cstring) -> result: number
```

### UnitEmpoweredChannelDuration

```lua
UnitEmpoweredChannelDuration(unit: UnitToken, includeHoldAtMaxTime: bool) -> duration: LuaDurationObject
```

### UnitEmpoweredStageDurations

```lua
UnitEmpoweredStageDurations(unit: UnitToken) -> duration: table
```

### UnitEmpoweredStagePercentages

```lua
UnitEmpoweredStagePercentages(unit: UnitToken, includeHoldAtMaxTime: bool) -> percentages: table
```

### UnitExists

```lua
UnitExists(unit?: UnitToken) -> result: bool
```

### UnitFactionGroup

```lua
UnitFactionGroup(unitName: cstring, checkDisplayRace: bool) -> factionGroupTag: cstring, localized: cstring
```

### UnitFullName

```lua
UnitFullName(unit: UnitToken) -> unitName: cstring, unitServer: cstring
```

### UnitGetDetailedHealPrediction

```lua
UnitGetDetailedHealPrediction(unit: UnitTokenPvPRestrictedForAddOns, healerUnit?: UnitTokenPvPRestrictedForAddOns, healPredictionCalculator: UnitHealPredictionCalculator)
```

### UnitGetIncomingHeals

```lua
UnitGetIncomingHeals(unit: UnitTokenPvPRestrictedForAddOns, healerGUID?: UnitTokenPvPRestrictedForAddOns) -> result?: number
```

### UnitGetTotalAbsorbs

```lua
UnitGetTotalAbsorbs(unit: UnitTokenPvPRestrictedForAddOns) -> result: number
```

### UnitGetTotalHealAbsorbs

```lua
UnitGetTotalHealAbsorbs(unit: UnitTokenPvPRestrictedForAddOns) -> result: number
```

### UnitGroupRolesAssigned

```lua
UnitGroupRolesAssigned(unit?: UnitToken) -> result: cstring
```

### UnitGroupRolesAssignedEnum

```lua
UnitGroupRolesAssignedEnum(unit?: UnitToken) -> result: number
```

### UnitGUID

```lua
UnitGUID(unit: UnitTokenPvPRestrictedForAddOns) -> result?: WOWGUID
```

### UnitHasEffectivelyTankAura

```lua
UnitHasEffectivelyTankAura(unit?: UnitToken) -> result: bool
```

### UnitHasLootInteraction

```lua
UnitHasLootInteraction(unit: UnitToken) -> result: bool
```

### UnitHasMouseoverHighlight

```lua
UnitHasMouseoverHighlight(unit: UnitToken) -> result: bool
```

### UnitHasPowerType

```lua
UnitHasPowerType(unitToken: UnitTokenPvPRestrictedForAddOns, powerType: PowerType) -> hasPower: bool
```

### UnitHasRelicSlot

```lua
UnitHasRelicSlot(unit: UnitToken) -> result: bool
```

### UnitHasVehiclePlayerFrameUI

```lua
UnitHasVehiclePlayerFrameUI(unit?: UnitToken) -> result: bool
```

### UnitHasVehicleUI

```lua
UnitHasVehicleUI(unit?: UnitToken) -> result: bool
```

### UnitHealth

```lua
UnitHealth(unit: UnitTokenPvPRestrictedForAddOns, usePredicted: bool) -> result: number
```

### UnitHealthMax

```lua
UnitHealthMax(unit: UnitTokenPvPRestrictedForAddOns) -> result: number
```

### UnitHealthMissing

```lua
UnitHealthMissing(unit: UnitTokenPvPRestrictedForAddOns, usePredicted: bool) -> result: number
```

### UnitHealthPercent

```lua
UnitHealthPercent(unit: UnitTokenPvPRestrictedForAddOns, usePredicted: bool, curve?: LuaCurveObjectBase) -> result: LuaCurveEvaluatedResult
```

### UnitHonor

```lua
UnitHonor(unit: UnitToken) -> result: number
```

### UnitHonorLevel

```lua
UnitHonorLevel(unit: UnitToken) -> result: number
```

### UnitHonorMax

```lua
UnitHonorMax(unit: UnitToken) -> result: number
```

### UnitHPPerStamina

```lua
UnitHPPerStamina(unit: UnitToken) -> result: number
```

### UnitInAnyGroup

```lua
UnitInAnyGroup(unit?: UnitToken, partyIndex?: luaIndex) -> result: bool
```

### UnitInBattleground

```lua
UnitInBattleground(unit?: UnitToken, partyIndex?: luaIndex) -> result?: luaIndex
```

### UnitInOtherParty

```lua
UnitInOtherParty(unit: UnitToken) -> inOtherParty: bool
```

### UnitInParty

```lua
UnitInParty(unit?: UnitToken, partyIndex?: luaIndex) -> result: bool
```

### UnitInPartyIsAI

```lua
UnitInPartyIsAI(unit?: UnitToken) -> result: bool
```

### UnitInPartyShard

```lua
UnitInPartyShard(unit: UnitToken) -> inPartyShard: bool
```

### UnitInRaid

```lua
UnitInRaid(unit?: UnitToken, partyIndex?: luaIndex) -> result?: luaIndex
```

### UnitInRange

```lua
UnitInRange(unit: UnitToken) -> inRange: bool, checkedRange: bool
```

### UnitInSubgroup

```lua
UnitInSubgroup(unit?: UnitToken, partyIndex?: luaIndex) -> result: bool
```

### UnitInVehicle

```lua
UnitInVehicle(unit: UnitToken) -> result: bool
```

### UnitInVehicleControlSeat

```lua
UnitInVehicleControlSeat(unit?: UnitToken) -> result: bool
```

### UnitInVehicleHidesPetFrame

```lua
UnitInVehicleHidesPetFrame(unit?: UnitToken) -> result: bool
```

### UnitIsAFK

```lua
UnitIsAFK(unit: UnitToken) -> result: bool
```

### UnitIsBattlePet

```lua
UnitIsBattlePet(unit: UnitToken) -> result?: bool
```

### UnitIsBattlePetCompanion

```lua
UnitIsBattlePetCompanion(unit: UnitToken) -> result: bool
```

### UnitIsBossMob

```lua
UnitIsBossMob(unit: UnitToken) -> result: bool
```

### UnitIsCharmed

```lua
UnitIsCharmed(unit?: UnitToken) -> result: bool
```

### UnitIsConnected

```lua
UnitIsConnected(unit: UnitToken) -> isConnected: bool
```

### UnitIsControlling

```lua
UnitIsControlling(unit: UnitToken) -> result: bool
```

### UnitIsCorpse

```lua
UnitIsCorpse(unit?: UnitToken) -> result: bool
```

### UnitIsDead

```lua
UnitIsDead(unit: UnitToken) -> result: bool
```

### UnitIsDeadOrGhost

```lua
UnitIsDeadOrGhost(unit: UnitToken) -> result: bool
```

### UnitIsDND

```lua
UnitIsDND(unit: UnitToken) -> result: bool
```

### UnitIsEnemy

```lua
UnitIsEnemy(unit: UnitToken, target: UnitToken) -> result: bool
```

### UnitIsFeignDeath

```lua
UnitIsFeignDeath(unit: UnitToken) -> result: bool
```

### UnitIsFriend

```lua
UnitIsFriend(unit: UnitToken, target: UnitToken) -> result: bool
```

### UnitIsGameObject

```lua
UnitIsGameObject(unit?: UnitToken) -> result: bool
```

### UnitIsGhost

```lua
UnitIsGhost(unit: UnitToken) -> result: bool
```

### UnitIsGroupAssistant

```lua
UnitIsGroupAssistant(unit: UnitToken) -> isAssistant: bool
```

### UnitIsGroupLeader

```lua
UnitIsGroupLeader(unit: UnitToken, partyCategory?: luaIndex) -> isLeader: bool
```

### UnitIsHumanPlayer

```lua
UnitIsHumanPlayer(unit?: UnitToken, partyIndex?: luaIndex) -> result: bool
```

### UnitIsInInteractRange

```lua
UnitIsInInteractRange(unit: UnitToken) -> result: bool
```

### UnitIsInMyGuild

```lua
UnitIsInMyGuild(unit: cstring) -> result: bool
```

### UnitIsInteractable

```lua
UnitIsInteractable(unit?: UnitToken) -> result: bool
```

### UnitIsLieutenant

```lua
UnitIsLieutenant(unit: UnitToken) -> result: bool
```

### UnitIsMercenary

```lua
UnitIsMercenary(name: cstring) -> result: bool
```

### UnitIsMinion

```lua
UnitIsMinion(unit: UnitToken) -> result: bool
```

### UnitIsNPCAsPlayer

```lua
UnitIsNPCAsPlayer(unit?: UnitToken) -> result: bool
```

### UnitIsOtherPlayersBattlePet

```lua
UnitIsOtherPlayersBattlePet(unit?: UnitToken) -> result: bool
```

### UnitIsOtherPlayersPet

```lua
UnitIsOtherPlayersPet(unit?: UnitToken) -> result: bool
```

### UnitIsOwnerOrControllerOfUnit

```lua
UnitIsOwnerOrControllerOfUnit(controllingUnit: UnitToken, controlledUnit: UnitToken) -> unitIsOwnerOrControllerOfUnit: bool
```

### UnitIsPlayer

```lua
UnitIsPlayer(unit?: UnitToken, partyIndex?: luaIndex) -> result: bool
```

### UnitIsPlayerControlledOrGroupMember

```lua
UnitIsPlayerControlledOrGroupMember(unit: UnitToken) -> result: bool
```

### UnitIsPossessed

```lua
UnitIsPossessed(unit?: UnitToken) -> result: bool
```

### UnitIsPVP

```lua
UnitIsPVP(unit: UnitToken) -> result: bool
```

### UnitIsPVPFreeForAll

```lua
UnitIsPVPFreeForAll(unit: UnitToken) -> result: bool
```

### UnitIsPVPSanctuary

```lua
UnitIsPVPSanctuary(unit?: UnitToken) -> result: bool
```

### UnitIsQuestBoss

```lua
UnitIsQuestBoss(unit: UnitToken) -> result: bool
```

### UnitIsRaidOfficer

```lua
UnitIsRaidOfficer(unit?: UnitToken) -> result: bool
```

### UnitIsSameServer

```lua
UnitIsSameServer(unitName: cstring) -> result: bool
```

### UnitIsTapDenied

```lua
UnitIsTapDenied(unit: UnitToken) -> result: bool
```

### UnitIsTrivial

```lua
UnitIsTrivial(unit: UnitToken) -> result: bool
```

### UnitIsUnconscious

```lua
UnitIsUnconscious(unit: UnitToken) -> result: bool
```

### UnitIsUnit

```lua
UnitIsUnit(unit1: UnitToken, unit2: UnitToken) -> result: bool
```

### UnitIsVisible

```lua
UnitIsVisible(unit?: UnitToken) -> result: bool
```

### UnitIsWildBattlePet

```lua
UnitIsWildBattlePet(unit: UnitToken) -> result: bool
```

### UnitLeadsAnyGroup

```lua
UnitLeadsAnyGroup(unit: UnitToken) -> isLeader: bool
```

### UnitLevel

```lua
UnitLevel(name: cstring) -> result: number
```

### UnitName

```lua
UnitName(unit: UnitToken) -> unitName: cstring, unitServer: cstring
```

### UnitNameFromGUID

```lua
UnitNameFromGUID(unitGUID: WOWGUID) -> unitName: cstring, unitServer: cstring
```

### UnitNameplateShowsWidgetsOnly

```lua
UnitNameplateShowsWidgetsOnly(unit: UnitToken) -> nameplateShowsWidgetsOnly: bool
```

### UnitNameUnmodified

```lua
UnitNameUnmodified(unit: UnitToken) -> unitName: cstring, unitServer: cstring
```

### UnitNumPowerBarTimers

```lua
UnitNumPowerBarTimers(unit: UnitToken) -> result: number
```

### UnitOnTaxi

```lua
UnitOnTaxi(unit: UnitToken) -> result: bool
```

### UnitOwnerGUID

```lua
UnitOwnerGUID(unit: UnitTokenPvPRestrictedForAddOns) -> ownerGUID: WOWGUID
```

### UnitPartialPower

```lua
UnitPartialPower(unitToken: UnitTokenPvPRestrictedForAddOns, powerType?: PowerType, unmodified: bool) -> partialPower: number
```

### UnitPercentHealthFromGUID

```lua
UnitPercentHealthFromGUID(unitGUID: WOWGUID) -> percentHealth?: number
```

### UnitPhaseReason

```lua
UnitPhaseReason(unit: UnitToken) -> reason?: PhaseReason
```

### UnitPlayerControlled

```lua
UnitPlayerControlled(unit?: UnitToken) -> result: bool
```

### UnitPlayerOrPetInParty

```lua
UnitPlayerOrPetInParty(unit?: UnitToken, partyIndex?: luaIndex) -> result: bool
```

### UnitPlayerOrPetInRaid

```lua
UnitPlayerOrPetInRaid(unit?: UnitToken, partyIndex?: luaIndex) -> result: bool
```

### UnitPosition

```lua
UnitPosition(unit: UnitToken) -> positionX: number, positionY: number, positionZ: number, mapID: number
```

### UnitPower

```lua
UnitPower(unitToken: UnitTokenPvPRestrictedForAddOns, powerType?: PowerType, unmodified: bool) -> power: number
```

### UnitPowerBarID

```lua
UnitPowerBarID(unitToken: UnitToken) -> barID: number
```

### UnitPowerBarTimerInfo

```lua
UnitPowerBarTimerInfo(unit: UnitToken, index: luaIndex) -> duration: number, expiration: number, barID: number, auraID: number
```

### UnitPowerDisplayMod

```lua
UnitPowerDisplayMod(powerType: PowerType) -> displayMod: number
```

### UnitPowerMax

```lua
UnitPowerMax(unitToken: UnitTokenPvPRestrictedForAddOns, powerType?: PowerType, unmodified: bool) -> maxPower: number
```

### UnitPowerMissing

```lua
UnitPowerMissing(unitToken: UnitTokenPvPRestrictedForAddOns, powerType?: PowerType, unmodified: bool) -> result: number
```

### UnitPowerPercent

```lua
UnitPowerPercent(unitToken: UnitTokenPvPRestrictedForAddOns, powerType?: PowerType, unmodified: bool, curve?: LuaCurveObjectBase) -> result: LuaCurveEvaluatedResult
```

### UnitPowerType

```lua
UnitPowerType(unit: UnitTokenPvPRestrictedForAddOns, index: number) -> powerType: PowerType, powerTypeToken: string, rgbX: number, rgbY: number, rgbZ: number
```

### UnitPvpClassification

```lua
UnitPvpClassification(unit: UnitTokenPvPRestrictedForAddOns) -> classification?: PvPUnitClassification
```

### UnitPVPName

```lua
UnitPVPName(unit: UnitToken) -> result: string
```

### UnitQuestTrivialLevelRange

```lua
UnitQuestTrivialLevelRange(unit: UnitToken) -> levelRange: number
```

### UnitQuestTrivialLevelRangeScaling

```lua
UnitQuestTrivialLevelRangeScaling(unit: UnitToken) -> levelRange: number
```

### UnitRace

```lua
UnitRace(unit: UnitToken) -> localizedRaceName: cstring, englishRaceName: cstring, raceID: number
```

### UnitRangedAttackPower

```lua
UnitRangedAttackPower(unit: UnitToken) -> attackPower: number, posBuff: number, negBuff: number
```

### UnitRangedDamage

```lua
UnitRangedDamage(unit: UnitToken) -> speed: number, minDamage: number, maxDamage: number, posBuff: number, negBuff: number, percent: number
```

### UnitReaction

```lua
UnitReaction(unit: UnitToken, target: UnitToken) -> result?: luaIndex
```

### UnitRealmRelationship

```lua
UnitRealmRelationship(unit: UnitToken) -> realmRelationship?: luaIndex
```

### UnitResistance

```lua
UnitResistance(unit: UnitToken, damageClass: Damageclass) -> baseResistance: number, realResistance: number, effectiveResistance: number, bonusResistance: number
```

### UnitSelectionColor

```lua
UnitSelectionColor(unit: UnitToken, useExtendedColors: bool) -> resultR: number, resultG: number, resultB: number, resultA: number
```

### UnitSelectionType

```lua
UnitSelectionType(unit: UnitToken, useExtendedColors: bool) -> result: number
```

### UnitSex

```lua
UnitSex(unit: UnitToken) -> sex?: number
```

### UnitSexBase

```lua
UnitSexBase(unit: UnitToken) -> sex?: UnitSex
```

### UnitShouldDisplayName

```lua
UnitShouldDisplayName(unit: UnitToken) -> result: bool
```

### UnitShouldDisplaySpellTargetName

```lua
UnitShouldDisplaySpellTargetName(unit: UnitToken) -> result: bool
```

### UnitSpellHaste

```lua
UnitSpellHaste(unit: UnitToken) -> result: number
```

### UnitSpellTargetClass

```lua
UnitSpellTargetClass(unit: UnitToken) -> classFilename: cstring
```

### UnitSpellTargetName

```lua
UnitSpellTargetName(unit: UnitToken) -> targetName: cstring
```

### UnitStagger

```lua
UnitStagger(unit: UnitTokenPvPRestrictedForAddOns) -> result: number
```

### UnitStat

```lua
UnitStat(unit: UnitToken, index: luaIndex) -> currentStat: number, effectiveStat: number, statPositiveBuff: number, statNegativeBuff: number
```

### UnitSwitchToVehicleSeat

```lua
UnitSwitchToVehicleSeat(unit: UnitToken, virtualSeatIndex: luaIndex)
```

### UnitTargetsVehicleInRaidUI

```lua
UnitTargetsVehicleInRaidUI(unit?: UnitToken) -> result: bool
```

### UnitThreatLeadSituation

```lua
UnitThreatLeadSituation(unit: UnitToken, mobGUID: UnitToken) -> result?: number
```

### UnitThreatPercentageOfLead

```lua
UnitThreatPercentageOfLead(unit: UnitToken, mobGUID: UnitToken) -> result?: number
```

### UnitThreatSituation

```lua
UnitThreatSituation(unit: UnitToken, mobGUID?: UnitToken) -> result?: number
```

### UnitTokenFromGUID

```lua
UnitTokenFromGUID(unitGUID: WOWGUID) -> unitToken?: string
```

### UnitTreatAsPlayerForDisplay

```lua
UnitTreatAsPlayerForDisplay(unit: UnitToken) -> treatAsPlayer: bool
```

### UnitTrialBankedLevels

```lua
UnitTrialBankedLevels(unit: UnitToken) -> bankedLevels: number, xpIntoCurrentLevel: number, xpForNextLevel: number
```

### UnitTrialXP

```lua
UnitTrialXP(unit: UnitToken) -> result: number
```

### UnitUsingVehicle

```lua
UnitUsingVehicle(unit: UnitToken) -> result: bool
```

### UnitVehicleSeatCount

```lua
UnitVehicleSeatCount(unit: UnitToken) -> result: number
```

### UnitVehicleSeatInfo

```lua
UnitVehicleSeatInfo(unit: UnitToken, virtualSeatIndex: luaIndex) -> controlType: cstring, occupantName: cstring, serverName: cstring, ejectable: bool, canSwitchSeats: bool
```

### UnitVehicleSkin

```lua
UnitVehicleSkin(unit?: UnitToken) -> result: fileID
```

### UnitWeaponAttackPower

```lua
UnitWeaponAttackPower(unit: UnitToken) -> mainHandWeaponAttackPower: number, offHandWeaponAttackPower: number, rangedWeaponAttackPower: number
```

### UnitWidgetSet

```lua
UnitWidgetSet(unit: UnitToken) -> uiWidgetSet: number
```

### UnitXP

```lua
UnitXP(unit: UnitToken) -> result: number
```

### UnitXPMax

```lua
UnitXPMax(unit: UnitToken) -> result: number
```

### WorldLootObjectExists

```lua
WorldLootObjectExists(unit?: UnitToken) -> result: bool
```

## Events

### ActivePlayerSpecializationChanged

Fires as `ACTIVE_PLAYER_SPECIALIZATION_CHANGED`.

No payload.

### ArenaCooldownsUpdate

Fires as `ARENA_COOLDOWNS_UPDATE`.

No payload.

### ArenaCrowdControlSpellUpdate

Fires as `ARENA_CROWD_CONTROL_SPELL_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant, spellID: number
```

### AutofollowBegin

Fires as `AUTOFOLLOW_BEGIN`.

```lua
payload: name: cstring
```

### AutofollowEnd

Fires as `AUTOFOLLOW_END`.

No payload.

### CancelSummon

Fires as `CANCEL_SUMMON`.

No payload.

### ComboTargetChanged

Fires as `COMBO_TARGET_CHANGED`.

No payload.

### ConfirmBinder

Fires as `CONFIRM_BINDER`.

```lua
payload: areaName: cstring
```

### ConfirmSummon

Fires as `CONFIRM_SUMMON`.

```lua
payload: summonReason: number, skippingStartExperience: bool
```

### EclipseDirectionChange

Fires as `ECLIPSE_DIRECTION_CHANGE`.

```lua
payload: direction: cstring
```

### HearthstoneBound

Fires as `HEARTHSTONE_BOUND`.

No payload.

### HonorXpUpdate

Fires as `HONOR_XP_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### IncomingResurrectChanged

Fires as `INCOMING_RESURRECT_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### IncomingSummonChanged

Fires as `INCOMING_SUMMON_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### KnownTitlesUpdate

Fires as `KNOWN_TITLES_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### LocalplayerPetRenamed

Fires as `LOCALPLAYER_PET_RENAMED`.

No payload.

### MirrorTimerPause

Fires as `MIRROR_TIMER_PAUSE`.

```lua
payload: timerName: cstring, paused: number
```

### MirrorTimerStart

Fires as `MIRROR_TIMER_START`.

```lua
payload: timerName: cstring, value: number, maxValue: number, scale: number, paused: number, timerLabel: cstring
```

### MirrorTimerStop

Fires as `MIRROR_TIMER_STOP`.

```lua
payload: timerName: cstring
```

### NeutralFactionSelectResult

Fires as `NEUTRAL_FACTION_SELECT_RESULT`.

```lua
payload: success: bool
```

### ObjectEnteredAOI

Fires as `OBJECT_ENTERED_AOI`.

```lua
payload: guid: WOWGUID
```

### ObjectLeftAOI

Fires as `OBJECT_LEFT_AOI`.

```lua
payload: guid: WOWGUID
```

### PartyKill

Fires as `PARTY_KILL`.

```lua
payload: attackerGUID: WOWGUID, targetGUID: WOWGUID
```

### PetBarUpdateUsable

Fires as `PET_BAR_UPDATE_USABLE`.

No payload.

### PetUiUpdate

Fires as `PET_UI_UPDATE`.

No payload.

### PlayerCanGlideChanged

Fires as `PLAYER_CAN_GLIDE_CHANGED`.

```lua
payload: canGlide: bool
```

### PlayerDamageDoneMods

Fires as `PLAYER_DAMAGE_DONE_MODS`.

```lua
payload: unitTarget: UnitTokenVariant
```

### PlayerEnterCombat

Fires as `PLAYER_ENTER_COMBAT`.

No payload.

### PlayerFarsightFocusChanged

Fires as `PLAYER_FARSIGHT_FOCUS_CHANGED`.

No payload.

### PlayerFlagsChanged

Fires as `PLAYER_FLAGS_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### PlayerFocusChanged

Fires as `PLAYER_FOCUS_CHANGED`.

No payload.

### PlayerImpulseApplied

Fires as `PLAYER_IMPULSE_APPLIED`.

No payload.

### PlayerIsGlidingChanged

Fires as `PLAYER_IS_GLIDING_CHANGED`.

```lua
payload: isGliding: bool
```

### PlayerLeaveCombat

Fires as `PLAYER_LEAVE_COMBAT`.

No payload.

### PlayerLevelChanged

Fires as `PLAYER_LEVEL_CHANGED`.

```lua
payload: oldLevel: number, newLevel: number, real: bool
```

### PlayerLevelUp

Fires as `PLAYER_LEVEL_UP`.

```lua
payload: level: number, healthDelta: number, powerDelta: number, numNewTalents: number, numNewPvpTalentSlots: number, strengthDelta: number, agilityDelta: number, staminaDelta: number, intellectDelta: number
```

### PlayerMaxLevelUpdate

Fires as `PLAYER_MAX_LEVEL_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### PlayerMountDisplayChanged

Fires as `PLAYER_MOUNT_DISPLAY_CHANGED`.

No payload.

### PlayerPvpKillsChanged

Fires as `PLAYER_PVP_KILLS_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### PlayerPvpRankChanged

Fires as `PLAYER_PVP_RANK_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### PlayerRegenDisabled

Fires as `PLAYER_REGEN_DISABLED`.

No payload.

### PlayerRegenEnabled

Fires as `PLAYER_REGEN_ENABLED`.

No payload.

### PlayerSoftEnemyChanged

Fires as `PLAYER_SOFT_ENEMY_CHANGED`.

No payload.

### PlayerSoftFriendChanged

Fires as `PLAYER_SOFT_FRIEND_CHANGED`.

No payload.

### PlayerSoftInteractChanged

Fires as `PLAYER_SOFT_INTERACT_CHANGED`.

```lua
payload: oldTarget: WOWGUID, newTarget: WOWGUID
```

### PlayerSoftTargetInteraction

Fires as `PLAYER_SOFT_TARGET_INTERACTION`.

No payload.

### PlayerSpecializationChanged

Fires as `PLAYER_SPECIALIZATION_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### PlayerStartedLooking

Fires as `PLAYER_STARTED_LOOKING`.

No payload.

### PlayerStartedMoving

Fires as `PLAYER_STARTED_MOVING`.

No payload.

### PlayerStartedTurning

Fires as `PLAYER_STARTED_TURNING`.

No payload.

### PlayerStoppedLooking

Fires as `PLAYER_STOPPED_LOOKING`.

No payload.

### PlayerStoppedMoving

Fires as `PLAYER_STOPPED_MOVING`.

No payload.

### PlayerStoppedTurning

Fires as `PLAYER_STOPPED_TURNING`.

No payload.

### PlayerTargetChanged

Fires as `PLAYER_TARGET_CHANGED`.

No payload.

### PlayerTrialXpUpdate

Fires as `PLAYER_TRIAL_XP_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### PlayerUpdateResting

Fires as `PLAYER_UPDATE_RESTING`.

No payload.

### PlayerXpUpdate

Fires as `PLAYER_XP_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### PortraitsUpdated

Fires as `PORTRAITS_UPDATED`.

No payload.

### ProvingGroundsScoreUpdate

Fires as `PROVING_GROUNDS_SCORE_UPDATE`.

```lua
payload: points: number
```

### PvpTimerUpdate

Fires as `PVP_TIMER_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### RunePowerUpdate

Fires as `RUNE_POWER_UPDATE`.

```lua
payload: runeIndex: number, added?: bool
```

### RuneTypeUpdate

Fires as `RUNE_TYPE_UPDATE`.

```lua
payload: runeIndex: number
```

### ShowFactionSelectUi

Fires as `SHOW_FACTION_SELECT_UI`.

No payload.

### SpellConfirmationPrompt

Fires as `SPELL_CONFIRMATION_PROMPT`.

```lua
payload: spellID: number, effectValue: number, message: cstring, duration: number, currencyTypesID: number, currencyCost: number, currentDifficulty: number, displayItemID: number, itemContext: number, treasureContextLevel: number
```

### SpellConfirmationTimeout

Fires as `SPELL_CONFIRMATION_TIMEOUT`.

```lua
payload: spellID: number, effectValue: number
```

### UnitAbsorbAmountChanged

Fires as `UNIT_ABSORB_AMOUNT_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitAreaChanged

Fires as `UNIT_AREA_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitArenaCooldownsUpdate

Fires as `UNIT_ARENA_COOLDOWNS_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitAttack

Fires as `UNIT_ATTACK`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitAttackPower

Fires as `UNIT_ATTACK_POWER`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitAttackSpeed

Fires as `UNIT_ATTACK_SPEED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitCheatToggleEvent

Fires as `UNIT_CHEAT_TOGGLE_EVENT`.

No payload.

### UnitClassificationChanged

Fires as `UNIT_CLASSIFICATION_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitCombat

Fires as `UNIT_COMBAT`.

```lua
payload: unitTarget: UnitTokenVariant, event: cstring, flagText: cstring, amount: number, schoolMask: number
```

### UnitConnection

Fires as `UNIT_CONNECTION`.

```lua
payload: unitTarget: UnitTokenVariant, isConnected: bool
```

### UnitCtrOptions

Fires as `UNIT_CTR_OPTIONS`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitDamage

Fires as `UNIT_DAMAGE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitDefense

Fires as `UNIT_DEFENSE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitDied

Fires as `UNIT_DIED`.

```lua
payload: unitGUID: WOWGUID
```

### UnitDisplaypower

Fires as `UNIT_DISPLAYPOWER`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitDistanceCheckUpdate

Fires as `UNIT_DISTANCE_CHECK_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant, isInDistance: bool
```

### UnitFaction

Fires as `UNIT_FACTION`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitFlags

Fires as `UNIT_FLAGS`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitFormChanged

Fires as `UNIT_FORM_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitHappiness

Fires as `UNIT_HAPPINESS`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitHealAbsorbAmountChanged

Fires as `UNIT_HEAL_ABSORB_AMOUNT_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitHealPrediction

Fires as `UNIT_HEAL_PREDICTION`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitHealth

Fires as `UNIT_HEALTH`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitInRangeUpdate

Fires as `UNIT_IN_RANGE_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant, isInRange: bool
```

### UnitInventoryChanged

Fires as `UNIT_INVENTORY_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitLevel

Fires as `UNIT_LEVEL`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitLoot

Fires as `UNIT_LOOT`.

```lua
payload: unitGUID: WOWGUID, hasLoot: bool
```

### UnitMana

Fires as `UNIT_MANA`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitMaxhealth

Fires as `UNIT_MAXHEALTH`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitMaxHealthModifiersChanged

Fires as `UNIT_MAX_HEALTH_MODIFIERS_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant, percentMaxHealthAdjusted: number
```

### UnitMaxpower

Fires as `UNIT_MAXPOWER`.

```lua
payload: unitTarget: UnitTokenVariant, powerType: cstring
```

### UnitModelChanged

Fires as `UNIT_MODEL_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitNameUpdate

Fires as `UNIT_NAME_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitOtherPartyChanged

Fires as `UNIT_OTHER_PARTY_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitPet

Fires as `UNIT_PET`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitPetExperience

Fires as `UNIT_PET_EXPERIENCE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitPetTrainingPoints

Fires as `UNIT_PET_TRAINING_POINTS`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitPhase

Fires as `UNIT_PHASE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitPortraitUpdate

Fires as `UNIT_PORTRAIT_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitPowerBarHide

Fires as `UNIT_POWER_BAR_HIDE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitPowerBarShow

Fires as `UNIT_POWER_BAR_SHOW`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitPowerBarTimerUpdate

Fires as `UNIT_POWER_BAR_TIMER_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitPowerFrequent

Fires as `UNIT_POWER_FREQUENT`.

```lua
payload: unitTarget: UnitTokenVariant, powerType: cstring
```

### UnitPowerPointCharge

Fires as `UNIT_POWER_POINT_CHARGE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitPowerUpdate

Fires as `UNIT_POWER_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant, powerType: cstring
```

### UnitQuestLogChanged

Fires as `UNIT_QUEST_LOG_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitRangedAttackPower

Fires as `UNIT_RANGED_ATTACK_POWER`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitRangeddamage

Fires as `UNIT_RANGEDDAMAGE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitResistances

Fires as `UNIT_RESISTANCES`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitSpellcastChannelStart

Fires as `UNIT_SPELLCAST_CHANNEL_START`.

```lua
payload: unitTarget: UnitTokenVariant, castGUID: WOWGUID, spellID: number, castBarID?: UnitCastBarID
```

### UnitSpellcastChannelStop

Fires as `UNIT_SPELLCAST_CHANNEL_STOP`.

```lua
payload: unitTarget: UnitTokenVariant, castGUID: WOWGUID, spellID: number, interruptedBy: WOWGUID, castBarID?: UnitCastBarID
```

### UnitSpellcastChannelUpdate

Fires as `UNIT_SPELLCAST_CHANNEL_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant, castGUID: WOWGUID, spellID: number, castBarID?: UnitCastBarID
```

### UnitSpellcastDelayed

Fires as `UNIT_SPELLCAST_DELAYED`.

```lua
payload: unitTarget: UnitTokenVariant, castGUID: WOWGUID, spellID: number, castBarID?: UnitCastBarID
```

### UnitSpellcastEmpowerStart

Fires as `UNIT_SPELLCAST_EMPOWER_START`.

```lua
payload: unitTarget: UnitTokenVariant, castGUID: WOWGUID, spellID: number, castBarID?: UnitCastBarID
```

### UnitSpellcastEmpowerStop

Fires as `UNIT_SPELLCAST_EMPOWER_STOP`.

```lua
payload: unitTarget: UnitTokenVariant, castGUID: WOWGUID, spellID: number, complete: bool, interruptedBy: WOWGUID, castBarID?: UnitCastBarID
```

### UnitSpellcastEmpowerUpdate

Fires as `UNIT_SPELLCAST_EMPOWER_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant, castGUID: WOWGUID, spellID: number, castBarID?: UnitCastBarID
```

### UnitSpellcastFailed

Fires as `UNIT_SPELLCAST_FAILED`.

```lua
payload: unitTarget: UnitTokenVariant, castGUID: WOWGUID, spellID: number, castBarID?: UnitCastBarID
```

### UnitSpellcastFailedQuiet

Fires as `UNIT_SPELLCAST_FAILED_QUIET`.

```lua
payload: unitTarget: UnitTokenVariant, castGUID: WOWGUID, spellID: number, castBarID?: UnitCastBarID
```

### UnitSpellcastInterrupted

Fires as `UNIT_SPELLCAST_INTERRUPTED`.

```lua
payload: unitTarget: UnitTokenVariant, castGUID: WOWGUID, spellID: number, interruptedBy: WOWGUID, castBarID?: UnitCastBarID
```

### UnitSpellcastInterruptible

Fires as `UNIT_SPELLCAST_INTERRUPTIBLE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitSpellcastNotInterruptible

Fires as `UNIT_SPELLCAST_NOT_INTERRUPTIBLE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitSpellcastReticleClear

Fires as `UNIT_SPELLCAST_RETICLE_CLEAR`.

```lua
payload: unitTarget: UnitTokenVariant, castGUID: WOWGUID, spellID: number
```

### UnitSpellcastReticleTarget

Fires as `UNIT_SPELLCAST_RETICLE_TARGET`.

```lua
payload: unitTarget: UnitTokenVariant, castGUID: WOWGUID, spellID: number
```

### UnitSpellcastSent

Fires as `UNIT_SPELLCAST_SENT`.

```lua
payload: unitTarget: UnitTokenVariant, target: cstring, castGUID: WOWGUID, spellID: number
```

### UnitSpellcastStart

Fires as `UNIT_SPELLCAST_START`.

```lua
payload: unitTarget: UnitTokenVariant, castGUID: WOWGUID, spellID: number, castBarID?: UnitCastBarID
```

### UnitSpellcastStop

Fires as `UNIT_SPELLCAST_STOP`.

```lua
payload: unitTarget: UnitTokenVariant, castGUID: WOWGUID, spellID: number, castBarID?: UnitCastBarID
```

### UnitSpellcastSucceeded

Fires as `UNIT_SPELLCAST_SUCCEEDED`.

```lua
payload: unitTarget: UnitTokenVariant, castGUID: WOWGUID, spellID: number, castBarID?: UnitCastBarID
```

### UnitSpellHaste

Fires as `UNIT_SPELL_HASTE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitStats

Fires as `UNIT_STATS`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitTarget

Fires as `UNIT_TARGET`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitTargetableChanged

Fires as `UNIT_TARGETABLE_CHANGED`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitThreatListUpdate

Fires as `UNIT_THREAT_LIST_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitThreatSituationUpdate

Fires as `UNIT_THREAT_SITUATION_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UpdateExhaustion

Fires as `UPDATE_EXHAUSTION`.

No payload.

### UpdateMouseoverUnit

Fires as `UPDATE_MOUSEOVER_UNIT`.

No payload.

### UpdateStealth

Fires as `UPDATE_STEALTH`.

No payload.

### VehicleAngleUpdate

Fires as `VEHICLE_ANGLE_UPDATE`.

```lua
payload: normalizedPitch: number, radians: number
```
