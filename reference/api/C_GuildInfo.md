# C_GuildInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`39` functions - `33` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AreGuildEventsEnabled

```lua
C_GuildInfo.AreGuildEventsEnabled() -> enabled: bool
```

### CanEditOfficerNote

```lua
C_GuildInfo.CanEditOfficerNote() -> canEditOfficerNote: bool
```

### CanSpeakInGuildChat

```lua
C_GuildInfo.CanSpeakInGuildChat() -> canSpeakInGuildChat: bool
```

### CanViewOfficerNote

```lua
C_GuildInfo.CanViewOfficerNote() -> canViewOfficerNote: bool
```

### Demote

```lua
C_GuildInfo.Demote(name: cstring)
```

### Disband

```lua
C_GuildInfo.Disband()
```

### GetGuildNewsInfo

```lua
C_GuildInfo.GetGuildNewsInfo(index: luaIndex) -> newsInfo: GuildNewsInfo
```

### GetGuildRankOrder

```lua
C_GuildInfo.GetGuildRankOrder(guid: WOWGUID) -> rankOrder: luaIndex
```

### GetGuildTabardInfo

```lua
C_GuildInfo.GetGuildTabardInfo(unit?: UnitToken) -> tabardInfo?: GuildTabardInfo
```

### GetInfoText

```lua
C_GuildInfo.GetInfoText() -> infoText: string
```

### GetMOTD

```lua
C_GuildInfo.GetMOTD() -> motd: string
```

### GetPreferredPlaySettings

```lua
C_GuildInfo.GetPreferredPlaySettings() -> loaded: bool, preferredLocaleID: number, preferredDatacenterLocalityID: number, lastPreferredLocaleChangeDate: time_t, lastPreferredDatacenterLocalityChangeDate: time_t, changeCooldownDays: number
```

### GetPreferredPlaySettingsFeatures

```lua
C_GuildInfo.GetPreferredPlaySettingsFeatures() -> canChangeLocale: bool, canChangeDatacenterLocality: bool
```

### GuildControlGetRankFlags

```lua
C_GuildInfo.GuildControlGetRankFlags(rankOrder: luaIndex) -> permissions: table
```

### GuildRoster

```lua
C_GuildInfo.GuildRoster()
```

### Invite

```lua
C_GuildInfo.Invite(name: cstring)
```

### IsDiscordStreamSeparate

```lua
C_GuildInfo.IsDiscordStreamSeparate() -> separateStream: bool
```

### IsEncounterGuildNewsEnabled

```lua
C_GuildInfo.IsEncounterGuildNewsEnabled() -> enabled: bool
```

### IsGuildOfficer

```lua
C_GuildInfo.IsGuildOfficer() -> isOfficer: bool
```

### IsGuildRankAssignmentAllowed

```lua
C_GuildInfo.IsGuildRankAssignmentAllowed(guid: WOWGUID, rankOrder: luaIndex) -> isGuildRankAssignmentAllowed: bool
```

### IsGuildReputationEnabled

```lua
C_GuildInfo.IsGuildReputationEnabled() -> enabled: bool
```

### Leave

```lua
C_GuildInfo.Leave()
```

### MemberExistsByName

```lua
C_GuildInfo.MemberExistsByName(name: cstring) -> exists: bool
```

### Promote

```lua
C_GuildInfo.Promote(name: cstring)
```

### QueryGuildMemberRecipes

```lua
C_GuildInfo.QueryGuildMemberRecipes(guildMemberGUID: WOWGUID, skillLineID: number)
```

### QueryGuildMembersForRecipe

```lua
C_GuildInfo.QueryGuildMembersForRecipe(skillLineID: number, recipeSpellID: number, recipeLevel?: luaIndex) -> updatedRecipeSpellID: number
```

### RemoveFromGuild

```lua
C_GuildInfo.RemoveFromGuild(guid: WOWGUID)
```

### RequestGuildRename

```lua
C_GuildInfo.RequestGuildRename(desiredName: cstring)
```

### RequestGuildRenameRefund

```lua
C_GuildInfo.RequestGuildRenameRefund()
```

### RequestPreferredPlaySettings

```lua
C_GuildInfo.RequestPreferredPlaySettings() -> startedSuccessfully: bool
```

### RequestRenameNameCheck

```lua
C_GuildInfo.RequestRenameNameCheck(desiredName: cstring)
```

### RequestRenameStatus

```lua
C_GuildInfo.RequestRenameStatus() -> ableToRequest: bool
```

### SetGuildRankOrder

```lua
C_GuildInfo.SetGuildRankOrder(guid: WOWGUID, rankOrder: luaIndex)
```

### SetInfoText

```lua
C_GuildInfo.SetInfoText(infoText: cstring)
```

### SetLeader

```lua
C_GuildInfo.SetLeader(name: cstring)
```

### SetMOTD

```lua
C_GuildInfo.SetMOTD(motd: cstring)
```

### SetNote

