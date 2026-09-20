# C_BlackMarketInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`0` functions - `7` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Events

### BlackMarketBidResult

Fires as `BLACK_MARKET_BID_RESULT`.

```lua
payload: marketID: number, resultCode: number
```

### BlackMarketClose

Fires as `BLACK_MARKET_CLOSE`.

No payload.

### BlackMarketItemUpdate

Fires as `BLACK_MARKET_ITEM_UPDATE`.

No payload.

### BlackMarketOpen

Fires as `BLACK_MARKET_OPEN`.

No payload.

### BlackMarketOutbid

Fires as `BLACK_MARKET_OUTBID`.

```lua
payload: marketID: number, itemID: number
```

### BlackMarketUnavailable

Fires as `BLACK_MARKET_UNAVAILABLE`.

No payload.

### BlackMarketWon

Fires as `BLACK_MARKET_WON`.

```lua
payload: marketID: number, itemID: number
```
