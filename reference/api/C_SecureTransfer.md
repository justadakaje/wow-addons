# C_SecureTransfer

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`11` functions - `5` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AcceptTrade

```lua
C_SecureTransfer.AcceptTrade()
```

### Cancel

```lua
C_SecureTransfer.Cancel()
```

### CompleteHousingPurchase

```lua
C_SecureTransfer.CompleteHousingPurchase()
```

### CompleteHousingVCPurchase

```lua
C_SecureTransfer.CompleteHousingVCPurchase()
```

### GetHousingPurchaseCost

```lua
C_SecureTransfer.GetHousingPurchaseCost() -> totalCost: number
```

### GetHousingPurchaseQuantity

```lua
C_SecureTransfer.GetHousingPurchaseQuantity() -> quantity: number
```

### GetHousingVCPurchaseProductID

```lua
C_SecureTransfer.GetHousingVCPurchaseProductID() -> productID: number
```

### GetMailInfo

```lua
C_SecureTransfer.GetMailInfo() -> mailInfo: MailInfo
```

### GetTradePartner

```lua
C_SecureTransfer.GetTradePartner() -> name?: cstring
```

### SendMail

```lua
C_SecureTransfer.SendMail()
```

### ShouldShowTradeOfferWarning

```lua
C_SecureTransfer.ShouldShowTradeOfferWarning() -> shouldShow: bool
```

## Events

### SecureTransferCancel

Fires as `SECURE_TRANSFER_CANCEL`.

No payload.

### SecureTransferConfirmHousingPurchase

Fires as `SECURE_TRANSFER_CONFIRM_HOUSING_PURCHASE`.

No payload.

### SecureTransferConfirmSendMail

Fires as `SECURE_TRANSFER_CONFIRM_SEND_MAIL`.

No payload.

### SecureTransferConfirmTradeAccept

Fires as `SECURE_TRANSFER_CONFIRM_TRADE_ACCEPT`.

No payload.

### SecureTransferHousingCurrencyPurchaseConfirmation

Fires as `SECURE_TRANSFER_HOUSING_CURRENCY_PURCHASE_CONFIRMATION`.

No payload.
