# C_HeirloomInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`8` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AreAllCollectionFiltersChecked

```lua
C_HeirloomInfo.AreAllCollectionFiltersChecked() -> areAllCollectionFiltersChecked: bool
```

### AreAllSourceFiltersChecked

```lua
C_HeirloomInfo.AreAllSourceFiltersChecked() -> areAllSourceFiltersChecked: bool
```

### HeirloomsAvailable

```lua
C_HeirloomInfo.HeirloomsAvailable() -> areHeirloomsAvailable: bool
```

### IsHeirloomSourceValid

```lua
C_HeirloomInfo.IsHeirloomSourceValid(source: luaIndex) -> isHeirloomSourceValid: bool
```

### IsUsingDefaultFilters

```lua
C_HeirloomInfo.IsUsingDefaultFilters() -> isUsingDefaultFilters: bool
```

### SetAllCollectionFilters

```lua
C_HeirloomInfo.SetAllCollectionFilters(checked: bool)
```

### SetAllSourceFilters

```lua
C_HeirloomInfo.SetAllSourceFilters(checked: bool)
```

### SetDefaultFilters

```lua
C_HeirloomInfo.SetDefaultFilters()
```

## Events

### HeirloomsUpdated

Fires as `HEIRLOOMS_UPDATED`.

```lua
payload: itemID?: number, updateReason?: cstring, hideUntilLearned?: bool
```

### HeirloomUpgradeTargetingChanged

Fires as `HEIRLOOM_UPGRADE_TARGETING_CHANGED`.

```lua
payload: pendingHeirloomUpgradeSpellcast: bool
```
