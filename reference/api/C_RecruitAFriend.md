# C_RecruitAFriend

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`16` functions - `5` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanSummonFriend

```lua
C_RecruitAFriend.CanSummonFriend(guid: WOWGUID) -> canSummon: bool, reason: RecruitAFriendFailure
```

### ClaimActivityReward

```lua
C_RecruitAFriend.ClaimActivityReward(activityID: number, acceptanceID: RecruitAcceptanceID) -> success: bool
```

### ClaimNextReward

```lua
C_RecruitAFriend.ClaimNextReward(rafVersion?: RecruitAFriendRewardsVersion) -> success: bool
```

### GenerateRecruitmentLink

```lua
C_RecruitAFriend.GenerateRecruitmentLink() -> success: bool
```

### GetRAFInfo

```lua
C_RecruitAFriend.GetRAFInfo() -> info: RafInfo
```

### GetRAFSystemInfo

```lua
C_RecruitAFriend.GetRAFSystemInfo() -> systemInfo: RafSystemInfo
```

### GetRecruitActivityRequirementsText

```lua
C_RecruitAFriend.GetRecruitActivityRequirementsText(activityID: number, acceptanceID: RecruitAcceptanceID) -> requirementsText: table
```

### GetRecruitInfo

```lua
C_RecruitAFriend.GetRecruitInfo() -> active: bool, faction: number
```

### GetSummonFriendCooldown

```lua
C_RecruitAFriend.GetSummonFriendCooldown() -> startTimeSeconds: number, durationSeconds: number, enableCooldownTimer: bool
```

### IsRecruitAFriendLinked

```lua
C_RecruitAFriend.IsRecruitAFriendLinked(guid: WOWGUID) -> result: bool
```

### IsRecruitingEnabled

```lua
C_RecruitAFriend.IsRecruitingEnabled() -> enabled: bool
```

### IsSystemEnabled

```lua
C_RecruitAFriend.IsSystemEnabled() -> isSystemEnabled: bool
```

### IsSystemSupported

```lua
C_RecruitAFriend.IsSystemSupported() -> isSystemSupported: bool
```

### RemoveRAFRecruit

```lua
C_RecruitAFriend.RemoveRAFRecruit(wowAccountGUID: WOWGUID) -> success: bool
```

### RequestUpdatedRecruitmentInfo

```lua
C_RecruitAFriend.RequestUpdatedRecruitmentInfo() -> success: bool
```

### SummonFriend

```lua
C_RecruitAFriend.SummonFriend(target: WOWGUID, name: cstring)
```

## Events

### RafInfoUpdated

Fires as `RAF_INFO_UPDATED`.

```lua
payload: info: RafInfo
```

### RafRecruitingEnabledStatus

Fires as `RAF_RECRUITING_ENABLED_STATUS`.

```lua
payload: enabled: bool
```

### RafRewardClaimFailed

Fires as `RAF_REWARD_CLAIM_FAILED`.

No payload.

### RafSystemEnabledStatus

Fires as `RAF_SYSTEM_ENABLED_STATUS`.

```lua
payload: enabled: bool
```

### RafSystemInfoUpdated

Fires as `RAF_SYSTEM_INFO_UPDATED`.

```lua
payload: systemInfo: RafSystemInfo
```
