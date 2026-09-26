# C_FriendList

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`31` functions - `27` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddFriend

```lua
C_FriendList.AddFriend(name: cstring, notes?: cstring)
```

### AddIgnore

```lua
C_FriendList.AddIgnore(name: cstring) -> added: bool
```

### AddOrDelIgnore

```lua
C_FriendList.AddOrDelIgnore(name: cstring)
```

### AddOrRemoveFriend

```lua
C_FriendList.AddOrRemoveFriend(name: cstring, notes: cstring)
```

### DelIgnore

```lua
C_FriendList.DelIgnore(name: cstring) -> removed: bool
```

### DelIgnoreByIndex

```lua
C_FriendList.DelIgnoreByIndex(index: luaIndex)
```

### GetFriendInfo

```lua
C_FriendList.GetFriendInfo(name: cstring) -> info: FriendInfo
```

### GetFriendInfoByIndex

```lua
C_FriendList.GetFriendInfoByIndex(index: luaIndex) -> info: FriendInfo
```

### GetIgnoreName

```lua
C_FriendList.GetIgnoreName(index: luaIndex) -> name?: string
```

### GetNumFriends

```lua
C_FriendList.GetNumFriends() -> numFriends: number
```

### GetNumIgnores

```lua
C_FriendList.GetNumIgnores() -> numIgnores: number
```

### GetNumOnlineFriends

```lua
C_FriendList.GetNumOnlineFriends() -> numOnline: number
```

### GetNumWhoResults

```lua
C_FriendList.GetNumWhoResults() -> numWhos: number, totalNumWhos: number
```

### GetSelectedFriend

```lua
C_FriendList.GetSelectedFriend() -> index?: luaIndex
```

### GetSelectedIgnore

```lua
C_FriendList.GetSelectedIgnore() -> index?: luaIndex
```

### GetWhoInfo

```lua
C_FriendList.GetWhoInfo(index: luaIndex) -> info: WhoInfo
```

### IsFriend

```lua
C_FriendList.IsFriend(guid: WOWGUID) -> isFriend: bool
```

### IsIgnored

```lua
C_FriendList.IsIgnored(token: cstring) -> isIgnored: bool
```

### IsIgnoredByGuid

```lua
C_FriendList.IsIgnoredByGuid(guid: WOWGUID) -> isIgnored: bool
```

### IsLegacyFriendSystemEnabled

```lua
C_FriendList.IsLegacyFriendSystemEnabled() -> isLegacyFriendSystemEnabled: bool
```

### IsOnIgnoredList

```lua
C_FriendList.IsOnIgnoredList(token: cstring) -> isIgnored: bool
```

### RemoveFriend

```lua
C_FriendList.RemoveFriend(name: cstring) -> removed: bool
```

### RemoveFriendByIndex

```lua
C_FriendList.RemoveFriendByIndex(index: luaIndex)
```

### SendWho

```lua
C_FriendList.SendWho(filter: cstring, origin?: number)
```

### SetFriendNotes

```lua
C_FriendList.SetFriendNotes(name: cstring, notes: cstring) -> found: bool
```

### SetFriendNotesByIndex

```lua
C_FriendList.SetFriendNotesByIndex(index: luaIndex, notes: cstring)
```

### SetSelectedFriend

```lua
C_FriendList.SetSelectedFriend(index: luaIndex)
```

### SetSelectedIgnore

```lua
C_FriendList.SetSelectedIgnore(index: luaIndex)
```

### SetWhoToUi

```lua
C_FriendList.SetWhoToUi(whoToUi: bool)
```

### ShowFriends

```lua
C_FriendList.ShowFriends()
```

### SortWho

```lua
C_FriendList.SortWho(sorting: cstring)
```

## Events

### BattleNetFriendTagEnabledStatusUpdated

Fires as `BATTLE_NET_FRIEND_TAG_ENABLED_STATUS_UPDATED`.

No payload.

### BattleNetTitleFriendCustomNameEnabledStatusUpdated

Fires as `BATTLE_NET_TITLE_FRIEND_CUSTOM_NAME_ENABLED_STATUS_UPDATED`.

No payload.

### BnBlockFailedTooMany

Fires as `BN_BLOCK_FAILED_TOO_MANY`.

```lua
payload: blockType: cstring
```

### BnBlockListUpdated

Fires as `BN_BLOCK_LIST_UPDATED`.

No payload.

### BnChatWhisperUndeliverable

Fires as `BN_CHAT_WHISPER_UNDELIVERABLE`.

```lua
payload: senderID: number
```

### BnConnected

Fires as `BN_CONNECTED`.

```lua
payload: suppressNotification: bool
```

### BnCustomMessageChanged

Fires as `BN_CUSTOM_MESSAGE_CHANGED`.

```lua
payload: id?: number
```

### BnCustomMessageLoaded

Fires as `BN_CUSTOM_MESSAGE_LOADED`.

No payload.

### BnDisconnected

Fires as `BN_DISCONNECTED`.

```lua
payload: result: bool, suppressNotification: bool
```

### BnFriendAccountOffline

Fires as `BN_FRIEND_ACCOUNT_OFFLINE`.

```lua
payload: friendId: number, isCompanionApp: bool
```

### BnFriendAccountOnline

Fires as `BN_FRIEND_ACCOUNT_ONLINE`.

```lua
payload: friendId: number, isCompanionApp: bool
```

### BnFriendInfoChanged

Fires as `BN_FRIEND_INFO_CHANGED`.

```lua
payload: friendIndex?: luaIndex
```

### BnFriendInviteAdded

Fires as `BN_FRIEND_INVITE_ADDED`.

```lua
payload: accountID: number
```

### BnFriendInviteListInitialized

Fires as `BN_FRIEND_INVITE_LIST_INITIALIZED`.

```lua
payload: listSize: number
```

### BnFriendInviteRemoved

Fires as `BN_FRIEND_INVITE_REMOVED`.

No payload.

### BnFriendListSizeChanged

Fires as `BN_FRIEND_LIST_SIZE_CHANGED`.

```lua
payload: accountID?: number
```

### BnInfoChanged

Fires as `BN_INFO_CHANGED`.

No payload.

### BnRequestFofSucceeded

Fires as `BN_REQUEST_FOF_SUCCEEDED`.

No payload.

### ConfirmBattleNetFriendInviteShow

Fires as `CONFIRM_BATTLE_NET_FRIEND_INVITE_SHOW`.

```lua
payload: name: cstring, friendLevel: BattleNetFriendLevel
```

### FriendlistUpdate

Fires as `FRIENDLIST_UPDATE`.

No payload.

### IgnorelistUpdate

Fires as `IGNORELIST_UPDATE`.

No payload.

### LegacyFriendSystemStatusUpdated

Fires as `LEGACY_FRIEND_SYSTEM_STATUS_UPDATED`.

No payload.

### MutelistUpdate

Fires as `MUTELIST_UPDATE`.

No payload.

### NewMatchmakingPartyInvite

Fires as `NEW_MATCHMAKING_PARTY_INVITE`.

No payload.

### RejectedMatchmakingPartyInvite

Fires as `REJECTED_MATCHMAKING_PARTY_INVITE`.

```lua
payload: name: cstring
```

### SocialUIFriendsListSystemStatusUpdated

Fires as `SOCIAL_UI_FRIENDS_LIST_SYSTEM_STATUS_UPDATED`.

No payload.

### WhoListUpdate

Fires as `WHO_LIST_UPDATE`.

No payload.
