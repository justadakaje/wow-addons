# C_KeyBindings

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`11` functions - `4` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ActivateBindingContext

```lua
C_KeyBindings.ActivateBindingContext(newContext: BindingContext)
```

### DeactivateBindingContext

```lua
C_KeyBindings.DeactivateBindingContext(context: BindingContext)
```

### GetBindingByKey

```lua
C_KeyBindings.GetBindingByKey(action: cstring, context?: BindingContext) -> binding: cstring
```

### GetBindingContextForAction

```lua
C_KeyBindings.GetBindingContextForAction(action: cstring) -> context?: BindingContext
```

### GetBindingIndex

```lua
C_KeyBindings.GetBindingIndex(action: cstring) -> bindingIndex?: luaIndex
```

### GetCustomBindingType

```lua
C_KeyBindings.GetCustomBindingType(bindingIndex: luaIndex) -> customBindingType?: CustomBindingType
```

### GetSearchTagsForAction

```lua
C_KeyBindings.GetSearchTagsForAction(action: cstring) -> searchTags?: table
```

### GetTurnStrafeStyle

```lua
C_KeyBindings.GetTurnStrafeStyle() -> style: TurnStrafeStyle
```

### IsBindingContextActive

```lua
C_KeyBindings.IsBindingContextActive(context: BindingContext) -> isActive: bool
```

### SetTurnStrafeStyle

```lua
C_KeyBindings.SetTurnStrafeStyle(style: TurnStrafeStyle)
```

### UpdateTurnStrafeBindingsForCharacter

```lua
C_KeyBindings.UpdateTurnStrafeBindingsForCharacter()
```

## Events

### BindingsLoaded

Fires as `BINDINGS_LOADED`.

No payload.

### ModifierStateChanged

Fires as `MODIFIER_STATE_CHANGED`.

```lua
payload: key: cstring, down: number
```

### NotifyTurnStrafeChange

Fires as `NOTIFY_TURN_STRAFE_CHANGE`.

No payload.

### UpdateBindings

Fires as `UPDATE_BINDINGS`.

No payload.
