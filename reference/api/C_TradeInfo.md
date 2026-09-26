# C_TradeInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`4` functions - `15` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddTradeMoney

```lua
C_TradeInfo.AddTradeMoney()
```

### PickupTradeMoney

```lua
C_TradeInfo.PickupTradeMoney(amount: WOWMONEY)
```

### SetTradeMoney

```lua
C_TradeInfo.SetTradeMoney(amount: WOWMONEY)
```

### ShouldShowTradeOfferWarning

```lua
C_TradeInfo.ShouldShowTradeOfferWarning() -> shouldShow: bool
```

## Events

### PlayerTradeCurrency

Fires as `PLAYER_TRADE_CURRENCY`.

No payload.

### PlayerTradeMoney

Fires as `PLAYER_TRADE_MONEY`.

No payload.

### TradeAcceptUpdate

Fires as `TRADE_ACCEPT_UPDATE`.

```lua
payload: playerAccepted: number, targetAccepted: number
```

### TradeClosed

Fires as `TRADE_CLOSED`.

No payload.

### TradeCurrencyChanged

Fires as `TRADE_CURRENCY_CHANGED`.

No payload.

### TradeMoneyChanged

Fires as `TRADE_MONEY_CHANGED`.

No payload.

### TradePlayerItemChanged

Fires as `TRADE_PLAYER_ITEM_CHANGED`.

```lua
payload: tradeSlotIndex: number
```

### TradePotentialBindEnchant

Fires as `TRADE_POTENTIAL_BIND_ENCHANT`.

```lua
payload: canBecomeBoundForTrade: bool
```

### TradePotentialRemoveTransmog

Fires as `TRADE_POTENTIAL_REMOVE_TRANSMOG`.

```lua
payload: itemLink: cstring, tradeSlotIndex: number
```

### TradeRequest

Fires as `TRADE_REQUEST`.

```lua
payload: name: cstring
```

### TradeRequestCancel

Fires as `TRADE_REQUEST_CANCEL`.

No payload.

### TradeShow

Fires as `TRADE_SHOW`.

No payload.

### TradeTargetItemChanged

Fires as `TRADE_TARGET_ITEM_CHANGED`.

```lua
payload: tradeSlotIndex: number
```

### TradeUpdate

Fires as `TRADE_UPDATE`.

No payload.

### TradeUpdateWarnings

Fires as `TRADE_UPDATE_WARNINGS`.

No payload.
