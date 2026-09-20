# C_CombatText

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`3` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetActiveUnit

```lua
C_CombatText.GetActiveUnit() -> unitTarget: string
```

### GetCurrentEventInfo

```lua
C_CombatText.GetCurrentEventInfo()
```

### SetActiveUnit

```lua
C_CombatText.SetActiveUnit(unitToken: UnitToken)
```

## Events

### CombatTextUpdate

Fires as `COMBAT_TEXT_UPDATE`.

```lua
payload: combatTextType: cstring
```
