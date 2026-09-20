# C_HousingLayout

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`41` functions - `18` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AnyRoomsOnFloor

```lua
C_HousingLayout.AnyRoomsOnFloor(floor: number) -> anyRooms: bool
```

### CancelActiveLayoutEditing

```lua
C_HousingLayout.CancelActiveLayoutEditing()
```

### CanSetViewedFloor

```lua
C_HousingLayout.CanSetViewedFloor(floor: number) -> canSet: bool
```

### ConfirmStairChoice

```lua
C_HousingLayout.ConfirmStairChoice(choice?: HousingLayoutStairDirection)
```

### DeselectFloorplan

```lua
C_HousingLayout.DeselectFloorplan()
```

### DeselectRoomOrDoor

```lua
C_HousingLayout.DeselectRoomOrDoor()
```

### GetBaseRoomFloor

```lua
C_HousingLayout.GetBaseRoomFloor() -> floor: number
```

### GetHighestOccupiedFloorIndex

```lua
C_HousingLayout.GetHighestOccupiedFloorIndex() -> highestFloorIndex: number
```

### GetLowestOccupiedFloorIndex

```lua
C_HousingLayout.GetLowestOccupiedFloorIndex() -> lowestFloorIndex: number
```

### GetNumActiveRooms

```lua
C_HousingLayout.GetNumActiveRooms() -> numRooms: number
```

### GetRoomPlacementBudget

```lua
C_HousingLayout.GetRoomPlacementBudget() -> placementBudget?: number
```

### GetRoomPlayerIsIn

```lua
C_HousingLayout.GetRoomPlayerIsIn() -> roomGUID: WOWGUID
```

### GetSelectedBlueprintFloorplan

```lua
C_HousingLayout.GetSelectedBlueprintFloorplan() -> roomID: number, shareCode: cstring
```

### GetSelectedDoor

```lua
C_HousingLayout.GetSelectedDoor() -> selectedDoorComponentID: number, roomGUID: WOWGUID
```

### GetSelectedFloorplan

```lua
C_HousingLayout.GetSelectedFloorplan() -> roomID?: number
```

### GetSelectedRoom

```lua
C_HousingLayout.GetSelectedRoom() -> roomGUID: WOWGUID
```

### GetSelectedStairwellRoomCount

```lua
C_HousingLayout.GetSelectedStairwellRoomCount() -> stairwellRoomCount: number
```

### GetSpentPlacementBudget

```lua
C_HousingLayout.GetSpentPlacementBudget() -> spentPlacementBudget?: number
```

### GetViewedFloor

```lua
C_HousingLayout.GetViewedFloor() -> floor: number
```

### HasAnySelections

```lua
C_HousingLayout.HasAnySelections() -> hasAnySelections: bool
```

### HasRoomPlacementBudget

```lua
C_HousingLayout.HasRoomPlacementBudget() -> hasBudget: bool
```

### HasSelectedBlueprintFloorplan

```lua
C_HousingLayout.HasSelectedBlueprintFloorplan() -> hasSelectedBlueprintFloorplan: bool
```

### HasSelectedDoor

```lua
C_HousingLayout.HasSelectedDoor() -> hasSelectedDoor: bool
```

### HasSelectedFloorplan

```lua
C_HousingLayout.HasSelectedFloorplan() -> hasSelectedFloorplan: bool
```

### HasSelectedRoom

```lua
C_HousingLayout.HasSelectedRoom() -> hasSelectedRoom: bool
```

### HasStairs

```lua
C_HousingLayout.HasStairs(roomRecordID: number) -> hasStairs: bool
```

### HasValidConnection

```lua
C_HousingLayout.HasValidConnection(roomGUID: WOWGUID, componentID: number, roomId: number) -> canPlace: bool
```

### IsBaseRoom

```lua
C_HousingLayout.IsBaseRoom(roomGUID: WOWGUID) -> isBaseRoom: bool
```

### IsDraggingRoom

```lua
C_HousingLayout.IsDraggingRoom() -> isDragging: bool, isAccessibleDrag: bool
```

### MoveDraggedRoom

```lua
C_HousingLayout.MoveDraggedRoom(sourceDoorIndex: number, destRoom: WOWGUID, destDoorIndex: number)
```

### MoveLayoutCamera

```lua
C_HousingLayout.MoveLayoutCamera(direction: HousingLayoutCameraDirection, isPressed: bool)
```

