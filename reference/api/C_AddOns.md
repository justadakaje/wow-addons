# C_AddOns

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`29` functions - `3` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### DisableAddOn

```lua
C_AddOns.DisableAddOn(name: uiAddon, character: cstring)
```

### DisableAllAddOns

```lua
C_AddOns.DisableAllAddOns(character?: cstring)
```

### DoesAddOnExist

```lua
C_AddOns.DoesAddOnExist(name: uiAddon) -> exists: bool
```

### DoesAddOnHaveLoadError

```lua
C_AddOns.DoesAddOnHaveLoadError(name: uiAddon) -> hadError: bool
```

### EnableAddOn

```lua
C_AddOns.EnableAddOn(name: uiAddon, character: cstring)
```

### EnableAllAddOns

```lua
C_AddOns.EnableAllAddOns(character?: cstring)
```

### GetAddOnDependencies

```lua
C_AddOns.GetAddOnDependencies(name: uiAddon) -> deps: cstring
```

### GetAddOnEnableState

```lua
C_AddOns.GetAddOnEnableState(name: uiAddon, character: cstring) -> state: AddOnEnableState
```

### GetAddOnInfo

```lua
C_AddOns.GetAddOnInfo(name: uiAddon) -> name: cstring, title: cstring, notes: cstring, loadable: bool, reason: cstring, security: cstring
```

### GetAddOnInterfaceVersion

```lua
C_AddOns.GetAddOnInterfaceVersion(name: uiAddon) -> interfaceVersion: number
```

### GetAddOnLocalTable

```lua
C_AddOns.GetAddOnLocalTable(name: uiAddon) -> table: LuaValueVariant
```

### GetAddOnMetadata

```lua
C_AddOns.GetAddOnMetadata(name: uiAddon, variable: cstring) -> value: cstring
```

### GetAddOnName

```lua
C_AddOns.GetAddOnName(index: uiAddon) -> name: cstring
```

### GetAddOnNotes

```lua
C_AddOns.GetAddOnNotes(name: uiAddon) -> notes: cstring
```

### GetAddOnOptionalDependencies

```lua
C_AddOns.GetAddOnOptionalDependencies(name: uiAddon) -> deps: cstring
```

### GetAddOnSecurity

```lua
C_AddOns.GetAddOnSecurity(name: uiAddon) -> security: AddOnSecurityStatus
```

### GetAddOnTitle

```lua
C_AddOns.GetAddOnTitle(name: uiAddon) -> title: cstring
```

### GetNumAddOns

```lua
C_AddOns.GetNumAddOns() -> numAddOns: number
```

### GetScriptsDisallowedForBeta

```lua
C_AddOns.GetScriptsDisallowedForBeta() -> disallowed: bool
```

### IsAddOnDefaultEnabled

```lua
C_AddOns.IsAddOnDefaultEnabled(name: uiAddon) -> defaultEnabled: bool
```

### IsAddOnLoadable

```lua
C_AddOns.IsAddOnLoadable(name: uiAddon, character: cstring, demandLoaded: bool) -> loadable: bool, reason: cstring
```

### IsAddOnLoaded

```lua
C_AddOns.IsAddOnLoaded(name: uiAddon) -> loadedOrLoading: bool, loaded: bool
```

### IsAddOnLoadOnDemand

```lua
C_AddOns.IsAddOnLoadOnDemand(name: uiAddon) -> loadOnDemand: bool
```

### IsAddonVersionCheckEnabled

```lua
C_AddOns.IsAddonVersionCheckEnabled() -> isEnabled: bool
```

### LoadAddOn

```lua
C_AddOns.LoadAddOn(name: uiAddon) -> loaded?: bool, value?: string
```

### ResetAddOns

```lua
C_AddOns.ResetAddOns()
```

### ResetDisabledAddOns

```lua
C_AddOns.ResetDisabledAddOns()
```

### SaveAddOns

```lua
C_AddOns.SaveAddOns()
```

### SetAddonVersionCheck

```lua
C_AddOns.SetAddonVersionCheck(enabled: bool)
```

## Events

### AddonLoaded

Fires as `ADDON_LOADED`.

```lua
payload: addOnName: cstring, containsBindings: bool
```

### AddonsUnloading

Fires as `ADDONS_UNLOADING`.

```lua
payload: closingClient: bool
```

### SavedVariablesTooLarge

Fires as `SAVED_VARIABLES_TOO_LARGE`.

```lua
payload: addOnName: cstring
```
