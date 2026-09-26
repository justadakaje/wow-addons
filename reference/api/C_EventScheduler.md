# C_EventScheduler

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`11` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanShowEvents

```lua
C_EventScheduler.CanShowEvents() -> canShow: bool
```

### ClearReminder

```lua
C_EventScheduler.ClearReminder(eventKey: string)
```

### GetActiveContinentName

```lua
C_EventScheduler.GetActiveContinentName() -> name: string
```

### GetEventUiMapID

```lua
C_EventScheduler.GetEventUiMapID(areaPoiID: number) -> uiMapID?: number
```

### GetEventZoneName

```lua
C_EventScheduler.GetEventZoneName(areaPoiID: number) -> name?: string
```

### GetOngoingEvents

```lua
C_EventScheduler.GetOngoingEvents() -> events: table
```

### GetScheduledEvents

```lua
C_EventScheduler.GetScheduledEvents() -> events: table
```

### HasData

```lua
C_EventScheduler.HasData() -> hasData: bool
```

### HasSavedReminders

```lua
C_EventScheduler.HasSavedReminders() -> hasSavedReminders: bool
```

### RequestEvents

```lua
C_EventScheduler.RequestEvents()
```

### SetReminder

```lua
C_EventScheduler.SetReminder(eventKey: string)
```

## Events

### EventSchedulerUpdate

Fires as `EVENT_SCHEDULER_UPDATE`.

No payload.
