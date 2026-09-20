# C_Calendar

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`90` functions - `13` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddEvent

```lua
C_Calendar.AddEvent()
```

### AreNamesReady

```lua
C_Calendar.AreNamesReady() -> ready: bool
```

### CanAddEvent

```lua
C_Calendar.CanAddEvent() -> canAddEvent: bool
```

### CanSendInvite

```lua
C_Calendar.CanSendInvite() -> canSendInvite: bool
```

### CloseEvent

```lua
C_Calendar.CloseEvent()
```

### ContextMenuEventCanComplain

```lua
C_Calendar.ContextMenuEventCanComplain(offsetMonths: number, monthDay: luaIndex, eventIndex: luaIndex) -> canComplain: bool
```

### ContextMenuEventCanEdit

```lua
C_Calendar.ContextMenuEventCanEdit(offsetMonths: number, monthDay: luaIndex, eventIndex: luaIndex) -> canEdit: bool
```

### ContextMenuEventCanRemove

```lua
C_Calendar.ContextMenuEventCanRemove(offsetMonths: number, monthDay: luaIndex, eventIndex: luaIndex) -> canRemove: bool
```

### ContextMenuEventClipboard

```lua
C_Calendar.ContextMenuEventClipboard() -> exists: bool
```

### ContextMenuEventCopy

```lua
C_Calendar.ContextMenuEventCopy()
```

### ContextMenuEventGetCalendarType

```lua
C_Calendar.ContextMenuEventGetCalendarType() -> calendarType?: string
```

### ContextMenuEventPaste

```lua
C_Calendar.ContextMenuEventPaste(offsetMonths: number, monthDay: luaIndex)
```

### ContextMenuEventRemove

```lua
C_Calendar.ContextMenuEventRemove()
```

### ContextMenuEventSignUp

```lua
C_Calendar.ContextMenuEventSignUp()
```

### ContextMenuGetEventIndex

```lua
C_Calendar.ContextMenuGetEventIndex() -> info: CalendarEventIndexInfo
```

### ContextMenuInviteAvailable

```lua
C_Calendar.ContextMenuInviteAvailable()
```

### ContextMenuInviteDecline

```lua
C_Calendar.ContextMenuInviteDecline()
```

### ContextMenuInviteRemove

```lua
C_Calendar.ContextMenuInviteRemove()
```

### ContextMenuInviteTentative

```lua
C_Calendar.ContextMenuInviteTentative()
```

### ContextMenuSelectEvent

```lua
C_Calendar.ContextMenuSelectEvent(offsetMonths: number, monthDay: luaIndex, eventIndex: luaIndex)
```

### CreateCommunitySignUpEvent

```lua
C_Calendar.CreateCommunitySignUpEvent()
```

### CreateGuildAnnouncementEvent

```lua
C_Calendar.CreateGuildAnnouncementEvent()
```

### CreateGuildSignUpEvent

```lua
C_Calendar.CreateGuildSignUpEvent()
```

### CreatePlayerEvent

```lua
C_Calendar.CreatePlayerEvent()
```

### EventAvailable

```lua
C_Calendar.EventAvailable()
```

### EventCanEdit

```lua
C_Calendar.EventCanEdit() -> canEdit: bool
```

### EventClearAutoApprove

```lua
C_Calendar.EventClearAutoApprove()
```

### EventClearLocked

```lua
C_Calendar.EventClearLocked()
```

### EventClearModerator

```lua
C_Calendar.EventClearModerator(inviteIndex: luaIndex)
```

### EventDecline

```lua
C_Calendar.EventDecline()
```

### EventGetCalendarType

```lua
C_Calendar.EventGetCalendarType() -> calendarType?: string
```

### EventGetClubId

```lua
C_Calendar.EventGetClubId() -> info?: ClubId
```

### EventGetInvite

```lua
C_Calendar.EventGetInvite(eventIndex: luaIndex) -> info: CalendarEventInviteInfo
```

### EventGetInviteResponseTime

```lua
C_Calendar.EventGetInviteResponseTime(eventIndex: luaIndex) -> time: CalendarTime
```

### EventGetInviteSortCriterion

```lua
C_Calendar.EventGetInviteSortCriterion() -> criterion: string, reverse: bool
```

### EventGetSelectedInvite

