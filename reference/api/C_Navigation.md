# C_Navigation

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`7` functions - `3` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetDistance

```lua
C_Navigation.GetDistance() -> distance: number
```

### GetFrame

```lua
C_Navigation.GetFrame() -> frame?: ScriptRegion
```

### GetNearestPartyMemberToken

```lua
C_Navigation.GetNearestPartyMemberToken() -> unitToken: cstring
```

### GetNextWaypointForMap

```lua
C_Navigation.GetNextWaypointForMap(uiMapID: number) -> x: number, y: number, waypointDescription: string
```

### GetTargetState

```lua
C_Navigation.GetTargetState() -> state: NavigationState
```

### HasValidScreenPosition

```lua
C_Navigation.HasValidScreenPosition() -> hasValidScreenPosition: bool
```

### WasClampedToScreen

```lua
C_Navigation.WasClampedToScreen() -> wasClamped: bool
```

## Events

### NavigationDestinationReached

Fires as `NAVIGATION_DESTINATION_REACHED`.

```lua
payload: isWaypoint: bool
```

### NavigationFrameCreated

Fires as `NAVIGATION_FRAME_CREATED`.

```lua
payload: region: ScriptRegion
```

### NavigationFrameDestroyed

Fires as `NAVIGATION_FRAME_DESTROYED`.

No payload.
