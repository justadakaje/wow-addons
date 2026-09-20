# C_PerksActivities

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`10` functions - `4` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddTrackedPerksActivity

```lua
C_PerksActivities.AddTrackedPerksActivity(perksActivityID: number)
```

### ClearPerksActivitiesPendingCompletion

```lua
C_PerksActivities.ClearPerksActivitiesPendingCompletion()
```

### GetAllPerksActivityTags

```lua
C_PerksActivities.GetAllPerksActivityTags() -> tags: PerksActivityTags
```

### GetPerksActivitiesInfo

```lua
C_PerksActivities.GetPerksActivitiesInfo() -> info: PerksActivitiesInfo
```

### GetPerksActivitiesPendingCompletion

```lua
C_PerksActivities.GetPerksActivitiesPendingCompletion() -> pending: PerksActivitiesPending
```

### GetPerksActivityChatLink

```lua
C_PerksActivities.GetPerksActivityChatLink(perksActivityID: number) -> link: cstring
```

### GetPerksActivityInfo

```lua
C_PerksActivities.GetPerksActivityInfo(perksActivityID: number) -> info?: PerksActivityInfo
```

### GetPerksUIThemePrefix

```lua
C_PerksActivities.GetPerksUIThemePrefix() -> kitPrefix: string
```

### GetTrackedPerksActivities

```lua
C_PerksActivities.GetTrackedPerksActivities() -> trackedPerksActivities: PerksActivitiesTracked
```

### RemoveTrackedPerksActivity

```lua
C_PerksActivities.RemoveTrackedPerksActivity(perksActivityID: number)
```

## Events

### PerksActivitiesTrackedListChanged

Fires as `PERKS_ACTIVITIES_TRACKED_LIST_CHANGED`.

```lua
payload: perksActivityID: number, added: bool
```

### PerksActivitiesTrackedUpdated

Fires as `PERKS_ACTIVITIES_TRACKED_UPDATED`.

No payload.

### PerksActivitiesUpdated

Fires as `PERKS_ACTIVITIES_UPDATED`.

No payload.

### PerksActivityCompleted

Fires as `PERKS_ACTIVITY_COMPLETED`.

```lua
payload: perksActivityID: number
```
