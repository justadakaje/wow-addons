# C_GMTicketInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`0` functions - `8` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Events

### GmPlayerInfo

Fires as `GM_PLAYER_INFO`.

```lua
payload: name: cstring, info: cstring
```

### ItemRestorationButtonStatus

Fires as `ITEM_RESTORATION_BUTTON_STATUS`.

No payload.

### PetitionClosed

Fires as `PETITION_CLOSED`.

No payload.

### PetitionShow

Fires as `PETITION_SHOW`.

No payload.

### PlayerReportSubmitted

Fires as `PLAYER_REPORT_SUBMITTED`.

```lua
payload: invitedByGUID: WOWGUID
```

### QuickTicketSystemStatus

Fires as `QUICK_TICKET_SYSTEM_STATUS`.

No payload.

### QuickTicketThrottleChanged

Fires as `QUICK_TICKET_THROTTLE_CHANGED`.

No payload.

### UpdateWebTicket

Fires as `UPDATE_WEB_TICKET`.

```lua
payload: hasTicket: bool, numTickets?: number, ticketStatus?: number, caseIndex?: number, waitTimeMinutes?: number, waitMessage?: cstring, caseTitle?: cstring, caseDescription?: cstring
```
