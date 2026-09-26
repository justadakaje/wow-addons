# PlayerScript

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`185` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AcceptAreaSpiritHeal

```lua
AcceptAreaSpiritHeal()
```

### AcceptGuild

```lua
AcceptGuild()
```

### AcceptResurrect

```lua
AcceptResurrect()
```

### Ambiguate

```lua
Ambiguate(fullName: cstring, context: cstring) -> result: string
```

### AutoEquipCursorItem

```lua
AutoEquipCursorItem()
```

### BeginTrade

```lua
BeginTrade()
```

### CancelAreaSpiritHeal

```lua
CancelAreaSpiritHeal()
```

### CancelPendingEquip

```lua
CancelPendingEquip(index: number)
```

### CancelTrade

```lua
CancelTrade()
```

### CanDualWield

```lua
CanDualWield() -> result: bool
```

### CanInspect

```lua
CanInspect(targetGUID: UnitToken) -> result: bool
```

### CanLootUnit

```lua
CanLootUnit(targetUnit: WOWGUID) -> hasLoot: bool, canLoot: bool
```

### CanPortGraveyard

```lua
CanPortGraveyard() -> canPortGraveyard: bool
```

### CheckInteractDistance

```lua
CheckInteractDistance(unitGUID: UnitToken, distIndex: luaIndex) -> result: bool
```

### CheckTalentMasterDist

```lua
CheckTalentMasterDist() -> result: bool
```

### ClearPendingBindConversionItem

```lua
ClearPendingBindConversionItem()
```

### ConfirmTalentWipe

```lua
ConfirmTalentWipe()
```

### ConvertItemToBindToAccount

```lua
ConvertItemToBindToAccount()
```

### DeclineGuild

```lua
DeclineGuild()
```

### DeclineResurrect

```lua
DeclineResurrect()
```

### Dismount

```lua
Dismount()
```

### EquipPendingItem

```lua
EquipPendingItem(index: number)
```

### FollowUnit

```lua
FollowUnit(name: cstring, exactMatch: bool)
```

### GetAllowLowLevelRaid

```lua
GetAllowLowLevelRaid() -> result: bool
```

### GetAllowRecentAlliesSeeLocation

```lua
GetAllowRecentAlliesSeeLocation() -> allowRecentAlliesSeeLocation: bool
```

### GetAreaSpiritHealerTime

```lua
GetAreaSpiritHealerTime() -> result: number
```

### GetArmorPenetration

```lua
GetArmorPenetration() -> result: number
```

### GetAttackPowerForStat

```lua
GetAttackPowerForStat(stat: luaIndex, value: number) -> result: number
```

### GetAutoDeclineGuildInvites

```lua
GetAutoDeclineGuildInvites() -> result: bool
```

### GetAutoDeclineNeighborhoodInvites

```lua
GetAutoDeclineNeighborhoodInvites() -> result: bool
```

### GetAvoidance

```lua
GetAvoidance() -> result: number
```

### GetBindLocation

```lua
GetBindLocation() -> result: cstring
```

### GetBlockChance

```lua
GetBlockChance() -> result: number
```

### GetCemeteryPreference

```lua
GetCemeteryPreference() -> result: number
```

### GetCollapsingStarCost

```lua
GetCollapsingStarCost() -> cost: number
```

### GetCombatRating

```lua
GetCombatRating(ratingIndex: luaIndex) -> result?: number
```

### GetCombatRatingBonus

```lua
GetCombatRatingBonus(ratingIndex: luaIndex) -> result?: number
```

### GetCombatRatingBonusForCombatRatingValue

```lua
GetCombatRatingBonusForCombatRatingValue(ratingIndex: luaIndex, value: number) -> result?: number
```

### GetCorpseRecoveryDelay

```lua
GetCorpseRecoveryDelay() -> result: number
```

### GetCorruption

```lua
GetCorruption() -> result: number
```

### GetCorruptionResistance

```lua
GetCorruptionResistance() -> result: number
```

### GetCritChance

```lua
GetCritChance() -> result: number
```

### GetCritChanceFromStat

```lua
GetCritChanceFromStat(stat: luaIndex, value: number) -> critChance: number
```

### GetCritChanceProvidesParryEffect

```lua
GetCritChanceProvidesParryEffect() -> result: bool
```

### GetDodgeChance

```lua
GetDodgeChance() -> result: number
```

### GetDodgeChanceFromAttribute

```lua
GetDodgeChanceFromAttribute() -> result: number
```

### GetEvictionTimeRemaining

```lua
GetEvictionTimeRemaining() -> result: number
```

### GetExpertise

```lua
GetExpertise() -> mainhandExpertise: number, offhandExpertise: number, rangedExpertise: number
```

