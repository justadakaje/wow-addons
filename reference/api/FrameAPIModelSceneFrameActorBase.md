# FrameAPIModelSceneFrameActorBase

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`50` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearModel

```lua
ClearModel()
```

### GetActiveBoundingBox

```lua
GetActiveBoundingBox() -> boxBottom: vector3, boxTop: vector3
```

### GetAlpha

```lua
GetAlpha() -> alpha: number
```

### GetAnimation

```lua
GetAnimation() -> animation: AnimationDataEnum
```

### GetAnimationBlendOperation

```lua
GetAnimationBlendOperation() -> blendOp: ModelBlendOperation
```

### GetAnimationVariation

```lua
GetAnimationVariation() -> variation: number
```

### GetDesaturation

```lua
GetDesaturation() -> strength: number
```

### GetMaxBoundingBox

```lua
GetMaxBoundingBox() -> boxBottom: vector3, boxTop: vector3
```

### GetModelFileID

```lua
GetModelFileID() -> file: fileID
```

### GetModelPath

```lua
GetModelPath() -> path: string
```

### GetModelUnitGUID

```lua
GetModelUnitGUID() -> guid: WOWGUID
```

### GetParticleOverrideScale

```lua
GetParticleOverrideScale() -> scale?: number
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

### GetScale

```lua
GetScale() -> scale: number
```

### GetSpellVisualKit

```lua
GetSpellVisualKit() -> spellVisualKitID: number
```

### GetYaw

```lua
GetYaw() -> yaw: number
```

### Hide

```lua
Hide()
```

### IsLoaded

```lua
IsLoaded() -> isLoaded: bool
```

### IsPreferringModelCollisionBounds

```lua
IsPreferringModelCollisionBounds() -> preferringCollisionBounds: bool
```

### IsShown

```lua
IsShown() -> isShown: bool
```

### IsUsingCenterForOrigin

```lua
IsUsingCenterForOrigin() -> x: bool, y: bool, z: bool
```

### IsVisible

```lua
IsVisible() -> isVisible: bool
```

### PlayAnimationKit

```lua
PlayAnimationKit(animationKit: number, isLooping: bool)
```

### SetAlpha

```lua
SetAlpha(alpha: number)
```

### SetAnimation

```lua
SetAnimation(animation: AnimationDataEnum, variation?: number, animSpeed: number, animOffsetSeconds: number)
```

### SetAnimationBlendOperation

```lua
SetAnimationBlendOperation(blendOp: ModelBlendOperation)
```

### SetDesaturation

```lua
SetDesaturation(strength: number)
```

### SetGradientMask

```lua
SetGradientMask(gradientIndex0: number, gradientIndex1: number, gradientIndex2: number, gradientIndex3: number)
```

### SetGradientMaskWithDyes

```lua
SetGradientMaskWithDyes(grad0DyeColorID?: number, grad1DyeColorID?: number, grad2DyeColorID?: number)
```

### SetModelByCreatureDisplayID

```lua
SetModelByCreatureDisplayID(creatureDisplayID: number, useActivePlayerCustomizations: bool) -> success: bool
```

### SetModelByFileID

```lua
SetModelByFileID(asset: FileAsset, useMips: bool) -> success: bool
```

### SetModelByPath

```lua
SetModelByPath(asset: FileAsset, useMips: bool) -> success: bool
```

### SetModelByUnit

```lua
SetModelByUnit(unit: UnitToken, sheatheWeapons: bool, autoDress: bool, hideWeapons: bool, usePlayerNativeForm: bool, holdBowString: bool, customRaceID?: number) -> success: bool
```

### SetModelByUnitCreatureDisplayID

```lua
SetModelByUnitCreatureDisplayID(unit: UnitToken) -> success: bool
```

### SetParticleOverrideScale

```lua
SetParticleOverrideScale(scale?: number)
```

### SetPitch

```lua
SetPitch(pitch: number)
```

### SetPlayerModelFromGlues

```lua
SetPlayerModelFromGlues(characterIndex?: number, sheatheWeapons: bool, autoDress: bool, hideWeapons: bool, usePlayerNativeForm: bool, customRaceID?: number) -> success: bool
```

### SetPosition

```lua
SetPosition(positionX: number, positionY: number, positionZ: number)
```

### SetPreferModelCollisionBounds

```lua
SetPreferModelCollisionBounds(preferCollisionBounds: bool)
```

### SetRoll

```lua
SetRoll(roll: number)
```

### SetScale

```lua
SetScale(scale: number)
```

### SetShown

```lua
SetShown(show: bool)
```

### SetSpellVisualKit

```lua
SetSpellVisualKit(spellVisualKitID: number, oneShot: bool)
```

### SetUseCenterForOrigin

```lua
SetUseCenterForOrigin(x: bool, y: bool, z: bool)
```

### SetYaw

```lua
SetYaw(yaw: number)
```

### Show

```lua
Show()
```

### StopAnimationKit

```lua
StopAnimationKit()
```

### TryOn

```lua
TryOn(itemLinkOrItemModifiedAppearanceID: cstring, handSlotName?: cstring, spellEnchantmentID: number) -> reason?: ItemTryOnReason
```
