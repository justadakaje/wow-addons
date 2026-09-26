# C_NeighborhoodInitiative

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`20` functions - `6` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddTrackedInitiativeTask

```lua
C_NeighborhoodInitiative.AddTrackedInitiativeTask(initiativeTaskID: number)
```

### GetActiveNeighborhood

```lua
C_NeighborhoodInitiative.GetActiveNeighborhood() -> neighborhoodGUID: WOWGUID
```

### GetAvailableHouseXP

```lua
C_NeighborhoodInitiative.GetAvailableHouseXP() -> availabeXP: number
```

### GetInitiativeActivityLogInfo

```lua
C_NeighborhoodInitiative.GetInitiativeActivityLogInfo() -> info?: InitiativeActivityLogInfo
```

### GetInitiativeTaskChatLink

```lua
C_NeighborhoodInitiative.GetInitiativeTaskChatLink(initiativeTaskID: number) -> link: cstring
```

### GetInitiativeTaskInfo

```lua
C_NeighborhoodInitiative.GetInitiativeTaskInfo(initiativeTaskID: number) -> info?: InitiativeTaskInfo
```

### GetInitiativeTaskRewardScaling

```lua
C_NeighborhoodInitiative.GetInitiativeTaskRewardScaling(taskID: number, numItems: number) -> scaledAmount: number
```

### GetNeighborhoodInitiativeInfo

```lua
C_NeighborhoodInitiative.GetNeighborhoodInitiativeInfo() -> info?: NeighborhoodInitiativeInfo
```

### GetRequiredLevel

```lua
C_NeighborhoodInitiative.GetRequiredLevel() -> reqLevel: number
```

### GetTrackedInitiativeTasks

```lua
C_NeighborhoodInitiative.GetTrackedInitiativeTasks() -> trackedInitiativeTasks: InitiativeTasksTracked
```

### IsInitiativeEnabled

```lua
C_NeighborhoodInitiative.IsInitiativeEnabled() -> enabled: bool
```

### IsPlayerInNeighborhoodGroup

```lua
C_NeighborhoodInitiative.IsPlayerInNeighborhoodGroup() -> inValidGroup: bool
```

### IsViewingActiveNeighborhood

```lua
C_NeighborhoodInitiative.IsViewingActiveNeighborhood() -> isViewingActiveNeighborhood: bool
```

### PlayerHasInitiativeAccess

```lua
C_NeighborhoodInitiative.PlayerHasInitiativeAccess() -> success: bool
```

### PlayerMeetsRequiredLevel

```lua
C_NeighborhoodInitiative.PlayerMeetsRequiredLevel() -> success: bool
```

### RemoveTrackedInitiativeTask

```lua
C_NeighborhoodInitiative.RemoveTrackedInitiativeTask(initiativeTaskID: number)
```

### RequestInitiativeActivityLog

```lua
C_NeighborhoodInitiative.RequestInitiativeActivityLog()
```

### RequestNeighborhoodInitiativeInfo

```lua
C_NeighborhoodInitiative.RequestNeighborhoodInitiativeInfo()
```

### SetActiveNeighborhood

```lua
C_NeighborhoodInitiative.SetActiveNeighborhood(neighborhoodGUID: WOWGUID)
```

### SetViewingNeighborhood

```lua
C_NeighborhoodInitiative.SetViewingNeighborhood(neighborhoodGUID: WOWGUID)
```

## Events

### InitiativeActivityLogUpdated

Fires as `INITIATIVE_ACTIVITY_LOG_UPDATED`.

No payload.

### InitiativeCompleted

Fires as `INITIATIVE_COMPLETED`.

```lua
payload: initiativeTitle: string
```

### InitiativeTaskCompleted

Fires as `INITIATIVE_TASK_COMPLETED`.

```lua
payload: taskName: string
```

### InitiativeTasksTrackedListChanged

Fires as `INITIATIVE_TASKS_TRACKED_LIST_CHANGED`.

```lua
payload: initiativeTaskID: number, added: bool
```

### InitiativeTasksTrackedUpdated

Fires as `INITIATIVE_TASKS_TRACKED_UPDATED`.

No payload.

### NeighborhoodInitiativeUpdated

Fires as `NEIGHBORHOOD_INITIATIVE_UPDATED`.

No payload.