### GetExpertisePercent

```lua
GetExpertisePercent() -> mainhandExpertisePercent: number, offhandExpertisePercent: number, rangedExpertisePercent: number
```

### GetHaste

```lua
GetHaste() -> result: number
```

### GetHealthRegen

```lua
GetHealthRegen() -> healthRegen: number, combatHealthRegen: number
```

### GetHealthRegenFromSpirit

```lua
GetHealthRegenFromSpirit() -> healthRegen: number, combatHealthRegen: number
```

### GetHitModifier

```lua
GetHitModifier() -> result: number
```

### GetJailersTowerLevel

```lua
GetJailersTowerLevel() -> result: number
```

### GetLifesteal

```lua
GetLifesteal() -> result: number
```

### GetLootSpecialization

```lua
GetLootSpecialization() -> specializationID: number
```

### GetManaRegen

```lua
GetManaRegen() -> baseManaRegen: number, castingManaRegen: number
```

### GetManaRegenFromSpirit

```lua
GetManaRegenFromSpirit() -> powerRegen: number, combatPowerRegen: number
```

### GetMastery

```lua
GetMastery() -> result: number
```

### GetMasteryEffect

```lua
GetMasteryEffect() -> masteryEffect: number, bonusCoefficient: number
```

### GetMaxPlayerLevel

```lua
GetMaxPlayerLevel() -> maxPlayerLevel: number
```

### GetMeleeHaste

```lua
GetMeleeHaste() -> result: number
```

### GetModResilienceDamageReduction

```lua
GetModResilienceDamageReduction() -> result: number
```

### GetMoney

```lua
GetMoney() -> result: number
```

### GetNormalizedRealmName

```lua
GetNormalizedRealmName() -> result: cstring
```

### GetOverrideAPBySpellPower

```lua
GetOverrideAPBySpellPower() -> result: number
```

### GetOverrideSpellPowerByAP

```lua
GetOverrideSpellPowerByAP() -> result: number
```

### GetParryChance

```lua
GetParryChance() -> result: number
```

### GetParryChanceFromAttribute

```lua
GetParryChanceFromAttribute() -> result: number
```

### GetPetHitChanceModifier

```lua
GetPetHitChanceModifier() -> result: number
```

### GetPetMeleeHaste

```lua
GetPetMeleeHaste() -> result: number
```

### GetPetSpellBonusDamage

```lua
GetPetSpellBonusDamage() -> result: number
```

### GetPetSpellHitChanceModifier

```lua
GetPetSpellHitChanceModifier() -> result: number
```

### GetPlayerFacing

```lua
GetPlayerFacing() -> result?: number
```

### GetPlayerInfoByGUID

```lua
GetPlayerInfoByGUID(guid: WOWGUID) -> localizedClass: cstring, englishClass: cstring, localizedRace: cstring, englishRace: cstring, sex: number, name: cstring, realmName: cstring, level?: number
```

### GetPowerRegen

```lua
GetPowerRegen() -> basePowerRegen: number, castingPowerRegen: number
```

### GetPowerRegenForPowerType

```lua
GetPowerRegenForPowerType(powerType: number) -> basePowerRegen: number, castingPowerRegen: number
```

### GetPVPDesired

```lua
GetPVPDesired() -> result: bool
```

### GetPVPGearStatRules

```lua
GetPVPGearStatRules() -> result: bool
```

### GetPVPLifetimeStats

```lua
GetPVPLifetimeStats() -> lifetimeHonorableKills: number, lifetimeMaxPVPRank: PvPRanks
```

### GetPvpPowerDamage

```lua
GetPvpPowerDamage() -> result: number
```

### GetPvpPowerHealing

```lua
GetPvpPowerHealing() -> result: number
```

### GetPVPSessionStats

```lua
GetPVPSessionStats() -> honorableKills: number, dishonorableKills: number
```

### GetPVPTimer

```lua
GetPVPTimer() -> result: number
```

### GetPVPYesterdayStats

```lua
GetPVPYesterdayStats() -> honorableKills: number, dishonorableKills: number
```

### GetRangedAttackPowerForStat

```lua
GetRangedAttackPowerForStat(stat: luaIndex, value: number) -> result: number
```

### GetRangedCritChance

```lua
GetRangedCritChance() -> result: number
```

### GetRangedHaste

```lua
GetRangedHaste() -> result: number, quiverHaste: number
```

### GetRangedHitModifier

```lua
GetRangedHitModifier() -> result: number
```

### GetReleaseTimeRemaining

```lua
GetReleaseTimeRemaining() -> result: number
```

### GetResSicknessDuration

```lua
GetResSicknessDuration() -> result?: string
```

