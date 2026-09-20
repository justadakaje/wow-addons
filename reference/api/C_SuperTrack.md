# C_SuperTrack

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`20` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearAllSuperTracked

```lua
C_SuperTrack.ClearAllSuperTracked()
```

### ClearSuperTrackedContent

```lua
C_SuperTrack.ClearSuperTrackedContent()
```

### ClearSuperTrackedMapPin

```lua
C_SuperTrack.ClearSuperTrackedMapPin()
```

### GetHighestPrioritySuperTrackingType

```lua
C_SuperTrack.GetHighestPrioritySuperTrackingType() -> type?: SuperTrackingType
```

### GetSuperTrackedContent

```lua
C_SuperTrack.GetSuperTrackedContent() -> trackableType: ContentTrackingType, trackableID: number
```

### GetSuperTrackedItemName

```lua
C_SuperTrack.GetSuperTrackedItemName() -> name: string, description: string
```

### GetSuperTrackedMapPin

```lua
C_SuperTrack.GetSuperTrackedMapPin() -> type: SuperTrackingMapPinType, typeID: number
```

### GetSuperTrackedQuestID

```lua
C_SuperTrack.GetSuperTrackedQuestID() -> questID?: number
```

### GetSuperTrackedVignette

```lua
C_SuperTrack.GetSuperTrackedVignette() -> vignetteGUID?: WOWGUID
```

### IsSuperTrackingAnything

```lua
C_SuperTrack.IsSuperTrackingAnything() -> isSuperTracking: bool
```

### IsSuperTrackingContent

```lua
C_SuperTrack.IsSuperTrackingContent() -> isSuperTracking: bool
```

### IsSuperTrackingCorpse

```lua
C_SuperTrack.IsSuperTrackingCorpse() -> isSuperTracking: bool
```

### IsSuperTrackingMapPin

```lua
C_SuperTrack.IsSuperTrackingMapPin() -> isSuperTracking: bool
```

### IsSuperTrackingQuest

```lua
C_SuperTrack.IsSuperTrackingQuest() -> isSuperTracking: bool
```

### IsSuperTrackingUserWaypoint

```lua
C_SuperTrack.IsSuperTrackingUserWaypoint() -> isSuperTracking: bool
```

### SetSuperTrackedContent

```lua
C_SuperTrack.SetSuperTrackedContent(trackableType: ContentTrackingType, trackableID: number)
```

### SetSuperTrackedMapPin

```lua
C_SuperTrack.SetSuperTrackedMapPin(type: SuperTrackingMapPinType, typeID: number)
```

### SetSuperTrackedQuestID

```lua
C_SuperTrack.SetSuperTrackedQuestID(questID: number)
```

### SetSuperTrackedUserWaypoint

```lua
C_SuperTrack.SetSuperTrackedUserWaypoint(superTracked: bool)
```

### SetSuperTrackedVignette

```lua
C_SuperTrack.SetSuperTrackedVignette(vignetteGUID: WOWGUID)
```

## Events

### SuperTrackingChanged

Fires as `SUPER_TRACKING_CHANGED`.

No payload.

### SuperTrackingPathUpdated

Fires as `SUPER_TRACKING_PATH_UPDATED`.

No payload.
