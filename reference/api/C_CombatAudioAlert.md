# C_CombatAudioAlert

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`16` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddToKnownTargetingList

```lua
C_CombatAudioAlert.AddToKnownTargetingList(unit: UnitToken) -> added: bool
```

### GetCategoryVoice

```lua
C_CombatAudioAlert.GetCategoryVoice(category: CombatAudioAlertCategory) -> voice: number
```

### GetCategoryVolume

```lua
C_CombatAudioAlert.GetCategoryVolume(category: CombatAudioAlertCategory) -> volume: number
```

### GetFormatSetting

```lua
C_CombatAudioAlert.GetFormatSetting(unit: CombatAudioAlertUnit, alertType: CombatAudioAlertType) -> formatVal: number
```

### GetSpeakerSpeed

```lua
C_CombatAudioAlert.GetSpeakerSpeed() -> speed: number
```

### GetSpecSetting

```lua
C_CombatAudioAlert.GetSpecSetting(setting: CombatAudioAlertSpecSetting) -> value: number
```

### GetThrottle

```lua
C_CombatAudioAlert.GetThrottle(throttleType: CombatAudioAlertThrottle) -> throttle: number
```

### IsEnabled

```lua
C_CombatAudioAlert.IsEnabled() -> isEnabled: bool
```

### RemoveFromKnownTargetingList

```lua
C_CombatAudioAlert.RemoveFromKnownTargetingList(unit: UnitToken) -> removed: bool
```

### SetCategoryVoice

```lua
C_CombatAudioAlert.SetCategoryVoice(category: CombatAudioAlertCategory, newVal: number) -> success: bool
```

### SetCategoryVolume

```lua
C_CombatAudioAlert.SetCategoryVolume(category: CombatAudioAlertCategory, newVal: number) -> success: bool
```

### SetFormatSetting

```lua
C_CombatAudioAlert.SetFormatSetting(unit: CombatAudioAlertUnit, alertType: CombatAudioAlertType, newVal: number) -> success: bool
```

### SetSpeakerSpeed

```lua
C_CombatAudioAlert.SetSpeakerSpeed(newVal: number) -> success: bool
```

### SetSpecSetting

```lua
C_CombatAudioAlert.SetSpecSetting(setting: CombatAudioAlertSpecSetting, newVal: number) -> success: bool
```

### SetThrottle

```lua
C_CombatAudioAlert.SetThrottle(throttleType: CombatAudioAlertThrottle, newVal: number) -> success: bool
```

### SpeakText

```lua
C_CombatAudioAlert.SpeakText(text: string, category: CombatAudioAlertCategory, allowOverlap: bool) -> utteranceID: number
```
