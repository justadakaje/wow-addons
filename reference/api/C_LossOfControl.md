# C_LossOfControl

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`5` functions - `6` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetActiveLossOfControlData

```lua
C_LossOfControl.GetActiveLossOfControlData(index: luaIndex) -> event?: LossOfControlData
```

### GetActiveLossOfControlDataByUnit

```lua
C_LossOfControl.GetActiveLossOfControlDataByUnit(unitToken: UnitToken, index: luaIndex) -> event?: LossOfControlData
```

### GetActiveLossOfControlDataCount

```lua
C_LossOfControl.GetActiveLossOfControlDataCount() -> count: number
```

### GetActiveLossOfControlDataCountByUnit

```lua
C_LossOfControl.GetActiveLossOfControlDataCountByUnit(unitToken: UnitToken) -> count: number
```

### GetActiveLossOfControlDuration

```lua
C_LossOfControl.GetActiveLossOfControlDuration(unitToken: UnitToken, index: luaIndex) -> duration?: LuaDurationObject
```

## Events

### LossOfControlAdded

Fires as `LOSS_OF_CONTROL_ADDED`.

```lua
payload: unitTarget: UnitTokenVariant, effectIndex: luaIndex
```

### LossOfControlCommentatorAdded

Fires as `LOSS_OF_CONTROL_COMMENTATOR_ADDED`.

```lua
payload: victim: WOWGUID, effectIndex: luaIndex
```

### LossOfControlCommentatorUpdate

Fires as `LOSS_OF_CONTROL_COMMENTATOR_UPDATE`.

```lua
payload: victim: WOWGUID
```

### LossOfControlUpdate

Fires as `LOSS_OF_CONTROL_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### PlayerControlGained

Fires as `PLAYER_CONTROL_GAINED`.

No payload.

### PlayerControlLost

Fires as `PLAYER_CONTROL_LOST`.

No payload.
