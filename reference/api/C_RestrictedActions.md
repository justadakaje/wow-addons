# C_RestrictedActions

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`4` functions - `5` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CheckAllowProtectedFunctions

```lua
C_RestrictedActions.CheckAllowProtectedFunctions(object: FrameScriptObject, silent: bool) -> protectedFunctionsAllowed: bool
```

### GetAddOnRestrictionState

```lua
C_RestrictedActions.GetAddOnRestrictionState(type: AddOnRestrictionType) -> state: AddOnRestrictionState
```

### InCombatLockdown

```lua
C_RestrictedActions.InCombatLockdown() -> inCombatLockdown: bool
```

### IsAddOnRestrictionActive

```lua
C_RestrictedActions.IsAddOnRestrictionActive(type: AddOnRestrictionType) -> active: bool
```

## Events

### AddonActionBlocked

Fires as `ADDON_ACTION_BLOCKED`.

```lua
payload: isTainted: cstring, function: cstring
```

### AddonActionForbidden

Fires as `ADDON_ACTION_FORBIDDEN`.

```lua
payload: isTainted: cstring, function: cstring
```

### AddonRestrictionStateChanged

Fires as `ADDON_RESTRICTION_STATE_CHANGED`.

```lua
payload: type: AddOnRestrictionType, state: AddOnRestrictionState
```

### MacroActionBlocked

Fires as `MACRO_ACTION_BLOCKED`.

```lua
payload: function: cstring
```

### MacroActionForbidden

Fires as `MACRO_ACTION_FORBIDDEN`.

```lua
payload: function: cstring
```
