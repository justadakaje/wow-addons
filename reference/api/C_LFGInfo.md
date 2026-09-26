# C_LFGInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`23` functions - `31` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AreCrossFactionGroupQueuesAllowed

```lua
C_LFGInfo.AreCrossFactionGroupQueuesAllowed(lfgDungeonID: number) -> areCrossFactionGroupQueuesAllowed: bool
```

### CanPlayerUseGroupFinder

```lua
C_LFGInfo.CanPlayerUseGroupFinder() -> canUse: bool, failureReason: string
```

### CanPlayerUseLFD

```lua
C_LFGInfo.CanPlayerUseLFD() -> canUse: bool, failureReason: string
```

### CanPlayerUseLFR

```lua
C_LFGInfo.CanPlayerUseLFR() -> canUse: bool, failureReason: string
```

### CanPlayerUsePremadeGroup

```lua
C_LFGInfo.CanPlayerUsePremadeGroup() -> canUse: bool, failureReason: string
```

### CanPlayerUsePVP

```lua
C_LFGInfo.CanPlayerUsePVP() -> canUse: bool, failureReason: string
```

### CanPlayerUseScenarioFinder

```lua
C_LFGInfo.CanPlayerUseScenarioFinder() -> canUse: bool, failureReason: string
```

### ConfirmLfgExpandSearch

```lua
C_LFGInfo.ConfirmLfgExpandSearch()
```

### DoesActivePartyMeetPremadeLaunchCount

```lua
C_LFGInfo.DoesActivePartyMeetPremadeLaunchCount(lfgDungeonID: number) -> doesActivePartyMeetPremadeLaunchCount: bool
```

### DoesCrossFactionQueueRequireFullPremade

```lua
C_LFGInfo.DoesCrossFactionQueueRequireFullPremade(lfgDungeonID: number) -> doesCrossFactionQueueRequireFullPremade: bool
```

### GetActiveLFGDungeonName

```lua
C_LFGInfo.GetActiveLFGDungeonName() -> name: string
```

### GetAllEntriesForCategory

```lua
C_LFGInfo.GetAllEntriesForCategory(category: luaIndex) -> lfgDungeonIDs: table
```

### GetDungeonInfo

```lua
C_LFGInfo.GetDungeonInfo(lfgDungeonID: number) -> dungeonInfo: LFGDungeonInfo
```

### GetLevelUpInstances

```lua
C_LFGInfo.GetLevelUpInstances(currPlayerLevel: number, isRaid: bool) -> instances: table
```

### GetLFDLockStates

```lua
C_LFGInfo.GetLFDLockStates() -> lockInfo: table
```

### GetRoleCheckDifficultyDetails

```lua
C_LFGInfo.GetRoleCheckDifficultyDetails() -> maxLevel?: number, isLevelReduced: bool
```

### HideNameFromUI

```lua
C_LFGInfo.HideNameFromUI(dungeonID: number) -> shouldHide: bool
```

### IsGroupFinderEnabled

```lua
C_LFGInfo.IsGroupFinderEnabled() -> enabled: bool
```

### IsInLFGFollowerDungeon

```lua
C_LFGInfo.IsInLFGFollowerDungeon() -> result: bool
```

### IsInMatchmadeRaidWithoutRoleRequirements

```lua
C_LFGInfo.IsInMatchmadeRaidWithoutRoleRequirements() -> result: bool
```

### IsLFDEnabled

```lua
C_LFGInfo.IsLFDEnabled() -> enabled: bool
```

### IsLFGFollowerDungeon

```lua
C_LFGInfo.IsLFGFollowerDungeon(dungeonID: number) -> result: bool
```

### IsLFREnabled

```lua
C_LFGInfo.IsLFREnabled() -> enabled: bool
```

## Events

### IslandCompleted

Fires as `ISLAND_COMPLETED`.

```lua
payload: mapID: number, winner: number
```

### LfgBootProposalUpdate

Fires as `LFG_BOOT_PROPOSAL_UPDATE`.

No payload.

### LfgCompletionReward

Fires as `LFG_COMPLETION_REWARD`.

No payload.

### LfgCooldownsUpdated

Fires as `LFG_COOLDOWNS_UPDATED`.

No payload.

### LfgEnabledStateChanged

Fires as `LFG_ENABLED_STATE_CHANGED`.

No payload.

### LfgInvalidErrorMessage

Fires as `LFG_INVALID_ERROR_MESSAGE`.

```lua
payload: reason: number, subReason1: number, subReason2: number
```

### LfgLockInfoReceived

Fires as `LFG_LOCK_INFO_RECEIVED`.

No payload.

### LfgOfferContinue

Fires as `LFG_OFFER_CONTINUE`.

```lua
payload: name: cstring, lfgDungeonsID: number, typeID: number
```

### LfgOpenFromGossip

Fires as `LFG_OPEN_FROM_GOSSIP`.

```lua
payload: dungeonID: number
```

### LfgProposalDone

Fires as `LFG_PROPOSAL_DONE`.

No payload.

### LfgProposalFailed

Fires as `LFG_PROPOSAL_FAILED`.

No payload.

### LfgProposalShow

Fires as `LFG_PROPOSAL_SHOW`.

No payload.

### LfgProposalSucceeded

Fires as `LFG_PROPOSAL_SUCCEEDED`.

No payload.

### LfgProposalUpdate

Fires as `LFG_PROPOSAL_UPDATE`.

No payload.

### LfgQueueStatusUpdate

Fires as `LFG_QUEUE_STATUS_UPDATE`.

No payload.

### LfgReadyCheckDeclined

Fires as `LFG_READY_CHECK_DECLINED`.

```lua
payload: name: cstring
```

### LfgReadyCheckHide

Fires as `LFG_READY_CHECK_HIDE`.

No payload.

### LfgReadyCheckPlayerIsReady

Fires as `LFG_READY_CHECK_PLAYER_IS_READY`.

```lua
payload: name: cstring
```

### LfgReadyCheckShow

Fires as `LFG_READY_CHECK_SHOW`.

```lua
payload: isRequeue: bool
```

### LfgReadyCheckUpdate

Fires as `LFG_READY_CHECK_UPDATE`.

No payload.

### LfgRoleCheckDeclined

Fires as `LFG_ROLE_CHECK_DECLINED`.

No payload.

### LfgRoleCheckHide

Fires as `LFG_ROLE_CHECK_HIDE`.

No payload.

### LfgRoleCheckRoleChosen

Fires as `LFG_ROLE_CHECK_ROLE_CHOSEN`.

```lua
payload: name: cstring, isTank: bool, isHealer: bool, isDamage: bool
```

### LfgRoleCheckShow

Fires as `LFG_ROLE_CHECK_SHOW`.

```lua
payload: isRequeue: bool
```

### LfgRoleCheckUpdate

Fires as `LFG_ROLE_CHECK_UPDATE`.

No payload.

### LfgRoleUpdate

Fires as `LFG_ROLE_UPDATE`.

No payload.

### LfgUpdate

Fires as `LFG_UPDATE`.

No payload.

### LfgUpdateRandomInfo

Fires as `LFG_UPDATE_RANDOM_INFO`.

No payload.

### ShowLfgExpandSearchPrompt

Fires as `SHOW_LFG_EXPAND_SEARCH_PROMPT`.

No payload.

### UpdateLfgList

Fires as `UPDATE_LFG_LIST`.

No payload.

### WarfrontCompleted

Fires as `WARFRONT_COMPLETED`.

```lua
payload: mapID: number, winner: number
```
