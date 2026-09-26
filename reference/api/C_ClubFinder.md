# C_ClubFinder

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`55` functions - `15` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ApplicantAcceptClubInvite

```lua
C_ClubFinder.ApplicantAcceptClubInvite(clubFinderGUID: WOWGUID)
```

### ApplicantDeclineClubInvite

```lua
C_ClubFinder.ApplicantDeclineClubInvite(clubFinderGUID: WOWGUID)
```

### CancelMembershipRequest

```lua
C_ClubFinder.CancelMembershipRequest(clubFinderGUID: WOWGUID)
```

### CheckAllPlayerApplicantSettings

```lua
C_ClubFinder.CheckAllPlayerApplicantSettings()
```

### ClearAllFinderCache

```lua
C_ClubFinder.ClearAllFinderCache()
```

### ClearClubApplicantsCache

```lua
C_ClubFinder.ClearClubApplicantsCache()
```

### ClearClubFinderPostingsCache

```lua
C_ClubFinder.ClearClubFinderPostingsCache()
```

### DoesPlayerBelongToClubFromClubGUID

```lua
C_ClubFinder.DoesPlayerBelongToClubFromClubGUID(clubFinderGUID: WOWGUID) -> belongsToClub: bool
```

### GetClubFinderDisableReason

```lua
C_ClubFinder.GetClubFinderDisableReason() -> disableReason?: ClubFinderDisableReason
```

### GetClubRecruitmentSettings

```lua
C_ClubFinder.GetClubRecruitmentSettings() -> settings: ClubSettingsInfo
```

### GetClubTypeFromFinderGUID

```lua
C_ClubFinder.GetClubTypeFromFinderGUID(clubFinderGUID: WOWGUID) -> clubType: ClubFinderRequestType
```

### GetFocusIndexFromFlag

```lua
C_ClubFinder.GetFocusIndexFromFlag(flags: number) -> index: number
```

### GetPlayerApplicantLocaleFlags

```lua
C_ClubFinder.GetPlayerApplicantLocaleFlags() -> localeFlags: number
```

### GetPlayerApplicantSettings

```lua
C_ClubFinder.GetPlayerApplicantSettings() -> settings: ClubSettingsInfo
```

### GetPlayerClubApplicationStatus

```lua
C_ClubFinder.GetPlayerClubApplicationStatus(clubFinderGUID: WOWGUID) -> clubStatus: PlayerClubRequestStatus
```

### GetPlayerSettingsFocusFlagsSelectedCount

```lua
C_ClubFinder.GetPlayerSettingsFocusFlagsSelectedCount() -> focusCount: number
```

### GetPostingIDFromClubFinderGUID

```lua
C_ClubFinder.GetPostingIDFromClubFinderGUID(clubFinderGUID: WOWGUID) -> postingID?: number
```

### GetRecruitingClubInfoFromClubID

```lua
C_ClubFinder.GetRecruitingClubInfoFromClubID(clubId: ClubId) -> clubInfo?: RecruitingClubInfo
```

### GetRecruitingClubInfoFromFinderGUID

```lua
C_ClubFinder.GetRecruitingClubInfoFromFinderGUID(clubFinderGUID: WOWGUID) -> clubInfo: RecruitingClubInfo
```

### GetStatusOfPostingFromClubId

```lua
C_ClubFinder.GetStatusOfPostingFromClubId(postingID: ClubId) -> postingFlags: table
```

### GetTotalMatchingCommunityListSize

```lua
C_ClubFinder.GetTotalMatchingCommunityListSize() -> totalSize: number
```

### GetTotalMatchingGuildListSize

```lua
C_ClubFinder.GetTotalMatchingGuildListSize() -> totalSize: number
```

### HasAlreadyAppliedToLinkedPosting

```lua
C_ClubFinder.HasAlreadyAppliedToLinkedPosting(clubFinderGUID: WOWGUID) -> hasAlreadyApplied: bool
```

### HasPostingBeenDelisted

```lua
C_ClubFinder.HasPostingBeenDelisted(postingID: ClubId) -> postingDelisted: bool
```

### IsCommunityFinderEnabled

```lua
C_ClubFinder.IsCommunityFinderEnabled() -> isEnabled: bool
```

### IsEnabled

```lua
C_ClubFinder.IsEnabled() -> isEnabled: bool
```

### IsListingEnabledFromFlags

```lua
C_ClubFinder.IsListingEnabledFromFlags(flags: number) -> isListed: bool
```

### IsPostingBanned

```lua
C_ClubFinder.IsPostingBanned(postingID: ClubId) -> postingBanned: bool
```

### IsValidSearchString

```lua
C_ClubFinder.IsValidSearchString(name: cstring) -> isApproved: bool
```

### LookupClubPostingFromClubFinderGUID

```lua
C_ClubFinder.LookupClubPostingFromClubFinderGUID(clubFinderGUID: WOWGUID, isLinkedPosting: bool)
```

### PlayerGetClubInvitationList

```lua
C_ClubFinder.PlayerGetClubInvitationList() -> inviteList: table
```

### PlayerRequestPendingClubsList

```lua
C_ClubFinder.PlayerRequestPendingClubsList(type: ClubFinderRequestType)
```

### PlayerReturnPendingCommunitiesList

```lua
C_ClubFinder.PlayerReturnPendingCommunitiesList() -> info: table
```

### PlayerReturnPendingGuildsList

```lua
C_ClubFinder.PlayerReturnPendingGuildsList() -> info: table
```

### PostClub

```lua
C_ClubFinder.PostClub(clubId: ClubId, itemLevelRequirement: number, name: string, description: string, avatarId: number, specs: table, type: ClubFinderRequestType, crossFaction: bool) -> succesful: bool
```

