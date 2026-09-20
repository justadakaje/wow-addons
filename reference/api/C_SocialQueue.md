# C_SocialQueue

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`10` functions - `3` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetAllGroups

```lua
C_SocialQueue.GetAllGroups(allowNonJoinable: bool, allowNonQueuedGroups: bool) -> groupGUIDs: table
```

### GetConfig

```lua
C_SocialQueue.GetConfig() -> config: SocialQueueConfig
```

### GetGroupForPlayer

```lua
C_SocialQueue.GetGroupForPlayer(playerGUID: WOWGUID) -> groupGUID: WOWGUID, isSoloQueueParty: bool
```

### GetGroupInfo

```lua
C_SocialQueue.GetGroupInfo(groupGUID: WOWGUID) -> canJoin: bool, numQueues: number, needTank: bool, needHealer: bool, needDamage: bool, isSoloQueueParty: bool, questSessionActive: bool, leaderGUID: WOWGUID
```

### GetGroupMembers

```lua
C_SocialQueue.GetGroupMembers(groupGUID: WOWGUID) -> groupMembers: table
```

### GetGroupQueues

```lua
C_SocialQueue.GetGroupQueues(groupGUID: WOWGUID) -> queues: table
```

### IsSystemEnabled

```lua
C_SocialQueue.IsSystemEnabled() -> isSystemEnabled: bool
```

### IsSystemSupported

```lua
C_SocialQueue.IsSystemSupported() -> isSystemSupported: bool
```

### RequestToJoin

```lua
C_SocialQueue.RequestToJoin(groupGUID: WOWGUID, applyAsTank: bool, applyAsHealer: bool, applyAsDamage: bool) -> requestSuccessful: bool
```

### SignalToastDisplayed

```lua
C_SocialQueue.SignalToastDisplayed(groupGUID: WOWGUID, priority: number)
```

## Events

### SocialQueueConfigUpdated

Fires as `SOCIAL_QUEUE_CONFIG_UPDATED`.

No payload.

### SocialQueueUpdate

Fires as `SOCIAL_QUEUE_UPDATE`.

```lua
payload: groupGUID: WOWGUID, numAddedItems?: number
```

### SocialUISocialQueueSystemStatusUpdated

Fires as `SOCIAL_UI_SOCIAL_QUEUE_SYSTEM_STATUS_UPDATED`.

No payload.
