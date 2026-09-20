# C_VideoOptions

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`11` functions - `9` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AreHighResTexturesAvailable

```lua
C_VideoOptions.AreHighResTexturesAvailable() -> areAvailable: bool
```

### GetCurrentGameWindowSize

```lua
C_VideoOptions.GetCurrentGameWindowSize() -> size: vector2
```

### GetDefaultGameWindowSize

```lua
C_VideoOptions.GetDefaultGameWindowSize(monitor: number) -> size: vector2
```

### GetGameWindowSizes

```lua
C_VideoOptions.GetGameWindowSizes(monitor: number, fullscreen: bool) -> sizes: table
```

### GetGxAdapterInfo

```lua
C_VideoOptions.GetGxAdapterInfo() -> adapters: table
```

### IsLinearEnabledOnStart

```lua
C_VideoOptions.IsLinearEnabledOnStart() -> isEnabled: bool
```

### IsOutlineModeSupported

```lua
C_VideoOptions.IsOutlineModeSupported() -> isSupported: bool
```

### IsPBRWaterSupported

```lua
C_VideoOptions.IsPBRWaterSupported() -> isSupported: bool
```

### IsSecondaryLightingSupported

```lua
C_VideoOptions.IsSecondaryLightingSupported() -> isSupported: bool
```

### IsSpellVisualDensitySystemSupported

```lua
C_VideoOptions.IsSpellVisualDensitySystemSupported() -> isSupported: bool
```

### SetGameWindowSize

```lua
C_VideoOptions.SetGameWindowSize(x: number, y: number)
```

## Events

### AdapterListChanged

Fires as `ADAPTER_LIST_CHANGED`.

No payload.

### DisplaySizeChanged

Fires as `DISPLAY_SIZE_CHANGED`.

No payload.

### GlueScreenshotFailed

Fires as `GLUE_SCREENSHOT_FAILED`.

No payload.

### GlueScreenshotStarted

Fires as `GLUE_SCREENSHOT_STARTED`.

No payload.

### GlueScreenshotSucceeded

Fires as `GLUE_SCREENSHOT_SUCCEEDED`.

No payload.

### GxRestarted

Fires as `GX_RESTARTED`.

No payload.

### ScreenshotFailed

Fires as `SCREENSHOT_FAILED`.

No payload.

### ScreenshotStarted

Fires as `SCREENSHOT_STARTED`.

No payload.

### ScreenshotSucceeded

Fires as `SCREENSHOT_SUCCEEDED`.

No payload.
