# C_EditMode

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`12` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ConvertLayoutInfoToString

```lua
C_EditMode.ConvertLayoutInfoToString(layoutInfo: EditModeLayoutInfo) -> layoutInfoAsString: string
```

### ConvertStringToLayoutInfo

```lua
C_EditMode.ConvertStringToLayoutInfo(layoutInfoAsString: string) -> layoutInfo: EditModeLayoutInfo
```

### GetAccountSettings

```lua
C_EditMode.GetAccountSettings() -> accountSettings: table
```

### GetEditModeDefaultLayout

```lua
C_EditMode.GetEditModeDefaultLayout() -> defaultLayout: number
```

### GetLayouts

```lua
C_EditMode.GetLayouts() -> layoutInfo: EditModeLayouts
```

### IsValidLayoutName

```lua
C_EditMode.IsValidLayoutName(name: cstring) -> isApproved: bool
```

### OnEditModeExit

```lua
C_EditMode.OnEditModeExit()
```

### OnLayoutAdded

```lua
C_EditMode.OnLayoutAdded(addedLayoutIndex: luaIndex, activateNewLayout: bool, isLayoutImported: bool)
```

### OnLayoutDeleted

```lua
C_EditMode.OnLayoutDeleted(deletedLayoutIndex: luaIndex)
```

### SaveLayouts

```lua
C_EditMode.SaveLayouts(saveInfo: EditModeLayouts)
```

### SetAccountSetting

```lua
C_EditMode.SetAccountSetting(setting: EditModeAccountSetting, value: number)
```

### SetActiveLayout

```lua
C_EditMode.SetActiveLayout(activeLayout: luaIndex)
```

## Events

### EditModeLayoutsUpdated

Fires as `EDIT_MODE_LAYOUTS_UPDATED`.

```lua
payload: layoutInfo: EditModeLayouts, reconcileLayouts: bool
```
