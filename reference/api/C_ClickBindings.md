# C_ClickBindings

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`9` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanSpellBeClickBound

```lua
C_ClickBindings.CanSpellBeClickBound(spellID: SpellIdentifier) -> canBeBound: bool
```

### ExecuteBinding

```lua
C_ClickBindings.ExecuteBinding(targetToken: cstring, button: cstring, modifiers: number)
```

### GetBindingType

```lua
C_ClickBindings.GetBindingType(button: cstring, modifiers: number) -> type: ClickBindingType
```

### GetEffectiveInteractionButton

```lua
C_ClickBindings.GetEffectiveInteractionButton(button: cstring, modifiers: number) -> effectiveButton: cstring
```

### GetProfileInfo

```lua
C_ClickBindings.GetProfileInfo() -> infoVec: table
```

### GetTutorialShown

```lua
C_ClickBindings.GetTutorialShown() -> tutorialShown: bool
```

### ResetCurrentProfile

```lua
C_ClickBindings.ResetCurrentProfile()
```

### SetProfileByInfo

```lua
C_ClickBindings.SetProfileByInfo(infoVec: table)
```

### SetTutorialShown

```lua
C_ClickBindings.SetTutorialShown()
```

## Events

### ClickbindingsSetHighlightsShown

Fires as `CLICKBINDINGS_SET_HIGHLIGHTS_SHOWN`.

```lua
payload: showHighlights: bool
```
