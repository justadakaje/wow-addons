# C_Texture

WoW: Forever 1.60.1 (build 70862) - Interface 16001

`11` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearTitleIconTexture

```lua
C_Texture.ClearTitleIconTexture(texture: SimpleTexture)
```

### GetAtlasElementID

```lua
C_Texture.GetAtlasElementID(atlas: textureAtlas) -> elementID: number
```

### GetAtlasElements

```lua
C_Texture.GetAtlasElements() -> atlases: table
```

### GetAtlasExists

```lua
C_Texture.GetAtlasExists(atlas: textureAtlas) -> atlasExists: bool
```

### GetAtlasID

```lua
C_Texture.GetAtlasID(atlas: textureAtlas) -> atlasID: number
```

### GetAtlasInfo

```lua
C_Texture.GetAtlasInfo(atlas: textureAtlas) -> info: AtlasInfo
```

### GetFilenameFromFileDataID

```lua
C_Texture.GetFilenameFromFileDataID(fileDataID: number) -> filename: string
```

### GetTitleIconTexture

```lua
C_Texture.GetTitleIconTexture(titleID: string, version: TitleIconVersion, callback: GetTitleIconTextureCallback, subIcon?: string)
```

### IsTitleIconTextureReady

```lua
C_Texture.IsTitleIconTextureReady(titleID: string, version: TitleIconVersion, subIcon?: string) -> ready: bool
```

### SetTitleIconTexture

```lua
C_Texture.SetTitleIconTexture(texture: SimpleTexture, titleID: string, version: TitleIconVersion, subIcon?: string)
```

### SetURLTexture

```lua
C_Texture.SetURLTexture(texture: SimpleTexture, url: cstring)
```

## Events

### UrlTextureRequestResult

Fires as `URL_TEXTURE_REQUEST_RESULT`.

```lua
payload: texture: SimpleTexture, result: UrlTextureResult
```
