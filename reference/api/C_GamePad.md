# C_GamePad

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`25` functions - `6` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddSDLMapping

```lua
C_GamePad.AddSDLMapping(platform: ClientPlatformType, mapping: cstring) -> success: bool
```

### ApplyConfigs

```lua
C_GamePad.ApplyConfigs()
```

### AxisIndexToConfigName

```lua
C_GamePad.AxisIndexToConfigName(axisIndex: number) -> configName?: cstring
```

### ButtonBindingToIndex

```lua
C_GamePad.ButtonBindingToIndex(bindingName: cstring) -> buttonIndex?: number
```

### ButtonIndexToBinding

```lua
C_GamePad.ButtonIndexToBinding(buttonIndex: number) -> bindingName?: cstring
```

### ButtonIndexToConfigName

```lua
C_GamePad.ButtonIndexToConfigName(buttonIndex: number) -> configName?: cstring
```

### ClearLedColor

```lua
C_GamePad.ClearLedColor()
```

### DeleteConfig

```lua
C_GamePad.DeleteConfig(configID: GamePadConfigID)
```

### GetActiveDeviceID

```lua
C_GamePad.GetActiveDeviceID() -> deviceID: number
```

### GetAllConfigIDs

```lua
C_GamePad.GetAllConfigIDs() -> configIDs: table
```

### GetAllDeviceIDs

```lua
C_GamePad.GetAllDeviceIDs() -> deviceIDs: table
```

### GetAllowHoverEventsWithFreeLook

```lua
C_GamePad.GetAllowHoverEventsWithFreeLook() -> enabled: bool
```

### GetCombinedDeviceID

```lua
C_GamePad.GetCombinedDeviceID() -> deviceID: number
```

### GetConfig

```lua
C_GamePad.GetConfig(configID: GamePadConfigID) -> config?: GamePadConfig
```

### GetDeviceMappedState

```lua
C_GamePad.GetDeviceMappedState(deviceID?: number) -> state?: GamePadMappedState
```

### GetDeviceRawState

```lua
C_GamePad.GetDeviceRawState(deviceID: number) -> rawState?: GamePadRawState
```

### GetLedColor

```lua
C_GamePad.GetLedColor() -> color: colorRGB
```

### GetPowerLevel

```lua
C_GamePad.GetPowerLevel(deviceID?: number) -> powerLevel: GamePadPowerLevel
```

### IsEnabled

```lua
C_GamePad.IsEnabled() -> enabled: bool
```

### SetAllowHoverEventsWithFreeLook

```lua
C_GamePad.SetAllowHoverEventsWithFreeLook(enable: bool)
```

### SetConfig

```lua
C_GamePad.SetConfig(config: GamePadConfig)
```

### SetLedColor

```lua
C_GamePad.SetLedColor(color: colorRGB)
```

### SetVibration

```lua
C_GamePad.SetVibration(vibrationType: cstring, intensity: number)
```

### StickIndexToConfigName

```lua
C_GamePad.StickIndexToConfigName(stickIndex: number) -> configName?: cstring
```

### StopVibration

```lua
C_GamePad.StopVibration()
```

## Events

### GamePadActiveChanged

Fires as `GAME_PAD_ACTIVE_CHANGED`.

```lua
payload: isActive: bool
```

### GamePadAllowHoverEventsWithFreeLookChanged

Fires as `GAME_PAD_ALLOW_HOVER_EVENTS_WITH_FREE_LOOK_CHANGED`.

```lua
payload: enabled: bool
```

### GamePadConfigsChanged

Fires as `GAME_PAD_CONFIGS_CHANGED`.

No payload.

### GamePadConnected

Fires as `GAME_PAD_CONNECTED`.

No payload.

### GamePadDisconnected

Fires as `GAME_PAD_DISCONNECTED`.

No payload.

### GamePadPowerChanged

Fires as `GAME_PAD_POWER_CHANGED`.

```lua
payload: powerLevel: GamePadPowerLevel
```
