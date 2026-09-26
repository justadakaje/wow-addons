# C_Macro

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`4` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetMacroName

```lua
C_Macro.GetMacroName(macroId: luaIndex) -> name?: cstring
```

### GetSelectedMacroIcon

```lua
C_Macro.GetSelectedMacroIcon(macroId: luaIndex) -> textureNum: fileID
```

### RunMacroText

```lua
C_Macro.RunMacroText(text: cstring, button: cstring)
```

### SetMacroExecuteLineCallback

```lua
C_Macro.SetMacroExecuteLineCallback(cb: MacroExecuteLineCallback)
```

## Events

### UpdateMacros

Fires as `UPDATE_MACROS`.

No payload.
