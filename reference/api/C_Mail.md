# C_Mail

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`5` functions - `13` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanCheckInbox

```lua
C_Mail.CanCheckInbox() -> canCheckInbox: bool, secondsUntilAllowed: number
```

### GetCraftingOrderMailInfo

```lua
C_Mail.GetCraftingOrderMailInfo(inboxIndex: luaIndex) -> info?: CraftingOrderMailInfo
```

### HasInboxMoney

```lua
C_Mail.HasInboxMoney(inboxIndex: luaIndex) -> inboxItemHasMoneyAttached: bool
```

### IsCommandPending

```lua
C_Mail.IsCommandPending() -> isCommandPending: bool
```

### SetOpeningAll

```lua
C_Mail.SetOpeningAll(openingAll: bool)
```

## Events

### CloseInboxItem

Fires as `CLOSE_INBOX_ITEM`.

```lua
payload: mailIndex: luaIndex
```

### MailClosed

Fires as `MAIL_CLOSED`.

No payload.

### MailFailed

Fires as `MAIL_FAILED`.

```lua
payload: itemID?: number
```

### MailInboxUpdate

Fires as `MAIL_INBOX_UPDATE`.

No payload.

### MailLockSendItems

Fires as `MAIL_LOCK_SEND_ITEMS`.

```lua
payload: attachSlot: luaIndex, itemLink: cstring
```

### MailSendInfoUpdate

Fires as `MAIL_SEND_INFO_UPDATE`.

No payload.

### MailSendSuccess

Fires as `MAIL_SEND_SUCCESS`.

No payload.

### MailShow

Fires as `MAIL_SHOW`.

No payload.

### MailSuccess

Fires as `MAIL_SUCCESS`.

```lua
payload: itemID?: number
```

### MailUnlockSendItems

Fires as `MAIL_UNLOCK_SEND_ITEMS`.

No payload.

### SendMailCodChanged

Fires as `SEND_MAIL_COD_CHANGED`.

No payload.

### SendMailMoneyChanged

Fires as `SEND_MAIL_MONEY_CHANGED`.

No payload.

### UpdatePendingMail

Fires as `UPDATE_PENDING_MAIL`.

No payload.
