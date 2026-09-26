# C_PartyInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`55` functions - `33` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AllowedToDoPartyConversion

```lua
C_PartyInfo.AllowedToDoPartyConversion(toRaid: bool) -> allowed: bool
```

### CanFormCrossFactionParties

```lua
C_PartyInfo.CanFormCrossFactionParties() -> canFormCrossFactionParties: bool
```

### CanInvite

```lua
C_PartyInfo.CanInvite() -> allowedToInvite: bool
```

### CanStartInstanceAbandonVote

```lua
C_PartyInfo.CanStartInstanceAbandonVote() -> canStart: bool
```

### ChallengeModeRestrictionsActive

```lua
C_PartyInfo.ChallengeModeRestrictionsActive() -> restrictionsActive: bool
```

### ConfirmConvertToRaid

```lua
C_PartyInfo.ConfirmConvertToRaid()
```

### ConfirmInviteTravelPass

```lua
C_PartyInfo.ConfirmInviteTravelPass(targetName: cstring, targetGUID: WOWGUID)
```

### ConfirmInviteUnit

```lua
C_PartyInfo.ConfirmInviteUnit(targetName: cstring)
```

### ConfirmLeaveParty

```lua
C_PartyInfo.ConfirmLeaveParty(category?: luaIndex)
```

### ConfirmReadyCheck

```lua
C_PartyInfo.ConfirmReadyCheck(isReady: bool)
```

### ConfirmRequestInviteFromUnit

```lua
C_PartyInfo.ConfirmRequestInviteFromUnit(targetName: cstring, tank?: bool, healer?: bool, dps?: bool)
```

### ConvertToParty

```lua
C_PartyInfo.ConvertToParty()
```

### ConvertToRaid

```lua
C_PartyInfo.ConvertToRaid()
```

### DelveTeleportOut

```lua
C_PartyInfo.DelveTeleportOut()
```

### DemoteAssistant

```lua
C_PartyInfo.DemoteAssistant(name: cstring, exactNameMatch?: bool)
```

### DoCountdown

```lua
C_PartyInfo.DoCountdown(seconds: number) -> success: bool
```

### DoReadyCheck

```lua
C_PartyInfo.DoReadyCheck()
```

### GetActiveCategories

```lua
C_PartyInfo.GetActiveCategories() -> categories: table
```

### GetAvailableLootMethods

```lua
C_PartyInfo.GetAvailableLootMethods() -> methods: table
```

### GetInstanceAbandonShutdownTime

```lua
C_PartyInfo.GetInstanceAbandonShutdownTime() -> durationSeconds: number, timeLeftSeconds: number
```

### GetInstanceAbandonVoteCooldownTime

```lua
C_PartyInfo.GetInstanceAbandonVoteCooldownTime() -> durationSeconds: number, timeLeftSeconds: number
```

### GetInstanceAbandonVoteRequirements

```lua
C_PartyInfo.GetInstanceAbandonVoteRequirements() -> votesRequired: number, keystoneOwnerVoteWeight: number
```

### GetInstanceAbandonVoteResponse

```lua
C_PartyInfo.GetInstanceAbandonVoteResponse() -> response?: bool
```

### GetInstanceAbandonVoteTime

```lua
C_PartyInfo.GetInstanceAbandonVoteTime() -> durationSeconds: number, timeLeftSeconds: number
```

### GetInviteConfirmationInvalidQueues

```lua
C_PartyInfo.GetInviteConfirmationInvalidQueues(inviteGUID: WOWGUID) -> invalidQueues: table
```

### GetInviteReferralInfo

```lua
C_PartyInfo.GetInviteReferralInfo(inviteGUID: WOWGUID) -> outReferredByGuid: WOWGUID, outReferredByName: cstring, outRelationType: PartyRequestJoinRelation, outIsQuickJoin: bool, outClubId: ClubId
```

### GetLootMethod

```lua
C_PartyInfo.GetLootMethod() -> method: LootMethod, masterLootPartyID?: number, masterLooterRaidID?: number
```

### GetLootMethodStyle

```lua
C_PartyInfo.GetLootMethodStyle() -> methodStyle: LootMethodStyles
```

### GetMinItemLevel

