# FrameAPIModelSceneFrame

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`47` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearFog

```lua
ClearFog()
```

### CreateActor

```lua
CreateActor(name: cstring, template: cstring)
```

### GetActorAtIndex

```lua
GetActorAtIndex(index: luaIndex)
```

### GetAllowOverlappedModels

```lua
GetAllowOverlappedModels() -> allowOverlappedModels: bool
```

### GetCameraFarClip

```lua
GetCameraFarClip() -> farClip: number
```

### GetCameraFieldOfView

```lua
GetCameraFieldOfView() -> fov: number
```

### GetCameraForward

```lua
GetCameraForward() -> forwardX: number, forwardY: number, forwardZ: number
```

### GetCameraNearClip

```lua
GetCameraNearClip() -> nearClip: number
```

### GetCameraPosition

```lua
GetCameraPosition() -> positionX: number, positionY: number, positionZ: number
```

### GetCameraRight

```lua
GetCameraRight() -> rightX: number, rightY: number, rightZ: number
```

### GetCameraUp

```lua
GetCameraUp() -> upX: number, upY: number, upZ: number
```

### GetDrawLayer

```lua
GetDrawLayer() -> layer: DrawLayer, sublevel: number
```

### GetFogColor

```lua
GetFogColor() -> colorR: number, colorG: number, colorB: number
```

### GetFogFar

```lua
GetFogFar() -> far: number
```

### GetFogNear

```lua
GetFogNear() -> near: number
```

### GetLightAmbientColor

```lua
GetLightAmbientColor() -> colorR: number, colorG: number, colorB: number
```

### GetLightDiffuseColor

```lua
GetLightDiffuseColor() -> colorR: number, colorG: number, colorB: number
```

### GetLightDirection

```lua
GetLightDirection() -> directionX: number, directionY: number, directionZ: number
```

### GetLightPosition

```lua
GetLightPosition() -> positionX: number, positionY: number, positionZ: number
```

### GetLightType

```lua
GetLightType() -> lightType?: ModelLightType
```

### GetNumActors

```lua
GetNumActors() -> numActors: number
```

### GetViewInsets

```lua
GetViewInsets() -> insets: uiRect
```

### GetViewTranslation

```lua
GetViewTranslation() -> translationX: number, translationY: number
```

### IsLightVisible

```lua
IsLightVisible() -> isVisible: bool
```

### Project3DPointTo2D

```lua
Project3DPointTo2D(pointX: number, pointY: number, pointZ: number) -> point2DX: number, point2DY: number, depth: number
```

### SetAllowOverlappedModels

```lua
SetAllowOverlappedModels(allowOverlappedModels: bool)
```

### SetCameraFarClip

```lua
SetCameraFarClip(farClip: number)
```

### SetCameraFieldOfView

```lua
SetCameraFieldOfView(fov: number)
```

### SetCameraNearClip

```lua
SetCameraNearClip(nearClip: number)
```

### SetCameraOrientationByAxisVectors

```lua
SetCameraOrientationByAxisVectors(forwardX: number, forwardY: number, forwardZ: number, rightX: number, rightY: number, rightZ: number, upX: number, upY: number, upZ: number)
```

### SetCameraOrientationByYawPitchRoll

```lua
SetCameraOrientationByYawPitchRoll(yaw: number, pitch: number, roll: number)
```

### SetCameraPosition

```lua
SetCameraPosition(positionX: number, positionY: number, positionZ: number)
```

### SetDesaturation

```lua
SetDesaturation(strength: number)
```

### SetDrawLayer

```lua
SetDrawLayer(layer: DrawLayer)
```

### SetFogColor

```lua
SetFogColor(colorR: number, colorG: number, colorB: number)
```

### SetFogFar

```lua
SetFogFar(far: number)
```

### SetFogNear

```lua
SetFogNear(near: number)
```

### SetLightAmbientColor

```lua
SetLightAmbientColor(colorR: number, colorG: number, colorB: number)
```

### SetLightDiffuseColor

```lua
SetLightDiffuseColor(colorR: number, colorG: number, colorB: number)
```

### SetLightDirection

```lua
SetLightDirection(directionX: number, directionY: number, directionZ: number)
```

### SetLightPosition

```lua
SetLightPosition(positionX: number, positionY: number, positionZ: number)
```

### SetLightType

```lua
SetLightType(lightType: ModelLightType)
```

### SetLightVisible

```lua
SetLightVisible(visible: bool)
```

### SetPaused

```lua
SetPaused(paused: bool, affectsGlobalPause: bool)
```

### SetViewInsets

```lua
SetViewInsets(insets: uiRect)
```

### SetViewTranslation

```lua
SetViewTranslation(translationX: number, translationY: number)
```

### TakeActor

```lua
TakeActor()
```
