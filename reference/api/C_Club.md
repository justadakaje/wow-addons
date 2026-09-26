# C_Club

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`84` functions - `30` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AcceptInvitation

```lua
C_Club.AcceptInvitation(clubId: ClubId)
```

### AddClubStreamChatChannel

```lua
C_Club.AddClubStreamChatChannel(clubId: ClubId, streamId: ClubStreamId)
```

### AdvanceStreamViewMarker

```lua
C_Club.AdvanceStreamViewMarker(clubId: ClubId, streamId: ClubStreamId)
```

### AreMembersReady

```lua
C_Club.AreMembersReady(clubId: ClubId) -> membersReady: bool
```

### AssignMemberRole

```lua
C_Club.AssignMemberRole(clubId: ClubId, memberId: ClubMemberOpaqueId, roleId: ClubRoleIdentifier)
```

### CanResolvePlayerLocationFromClubMessageData

```lua
C_Club.CanResolvePlayerLocationFromClubMessageData(clubId: ClubId, streamId: ClubStreamId, epoch: BigUInteger, position: BigUInteger) -> canResolve: bool
```

### ClearAutoAdvanceStreamViewMarker

```lua
C_Club.ClearAutoAdvanceStreamViewMarker()
```

### ClearClubPresenceSubscription

```lua
C_Club.ClearClubPresenceSubscription()
```

### CompareBattleNetDisplayName

```lua
C_Club.CompareBattleNetDisplayName(clubId: ClubId, lhsMemberId: number, rhsMemberId: number) -> comparison: number
```

### CreateClub

```lua
C_Club.CreateClub(name: string, shortName?: string, description: string, clubType: ClubType, avatarId: number, isCrossFaction?: bool)
```

### CreateStream

```lua
C_Club.CreateStream(clubId: ClubId, name: string, subject: string, leadersAndModeratorsOnly: bool)
```

### CreateTicket

```lua
C_Club.CreateTicket(clubId: ClubId, allowedRedeemCount?: number, duration?: number, defaultStreamId?: ClubStreamId, isCrossFaction?: bool)
```

### DeclineInvitation

```lua
C_Club.DeclineInvitation(clubId: ClubId)
```

### DestroyClub

```lua
C_Club.DestroyClub(clubId: ClubId)
```

### DestroyMessage

```lua
C_Club.DestroyMessage(clubId: ClubId, streamId: ClubStreamId, messageId: ClubMessageIdentifier)
```

### DestroyStream

```lua
C_Club.DestroyStream(clubId: ClubId, streamId: ClubStreamId)
```

### DestroyTicket

```lua
C_Club.DestroyTicket(clubId: ClubId, ticketId: string)
```

### DoesAnyCommunityHaveUnreadMessages

```lua
C_Club.DoesAnyCommunityHaveUnreadMessages() -> hasUnreadMessages: bool
```

### DoesCommunityHaveMembersOfTheOppositeFaction

```lua
C_Club.DoesCommunityHaveMembersOfTheOppositeFaction(clubId: ClubId) -> hasMembersOfOppositeFaction: bool
```

### EditClub

```lua
C_Club.EditClub(clubId: ClubId, name?: string, shortName?: string, description?: string, avatarId?: number, broadcast?: string, crossFaction?: bool)
```

### EditMessage

```lua
C_Club.EditMessage(clubId: ClubId, streamId: ClubStreamId, messageId: ClubMessageIdentifier, message: string)
```

### EditStream

```lua
C_Club.EditStream(clubId: ClubId, streamId: ClubStreamId, name?: string, subject?: string, leadersAndModeratorsOnly?: bool)
```

### Flush

```lua
C_Club.Flush()
```

### FocusCommunityStreams

```lua
C_Club.FocusCommunityStreams()
```

### FocusMembers

```lua
C_Club.FocusMembers(clubId: ClubId)
```

### FocusStream

```lua
C_Club.FocusStream(clubId: ClubId, streamId: ClubStreamId) -> focused: bool
```

### GetAssignableRoles

```lua
C_Club.GetAssignableRoles(clubId: ClubId, memberId: ClubMemberOpaqueId) -> assignableRoles: table
```

### GetAvatarIdList

```lua
C_Club.GetAvatarIdList(clubType: ClubType) -> avatarIds?: table
```

### GetClubCapacity

```lua
C_Club.GetClubCapacity() -> capacity: number
```

