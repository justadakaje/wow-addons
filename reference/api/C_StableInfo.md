# C_StableInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`17` functions - `5` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### BuyStableSlot

```lua
C_StableInfo.BuyStableSlot()
```

### ClosePetStables

```lua
C_StableInfo.ClosePetStables()
```

### GetActivePetList

```lua
C_StableInfo.GetActivePetList() -> activePets: table
```

### GetAvailablePetSpecInfos

```lua
C_StableInfo.GetAvailablePetSpecInfos() -> petSpecInfos: table
```

### GetNextStableSlotCost

```lua
C_StableInfo.GetNextStableSlotCost() -> cost: number
```

### GetNumActivePets

```lua
C_StableInfo.GetNumActivePets() -> numActivePets: number
```

### GetNumStablePets

```lua
C_StableInfo.GetNumStablePets() -> numStablePets: number
```

### GetNumStableSlots

```lua
C_StableInfo.GetNumStableSlots() -> numSlots: number
```

### GetStabledPetList

```lua
C_StableInfo.GetStabledPetList() -> stabledPets: table
```

### GetStablePetFoodTypes

```lua
C_StableInfo.GetStablePetFoodTypes(index: luaIndex) -> foodTypes: table
```

### GetStablePetInfo

```lua
C_StableInfo.GetStablePetInfo(index: luaIndex) -> petInfo?: PetInfo
```

### IsAtStableMaster

```lua
C_StableInfo.IsAtStableMaster() -> isAtStableMaster: bool
```

### IsBonusPetSlotAvailable

```lua
C_StableInfo.IsBonusPetSlotAvailable() -> isAvailable: bool
```

### IsPetFavorite

```lua
C_StableInfo.IsPetFavorite(slot: luaIndex) -> isFavorite: bool
```

### PickupStablePet

```lua
C_StableInfo.PickupStablePet(index: luaIndex)
```

### SetPetFavorite

```lua
C_StableInfo.SetPetFavorite(slot: luaIndex, isFavorite: bool)
```

### SetPetSlot

```lua
C_StableInfo.SetPetSlot(index: luaIndex, slot: luaIndex)
```

## Events

### PetInfoUpdate

Fires as `PET_INFO_UPDATE`.

No payload.

### PetStableClosed

Fires as `PET_STABLE_CLOSED`.

No payload.

### PetStableFavoritesUpdated

Fires as `PET_STABLE_FAVORITES_UPDATED`.

No payload.

### PetStableShow

Fires as `PET_STABLE_SHOW`.

No payload.

### PetStableUpdate

Fires as `PET_STABLE_UPDATE`.

No payload.
