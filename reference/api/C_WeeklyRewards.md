# C_WeeklyRewards

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`21` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AreRewardsForCurrentRewardPeriod

```lua
C_WeeklyRewards.AreRewardsForCurrentRewardPeriod() -> isCurrentPeriod: bool
```

### CanClaimRewards

```lua
C_WeeklyRewards.CanClaimRewards() -> canClaimRewards: bool
```

### ClaimReward

```lua
C_WeeklyRewards.ClaimReward(id: number)
```

### CloseInteraction

```lua
C_WeeklyRewards.CloseInteraction()
```

### GetActivities

```lua
C_WeeklyRewards.GetActivities(type?: WeeklyRewardChestThresholdType) -> activities: table
```

### GetActivityEncounterInfo

```lua
C_WeeklyRewards.GetActivityEncounterInfo(type: WeeklyRewardChestThresholdType, index: luaIndex) -> info: table
```

### GetConquestWeeklyProgress

```lua
C_WeeklyRewards.GetConquestWeeklyProgress() -> weeklyProgress: ConquestWeeklyProgress
```

### GetDifficultyIDForActivityTier

```lua
C_WeeklyRewards.GetDifficultyIDForActivityTier(activityTierID: number) -> difficultyID: number
```

### GetExampleRewardItemHyperlinks

```lua
C_WeeklyRewards.GetExampleRewardItemHyperlinks(id: number) -> hyperlink: string, upgradeHyperlink: string
```

### GetItemHyperlink

```lua
C_WeeklyRewards.GetItemHyperlink(itemDBID: WeeklyRewardItemDBID) -> hyperlink: cstring
```

### GetNextActivitiesIncrease

```lua
C_WeeklyRewards.GetNextActivitiesIncrease(activityTierID: number, level: number) -> hasSeasonData: bool, nextActivityTierID?: number, nextLevel?: number, itemLevel?: number
```

### GetNextMythicPlusIncrease

```lua
C_WeeklyRewards.GetNextMythicPlusIncrease(mythicPlusLevel: number) -> hasSeasonData: bool, nextMythicPlusLevel?: number, itemLevel?: number
```

### GetNumCompletedDungeonRuns

```lua
C_WeeklyRewards.GetNumCompletedDungeonRuns() -> numHeroic: number, numMythic: number, numMythicPlus: number
```

### GetSortedProgressForActivity

```lua
C_WeeklyRewards.GetSortedProgressForActivity(type: WeeklyRewardChestThresholdType, combineSharedDifficulty: bool) -> progress: table
```

### HasAvailableRewards

```lua
C_WeeklyRewards.HasAvailableRewards() -> hasAvailableRewards: bool
```

### HasGeneratedRewards

```lua
C_WeeklyRewards.HasGeneratedRewards() -> hasGeneratedRewards: bool
```

### HasInteraction

```lua
C_WeeklyRewards.HasInteraction() -> isInteracting: bool
```

### IsWeeklyChestRetired

```lua
C_WeeklyRewards.IsWeeklyChestRetired() -> isRetired: bool
```

### OnUIInteract

```lua
C_WeeklyRewards.OnUIInteract()
```

### ShouldShowFinalRetirementMessage

```lua
C_WeeklyRewards.ShouldShowFinalRetirementMessage() -> showRetirementMessage: bool
```

### ShouldShowRetirementMessage

```lua
C_WeeklyRewards.ShouldShowRetirementMessage() -> showRetirementMessage: bool
```

## Events

### WeeklyRewardsItemChanged

Fires as `WEEKLY_REWARDS_ITEM_CHANGED`.

No payload.

### WeeklyRewardsUpdate

Fires as `WEEKLY_REWARDS_UPDATE`.

No payload.
