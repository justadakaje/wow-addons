# C_PingSecure

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`19` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearHitTestPingInfo

```lua
C_PingSecure.ClearHitTestPingInfo()
```

### CreateFrame

```lua
C_PingSecure.CreateFrame()
```

### DisplayError

```lua
C_PingSecure.DisplayError(error: cstring)
```

### GetTargetPingReceiver

```lua
C_PingSecure.GetTargetPingReceiver(mousePosX: number, mousePosY: number) -> frame: ScriptRegion
```

### SendHitTestPing

```lua
C_PingSecure.SendHitTestPing(type?: PingSubjectType) -> result: SendPingResult
```

### SendPlayerItemPing

```lua
C_PingSecure.SendPlayerItemPing(itemID: number) -> result: SendPingResult
```

### SendPlayerSpellCategoryPing

```lua
C_PingSecure.SendPlayerSpellCategoryPing(spellCategoryID: number) -> result: SendPingResult
```

### SendPlayerSpellPing

```lua
C_PingSecure.SendPlayerSpellPing(spellID: number) -> result: SendPingResult
```

### SendUnitPing

```lua
C_PingSecure.SendUnitPing(target: WOWGUID, type?: PingSubjectType, isPlayerResource?: bool) -> result: SendPingResult
```

### SetHitTestPingTarget

```lua
C_PingSecure.SetHitTestPingTarget(mousePosX: number, mousePosY: number, forcePointPing?: bool) -> state: PingSetTargetState
```

### SetHitTestTargetAndSendPing

```lua
C_PingSecure.SetHitTestTargetAndSendPing() -> result: SendPingResult
```

### SetPendingPingOffScreenCallback

```lua
C_PingSecure.SetPendingPingOffScreenCallback(cb: PendingPingOffScreenCallback)
```

### SetPingCooldownStartedCallback

```lua
C_PingSecure.SetPingCooldownStartedCallback(cb: PingCooldownStartedCallback)
```

### SetPingPinFrameAddedCallback

```lua
C_PingSecure.SetPingPinFrameAddedCallback(cb: PingPinFrameAddedCallback)
```

### SetPingPinFrameRemovedCallback

```lua
C_PingSecure.SetPingPinFrameRemovedCallback(cb: PingPinFrameRemovedCallback)
```

### SetPingPinFrameScreenClampStateUpdatedCallback

```lua
C_PingSecure.SetPingPinFrameScreenClampStateUpdatedCallback(cb: PingPinFrameScreenClampStateUpdatedCallback)
```

### SetPingRadialWheelCreatedCallback

```lua
C_PingSecure.SetPingRadialWheelCreatedCallback(cb: PingRadialWheelCreatedCallback)
```

### SetSendMacroPingCallback

```lua
C_PingSecure.SetSendMacroPingCallback(cb: SendMacroPingCallback)
```

### SetTogglePingListenerCallback

```lua
C_PingSecure.SetTogglePingListenerCallback(cb: TogglePingListenerCallback)
```

## Events

### UnitPingPinAdded

Fires as `UNIT_PING_PIN_ADDED`.

```lua
payload: guid: WOWGUID, uiTextureKit: textureKit
```

### UnitPingPinRemoved

Fires as `UNIT_PING_PIN_REMOVED`.

```lua
payload: guid: WOWGUID
```
