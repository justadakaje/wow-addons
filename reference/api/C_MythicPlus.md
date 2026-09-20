# C_MythicPlus

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`21` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetCurrentAffixes

```lua
C_MythicPlus.GetCurrentAffixes() -> affixIDs: table
```

### GetCurrentSeason

```lua
C_MythicPlus.GetCurrentSeason() -> seasonID: number
```

### GetCurrentSeasonValues

```lua
C_MythicPlus.GetCurrentSeasonValues() -> displaySeasonID: number, milestoneSeasonID: number, rewardSeasonID: number
```

### GetCurrentUIDisplaySeason

```lua
C_MythicPlus.GetCurrentUIDisplaySeason() -> seasonID?: number
```

### GetEndOfRunGearSequenceLevel

```lua
C_MythicPlus.GetEndOfRunGearSequenceLevel(keystoneLevel: number) -> sequenceLevel?: number
```

### GetLastWeeklyBestInformation

```lua
C_MythicPlus.GetLastWeeklyBestInformation() -> challengeMapId: number, level: number
```

### GetOwnedKeystoneChallengeMapID

```lua
C_MythicPlus.GetOwnedKeystoneChallengeMapID() -> challengeMapID: number
```

### GetOwnedKeystoneLevel

```lua
C_MythicPlus.GetOwnedKeystoneLevel() -> keyStoneLevel: number
```

### GetOwnedKeystoneMapID

```lua
C_MythicPlus.GetOwnedKeystoneMapID() -> mapID: number
```

### GetRewardLevelForDifficultyLevel

```lua
C_MythicPlus.GetRewardLevelForDifficultyLevel(difficultyLevel: number) -> weeklyRewardLevel: number, endOfRunRewardLevel: number
```

### GetRewardLevelFromKeystoneLevel

```lua
C_MythicPlus.GetRewardLevelFromKeystoneLevel(keystoneLevel: number) -> rewardLevel?: number
```

### GetRunHistory

```lua
C_MythicPlus.GetRunHistory(includePreviousWeeks: bool, includeIncompleteRuns: bool, currentSeasonOnly: bool) -> runs: table
```

### GetSeasonBestAffixScoreInfoForMap

```lua
C_MythicPlus.GetSeasonBestAffixScoreInfoForMap(mapChallengeModeID: number) -> affixScores: table, bestOverAllScore: number
```

### GetSeasonBestForMap

```lua
C_MythicPlus.GetSeasonBestForMap(mapChallengeModeID: number) -> intimeInfo?: MapSeasonBestInfo, overtimeInfo?: MapSeasonBestInfo
```

### GetSeasonBestMythicRatingFromThisExpansion

```lua
C_MythicPlus.GetSeasonBestMythicRatingFromThisExpansion() -> bestSeasonScore: number, bestSeason: number
```

### GetWeeklyBestForMap

```lua
C_MythicPlus.GetWeeklyBestForMap(mapChallengeModeID: number) -> durationSec: number, level: number, completionDate: CalendarTime, affixIDs: table, members: table, dungeonScore: number
```

### GetWeeklyChestRewardLevel

```lua
C_MythicPlus.GetWeeklyChestRewardLevel() -> currentWeekBestLevel: number, weeklyRewardLevel: number, nextDifficultyWeeklyRewardLevel: number, nextBestLevel: number
```

### IsMythicPlusActive

```lua
C_MythicPlus.IsMythicPlusActive() -> isMythicPlusActive: bool
```

### RequestCurrentAffixes

```lua
C_MythicPlus.RequestCurrentAffixes()
```

### RequestMapInfo

```lua
C_MythicPlus.RequestMapInfo()
```

### RequestRewards

```lua
C_MythicPlus.RequestRewards()
```

## Events

### MythicPlusCurrentAffixUpdate

Fires as `MYTHIC_PLUS_CURRENT_AFFIX_UPDATE`.

No payload.

### MythicPlusNewWeeklyRecord

Fires as `MYTHIC_PLUS_NEW_WEEKLY_RECORD`.

```lua
payload: mapChallengeModeID: number, completionMilliseconds: number, level: number
```