```lua
C_PartyInfo.GetMinItemLevel(avgItemLevelCategory: AvgItemLevelCategories) -> minItemLevel: number, playerNameWithLowestItemLevel: cstring
```

### GetMinLevel

```lua
C_PartyInfo.GetMinLevel(category?: luaIndex) -> minLevel: number
```

### GetNumInstanceAbandonGroupVoteResponses

```lua
C_PartyInfo.GetNumInstanceAbandonGroupVoteResponses() -> count: number
```

### GetRestrictPings

```lua
C_PartyInfo.GetRestrictPings() -> restrictTo: RestrictPingsTo
```

### InviteUnit

```lua
C_PartyInfo.InviteUnit(targetName: cstring)
```

### IsChallengeModeActive

```lua
C_PartyInfo.IsChallengeModeActive() -> active: bool
```

### IsChallengeModeKeystoneOwner

```lua
C_PartyInfo.IsChallengeModeKeystoneOwner() -> isKeystoneOwner: bool
```

### IsCrossFactionParty

```lua
C_PartyInfo.IsCrossFactionParty(category?: luaIndex) -> isCrossFactionParty: bool
```

### IsDelveComplete

```lua
C_PartyInfo.IsDelveComplete() -> isDelveComplete: bool
```

### IsDelveInProgress

```lua
C_PartyInfo.IsDelveInProgress() -> isDelveComplete: bool
```

### IsGUIDInGroup

```lua
C_PartyInfo.IsGUIDInGroup(guid: WOWGUID, category?: luaIndex) -> isInGroup: bool
```

### IsLootMethodAvailable

```lua
C_PartyInfo.IsLootMethodAvailable(method: LootMethod) -> available: bool
```

### IsPartyFull

```lua
C_PartyInfo.IsPartyFull(category?: luaIndex) -> isFull: bool
```

### IsPartyInJailersTower

```lua
C_PartyInfo.IsPartyInJailersTower() -> isPartyInJailersTower: bool
```

### IsPartyWalkIn

```lua
C_PartyInfo.IsPartyWalkIn() -> isPartyWalkIn: bool
```

### IsRaidListEnabled

```lua
C_PartyInfo.IsRaidListEnabled() -> isRaidListEnabled: bool
```

### IsRaidListSupported

```lua
C_PartyInfo.IsRaidListSupported() -> isRaidListSupported: bool
```

### LeaveParty

```lua
C_PartyInfo.LeaveParty(category?: luaIndex)
```

### PromoteToAssistant

```lua
C_PartyInfo.PromoteToAssistant(name: cstring, exactNameMatch?: bool)
```

### PromoteToLeader

```lua
C_PartyInfo.PromoteToLeader(name: cstring, exactNameMatch?: bool)
```

### RequestInviteFromUnit

```lua
C_PartyInfo.RequestInviteFromUnit(targetName: cstring, tank?: bool, healer?: bool, dps?: bool)
```

### SetEveryoneIsAssistant

```lua
C_PartyInfo.SetEveryoneIsAssistant(isAssistant: bool) -> updated: bool
```

### SetInstanceAbandonVoteResponse

```lua
C_PartyInfo.SetInstanceAbandonVoteResponse(response: bool)
```

### SetLootMethod

```lua
C_PartyInfo.SetLootMethod(method: LootMethod, lootMaster?: string) -> success: bool
```

### SetRestrictPings

```lua
C_PartyInfo.SetRestrictPings(restrictTo: RestrictPingsTo)
```

### StartInstanceAbandonVote

```lua
C_PartyInfo.StartInstanceAbandonVote()
```

### UninviteUnit

```lua
C_PartyInfo.UninviteUnit(name: cstring, reason?: cstring, exactNameMatch?: bool)
```

## Events

### BnetRequestInviteConfirmation

Fires as `BNET_REQUEST_INVITE_CONFIRMATION`.

```lua
payload: gameAccountID: number, questSessionActive: bool, tank: bool, healer: bool, dps: bool
```

### ConvertToRaidConfirmation

Fires as `CONVERT_TO_RAID_CONFIRMATION`.

No payload.

### EnteredDifferentInstanceFromParty

Fires as `ENTERED_DIFFERENT_INSTANCE_FROM_PARTY`.