```lua
C_Calendar.EventGetSelectedInvite() -> inviteIndex?: luaIndex
```

### EventGetStatusOptions

```lua
C_Calendar.EventGetStatusOptions(eventIndex: luaIndex) -> options: table
```

### EventGetTextures

```lua
C_Calendar.EventGetTextures(eventType: CalendarEventType) -> textures: table
```

### EventGetTypes

```lua
C_Calendar.EventGetTypes() -> types: table
```

### EventGetTypesDisplayOrdered

```lua
C_Calendar.EventGetTypesDisplayOrdered() -> infos: table
```

### EventHasPendingInvite

```lua
C_Calendar.EventHasPendingInvite() -> hasPendingInvite: bool
```

### EventHaveSettingsChanged

```lua
C_Calendar.EventHaveSettingsChanged() -> haveSettingsChanged: bool
```

### EventInvite

```lua
C_Calendar.EventInvite(name: cstring)
```

### EventRemoveInvite

```lua
C_Calendar.EventRemoveInvite(inviteIndex: luaIndex)
```

### EventRemoveInviteByGuid

```lua
C_Calendar.EventRemoveInviteByGuid(guid: WOWGUID)
```

### EventSelectInvite

```lua
C_Calendar.EventSelectInvite(inviteIndex: luaIndex)
```

### EventSetAutoApprove

```lua
C_Calendar.EventSetAutoApprove()
```

### EventSetClubId

```lua
C_Calendar.EventSetClubId(clubId?: ClubId)
```

### EventSetDate

```lua
C_Calendar.EventSetDate(month: luaIndex, monthDay: luaIndex, year: number)
```

### EventSetDescription

```lua
C_Calendar.EventSetDescription(description: cstring)
```

### EventSetInviteStatus

```lua
C_Calendar.EventSetInviteStatus(eventIndex: luaIndex, status: CalendarStatus)
```

### EventSetLocked

```lua
C_Calendar.EventSetLocked()
```

### EventSetModerator

```lua
C_Calendar.EventSetModerator(inviteIndex: luaIndex)
```

### EventSetTextureID

```lua
C_Calendar.EventSetTextureID(textureIndex: luaIndex)
```

### EventSetTime

```lua
C_Calendar.EventSetTime(hour: number, minute: number)
```

### EventSetTitle

```lua
C_Calendar.EventSetTitle(title: cstring)
```

### EventSetType

```lua
C_Calendar.EventSetType(typeIndex: CalendarEventType)
```

### EventSignUp

```lua
C_Calendar.EventSignUp()
```

### EventSortInvites

```lua
C_Calendar.EventSortInvites(criterion: cstring, reverse: bool)
```

### EventTentative

```lua
C_Calendar.EventTentative()
```

### GetClubCalendarEvents

```lua
C_Calendar.GetClubCalendarEvents(clubId: ClubId, startTime: CalendarTime, endTime: CalendarTime) -> events: table
```

### GetDayEvent

```lua
C_Calendar.GetDayEvent(monthOffset: number, monthDay: luaIndex, index: luaIndex) -> event: CalendarDayEvent
```

### GetDefaultGuildFilter

```lua
C_Calendar.GetDefaultGuildFilter() -> info: CalendarGuildFilterInfo
```

### GetEventIndex

```lua
C_Calendar.GetEventIndex() -> info: CalendarEventIndexInfo
```

### GetEventIndexInfo

```lua
C_Calendar.GetEventIndexInfo(eventID: CalendarEventID, monthOffset?: number, monthDay?: number) -> eventIndexInfo?: CalendarEventIndexInfo
```

### GetEventInfo

```lua
C_Calendar.GetEventInfo() -> info: CalendarEventInfo
```

### GetFirstPendingInvite

```lua
C_Calendar.GetFirstPendingInvite(offsetMonths: number, monthDay: luaIndex) -> firstPendingInvite?: luaIndex
```

### GetGuildEventInfo

```lua
C_Calendar.GetGuildEventInfo(index: luaIndex) -> info: CalendarGuildEventInfo
```

### GetGuildEventSelectionInfo

```lua
C_Calendar.GetGuildEventSelectionInfo(index: luaIndex) -> info: CalendarEventIndexInfo
```

### GetHolidayInfo

```lua
C_Calendar.GetHolidayInfo(monthOffset: number, monthDay: luaIndex, index: luaIndex) -> event: CalendarHolidayInfo
```

