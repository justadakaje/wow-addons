# C_Reputation

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`27` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AreLegacyReputationsShown

```lua
C_Reputation.AreLegacyReputationsShown() -> areLegacyReputationsShown: bool
```

### CollapseAllFactionHeaders

```lua
C_Reputation.CollapseAllFactionHeaders()
```

### CollapseFactionHeader

```lua
C_Reputation.CollapseFactionHeader(factionSortIndex: luaIndex)
```

### ExpandAllFactionHeaders

```lua
C_Reputation.ExpandAllFactionHeaders()
```

### ExpandFactionHeader

```lua
C_Reputation.ExpandFactionHeader(factionSortIndex: luaIndex)
```

### GetFactionDataByID

```lua
C_Reputation.GetFactionDataByID(factionID: number) -> factionData?: FactionData
```

### GetFactionDataByIndex

```lua
C_Reputation.GetFactionDataByIndex(factionSortIndex: luaIndex) -> factionData?: FactionData
```

### GetFactionParagonInfo

```lua
C_Reputation.GetFactionParagonInfo(factionID: number) -> currentValue: number, threshold: number, rewardQuestID: number, hasRewardPending: bool, tooLowLevelForParagon: bool, paragonStorageLevel: number
```

### GetGuildFactionData

```lua
C_Reputation.GetGuildFactionData() -> guildFactionData?: FactionData
```

### GetGuildRepExpirationTime

```lua
C_Reputation.GetGuildRepExpirationTime() -> expirationTime?: number
```

### GetNumFactions

```lua
C_Reputation.GetNumFactions() -> numFactions: number
```

### GetReputationSortType

```lua
C_Reputation.GetReputationSortType() -> sortType: ReputationSortType
```

### GetSelectedFaction

```lua
C_Reputation.GetSelectedFaction() -> selectedFactionSortIndex: luaIndex
```

### GetWatchedFactionData

```lua
C_Reputation.GetWatchedFactionData() -> watchedFactionData?: FactionData
```

### IsAccountWideReputation

```lua
C_Reputation.IsAccountWideReputation(factionID: number) -> isAccountWide: bool
```

### IsFactionActive

```lua
C_Reputation.IsFactionActive(factionSortIndex: luaIndex) -> isActive: bool
```

### IsFactionParagon

```lua
C_Reputation.IsFactionParagon(factionID: number) -> factionIsParagon: bool
```

### IsFactionParagonForCurrentPlayer

```lua
C_Reputation.IsFactionParagonForCurrentPlayer(factionID: number) -> currentPlayerHasParagon: bool
```

### IsMajorFaction

```lua
C_Reputation.IsMajorFaction(factionID: number) -> isMajorFaction: bool
```

### RequestFactionParagonPreloadRewardData

```lua
C_Reputation.RequestFactionParagonPreloadRewardData(factionID: number)
```

### SetFactionActive

```lua
C_Reputation.SetFactionActive(factionSortIndex: luaIndex, setActive: bool)
```

### SetLegacyReputationsShown

```lua
C_Reputation.SetLegacyReputationsShown(showLegacyReputations: bool)
```

### SetReputationSortType

```lua
C_Reputation.SetReputationSortType(sortType: ReputationSortType)
```

### SetSelectedFaction

```lua
C_Reputation.SetSelectedFaction(factionSortIndex: luaIndex)
```

### SetWatchedFactionByID

```lua
C_Reputation.SetWatchedFactionByID(factionID: number)
```

### SetWatchedFactionByIndex

```lua
C_Reputation.SetWatchedFactionByIndex(factionSortIndex: luaIndex)
```

### ToggleFactionAtWar

```lua
C_Reputation.ToggleFactionAtWar(factionSortIndex: luaIndex)
```

## Events

### FactionStandingChanged

Fires as `FACTION_STANDING_CHANGED`.

```lua
payload: factionID: number, updatedStanding: number
```
