# C_WarbandScene

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`7` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetRandomEntryID

```lua
C_WarbandScene.GetRandomEntryID() -> warbandSceneID: number
```

### GetWarbandSceneEntry

```lua
C_WarbandScene.GetWarbandSceneEntry(warbandSceneID: number) -> warbandSceneEntry: WarbandSceneEntry
```

### HasWarbandScene

```lua
C_WarbandScene.HasWarbandScene(warbandSceneID: number) -> owned: bool
```

### IsFavorite

```lua
C_WarbandScene.IsFavorite(warbandSceneID: number) -> favorite: bool
```

### SearchWarbandSceneEntries

```lua
C_WarbandScene.SearchWarbandSceneEntries(searchParams: WarbandSceneSearchInfo) -> matchingEntryIDs: table
```

### SetFavorite

```lua
C_WarbandScene.SetFavorite(warbandSceneID: number, favorite: bool)
```

### WarbandScenesAvailable

```lua
C_WarbandScene.WarbandScenesAvailable() -> areWarbandScenesAvailable: bool
```

## Events

### NewWarbandSceneAdded

Fires as `NEW_WARBAND_SCENE_ADDED`.

```lua
payload: warbandScenID: number
```

### WarbandSceneFavoritesUpdated

Fires as `WARBAND_SCENE_FAVORITES_UPDATED`.

No payload.
