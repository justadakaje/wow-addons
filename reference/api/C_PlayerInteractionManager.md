# C_PlayerInteractionManager

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`8` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearInteraction

```lua
C_PlayerInteractionManager.ClearInteraction(type?: PlayerInteractionType)
```

### ConfirmationInteraction

```lua
C_PlayerInteractionManager.ConfirmationInteraction(type?: PlayerInteractionType)
```

### InteractUnit

```lua
C_PlayerInteractionManager.InteractUnit(unit: string, exactMatch: bool, looseTargeting: bool) -> success: bool
```

### IsInteractingWithNpcOfType

```lua
C_PlayerInteractionManager.IsInteractingWithNpcOfType(type: PlayerInteractionType) -> interacting: bool
```

### IsReplacingUnit

```lua
C_PlayerInteractionManager.IsReplacingUnit() -> replacing: bool
```

### IsValidNPCInteraction

```lua
C_PlayerInteractionManager.IsValidNPCInteraction(type: PlayerInteractionType) -> isValidInteraction: bool
```

### ReopenInteraction

```lua
C_PlayerInteractionManager.ReopenInteraction()
```

### ShardTransferConfirm

```lua
C_PlayerInteractionManager.ShardTransferConfirm()
```

## Events

### PlayerInteractionManagerFrameHide

Fires as `PLAYER_INTERACTION_MANAGER_FRAME_HIDE`.

```lua
payload: type: PlayerInteractionType
```

### PlayerInteractionManagerFrameShow

Fires as `PLAYER_INTERACTION_MANAGER_FRAME_SHOW`.

```lua
payload: type: PlayerInteractionType
```
