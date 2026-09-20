# FrameAPIUnitPositionFrame

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`12` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddUnit

```lua
AddUnit(unitTokenString: cstring, asset: TextureAssetDisk, width?: uiUnit, height?: uiUnit, r?: number, g?: number, b?: number, a?: number, sublayer?: number, showFacing?: bool)
```

### ClearUnits

```lua
ClearUnits()
```

### FinalizeUnits

```lua
FinalizeUnits()
```

### GetMouseOverUnits

```lua
GetMouseOverUnits() -> units: UnitTokenType
```

### GetPlayerPingScale

```lua
GetPlayerPingScale() -> scale: number
```

### GetUiMapID

```lua
GetUiMapID() -> mapID: number
```

### SetPlayerPingScale

```lua
SetPlayerPingScale(scale: number)
```

### SetPlayerPingTexture

```lua
SetPlayerPingTexture(textureType: PingTextureType, asset: FileAsset, width: uiUnit, height: uiUnit)
```

### SetUiMapID

```lua
SetUiMapID(mapID: number)
```

### SetUnitColor

```lua
SetUnitColor(unit: UnitTokenType, colorR: number, colorG: number, colorB: number, colorA: number)
```

### StartPlayerPing

```lua
StartPlayerPing(duration: number, fadeDuration: number)
```

### StopPlayerPing

```lua
StopPlayerPing()
```