### GetMaxCreateDate

```lua
C_Calendar.GetMaxCreateDate() -> maxCreateDate: CalendarTime
```

### GetMinDate

```lua
C_Calendar.GetMinDate() -> minDate: CalendarTime
```

### GetMonthInfo

```lua
C_Calendar.GetMonthInfo(offsetMonths: number) -> monthInfo: CalendarMonthInfo
```

### GetNextClubId

```lua
C_Calendar.GetNextClubId() -> clubId?: ClubId
```

### GetNumDayEvents

```lua
C_Calendar.GetNumDayEvents(offsetMonths: number, monthDay: luaIndex) -> numDayEvents: number
```

### GetNumGuildEvents

```lua
C_Calendar.GetNumGuildEvents() -> numGuildEvents: number
```

### GetNumInvites

```lua
C_Calendar.GetNumInvites() -> num: number
```

### GetNumPendingInvites

```lua
C_Calendar.GetNumPendingInvites() -> num: number
```

### GetRaidInfo

```lua
C_Calendar.GetRaidInfo(offsetMonths: number, monthDay: luaIndex, eventIndex: luaIndex) -> info: CalendarRaidInfo
```

### IsActionPending

```lua
C_Calendar.IsActionPending() -> actionPending: bool
```

### IsEventOpen

```lua
C_Calendar.IsEventOpen() -> isOpen: bool
```

### MassInviteCommunity

```lua
C_Calendar.MassInviteCommunity(clubId: ClubId, minLevel: number, maxLevel: number, maxRankOrder?: luaIndex)
```

### MassInviteGuild

```lua
C_Calendar.MassInviteGuild(minLevel: number, maxLevel: number, maxRankOrder: luaIndex)
```

### OpenCalendar

```lua
C_Calendar.OpenCalendar()
```

### OpenEvent

```lua
C_Calendar.OpenEvent(offsetMonths: number, monthDay: luaIndex, index: luaIndex) -> success: bool
```

### RemoveEvent

```lua
C_Calendar.RemoveEvent()
```

### SetAbsMonth

```lua
C_Calendar.SetAbsMonth(month: luaIndex, year: number)
```

### SetMonth

```lua
C_Calendar.SetMonth(offsetMonths: number)
```

### SetNextClubId

```lua
C_Calendar.SetNextClubId(clubId?: ClubId)
```

### UpdateEvent

```lua
C_Calendar.UpdateEvent()
```

## Events

### CalendarActionPending

Fires as `CALENDAR_ACTION_PENDING`.

```lua
payload: pending: bool
```

### CalendarCloseEvent

Fires as `CALENDAR_CLOSE_EVENT`.

No payload.

### CalendarEventAlarm

Fires as `CALENDAR_EVENT_ALARM`.

```lua
payload: title: cstring, hour: number, minute: number
```

### CalendarNewEvent

Fires as `CALENDAR_NEW_EVENT`.

```lua
payload: isCopy: bool
```

### CalendarOpenEvent

Fires as `CALENDAR_OPEN_EVENT`.

```lua
payload: calendarType: cstring
```

### CalendarUpdateError

Fires as `CALENDAR_UPDATE_ERROR`.

```lua
payload: errorReason: cstring
```

### CalendarUpdateErrorWithCount

Fires as `CALENDAR_UPDATE_ERROR_WITH_COUNT`.

```lua
payload: errorReason: cstring, count: number
```

### CalendarUpdateErrorWithPlayerName

Fires as `CALENDAR_UPDATE_ERROR_WITH_PLAYER_NAME`.

```lua
payload: errorReason: cstring, playerName: cstring
```

### CalendarUpdateEvent

Fires as `CALENDAR_UPDATE_EVENT`.

No payload.

### CalendarUpdateEventList

Fires as `CALENDAR_UPDATE_EVENT_LIST`.

No payload.

### CalendarUpdateGuildEvents

Fires as `CALENDAR_UPDATE_GUILD_EVENTS`.

No payload.

### CalendarUpdateInviteList

Fires as `CALENDAR_UPDATE_INVITE_LIST`.

```lua
payload: hasCompleteList?: bool
```

### CalendarUpdatePendingInvites

Fires as `CALENDAR_UPDATE_PENDING_INVITES`.

No payload.