### RequestApplicantList

```lua
C_ClubFinder.RequestApplicantList(type: ClubFinderRequestType)
```

### RequestClubsList

```lua
C_ClubFinder.RequestClubsList(guildListRequested: bool, searchString: string, specIDs: table)
```

### RequestMembershipToClub

```lua
C_ClubFinder.RequestMembershipToClub(clubFinderGUID: WOWGUID, comment: string, specIDs: table)
```

### RequestNextCommunityPage

```lua
C_ClubFinder.RequestNextCommunityPage(startingIndex: number, pageSize: number)
```

### RequestNextGuildPage

```lua
C_ClubFinder.RequestNextGuildPage(startingIndex: number, pageSize: number)
```

### RequestPostingInformationFromClubId

```lua
C_ClubFinder.RequestPostingInformationFromClubId(clubId: ClubId) -> success: bool
```

### RequestSubscribedClubPostingIDs

```lua
C_ClubFinder.RequestSubscribedClubPostingIDs()
```

### ResetClubPostingMapCache

```lua
C_ClubFinder.ResetClubPostingMapCache()
```

### RespondToApplicant

```lua
C_ClubFinder.RespondToApplicant(clubFinderGUID: WOWGUID, playerGUID: WOWGUID, shouldAccept: bool, requestType: ClubFinderRequestType, playerName: string, forceAccept: bool, reported?: bool)
```

### ReturnClubApplicantList

```lua
C_ClubFinder.ReturnClubApplicantList(clubId: ClubId) -> info: table
```

### ReturnMatchingCommunityList

```lua
C_ClubFinder.ReturnMatchingCommunityList() -> recruitingClubs: table
```

### ReturnMatchingGuildList

```lua
C_ClubFinder.ReturnMatchingGuildList() -> recruitingClubs: table
```

### ReturnPendingClubApplicantList

```lua
C_ClubFinder.ReturnPendingClubApplicantList(clubId: ClubId) -> info: table
```

### SendChatWhisper

```lua
C_ClubFinder.SendChatWhisper(clubFinderGUID: WOWGUID, playerGUID: WOWGUID, applicantType: ClubFinderRequestType, name: string)
```

### SetAllRecruitmentSettings

```lua
C_ClubFinder.SetAllRecruitmentSettings(value: number)
```

### SetPlayerApplicantLocaleFlags

```lua
C_ClubFinder.SetPlayerApplicantLocaleFlags(localeFlags: number)
```

### SetPlayerApplicantSettings

```lua
C_ClubFinder.SetPlayerApplicantSettings(index: number, checked: bool)
```

### SetRecruitmentLocale

```lua
C_ClubFinder.SetRecruitmentLocale(locale: number)
```

### SetRecruitmentSettings

```lua
C_ClubFinder.SetRecruitmentSettings(index: number, checked: bool)
```

### ShouldShowClubFinder

```lua
C_ClubFinder.ShouldShowClubFinder() -> shouldShow: bool
```

## Events

### ClubFinderApplicantInviteRecieved

Fires as `CLUB_FINDER_APPLICANT_INVITE_RECIEVED`.

```lua
payload: clubFinderGUIDs: table
```

### ClubFinderApplicationsUpdated

Fires as `CLUB_FINDER_APPLICATIONS_UPDATED`.

```lua
payload: type: ClubFinderRequestType, clubFinderGUIDs: table
```

### ClubFinderCanWhisperApplicant

Fires as `CLUB_FINDER_CAN_WHISPER_APPLICANT`.

```lua
payload: applicant: WOWGUID
```

### ClubFinderClubListReturned

Fires as `CLUB_FINDER_CLUB_LIST_RETURNED`.

```lua
payload: type: ClubFinderRequestType
```

### ClubFinderClubReported

Fires as `CLUB_FINDER_CLUB_REPORTED`.

```lua
payload: type: ClubFinderRequestType, clubFinderGUID: WOWGUID
```

### ClubFinderCommunityOfflineJoin

Fires as `CLUB_FINDER_COMMUNITY_OFFLINE_JOIN`.

```lua
payload: clubId: ClubId
```

### ClubFinderEnabledOrDisabled

Fires as `CLUB_FINDER_ENABLED_OR_DISABLED`.

No payload.

### ClubFinderGuildRealmNameUpdated

Fires as `CLUB_FINDER_GUILD_REALM_NAME_UPDATED`.

```lua
payload: clubFinderGUID: WOWGUID, realmName: string
```

### ClubFinderLinkedClubReturned

Fires as `CLUB_FINDER_LINKED_CLUB_RETURNED`.

```lua
payload: clubInfo: RecruitingClubInfo
```

### ClubFinderMembershipListChanged

Fires as `CLUB_FINDER_MEMBERSHIP_LIST_CHANGED`.

No payload.

### ClubFinderPlayerPendingListRecieved

Fires as `CLUB_FINDER_PLAYER_PENDING_LIST_RECIEVED`.

```lua
payload: type: ClubFinderRequestType
```

### ClubFinderPostUpdated

Fires as `CLUB_FINDER_POST_UPDATED`.

```lua
payload: clubFinderGUIDs: table
```

### ClubFinderRecruitListChanged

Fires as `CLUB_FINDER_RECRUIT_LIST_CHANGED`.

No payload.

### ClubFinderRecruitmentPostReturned

Fires as `CLUB_FINDER_RECRUITMENT_POST_RETURNED`.

```lua
payload: type: ClubFinderRequestType
```

### ClubFinderRecruitsUpdated

Fires as `CLUB_FINDER_RECRUITS_UPDATED`.

```lua
payload: type: ClubFinderRequestType
```
