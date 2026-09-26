# C_LFGList

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`52` functions - `17` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanActiveEntryUseAutoAccept

```lua
C_LFGList.CanActiveEntryUseAutoAccept() -> canUseAutoAccept: bool
```

### CanCreateQuestGroup

```lua
C_LFGList.CanCreateQuestGroup(questID: number) -> canCreate: bool
```

### CanCreateScenarioGroup

```lua
C_LFGList.CanCreateScenarioGroup(scenarioID: number) -> canCreate: bool
```

### ClearApplicationTextFields

```lua
C_LFGList.ClearApplicationTextFields()
```

### ClearCreationTextFields

```lua
C_LFGList.ClearCreationTextFields()
```

### ClearSearchTextFields

```lua
C_LFGList.ClearSearchTextFields()
```

### ConfirmCensoredActiveEntry

```lua
C_LFGList.ConfirmCensoredActiveEntry()
```

### CopyActiveEntryInfoToCreationFields

```lua
C_LFGList.CopyActiveEntryInfoToCreationFields()
```

### CreateListing

```lua
C_LFGList.CreateListing(createData: LfgListingCreateData) -> success: bool
```

### CreateScenarioListing

```lua
C_LFGList.CreateScenarioListing(activityID: number, itemLevel: number, autoAccept: bool, privateGroup: bool, scenarioID: number) -> canCreate: bool
```

### DoesCensoredTextMatch

```lua
C_LFGList.DoesCensoredTextMatch(name: cstring, comment: cstring) -> isMatch: bool
```

### DoesEntryTitleMatchPrebuiltTitle

```lua
C_LFGList.DoesEntryTitleMatchPrebuiltTitle(activityID: number, groupID: number, playstyle?: LFGEntryPlaystyle, generalPlaystyle?: LFGEntryGeneralPlaystyle) -> matches: bool
```

### GetActiveEntryInfo

```lua
C_LFGList.GetActiveEntryInfo() -> entryData: LfgEntryData
```

### GetActivityFullName

```lua
C_LFGList.GetActivityFullName(activityID: number, questID?: number, showWarmode?: bool) -> fullName: string
```

### GetActivityGroupInfo

```lua
C_LFGList.GetActivityGroupInfo(groupID: number) -> name: string, orderIndex: number
```

### GetActivityInfoTable

```lua
C_LFGList.GetActivityInfoTable(activityID: number, questID?: number, showWarmode?: bool) -> activityInfo: GroupFinderActivityInfo
```

### GetAdvancedFilter

```lua
C_LFGList.GetAdvancedFilter() -> options: AdvancedFilterOptions
```

### GetApplicantBestDungeonScore

```lua
C_LFGList.GetApplicantBestDungeonScore(localID: number, applicantIndex: luaIndex) -> bestDungeonScoreForListing: BestDungeonScoreMapInfo
```

### GetApplicantDungeonScoreForListing

```lua
C_LFGList.GetApplicantDungeonScoreForListing(localID: number, applicantIndex: luaIndex, activityID: number) -> bestDungeonScoreForListing: BestDungeonScoreMapInfo
```

### GetApplicantInfo

```lua
C_LFGList.GetApplicantInfo(applicantID: number) -> applicantData: LfgApplicantData
```

### GetApplicantPvpRatingInfoForListing

```lua
C_LFGList.GetApplicantPvpRatingInfoForListing(localID: number, applicantIndex: luaIndex, activityID: number) -> pvpRatingInfo: PvpRatingInfo
```

### GetAvailableActivityGroups

```lua
C_LFGList.GetAvailableActivityGroups(categoryID: number, filter: number) -> activityIDs: table
```

### GetFilteredSearchResults

```lua
C_LFGList.GetFilteredSearchResults() -> totalResultsFound: number, filteredResults: table
```

### GetGroupLeaverCountsByRole

```lua
C_LFGList.GetGroupLeaverCountsByRole() -> tankLeavers: number, healerLeavers: number, damageLeavers: number
```

### GetKeystoneForActivity

```lua
C_LFGList.GetKeystoneForActivity(activityID: number) -> level: number
```

### GetLfgCategoryInfo

```lua
C_LFGList.GetLfgCategoryInfo(categoryID: number) -> categoryData: LfgCategoryData
```

### GetOwnedKeystoneActivityAndGroupAndLevel

```lua
C_LFGList.GetOwnedKeystoneActivityAndGroupAndLevel(getTimewalking: bool) -> activityID: number, groupID: number, keystoneLevel: number
```

### GetPlaystyleString

```lua
C_LFGList.GetPlaystyleString(playstyle: LFGEntryPlaystyle, generalPlaystyle: LFGEntryGeneralPlaystyle, activityInfo: GroupFinderActivityInfo) -> playstyleString: string
```

### GetPremadeGroupFinderStyle

```lua
C_LFGList.GetPremadeGroupFinderStyle() -> style: PremadeGroupFinderStyle
```

### GetSearchResultInfo

```lua
C_LFGList.GetSearchResultInfo(searchResultID: number) -> searchResultData: LfgSearchResultData
```

### GetSearchResultLeaderInfo

```lua
C_LFGList.GetSearchResultLeaderInfo(searchResultID: number) -> leaderInfo: LfgSearchResultPlayerInfo
```

### GetSearchResultPlayerInfo

```lua
C_LFGList.GetSearchResultPlayerInfo(searchResultID: number, memberIndex: luaIndex) -> playerInfo: LfgSearchResultPlayerInfo
```

### GetSearchResults

```lua
C_LFGList.GetSearchResults() -> totalResultsFound: number, results: table
```

### HasActiveEntryInfo

