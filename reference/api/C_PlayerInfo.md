# C_PlayerInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`7` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetClass

```lua
C_PlayerInfo.GetClass(playerLocation: PlayerLocation) -> className?: cstring, classFilename?: cstring, classID?: number
```

### GetName

```lua
C_PlayerInfo.GetName(playerLocation: PlayerLocation) -> name?: string
```

### GetRace

```lua
C_PlayerInfo.GetRace(playerLocation: PlayerLocation) -> raceID?: number
```

### GetSex

```lua
C_PlayerInfo.GetSex(playerLocation: PlayerLocation) -> sex?: UnitSex
```

### GUIDIsPlayer

```lua
C_PlayerInfo.GUIDIsPlayer(guid: WOWGUID) -> isPlayer: bool
```

### IsConnected

```lua
C_PlayerInfo.IsConnected(playerLocation?: PlayerLocation) -> isConnected?: bool
```

### UnitIsSameServer

```lua
C_PlayerInfo.UnitIsSameServer(playerLocation: PlayerLocation) -> unitIsSameServer: bool
```
