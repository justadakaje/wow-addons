# C_Minimap

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`23` functions - `4` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanTrackBattlePets

```lua
C_Minimap.CanTrackBattlePets() -> CanTrackBattlePets: bool
```

### ClearAllTracking

```lua
C_Minimap.ClearAllTracking()
```

### ClearMinimapInsetInfo

```lua
C_Minimap.ClearMinimapInsetInfo()
```

### GetDefaultTrackingValue

```lua
C_Minimap.GetDefaultTrackingValue(filterType: MinimapTrackingFilter) -> defaultValue: bool
```

### GetDrawGroundTextures

```lua
C_Minimap.GetDrawGroundTextures() -> draw: bool
```

### GetNumQuestPOIWorldEffects

```lua
C_Minimap.GetNumQuestPOIWorldEffects() -> worldEffectCount: number
```

### GetNumTrackingTypes

```lua
C_Minimap.GetNumTrackingTypes() -> numTrackingTypes: number
```

### GetPOITextureCoords

```lua
C_Minimap.GetPOITextureCoords(index?: number) -> textureCoordsX: number, textureCoordsY: number, textureCoordsZ: number, textureCoordsW: number
```

### GetTrackingFilter

```lua
C_Minimap.GetTrackingFilter(spellIndex: luaIndex) -> trackingType: MinimapScriptTrackingFilter
```

### GetTrackingInfo

```lua
C_Minimap.GetTrackingInfo(spellIndex: luaIndex) -> trackingInfo?: MinimapScriptTrackingInfo
```

### GetUiMapID

```lua
C_Minimap.GetUiMapID() -> uiMapID?: number
```

### GetViewRadius

```lua
C_Minimap.GetViewRadius() -> yards: number
```

### IsFilteredOut

```lua
C_Minimap.IsFilteredOut(filterType: MinimapTrackingFilter) -> isFiltered: bool
```

### IsInsideQuestBlob

```lua
C_Minimap.IsInsideQuestBlob(questID: number) -> isInside: bool
```

### IsRotateMinimapIgnored

```lua
C_Minimap.IsRotateMinimapIgnored() -> isIgnored: bool
```

### IsTrackingAccountCompletedQuests

```lua
C_Minimap.IsTrackingAccountCompletedQuests() -> IsTrackingAccountCompletedQuests: bool
```

### IsTrackingBattlePets

```lua
C_Minimap.IsTrackingBattlePets() -> isTrackingBattlePets: bool
```

### IsTrackingHiddenQuests

```lua
C_Minimap.IsTrackingHiddenQuests() -> isTrackingHiddenQuests: bool
```

### SetDrawGroundTextures

```lua
C_Minimap.SetDrawGroundTextures(draw: bool)
```

### SetIgnoreRotateMinimap

```lua
C_Minimap.SetIgnoreRotateMinimap(ignore: bool)
```

### SetMinimapInsetInfo

```lua
C_Minimap.SetMinimapInsetInfo(minAngle: number, maxAngle: number, scalar: number)
```

### SetTracking

```lua
C_Minimap.SetTracking(index: luaIndex, on: bool)
```

### ShouldUseHybridMinimap

```lua
C_Minimap.ShouldUseHybridMinimap() -> shouldUse: bool
```

## Events

### MinimapPing

Fires as `MINIMAP_PING`.

```lua
payload: unitTarget: UnitTokenVariant, y: number, x: number
```

### MinimapUpdateTracking

Fires as `MINIMAP_UPDATE_TRACKING`.

No payload.

### MinimapUpdateZoom

Fires as `MINIMAP_UPDATE_ZOOM`.

No payload.

### PlayerInsideQuestBlobStateChanged

Fires as `PLAYER_INSIDE_QUEST_BLOB_STATE_CHANGED`.

```lua
payload: questID: number, isInside: bool
```
