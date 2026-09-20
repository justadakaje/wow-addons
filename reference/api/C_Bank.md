# C_Bank

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`26` functions - `7` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AreAnyBankTypesViewable

```lua
C_Bank.AreAnyBankTypesViewable() -> areAnyBankTypesViewable: bool
```

### AutoDepositItemsIntoBank

```lua
C_Bank.AutoDepositItemsIntoBank(bankType: BankType)
```

### BankBagTypeAndIDToInvSlot

```lua
C_Bank.BankBagTypeAndIDToInvSlot(bankType: BankType, slotIndex: luaIndex) -> slot?: number
```

### CanDepositMoney

```lua
C_Bank.CanDepositMoney(bankType: BankType) -> canDepositMoney: bool
```

### CanPurchaseBankTab

```lua
C_Bank.CanPurchaseBankTab(bankType: BankType) -> canPurchaseBankTab: bool
```

### CanUseBank

```lua
C_Bank.CanUseBank(bankType: BankType) -> canUseBank: bool
```

### CanViewBank

```lua
C_Bank.CanViewBank(bankType: BankType) -> canViewBank: bool
```

### CanWithdrawMoney

```lua
C_Bank.CanWithdrawMoney(bankType: BankType) -> canWithdrawMoney: bool
```

### CloseBankFrame

```lua
C_Bank.CloseBankFrame()
```

### DepositMoney

```lua
C_Bank.DepositMoney(bankType: BankType, amount: WOWMONEY)
```

### DoesBankTypeSupportAutoDeposit

```lua
C_Bank.DoesBankTypeSupportAutoDeposit(bankType: BankType) -> doesBankTypeSupportAutoDeposit: bool
```

### DoesBankTypeSupportMoneyTransfer

```lua
C_Bank.DoesBankTypeSupportMoneyTransfer(bankType: BankType) -> doesBankTypeSupportMoneyTransfer: bool
```

### FetchBankLockedReason

```lua
C_Bank.FetchBankLockedReason(bankType: BankType) -> reason?: BankLockedReason
```

### FetchDepositedMoney

```lua
C_Bank.FetchDepositedMoney(bankType: BankType) -> amount: WOWMONEY
```

### FetchMaxNumBankTabs

```lua
C_Bank.FetchMaxNumBankTabs(bankType: BankType) -> numPurchasedBankTabs: number
```

### FetchNextPurchasableBankTabData

```lua
C_Bank.FetchNextPurchasableBankTabData(bankType: BankType) -> nextPurchasableTabData?: PurchasableBankTabData
```

### FetchNumPurchasedBankTabs

```lua
C_Bank.FetchNumPurchasedBankTabs(bankType: BankType) -> numPurchasedBankTabs: number
```

### FetchPurchasedBankTabData

```lua
C_Bank.FetchPurchasedBankTabData(bankType: BankType) -> purchasedBankTabData: table
```

### FetchPurchasedBankTabIDs

```lua
C_Bank.FetchPurchasedBankTabIDs(bankType: BankType) -> purchasedBankTabIDs: table
```

### FetchViewableBankTypes

```lua
C_Bank.FetchViewableBankTypes() -> viewableBankTypes: table
```

### HasMaxBankTabs

```lua
C_Bank.HasMaxBankTabs(bankType: BankType) -> hasMaxBankTabs: bool
```

### IsItemAllowedInBankType

```lua
C_Bank.IsItemAllowedInBankType(bankType: BankType, itemLocation: ItemLocation) -> isItemAllowedInBankType: bool
```

### PurchaseBankTab

```lua
C_Bank.PurchaseBankTab(bankType: BankType)
```

### ShouldUsePlayerBagsInBank

```lua
C_Bank.ShouldUsePlayerBagsInBank() -> shouldUsePlayerBagsInBank: bool
```

### UpdateBankTabSettings

```lua
C_Bank.UpdateBankTabSettings(bankType: BankType, tabID: BagIndex, tabName: cstring, tabIcon: cstring, depositFlags: BagSlotFlags)
```

### WithdrawMoney

```lua
C_Bank.WithdrawMoney(bankType: BankType, amount: WOWMONEY)
```

## Events

### BankBagSlotFlagsUpdated

Fires as `BANK_BAG_SLOT_FLAGS_UPDATED`.

```lua
payload: slot: number
```

### BankframeClosed

Fires as `BANKFRAME_CLOSED`.

No payload.

### BankframeOpened

Fires as `BANKFRAME_OPENED`.

No payload.

### BankTabsChanged

Fires as `BANK_TABS_CHANGED`.

```lua
payload: bankType: BankType
```

### BankTabSettingsUpdated

Fires as `BANK_TAB_SETTINGS_UPDATED`.

```lua
payload: bankType: BankType
```

### PlayerAccountBankTabSlotsChanged

Fires as `PLAYER_ACCOUNT_BANK_TAB_SLOTS_CHANGED`.

```lua
payload: slot: number
```

### PlayerbankslotsChanged

Fires as `PLAYERBANKSLOTS_CHANGED`.

```lua
payload: slot: number
```
