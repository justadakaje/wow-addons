# C_BattleNet

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`32` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AreFriendTagsEnabled

```lua
C_BattleNet.AreFriendTagsEnabled() -> areFriendTagsEnabled: bool
```

### AreHighResTexturesInstalled

```lua
C_BattleNet.AreHighResTexturesInstalled() -> installed: bool
```

### AreTitleFriendCustomNamesEnabled

```lua
C_BattleNet.AreTitleFriendCustomNamesEnabled() -> areTitleFriendCustomNamesEnabled: bool
```

### AreTitleFriendsEnabled

```lua
C_BattleNet.AreTitleFriendsEnabled() -> areTitleFriendsEnabled: bool
```

### BNCheckBattleTagInviteToRecentAlly

```lua
C_BattleNet.BNCheckBattleTagInviteToRecentAlly(recentAllyGUID: WOWGUID)
```

### BNCheckTitleFriendInviteToUnit

```lua
C_BattleNet.BNCheckTitleFriendInviteToUnit(unit: UnitToken)
```

### CanToggleHighResTexturesWithoutClientReload

```lua
C_BattleNet.CanToggleHighResTexturesWithoutClientReload() -> canToggle: bool
```

### GetAccountInfoByGUID

```lua
C_BattleNet.GetAccountInfoByGUID(guid: WOWGUID) -> accountInfo?: BNetAccountInfo
```

### GetAccountInfoByID

```lua
C_BattleNet.GetAccountInfoByID(id: number, wowAccountGUID?: WOWGUID) -> accountInfo?: BNetAccountInfo
```

### GetCustomTitleFriendName

```lua
C_BattleNet.GetCustomTitleFriendName(id: number) -> customName: string
```

### GetFriendAccountInfo

```lua
C_BattleNet.GetFriendAccountInfo(friendIndex: luaIndex, wowAccountGUID?: WOWGUID) -> accountInfo?: BNetAccountInfo
```

### GetFriendGameAccountInfo

```lua
C_BattleNet.GetFriendGameAccountInfo(friendIndex: luaIndex, accountIndex: luaIndex) -> gameAccountInfo?: BNetGameAccountInfo
```

### GetFriendInviteInfo

```lua
C_BattleNet.GetFriendInviteInfo(inviteIndex: luaIndex) -> inviteInfo?: BNetFriendInviteInfo
```

### GetFriendNumGameAccounts

```lua
C_BattleNet.GetFriendNumGameAccounts(friendIndex: luaIndex) -> numGameAccounts: number
```

### GetGameAccountInfoByGUID

```lua
C_BattleNet.GetGameAccountInfoByGUID(guid: WOWGUID) -> gameAccountInfo?: BNetGameAccountInfo
```

### GetGameAccountInfoByID

```lua
C_BattleNet.GetGameAccountInfoByID(id: number) -> gameAccountInfo?: BNetGameAccountInfo
```

### InstallHighResTextures

```lua
C_BattleNet.InstallHighResTextures()
```

### InviteFriend

```lua
C_BattleNet.InviteFriend(gameAccountID: number)
```

### IsBattleNetFriendsListEnabled

```lua
C_BattleNet.IsBattleNetFriendsListEnabled() -> isBattleNetFriendsListEnabled: bool
```

### IsBattleNetFriendsListSupported

```lua
C_BattleNet.IsBattleNetFriendsListSupported() -> isBattleNetFriendsListSupported: bool
```

### IsFriendTagSupportedForCurrentGameType

```lua
C_BattleNet.IsFriendTagSupportedForCurrentGameType(friendTag: BattleNetFriendTag) -> isFriendTagSupportedForCurrentGameType: bool
```

### SearchFriends

```lua
C_BattleNet.SearchFriends(searchInfo: AuroraFriendsSearchInfo) -> friendsData: table
```

### SendGameData

```lua
C_BattleNet.SendGameData(gameAccountID: number, prefix: stringView, data: stringView) -> result: SendAddonMessageResult
```

### SendTitleFriendInviteByName

```lua
C_BattleNet.SendTitleFriendInviteByName(name: cstring)
```

### SendVerifiedBattleNetFriendInvite

```lua
C_BattleNet.SendVerifiedBattleNetFriendInvite()
```

### SendWhisper

```lua
C_BattleNet.SendWhisper(bnetAccountID: number, text: stringView) -> success: bool
```

### SetAFK

```lua
C_BattleNet.SetAFK(isAFK: bool)
```

### SetAppearOffline

```lua
C_BattleNet.SetAppearOffline(isAppearOffline: bool)
```

### SetCustomMessage

```lua
C_BattleNet.SetCustomMessage(text: cstring) -> success: bool
```

### SetCustomTitleFriendName

```lua
C_BattleNet.SetCustomTitleFriendName(id: number, customName: cstring)
```

### SetDND

```lua
C_BattleNet.SetDND(isDND: bool)
```

### SetFriendTags

```lua
C_BattleNet.SetFriendTags(id: number, friendTags: table)
```
