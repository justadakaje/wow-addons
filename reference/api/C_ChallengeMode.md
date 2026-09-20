# C_ChallengeMode

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`29` functions - `14` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanUseKeystoneInCurrentMap

```lua
C_ChallengeMode.CanUseKeystoneInCurrentMap(itemLocation: ItemLocation) -> canUse: bool
```

### ClearKeystone

```lua
C_ChallengeMode.ClearKeystone()
```

### CloseKeystoneFrame

```lua
C_ChallengeMode.CloseKeystoneFrame()
```

### GetActiveChallengeMapID

```lua
C_ChallengeMode.GetActiveChallengeMapID() -> mapChallengeModeID?: number
```

### GetActiveKeystoneInfo

```lua
C_ChallengeMode.GetActiveKeystoneInfo() -> activeKeystoneLevel: number, activeAffixIDs: table, wasActiveKeystoneCharged: bool
```

### GetAffixInfo

```lua
C_ChallengeMode.GetAffixInfo(affixID: number) -> name: cstring, description: cstring, filedataid: number
```

### GetChallengeCompletionInfo

```lua
C_ChallengeMode.GetChallengeCompletionInfo() -> info: ChallengeCompletionInfo
```

### GetDeathCount

```lua
C_ChallengeMode.GetDeathCount() -> numDeaths: number, timeLost: number
```

### GetDungeonScoreRarityColor

```lua
C_ChallengeMode.GetDungeonScoreRarityColor(dungeonScore: number) -> scoreColor: colorRGB
```

### GetGuildLeaders

```lua
C_ChallengeMode.GetGuildLeaders() -> topAttempt: table
```

### GetKeystoneLevelRarityColor

```lua
C_ChallengeMode.GetKeystoneLevelRarityColor(level: number) -> levelScore: colorRGB
```

### GetLeaverPenaltyWarningTimeLeft

```lua
C_ChallengeMode.GetLeaverPenaltyWarningTimeLeft() -> timeLeftSeconds: number
```

### GetMapScoreInfo

```lua
C_ChallengeMode.GetMapScoreInfo() -> displayScores: table
```

### GetMapTable

```lua
C_ChallengeMode.GetMapTable() -> mapChallengeModeIDs: table
```

### GetMapUIInfo

```lua
C_ChallengeMode.GetMapUIInfo(mapChallengeModeID: number) -> name: cstring, id: number, timeLimit: number, texture?: number, backgroundTexture: number, mapID: number
```

### GetOverallDungeonScore

```lua
C_ChallengeMode.GetOverallDungeonScore() -> overallDungeonScore: number
```

### GetPowerLevelDamageHealthMod

```lua
C_ChallengeMode.GetPowerLevelDamageHealthMod(powerLevel: number) -> damageMod: number, healthMod: number
```

### GetSlottedKeystoneInfo

```lua
C_ChallengeMode.GetSlottedKeystoneInfo() -> mapChallengeModeID: number, affixIDs: table, keystoneLevel: number
```

### GetSpecificDungeonOverallScoreRarityColor

```lua
C_ChallengeMode.GetSpecificDungeonOverallScoreRarityColor(specificDungeonOverallScore: number) -> specificDungeonOverallScoreColor: colorRGB
```

### GetSpecificDungeonScoreRarityColor

```lua
C_ChallengeMode.GetSpecificDungeonScoreRarityColor(specificDungeonScore: number) -> specificDungeonScoreColor: colorRGB
```

### GetStartTime

```lua
C_ChallengeMode.GetStartTime() -> startTime: number
```

### HasSlottedKeystone

```lua
C_ChallengeMode.HasSlottedKeystone() -> hasSlottedKeystone: bool
```

### IsChallengeModeActive

```lua
C_ChallengeMode.IsChallengeModeActive() -> challengeModeActive: bool
```

### IsChallengeModeResettable

```lua
C_ChallengeMode.IsChallengeModeResettable() -> canReset: bool
```

### RemoveKeystone

```lua
C_ChallengeMode.RemoveKeystone() -> removalSuccessful: bool
```

### RequestLeaders

```lua
C_ChallengeMode.RequestLeaders(mapChallengeModeID: number)
```

### Reset

```lua
C_ChallengeMode.Reset()
```

### SlotKeystone

```lua
C_ChallengeMode.SlotKeystone()
```

### StartChallengeMode

```lua
C_ChallengeMode.StartChallengeMode() -> success: bool
```

## Events

### ChallengeModeCompleted

Fires as `CHALLENGE_MODE_COMPLETED`.

No payload.

### ChallengeModeCompletedRewards

Fires as `CHALLENGE_MODE_COMPLETED_REWARDS`.

```lua
payload: mapID: number, medal: number, timeMS: number, money: number, rewards: table
```

### ChallengeModeDeathCountUpdated

Fires as `CHALLENGE_MODE_DEATH_COUNT_UPDATED`.

No payload.

### ChallengeModeKeystoneReceptableOpen

Fires as `CHALLENGE_MODE_KEYSTONE_RECEPTABLE_OPEN`.

No payload.

### ChallengeModeKeystoneSlotted

Fires as `CHALLENGE_MODE_KEYSTONE_SLOTTED`.

```lua
payload: keystoneID: number
```

### ChallengeModeLeaderboardResult

Fires as `CHALLENGE_MODE_LEADERBOARD_RESULT`.

```lua
payload: mapID: number, challengeModeID: number, page: number, results: table
```

### ChallengeModeLeadersUpdate

Fires as `CHALLENGE_MODE_LEADERS_UPDATE`.

No payload.

### ChallengeModeLeaverTimerEnded

Fires as `CHALLENGE_MODE_LEAVER_TIMER_ENDED`.

No payload.

### ChallengeModeLeaverTimerStarted

Fires as `CHALLENGE_MODE_LEAVER_TIMER_STARTED`.

No payload.

### ChallengeModeMapsUpdate

Fires as `CHALLENGE_MODE_MAPS_UPDATE`.

No payload.

### ChallengeModeMemberInfoUpdated

Fires as `CHALLENGE_MODE_MEMBER_INFO_UPDATED`.

No payload.

### ChallengeModeNewRecord

Fires as `CHALLENGE_MODE_NEW_RECORD`.

```lua
payload: mapID: number, timeMS: number, medal: number
```

### ChallengeModeReset

Fires as `CHALLENGE_MODE_RESET`.

```lua
payload: mapID: number
```

### ChallengeModeStart

Fires as `CHALLENGE_MODE_START`.

```lua
payload: mapID: number
```
