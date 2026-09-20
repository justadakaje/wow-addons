# C_PlayerChoice

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`7` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetCurrentPlayerChoiceInfo

```lua
C_PlayerChoice.GetCurrentPlayerChoiceInfo() -> choiceInfo: PlayerChoiceInfo
```

### GetNumRerolls

```lua
C_PlayerChoice.GetNumRerolls() -> numRerolls: number
```

### GetRemainingTime

```lua
C_PlayerChoice.GetRemainingTime() -> remainingTime?: number
```

### IsWaitingForPlayerChoiceResponse

```lua
C_PlayerChoice.IsWaitingForPlayerChoiceResponse() -> isWaitingForResponse: bool
```

### OnUIClosed

```lua
C_PlayerChoice.OnUIClosed()
```

### RequestRerollPlayerChoice

```lua
C_PlayerChoice.RequestRerollPlayerChoice()
```

### SendPlayerChoiceResponse

```lua
C_PlayerChoice.SendPlayerChoiceResponse(responseID: number)
```

## Events

### PlayerChoiceClose

Fires as `PLAYER_CHOICE_CLOSE`.

No payload.

### PlayerChoiceUpdate

Fires as `PLAYER_CHOICE_UPDATE`.

No payload.
