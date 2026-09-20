# C_BlizzCon2026

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`4` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetExperience

```lua
C_BlizzCon2026.GetExperience() -> experience: Bc26Experience
```

### IsActive

```lua
C_BlizzCon2026.IsActive() -> isActive: bool
```

### IsColdSwapFeatureEnabled

```lua
C_BlizzCon2026.IsColdSwapFeatureEnabled() -> isEnabled: bool
```

### SetExperience

```lua
C_BlizzCon2026.SetExperience(experience: Bc26Experience)
```

## Events

### Bc26ColdSwapFeatureEnabledChanged

Fires as `BC_26_COLD_SWAP_FEATURE_ENABLED_CHANGED`.

```lua
payload: newEnabled: bool, oldEnabled: bool
```

### Bc26ExperienceChanged

Fires as `BC_26_EXPERIENCE_CHANGED`.

```lua
payload: newExperience: Bc26Experience, oldExperience: Bc26Experience
```
