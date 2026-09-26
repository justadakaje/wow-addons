# C_GuildBank

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`1` functions - `10` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### IsGuildBankEnabled

```lua
C_GuildBank.IsGuildBankEnabled() -> enabled: bool
```

## Events

### GuildbankbagslotsChanged

Fires as `GUILDBANKBAGSLOTS_CHANGED`.

No payload.

### GuildbankframeClosed

Fires as `GUILDBANKFRAME_CLOSED`.

No payload.

### GuildbankframeOpened

Fires as `GUILDBANKFRAME_OPENED`.

No payload.

### GuildbankItemLockChanged

Fires as `GUILDBANK_ITEM_LOCK_CHANGED`.

No payload.

### GuildbanklogUpdate

Fires as `GUILDBANKLOG_UPDATE`.

No payload.

### GuildbankTextChanged

Fires as `GUILDBANK_TEXT_CHANGED`.

```lua
payload: guildBankTab: luaIndex
```

### GuildbankUpdateMoney

Fires as `GUILDBANK_UPDATE_MONEY`.

No payload.

### GuildbankUpdateTabs

Fires as `GUILDBANK_UPDATE_TABS`.

No payload.

### GuildbankUpdateText

Fires as `GUILDBANK_UPDATE_TEXT`.

```lua
payload: guildBankTab: number
```

### GuildbankUpdateWithdrawmoney

Fires as `GUILDBANK_UPDATE_WITHDRAWMONEY`.

No payload.