```lua
C_GuildInfo.SetNote(guid: WOWGUID, note: cstring, isPublic: bool)
```

### SetPreferredPlaySettings

```lua
C_GuildInfo.SetPreferredPlaySettings(preferredLocaleID: number, preferredDatacenterLocalityID: number) -> startedSuccessfully: bool
```

### Uninvite

```lua
C_GuildInfo.Uninvite(name: cstring)
```

## Events

### CloseTabardFrame

Fires as `CLOSE_TABARD_FRAME`.

No payload.

### DisableDeclineGuildInvite

Fires as `DISABLE_DECLINE_GUILD_INVITE`.

No payload.

### EnableDeclineGuildInvite

Fires as `ENABLE_DECLINE_GUILD_INVITE`.

No payload.

### GuildChallengeCompleted

Fires as `GUILD_CHALLENGE_COMPLETED`.

```lua
payload: challengeType: number, currentCount: number, maxCount: number, goldAwarded: number
```

### GuildChallengeUpdated

Fires as `GUILD_CHALLENGE_UPDATED`.

No payload.

### GuildEventLogUpdate

Fires as `GUILD_EVENT_LOG_UPDATE`.

No payload.

### GuildInviteCancel

Fires as `GUILD_INVITE_CANCEL`.

No payload.

### GuildInviteRequest

Fires as `GUILD_INVITE_REQUEST`.

```lua
payload: inviter: cstring, guildName: cstring, guildAchievementPoints: number, oldGuildName: cstring, isNewGuild?: bool, tabardInfo?: GuildTabardInfo
```

### GuildMotd

Fires as `GUILD_MOTD`.

```lua
payload: motdText: cstring
```

### GuildNewsUpdate

Fires as `GUILD_NEWS_UPDATE`.

No payload.

### GuildPartyStateUpdated

Fires as `GUILD_PARTY_STATE_UPDATED`.

```lua
payload: inGuildParty: bool
```

### GuildPreferredPlaySettingsUpdated

Fires as `GUILD_PREFERRED_PLAY_SETTINGS_UPDATED`.

```lua
payload: status: PreferredPlaySettingsStatus, preferredLocaleID: number, preferredDatacenterLocalityID: number, lastPreferredLocaleChangeDate: time_t, lastPreferredDatacenterLocalityChangeDate: time_t
```

### GuildRanksUpdate

Fires as `GUILD_RANKS_UPDATE`.

No payload.

### GuildRanksUpdateActivePlayer

Fires as `GUILD_RANKS_UPDATE_ACTIVE_PLAYER`.

No payload.

### GuildRecipeKnownByMembers

Fires as `GUILD_RECIPE_KNOWN_BY_MEMBERS`.

No payload.

### GuildRegistrarClosed

Fires as `GUILD_REGISTRAR_CLOSED`.

No payload.

### GuildRegistrarShow

Fires as `GUILD_REGISTRAR_SHOW`.

No payload.

### GuildRenameNameCheck

Fires as `GUILD_RENAME_NAME_CHECK`.

```lua
payload: desiredName: cstring, status: GuildErrorType, nameErrorToken?: cstring
```

### GuildRenameRefundResult

Fires as `GUILD_RENAME_REFUND_RESULT`.

```lua
payload: guildName: cstring, status: GuildErrorType
```

### GuildRenameRequired

Fires as `GUILD_RENAME_REQUIRED`.

```lua
payload: flagSet: bool
```

### GuildRenameStatusUpdate

Fires as `GUILD_RENAME_STATUS_UPDATE`.

```lua
payload: status: GuildRenameStatus
```

### GuildRewardsList

Fires as `GUILD_REWARDS_LIST`.

No payload.

### GuildRewardsListUpdate

Fires as `GUILD_REWARDS_LIST_UPDATE`.

No payload.

### GuildRosterUpdate

Fires as `GUILD_ROSTER_UPDATE`.

```lua
payload: canRequestRosterUpdate: bool
```

### GuildtabardUpdate

Fires as `GUILDTABARD_UPDATE`.

No payload.

### GuildTradeskillUpdate

Fires as `GUILD_TRADESKILL_UPDATE`.

No payload.

### OpenTabardFrame

Fires as `OPEN_TABARD_FRAME`.

No payload.

### PlayerGuildUpdate

Fires as `PLAYER_GUILD_UPDATE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### RequestedGuildRenameResult

Fires as `REQUESTED_GUILD_RENAME_RESULT`.

```lua
payload: newName: cstring, status: GuildErrorType
```

### RequiredGuildRenameResult

Fires as `REQUIRED_GUILD_RENAME_RESULT`.

```lua
payload: success: bool
```

### TabardCansaveChanged

Fires as `TABARD_CANSAVE_CHANGED`.

No payload.

### TabardSavePending

Fires as `TABARD_SAVE_PENDING`.

No payload.

### UnitGuildLevel

Fires as `UNIT_GUILD_LEVEL`.

```lua
payload: newLevel: number
```
