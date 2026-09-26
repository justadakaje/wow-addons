# C_SpellDiminish

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`4` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetAllSpellDiminishCategories

```lua
C_SpellDiminish.GetAllSpellDiminishCategories(ruleset?: SpellDiminishRuleset) -> categories: table
```

### GetSpellDiminishCategoryInfo

```lua
C_SpellDiminish.GetSpellDiminishCategoryInfo(category: SpellDiminishCategory) -> categoryInfo?: SpellDiminishCategoryInfo
```

### IsSystemSupported

```lua
C_SpellDiminish.IsSystemSupported() -> isSystemSupported: bool
```

### ShouldTrackSpellDiminishCategory

```lua
C_SpellDiminish.ShouldTrackSpellDiminishCategory(category: SpellDiminishCategory, ruleset: SpellDiminishRuleset) -> isTracked: bool
```

## Events

### UnitSpellDiminishCategoryStateUpdated

Fires as `UNIT_SPELL_DIMINISH_CATEGORY_STATE_UPDATED`.

```lua
payload: unitTarget: UnitTokenVariant, trackerInfo: SpellDiminishTrackerInfo
```
