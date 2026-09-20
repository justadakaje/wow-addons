# C_ToyBoxInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`6` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearFanfare

```lua
C_ToyBoxInfo.ClearFanfare(itemID: number)
```

### HasAnyToy

```lua
C_ToyBoxInfo.HasAnyToy() -> hasToy: bool
```

### IsToySourceValid

```lua
C_ToyBoxInfo.IsToySourceValid(source: luaIndex) -> isToySourceValid: bool
```

### IsUsingDefaultFilters

```lua
C_ToyBoxInfo.IsUsingDefaultFilters() -> isUsingDefaultFilters: bool
```

### NeedsFanfare

```lua
C_ToyBoxInfo.NeedsFanfare(itemID: number) -> needsFanfare: bool
```

### SetDefaultFilters

```lua
C_ToyBoxInfo.SetDefaultFilters()
```

## Events

### NewToyAdded

Fires as `NEW_TOY_ADDED`.

```lua
payload: itemID: number
```

### ToysUpdated

Fires as `TOYS_UPDATED`.

```lua
payload: itemID?: number, isNew?: bool, hasFanfare?: bool
```
