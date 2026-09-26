# SimpleModelAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`65` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AdvanceTime

```lua
AdvanceTime()
```

### ClearFog

```lua
ClearFog()
```

### ClearModel

```lua
ClearModel()
```

### ClearTransform

```lua
ClearTransform()
```

### GetCameraDistance

```lua
GetCameraDistance() -> distance: number
```

### GetCameraFacing

```lua
GetCameraFacing() -> radians: number
```

### GetCameraPosition

```lua
GetCameraPosition() -> positionX: number, positionY: number, positionZ: number
```

### GetCameraRoll

```lua
GetCameraRoll() -> radians: number
```

### GetCameraTarget

```lua
GetCameraTarget() -> targetX: number, targetY: number, targetZ: number
```

### GetDesaturation

```lua
GetDesaturation() -> strength: number
```

### GetFacing

```lua
GetFacing() -> facing: number
```

### GetFogColor

```lua
GetFogColor() -> colorR: number, colorG: number, colorB: number, colorA: number
```

### GetFogFar

```lua
GetFogFar() -> fogFar: number
```

### GetFogNear

```lua
GetFogNear() -> fogNear: number
```

### GetLight

```lua
GetLight() -> enabled: bool, light: ModelLight
```

### GetModelAlpha

```lua
GetModelAlpha() -> alpha: number
```

### GetModelDrawLayer

```lua
GetModelDrawLayer() -> layer: DrawLayer, sublayer: number
```

### GetModelFileID

```lua
GetModelFileID() -> modelFileID: fileID
```

### GetModelScale

```lua
GetModelScale() -> scale: number
```

### GetPaused

```lua
GetPaused() -> paused: bool
```

### GetPitch

```lua
GetPitch() -> pitch: number
```

### GetPosition

```lua
GetPosition() -> positionX: number, positionY: number, positionZ: number
```

### GetRoll

```lua
GetRoll() -> roll: number
```

### GetShadowEffect

```lua
GetShadowEffect() -> strength: number
```

### GetViewInsets

```lua
GetViewInsets() -> left: uiUnit, right: uiUnit, top: uiUnit, bottom: uiUnit
```

### GetViewTranslation

```lua
GetViewTranslation() -> x: uiUnit, y: uiUnit
```

### GetWorldScale

```lua
GetWorldScale() -> worldScale: number
```

### HasAttachmentPoints

```lua
HasAttachmentPoints() -> hasAttachmentPoints: bool
```

### HasCustomCamera

```lua
HasCustomCamera() -> hasCustomCamera: bool
```

### IsUsingModelCenterToTransform

```lua
IsUsingModelCenterToTransform() -> useCenter: bool
```

### MakeCurrentCameraCustom

```lua
MakeCurrentCameraCustom()
```

### ReplaceIconTexture

```lua
ReplaceIconTexture(asset: FileAsset)
```

### SetCamera

```lua
SetCamera(cameraIndex: number)
```

### SetCameraDistance

```lua
SetCameraDistance(distance: number)
```

### SetCameraFacing

```lua
SetCameraFacing(radians: number)
```

### SetCameraPosition

```lua
SetCameraPosition(positionX: number, positionY: number, positionZ: number)
```

### SetCameraRoll

```lua
SetCameraRoll(radians: number)
```

### SetCameraTarget

```lua
SetCameraTarget(targetX: number, targetY: number, targetZ: number)
```

### SetCustomCamera

```lua
SetCustomCamera(cameraIndex: number)
```

### SetDesaturation

```lua
SetDesaturation(strength: number)
```

### SetFacing

```lua
SetFacing(facing: number)
```

### SetFogColor

```lua
SetFogColor(colorR: number, colorG: number, colorB: number, a?: SingleColorValue)
```

### SetFogFar

```lua
SetFogFar(fogFar: number)
```

### SetFogNear

```lua
SetFogNear(fogNear: number)
```

### SetGlow

```lua
SetGlow(glow: number)
```

### SetGradientMask

```lua
SetGradientMask(grad0: number, grad1: number, grad2: number, grad3: number)
```

### SetLight

```lua
SetLight(enabled: bool, light: ModelLight)
```

### SetModel

```lua
SetModel(asset: ModelAsset, noMip: bool)
```

### SetModelAlpha

```lua
SetModelAlpha(alpha: number)
```

### SetModelDrawLayer

```lua
SetModelDrawLayer(layer: DrawLayer)
```

### SetModelScale

```lua
SetModelScale(scale: number)
```

### SetParticlesEnabled

```lua
SetParticlesEnabled(enabled: bool)
```

### SetPaused

```lua
SetPaused(paused: bool)
```

### SetPitch

```lua
SetPitch(pitch: number)
```

### SetPosition

```lua
SetPosition(positionX: number, positionY: number, positionZ: number)
```

### SetRoll

```lua
SetRoll(roll: number)
```

### SetSequence

```lua
SetSequence(sequence: number)
```

### SetSequenceTime

```lua
SetSequenceTime(sequence: number, timeOffset: number)
```

### SetShadowEffect

```lua
SetShadowEffect(strength: number)
```

### SetTransform

```lua
SetTransform(translation?: vector3, rotation?: vector3, scale?: number)
```

### SetUseGBuffer

```lua
SetUseGBuffer(useGBuffer: bool)
```

### SetViewInsets

```lua
SetViewInsets(left: uiUnit, right: uiUnit, top: uiUnit, bottom: uiUnit)
```

### SetViewTranslation

```lua
SetViewTranslation(x: uiUnit, y: uiUnit)
```

### TransformCameraSpaceToModelSpace

```lua
TransformCameraSpaceToModelSpace(cameraPosition: vector3) -> modelPosition: vector3
```

### UseModelCenterToTransform

```lua
UseModelCenterToTransform(useCenter: bool)
```
