# C_System

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`1` functions - `28` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetFrameStack

```lua
C_System.GetFrameStack() -> objects: table
```

## Events

### CaptureframesFailed

Fires as `CAPTUREFRAMES_FAILED`.

No payload.

### CaptureframesSucceeded

Fires as `CAPTUREFRAMES_SUCCEEDED`.

No payload.

### DisableTaxiBenchmark

Fires as `DISABLE_TAXI_BENCHMARK`.

No payload.

### EnableTaxiBenchmark

Fires as `ENABLE_TAXI_BENCHMARK`.

No payload.

### FirstFrameRendered

Fires as `FIRST_FRAME_RENDERED`.

No payload.

### GenericError

Fires as `GENERIC_ERROR`.

```lua
payload: errorMessage: cstring
```

### GlobalMouseDown

Fires as `GLOBAL_MOUSE_DOWN`.

```lua
payload: button: cstring
```

### GlobalMouseUp

Fires as `GLOBAL_MOUSE_UP`.

```lua
payload: button: cstring
```

### InitialHotfixesApplied

Fires as `INITIAL_HOTFIXES_APPLIED`.

No payload.

### LocResult

Fires as `LOC_RESULT`.

```lua
payload: result: cstring
```

### LogoutCancel

Fires as `LOGOUT_CANCEL`.

No payload.

### PlayerCamping

Fires as `PLAYER_CAMPING`.

No payload.

### PlayerEnteringWorld

Fires as `PLAYER_ENTERING_WORLD`.

```lua
payload: isInitialLogin: bool, isReloadingUi: bool
```

### PlayerLeavingWorld

Fires as `PLAYER_LEAVING_WORLD`.

No payload.

### PlayerLogin

Fires as `PLAYER_LOGIN`.

No payload.

### PlayerLogout

Fires as `PLAYER_LOGOUT`.

No payload.

### PlayerQuiting

Fires as `PLAYER_QUITING`.

No payload.

### SearchDbLoaded

Fires as `SEARCH_DB_LOADED`.

No payload.

### ShardTransfer

Fires as `SHARD_TRANSFER`.

No payload.

### ShardTransferImminent

Fires as `SHARD_TRANSFER_IMMINENT`.

No payload.

### StreamingIcon

Fires as `STREAMING_ICON`.

```lua
payload: streamingStatus: number
```

### Sysmsg

Fires as `SYSMSG`.

```lua
payload: string: cstring, r: number, g: number, b: number
```

### TimePlayedMsg

Fires as `TIME_PLAYED_MSG`.

```lua
payload: totalTimePlayed: number, timePlayedThisLevel: number
```

### UiErrorMessage

Fires as `UI_ERROR_MESSAGE`.

```lua
payload: errorType: luaIndex, message: string
```

### UiErrorPopup

Fires as `UI_ERROR_POPUP`.

```lua
payload: errorType: luaIndex, message: string
```

### UiInfoMessage

Fires as `UI_INFO_MESSAGE`.

```lua
payload: errorType: luaIndex, message: string
```

### VariablesLoaded

Fires as `VARIABLES_LOADED`.

No payload.

### WoWMouseNotFound

Fires as `WOW_MOUSE_NOT_FOUND`.

No payload.
