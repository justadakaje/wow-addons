# C_EncounterWarnings

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`10` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetColorForSeverity

```lua
C_EncounterWarnings.GetColorForSeverity(severity: EncounterEventSeverity) -> color: colorRGBA
```

### GetEditModeWarningInfo

```lua
C_EncounterWarnings.GetEditModeWarningInfo(severity: EncounterEventSeverity) -> warningInfo: EncounterWarningInfo
```

### GetPlayCustomSoundsWhenHidden

```lua
C_EncounterWarnings.GetPlayCustomSoundsWhenHidden() -> play: bool
```

### GetSoundKitForSeverity

```lua
C_EncounterWarnings.GetSoundKitForSeverity(severity: EncounterEventSeverity) -> soundKitID: number
```

### GetWarningsShown

```lua
C_EncounterWarnings.GetWarningsShown() -> shown: bool
```

### IsFeatureAvailable

```lua
C_EncounterWarnings.IsFeatureAvailable() -> isAvailable: bool
```

### IsFeatureEnabled

```lua
C_EncounterWarnings.IsFeatureEnabled() -> isAvailableAndEnabled: bool
```

### PlaySound

```lua
C_EncounterWarnings.PlaySound(severity: EncounterEventSeverity) -> soundHandle: number
```

### SetPlayCustomSoundsWhenHidden

```lua
C_EncounterWarnings.SetPlayCustomSoundsWhenHidden(play: bool)
```

### SetWarningsShown

```lua
C_EncounterWarnings.SetWarningsShown(shown: bool)
```

## Events

### EncounterWarning

Fires as `ENCOUNTER_WARNING`.

```lua
payload: encounterWarningInfo: EncounterWarningInfo
```
