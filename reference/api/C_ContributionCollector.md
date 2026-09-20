# C_ContributionCollector

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`18` functions - `4` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### Close

```lua
C_ContributionCollector.Close()
```

### Contribute

```lua
C_ContributionCollector.Contribute(contributionID: number)
```

### GetActive

```lua
C_ContributionCollector.GetActive() -> contributionID: number
```

### GetAtlases

```lua
C_ContributionCollector.GetAtlases(contributionID: number) -> atlasName: table
```

### GetBuffs

```lua
C_ContributionCollector.GetBuffs(contributionID: number) -> spellID: number
```

### GetContributionAppearance

```lua
C_ContributionCollector.GetContributionAppearance(contributionID: number, contributionState: ContributionState) -> appearance?: ContributionAppearance
```

### GetContributionCollectorsForMap

```lua
C_ContributionCollector.GetContributionCollectorsForMap(uiMapID: number) -> contributionCollectors: table
```

### GetContributionResult

```lua
C_ContributionCollector.GetContributionResult(contributionID: number) -> result: ContributionResult
```

### GetDescription

```lua
C_ContributionCollector.GetDescription(contributionID: number) -> description: cstring
```

### GetManagedContributionsForCreatureID

```lua
C_ContributionCollector.GetManagedContributionsForCreatureID(creatureID: number) -> contributionID: number
```

### GetName

```lua
C_ContributionCollector.GetName(contributionID: number) -> name: cstring
```

### GetOrderIndex

```lua
C_ContributionCollector.GetOrderIndex(contributionID: number) -> orderIndex: number
```

### GetRequiredContributionCurrency

```lua
C_ContributionCollector.GetRequiredContributionCurrency(contributionID: number) -> currencyID: number, currencyAmount: number
```

### GetRequiredContributionItem

```lua
C_ContributionCollector.GetRequiredContributionItem(contributionID: number) -> itemID: number, itemCount: number
```

### GetRewardQuestID

```lua
C_ContributionCollector.GetRewardQuestID(contributionID: number) -> questID: number
```

### GetState

```lua
C_ContributionCollector.GetState(contributionID: number) -> contributionState: ContributionState, contributionPercentageComplete: number, timeOfNextStateChange?: time_t, startTime: time_t
```

### HasPendingContribution

```lua
C_ContributionCollector.HasPendingContribution(contributionID: number) -> hasPending: bool
```

### IsAwaitingRewardQuestData

```lua
C_ContributionCollector.IsAwaitingRewardQuestData(contributionID: number) -> awaitingData: bool
```

## Events

### ContributionChanged

Fires as `CONTRIBUTION_CHANGED`.

```lua
payload: state: ContributionState, result: ContributionResult, name: string, contributionID: number
```

### ContributionCollectorPending

Fires as `CONTRIBUTION_COLLECTOR_PENDING`.

```lua
payload: contributionID: number, isPending: bool, result: number
```

### ContributionCollectorUpdate

Fires as `CONTRIBUTION_COLLECTOR_UPDATE`.

No payload.

### ContributionCollectorUpdateSingle

Fires as `CONTRIBUTION_COLLECTOR_UPDATE_SINGLE`.

```lua
payload: contributionID: number
```
