# SimpleFrameAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`126` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AbortDrag

```lua
AbortDrag()
```

### AddRoleset

```lua
AddRoleset(roleset: string)
```

### CanChangeAttribute

```lua
CanChangeAttribute() -> canChangeAttributes: bool
```

### ClearAlphaGradient

```lua
ClearAlphaGradient()
```

### ClearAttribute

```lua
ClearAttribute(attributeName: cstring) -> cleared: bool
```

### ClearAttributes

```lua
ClearAttributes()
```

### CreateFontString

```lua
CreateFontString(name?: cstring, drawLayer?: DrawLayer, templateName?: cstring) -> line: SimpleFontString
```

### CreateLine

```lua
CreateLine(name?: cstring, drawLayer?: DrawLayer, templateName?: cstring, subLevel?: number) -> line: SimpleLine
```

### CreateMaskTexture

```lua
CreateMaskTexture(name?: cstring, drawLayer?: DrawLayer, templateName?: cstring, subLevel?: number) -> maskTexture: SimpleMaskTexture
```

### CreateTexture

```lua
CreateTexture(name?: cstring, drawLayer?: DrawLayer, templateName?: cstring, subLevel?: number) -> texture: SimpleTexture
```

### CreateVectorGraphics

```lua
CreateVectorGraphics(name?: cstring, drawLayer?: DrawLayer, templateName?: cstring, subLevel?: number) -> vectorGraphics: SimpleVectorGraphics
```

### DesaturateHierarchy

```lua
DesaturateHierarchy(desaturation: number, excludeRoot: bool)
```

### DisableDrawLayer

```lua
DisableDrawLayer(layer: DrawLayer)
```

### DoesClipChildren

```lua
DoesClipChildren() -> clipsChildren: bool
```

### DoesHyperlinkPropagateToParent

```lua
DoesHyperlinkPropagateToParent() -> canPropagate: bool
```

### EnableDrawLayer

```lua
EnableDrawLayer(layer: DrawLayer)
```

### EnableGamePadButton

```lua
EnableGamePadButton(enable: bool)
```

### EnableGamePadStick

```lua
EnableGamePadStick(enable: bool)
```

### EnableKeyboard

```lua
EnableKeyboard(enable: bool)
```

### ExecuteAttribute

```lua
ExecuteAttribute(attributeName: cstring, arguments?: cstring) -> success: bool, returns?: cstring
```

### GetAlpha

```lua
GetAlpha() -> alpha: SingleColorValue
```

### GetAttribute

```lua
GetAttribute(attributeName: cstring) -> value: cstring
```

### GetBoundsRect

```lua
GetBoundsRect() -> left: uiUnit, bottom: uiUnit, width: uiUnit, height: uiUnit
```

### GetChildren

```lua
GetChildren() -> children: SimpleFrame
```

### GetClampRectInsets

```lua
GetClampRectInsets() -> left: uiUnit, right: uiUnit, top: uiUnit, bottom: uiUnit
```

### GetDontSavePosition

```lua
GetDontSavePosition() -> dontSave: bool
```

### GetEffectiveAlpha

```lua
GetEffectiveAlpha() -> effectiveAlpha: SingleColorValue
```

### GetEffectivelyFlattensRenderLayers

```lua
GetEffectivelyFlattensRenderLayers() -> flatten: bool
```

### GetEffectiveScale

```lua
GetEffectiveScale() -> effectiveScale: number
```

### GetFlattensRenderLayers

```lua
GetFlattensRenderLayers() -> flatten: bool
```

### GetFrameLevel

```lua
GetFrameLevel() -> frameLevel: number
```

### GetFrameStrata

```lua
GetFrameStrata() -> strata: FrameStrata
```

### GetHighestFrameLevel

```lua
GetHighestFrameLevel(iterateAllChildren: bool) -> frameLevel: number
```

### GetHitRectInsets

```lua
GetHitRectInsets() -> left: uiUnit, right: uiUnit, top: uiUnit, bottom: uiUnit
```

### GetHyperlinksEnabled

```lua
GetHyperlinksEnabled() -> enabled: bool
```

### GetID

```lua
GetID() -> id: number
```

### GetNumChildren

```lua
GetNumChildren() -> numChildren: number
```

### GetNumRegions

```lua
GetNumRegions() -> numRegions: number
```

