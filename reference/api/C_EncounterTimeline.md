# C_EncounterTimeline

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`34` functions - `11` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddEditModeEvents

```lua
C_EncounterTimeline.AddEditModeEvents() -> loopTimerDuration: Seconds
```

### AddScriptEvent

```lua
C_EncounterTimeline.AddScriptEvent(eventInfo: EncounterTimelineScriptEventRequest) -> eventID: EncounterTimelineEventID
```

### CancelAllScriptEvents

```lua
C_EncounterTimeline.CancelAllScriptEvents()
```

### CancelEditModeEvents

```lua
C_EncounterTimeline.CancelEditModeEvents()
```

### CancelScriptEvent

```lua
C_EncounterTimeline.CancelScriptEvent(eventID: EncounterTimelineEventID)
```

### FinishScriptEvent

```lua
C_EncounterTimeline.FinishScriptEvent(eventID: EncounterTimelineEventID)
```

### GetCurrentTime

```lua
C_EncounterTimeline.GetCurrentTime() -> currentTime: Seconds
```

### GetEventColor

```lua
C_EncounterTimeline.GetEventColor(eventID: EncounterTimelineEventID, overrideTrigger?: EncounterEventColorTrigger) -> color: colorRGBA
```

### GetEventCountBySource

```lua
C_EncounterTimeline.GetEventCountBySource(source: EncounterTimelineEventSource) -> count: number
```

### GetEventHighlightTime

```lua
C_EncounterTimeline.GetEventHighlightTime() -> highlightTime: Seconds
```

### GetEventInfo

```lua
C_EncounterTimeline.GetEventInfo(eventID: EncounterTimelineEventID) -> info: EncounterTimelineEventInfo
```

### GetEventList

```lua
C_EncounterTimeline.GetEventList() -> events: table
```

### GetEventState

```lua
C_EncounterTimeline.GetEventState(eventID: EncounterTimelineEventID) -> state: EncounterTimelineEventState
```

### GetEventTimeElapsed

```lua
C_EncounterTimeline.GetEventTimeElapsed(eventID: EncounterTimelineEventID) -> timeElapsed: Seconds
```

### GetEventTimer

```lua
C_EncounterTimeline.GetEventTimer(eventID: EncounterTimelineEventID) -> duration?: LuaDurationObject
```

### GetEventTimeRemaining

```lua
C_EncounterTimeline.GetEventTimeRemaining(eventID: EncounterTimelineEventID) -> timeRemaining: Seconds
```

### GetEventTrack

```lua
C_EncounterTimeline.GetEventTrack(eventID: EncounterTimelineEventID) -> track: EncounterTimelineTrack, trackSortIndex?: luaIndex
```

### GetSortedEventList

```lua
C_EncounterTimeline.GetSortedEventList(maxEventCount?: number, maxEventDuration?: Seconds, excludeTerminalStates: bool, excludeHiddenEvents: bool) -> events: table
```

### GetTrackInfo

```lua
C_EncounterTimeline.GetTrackInfo(track: EncounterTimelineTrack) -> trackInfo: EncounterTimelineTrackInfo
```

### GetTrackList

```lua
C_EncounterTimeline.GetTrackList() -> tracks: table
```

### GetTrackMaxEventDuration

```lua
C_EncounterTimeline.GetTrackMaxEventDuration(track: EncounterTimelineTrack) -> maxEventDuration: Seconds
```

### GetTrackType

```lua
C_EncounterTimeline.GetTrackType(track: EncounterTimelineTrack) -> trackType: EncounterTimelineTrackType
```

### GetViewType

```lua
C_EncounterTimeline.GetViewType() -> viewType: EncounterTimelineViewType
```

### HasActiveEvents

```lua
C_EncounterTimeline.HasActiveEvents() -> hasActiveEvents: bool
```

### HasAnyEvents

```lua
C_EncounterTimeline.HasAnyEvents() -> hasAnyEvents: bool
```

### HasPausedEvents

```lua
C_EncounterTimeline.HasPausedEvents() -> hasPausedEvents: bool
```

### HasVisibleEvents

```lua
C_EncounterTimeline.HasVisibleEvents() -> hasVisibleEvents: bool
```

### IsEventBlocked

```lua
C_EncounterTimeline.IsEventBlocked(eventID: EncounterTimelineEventID) -> blocked: bool
```

### IsFeatureAvailable

```lua
C_EncounterTimeline.IsFeatureAvailable() -> isAvailable: bool
```

### IsFeatureEnabled

```lua
C_EncounterTimeline.IsFeatureEnabled() -> isAvailableAndEnabled: bool
```

### PauseScriptEvent

```lua
C_EncounterTimeline.PauseScriptEvent(eventID: EncounterTimelineEventID)
```

### ResumeScriptEvent

```lua
C_EncounterTimeline.ResumeScriptEvent(eventID: EncounterTimelineEventID)
```

### SetEventIconTextures

```lua
C_EncounterTimeline.SetEventIconTextures(eventID: EncounterTimelineEventID, includeIcons: EncounterEventIconmask, textures: table)
```

### SetViewType

```lua
C_EncounterTimeline.SetViewType(viewType: EncounterTimelineViewType)
```

## Events

### EncounterTimelineEventAdded

Fires as `ENCOUNTER_TIMELINE_EVENT_ADDED`.

```lua
payload: eventInfo: EncounterTimelineEventInfo
```

### EncounterTimelineEventBlockStateChanged

Fires as `ENCOUNTER_TIMELINE_EVENT_BLOCK_STATE_CHANGED`.

```lua
payload: eventID: EncounterTimelineEventID
```

### EncounterTimelineEventColorChanged

Fires as `ENCOUNTER_TIMELINE_EVENT_COLOR_CHANGED`.

```lua
payload: eventID: EncounterTimelineEventID
```

### EncounterTimelineEventHighlight

Fires as `ENCOUNTER_TIMELINE_EVENT_HIGHLIGHT`.

```lua
payload: eventID: EncounterTimelineEventID
```

### EncounterTimelineEventRemoved

Fires as `ENCOUNTER_TIMELINE_EVENT_REMOVED`.

```lua
payload: eventID: EncounterTimelineEventID
```

### EncounterTimelineEventStateChanged

Fires as `ENCOUNTER_TIMELINE_EVENT_STATE_CHANGED`.

```lua
payload: eventID: EncounterTimelineEventID
```

### EncounterTimelineEventTrackChanged

Fires as `ENCOUNTER_TIMELINE_EVENT_TRACK_CHANGED`.

```lua
payload: eventID: EncounterTimelineEventID
```

### EncounterTimelineLayoutUpdated

Fires as `ENCOUNTER_TIMELINE_LAYOUT_UPDATED`.

No payload.

### EncounterTimelineStateUpdated

Fires as `ENCOUNTER_TIMELINE_STATE_UPDATED`.

No payload.

### EncounterTimelineViewActivated

Fires as `ENCOUNTER_TIMELINE_VIEW_ACTIVATED`.

```lua
payload: viewType: EncounterTimelineViewType
```

### EncounterTimelineViewDeactivated

Fires as `ENCOUNTER_TIMELINE_VIEW_DEACTIVATED`.

```lua
payload: viewType: EncounterTimelineViewType
```
