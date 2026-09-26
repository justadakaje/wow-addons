# C_HousingCleanupMode

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`3` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetHoveredDecorInfo

```lua
C_HousingCleanupMode.GetHoveredDecorInfo() -> info?: HousingDecorInstanceInfo
```

### IsHoveringDecor

```lua
C_HousingCleanupMode.IsHoveringDecor() -> isHoveringDecor: bool
```

### RemoveSelectedDecor

```lua
C_HousingCleanupMode.RemoveSelectedDecor()
```

## Events

### HousingCleanupModeHoveredTargetChanged

Fires as `HOUSING_CLEANUP_MODE_HOVERED_TARGET_CHANGED`.

```lua
payload: hasHoveredTarget: bool, targetType: HousingCleanupModeTargetType
```

### HousingCleanupModeTargetSelected

Fires as `HOUSING_CLEANUP_MODE_TARGET_SELECTED`.

No payload.
