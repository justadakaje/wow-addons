# C_QuestSession

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`14` functions - `8` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanStart

```lua
C_QuestSession.CanStart() -> allowed: bool
```

### CanStop

```lua
C_QuestSession.CanStop() -> allowed: bool
```

### Exists

```lua
C_QuestSession.Exists() -> exists: bool
```

### GetAvailableSessionCommand

```lua
C_QuestSession.GetAvailableSessionCommand() -> command: QuestSessionCommand
```

### GetPendingCommand

```lua
C_QuestSession.GetPendingCommand() -> command: QuestSessionCommand
```

### GetProposedMaxLevelForSession

```lua
C_QuestSession.GetProposedMaxLevelForSession() -> proposedMaxLevel: number
```

### GetSessionBeginDetails

```lua
C_QuestSession.GetSessionBeginDetails() -> details?: QuestSessionPlayerDetails
```

### GetSuperTrackedQuest

```lua
C_QuestSession.GetSuperTrackedQuest() -> questID?: number
```

### HasJoined

```lua
C_QuestSession.HasJoined() -> hasJoined: bool
```

### HasPendingCommand

```lua
C_QuestSession.HasPendingCommand() -> hasPendingCommand: bool
```

### RequestSessionStart

```lua
C_QuestSession.RequestSessionStart()
```

### RequestSessionStop

```lua
C_QuestSession.RequestSessionStop()
```

### SendSessionBeginResponse

```lua
C_QuestSession.SendSessionBeginResponse(beginSession: bool)
```

### SetQuestIsSuperTracked

```lua
C_QuestSession.SetQuestIsSuperTracked(questID: number, superTrack: bool)
```

## Events

### QuestSessionCreated

Fires as `QUEST_SESSION_CREATED`.

No payload.

### QuestSessionDestroyed

Fires as `QUEST_SESSION_DESTROYED`.

No payload.

### QuestSessionEnabledStateChanged

Fires as `QUEST_SESSION_ENABLED_STATE_CHANGED`.

```lua
payload: enabled: bool
```

### QuestSessionJoined

Fires as `QUEST_SESSION_JOINED`.

No payload.

### QuestSessionLeft

Fires as `QUEST_SESSION_LEFT`.

No payload.

### QuestSessionMemberConfirm

Fires as `QUEST_SESSION_MEMBER_CONFIRM`.

No payload.

### QuestSessionMemberStartResponse

Fires as `QUEST_SESSION_MEMBER_START_RESPONSE`.

```lua
payload: guid: WOWGUID, response: bool
```

### QuestSessionNotification

Fires as `QUEST_SESSION_NOTIFICATION`.

```lua
payload: result: QuestSessionResult, guid: WOWGUID
```
