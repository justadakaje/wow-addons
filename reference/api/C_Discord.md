# C_Discord

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`20` functions - `6` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### Authorize

```lua
C_Discord.Authorize()
```

### GetDiscordChannelName

```lua
C_Discord.GetDiscordChannelName(serverIndex: luaIndex, channelIndex: luaIndex) -> name: string
```

### GetDiscordUserID

```lua
C_Discord.GetDiscordUserID() -> userID: DiscordID
```

### GetDiscordUserName

```lua
C_Discord.GetDiscordUserName(userID: DiscordID) -> userName: KStringDiscordUserName
```

### GetDisplayNameType

```lua
C_Discord.GetDisplayNameType() -> type: DiscordDisplayNameType
```

### GetGuildLinkStatus

```lua
C_Discord.GetGuildLinkStatus() -> isFullyLinked: bool, linkedChannelName: string, linkedServerName: string
```

### GetNumDiscordChannels

```lua
C_Discord.GetNumDiscordChannels(serverIndex: luaIndex) -> count: number, valid: bool
```

### GetNumDiscordServers

```lua
C_Discord.GetNumDiscordServers() -> count: number
```

### GetServerLinkableChannels

```lua
C_Discord.GetServerLinkableChannels(index: luaIndex)
```

### GetServerName

```lua
C_Discord.GetServerName(index: luaIndex) -> name: string
```

### GuildLink

```lua
C_Discord.GuildLink(serverIndex: luaIndex, channelIndex: luaIndex)
```

### GuildUnlink

```lua
C_Discord.GuildUnlink()
```

### IsEnabled

```lua
C_Discord.IsEnabled() -> enabled: bool
```

### IsGuildChannelLinked

```lua
C_Discord.IsGuildChannelLinked() -> isLinked: bool
```

### IsGuildSettingSet

```lua
C_Discord.IsGuildSettingSet(setting: DiscordGuildSettings) -> isSet: bool
```

### IsUserOAuthed

```lua
C_Discord.IsUserOAuthed() -> hasOAuth: bool
```

### RefreshAuth

```lua
C_Discord.RefreshAuth()
```

### SetGuildSetting

```lua
C_Discord.SetGuildSetting(setting: DiscordGuildSettings, set: bool)
```

### UpdateDiscordServers

```lua
C_Discord.UpdateDiscordServers()
```

### UpdateGuildLobby

```lua
C_Discord.UpdateGuildLobby()
```

## Events

### DiscordGuildAchievement

Fires as `DISCORD_GUILD_ACHIEVEMENT`.

```lua
payload: achievementID: number
```

### DiscordGuildLobbyUpdate

Fires as `DISCORD_GUILD_LOBBY_UPDATE`.

No payload.

### DiscordGuildSettingsUpdate

Fires as `DISCORD_GUILD_SETTINGS_UPDATE`.

No payload.

### DiscordLinkUpdate

Fires as `DISCORD_LINK_UPDATE`.

No payload.

### DiscordServerListUpdate

Fires as `DISCORD_SERVER_LIST_UPDATE`.

No payload.

### DiscordStatusUpdate

Fires as `DISCORD_STATUS_UPDATE`.

No payload.
