# Totem

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`7` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### DestroyTotem

```lua
DestroyTotem(slot: luaIndex)
```

### GetNumTotemSlots

```lua
GetNumTotemSlots() -> numSlots: number
```

### GetTotemCannotDismiss

```lua
GetTotemCannotDismiss(slot: luaIndex) -> cannotDismiss?: bool
```

### GetTotemDuration

```lua
GetTotemDuration(slot: luaIndex) -> duration: LuaDurationObject
```

### GetTotemInfo

```lua
GetTotemInfo(slot: luaIndex) -> haveTotem: bool, totemName: cstring, startTime: number, duration: number, icon: fileID, modRate: number, spellID: number
```

### GetTotemTimeLeft

```lua
GetTotemTimeLeft(slot: luaIndex) -> timeLeft?: number
```

### TargetTotem

```lua
TargetTotem(slot: luaIndex)
```
