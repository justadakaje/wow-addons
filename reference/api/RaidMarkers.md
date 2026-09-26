# RaidMarkers

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`9` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanBeRaidTarget

```lua
CanBeRaidTarget(target: UnitToken) -> result: bool
```

### ClearRaidMarker

```lua
ClearRaidMarker(raidMarkerIndex: luaIndex)
```

### GetNextAvailableRaidTargetMarkerIndex

```lua
GetNextAvailableRaidTargetMarkerIndex(startIndex: luaIndex, reverseSearch: bool, wrapSearch: bool, treatDeadNonFriendlyAsAvailable: bool) -> nextAvailableRaidTargetMarkerIndex: luaIndex
```

### GetRaidTargetIndex

```lua
GetRaidTargetIndex(target: UnitToken) -> result?: luaIndex
```

### IsRaidMarkerActive

```lua
IsRaidMarkerActive(index: luaIndex) -> result: bool
```

### IsRaidMarkerSystemEnabled

```lua
IsRaidMarkerSystemEnabled() -> enabled: bool
```

### PlaceRaidMarker

```lua
PlaceRaidMarker(index: luaIndex, token?: cstring)
```

### RemoveRaidTargets

```lua
RemoveRaidTargets()
```

### SetRaidTarget

```lua
SetRaidTarget(target: UnitToken, userIndex: luaIndex)
```
