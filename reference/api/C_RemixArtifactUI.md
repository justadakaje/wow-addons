# C_RemixArtifactUI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`8` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearRemixArtifactItem

```lua
C_RemixArtifactUI.ClearRemixArtifactItem()
```

### GetAppearanceInfoByID

```lua
C_RemixArtifactUI.GetAppearanceInfoByID(artifactAppearanceID: number) -> uiCameraID: number, altHandUICameraID?: number
```

### GetArtifactArtInfo

```lua
C_RemixArtifactUI.GetArtifactArtInfo() -> artifactArtInfo: RemixArtifactArtInfo
```

### GetArtifactItemInfo

```lua
C_RemixArtifactUI.GetArtifactItemInfo() -> itemID: number, altItemID?: number, artifactAppearanceID: number, appearanceModID: number, itemAppearanceID?: number, altItemAppearanceID?: number, altOnTop: bool
```

### GetCurrArtifactItemID

```lua
C_RemixArtifactUI.GetCurrArtifactItemID() -> reqitemID?: number
```

### GetCurrItemSpecIndex

```lua
C_RemixArtifactUI.GetCurrItemSpecIndex() -> specIndex?: luaIndex
```

### GetCurrTraitTreeID

```lua
C_RemixArtifactUI.GetCurrTraitTreeID() -> traitTreeID?: number
```

### ItemInSlotIsRemixArtifact

```lua
C_RemixArtifactUI.ItemInSlotIsRemixArtifact(invSlot: luaIndex) -> isRemixArtifact: bool
```

## Events

### RemixArtifactItemSpecsLoaded

Fires as `REMIX_ARTIFACT_ITEM_SPECS_LOADED`.

```lua
payload: success: bool
```

### RemixArtifactUpdate

Fires as `REMIX_ARTIFACT_UPDATE`.

No payload.
