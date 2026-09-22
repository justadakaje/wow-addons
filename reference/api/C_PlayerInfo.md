# C_PlayerInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`40` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanPlayerEnterChromieTime

```lua
C_PlayerInfo.CanPlayerEnterChromieTime() -> canEnter: bool
```

### CanPlayerUseAreaLoot

```lua
C_PlayerInfo.CanPlayerUseAreaLoot() -> canUseAreaLoot: bool
```

### CanPlayerUseMountEquipment

```lua
C_PlayerInfo.CanPlayerUseMountEquipment() -> canUseMountEquipment: bool, failureReason: string
```

### CanUseItem

```lua
C_PlayerInfo.CanUseItem(itemID: number) -> isUseable: bool
```

### GetAlternateFormInfo

```lua
C_PlayerInfo.GetAlternateFormInfo() -> hasAlternateForm: bool, inAlternateForm: bool
```

### GetClass

```lua
C_PlayerInfo.GetClass(playerLocation: PlayerLocation) -> className?: cstring, classFilename?: cstring, classID?: number
```

### GetContentDifficultyCreatureForPlayer

```lua
C_PlayerInfo.GetContentDifficultyCreatureForPlayer(unitToken: UnitToken) -> difficulty: RelativeContentDifficulty
```

### GetContentDifficultyQuestForPlayer

```lua
C_PlayerInfo.GetContentDifficultyQuestForPlayer(questID: number) -> difficulty: RelativeContentDifficulty
```

### GetDisplayID

```lua
C_PlayerInfo.GetDisplayID() -> displayID: number
```

### GetGlidingInfo

```lua
C_PlayerInfo.GetGlidingInfo() -> isGliding: bool, canGlide: bool, forwardSpeed: number
```

### GetInstancesUnlockedAtLevel

```lua
C_PlayerInfo.GetInstancesUnlockedAtLevel(level: number, isRaid: bool) -> dungeonID: table
```

### GetName

```lua
C_PlayerInfo.GetName(playerLocation: PlayerLocation) -> name?: string
```

### GetNativeDisplayID

```lua
C_PlayerInfo.GetNativeDisplayID() -> nativeDisplayID: number
```

### GetPetStableCreatureDisplayInfoID

```lua
C_PlayerInfo.GetPetStableCreatureDisplayInfoID(index: number) -> creatureDisplayInfoID: number
```

### GetPlayerCharacterData

```lua
C_PlayerInfo.GetPlayerCharacterData() -> characterData: PlayerInfoCharacterData
```

### GetPlayerMythicPlusRatingSummary

```lua
C_PlayerInfo.GetPlayerMythicPlusRatingSummary(playerToken: UnitToken) -> ratingSummary: MythicPlusRatingSummary
```

### GetRace

```lua
C_PlayerInfo.GetRace(playerLocation: PlayerLocation) -> raceID?: number
```

### GetSex

```lua
C_PlayerInfo.GetSex(playerLocation: PlayerLocation) -> sex?: UnitSex
```

### GUIDIsPlayer

```lua
C_PlayerInfo.GUIDIsPlayer(guid: WOWGUID) -> isPlayer: bool
```

### HasAccountInventoryLock

```lua
C_PlayerInfo.HasAccountInventoryLock() -> hasAccountInventoryLock: bool
```

### HasVisibleInvSlot

```lua
C_PlayerInfo.HasVisibleInvSlot(slot: luaIndex) -> isVisible: bool
```

### IsAccountBankEnabled

```lua
C_PlayerInfo.IsAccountBankEnabled() -> isAccountBankEnabled: bool
```

### IsCharacterBankEnabled

```lua
C_PlayerInfo.IsCharacterBankEnabled() -> isCharacterBankEnabled: bool
```

### IsConnected

```lua
C_PlayerInfo.IsConnected(playerLocation?: PlayerLocation) -> isConnected?: bool
```

### IsDisplayRaceNative

```lua
C_PlayerInfo.IsDisplayRaceNative() -> isDisplayRaceNative: bool
```

### IsExpansionLandingPageUnlockedForPlayer

```lua
C_PlayerInfo.IsExpansionLandingPageUnlockedForPlayer(expansionID: number) -> isUnlocked: bool
```

### IsMirrorImage

```lua
C_PlayerInfo.IsMirrorImage() -> isMirrorImage: bool
```

### IsPlayerEligibleForNPE

```lua
C_PlayerInfo.IsPlayerEligibleForNPE() -> isEligible: bool, failureReason: string
```

### IsPlayerEligibleForNPEv2

```lua
C_PlayerInfo.IsPlayerEligibleForNPEv2() -> isEligible: bool, failureReason: string
```

### IsPlayerInChromieTime

```lua
C_PlayerInfo.IsPlayerInChromieTime() -> inChromieTime: bool
```

### IsPlayerInRPE

```lua
C_PlayerInfo.IsPlayerInRPE() -> isInRPE: bool
```

### IsPlayerInTimerunningHeroicWorldTier

```lua
C_PlayerInfo.IsPlayerInTimerunningHeroicWorldTier() -> inTimerunningHeroicWorldTier: bool
```

### IsPlayerNPERestricted

```lua
C_PlayerInfo.IsPlayerNPERestricted() -> isRestricted: bool
```

### IsReturningCharacter

```lua
C_PlayerInfo.IsReturningCharacter() -> isReturning: bool
```

### IsSelfFoundActive

```lua
C_PlayerInfo.IsSelfFoundActive() -> active: bool
```

### IsTradingPostAvailable

```lua
C_PlayerInfo.IsTradingPostAvailable() -> isAvailable: bool
```

### IsTravelersLogAvailable

```lua
C_PlayerInfo.IsTravelersLogAvailable() -> isAvailable: bool
```

### IsTutorialsTabAvailable

```lua
C_PlayerInfo.IsTutorialsTabAvailable() -> isAvailable: bool
```

### ShouldDisplaySurname

```lua
C_PlayerInfo.ShouldDisplaySurname() -> display: bool
```

### UnitIsSameServer

```lua
C_PlayerInfo.UnitIsSameServer(playerLocation: PlayerLocation) -> unitIsSameServer: bool
```
