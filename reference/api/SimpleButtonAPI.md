# SimpleButtonAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`42` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearDisabledTexture

```lua
ClearDisabledTexture()
```

### ClearHighlightTexture

```lua
ClearHighlightTexture()
```

### ClearNormalTexture

```lua
ClearNormalTexture()
```

### ClearPushedTexture

```lua
ClearPushedTexture()
```

### Click

```lua
Click(button: cstring, isDown: bool)
```

### Disable

```lua
Disable()
```

### Enable

```lua
Enable()
```

### GetButtonState

```lua
GetButtonState() -> buttonState: SimpleButtonStateToken
```

### GetDisabledFontObject

```lua
GetDisabledFontObject() -> font: SimpleFont
```

### GetDisabledTexture

```lua
GetDisabledTexture() -> texture: SimpleTexture
```

### GetFontString

```lua
GetFontString() -> fontString: SimpleFontString
```

### GetHighlightFontObject

```lua
GetHighlightFontObject() -> font: SimpleFont
```

### GetHighlightTexture

```lua
GetHighlightTexture() -> texture: SimpleTexture
```

### GetMotionScriptsWhileDisabled

```lua
GetMotionScriptsWhileDisabled() -> motionScriptsWhileDisabled: bool
```

### GetNormalFontObject

```lua
GetNormalFontObject() -> font: SimpleFont
```

### GetNormalTexture

```lua
GetNormalTexture() -> texture: SimpleTexture
```

### GetPushedTextOffset

```lua
GetPushedTextOffset() -> offsetX: uiUnit, offsetY: uiUnit
```

### GetPushedTexture

```lua
GetPushedTexture() -> texture: SimpleTexture
```

### GetText

```lua
GetText() -> text: cstring
```

### GetTextHeight

```lua
GetTextHeight() -> height: uiUnit
```

### GetTextWidth

```lua
GetTextWidth() -> width: uiUnit
```

### IsEnabled

```lua
IsEnabled() -> isEnabled: bool
```

### RegisterForClicks

```lua
RegisterForClicks(buttons: ClickButton)
```

### RegisterForMouse

```lua
RegisterForMouse(buttons: ClickButton)
```

### SetButtonState

```lua
SetButtonState(buttonState: SimpleButtonStateToken, lock: bool)
```

### SetDisabledAtlas

```lua
SetDisabledAtlas(atlas: textureAtlas)
```

### SetDisabledFontObject

```lua
SetDisabledFontObject(font: SimpleFont)
```

### SetDisabledTexture

```lua
SetDisabledTexture(asset: TextureAsset)
```

### SetEnabled

```lua
SetEnabled(enabled: bool)
```

### SetFontString

```lua
SetFontString(fontString: SimpleFontString)
```

### SetFormattedText

```lua
SetFormattedText(text: cstring)
```

### SetHighlightAtlas

```lua
SetHighlightAtlas(atlas: textureAtlas, blendMode?: BlendMode)
```

### SetHighlightFontObject

```lua
SetHighlightFontObject(font: SimpleFont)
```

### SetHighlightTexture

```lua
SetHighlightTexture(asset: TextureAsset, blendMode?: BlendMode)
```

### SetMotionScriptsWhileDisabled

```lua
SetMotionScriptsWhileDisabled(motionScriptsWhileDisabled: bool)
```

### SetNormalAtlas

```lua
SetNormalAtlas(atlas: textureAtlas)
```

### SetNormalFontObject

```lua
SetNormalFontObject(font: SimpleFont)
```

### SetNormalTexture

```lua
SetNormalTexture(asset: TextureAsset)
```

### SetPushedAtlas

```lua
SetPushedAtlas(atlas: textureAtlas)
```

### SetPushedTextOffset

```lua
SetPushedTextOffset(offsetX: uiUnit, offsetY: uiUnit)
```

### SetPushedTexture

```lua
SetPushedTexture(asset: TextureAsset)
```

### SetText

```lua
SetText(text: cstring)
```
