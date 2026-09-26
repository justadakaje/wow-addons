# C_Ping

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`6` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetCooldownInfo

```lua
C_Ping.GetCooldownInfo() -> cooldownInfo: PingCooldownInfo
```

### GetDefaultPingOptions

```lua
C_Ping.GetDefaultPingOptions() -> pingTypes: table
```

### GetTextureKitForType

```lua
C_Ping.GetTextureKitForType(type: PingSubjectType) -> uiTextureKitID: textureKit
```

### IsPingSystemEnabled

```lua
C_Ping.IsPingSystemEnabled() -> isEnabled: bool
```

### SendMacroPing

```lua
C_Ping.SendMacroPing(macroInfo: PingMacroInfo)
```

### TogglePingListener

```lua
C_Ping.TogglePingListener(down: bool)
```

## Events

### PingSystemError

Fires as `PING_SYSTEM_ERROR`.

```lua
payload: error: cstring
```
