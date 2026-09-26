# UnitRole

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`6` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AreClassRolesSoftSuggestions

```lua
AreClassRolesSoftSuggestions() -> result: bool
```

### CanShowSetRoleButton

```lua
CanShowSetRoleButton() -> result: bool
```

### InitiateRolePoll

```lua
InitiateRolePoll() -> result: bool
```

### UnitGetAvailableRoles

```lua
UnitGetAvailableRoles(unit: UnitToken) -> tank: bool, healer: bool, dps: bool
```

### UnitSetRole

```lua
UnitSetRole(unit: UnitToken, roleStr?: cstring) -> result: bool
```

### UnitSetRoleEnum

```lua
UnitSetRoleEnum(unit: UnitToken, role?: LFGRole) -> result: bool
```

## Events

### RoleChangedInform

Fires as `ROLE_CHANGED_INFORM`.

```lua
payload: changedName: cstring, fromName: cstring, oldRole: cstring, newRole: cstring
```

### RolePollBegin

Fires as `ROLE_POLL_BEGIN`.

```lua
payload: fromName: cstring
```
