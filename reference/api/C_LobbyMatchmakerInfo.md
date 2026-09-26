# C_LobbyMatchmakerInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`8` functions - `5` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AbandonQueue

```lua
C_LobbyMatchmakerInfo.AbandonQueue()
```

### EnterQueue

```lua
C_LobbyMatchmakerInfo.EnterQueue(playlistEntry: PartyPlaylistEntry)
```

### GetCurrQueuePlaylistEntry

```lua
C_LobbyMatchmakerInfo.GetCurrQueuePlaylistEntry() -> playlistEntry: PartyPlaylistEntry
```

### GetCurrQueueState

```lua
C_LobbyMatchmakerInfo.GetCurrQueueState() -> queueState: PlunderstormQueueState
```

### GetQueueFromMainlineEnabled

```lua
C_LobbyMatchmakerInfo.GetQueueFromMainlineEnabled() -> queueFromMainlineEnabled: bool
```

### GetQueueStartTime

```lua
C_LobbyMatchmakerInfo.GetQueueStartTime() -> queueStartTime: number
```

### IsInQueue

```lua
C_LobbyMatchmakerInfo.IsInQueue() -> isInQueue: bool
```

### RespondToQueuePop

```lua
C_LobbyMatchmakerInfo.RespondToQueuePop(acceptQueue: bool)
```

## Events

### LobbyMatchmakerQueueAbandoned

Fires as `LOBBY_MATCHMAKER_QUEUE_ABANDONED`.

No payload.

### LobbyMatchmakerQueueError

Fires as `LOBBY_MATCHMAKER_QUEUE_ERROR`.

No payload.

### LobbyMatchmakerQueueExpired

Fires as `LOBBY_MATCHMAKER_QUEUE_EXPIRED`.

No payload.

### LobbyMatchmakerQueuePopped

Fires as `LOBBY_MATCHMAKER_QUEUE_POPPED`.

No payload.

### LobbyMatchmakerQueueStatusUpdate

Fires as `LOBBY_MATCHMAKER_QUEUE_STATUS_UPDATE`.

No payload.
