# C_Flyout

WoW: Forever 1.60.1 (build 70862) - Interface 16001

`6` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### FlyoutHasSpell

```lua
C_Flyout.FlyoutHasSpell(flyoutID: number, spellID: number) -> hasSpell: bool
```

### GetFlyoutID

```lua
C_Flyout.GetFlyoutID(index: luaIndex) -> flyoutID: number
```

### GetFlyoutInfo

```lua
C_Flyout.GetFlyoutInfo(flyoutID: number) -> info: FlyoutInfo
```

### GetFlyoutSlotInfo

```lua
C_Flyout.GetFlyoutSlotInfo(flyoutID: number, slotIndex: luaIndex) -> slotInfo: FlyoutSlotInfo
```

### GetFlyoutTexture

```lua
C_Flyout.GetFlyoutTexture(flyoutID: number) -> textureID: fileID
```

### GetNumFlyouts

```lua
C_Flyout.GetNumFlyouts() -> numFlyouts: number
```
