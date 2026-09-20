# C_BarberShop

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`29` functions - `7` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ApplyCustomizationChoices

```lua
C_BarberShop.ApplyCustomizationChoices() -> success: bool
```

### Cancel

```lua
C_BarberShop.Cancel()
```

### ClearPreviewChoices

```lua
C_BarberShop.ClearPreviewChoices(clearSavedChoices: bool)
```

### GetAvailableCustomizations

```lua
C_BarberShop.GetAvailableCustomizations() -> categories: table
```

### GetCurrentCameraZoom

```lua
C_BarberShop.GetCurrentCameraZoom() -> zoomLevel: number
```

### GetCurrentCharacterData

```lua
C_BarberShop.GetCurrentCharacterData() -> characterData: PlayerInfoCharacterData
```

### GetCurrentCost

```lua
C_BarberShop.GetCurrentCost() -> cost: number
```

### GetViewingChrModel

```lua
C_BarberShop.GetViewingChrModel() -> chrModelID?: number
```

### HasAlteredForm

```lua
C_BarberShop.HasAlteredForm() -> hasAlteredForm: bool
```

### HasAnyChanges

```lua
C_BarberShop.HasAnyChanges() -> hasChanges: bool
```

### HasCustomizationFeature

```lua
C_BarberShop.HasCustomizationFeature(featureMask: ChrModelFeatureFlags) -> hasCustomizationFeature: bool
```

### IsViewingAlteredForm

```lua
C_BarberShop.IsViewingAlteredForm() -> isViewingAlteredForm: bool
```

### MarkCustomizationChoiceAsSeen

```lua
C_BarberShop.MarkCustomizationChoiceAsSeen(choiceID: number)
```

### MarkCustomizationOptionAsSeen

```lua
C_BarberShop.MarkCustomizationOptionAsSeen(optionID: number)
```

### PreviewCustomizationChoice

```lua
C_BarberShop.PreviewCustomizationChoice(optionID: number, choiceID: number)
```

### RandomizeCustomizationChoices

```lua
C_BarberShop.RandomizeCustomizationChoices()
```

### ResetCameraRotation

```lua
C_BarberShop.ResetCameraRotation()
```

### ResetCustomizationChoices

```lua
C_BarberShop.ResetCustomizationChoices()
```

### RotateCamera

```lua
C_BarberShop.RotateCamera(diffDegrees: number)
```

### SaveSeenChoices

```lua
C_BarberShop.SaveSeenChoices()
```

### SetCameraDistanceOffset

```lua
C_BarberShop.SetCameraDistanceOffset(offset: number)
```

### SetCameraZoomLevel

```lua
C_BarberShop.SetCameraZoomLevel(zoomLevel: number, keepCustomZoom?: bool)
```

### SetCustomizationChoice

```lua
C_BarberShop.SetCustomizationChoice(optionID: number, choiceID: number)
```

### SetModelDressState

```lua
C_BarberShop.SetModelDressState(dressedState: bool)
```

### SetSelectedSex

```lua
C_BarberShop.SetSelectedSex(sex: UnitSex)
```

### SetViewingAlteredForm

```lua
C_BarberShop.SetViewingAlteredForm(isViewingAlteredForm: bool)
```

### SetViewingChrModel

```lua
C_BarberShop.SetViewingChrModel(chrModelID?: number, spellShapeshiftFormID?: number)
```

### SetViewingShapeshiftForm

```lua
C_BarberShop.SetViewingShapeshiftForm(shapeshiftFormID?: number)
```

### ZoomCamera

```lua
C_BarberShop.ZoomCamera(zoomAmount: number)
```

## Events

### BarberShopAppearanceApplied

Fires as `BARBER_SHOP_APPEARANCE_APPLIED`.

No payload.

### BarberShopCameraValuesUpdated

Fires as `BARBER_SHOP_CAMERA_VALUES_UPDATED`.

No payload.

### BarberShopClose

Fires as `BARBER_SHOP_CLOSE`.

No payload.

### BarberShopCostUpdate

Fires as `BARBER_SHOP_COST_UPDATE`.

No payload.

### BarberShopForceCustomizationsUpdate

Fires as `BARBER_SHOP_FORCE_CUSTOMIZATIONS_UPDATE`.

No payload.

### BarberShopOpen

Fires as `BARBER_SHOP_OPEN`.

No payload.

### BarberShopResult

Fires as `BARBER_SHOP_RESULT`.

```lua
payload: success: bool
```
