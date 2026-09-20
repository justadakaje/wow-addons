# C_CombatLogSecure

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`9` functions - `3` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddEventFilter

```lua
C_CombatLogSecure.AddEventFilter()
```

### ClearEventFilters

```lua
C_CombatLogSecure.ClearEventFilters()
```

### CreateCombatLogMessage

```lua
C_CombatLogSecure.CreateCombatLogMessage(message: string, colorR: number, colorG: number, colorB: number, order: CombatLogMessageOrder)
```

### GetCurrentEntryInfo

```lua
C_CombatLogSecure.GetCurrentEntryInfo()
```

### GetCurrentEventInfo

```lua
C_CombatLogSecure.GetCurrentEventInfo()
```

### GetEntryCount

```lua
C_CombatLogSecure.GetEntryCount(ignoreFilter: bool) -> count: number
```

### SeekToNewestEntry

```lua
C_CombatLogSecure.SeekToNewestEntry(ignoreFilter: bool) -> isValidEntry: bool
```

### SeekToPreviousEntry

```lua
C_CombatLogSecure.SeekToPreviousEntry(ignoreFilter: bool) -> isValidEntry: bool
```

### ShouldShowCurrentEntry

```lua
C_CombatLogSecure.ShouldShowCurrentEntry() -> shouldShow: bool
```

## Events

### CombatLogApplyFilterSettings

Fires as `COMBAT_LOG_APPLY_FILTER_SETTINGS`.

```lua
payload: filterSettings: LuaValueVariant
```

### CombatLogMessage

Fires as `COMBAT_LOG_MESSAGE`.

```lua
payload: message: string, colorR: number, colorG: number, colorB: number, order: CombatLogMessageOrder
```

### CombatLogRefilterEntries

Fires as `COMBAT_LOG_REFILTER_ENTRIES`.

No payload.
