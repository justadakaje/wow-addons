# C_RecentAllies

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`15` functions - `5` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanSetRecentAllyNote

```lua
C_RecentAllies.CanSetRecentAllyNote(characterGUID: WOWGUID) -> canSetNote: bool
```

### GetRecentAllies

```lua
C_RecentAllies.GetRecentAllies() -> recentAlliesData: table
```

### GetRecentAllyByFullName

```lua
C_RecentAllies.GetRecentAllyByFullName(fullCharacterName: cstring) -> recentAllyData?: RecentAllyData
```

### GetRecentAllyByGUID

```lua
C_RecentAllies.GetRecentAllyByGUID(characterGUID: WOWGUID) -> recentAllyData?: RecentAllyData
```

### IsInteractionCategoryFilterSupportedForCurrentGameType

```lua
C_RecentAllies.IsInteractionCategoryFilterSupportedForCurrentGameType(interactionCategoryFilter: RecentAlliesInteractionCategoryFilter) -> isInteractionCategoryFilterSupportedForCurrentGameType: bool
```

### IsRecentAllyByFullName

```lua
C_RecentAllies.IsRecentAllyByFullName(fullCharacterName: cstring) -> isRecentAlly: bool
```

### IsRecentAllyByGUID

```lua
C_RecentAllies.IsRecentAllyByGUID(characterGUID: WOWGUID) -> isRecentAlly: bool
```

### IsRecentAllyDataReady

```lua
C_RecentAllies.IsRecentAllyDataReady() -> isReady: bool
```

### IsRecentAllyPinned

```lua
C_RecentAllies.IsRecentAllyPinned(characterGUID: WOWGUID) -> isPinned: bool
```

### IsSystemEnabled

```lua
C_RecentAllies.IsSystemEnabled() -> isRecentAllySystemEnabled: bool
```

### IsSystemSupported

```lua
C_RecentAllies.IsSystemSupported() -> isRecentAllySystemSupported: bool
```

### SearchRecentAllies

```lua
C_RecentAllies.SearchRecentAllies(searchInfo: RecentAlliesSearchInfo) -> recentAlliesData: table
```

### SetRecentAllyNote

```lua
C_RecentAllies.SetRecentAllyNote(characterGUID: WOWGUID, note: cstring)
```

### SetRecentAllyPinned

```lua
C_RecentAllies.SetRecentAllyPinned(characterGUID: WOWGUID, isPinned: bool)
```

### TryRequestRecentAlliesData

```lua
C_RecentAllies.TryRequestRecentAlliesData()
```

## Events

### LetRecentAlliesSeeLocationSettingUpdated

Fires as `LET_RECENT_ALLIES_SEE_LOCATION_SETTING_UPDATED`.

No payload.

### RecentAlliesCacheUpdate

Fires as `RECENT_ALLIES_CACHE_UPDATE`.

No payload.

### RecentAlliesDataReady

Fires as `RECENT_ALLIES_DATA_READY`.

No payload.

### RecentAlliesSystemStatusUpdated

Fires as `RECENT_ALLIES_SYSTEM_STATUS_UPDATED`.

No payload.

### RecentAllyDataUpdated

Fires as `RECENT_ALLY_DATA_UPDATED`.

```lua
payload: characterGUID: WOWGUID
```
