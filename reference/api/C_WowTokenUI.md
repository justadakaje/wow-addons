# C_WowTokenUI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`2` functions - `15` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ShouldDisplayInAuctionHouse

```lua
C_WowTokenUI.ShouldDisplayInAuctionHouse() -> displayInAH: bool
```

### StartTokenSell

```lua
C_WowTokenUI.StartTokenSell(tokenGUID: WOWGUID)
```

## Events

### TokenAuctionSold

Fires as `TOKEN_AUCTION_SOLD`.

No payload.

### TokenBuyConfirmRequired

Fires as `TOKEN_BUY_CONFIRM_REQUIRED`.

No payload.

### TokenBuyResult

Fires as `TOKEN_BUY_RESULT`.

```lua
payload: result: number
```

### TokenCanVeteranBuyUpdate

Fires as `TOKEN_CAN_VETERAN_BUY_UPDATE`.

```lua
payload: result: number
```

### TokenDistributionsUpdated

Fires as `TOKEN_DISTRIBUTIONS_UPDATED`.

```lua
payload: result: number
```

### TokenMarketPriceUpdated

Fires as `TOKEN_MARKET_PRICE_UPDATED`.

```lua
payload: result: number
```

### TokenRedeemBalanceUpdated

Fires as `TOKEN_REDEEM_BALANCE_UPDATED`.

No payload.

### TokenRedeemConfirmRequired

Fires as `TOKEN_REDEEM_CONFIRM_REQUIRED`.

```lua
payload: choiceType: luaIndex
```

### TokenRedeemFrameShow

Fires as `TOKEN_REDEEM_FRAME_SHOW`.

No payload.

### TokenRedeemGameTimeUpdated

Fires as `TOKEN_REDEEM_GAME_TIME_UPDATED`.

No payload.

### TokenRedeemResult

Fires as `TOKEN_REDEEM_RESULT`.

```lua
payload: result: luaIndex, choiceType: luaIndex
```

### TokenSellConfirmed

Fires as `TOKEN_SELL_CONFIRMED`.

No payload.

### TokenSellConfirmRequired

Fires as `TOKEN_SELL_CONFIRM_REQUIRED`.

No payload.

### TokenSellResult

Fires as `TOKEN_SELL_RESULT`.

```lua
payload: result: number
```

### TokenStatusChanged

Fires as `TOKEN_STATUS_CHANGED`.

No payload.
