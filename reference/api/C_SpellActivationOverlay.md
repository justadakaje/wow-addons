# C_SpellActivationOverlay

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`1` functions - `4` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### IsSpellOverlayed

```lua
C_SpellActivationOverlay.IsSpellOverlayed(spellID: number) -> isSpellOverlayed: bool
```

## Events

### SpellActivationOverlayGlowHide

Fires as `SPELL_ACTIVATION_OVERLAY_GLOW_HIDE`.

```lua
payload: spellID: number
```

### SpellActivationOverlayGlowShow

Fires as `SPELL_ACTIVATION_OVERLAY_GLOW_SHOW`.

```lua
payload: spellID: number
```

### SpellActivationOverlayHide

Fires as `SPELL_ACTIVATION_OVERLAY_HIDE`.

```lua
payload: spellID?: number
```

### SpellActivationOverlayShow

Fires as `SPELL_ACTIVATION_OVERLAY_SHOW`.

```lua
payload: spellID: number, overlayFileDataID: number, locationType: ScreenLocationType, scale: number, r: number, g: number, b: number
```
