# C_Map

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`40` functions - `7` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanSetUserWaypointOnMap

```lua
C_Map.CanSetUserWaypointOnMap(uiMapID: number) -> canSet: bool
```

### ClearUserWaypoint

```lua
C_Map.ClearUserWaypoint()
```

### CloseWorldMapInteraction

```lua
C_Map.CloseWorldMapInteraction()
```

### GetAreaInfo

```lua
C_Map.GetAreaInfo(areaID: number) -> name: cstring
```

### GetBestMapForUnit

```lua
C_Map.GetBestMapForUnit(unitToken: UnitToken) -> uiMapID?: number
```

### GetBountySetMaps

```lua
C_Map.GetBountySetMaps(bountySetID: number) -> mapIDs: table
```

### GetFallbackWorldMapID

```lua
C_Map.GetFallbackWorldMapID() -> uiMapID: number
```

### GetMapArtBackgroundAtlas

```lua
C_Map.GetMapArtBackgroundAtlas(uiMapID: number) -> atlasName: textureAtlas
```

### GetMapArtHelpTextPosition

```lua
C_Map.GetMapArtHelpTextPosition(uiMapID: number) -> position: MapCanvasPosition
```

### GetMapArtID

```lua
C_Map.GetMapArtID(uiMapID: number) -> uiMapArtID: number
```

### GetMapArtLayers

```lua
C_Map.GetMapArtLayers(uiMapID: number) -> layerInfo: table
```

### GetMapArtLayerTextures

```lua
C_Map.GetMapArtLayerTextures(uiMapID: number, layerIndex: luaIndex) -> textures: table
```

### GetMapArtZoneTextPosition

```lua
C_Map.GetMapArtZoneTextPosition(uiMapID: number) -> position: MapCanvasPosition
```

### GetMapBannersForMap

```lua
C_Map.GetMapBannersForMap(uiMapID: number) -> mapBanners: table
```

### GetMapChildrenInfo

```lua
C_Map.GetMapChildrenInfo(uiMapID: number, mapType?: UIMapType, allDescendants?: bool) -> info: table
```

### GetMapDisplayInfo

```lua
C_Map.GetMapDisplayInfo(uiMapID: number) -> hideIcons: bool
```

### GetMapGroupID

```lua
C_Map.GetMapGroupID(uiMapID: number) -> uiMapGroupID: number
```

### GetMapGroupMembersInfo

```lua
C_Map.GetMapGroupMembersInfo(uiMapGroupID: number) -> info: table
```

### GetMapHighlightInfoAtPosition

```lua
C_Map.GetMapHighlightInfoAtPosition(uiMapID: number, x: number, y: number) -> fileDataID: fileID, atlasID: textureAtlas, texturePercentageX: number, texturePercentageY: number, textureX: number, textureY: number, scrollChildX: number, scrollChildY: number
```

### GetMapHighlightPulseInfo

```lua
C_Map.GetMapHighlightPulseInfo(uiMapID: number) -> fileDataID: fileID, atlasID: textureAtlas, texturePercentageX: number, texturePercentageY: number, textureX: number, textureY: number, scrollChildX: number, scrollChildY: number
```

### GetMapInfo

```lua
C_Map.GetMapInfo(uiMapID: number) -> info: UiMapDetails
```

### GetMapInfoAtPosition

```lua
C_Map.GetMapInfoAtPosition(uiMapID: number, x: number, y: number, ignoreZoneMapPositionData?: bool) -> info: UiMapDetails
```

### GetMapLevels

```lua
C_Map.GetMapLevels(uiMapID: number) -> playerMinLevel: number, playerMaxLevel: number, petMinLevel: number, petMaxLevel: number
```

### GetMapLinksForMap

```lua
C_Map.GetMapLinksForMap(uiMapID: number) -> mapLinks: table
```

### GetMapPosFromWorldPos

```lua
C_Map.GetMapPosFromWorldPos(continentID: number, worldPosition: vector2, overrideUiMapID?: number) -> uiMapID: number, mapPosition: vector2
```

### GetMapRectOnMap

```lua
C_Map.GetMapRectOnMap(uiMapID: number, topUiMapID: number) -> minX: number, maxX: number, minY: number, maxY: number
```

### GetMapWorldSize

```lua
C_Map.GetMapWorldSize(uiMapID: number) -> width: number, height: number
```

### GetPlayerMapPosition

```lua
C_Map.GetPlayerMapPosition(uiMapID: number, unitToken: UnitToken) -> position?: vector2
```

### GetUserWaypoint

```lua
C_Map.GetUserWaypoint() -> point: UiMapPoint
```

### GetUserWaypointFromHyperlink

```lua
C_Map.GetUserWaypointFromHyperlink(hyperlink: string) -> point: UiMapPoint
```

### GetUserWaypointHyperlink

```lua
C_Map.GetUserWaypointHyperlink() -> hyperlink: string
```

### GetUserWaypointPositionForMap

```lua
C_Map.GetUserWaypointPositionForMap(uiMapID: number) -> mapPosition: vector2
```

### GetWorldPosFromMapPos

```lua
C_Map.GetWorldPosFromMapPos(uiMapID: number, mapPosition: vector2) -> continentID: number, worldPosition: vector2
```

### HasUserWaypoint

```lua
C_Map.HasUserWaypoint() -> hasUserWaypoint: bool
```

### IsCityMap

```lua
C_Map.IsCityMap(uiMapID: number) -> isCityMap: bool
```

### IsMapValidForNavBarDropdown

```lua
C_Map.IsMapValidForNavBarDropdown(uiMapID: number) -> isValid: bool
```

### MapHasArt

```lua
C_Map.MapHasArt(uiMapID: number) -> hasArt: bool
```

### OpenWorldMap

```lua
C_Map.OpenWorldMap(uiMapID?: number)
```

### RequestPreloadMap

```lua
C_Map.RequestPreloadMap(uiMapID: number)
```

### SetUserWaypoint

```lua
C_Map.SetUserWaypoint(point: UiMapPoint) -> wasSet: bool
```

## Events

### NewWmoChunk

Fires as `NEW_WMO_CHUNK`.

No payload.

### PlayerMapChanged

Fires as `PLAYER_MAP_CHANGED`.

```lua
payload: oldMapID: number, newMapID: number
```

### UserWaypointUpdated

Fires as `USER_WAYPOINT_UPDATED`.

No payload.

### WorldMapOpen

Fires as `WORLD_MAP_OPEN`.

```lua
payload: uiMapID?: number
```

### ZoneChanged

Fires as `ZONE_CHANGED`.

No payload.

### ZoneChangedIndoors

Fires as `ZONE_CHANGED_INDOORS`.

No payload.

### ZoneChangedNewArea

Fires as `ZONE_CHANGED_NEW_AREA`.

No payload.
