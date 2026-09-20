# C_CurrencyInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`43` functions - `8` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanTransferCurrency

```lua
C_CurrencyInfo.CanTransferCurrency(currencyID: number) -> canTransferCurrency: bool, failureReason?: AccountCurrencyTransferResult
```

### DoesCurrentFilterRequireAccountCurrencyData

```lua
C_CurrencyInfo.DoesCurrentFilterRequireAccountCurrencyData() -> doesCurrentFilterRequireAccountCurrencyData: bool
```

### DoesWarModeBonusApply

```lua
C_CurrencyInfo.DoesWarModeBonusApply(currencyID: number) -> warModeApplies?: bool, limitOncePerTooltip?: bool
```

### ExpandCurrencyList

```lua
C_CurrencyInfo.ExpandCurrencyList(index: luaIndex, expand: bool)
```

### FetchCurrencyDataFromAccountCharacters

```lua
C_CurrencyInfo.FetchCurrencyDataFromAccountCharacters(currencyID: number) -> accountCurrencyData: table
```

### FetchCurrencyTransferTransactions

```lua
C_CurrencyInfo.FetchCurrencyTransferTransactions() -> currencyTransferTransactions: table
```

### GetAzeriteCurrencyID

```lua
C_CurrencyInfo.GetAzeriteCurrencyID() -> azeriteCurrencyID: number
```

### GetBackpackCurrencyInfo

```lua
C_CurrencyInfo.GetBackpackCurrencyInfo(index: luaIndex) -> info: BackpackCurrencyInfo
```

### GetBasicCurrencyInfo

```lua
C_CurrencyInfo.GetBasicCurrencyInfo(currencyType: number, quantity?: number) -> info: CurrencyDisplayInfo
```

### GetCoinIcon

```lua
C_CurrencyInfo.GetCoinIcon(amount: WOWMONEY) -> result: fileID
```

### GetCoinText

```lua
C_CurrencyInfo.GetCoinText(amount: WOWMONEY, separator: cstring) -> result: cstring
```

### GetCoinTextureString

```lua
C_CurrencyInfo.GetCoinTextureString(amount: WOWMONEY, fontHeight: number) -> result: cstring
```

### GetCostToTransferCurrency

```lua
C_CurrencyInfo.GetCostToTransferCurrency(currencyID: number, quantity: number) -> totalQuantityConsumed?: number
```

### GetCurrencyContainerInfo

```lua
C_CurrencyInfo.GetCurrencyContainerInfo(currencyType: number, quantity: number) -> info: CurrencyDisplayInfo
```

### GetCurrencyDescription

```lua
C_CurrencyInfo.GetCurrencyDescription(type: number) -> description: cstring
```

### GetCurrencyFilter

```lua
C_CurrencyInfo.GetCurrencyFilter() -> filterType: CurrencyFilterType
```

### GetCurrencyIDFromLink

```lua
C_CurrencyInfo.GetCurrencyIDFromLink(currencyLink: cstring) -> currencyID: number
```

### GetCurrencyInfo

```lua
C_CurrencyInfo.GetCurrencyInfo(type: number) -> info: CurrencyInfo
```

### GetCurrencyInfoFromLink

```lua
C_CurrencyInfo.GetCurrencyInfoFromLink(link: string) -> info: CurrencyInfo
```

### GetCurrencyLink

```lua
C_CurrencyInfo.GetCurrencyLink(type: number, amount?: number) -> link: cstring
```

### GetCurrencyListInfo

```lua
C_CurrencyInfo.GetCurrencyListInfo(index: luaIndex) -> info: CurrencyInfo
```

### GetCurrencyListLink

```lua
C_CurrencyInfo.GetCurrencyListLink(index: luaIndex) -> link: cstring
```

### GetCurrencyListSize

```lua
C_CurrencyInfo.GetCurrencyListSize() -> currencyListSize: number
```

### GetDragonIslesSuppliesCurrencyID

```lua
C_CurrencyInfo.GetDragonIslesSuppliesCurrencyID() -> dragonIslesSuppliesCurrencyID: number
```

### GetFactionGrantedByCurrency

```lua
C_CurrencyInfo.GetFactionGrantedByCurrency(currencyID: number) -> factionID?: number
```

