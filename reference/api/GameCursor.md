# GameCursor

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`19` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearCursor

```lua
ClearCursor()
```

### ClearCursorHoveredItem

```lua
ClearCursorHoveredItem()
```

### CursorHasItem

```lua
CursorHasItem() -> result: bool
```

### CursorHasMacro

```lua
CursorHasMacro() -> result: bool
```

### CursorHasMoney

```lua
CursorHasMoney() -> result: bool
```

### CursorHasSpell

```lua
CursorHasSpell() -> result: bool
```

### DeleteCursorItem

```lua
DeleteCursorItem()
```

### DropCursorMoney

```lua
DropCursorMoney()
```

### EquipCursorItem

```lua
EquipCursorItem(slot: luaIndex)
```

### GetCursorInfo

```lua
GetCursorInfo()
```

### GetCursorMoney

```lua
GetCursorMoney() -> amount: number
```

### PickupPlayerMoney

```lua
PickupPlayerMoney(amount: WOWMONEY)
```

### ResetCursor

```lua
ResetCursor()
```

### SellCursorItem

```lua
SellCursorItem()
```

### SetCursor

```lua
SetCursor(name?: cstring) -> result: bool
```

### SetCursorByMode

```lua
SetCursorByMode(mode: Cursormode) -> result: bool
```

### SetCursorHoveredItem

```lua
SetCursorHoveredItem(item: ItemLocation)
```

### SetCursorHoveredItemTradeItem

```lua
SetCursorHoveredItemTradeItem(enabled: bool)
```

### SetCursorVirtualItem

```lua
SetCursorVirtualItem(itemInfo: ItemInfo, cursorType: UICursorType)
```
