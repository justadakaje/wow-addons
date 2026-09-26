# C_Cursor

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`1` functions - `4` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetCursorItem

```lua
C_Cursor.GetCursorItem() -> item: ItemLocation
```

## Events

### BattlePetCursorClear

Fires as `BATTLE_PET_CURSOR_CLEAR`.

No payload.

### CursorChanged

Fires as `CURSOR_CHANGED`.

```lua
payload: isDefault: bool, newCursorType: UICursorType, oldCursorType: UICursorType, oldCursorVirtualID: number
```

### MountCursorClear

Fires as `MOUNT_CURSOR_CLEAR`.

No payload.

### WorldCursorTooltipUpdate

Fires as `WORLD_CURSOR_TOOLTIP_UPDATE`.

```lua
payload: anchorType: WorldCursorAnchorType
```
