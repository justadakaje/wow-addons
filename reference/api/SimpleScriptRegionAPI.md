# SimpleScriptRegionAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`55` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanChangeProtectedState

```lua
CanChangeProtectedState() -> canChange: bool
```

### CanPropagateMouseClicks

```lua
CanPropagateMouseClicks() -> canPropagate: bool
```

### CanPropagateMouseMotion

```lua
CanPropagateMouseMotion() -> canPropagate: bool
```

### ClearScripts

```lua
ClearScripts()
```

### CollapsesLayout

```lua
CollapsesLayout() -> collapsesLayout: bool
```

### EnableMouse

```lua
EnableMouse(enable: bool)
```

### EnableMouseMotion

```lua
EnableMouseMotion(enable: bool)
```

### EnableMouseWheel

```lua
EnableMouseWheel(enable: bool)
```

### FocusEnter

```lua
FocusEnter(fromMouseMotion: bool)
```

### FocusExit

```lua
FocusExit(fromMouseMotion: bool)
```

### GetBottom

```lua
GetBottom() -> bottom: uiUnit
```

### GetCenter

```lua
GetCenter() -> x: uiUnit, y: uiUnit
```

### GetHeight

```lua
GetHeight(ignoreRect: bool) -> height: uiUnit
```

### GetLeft

```lua
GetLeft() -> left: uiUnit
```

### GetRect

```lua
GetRect() -> left: uiUnit, bottom: uiUnit, width: uiUnit, height: uiUnit
```

### GetRight

```lua
GetRight() -> right: uiUnit
```

### GetRoundLayoutToNearestPixel

```lua
GetRoundLayoutToNearestPixel() -> enabled: bool
```

### GetScaledRect

```lua
GetScaledRect() -> left: uiUnit, bottom: uiUnit, width: uiUnit, height: uiUnit
```

### GetScript

```lua
GetScript(scriptTypeName: ScriptTypeName, bindingType: ScriptBindingType) -> script: LuaFunctionReference
```

### GetSize

```lua
GetSize(ignoreRect: bool) -> width: uiUnit, height: uiUnit
```

### GetSourceLocation

```lua
GetSourceLocation() -> location: string
```

### GetTop

```lua
GetTop() -> top: uiUnit
```

### GetWidth

```lua
GetWidth(ignoreRect: bool) -> width: uiUnit
```

### HasScript

```lua
HasScript(scriptName: cstring) -> hasScript: bool
```

### Hide

```lua
Hide()
```

### HookScript

```lua
HookScript(scriptTypeName: ScriptTypeName, script: LuaFunctionReference, bindingType: ScriptBindingType) -> success: bool
```

### Intersects

```lua
Intersects(region: ScriptRegion) -> intersects: bool
```

### IsAnchoringRestricted

```lua
IsAnchoringRestricted() -> isRestricted: bool
```

### IsAnchoringSecret

```lua
IsAnchoringSecret() -> isSecret: bool
```

### IsCollapsed

```lua
IsCollapsed() -> isCollapsed: bool
```

### IsDragging

```lua
IsDragging() -> isDragging: bool
```

### IsMouseClickEnabled

```lua
IsMouseClickEnabled() -> enabled: bool
```

### IsMouseEnabled

```lua
IsMouseEnabled() -> enabled: bool
```

### IsMouseMotionEnabled

```lua
IsMouseMotionEnabled() -> enabled: bool
```

### IsMouseMotionFocus

```lua
IsMouseMotionFocus() -> isMouseMotionFocus: bool
```

### IsMouseOver

```lua
IsMouseOver(offsetTop: uiUnit, offsetBottom: uiUnit, offsetLeft: uiUnit, offsetRight: uiUnit) -> isMouseOver: bool
```

### IsMouseWheelEnabled

```lua
IsMouseWheelEnabled() -> enabled: bool
```

### IsProtected

```lua
IsProtected() -> isProtected: bool, isProtectedExplicitly: bool
```

### IsRectValid

```lua
IsRectValid() -> isValid: bool
```

### IsShown

```lua
IsShown() -> isShown: bool
```

### IsVisible

```lua
IsVisible() -> isVisible: bool
```

### MouseDown

```lua
MouseDown(button: cstring)
```

### MouseUp

```lua
MouseUp(button: cstring)
```

### SetCollapsesLayout

```lua
SetCollapsesLayout(collapsesLayout: bool)
```

### SetMouseClickEnabled

```lua
SetMouseClickEnabled(enabled: bool)
```

### SetMouseMotionEnabled

```lua
SetMouseMotionEnabled(enabled: bool)
```

### SetParent

```lua
SetParent(parent?: SimpleFrame)
```

### SetPassThroughButtons

```lua
SetPassThroughButtons(buttons: MouseButton)
```

### SetPropagateMouseClicks

```lua
SetPropagateMouseClicks(propagate: bool)
```

### SetPropagateMouseMotion

```lua
SetPropagateMouseMotion(propagate: bool)
```

### SetRoundLayoutToNearestPixel

```lua
SetRoundLayoutToNearestPixel(enabled: bool)
```

### SetScript

```lua
SetScript(scriptTypeName: ScriptTypeName, script?: LuaFunctionReference)
```

### SetShown

```lua
SetShown(show: bool)
```

### ShouldButtonPassThrough

```lua
ShouldButtonPassThrough(button: MouseButton) -> shouldPassThrough: bool
```

### Show

```lua
Show()
```
