# HousingLayoutPinFrameAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`17` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanMove

```lua
CanMove() -> moveRestriction: HousingLayoutRestriction
```

### CanRemove

```lua
CanRemove() -> removalRestriction: HousingLayoutRestriction
```

### CanRotate

```lua
CanRotate() -> rotateRestriction: HousingLayoutRestriction
```

### Drag

```lua
Drag(isAccessible: bool)
```

### GetDoorConnectionInfo

```lua
GetDoorConnectionInfo() -> connectionInfo?: DoorConnectionInfo
```

### GetPinType

```lua
GetPinType() -> type: HousingLayoutPinType
```

### GetRoomGUID

```lua
GetRoomGUID() -> roomGUID: WOWGUID
```

### GetRoomName

```lua
GetRoomName() -> name?: cstring
```

### IsAnyPartOfRoomSelected

```lua
IsAnyPartOfRoomSelected() -> isSelected: bool
```

### IsConnectedToDraggingRoom

```lua
IsConnectedToDraggingRoom() -> isConnectedToDraggingRoom: bool
```

### IsOccupiedDoor

```lua
IsOccupiedDoor() -> isOccupied?: bool
```

### IsPartOfDraggingRoom

```lua
IsPartOfDraggingRoom() -> isPartOfDraggingRoom: bool
```

### IsSelected

```lua
IsSelected() -> isSelected: bool
```

### IsValid

```lua
IsValid() -> isValid: bool
```

### IsValidForSelectedFloorplan

```lua
IsValidForSelectedFloorplan() -> isValid: bool
```

### Select

```lua
Select()
```

### SetUpdateCallback

```lua
SetUpdateCallback(cb: PinUpdatedCallback)
```