### GetClubInfo

```lua
C_Club.GetClubInfo(clubId: ClubId) -> info?: ClubInfo
```

### GetClubLimits

```lua
C_Club.GetClubLimits(clubType: ClubType) -> clubLimits: ClubLimits
```

### GetClubMembers

```lua
C_Club.GetClubMembers(clubId: ClubId, streamId?: ClubStreamId) -> members: table
```

### GetClubPrivileges

```lua
C_Club.GetClubPrivileges(clubId: ClubId) -> privilegeInfo: ClubPrivilegeInfo
```

### GetClubStreamNotificationSettings

```lua
C_Club.GetClubStreamNotificationSettings(clubId: ClubId) -> settings: table
```

### GetCommunityNameResultText

```lua
C_Club.GetCommunityNameResultText(result: ValidateNameResult) -> errorCode?: cstring
```

### GetGuildClubId

```lua
C_Club.GetGuildClubId() -> guildClubId?: ClubId
```

### GetInfoFromLastCommunityChatLine

```lua
C_Club.GetInfoFromLastCommunityChatLine() -> messageInfo: ClubMessageInfo, clubId: ClubId, streamId: ClubStreamId, clubType: ClubType
```

### GetInvitationCandidates

```lua
C_Club.GetInvitationCandidates(filter?: string, maxResults?: number, cursorPosition?: number, allowFullMatch?: bool, clubId: ClubId) -> candidates: table
```

### GetInvitationInfo

```lua
C_Club.GetInvitationInfo(clubId: ClubId) -> invitation?: ClubSelfInvitationInfo
```

### GetInvitationsForClub

```lua
C_Club.GetInvitationsForClub(clubId: ClubId) -> invitations: table
```

### GetInvitationsForSelf

```lua
C_Club.GetInvitationsForSelf() -> invitations: table
```

### GetLastTicketResponse

```lua
C_Club.GetLastTicketResponse(ticket: string) -> error: ClubErrorType, info?: ClubInfo, showError: bool
```

### GetMemberInfo

```lua
C_Club.GetMemberInfo(clubId: ClubId, memberId: ClubMemberOpaqueId) -> info?: ClubMemberInfo
```

### GetMemberInfoForSelf

```lua
C_Club.GetMemberInfoForSelf(clubId: ClubId) -> info?: ClubMemberInfo
```

### GetMessageInfo

```lua
C_Club.GetMessageInfo(clubId: ClubId, streamId: ClubStreamId, messageId: ClubMessageIdentifier) -> message?: ClubMessageInfo
```

### GetMessageRanges

```lua
C_Club.GetMessageRanges(clubId: ClubId, streamId: ClubStreamId) -> ranges: table
```

### GetMessagesBefore

```lua
C_Club.GetMessagesBefore(clubId: ClubId, streamId: ClubStreamId, newest: ClubMessageIdentifier, count: number) -> messages: table
```

### GetMessagesInRange

```lua
C_Club.GetMessagesInRange(clubId: ClubId, streamId: ClubStreamId, oldest: ClubMessageIdentifier, newest: ClubMessageIdentifier) -> messages: table
```

### GetStreamInfo

```lua
C_Club.GetStreamInfo(clubId: ClubId, streamId: ClubStreamId) -> streamInfo?: ClubStreamInfo
```

### GetStreams

```lua
C_Club.GetStreams(clubId: ClubId) -> streams: table
```

### GetStreamViewMarker

```lua
C_Club.GetStreamViewMarker(clubId: ClubId, streamId: ClubStreamId) -> lastReadTime?: BigUInteger
```

### GetSubscribedClubs

```lua
C_Club.GetSubscribedClubs() -> clubs: table
```

### GetTickets

```lua
C_Club.GetTickets(clubId: ClubId) -> tickets: table
```

### IsAccountMuted

```lua
C_Club.IsAccountMuted(clubId: ClubId) -> accountMuted: bool
```

### IsBeginningOfStream

```lua
C_Club.IsBeginningOfStream(clubId: ClubId, streamId: ClubStreamId, messageId: ClubMessageIdentifier) -> isBeginningOfStream: bool
```

### IsEnabled

```lua
C_Club.IsEnabled() -> clubsEnabled: bool
```

### IsRestricted

```lua
C_Club.IsRestricted() -> restrictionReason: ClubRestrictionReason
```

