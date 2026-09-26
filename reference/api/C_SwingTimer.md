# C_SwingTimer

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`2` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### EnableRangeCheck

```lua
C_SwingTimer.EnableRangeCheck(swingType: PlayerSwingType, enable: bool)
```

### IsTargetWithinSwingRange

```lua
C_SwingTimer.IsTargetWithinSwingRange(swingType: PlayerSwingType) -> isInRange?: bool
```

## Events

### PlayerSwing

Fires as `PLAYER_SWING`.

```lua
payload: swingDuration: number, swingType: PlayerSwingType
```

### PlayerSwingRangeUpdate

Fires as `PLAYER_SWING_RANGE_UPDATE`.

```lua
payload: swingType: PlayerSwingType, isInRange: bool, checksRange: bool
```
