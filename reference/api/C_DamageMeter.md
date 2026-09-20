# C_DamageMeter

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`8` functions - `3` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetAvailableCombatSessions

```lua
C_DamageMeter.GetAvailableCombatSessions() -> availableSessions: table
```

### GetCombatSessionFromID

```lua
C_DamageMeter.GetCombatSessionFromID(sessionID: number, type: DamageMeterType) -> session: DamageMeterCombatSession
```

### GetCombatSessionFromType

```lua
C_DamageMeter.GetCombatSessionFromType(sessionType: DamageMeterSessionType, type: DamageMeterType) -> session: DamageMeterCombatSession
```

### GetCombatSessionSourceFromID

```lua
C_DamageMeter.GetCombatSessionSourceFromID(sessionID: number, type: DamageMeterType, sourceGUID?: WOWGUID, sourceCreatureID?: number) -> sessionSource: DamageMeterCombatSessionSource
```

### GetCombatSessionSourceFromType

```lua
C_DamageMeter.GetCombatSessionSourceFromType(sessionType: DamageMeterSessionType, type: DamageMeterType, sourceGUID?: WOWGUID, sourceCreatureID?: number) -> sessionSource: DamageMeterCombatSessionSource
```

### GetSessionDurationSeconds

```lua
C_DamageMeter.GetSessionDurationSeconds(sessionType: DamageMeterSessionType) -> durationSeconds?: number
```

### IsDamageMeterAvailable

```lua
C_DamageMeter.IsDamageMeterAvailable() -> isAvailable: bool, failureReason: string
```

### ResetAllCombatSessions

```lua
C_DamageMeter.ResetAllCombatSessions()
```

## Events

### DamageMeterCombatSessionUpdated

Fires as `DAMAGE_METER_COMBAT_SESSION_UPDATED`.

```lua
payload: type: DamageMeterType, sessionID: number
```

### DamageMeterCurrentSessionUpdated

Fires as `DAMAGE_METER_CURRENT_SESSION_UPDATED`.

No payload.

### DamageMeterReset

Fires as `DAMAGE_METER_RESET`.

No payload.
