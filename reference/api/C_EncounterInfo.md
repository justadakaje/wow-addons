# C_EncounterInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`0` functions - `10` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Events

### BossKill

Fires as `BOSS_KILL`.

```lua
payload: encounterID: number, encounterName: cstring
```

### DisableLowLevelRaid

Fires as `DISABLE_LOW_LEVEL_RAID`.

No payload.

### EnableLowLevelRaid

Fires as `ENABLE_LOW_LEVEL_RAID`.

No payload.

### EncounterEnd

Fires as `ENCOUNTER_END`.

```lua
payload: encounterID: number, encounterName: cstring, difficultyID: number, groupSize: number, success: number, encounterUnitStatus: table
```

### EncounterStart

Fires as `ENCOUNTER_START`.

```lua
payload: encounterID: number, encounterName: cstring, difficultyID: number, groupSize: number
```

### InstanceLockStart

Fires as `INSTANCE_LOCK_START`.

No payload.

### InstanceLockStop

Fires as `INSTANCE_LOCK_STOP`.

No payload.

### InstanceLockWarning

Fires as `INSTANCE_LOCK_WARNING`.

No payload.

### RaidTargetUpdate

Fires as `RAID_TARGET_UPDATE`.

No payload.

### UpdateInstanceInfo

Fires as `UPDATE_INSTANCE_INFO`.

No payload.
