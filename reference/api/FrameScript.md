# FrameScript

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`38` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddSourceLocationExclude

```lua
AddSourceLocationExclude(fileName: cstring)
```

### canaccessallvalues

```lua
canaccessallvalues(values: LuaValueReference) -> canAccessAllValues: bool
```

### canaccesssecrets

```lua
canaccesssecrets() -> canAccessSecrets: bool
```

### canaccesstable

```lua
canaccesstable(table: LuaValueReference) -> canAccessTable: bool
```

### canaccessvalue

```lua
canaccessvalue(value: LuaValueReference) -> canAccessValue: bool
```

### CreateFrameWithOptions

```lua
CreateFrameWithOptions(options: CreateFrameOptions) -> frame: SimpleFrame
```

### CreateFromMixins

```lua
CreateFromMixins(mixins: LuaValueVariant) -> object: LuaValueVariant
```

### CreateSecureDelegate

```lua
CreateSecureDelegate(luaFunction: LuaValueReference, options?: SecureDelegateOptions) -> secureDelegateFunction: LuaValueReference
```

### CreateWindow

```lua
CreateWindow(popupStyle: bool, topMost: bool) -> window?: SimpleWindow
```

### debugprofilestart

```lua
debugprofilestart()
```

### debugprofilestop

```lua
debugprofilestop() -> elapsedMilliseconds: number
```

### dropsecretaccess

```lua
dropsecretaccess()
```

### dumpobject

```lua
dumpobject(value?: LuaValueReference) -> result?: LuaValueReference
```

### GetCallstackHeight

```lua
GetCallstackHeight() -> height: number
```

### GetCurrentEventID

```lua
GetCurrentEventID() -> eventID?: number
```

### GetErrorCallstackHeight

```lua
GetErrorCallstackHeight() -> height?: number
```

### GetEventTime

```lua
GetEventTime(eventProfileIndex: number) -> totalElapsedTime: number, numExecutedHandlers: number, slowestHandlerName: cstring, slowestHandlerTime: number
```

### GetForbiddenObjectTable

```lua
GetForbiddenObjectTable(object: FrameScriptObject) -> forbiddenTable: FrameScriptObject
```

### GetScriptBucketThrottleLimits

```lua
GetScriptBucketThrottleLimits() -> limits: ScriptBucketThrottleLimits
```

### GetSourceLocation

```lua
GetSourceLocation() -> location: string
```

### hasanysecretvalues

```lua
hasanysecretvalues(values: LuaValueReference) -> isAnyValueSecret: bool
```

### issecrettable

```lua
issecrettable(table: LuaValueReference) -> isSecretOrContentsSecret: bool
```

### issecretvalue

```lua
issecretvalue(value: LuaValueReference) -> isSecret: bool
```

### mapvalues

```lua
mapvalues(func: LuaValueReference, values: LuaValueReference) -> mapped: LuaValueReference
```

### Mixin

```lua
Mixin(object: LuaValueVariant, mixins: LuaValueVariant) -> outObject: LuaValueVariant
```

### RegisterEventCallback

```lua
RegisterEventCallback(eventName: cstring, callback: EventCallbackType)
```

### RegisterUnitEventCallback

```lua
RegisterUnitEventCallback(eventName: cstring, callback: EventCallbackType, unit: UnitToken)
```

### RunScript

```lua
RunScript(text: cstring)
```

### scrub

```lua
scrub(values: LuaValueReference) -> scrubbed: LuaValueReference
```

### scrubsecretvalues

```lua
scrubsecretvalues(values: LuaValueReference) -> scrubbed: LuaValueReference
```

### secretunwrap

```lua
secretunwrap(values: LuaValueReference) -> unwrapped: LuaValueReference
```

### secretwrap

```lua
secretwrap(values: LuaValueReference) -> wrapped: LuaValueReference
```

### securecallmethod

```lua
securecallmethod(object: LuaValueReference, method: cstring, arguments: LuaValueReference) -> results: LuaValueReference
```

### securecopy

```lua
securecopy(value?: LuaValueReference, options?: SecureCopyOptions) -> copy: LuaValueReference
```

### SetErrorCallstackHeight

```lua
SetErrorCallstackHeight(height?: number)
```

### settablesecurity

```lua
settablesecurity(table: LuaValueVariant, option: TableSecurityOption)
```

### UnregisterEventCallback

```lua
UnregisterEventCallback(eventName: cstring, callback: EventCallbackType)
```

### UnregisterUnitEventCallback

```lua
UnregisterUnitEventCallback(eventName: cstring, callback: EventCallbackType, unit: UnitToken)
```