### GetMaxTransferableAmountFromQuantity

```lua
C_CurrencyInfo.GetMaxTransferableAmountFromQuantity(currencyID: number, requestedQuantity: number) -> maxTransferableAmount?: number
```

### GetPlayerCurrencyCategoryInfo

```lua
C_CurrencyInfo.GetPlayerCurrencyCategoryInfo(categoryID: number, includeAccountWide: bool) -> info: PlayerCurrencyCategoryInfo
```

### GetWarResourcesCurrencyID

```lua
C_CurrencyInfo.GetWarResourcesCurrencyID() -> warResourceCurrencyID: number
```

### IsAccountCharacterCurrencyDataReady

```lua
C_CurrencyInfo.IsAccountCharacterCurrencyDataReady() -> isReady: bool
```

### IsAccountTransferableCurrency

```lua
C_CurrencyInfo.IsAccountTransferableCurrency(currencyID: number) -> isAccountTransferableCurrency: bool
```

### IsAccountWideCurrency

```lua
C_CurrencyInfo.IsAccountWideCurrency(currencyID: number) -> isAccountWideCurrency: bool
```

### IsCurrencyContainer

```lua
C_CurrencyInfo.IsCurrencyContainer(currencyID: number, quantity: number) -> isCurrencyContainer: bool
```

### IsCurrencyTransferInProgress

```lua
C_CurrencyInfo.IsCurrencyTransferInProgress() -> currencyTransferInProgress: bool
```

### IsCurrencyTransferTransactionDataReady

```lua
C_CurrencyInfo.IsCurrencyTransferTransactionDataReady() -> isReady: bool
```

### PickupCurrency

```lua
C_CurrencyInfo.PickupCurrency(type: number)
```

### PlayerHasMaxQuantity

```lua
C_CurrencyInfo.PlayerHasMaxQuantity(currencyID: number) -> hasMaxQuantity: bool
```

### PlayerHasMaxWeeklyQuantity

```lua
C_CurrencyInfo.PlayerHasMaxWeeklyQuantity(currencyID: number) -> hasMaxWeeklyQuantity: bool
```

### RequestCurrencyDataForAccountCharacters

```lua
C_CurrencyInfo.RequestCurrencyDataForAccountCharacters()
```

### RequestCurrencyFromAccountCharacter

```lua
C_CurrencyInfo.RequestCurrencyFromAccountCharacter(sourceCharacterGUID: WOWGUID, currencyID: number, quantity: number)
```

### SetCurrencyBackpack

```lua
C_CurrencyInfo.SetCurrencyBackpack(index: luaIndex, backpack: bool)
```

### SetCurrencyBackpackByID

```lua
C_CurrencyInfo.SetCurrencyBackpackByID(currencyType: number, backpack: bool)
```

### SetCurrencyFilter

```lua
C_CurrencyInfo.SetCurrencyFilter(filterType: CurrencyFilterType)
```

### SetCurrencyUnused

```lua
C_CurrencyInfo.SetCurrencyUnused(index: luaIndex, unused: bool)
```

## Events

### AccountCharacterCurrencyDataReceived

Fires as `ACCOUNT_CHARACTER_CURRENCY_DATA_RECEIVED`.

No payload.

### AccountMoney

Fires as `ACCOUNT_MONEY`.

No payload.

### CurrencyDisplayUpdate

Fires as `CURRENCY_DISPLAY_UPDATE`.

```lua
payload: currencyType?: number, quantity?: number, quantityChange?: number, quantityGainSource?: number, destroyReason?: number
```

### CurrencyTransferFailed

Fires as `CURRENCY_TRANSFER_FAILED`.

```lua
payload: failureReason: AccountCurrencyTransferResult
```

### CurrencyTransferInitiated

Fires as `CURRENCY_TRANSFER_INITIATED`.

No payload.

### CurrencyTransferLogUpdate

Fires as `CURRENCY_TRANSFER_LOG_UPDATE`.

No payload.

### CurrencyTransferSuccess

Fires as `CURRENCY_TRANSFER_SUCCESS`.

No payload.

### PlayerMoney

Fires as `PLAYER_MONEY`.

No payload.