### IsSubscribedToStream

```lua
C_Club.IsSubscribedToStream(clubId: ClubId, streamId: ClubStreamId) -> subscribed: bool
```

### KickMember

```lua
C_Club.KickMember(clubId: ClubId, memberId: ClubMemberOpaqueId)
```

### LeaveClub

```lua
C_Club.LeaveClub(clubId: ClubId)
```

### RedeemTicket

```lua
C_Club.RedeemTicket(ticketId: string)
```

### RequestInvitationsForClub

```lua
C_Club.RequestInvitationsForClub(clubId: ClubId)
```

### RequestMoreMessagesBefore

```lua
C_Club.RequestMoreMessagesBefore(clubId: ClubId, streamId: ClubStreamId, messageId?: ClubMessageIdentifier, count?: number) -> alreadyHasMessages: bool
```

### RequestTicket

```lua
C_Club.RequestTicket(ticketId: string)
```

### RequestTickets

```lua
C_Club.RequestTickets(clubId: ClubId)
```

### RevokeInvitation

```lua
C_Club.RevokeInvitation(clubId: ClubId, memberId: ClubMemberOpaqueId)
```

### SendBattleTagFriendRequest

```lua
C_Club.SendBattleTagFriendRequest(guildClubId: ClubId, memberId: ClubMemberOpaqueId)
```

### SendCharacterInvitation

```lua
C_Club.SendCharacterInvitation(clubId: ClubId, character: string)
```

### SendInvitation

```lua
C_Club.SendInvitation(clubId: ClubId, memberId: ClubMemberOpaqueId)
```

### SendMessage

```lua
C_Club.SendMessage(clubId: ClubId, streamId: ClubStreamId, message: string)
```

### SendTitleFriendRequest

```lua
C_Club.SendTitleFriendRequest(guildClubId: ClubId, memberId: ClubMemberOpaqueId)
```

### SetAutoAdvanceStreamViewMarker

```lua
C_Club.SetAutoAdvanceStreamViewMarker(clubId: ClubId, streamId: ClubStreamId)
```

### SetAvatarTexture

```lua
C_Club.SetAvatarTexture(texture: SimpleTexture, avatarId: number, clubType: ClubType)
```

### SetClubMemberNote

```lua
C_Club.SetClubMemberNote(clubId: ClubId, memberId: ClubMemberOpaqueId, note: string)
```

### SetClubPresenceSubscription

```lua
C_Club.SetClubPresenceSubscription(clubId: ClubId)
```

### SetClubStreamNotificationSettings

```lua
C_Club.SetClubStreamNotificationSettings(clubId: ClubId, settings: table)
```

### SetCommunityID

```lua
C_Club.SetCommunityID(communityID: BigUInteger)
```

### SetFavorite

```lua
C_Club.SetFavorite(clubId: ClubId, isFavorite: bool)
```

### SetSocialQueueingEnabled

```lua
C_Club.SetSocialQueueingEnabled(clubId: ClubId, enabled: bool)
```

### ShouldAllowClubType

```lua
C_Club.ShouldAllowClubType(clubType: ClubType) -> clubTypeIsAllowed: bool
```

### UnfocusAllStreams

```lua
C_Club.UnfocusAllStreams(unsubscribe: bool)
```

### UnfocusMembers

```lua
C_Club.UnfocusMembers(clubId: ClubId)
```

### UnfocusStream

```lua
C_Club.UnfocusStream(clubId: ClubId, streamId: ClubStreamId)
```

### ValidateText

```lua
C_Club.ValidateText(clubType: ClubType, text: string, clubFieldType: ClubFieldType) -> result: ValidateNameResult
```

## Events

### AvatarListUpdated

Fires as `AVATAR_LIST_UPDATED`.

```lua
payload: clubType: ClubType
```

### ClubAdded

Fires as `CLUB_ADDED`.

```lua
payload: clubId: ClubId
```

### ClubError

Fires as `CLUB_ERROR`.

```lua
payload: action: ClubActionType, error: ClubErrorType, clubType: ClubType
```

### ClubInvitationAddedForSelf

Fires as `CLUB_INVITATION_ADDED_FOR_SELF`.

```lua
payload: invitation: ClubSelfInvitationInfo
```

### ClubInvitationRemovedForSelf

Fires as `CLUB_INVITATION_REMOVED_FOR_SELF`.

