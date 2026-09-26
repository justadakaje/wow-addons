# SimpleTextureBaseAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`52` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearRadialProgressBar

```lua
ClearRadialProgressBar()
```

### ClearSVG

```lua
ClearSVG()
```

### ClearTextureSlice

```lua
ClearTextureSlice()
```

### ClearVertexOffsets

```lua
ClearVertexOffsets()
```

### GetAtlas

```lua
GetAtlas() -> atlas: textureAtlas
```

### GetBlendMode

```lua
GetBlendMode() -> blendMode: BlendMode
```

### GetDesaturation

```lua
GetDesaturation() -> desaturation: normalizedValue
```

### GetHorizTile

```lua
GetHorizTile() -> tiling: bool
```

### GetRadialProgressBarEndOffset

```lua
GetRadialProgressBarEndOffset() -> offset: normalizedValue
```

### GetRadialProgressBarFeather

```lua
GetRadialProgressBarFeather() -> feather: normalizedValue
```

### GetRadialProgressBarPercent

```lua
GetRadialProgressBarPercent() -> percent: normalizedValue
```

### GetRadialProgressBarReverse

```lua
GetRadialProgressBarReverse() -> reverse: bool
```

### GetRadialProgressBarStartOffset

```lua
GetRadialProgressBarStartOffset() -> offset: normalizedValue
```

### GetRotation

```lua
GetRotation() -> radians: number, normalizedRotationPoint: vector2
```

### GetTexCoord

```lua
GetTexCoord() -> ulX: number, ulY: number, llX: number, llY: number, urX: number, urY: number, lrX: number, lrY: number
```

### GetTexelSnappingBias

```lua
GetTexelSnappingBias() -> bias: normalizedValue
```

### GetTexture

```lua
GetTexture() -> textureFile?: cstring
```

### GetTextureFileID

```lua
GetTextureFileID() -> textureFile: fileID
```

### GetTextureFilePath

```lua
GetTextureFilePath() -> textureFile?: cstring
```

### GetTextureSliceMargins

```lua
GetTextureSliceMargins() -> left: number, top: number, right: number, bottom: number
```

### GetTextureSliceMode

```lua
GetTextureSliceMode() -> sliceMode: UITextureSliceMode
```

### GetVertexOffset

```lua
GetVertexOffset(vertexIndex: luaIndex) -> offsetX: uiUnit, offsetY: uiUnit
```

### GetVertTile

```lua
GetVertTile() -> tiling: bool
```

### IsBlockingLoadRequested

```lua
IsBlockingLoadRequested() -> blocking: bool
```

### IsDesaturated

```lua
IsDesaturated() -> desaturated: bool
```

### IsSnappingToPixelGrid

```lua
IsSnappingToPixelGrid() -> snap: bool
```

### ResetTexCoord

```lua
ResetTexCoord()
```

### SetAtlas

```lua
SetAtlas(atlas: textureAtlas, useAtlasSize: bool, filterMode?: FilterMode, resetTexCoords?: bool, wrapModeHorizontal?: cstring, wrapModeVertical?: cstring)
```

### SetBlendMode

```lua
SetBlendMode(blendMode: BlendMode)
```

### SetBlockingLoadsRequested

```lua
SetBlockingLoadsRequested(blocking: bool)
```

### SetColorTexture

```lua
SetColorTexture(colorR: number, colorG: number, colorB: number, a?: SingleColorValue)
```

### SetDesaturated

```lua
SetDesaturated(desaturated: bool)
```

### SetDesaturation

```lua
SetDesaturation(desaturation: normalizedValue)
```

### SetGradient

```lua
SetGradient(orientation: Orientation, minColor: colorRGBA, maxColor: colorRGBA)
```

### SetHorizTile

```lua
SetHorizTile(tiling: bool)
```

### SetMask

```lua
SetMask(file: cstring)
```

### SetRadialProgressBarEndOffset

```lua
SetRadialProgressBarEndOffset(offset: normalizedValue)
```

### SetRadialProgressBarFeather

```lua
SetRadialProgressBarFeather(feather: normalizedValue)
```

### SetRadialProgressBarPercent

```lua
SetRadialProgressBarPercent(percent: normalizedValue)
```

### SetRadialProgressBarReverse

```lua
SetRadialProgressBarReverse(reverse: bool)
```

### SetRadialProgressBarStartOffset

```lua
SetRadialProgressBarStartOffset(offset: normalizedValue)
```

### SetRotation

```lua
SetRotation(radians: number, normalizedRotationPoint?: vector2)
```

### SetSnapToPixelGrid

```lua
SetSnapToPixelGrid(snap: bool)
```

### SetSpriteSheetCell

```lua
SetSpriteSheetCell(cell: luaIndex, numRows: number, numColumns: number, cellWidth?: number, cellHeight?: number)
```

### SetSVG

```lua
SetSVG(svgAsset: FileAsset) -> success: bool
```

### SetTexCoord

```lua
SetTexCoord(left: number, right: number, bottom: number, top: number)
```

### SetTexelSnappingBias

```lua
SetTexelSnappingBias(bias: normalizedValue)
```

### SetTexture

```lua
SetTexture(textureAsset?: cstring, wrapModeHorizontal?: cstring, wrapModeVertical?: cstring, filterMode?: cstring) -> success: bool
```

### SetTextureSliceMargins

```lua
SetTextureSliceMargins(left: number, top: number, right: number, bottom: number)
```

### SetTextureSliceMode

```lua
SetTextureSliceMode(sliceMode: UITextureSliceMode)
```

### SetVertexOffset

```lua
SetVertexOffset(vertexIndex: luaIndex, offsetX: uiUnit, offsetY: uiUnit)
```

### SetVertTile

```lua
SetVertTile(tiling: bool)
```
