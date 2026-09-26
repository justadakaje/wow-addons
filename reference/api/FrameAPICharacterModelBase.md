# FrameAPICharacterModelBase

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`24` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ApplySpellVisualKit

```lua
ApplySpellVisualKit(spellVisualKitID: number, oneShot: bool)
```

### CanSetUnit

```lua
CanSetUnit(unit: UnitToken)
```

### FreezeAnimation

```lua
FreezeAnimation(anim: AnimationDataEnum, variation: number, frame: number)
```

### GetDisplayInfo

```lua
GetDisplayInfo() -> displayID: number
```

### GetDoBlend

```lua
GetDoBlend() -> doBlend: bool
```

### GetKeepModelOnHide

```lua
GetKeepModelOnHide() -> keepModelOnHide: bool
```

### HasAnimation

```lua
HasAnimation(anim: AnimationDataEnum) -> hasAnimation: bool
```

### PlayAnimKit

```lua
PlayAnimKit(animKit: number, loop: bool)
```

### RefreshCamera

```lua
RefreshCamera()
```

### RefreshUnit

```lua
RefreshUnit()
```

### SetAnimation

```lua
SetAnimation(anim: AnimationDataEnum, variation?: number)
```

### SetBarberShopAlternateForm

```lua
SetBarberShopAlternateForm()
```

### SetCamDistanceScale

```lua
SetCamDistanceScale(scale: number)
```

### SetCreature

```lua
SetCreature(creatureID: number, displayID: number)
```

### SetDisplayInfo

```lua
SetDisplayInfo(displayID: number, mountDisplayID?: number)
```

### SetDoBlend

```lua
SetDoBlend(doBlend: bool)
```

### SetItem

```lua
SetItem(itemID: number, appearanceModID?: number, itemVisualID?: number)
```

### SetItemAppearance

```lua
SetItemAppearance(itemAppearanceID: number, itemVisualID?: number, itemSubclass?: ItemWeaponSubclass)
```

### SetKeepModelOnHide

```lua
SetKeepModelOnHide(keepModelOnHide: bool)
```

### SetPortraitZoom

```lua
SetPortraitZoom(zoom: number)
```

### SetRotation

```lua
SetRotation(radians: number, animate: bool)
```

### SetUnit

```lua
SetUnit(unit: UnitToken, blend: bool, useNativeForm?: bool) -> success: bool
```

### StopAnimKit

```lua
StopAnimKit()
```

### ZeroCachedCenterXY

```lua
ZeroCachedCenterXY()
```
