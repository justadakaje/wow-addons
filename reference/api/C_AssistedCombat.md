# C_AssistedCombat

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`4` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetActionSpell

```lua
C_AssistedCombat.GetActionSpell() -> spellID?: number
```

### GetNextCastSpell

```lua
C_AssistedCombat.GetNextCastSpell(checkForVisibleButton: bool) -> spellID?: number
```

### GetRotationSpells

```lua
C_AssistedCombat.GetRotationSpells() -> spellIDs: table
```

### IsAvailable

```lua
C_AssistedCombat.IsAvailable() -> isAvailable: bool, failureReason: string
```

## Events

### AssistedCombatActionSpellCast

Fires as `ASSISTED_COMBAT_ACTION_SPELL_CAST`.

No payload.
