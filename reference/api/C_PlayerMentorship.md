# C_PlayerMentorship

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`5` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetMentorLevelRequirement

```lua
C_PlayerMentorship.GetMentorLevelRequirement() -> level?: number
```

### GetMentorRequirements

```lua
C_PlayerMentorship.GetMentorRequirements() -> achievementIDs: table, optionalAchievementIDs: table, optionalCompleteAtLeastCount: number
```

### GetMentorshipStatus

```lua
C_PlayerMentorship.GetMentorshipStatus(playerLocation: PlayerLocation) -> status: PlayerMentorshipStatus
```

### IsActivePlayerConsideredNewcomer

```lua
C_PlayerMentorship.IsActivePlayerConsideredNewcomer() -> isConsideredNewcomer: bool
```

### IsMentorRestricted

```lua
C_PlayerMentorship.IsMentorRestricted() -> isRestricted: bool
```

## Events

### MentorshipStatusChanged

Fires as `MENTORSHIP_STATUS_CHANGED`.

No payload.

### NewcomerGraduation

Fires as `NEWCOMER_GRADUATION`.

No payload.