### GetOnUpdateMode

```lua
GetOnUpdateMode() -> onUpdateMode: OnUpdateMode
```

### GetPropagateKeyboardInput

```lua
GetPropagateKeyboardInput() -> propagate: bool
```

### GetRaisedFrameLevel

```lua
GetRaisedFrameLevel() -> frameLevel: number
```

### GetRegions

```lua
GetRegions() -> regions: SimpleRegion
```

### GetResizeBounds

```lua
GetResizeBounds() -> minWidth: uiUnit, minHeight: uiUnit, maxWidth: uiUnit, maxHeight: uiUnit
```

### GetRolesetNames

```lua
GetRolesetNames() -> rolesets: table
```

### GetScale

```lua
GetScale() -> frameScale: number
```

### GetWindow

```lua
GetWindow() -> window: SimpleWindow
```

### HasAlphaGradient

```lua
HasAlphaGradient() -> hasAlphaGradient: bool
```

### HasFixedFrameLevel

```lua
HasFixedFrameLevel() -> isFixed: bool
```

### HasFixedFrameStrata

```lua
HasFixedFrameStrata() -> isFixed: bool
```

### Hide

```lua
Hide()
```

### InterceptStartDrag

```lua
InterceptStartDrag(delegate: SimpleFrame) -> success: bool
```

### IsClampedToScreen

```lua
IsClampedToScreen() -> clampedToScreen: bool
```

### IsDrawLayerEnabled

```lua
IsDrawLayerEnabled(layer: DrawLayer) -> isEnabled: bool
```

### IsEventRegistered

```lua
IsEventRegistered(eventName: cstring) -> isRegistered: bool, units?: UnitTokenType
```

### IsFrameBuffer

```lua
IsFrameBuffer() -> isFrameBuffer: bool
```

### IsGamePadButtonEnabled

```lua
IsGamePadButtonEnabled() -> enabled: bool
```

### IsGamePadStickEnabled

```lua
IsGamePadStickEnabled() -> enabled: bool
```

### IsHighlightLocked

```lua
IsHighlightLocked() -> locked: bool
```

### IsIgnoringChildrenForBounds

```lua
IsIgnoringChildrenForBounds() -> ignore: bool
```

### IsIgnoringParentAlpha

```lua
IsIgnoringParentAlpha() -> ignore: bool
```

### IsIgnoringParentScale

```lua
IsIgnoringParentScale() -> ignore: bool
```

### IsKeyboardEnabled

```lua
IsKeyboardEnabled() -> enabled: bool
```

### IsMovable

```lua
IsMovable() -> isMovable: bool
```

### IsObjectLoaded

```lua
IsObjectLoaded() -> isLoaded: bool
```

### IsResizable

```lua
IsResizable() -> resizable: bool
```

### IsRolesetFiltered

```lua
IsRolesetFiltered() -> isRolesetFiltered: bool
```

### IsShown

```lua
IsShown() -> isShown: bool
```

### IsToplevel

```lua
IsToplevel() -> isTopLevel: bool
```

### IsUserPlaced

```lua
IsUserPlaced() -> isUserPlaced: bool
```

### IsUsingParentLevel

```lua
IsUsingParentLevel() -> usingParentLevel: bool
```

### IsVisible

```lua
IsVisible() -> isVisible: bool
```

### LockHighlight

```lua
LockHighlight()
```

### Lower

```lua
Lower()
```

### Raise

```lua
Raise()
```

### RegisterAllEvents

```lua
RegisterAllEvents()
```

### RegisterEvent

```lua
RegisterEvent(eventName: cstring) -> registered: bool
```

### RegisterEventCallback

```lua
RegisterEventCallback(eventName: cstring, cb: FrameEventCallbackType) -> registered: bool
```

### RegisterForDrag

```lua
RegisterForDrag(buttons: MouseButton)
```

### RegisterUnitEvent

```lua
RegisterUnitEvent(eventName: cstring, units: UnitTokenType) -> registered: bool
```

### RegisterUnitEventCallback

```lua
RegisterUnitEventCallback(eventName: cstring, cb: FrameEventCallbackType, units: UnitTokenType) -> registered: bool
```

### RemoveRoleset

```lua
RemoveRoleset(roleset: string)
```

### ResizeToBoundsRect

```lua
ResizeToBoundsRect()
```

### RotateTextures