```lua
C_LFGList.HasActiveEntryInfo() -> hasActiveEntryInfo: bool
```

### HasSearchResultInfo

```lua
C_LFGList.HasSearchResultInfo(searchResultID: number) -> hasSearchResultInfo: bool
```

### IsCensoredActiveEntryUnresolved

```lua
C_LFGList.IsCensoredActiveEntryUnresolved() -> isUnresolved: bool
```

### IsPlayerAuthenticatedForLFG

```lua
C_LFGList.IsPlayerAuthenticatedForLFG(activityCategoryID?: number) -> isAuthenticated: bool
```

### IsPlayerValidForEndgameFieldEdits

```lua
C_LFGList.IsPlayerValidForEndgameFieldEdits() -> isValid: bool
```

### IsPremadeGroupFinderEnabled

```lua
C_LFGList.IsPremadeGroupFinderEnabled() -> enabled: bool
```

### ListingUsesEndgameEditRestrictions

```lua
C_LFGList.ListingUsesEndgameEditRestrictions(activityID: number) -> isEndgameListing: bool
```

### ReportGroupAsAdvertisement

```lua
C_LFGList.ReportGroupAsAdvertisement(searchResultID: number)
```

### RevealCensoredActiveEntry

```lua
C_LFGList.RevealCensoredActiveEntry()
```

### RevealCensoredSearchResult

```lua
C_LFGList.RevealCensoredSearchResult(searchResultID: number)
```

### SaveAdvancedFilter

```lua
C_LFGList.SaveAdvancedFilter(options: AdvancedFilterOptions)
```

### Search

```lua
C_LFGList.Search(categoryID: number, filter: number, preferredFilters: number, languageFilter?: WowLocale, searchCrossFactionListings?: bool, advancedFilter?: AdvancedFilterOptions, activityIDsFilter?: table)
```

### SetEntryTitle

```lua
C_LFGList.SetEntryTitle(activityID: number, groupID: number, playstyle?: LFGEntryPlaystyle, generalPlaystyle?: LFGEntryGeneralPlaystyle)
```

### SetSearchToActivity

```lua
C_LFGList.SetSearchToActivity(activityID: number)
```

### SetSearchToQuestID

```lua
C_LFGList.SetSearchToQuestID(questID: number)
```

### SetSearchToScenarioID

```lua
C_LFGList.SetSearchToScenarioID(scenarioID: number)
```

### UpdateListing

```lua
C_LFGList.UpdateListing(createData: LfgListingCreateData) -> success: bool
```

### ValidateRequiredDungeonScore

```lua
C_LFGList.ValidateRequiredDungeonScore(dungeonScore: number) -> passes: bool
```

### ValidateRequiredPvpRatingForActivity

```lua
C_LFGList.ValidateRequiredPvpRatingForActivity(activityID: number, rating: number) -> passes: bool
```

## Events

### LfgGroupDelistedLeadershipChange

Fires as `LFG_GROUP_DELISTED_LEADERSHIP_CHANGE`.

```lua
payload: listingName: string, automaticDelistTimeRemaining: number
```

### LfgListActiveEntryUpdate

Fires as `LFG_LIST_ACTIVE_ENTRY_UPDATE`.

```lua
payload: created?: bool
```

### LfgListApplicantListUpdated

Fires as `LFG_LIST_APPLICANT_LIST_UPDATED`.

```lua
payload: newPendingEntry?: bool, newPendingEntryWithData?: bool
```

### LfgListApplicantUpdated

Fires as `LFG_LIST_APPLICANT_UPDATED`.

```lua
payload: applicantID: number
```

### LfgListApplicationStatusUpdated

Fires as `LFG_LIST_APPLICATION_STATUS_UPDATED`.

```lua
payload: searchResultID: number, newStatus: cstring, oldStatus: cstring, groupName: kstringLfgListChat
```

### LfgListAvailabilityUpdate

Fires as `LFG_LIST_AVAILABILITY_UPDATE`.

No payload.

### LfgListCensoredActiveEntryUpdate

Fires as `LFG_LIST_CENSORED_ACTIVE_ENTRY_UPDATE`.

```lua
payload: isCensored: bool
```

### LfgListEntryCreationFailed

Fires as `LFG_LIST_ENTRY_CREATION_FAILED`.

No payload.

### LfgListEntryExpiredTimeout

Fires as `LFG_LIST_ENTRY_EXPIRED_TIMEOUT`.

No payload.

### LfgListEntryExpiredTooManyPlayers

Fires as `LFG_LIST_ENTRY_EXPIRED_TOO_MANY_PLAYERS`.

No payload.

### LfgListJoinedGroup

Fires as `LFG_LIST_JOINED_GROUP`.

```lua
payload: searchResultID: number, groupName: kstringLfgListChat
```

### LfgListRevealedCensoredActiveEntry

Fires as `LFG_LIST_REVEALED_CENSORED_ACTIVE_ENTRY`.

No payload.

### LfgListSearchFailed

Fires as `LFG_LIST_SEARCH_FAILED`.

```lua
payload: reason?: cstring
```

### LfgListSearchResultsReceived

Fires as `LFG_LIST_SEARCH_RESULTS_RECEIVED`.

No payload.

### LfgListSearchResultUpdated

Fires as `LFG_LIST_SEARCH_RESULT_UPDATED`.

```lua
payload: searchResultID: number
```

### LfgListShowSearch

Fires as `LFG_LIST_SHOW_SEARCH`.

```lua
payload: activityIDsFilter?: table
```

### LfgListUpdateSearchResults

Fires as `LFG_LIST_UPDATE_SEARCH_RESULTS`.

No payload.
