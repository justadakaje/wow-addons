# Cinematic

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`7` functions - `6` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CinematicFinished

```lua
CinematicFinished(movieType: CinematicType, userCanceled: bool, didError: bool)
```

### CinematicStarted

```lua
CinematicStarted(movieType: CinematicType, movieID: number, canCancel: bool)
```

### GetCurrentCinematicSummary

```lua
GetCurrentCinematicSummary() -> summary: cstring
```

### InCinematic

```lua
InCinematic() -> inCinematic: bool
```

### MouseOverrideCinematicDisable

```lua
MouseOverrideCinematicDisable(doOverride: bool)
```

### OpeningCinematic

```lua
OpeningCinematic()
```

### StopCinematic

```lua
StopCinematic()
```

## Events

### CinematicStart

Fires as `CINEMATIC_START`.

```lua
payload: canBeCancelled: bool, forcedAspectRatio: CameraModeAspectRatio
```

### CinematicStop

Fires as `CINEMATIC_STOP`.

No payload.

### HideSubtitle

Fires as `HIDE_SUBTITLE`.

No payload.

### PlayMovie

Fires as `PLAY_MOVIE`.

```lua
payload: movieID: number
```

### ShowSubtitle

Fires as `SHOW_SUBTITLE`.

```lua
payload: subtitle: cstring, sender?: cstring
```

### StopMovie

Fires as `STOP_MOVIE`.

No payload.
