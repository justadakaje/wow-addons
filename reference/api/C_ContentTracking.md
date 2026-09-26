# C_ContentTracking

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`18` functions - `5` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetBestMapForTrackable

```lua
C_ContentTracking.GetBestMapForTrackable(trackableType: ContentTrackingType, trackableID: number, ignoreWaypoint: bool) -> result: ContentTrackingResult, mapID?: number
```

### GetCollectableSourceTrackingEnabled

```lua
C_ContentTracking.GetCollectableSourceTrackingEnabled() -> isEnabled: bool
```

### GetCollectableSourceTypes

```lua
C_ContentTracking.GetCollectableSourceTypes() -> collectableSourceTypes: table
```

### GetCurrentTrackingTarget

```lua
C_ContentTracking.GetCurrentTrackingTarget(type: ContentTrackingType, id: number) -> targetType: ContentTrackingTargetType, targetID: number
```

### GetEncounterTrackingInfo

```lua
C_ContentTracking.GetEncounterTrackingInfo(journalEncounterID: number) -> trackingInfo: EncounterTrackingInfo
```

### GetNextWaypointForTrackable

```lua
C_ContentTracking.GetNextWaypointForTrackable(trackableType: ContentTrackingType, trackableID: number, uiMapID: number) -> result: ContentTrackingResult, mapInfo?: ContentTrackingMapInfo
```

### GetObjectiveText

```lua
C_ContentTracking.GetObjectiveText(targetType: ContentTrackingTargetType, targetID: number, includeHyperlinks: bool) -> objectiveText: string
```

### GetTitle

```lua
C_ContentTracking.GetTitle(trackableType: ContentTrackingType, trackableID: number) -> title: string
```

### GetTrackablesOnMap

```lua
C_ContentTracking.GetTrackablesOnMap(trackableType: ContentTrackingType, uiMapID: number) -> result: ContentTrackingResult, trackableMapInfos: table
```

### GetTrackedIDs

```lua
C_ContentTracking.GetTrackedIDs(trackableType: ContentTrackingType) -> entryIDs: table
```

### GetVendorTrackingInfo

```lua
C_ContentTracking.GetVendorTrackingInfo(collectableEntryID: number) -> vendorTrackingInfo: VendorTrackingInfo
```

### GetWaypointText

```lua
C_ContentTracking.GetWaypointText(trackableType: ContentTrackingType, trackableID: number) -> waypointText: string
```

### IsNavigable

```lua
C_ContentTracking.IsNavigable(trackableType: ContentTrackingType, trackableID: number) -> result: ContentTrackingResult, isNavigable: bool
```

### IsTrackable

```lua
C_ContentTracking.IsTrackable(type: ContentTrackingType, id: number) -> isTrackable: bool
```

### IsTracking

```lua
C_ContentTracking.IsTracking(type: ContentTrackingType, id: number) -> isTracking: bool
```

### StartTracking

```lua
C_ContentTracking.StartTracking(type: ContentTrackingType, id: number) -> error?: ContentTrackingError
```

### StopTracking

```lua
C_ContentTracking.StopTracking(type: ContentTrackingType, id: number, stopType: ContentTrackingStopType)
```

### ToggleTracking

```lua
C_ContentTracking.ToggleTracking(type: ContentTrackingType, id: number, stopType: ContentTrackingStopType) -> error?: ContentTrackingError
```

## Events

### ContentTrackingIsEnabledUpdate

Fires as `CONTENT_TRACKING_IS_ENABLED_UPDATE`.

```lua
payload: isEnabled: bool
```

### ContentTrackingListUpdate

Fires as `CONTENT_TRACKING_LIST_UPDATE`.

No payload.

### ContentTrackingUpdate

Fires as `CONTENT_TRACKING_UPDATE`.

```lua
payload: type: ContentTrackingType, id: number, isTracked: bool
```

### TrackableInfoUpdate

Fires as `TRACKABLE_INFO_UPDATE`.

```lua
payload: type: ContentTrackingType, id: number
```

### TrackingTargetInfoUpdate

Fires as `TRACKING_TARGET_INFO_UPDATE`.

```lua
payload: targetType: ContentTrackingTargetType, targetID: number
```
