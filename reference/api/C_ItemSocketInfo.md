# C_ItemSocketInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`16` functions - `8` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AcceptSockets

```lua
C_ItemSocketInfo.AcceptSockets()
```

### ClickSocketButton

```lua
C_ItemSocketInfo.ClickSocketButton(index: luaIndex)
```

### CloseSocketInfo

```lua
C_ItemSocketInfo.CloseSocketInfo()
```

### CompleteSocketing

```lua
C_ItemSocketInfo.CompleteSocketing()
```

### GetCurrUIType

```lua
C_ItemSocketInfo.GetCurrUIType() -> uiType: ItemSocketInfoUIType
```

### GetExistingSocketInfo

```lua
C_ItemSocketInfo.GetExistingSocketInfo(index: luaIndex) -> name?: string, icon?: fileID, gemMatchesSocket: bool
```

### GetExistingSocketLink

```lua
C_ItemSocketInfo.GetExistingSocketLink(index: luaIndex) -> existingSocketLink?: string
```

### GetNewSocketInfo

```lua
C_ItemSocketInfo.GetNewSocketInfo(index: luaIndex) -> name?: string, icon?: fileID, gemMatchesSocket: bool
```

### GetNewSocketLink

```lua
C_ItemSocketInfo.GetNewSocketLink(index: luaIndex) -> newSocketLink?: string
```

### GetNumSockets

```lua
C_ItemSocketInfo.GetNumSockets() -> numSockets: number
```

### GetSocketItemBoundTradeable

```lua
C_ItemSocketInfo.GetSocketItemBoundTradeable() -> socketItemTradeable: bool
```

### GetSocketItemInfo

```lua
C_ItemSocketInfo.GetSocketItemInfo() -> name?: string, icon?: fileID, quality: ItemQuality
```

### GetSocketItemRefundable

```lua
C_ItemSocketInfo.GetSocketItemRefundable() -> socketItemRefundable: bool
```

### GetSocketTypes

```lua
C_ItemSocketInfo.GetSocketTypes(index: luaIndex) -> socketType?: string
```

### HasBoundGemProposed

```lua
C_ItemSocketInfo.HasBoundGemProposed() -> hasBoundGemProposed: bool
```

### IsArtifactRelicItem

```lua
C_ItemSocketInfo.IsArtifactRelicItem(info: ItemInfo) -> isArtifactRelicItem: bool
```

## Events

### SocketInfoAccept

Fires as `SOCKET_INFO_ACCEPT`.

No payload.

### SocketInfoBindConfirm

Fires as `SOCKET_INFO_BIND_CONFIRM`.

No payload.

### SocketInfoClose

Fires as `SOCKET_INFO_CLOSE`.

No payload.

### SocketInfoFailure

Fires as `SOCKET_INFO_FAILURE`.

No payload.

### SocketInfoRefundableConfirm

Fires as `SOCKET_INFO_REFUNDABLE_CONFIRM`.

No payload.

### SocketInfoSuccess

Fires as `SOCKET_INFO_SUCCESS`.

No payload.

### SocketInfoUiEventRegistrationUpdate

Fires as `SOCKET_INFO_UI_EVENT_REGISTRATION_UPDATE`.

```lua
payload: uiType: ItemSocketInfoUIType
```

### SocketInfoUpdate

Fires as `SOCKET_INFO_UPDATE`.

No payload.
