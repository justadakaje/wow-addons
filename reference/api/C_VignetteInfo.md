# C_VignetteInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`6` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### FindBestUniqueVignette

```lua
C_VignetteInfo.FindBestUniqueVignette(vignetteGUIDs: table) -> bestUniqueVignetteIndex?: luaIndex
```

### GetHealthPercent

```lua
C_VignetteInfo.GetHealthPercent(vignetteGUID: WOWGUID) -> healthPct?: number
```

### GetRecommendedGroupSize

```lua
C_VignetteInfo.GetRecommendedGroupSize(vignetteGUID: WOWGUID) -> minGroupSize: number, maxGroupSize: number
```

### GetVignetteInfo

```lua
C_VignetteInfo.GetVignetteInfo(vignetteGUID: WOWGUID) -> vignetteInfo?: VignetteInfo
```

### GetVignettePosition

```lua
C_VignetteInfo.GetVignettePosition(vignetteGUID: WOWGUID, uiMapID: number) -> vignettePosition: vector2, vignetteFacing?: number
```

### GetVignettes

```lua
C_VignetteInfo.GetVignettes() -> vignetteGUIDs: table
```

## Events

### VignetteMinimapUpdated

Fires as `VIGNETTE_MINIMAP_UPDATED`.

```lua
payload: vignetteGUID: WOWGUID, onMinimap: bool
```

### VignettesUpdated

Fires as `VIGNETTES_UPDATED`.

No payload.
