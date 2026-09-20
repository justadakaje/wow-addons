# C_CombatLog

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`11` functions - `4` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ApplyFilterSettings

```lua
C_CombatLog.ApplyFilterSettings(filterSettings: LuaValueVariant)
```

### AreFilteredEventsEnabled

```lua
C_CombatLog.AreFilteredEventsEnabled() -> enabled: bool
```

### ClearEntries

```lua
C_CombatLog.ClearEntries()
```

### DoesObjectMatchFilter

```lua
C_CombatLog.DoesObjectMatchFilter(mask: CombatLogObject, flags: CombatLogObject) -> matches: bool
```

### GetEntryRetentionTime

```lua
C_CombatLog.GetEntryRetentionTime() -> retentionTime: number
```

### GetMessageLimit

```lua
C_CombatLog.GetMessageLimit() -> messageLimit: number
```

### IsCombatLogRestricted

```lua
C_CombatLog.IsCombatLogRestricted() -> restricted: bool
```

### RefilterEntries

```lua
C_CombatLog.RefilterEntries()
```

### SetEntryRetentionTime

```lua
C_CombatLog.SetEntryRetentionTime(retentionTime: number)
```

### SetFilteredEventsEnabled

```lua
C_CombatLog.SetFilteredEventsEnabled(enabled: bool)
```

### SetMessageLimit

```lua
C_CombatLog.SetMessageLimit(messageLimit: number)
```

## Events

### CombatLogEntriesCleared

Fires as `COMBAT_LOG_ENTRIES_CLEARED`.

No payload.

### CombatLogEvent

Fires as `COMBAT_LOG_EVENT`.

No payload.

### CombatLogEventUnfiltered

Fires as `COMBAT_LOG_EVENT_UNFILTERED`.

No payload.

### CombatLogMessageLimitChanged

Fires as `COMBAT_LOG_MESSAGE_LIMIT_CHANGED`.

```lua
payload: messageLimit: number
```
