# C_MajorFactions

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`14` functions - `4` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetCurrentRenownLevel

```lua
C_MajorFactions.GetCurrentRenownLevel(majorFactionID: number) -> level: number
```

### GetMajorFactionData

```lua
C_MajorFactions.GetMajorFactionData(majorFactionID: number) -> data?: MajorFactionData
```

### GetMajorFactionIDs

```lua
C_MajorFactions.GetMajorFactionIDs(expansionID?: number) -> majorFactionIDs: table
```

### GetMajorFactionProgressionInfo

```lua
C_MajorFactions.GetMajorFactionProgressionInfo(majorFactionID: number) -> data?: MajorFactionProgressionInfo
```

### GetMajorFactionRenownInfo

```lua
C_MajorFactions.GetMajorFactionRenownInfo(majorFactionID: number) -> data?: MajorFactionRenownInfo
```

### GetRenownLevels

```lua
C_MajorFactions.GetRenownLevels(majorFactionID: number) -> levels: table
```

### GetRenownNPCFactionID

```lua
C_MajorFactions.GetRenownNPCFactionID() -> renownNPCFactionID: number
```

### GetRenownRewardsForLevel

```lua
C_MajorFactions.GetRenownRewardsForLevel(majorFactionID: number, renownLevel: number) -> rewards: table
```

### GetTotalReputationForRenownLevel

```lua
C_MajorFactions.GetTotalReputationForRenownLevel(majorFactionID: number, renownLevel: number) -> totalReputation: number
```

### HasMaximumRenown

```lua
C_MajorFactions.HasMaximumRenown(majorFactionID: number) -> hasMaxRenown: bool
```

### IsMajorFactionHiddenFromExpansionPage

```lua
C_MajorFactions.IsMajorFactionHiddenFromExpansionPage(majorFactionID: number) -> isHidden: bool
```

### IsWeeklyRenownCapped

```lua
C_MajorFactions.IsWeeklyRenownCapped(majorFactionID: number) -> isWeeklyCapped: bool
```

### ShouldDisplayMajorFactionAsJourney

```lua
C_MajorFactions.ShouldDisplayMajorFactionAsJourney(majorFactionID: number) -> shouldDisplayMajorFactionAsJourney: bool
```

### ShouldUseJourneyRewardTrack

```lua
C_MajorFactions.ShouldUseJourneyRewardTrack(majorFactionID: number) -> shouldUseJourneyRewardTrack: bool
```

## Events

### MajorFactionInteractionEnded

Fires as `MAJOR_FACTION_INTERACTION_ENDED`.

No payload.

### MajorFactionInteractionStarted

Fires as `MAJOR_FACTION_INTERACTION_STARTED`.

No payload.

### MajorFactionRenownLevelChanged

Fires as `MAJOR_FACTION_RENOWN_LEVEL_CHANGED`.

```lua
payload: majorFactionID: number, newRenownLevel: number, oldRenownLevel: number
```

### MajorFactionUnlocked

Fires as `MAJOR_FACTION_UNLOCKED`.

```lua
payload: majorFactionID: number
```
