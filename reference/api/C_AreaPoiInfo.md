# C_AreaPoiInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`8` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetAreaPOIForMap

```lua
C_AreaPoiInfo.GetAreaPOIForMap(uiMapID: number) -> areaPoiIDs: table
```

### GetAreaPOIInfo

```lua
C_AreaPoiInfo.GetAreaPOIInfo(uiMapID?: number, areaPoiID: number) -> poiInfo: AreaPOIInfo
```

### GetAreaPOISecondsLeft

```lua
C_AreaPoiInfo.GetAreaPOISecondsLeft(areaPoiID: number) -> secondsLeft: number
```

### GetDelvesForMap

```lua
C_AreaPoiInfo.GetDelvesForMap(uiMapID: number) -> areaPoiIDs: table
```

### GetDragonridingRacesForMap

```lua
C_AreaPoiInfo.GetDragonridingRacesForMap(uiMapID: number) -> areaPoiIDs: table
```

### GetEventsForMap

```lua
C_AreaPoiInfo.GetEventsForMap(uiMapID: number) -> areaPoiIDs: table
```

### GetQuestHubsForMap

```lua
C_AreaPoiInfo.GetQuestHubsForMap(uiMapID: number) -> areaPoiIDs: table
```

### IsAreaPOITimed

```lua
C_AreaPoiInfo.IsAreaPOITimed(areaPoiID: number) -> isTimed: bool, hideTimerInTooltip?: bool
```

## Events

### AreaPoisUpdated

Fires as `AREA_POIS_UPDATED`.

No payload.
