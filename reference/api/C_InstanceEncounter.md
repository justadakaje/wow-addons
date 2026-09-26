# C_InstanceEncounter

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`4` functions - `6` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### IsEncounterInProgress

```lua
C_InstanceEncounter.IsEncounterInProgress() -> isInProgress: bool
```

### IsEncounterLimitingResurrections

```lua
C_InstanceEncounter.IsEncounterLimitingResurrections() -> isLimitingResurrections: bool
```

### IsEncounterSuppressingRelease

```lua
C_InstanceEncounter.IsEncounterSuppressingRelease() -> isSuppressingRelease: bool
```

### ShouldShowTimelineForEncounter

```lua
C_InstanceEncounter.ShouldShowTimelineForEncounter() -> shouldShow: bool
```

## Events

### EncounterStateChanged

Fires as `ENCOUNTER_STATE_CHANGED`.

```lua
payload: isInProgress: bool
```

### InstanceEncounterAddTimer

Fires as `INSTANCE_ENCOUNTER_ADD_TIMER`.

```lua
payload: timeRemaining: number
```

### InstanceEncounterEngageUnit

Fires as `INSTANCE_ENCOUNTER_ENGAGE_UNIT`.

No payload.

### InstanceEncounterObjectiveComplete

Fires as `INSTANCE_ENCOUNTER_OBJECTIVE_COMPLETE`.

```lua
payload: objectiveID: number
```

### InstanceEncounterObjectiveStart

Fires as `INSTANCE_ENCOUNTER_OBJECTIVE_START`.

```lua
payload: objectiveID: number, objectiveProgress: number
```

### InstanceEncounterObjectiveUpdate

Fires as `INSTANCE_ENCOUNTER_OBJECTIVE_UPDATE`.

```lua
payload: objectiveID: number, objectiveProgress: number
```