### RemoveRoom

```lua
C_HousingLayout.RemoveRoom(roomGUID: WOWGUID)
```

### RoomHasStairs

```lua
C_HousingLayout.RoomHasStairs(roomGUID: WOWGUID) -> hasStairs: bool
```

### RotateFocusedRoom

```lua
C_HousingLayout.RotateFocusedRoom(isLeft: bool)
```

### RotateRoom

```lua
C_HousingLayout.RotateRoom(roomGUID: WOWGUID, isLeft: bool)
```

### SelectFloorplan

```lua
C_HousingLayout.SelectFloorplan(roomID: number)
```

### SetViewedFloor

```lua
C_HousingLayout.SetViewedFloor(floor: number)
```

### StartDrag

```lua
C_HousingLayout.StartDrag()
```

### StopDrag

```lua
C_HousingLayout.StopDrag()
```

### StopDraggingRoom

```lua
C_HousingLayout.StopDraggingRoom()
```

### ZoomLayoutCamera

```lua
C_HousingLayout.ZoomLayoutCamera(zoomIn: bool) -> zoomChanged: bool
```

## Events

### HousingLayoutDoorSelected

Fires as `HOUSING_LAYOUT_DOOR_SELECTED`.

```lua
payload: roomGUID: WOWGUID, componentID: number
```

### HousingLayoutDoorSelectionChanged

Fires as `HOUSING_LAYOUT_DOOR_SELECTION_CHANGED`.

```lua
payload: hasSelection: bool
```

### HousingLayoutDragTargetChanged

Fires as `HOUSING_LAYOUT_DRAG_TARGET_CHANGED`.

```lua
payload: isDraggingRoom: bool
```

### HousingLayoutFloorplanSelectionChanged

Fires as `HOUSING_LAYOUT_FLOORPLAN_SELECTION_CHANGED`.

```lua
payload: hasSelection: bool, roomID: number, blueprintShareCode?: cstring
```

### HousingLayoutOccupiedFloorRangeChanged

Fires as `HOUSING_LAYOUT_OCCUPIED_FLOOR_RANGE_CHANGED`.

```lua
payload: lowestFloor: number, highestFloor: number
```

### HousingLayoutPinFrameAdded

Fires as `HOUSING_LAYOUT_PIN_FRAME_ADDED`.

```lua
payload: pinFrame: HousingLayoutPinFrame
```

### HousingLayoutPinFrameReleased

Fires as `HOUSING_LAYOUT_PIN_FRAME_RELEASED`.

```lua
payload: pinFrame: HousingLayoutPinFrame
```

### HousingLayoutPinFramesReleased

Fires as `HOUSING_LAYOUT_PIN_FRAMES_RELEASED`.

No payload.

### HousingLayoutRoomComponentThemeSetChanged

Fires as `HOUSING_LAYOUT_ROOM_COMPONENT_THEME_SET_CHANGED`.

```lua
payload: roomGUID: WOWGUID, componentID: number, newThemeSet: number, result: HousingResult
```

### HousingLayoutRoomMoved

Fires as `HOUSING_LAYOUT_ROOM_MOVED`.

No payload.

### HousingLayoutRoomMoveInvalid

Fires as `HOUSING_LAYOUT_ROOM_MOVE_INVALID`.

No payload.

### HousingLayoutRoomReceived

Fires as `HOUSING_LAYOUT_ROOM_RECEIVED`.

```lua
payload: playAddedSound: bool
```

### HousingLayoutRoomRemoved

Fires as `HOUSING_LAYOUT_ROOM_REMOVED`.

No payload.

### HousingLayoutRoomReturned

Fires as `HOUSING_LAYOUT_ROOM_RETURNED`.

No payload.

### HousingLayoutRoomSelectionChanged

Fires as `HOUSING_LAYOUT_ROOM_SELECTION_CHANGED`.

```lua
payload: hasSelection: bool
```

### HousingLayoutRoomSnapped

Fires as `HOUSING_LAYOUT_ROOM_SNAPPED`.

No payload.

### HousingLayoutViewedFloorChanged

Fires as `HOUSING_LAYOUT_VIEWED_FLOOR_CHANGED`.

```lua
payload: floor: number
```

### ShowStairDirectionConfirmation

Fires as `SHOW_STAIR_DIRECTION_CONFIRMATION`.

No payload.
