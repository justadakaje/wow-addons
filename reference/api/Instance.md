# Instance

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`18` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanChangePlayerDifficulty

```lua
CanChangePlayerDifficulty() -> canChange: bool, notOnCooldown: bool
```

### CanMapChangeDifficulty

```lua
CanMapChangeDifficulty(mapID?: number) -> canChange: bool
```

### CanShowResetInstances

```lua
CanShowResetInstances() -> result: bool
```

### GetBaseDifficultyID

```lua
GetBaseDifficultyID(difficultyID: number) -> baseDifficultyID: number
```

### GetDifficultyInfo

```lua
GetDifficultyInfo(difficultyID: number) -> name: cstring, instanceType: cstring, isHeroic: bool, isChallengeMode: bool, displayHeroic: bool, displayMythic: bool, toggleDifficultyID?: number, isLFR: bool, minPlayers?: number, maxPlayers?: number, isUserSelectable: bool
```

### GetDungeonDifficultyID

```lua
GetDungeonDifficultyID() -> result: number
```

### GetInstanceBootTimeRemaining

```lua
GetInstanceBootTimeRemaining() -> result: number
```

### GetInstanceInfo

```lua
GetInstanceInfo() -> name: cstring, instanceType: cstring, difficultyID: number, difficultyName: cstring, maxPlayers: number, dynamicDifficulty: number, isDynamic?: bool, instanceID: number, instanceGroupSize: number, lfgDungeonID?: number, hasWorldTier: bool
```

### GetInstanceLockTimeRemaining

```lua
GetInstanceLockTimeRemaining() -> timeLeft: number, extending: bool, encountersTotal: number, encountersCompleted: number
```

### GetInstanceLockTimeRemainingEncounter

```lua
GetInstanceLockTimeRemainingEncounter(encounterIndex: luaIndex) -> encounterName: cstring, texture: cstring, isKilled: bool, ineligible: bool
```

### GetLegacyRaidDifficultyID

```lua
GetLegacyRaidDifficultyID() -> result?: number
```

### GetRaidDifficultyID

```lua
GetRaidDifficultyID() -> result?: number
```

### IsInInstance

```lua
IsInInstance() -> isInInstance: bool, instanceType: cstring
```

### IsLegacyDifficulty

```lua
IsLegacyDifficulty(difficultyID: number) -> result?: bool
```

### ResetInstances

```lua
ResetInstances()
```

### SetDungeonDifficultyID

```lua
SetDungeonDifficultyID(difficultyID: number)
```

### SetLegacyRaidDifficultyID

```lua
SetLegacyRaidDifficultyID(difficultyID: number, force: bool)
```

### SetRaidDifficultyID

```lua
SetRaidDifficultyID(difficultyID: number, force: bool)
```