No payload.

### GroupFormed

Fires as `GROUP_FORMED`.

```lua
payload: category: number, partyGUID: WOWGUID
```

### GroupInviteConfirmation

Fires as `GROUP_INVITE_CONFIRMATION`.

No payload.

### GroupJoined

Fires as `GROUP_JOINED`.

```lua
payload: category: number, partyGUID: WOWGUID
```

### GroupLeft

Fires as `GROUP_LEFT`.

```lua
payload: category: number, partyGUID: WOWGUID
```

### GroupRosterUpdate

Fires as `GROUP_ROSTER_UPDATE`.

No payload.

### InstanceAbandonVoteFinished

Fires as `INSTANCE_ABANDON_VOTE_FINISHED`.

```lua
payload: votePassed: bool
```

### InstanceAbandonVoteStarted

Fires as `INSTANCE_ABANDON_VOTE_STARTED`.

No payload.

### InstanceAbandonVoteUpdated

Fires as `INSTANCE_ABANDON_VOTE_UPDATED`.

No payload.

### InstanceBootStart

Fires as `INSTANCE_BOOT_START`.

No payload.

### InstanceBootStop

Fires as `INSTANCE_BOOT_STOP`.

No payload.

### InstanceGroupSizeChanged

Fires as `INSTANCE_GROUP_SIZE_CHANGED`.

No payload.

### InviteToPartyConfirmation

Fires as `INVITE_TO_PARTY_CONFIRMATION`.

```lua
payload: targetName: cstring, willConvertToRaid: bool, questSessionActive: bool
```

### InviteTravelPassConfirmation

Fires as `INVITE_TRAVEL_PASS_CONFIRMATION`.

```lua
payload: targetName: cstring, targetGUID: WOWGUID, willConvertToRaid: bool, questSessionActive: bool
```

### LeavePartyConfirmation

Fires as `LEAVE_PARTY_CONFIRMATION`.

```lua
payload: reason: LeavePartyConfirmReason
```

### PartyInviteCancel

Fires as `PARTY_INVITE_CANCEL`.

No payload.

### PartyInviteRequest

Fires as `PARTY_INVITE_REQUEST`.

```lua
payload: name: cstring, isTank: bool, isHealer: bool, isDamage: bool, isNativeRealm: bool, allowMultipleRoles: bool, inviterGUID: WOWGUID, questSessionActive: bool
```

### PartyLeaderChanged

Fires as `PARTY_LEADER_CHANGED`.

No payload.

### PartyLfgRestricted

Fires as `PARTY_LFG_RESTRICTED`.

No payload.

### PartyLootMethodChanged

Fires as `PARTY_LOOT_METHOD_CHANGED`.

No payload.

### PartyMemberDisable

Fires as `PARTY_MEMBER_DISABLE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### PartyMemberEnable

Fires as `PARTY_MEMBER_ENABLE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### PlayerDifficultyChanged

Fires as `PLAYER_DIFFICULTY_CHANGED`.

No payload.

### PlayerRolesAssigned

Fires as `PLAYER_ROLES_ASSIGNED`.

No payload.

### RaidRosterUpdate

Fires as `RAID_ROSTER_UPDATE`.

No payload.

### ReadyCheck

Fires as `READY_CHECK`.

```lua
payload: initiatorName: cstring, readyCheckTimeLeft: time_t
```

### ReadyCheckConfirm

Fires as `READY_CHECK_CONFIRM`.

```lua
payload: unitTarget: UnitTokenVariant, isReady: bool
```

### ReadyCheckFinished

Fires as `READY_CHECK_FINISHED`.

```lua
payload: preempted: bool
```

### RequestInviteConfirmation

Fires as `REQUEST_INVITE_CONFIRMATION`.

```lua
payload: targetName: cstring, partyLevelLink: number, questSessionActive: bool, tank?: bool, healer?: bool, dps?: bool
```

### SocialUIRaidListSystemStatusUpdated

Fires as `SOCIAL_UI_RAID_LIST_SYSTEM_STATUS_UPDATED`.

No payload.

### VoteKickReasonNeeded

Fires as `VOTE_KICK_REASON_NEEDED`.

```lua
payload: name: cstring, resultGUID: WOWGUID
```
