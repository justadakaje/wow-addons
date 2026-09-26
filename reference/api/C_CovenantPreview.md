# C_CovenantPreview

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`2` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CloseFromUI

```lua
C_CovenantPreview.CloseFromUI()
```

### GetCovenantInfoForPlayerChoiceResponseID

```lua
C_CovenantPreview.GetCovenantInfoForPlayerChoiceResponseID(playerChoiceResponseID: number) -> previewInfo: CovenantPreviewInfo
```

## Events

### CovenantPreviewClose

Fires as `COVENANT_PREVIEW_CLOSE`.

No payload.

### CovenantPreviewOpen

Fires as `COVENANT_PREVIEW_OPEN`.

```lua
payload: previewInfo: CovenantPreviewInfo
```