### GetRestrictedAccountData

```lua
GetRestrictedAccountData() -> maxLevel: number, maxMoney: WOWMONEY, professionCap: number
```

### GetRestState

```lua
GetRestState() -> exhaustionID: number, name: cstring, factor: number
```

### GetRuneCooldown

```lua
GetRuneCooldown(runeIndex: luaIndex) -> startTime: number, duration: number, isRuneReady: bool
```

### GetRuneCount

```lua
GetRuneCount(runeIndex: luaIndex) -> result: number
```

### GetSheathState

```lua
GetSheathState() -> result?: number
```

### GetShieldBlock

```lua
GetShieldBlock() -> result: number
```

### GetSpeed

```lua
GetSpeed() -> result: number
```

### GetSpellBonusDamage

```lua
GetSpellBonusDamage(school: luaIndex) -> result?: number
```

### GetSpellBonusHealing

```lua
GetSpellBonusHealing() -> result: number
```

### GetSpellCritChance

```lua
GetSpellCritChance() -> result: number
```

### GetSpellCritChanceFromStat

```lua
GetSpellCritChanceFromStat(stat: luaIndex, value: number) -> spellCritChance: number
```

### GetSpellHitModifier

```lua
GetSpellHitModifier() -> result: number
```

### GetSpellPenetration

```lua
GetSpellPenetration() -> result: number
```

### GetSturdiness

```lua
GetSturdiness() -> result: number
```

### GetTaxiBenchmarkMode

```lua
GetTaxiBenchmarkMode() -> result: bool
```

### GetVersatilityBonus

```lua
GetVersatilityBonus(combatRating: luaIndex) -> result: number
```

### GetXPExhaustion

```lua
GetXPExhaustion() -> result?: number
```

### HasAPEffectsSpellPower

```lua
HasAPEffectsSpellPower() -> result: bool
```

### HasDualWieldPenalty

```lua
HasDualWieldPenalty() -> result: bool
```

### HasFullControl

```lua
HasFullControl() -> result: bool
```

### HasIgnoreDualWieldWeapon

```lua
HasIgnoreDualWieldWeapon() -> result: bool
```

### HasKey

```lua
HasKey() -> hasKey: bool
```

### HasNoReleaseAura

```lua
HasNoReleaseAura() -> hasCannotReleaseEffect: bool, longestDuration: number, hasUntilCancelledDuration: bool
```

### HasSPEffectsAttackPower

```lua
HasSPEffectsAttackPower() -> result: bool
```

### InitiateTrade

```lua
InitiateTrade(guid: UnitToken)
```

### IsAccountSecured

```lua
IsAccountSecured() -> result: bool
```

### IsAdvancedFlyableArea

```lua
IsAdvancedFlyableArea() -> result: bool
```

### IsCemeterySelectionAvailable

```lua
IsCemeterySelectionAvailable() -> result: bool
```

### IsCharacterNewlyBoosted

```lua
IsCharacterNewlyBoosted() -> newlyBoosted: bool
```

### IsDrivableArea

```lua
IsDrivableArea() -> result: bool
```

### IsDualWielding

```lua
IsDualWielding() -> result: bool
```

### IsFlyableArea

```lua
IsFlyableArea() -> result: bool
```

### IsGuildLeader

```lua
IsGuildLeader() -> result: bool
```

### IsIndoors

```lua
IsIndoors() -> result: bool
```

### IsInGuild

```lua
IsInGuild() -> result: bool
```

### IsInJailersTower

```lua
IsInJailersTower() -> result: bool
```

### IsInsane

```lua
IsInsane() -> result: bool
```

### IsItemPreferredArmorType

```lua
IsItemPreferredArmorType(itemLocation: ItemLocation) -> isItemPreferredArmorType: bool
```

### IsJailersTowerLayerTimeLocked

```lua
IsJailersTowerLayerTimeLocked(layerLevel: number) -> result: cstring
```

### IsLoggedIn

```lua
IsLoggedIn() -> result: bool
```

### IsMounted

```lua
IsMounted() -> result: bool
```

### IsOnGroundFloorInJailersTower

```lua
IsOnGroundFloorInJailersTower() -> result: bool
```

### IsOutdoors

```lua
IsOutdoors() -> result: bool
```

### IsOutOfBounds

```lua
IsOutOfBounds() -> result: bool
```

### IsPlayerInWorld

```lua
IsPlayerInWorld() -> result: bool
```

### IsPlayerMoving

```lua
IsPlayerMoving() -> result: bool
```

### IsPVPTimerRunning

```lua
IsPVPTimerRunning() -> result: bool
```

### IsRangedWeapon

