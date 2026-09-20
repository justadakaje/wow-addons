# C_CovenantSanctumUI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`16` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanAccessReservoir

```lua
C_CovenantSanctumUI.CanAccessReservoir() -> canAccess: bool
```

### CanDepositAnima

```lua
C_CovenantSanctumUI.CanDepositAnima() -> canDeposit: bool
```

### DepositAnima

```lua
C_CovenantSanctumUI.DepositAnima()
```

### EndInteraction

```lua
C_CovenantSanctumUI.EndInteraction()
```

### GetAnimaInfo

```lua
C_CovenantSanctumUI.GetAnimaInfo() -> currencyID: number, maxDisplayableValue: number
```

### GetCurrentTalentTreeID

```lua
C_CovenantSanctumUI.GetCurrentTalentTreeID() -> currentTalentTreeID?: number
```

### GetFeatures

```lua
C_CovenantSanctumUI.GetFeatures() -> features: table
```

### GetRenownLevel

```lua
C_CovenantSanctumUI.GetRenownLevel() -> level: number
```

### GetRenownLevels

```lua
C_CovenantSanctumUI.GetRenownLevels(covenantID: number) -> levels: table
```

### GetRenownRewardsForLevel

```lua
C_CovenantSanctumUI.GetRenownRewardsForLevel(covenantID: number, renownLevel: number) -> rewards: table
```

### GetSanctumType

```lua
C_CovenantSanctumUI.GetSanctumType() -> sanctumType?: GarrTalentFeatureSubtype
```

### GetSoulCurrencies

```lua
C_CovenantSanctumUI.GetSoulCurrencies() -> currencyIDs: table
```

### HasMaximumRenown

```lua
C_CovenantSanctumUI.HasMaximumRenown() -> hasMaxRenown: bool
```

### IsPlayerInRenownCatchUpMode

```lua
C_CovenantSanctumUI.IsPlayerInRenownCatchUpMode() -> isInCatchUpMode: bool
```

### IsWeeklyRenownCapped

```lua
C_CovenantSanctumUI.IsWeeklyRenownCapped() -> isWeeklyCapped: bool
```

### RequestCatchUpState

```lua
C_CovenantSanctumUI.RequestCatchUpState()
```

## Events

### CovenantRenownCatchUpStateUpdate

Fires as `COVENANT_RENOWN_CATCH_UP_STATE_UPDATE`.

No payload.

### CovenantSanctumRenownLevelChanged

Fires as `COVENANT_SANCTUM_RENOWN_LEVEL_CHANGED`.

```lua
payload: newRenownLevel: number, oldRenownLevel: number
```
