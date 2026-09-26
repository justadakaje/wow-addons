# C_CVar

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`12` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AreCVarsLoaded

```lua
C_CVar.AreCVarsLoaded() -> loaded: bool
```

### GetCVar

```lua
C_CVar.GetCVar(name: cstring) -> value?: string
```

### GetCVarBitfield

```lua
C_CVar.GetCVarBitfield(name: cstring, index: luaIndex) -> value?: bool
```

### GetCVarBool

```lua
C_CVar.GetCVarBool(name: cstring) -> value?: bool
```

### GetCVarDefault

```lua
C_CVar.GetCVarDefault(name: cstring) -> defaultValue?: string
```

### GetCVarInfo

```lua
C_CVar.GetCVarInfo(name: cstring) -> value: cstring, defaultValue: cstring, isStoredServerAccount: bool, isStoredServerCharacter: bool, isLockedFromUser: bool, isSecure: bool, isReadOnly: bool
```

### RegisterCVar

```lua
C_CVar.RegisterCVar(name: cstring, value?: cstring)
```

### RemoveTempCVar

```lua
C_CVar.RemoveTempCVar(name: cstring)
```

### ResetTestCVars

```lua
C_CVar.ResetTestCVars()
```

### SetCVar

```lua
C_CVar.SetCVar(name: cstring, value?: cstring) -> success: bool
```

### SetCVarBitfield

```lua
C_CVar.SetCVarBitfield(name: cstring, index: luaIndex, value: bool) -> success: bool
```

### SetTempCVar

```lua
C_CVar.SetTempCVar(name: cstring, value?: cstring)
```