```lua
IsRangedWeapon() -> result: bool
```

### IsResting

```lua
IsResting() -> result: bool
```

### IsRestrictedAccount

```lua
IsRestrictedAccount() -> result: bool
```

### IsStealthed

```lua
IsStealthed() -> result: bool
```

### IsXPUserDisabled

```lua
IsXPUserDisabled() -> result: bool
```

### NoPlayTime

```lua
NoPlayTime() -> result?: bool
```

### NotifyInspect

```lua
NotifyInspect(targetGUID: UnitToken)
```

### PartialPlayTime

```lua
PartialPlayTime() -> result?: bool
```

### PlayerCanTeleport

```lua
PlayerCanTeleport() -> result: bool
```

### PlayerEffectiveAttackPower

```lua
PlayerEffectiveAttackPower() -> mainHandAttackPower: number, offHandAttackPower: number, rangedAttackPower: number, baseAttackPower: number, baseRangedAttackPower: number
```

### PlayerGetTimerunningSeasonID

```lua
PlayerGetTimerunningSeasonID() -> timerunningSeasonID?: number
```

### PlayerIsInCombat

```lua
PlayerIsInCombat() -> playerIsInCombat: bool
```

### PlayerIsTimerunning

```lua
PlayerIsTimerunning() -> playerIsTimerunning: bool
```

### PortGraveyard

```lua
PortGraveyard()
```

### RandomRoll

```lua
RandomRoll(min: number, max: number)
```

### ReagentsFromBankAllowed

```lua
ReagentsFromBankAllowed() -> allowed: bool
```

### RepopMe

```lua
RepopMe()
```

### RequestTimePlayed

```lua
RequestTimePlayed()
```

### RespondInstanceLock

```lua
RespondInstanceLock(acceptLock: bool)
```

### ResurrectGetOfferer

```lua
ResurrectGetOfferer() -> name: cstring
```

### ResurrectHasSickness

```lua
ResurrectHasSickness() -> result: bool
```

### ResurrectHasTimer

```lua
ResurrectHasTimer() -> result: bool
```

### RetrieveCorpse

```lua
RetrieveCorpse()
```

### SetAllowLowLevelRaid

```lua
SetAllowLowLevelRaid(allow: bool)
```

### SetAllowRecentAlliesSeeLocation

```lua
SetAllowRecentAlliesSeeLocation(allowRecentAlliesSeeLocation: bool)
```

### SetAutoDeclineGuildInvites

```lua
SetAutoDeclineGuildInvites(allow: bool)
```

### SetAutoDeclineNeighborhoodInvites

```lua
SetAutoDeclineNeighborhoodInvites(allow: bool)
```

### SetCemeteryPreference

```lua
SetCemeteryPreference(cemetaryID: number)
```

### SetLootSpecialization

```lua
SetLootSpecialization(specializationID: number)
```

### SetTaxiBenchmarkMode

```lua
SetTaxiBenchmarkMode(enable: bool)
```

### ShouldDisplayRaidRolesInSocialFrame

```lua
ShouldDisplayRaidRolesInSocialFrame() -> result: bool
```

### ShouldDisplayStoryModeTooltipInSocialFrame

```lua
ShouldDisplayStoryModeTooltipInSocialFrame() -> result: bool
```

### ShouldShowIslandsWeeklyPOI

```lua
ShouldShowIslandsWeeklyPOI() -> result: bool
```

### ShouldShowSpecialSplashScreen

```lua
ShouldShowSpecialSplashScreen() -> result: bool
```

### ShowCloak

```lua
ShowCloak(show: bool)
```

### ShowHelm

```lua
ShowHelm(show: bool)
```

### ShowingCloak

```lua
ShowingCloak() -> result: bool
```

### ShowingHelm

```lua
ShowingHelm() -> result: bool
```

### SitStandOrDescendStart

```lua
SitStandOrDescendStart()
```

### SplashFrameCanBeShown

```lua
SplashFrameCanBeShown() -> result: bool
```

### StartAttack

```lua
StartAttack(name: cstring, exactMatch: bool)
```

### StopAttack

```lua
StopAttack()
```

### Stuck

```lua
Stuck()
```

### TimeoutResurrect

```lua
TimeoutResurrect()
```

### ToggleSelfHighlight

```lua
ToggleSelfHighlight() -> enabled: bool
```

### ToggleSheath

```lua
ToggleSheath()
```

### ToggleSit

```lua
ToggleSit()
```

## Events

### PlayerInCombatChanged

Fires as `PLAYER_IN_COMBAT_CHANGED`.

```lua
payload: inCombat: bool
```

### PlayerTargetDied

Fires as `PLAYER_TARGET_DIED`.

No payload.
