# C_AdventureMap

WoW: Forever 1.60.1 (build 70862) - Interface 16001

`5` functions - `5` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetAdventureMapTextureKit

```lua
C_AdventureMap.GetAdventureMapTextureKit() -> adventureMapTextureKit: textureKit
```

### GetNumMapInsets

```lua
C_AdventureMap.GetNumMapInsets() -> numMapInsets: number
```

### GetNumQuestOffers

```lua
C_AdventureMap.GetNumQuestOffers() -> numQuestOffers: number
```

### GetNumZoneChoices

```lua
C_AdventureMap.GetNumZoneChoices() -> numZoneChoices: number
```

### GetQuestPortraitInfo

```lua
C_AdventureMap.GetQuestPortraitInfo(questID: number) -> info: AdventureMapQuestPortraitInfo
```

## Events

### AdventureMapClose

Fires as `ADVENTURE_MAP_CLOSE`.

No payload.

### AdventureMapOpen

Fires as `ADVENTURE_MAP_OPEN`.

```lua
payload: followerTypeID: number
```

### AdventureMapQuestUpdate

Fires as `ADVENTURE_MAP_QUEST_UPDATE`.

```lua
payload: questID: number
```

### AdventureMapUpdateInsets

Fires as `ADVENTURE_MAP_UPDATE_INSETS`.

No payload.

### AdventureMapUpdatePois

Fires as `ADVENTURE_MAP_UPDATE_POIS`.

No payload.
