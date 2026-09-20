# SimpleFrameScriptObjectAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`21` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddAccessRestrictions

```lua
AddAccessRestrictions(restrictions: ScriptObjectAccessRestriction)
```

### AddForbiddenAspects

```lua
AddForbiddenAspects(aspects: ForbiddenAspect)
```

### AddSecretAspect

```lua
AddSecretAspect(aspect: SecretAspect)
```

### CanBeAccessedInContext

```lua
CanBeAccessedInContext() -> canAccess: bool
```

### GetAccessRestrictions

```lua
GetAccessRestrictions() -> restrictions: ScriptObjectAccessRestriction
```

### GetForbiddenAspects

```lua
GetForbiddenAspects() -> aspects: ForbiddenAspect
```

### GetInheritableForbiddenAspects

```lua
GetInheritableForbiddenAspects(path: ScriptObjectPropagationPath) -> aspects: ForbiddenAspect
```

### GetName

```lua
GetName() -> name: cstring
```

### GetObjectTable

```lua
GetObjectTable() -> objectTable: FrameScriptObject
```

### GetObjectType

```lua
GetObjectType() -> objectType: cstring
```

### HasAccessConstraints

```lua
HasAccessConstraints() -> hasAccessConstraints: bool
```

### HasAnyAccessRestrictions

```lua
HasAnyAccessRestrictions(restrictions?: ScriptObjectAccessRestriction) -> hasAnyAccessRestriction: bool
```

### HasAnyForbiddenAspects

```lua
HasAnyForbiddenAspects(aspects?: ForbiddenAspect) -> hasAnyForbiddenAspect: bool
```

### HasAnySecretAspect

```lua
HasAnySecretAspect() -> hasSecretAspect: bool
```

### HasSecretAspect

```lua
HasSecretAspect(aspect: SecretAspect) -> hasSecretAspect: bool
```

### HasSecretValues

```lua
HasSecretValues() -> hasSecretValues: bool
```

### IsForbidden

```lua
IsForbidden() -> isForbidden: bool
```

### IsObjectType

```lua
IsObjectType(objectType: cstring) -> isType: bool
```

### IsPreventingSecretValues

```lua
IsPreventingSecretValues() -> isPreventingSecretValues: bool
```

### SetForbidden

```lua
SetForbidden()
```

### SetToDefaults

```lua
SetToDefaults()
```
