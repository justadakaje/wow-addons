# C_AchievementInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`6` functions - `11` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AreGuildAchievementsEnabled

```lua
C_AchievementInfo.AreGuildAchievementsEnabled() -> enabled: bool
```

### GetRewardItemID

```lua
C_AchievementInfo.GetRewardItemID(achievementID: number) -> rewardItemID?: number
```

### GetSupercedingAchievements

```lua
C_AchievementInfo.GetSupercedingAchievements(achievementID: number) -> supercedingAchievements: table
```

### IsGuildAchievement

```lua
C_AchievementInfo.IsGuildAchievement(achievementId: number) -> isGuild: bool
```

### IsValidAchievement

```lua
C_AchievementInfo.IsValidAchievement(achievementId: number) -> isValidAchievement: bool
```

### SetPortraitTexture

```lua
C_AchievementInfo.SetPortraitTexture(textureObject: SimpleTexture)
```

## Events

### AchievementEarned

Fires as `ACHIEVEMENT_EARNED`.

```lua
payload: achievementID: number, alreadyEarned?: bool
```

### AchievementPlayerName

Fires as `ACHIEVEMENT_PLAYER_NAME`.

```lua
payload: achievementID: number
```

### AchievementSearchUpdated

Fires as `ACHIEVEMENT_SEARCH_UPDATED`.

No payload.

### CriteriaComplete

Fires as `CRITERIA_COMPLETE`.

```lua
payload: criteriaID: number
```

### CriteriaEarned

Fires as `CRITERIA_EARNED`.

```lua
payload: achievementID: number, description: cstring, achievementAlreadyEarnedOnAccount: bool
```

### CriteriaUpdate

Fires as `CRITERIA_UPDATE`.

No payload.

### InspectAchievementReady

Fires as `INSPECT_ACHIEVEMENT_READY`.

```lua
payload: guid: WOWGUID
```

### ReceivedAchievementList

Fires as `RECEIVED_ACHIEVEMENT_LIST`.

No payload.

### ReceivedAchievementMemberList

Fires as `RECEIVED_ACHIEVEMENT_MEMBER_LIST`.

```lua
payload: achievementID: number
```

### TrackedAchievementListChanged

Fires as `TRACKED_ACHIEVEMENT_LIST_CHANGED`.

```lua
payload: achievementID?: number, added?: bool
```

### TrackedAchievementUpdate

Fires as `TRACKED_ACHIEVEMENT_UPDATE`.

```lua
payload: achievementID: number, criteriaID?: number, elapsed?: time_t, duration?: number
```
