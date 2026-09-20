# C_EncounterEvents

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`8` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetEventColor

```lua
C_EncounterEvents.GetEventColor(encounterEventID: number, trigger: EncounterEventColorTrigger) -> color?: colorRGBA
```

### GetEventInfo

```lua
C_EncounterEvents.GetEventInfo(encounterEventID: number) -> encounterEventInfo: EncounterEventInfo
```

### GetEventList

```lua
C_EncounterEvents.GetEventList() -> encounterEventIDs: table
```

### GetEventSound

```lua
C_EncounterEvents.GetEventSound(encounterEventID: number, trigger: EncounterEventSoundTrigger) -> sound: EncounterEventSoundInfo
```

### HasEventInfo

```lua
C_EncounterEvents.HasEventInfo(encounterEventID: number) -> exists: bool
```

### PlayEventSound

```lua
C_EncounterEvents.PlayEventSound(encounterEventID: number, trigger: EncounterEventSoundTrigger) -> handle: SoundHandle
```

### SetEventColor

```lua
C_EncounterEvents.SetEventColor(encounterEventID: number, trigger: EncounterEventColorTrigger, color?: colorRGBA)
```

### SetEventSound

```lua
C_EncounterEvents.SetEventSound(encounterEventID: number, trigger: EncounterEventSoundTrigger, sound?: EncounterEventSoundInfo)
```
