# C_PetInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`13` functions - `11` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanPetEatItem

```lua
C_PetInfo.CanPetEatItem(itemID: number) -> canEat: bool
```

### GetPetFoodTypes

```lua
C_PetInfo.GetPetFoodTypes() -> foodTypes: table
```

### GetPetHappiness

```lua
C_PetInfo.GetPetHappiness() -> happiness: number, damagePercentage: number, loyaltyRate: number
```

### GetPetLoyalty

```lua
C_PetInfo.GetPetLoyalty() -> loyaltyName: string
```

### GetPetTalentTree

```lua
C_PetInfo.GetPetTalentTree() -> talentTreeName: stringView
```

### GetPetTamersForMap

```lua
C_PetInfo.GetPetTamersForMap(uiMapID: number) -> petTamers: table
```

### GetPetTrainingPoints

```lua
C_PetInfo.GetPetTrainingPoints() -> totalPoints: number, usedPoints: number
```

### GetPetUIModelSceneID

```lua
C_PetInfo.GetPetUIModelSceneID() -> modelSceneID: number
```

### GetSpellForPetAction

```lua
C_PetInfo.GetSpellForPetAction(actionID: number) -> spellID?: number
```

### IsPetActionPassive

```lua
C_PetInfo.IsPetActionPassive(actionID: number) -> isPassive: bool
```

### PetAbandon

```lua
C_PetInfo.PetAbandon(petNumber?: number)
```

### PetAssistMode

```lua
C_PetInfo.PetAssistMode()
```

### PetRename

```lua
C_PetInfo.PetRename(name: cstring, petNumber?: number, declensions?: table)
```

## Events

### PetAttackStart

Fires as `PET_ATTACK_START`.

No payload.

### PetAttackStop

Fires as `PET_ATTACK_STOP`.

No payload.

### PetBarHidegrid

Fires as `PET_BAR_HIDEGRID`.

No payload.

### PetBarShowgrid

Fires as `PET_BAR_SHOWGRID`.

No payload.

### PetBarUpdateCooldown

Fires as `PET_BAR_UPDATE_COOLDOWN`.

No payload.

### PetDismissStart

Fires as `PET_DISMISS_START`.

```lua
payload: delay: number
```

### PetForceNameDeclension

Fires as `PET_FORCE_NAME_DECLENSION`.

```lua
payload: name: cstring, petNumber?: number, declinedName1?: cstring, declinedName2?: cstring, declinedName3?: cstring, declinedName4?: cstring, declinedName5?: cstring
```

### PetUiClose

Fires as `PET_UI_CLOSE`.

No payload.

### RaisedAsGhoul

Fires as `RAISED_AS_GHOUL`.

No payload.

### UpdatePossessBar

Fires as `UPDATE_POSSESS_BAR`.

No payload.

### UpdateVehicleActionbar

Fires as `UPDATE_VEHICLE_ACTIONBAR`.

No payload.