```lua
payload: invitationId: ClubInvitationId
```

### ClubInvitationsReceivedForClub

Fires as `CLUB_INVITATIONS_RECEIVED_FOR_CLUB`.

```lua
payload: clubId: ClubId
```

### ClubMemberAdded

Fires as `CLUB_MEMBER_ADDED`.

```lua
payload: clubId: ClubId, memberId: ClubMemberOpaqueId
```

### ClubMemberPresenceUpdated

Fires as `CLUB_MEMBER_PRESENCE_UPDATED`.

```lua
payload: clubId: ClubId, memberId: ClubMemberOpaqueId, presence: ClubMemberPresence
```

### ClubMemberRemoved

Fires as `CLUB_MEMBER_REMOVED`.

```lua
payload: clubId: ClubId, memberId: ClubMemberOpaqueId
```

### ClubMemberRoleUpdated

Fires as `CLUB_MEMBER_ROLE_UPDATED`.

```lua
payload: clubId: ClubId, memberId: ClubMemberOpaqueId, roleId: number
```

### ClubMembersUpdated

Fires as `CLUB_MEMBERS_UPDATED`.

```lua
payload: clubId: ClubId
```

### ClubMemberUpdated

Fires as `CLUB_MEMBER_UPDATED`.

```lua
payload: clubId: ClubId, memberId: ClubMemberOpaqueId
```

### ClubMessageAdded

Fires as `CLUB_MESSAGE_ADDED`.

```lua
payload: clubId: ClubId, streamId: ClubStreamId, messageId: ClubMessageIdentifier
```

### ClubMessageHistoryReceived

Fires as `CLUB_MESSAGE_HISTORY_RECEIVED`.

```lua
payload: clubId: ClubId, streamId: ClubStreamId, downloadedRange: ClubMessageRange, contiguousRange: ClubMessageRange
```

### ClubMessageUpdated

Fires as `CLUB_MESSAGE_UPDATED`.

```lua
payload: clubId: ClubId, streamId: ClubStreamId, messageId: ClubMessageIdentifier
```

### ClubRemoved

Fires as `CLUB_REMOVED`.

```lua
payload: clubId: ClubId
```

### ClubRemovedMessage

Fires as `CLUB_REMOVED_MESSAGE`.

```lua
payload: clubName: string, clubRemovedReason: ClubRemovedReason
```

### ClubSelfMemberRoleUpdated

Fires as `CLUB_SELF_MEMBER_ROLE_UPDATED`.

```lua
payload: clubId: ClubId, roleId: number
```

### ClubStreamAdded

Fires as `CLUB_STREAM_ADDED`.

```lua
payload: clubId: ClubId, streamId: ClubStreamId
```

### ClubStreamRemoved

Fires as `CLUB_STREAM_REMOVED`.

```lua
payload: clubId: ClubId, streamId: ClubStreamId
```

### ClubStreamsLoaded

Fires as `CLUB_STREAMS_LOADED`.

```lua
payload: clubId: ClubId
```

### ClubStreamSubscribed

Fires as `CLUB_STREAM_SUBSCRIBED`.

```lua
payload: clubId: ClubId, streamId: ClubStreamId
```

### ClubStreamUnsubscribed

Fires as `CLUB_STREAM_UNSUBSCRIBED`.

```lua
payload: clubId: ClubId, streamId: ClubStreamId
```

### ClubStreamUpdated

Fires as `CLUB_STREAM_UPDATED`.

```lua
payload: clubId: ClubId, streamId: ClubStreamId
```

### ClubTicketCreated

Fires as `CLUB_TICKET_CREATED`.

```lua
payload: clubId: ClubId, ticketInfo: ClubTicketInfo
```

### ClubTicketReceived

Fires as `CLUB_TICKET_RECEIVED`.

```lua
payload: ticket: string
```

### ClubTicketsReceived

Fires as `CLUB_TICKETS_RECEIVED`.

```lua
payload: clubId: ClubId
```

### ClubUpdated

Fires as `CLUB_UPDATED`.

```lua
payload: clubId: ClubId
```

### InitialClubsLoaded

Fires as `INITIAL_CLUBS_LOADED`.

No payload.

### StreamViewMarkerUpdated

Fires as `STREAM_VIEW_MARKER_UPDATED`.

```lua
payload: clubId: ClubId, streamId: ClubStreamId, lastReadTime?: BigUInteger
```