```lua
RotateTextures(radians: number, x: number, y: number)
```

### SetAlpha

```lua
SetAlpha(alpha: SingleColorValue)
```

### SetAlphaFromBoolean

```lua
SetAlphaFromBoolean(value: bool, alphaIfTrue: SingleColorValue, alphaIfFalse: SingleColorValue)
```

### SetAlphaGradient

```lua
SetAlphaGradient(index: number, gradient: vector2)
```

### SetAttribute

```lua
SetAttribute(attributeName: cstring, value: cstring)
```

### SetAttributeNoHandler

```lua
SetAttributeNoHandler(attributeName: cstring, value: cstring)
```

### SetClampedToScreen

```lua
SetClampedToScreen(clampedToScreen: bool)
```

### SetClampRectInsets

```lua
SetClampRectInsets(left: uiUnit, right: uiUnit, top: uiUnit, bottom: uiUnit)
```

### SetClipsChildren

```lua
SetClipsChildren(clipsChildren: bool)
```

### SetDontSavePosition

```lua
SetDontSavePosition(dontSave: bool)
```

### SetDrawLayerEnabled

```lua
SetDrawLayerEnabled(layer: DrawLayer, isEnabled: bool)
```

### SetFixedFrameLevel

```lua
SetFixedFrameLevel(isFixed: bool)
```

### SetFixedFrameStrata

```lua
SetFixedFrameStrata(isFixed: bool)
```

### SetFlattensRenderLayers

```lua
SetFlattensRenderLayers(flatten: bool)
```

### SetFrameLevel

```lua
SetFrameLevel(frameLevel: number)
```

### SetFrameStrata

```lua
SetFrameStrata(strata: FrameStrata)
```

### SetHighlightLocked

```lua
SetHighlightLocked(locked: bool)
```

### SetHitRectInsets

```lua
SetHitRectInsets(left: uiUnit, right: uiUnit, top: uiUnit, bottom: uiUnit)
```

### SetHyperlinkPropagateToParent

```lua
SetHyperlinkPropagateToParent(canPropagate: bool)
```

### SetHyperlinksEnabled

```lua
SetHyperlinksEnabled(enabled: bool)
```

### SetID

```lua
SetID(id: number)
```

### SetIgnoreParentAlpha

```lua
SetIgnoreParentAlpha(ignore: bool)
```

### SetIgnoreParentScale

```lua
SetIgnoreParentScale(ignore: bool)
```

### SetIgnoringChildrenForBounds

```lua
SetIgnoringChildrenForBounds(ignore: bool)
```

### SetIsFrameBuffer

```lua
SetIsFrameBuffer(isFrameBuffer: bool)
```

### SetMovable

```lua
SetMovable(movable: bool)
```

### SetOnUpdateMode

```lua
SetOnUpdateMode(onUpdateMode: OnUpdateMode)
```

### SetPropagateKeyboardInput

```lua
SetPropagateKeyboardInput(propagate: bool)
```

### SetResizable

```lua
SetResizable(resizable: bool)
```

### SetResizeBounds

```lua
SetResizeBounds(minWidth: uiUnit, minHeight: uiUnit, maxWidth?: uiUnit, maxHeight?: uiUnit)
```

### SetRolesets

```lua
SetRolesets(rolesetsString?: cstring)
```

### SetScale

```lua
SetScale(scale: number)
```

### SetShown

```lua
SetShown(shown: bool)
```

### SetToplevel

```lua
SetToplevel(topLevel: bool)
```

### SetUserPlaced

```lua
SetUserPlaced(userPlaced: bool)
```

### SetUsingParentLevel

```lua
SetUsingParentLevel(usingParentLevel: bool)
```

### SetWindow

```lua
SetWindow(window?: SimpleWindow)
```

### Show

```lua
Show()
```

### StartMoving

```lua
StartMoving(alwaysStartFromMouse: bool)
```

### StartSizing

```lua
StartSizing(resizePoint?: FramePoint, alwaysStartFromMouse: bool)
```

### StopMovingOrSizing

```lua
StopMovingOrSizing()
```

### UnlockHighlight

```lua
UnlockHighlight()
```

### UnregisterAllEvents

```lua
UnregisterAllEvents()
```

### UnregisterEvent

```lua
UnregisterEvent(eventName: cstring) -> registered: bool
```
