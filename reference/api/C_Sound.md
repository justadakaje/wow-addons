# C_Sound

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`6` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetSoundScaledVolume

```lua
C_Sound.GetSoundScaledVolume(soundHandle: number) -> scaledVolume: number
```

### IsPlaying

```lua
C_Sound.IsPlaying(soundHandle: number) -> isPlaying: bool
```

### PlayItemSound

```lua
C_Sound.PlayItemSound(soundType: ItemSoundType, itemLocation: ItemLocation)
```

### PlaySound

```lua
C_Sound.PlaySound(soundKitID: number, uiSoundSubType: UISoundSubType, forceNoDuplicates: bool, runFinishCallback: bool, overridePriority?: number, volumeOverride?: number) -> success: bool, soundHandle: SoundHandle
```

### PlaySoundWithOptions

```lua
C_Sound.PlaySoundWithOptions(params: PlaySoundParams) -> success: bool, soundHandle: SoundHandle
```

### PlayVocalErrorSound

```lua
C_Sound.PlayVocalErrorSound(vocalErrorSoundID: Vocalerrorsounds)
```

## Events

### SoundDeviceUpdate

Fires as `SOUND_DEVICE_UPDATE`.

No payload.

### SoundkitFinished

Fires as `SOUNDKIT_FINISHED`.

```lua
payload: soundHandle: number
```
