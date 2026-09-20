# C_AnimaDiversion

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`7` functions - `3` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CloseUI

```lua
C_AnimaDiversion.CloseUI()
```

### GetAnimaDiversionNodes

```lua
C_AnimaDiversion.GetAnimaDiversionNodes() -> animaNodes: table
```

### GetOriginPosition

```lua
C_AnimaDiversion.GetOriginPosition() -> normalizedPosition?: vector2
```

### GetReinforceProgress

```lua
C_AnimaDiversion.GetReinforceProgress() -> progress: number
```

### GetTextureKit

```lua
C_AnimaDiversion.GetTextureKit() -> textureKit: textureKit
```

### OpenAnimaDiversionUI

```lua
C_AnimaDiversion.OpenAnimaDiversionUI()
```

### SelectAnimaNode

```lua
C_AnimaDiversion.SelectAnimaNode(talentID: number, temporary: bool)
```

## Events

### AnimaDiversionClose

Fires as `ANIMA_DIVERSION_CLOSE`.

No payload.

### AnimaDiversionOpen

Fires as `ANIMA_DIVERSION_OPEN`.

```lua
payload: info: AnimaDiversionFrameInfo
```

### AnimaDiversionTalentUpdated

Fires as `ANIMA_DIVERSION_TALENT_UPDATED`.

No payload.
