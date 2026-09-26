# C_ChatInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`45` functions - `102` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AreOutgoingAddonChatMessagesRestricted

```lua
C_ChatInfo.AreOutgoingAddonChatMessagesRestricted() -> isRestricted: bool
```

### CancelEmote

```lua
C_ChatInfo.CancelEmote()
```

### CanPlayerSpeakLanguage

```lua
C_ChatInfo.CanPlayerSpeakLanguage(languageId: number) -> canSpeakLanguage: bool
```

### DropCautionaryChatMessage

```lua
C_ChatInfo.DropCautionaryChatMessage(confirmNumber: number)
```

### GetChannelInfoFromIdentifier

```lua
C_ChatInfo.GetChannelInfoFromIdentifier(channelIdentifier: cstring) -> info?: ChatChannelInfo
```

### GetChannelRosterInfo

```lua
C_ChatInfo.GetChannelRosterInfo(channelIndex: luaIndex, rosterIndex: luaIndex) -> name: string, owner: bool, moderator: bool, guid: WOWGUID
```

### GetChannelRuleset

```lua
C_ChatInfo.GetChannelRuleset(channelIndex: luaIndex) -> ruleset: ChatChannelRuleset
```

### GetChannelRulesetForChannelID

```lua
C_ChatInfo.GetChannelRulesetForChannelID(channelID: number) -> ruleset: ChatChannelRuleset
```

### GetChannelShortcut

```lua
C_ChatInfo.GetChannelShortcut(channelIndex: luaIndex) -> shortcut: cstring
```

### GetChannelShortcutForChannelID

```lua
C_ChatInfo.GetChannelShortcutForChannelID(channelID: number) -> shortcut: cstring
```

### GetChatLineSenderGUID

```lua
C_ChatInfo.GetChatLineSenderGUID(chatLine: number) -> guid: WOWGUID
```

### GetChatLineSenderName

```lua
C_ChatInfo.GetChatLineSenderName(chatLine: number) -> name: string
```

### GetChatLineText

```lua
C_ChatInfo.GetChatLineText(chatLine: number) -> text: string
```

### GetChatTypeName

```lua
C_ChatInfo.GetChatTypeName(typeID: number) -> name?: string
```

### GetClubStreamIDs

```lua
C_ChatInfo.GetClubStreamIDs(clubID: ClubId) -> ids: table
```

### GetColorForChatType

```lua
C_ChatInfo.GetColorForChatType(chatType: cstring) -> color?: colorRGB
```

### GetGeneralChannelID

```lua
C_ChatInfo.GetGeneralChannelID() -> channelID: number
```

### GetGeneralChannelLocalID

```lua
C_ChatInfo.GetGeneralChannelLocalID() -> localID?: number
```

### GetMentorChannelID

```lua
C_ChatInfo.GetMentorChannelID() -> channelID: number
```

### GetNumActiveChannels

```lua
C_ChatInfo.GetNumActiveChannels() -> numChannels: number
```

### GetNumReservedChatWindows

```lua
C_ChatInfo.GetNumReservedChatWindows() -> numReserved: number
```

### GetRegisteredAddonMessagePrefixes

```lua
C_ChatInfo.GetRegisteredAddonMessagePrefixes() -> registeredPrefixes: table
```

### InChatMessagingLockdown

```lua
C_ChatInfo.InChatMessagingLockdown() -> isRestricted: bool
```

### IsAddonMessagePrefixRegistered

```lua
C_ChatInfo.IsAddonMessagePrefixRegistered(prefix: cstring) -> isRegistered: bool
```

### IsChannelRegional

```lua
C_ChatInfo.IsChannelRegional(channelIndex: luaIndex) -> isRegional: bool
```

### IsChannelRegionalForChannelID

```lua
C_ChatInfo.IsChannelRegionalForChannelID(channelID: number) -> isRegional: bool
```

### IsChatLineCensored

```lua
C_ChatInfo.IsChatLineCensored(chatLine: number) -> isCensored: bool
```

### IsLoggingChat

```lua
C_ChatInfo.IsLoggingChat() -> enabled: bool
```

### IsLoggingCombat

```lua
C_ChatInfo.IsLoggingCombat() -> enabled: bool, advanced: bool
```

### IsPartyChannelType

```lua
C_ChatInfo.IsPartyChannelType(channelType: ChatChannelType) -> isPartyChannelType: bool
```

### IsRegionalServiceAvailable

```lua
C_ChatInfo.IsRegionalServiceAvailable() -> available: bool
```

### IsTimerunningPlayer

```lua
C_ChatInfo.IsTimerunningPlayer(playerGUID: WOWGUID) -> isTimerunning: bool
```

### IsValidChatLine

```lua
C_ChatInfo.IsValidChatLine(chatLine?: number) -> isValid: bool
```

### IsValidCombatFilterName

```lua
C_ChatInfo.IsValidCombatFilterName(name: cstring) -> isApproved: bool
```

### PerformEmote

```lua
C_ChatInfo.PerformEmote(emoteName: cstring, targetName?: cstring, suppressMoveError: bool) -> success: bool
```

### RegisterAddonMessagePrefix

```lua
C_ChatInfo.RegisterAddonMessagePrefix(prefix: cstring) -> result: RegisterAddonMessagePrefixResult
```

### ReplaceIconAndGroupExpressions

```lua
C_ChatInfo.ReplaceIconAndGroupExpressions(input: string, noIconReplacement?: bool, noGroupReplacement?: bool) -> output: string
```

### RequestCanLocalWhisperTarget

```lua
C_ChatInfo.RequestCanLocalWhisperTarget(whisperTarget: WOWGUID)
```

### ResetDefaultZoneChannels

```lua
C_ChatInfo.ResetDefaultZoneChannels()
```

### SendAddonMessage

```lua
C_ChatInfo.SendAddonMessage(prefix: cstring, message: cstring, chatType?: cstring, target?: cstring) -> result: SendAddonMessageResult
```

### SendAddonMessageLogged

```lua
C_ChatInfo.SendAddonMessageLogged(prefix: cstring, message: cstring, chatType?: cstring, target?: cstring) -> result?: SendAddonMessageResult
```

### SendCautionaryChatMessage

```lua
C_ChatInfo.SendCautionaryChatMessage(confirmNumber: number)
```

### SendChatMessage

```lua
C_ChatInfo.SendChatMessage(message: cstring, chatType?: SendChatMessageType, languageID?: number, target?: cstring)
```

### SwapChatChannelsByChannelIndex

```lua
C_ChatInfo.SwapChatChannelsByChannelIndex(firstChannelIndex: luaIndex, secondChannelIndex: luaIndex)
```

### UncensorChatLine

```lua
C_ChatInfo.UncensorChatLine(chatLine: number)
```

## Events

### AlternativeDefaultLanguageChanged

Fires as `ALTERNATIVE_DEFAULT_LANGUAGE_CHANGED`.

No payload.

### BnChatMsgAddon

Fires as `BN_CHAT_MSG_ADDON`.

```lua
payload: prefix: cstring, text: cstring, channel: cstring, senderID: number
```

### CanLocalWhisperTargetResponse

Fires as `CAN_LOCAL_WHISPER_TARGET_RESPONSE`.

```lua
payload: whisperTarget: WOWGUID, status: ChatWhisperTargetStatus
```

### CanPlayerSpeakLanguageChanged

Fires as `CAN_PLAYER_SPEAK_LANGUAGE_CHANGED`.

```lua
payload: languageId: number, canSpeakLanguage: bool
```

### CautionaryChannelMessage

Fires as `CAUTIONARY_CHANNEL_MESSAGE`.

```lua
payload: confirmNumber: number
```

### CautionaryChatMessage

Fires as `CAUTIONARY_CHAT_MESSAGE`.

```lua
payload: chatLineID: number, confirmNumber: number
```

### ChannelCountUpdate

Fires as `CHANNEL_COUNT_UPDATE`.

```lua
payload: displayIndex: number, count: number
```

### ChannelFlagsUpdated

Fires as `CHANNEL_FLAGS_UPDATED`.

```lua
payload: displayIndex: number
```

### ChannelInviteRequest

Fires as `CHANNEL_INVITE_REQUEST`.

```lua
payload: channelID: cstring, name: cstring
```

### ChannelLeft

Fires as `CHANNEL_LEFT`.

```lua
payload: chatChannelID: number, name: cstring
```

### ChannelPasswordRequest

Fires as `CHANNEL_PASSWORD_REQUEST`.

```lua
payload: channelID: cstring
```

### ChannelRosterUpdate

Fires as `CHANNEL_ROSTER_UPDATE`.

```lua
payload: displayIndex: number, count: number
```

### ChannelUiUpdate

Fires as `CHANNEL_UI_UPDATE`.

No payload.

### ChatCombatMsgArenaPointsGain

Fires as `CHAT_COMBAT_MSG_ARENA_POINTS_GAIN`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatLoggingChanged

Fires as `CHAT_LOGGING_CHANGED`.

```lua
payload: whichLog: number, isEnabled: bool
```

### ChatMsgAchievement

Fires as `CHAT_MSG_ACHIEVEMENT`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgAddon

Fires as `CHAT_MSG_ADDON`.

```lua
payload: prefix: cstring, text: cstring, channel: cstring, sender: cstring, target: cstring, zoneChannelID: number, localID: number, name: cstring, instanceID: number
```

### ChatMsgAddonLogged

Fires as `CHAT_MSG_ADDON_LOGGED`.

```lua
payload: prefix: cstring, text: cstring, channel: cstring, sender: cstring, target: cstring, zoneChannelID: number, localID: number, name: cstring, instanceID: number
```

### ChatMsgAfk

Fires as `CHAT_MSG_AFK`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgBgSystemAlliance

Fires as `CHAT_MSG_BG_SYSTEM_ALLIANCE`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgBgSystemHorde

Fires as `CHAT_MSG_BG_SYSTEM_HORDE`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgBgSystemNeutral

Fires as `CHAT_MSG_BG_SYSTEM_NEUTRAL`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgBn

Fires as `CHAT_MSG_BN`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgBnInlineToastAlert

Fires as `CHAT_MSG_BN_INLINE_TOAST_ALERT`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgBnInlineToastBroadcast

Fires as `CHAT_MSG_BN_INLINE_TOAST_BROADCAST`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgBnInlineToastBroadcastInform

Fires as `CHAT_MSG_BN_INLINE_TOAST_BROADCAST_INFORM`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgBnInlineToastConversation

Fires as `CHAT_MSG_BN_INLINE_TOAST_CONVERSATION`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgBnWhisper

Fires as `CHAT_MSG_BN_WHISPER`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgBnWhisperInform

Fires as `CHAT_MSG_BN_WHISPER_INFORM`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgBnWhisperPlayerOffline

Fires as `CHAT_MSG_BN_WHISPER_PLAYER_OFFLINE`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgChannel

Fires as `CHAT_MSG_CHANNEL`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgChannelJoin

Fires as `CHAT_MSG_CHANNEL_JOIN`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgChannelLeave

Fires as `CHAT_MSG_CHANNEL_LEAVE`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgChannelLeavePrevented

Fires as `CHAT_MSG_CHANNEL_LEAVE_PREVENTED`.

```lua
payload: channelName: cstring
```

### ChatMsgChannelList

Fires as `CHAT_MSG_CHANNEL_LIST`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgChannelNotice

Fires as `CHAT_MSG_CHANNEL_NOTICE`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgChannelNoticeUser

Fires as `CHAT_MSG_CHANNEL_NOTICE_USER`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgCollectedAppearance

Fires as `CHAT_MSG_COLLECTED_APPEARANCE`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgCombatFactionChange

Fires as `CHAT_MSG_COMBAT_FACTION_CHANGE`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgCombatHonorGain

Fires as `CHAT_MSG_COMBAT_HONOR_GAIN`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgCombatMiscInfo

Fires as `CHAT_MSG_COMBAT_MISC_INFO`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgCombatXpGain

Fires as `CHAT_MSG_COMBAT_XP_GAIN`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgCommunitiesChannel

Fires as `CHAT_MSG_COMMUNITIES_CHANNEL`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgCurrency

Fires as `CHAT_MSG_CURRENCY`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgDnd

Fires as `CHAT_MSG_DND`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgEmote

Fires as `CHAT_MSG_EMOTE`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgFiltered

Fires as `CHAT_MSG_FILTERED`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgGuild

Fires as `CHAT_MSG_GUILD`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgGuildAchievement

Fires as `CHAT_MSG_GUILD_ACHIEVEMENT`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgGuildDiscord

Fires as `CHAT_MSG_GUILD_DISCORD`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgGuildItemLooted

Fires as `CHAT_MSG_GUILD_ITEM_LOOTED`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgIgnored

Fires as `CHAT_MSG_IGNORED`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgInstanceChat

Fires as `CHAT_MSG_INSTANCE_CHAT`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgInstanceChatLeader

Fires as `CHAT_MSG_INSTANCE_CHAT_LEADER`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgLoot

Fires as `CHAT_MSG_LOOT`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgMoney

Fires as `CHAT_MSG_MONEY`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgMonsterEmote

Fires as `CHAT_MSG_MONSTER_EMOTE`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgMonsterParty

Fires as `CHAT_MSG_MONSTER_PARTY`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgMonsterSay

Fires as `CHAT_MSG_MONSTER_SAY`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgMonsterWhisper

Fires as `CHAT_MSG_MONSTER_WHISPER`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgMonsterYell

Fires as `CHAT_MSG_MONSTER_YELL`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgOfficer

Fires as `CHAT_MSG_OFFICER`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgOpening

Fires as `CHAT_MSG_OPENING`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgParty

Fires as `CHAT_MSG_PARTY`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgPartyLeader

Fires as `CHAT_MSG_PARTY_LEADER`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgPetBattleCombatLog

Fires as `CHAT_MSG_PET_BATTLE_COMBAT_LOG`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgPetBattleInfo

Fires as `CHAT_MSG_PET_BATTLE_INFO`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgPetInfo

Fires as `CHAT_MSG_PET_INFO`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgPing

Fires as `CHAT_MSG_PING`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgRaid

Fires as `CHAT_MSG_RAID`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgRaidBossEmote

Fires as `CHAT_MSG_RAID_BOSS_EMOTE`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgRaidBossWhisper

Fires as `CHAT_MSG_RAID_BOSS_WHISPER`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgRaidLeader

Fires as `CHAT_MSG_RAID_LEADER`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgRaidWarning

Fires as `CHAT_MSG_RAID_WARNING`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgRestricted

Fires as `CHAT_MSG_RESTRICTED`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgSay

Fires as `CHAT_MSG_SAY`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgSkill

Fires as `CHAT_MSG_SKILL`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgSystem

Fires as `CHAT_MSG_SYSTEM`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgTargeticons

Fires as `CHAT_MSG_TARGETICONS`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgTextEmote

Fires as `CHAT_MSG_TEXT_EMOTE`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgTradeskills

Fires as `CHAT_MSG_TRADESKILLS`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgVoiceText

Fires as `CHAT_MSG_VOICE_TEXT`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgWhisper

Fires as `CHAT_MSG_WHISPER`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgWhisperInform

Fires as `CHAT_MSG_WHISPER_INFORM`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatMsgYell

Fires as `CHAT_MSG_YELL`.

```lua
payload: text: cstring, playerName: cstring, languageName: cstring, channelName: cstring, playerName2: cstring, specialFlags: cstring, zoneChannelID: number, channelIndex: number, channelBaseName: cstring, languageID: number, lineID: number, guid: WOWGUID, bnSenderID: number, isMobile: bool, isSubtitle: bool, hideSenderInLetterbox: bool, suppressRaidIcons: bool, discordInfo: DiscordChatInfo
```

### ChatRegionalSendFailed

Fires as `CHAT_REGIONAL_SEND_FAILED`.

No payload.

### ChatRegionalStatusChanged

Fires as `CHAT_REGIONAL_STATUS_CHANGED`.

```lua
payload: isServiceAvailable: bool
```

### ChatServerDisconnected

Fires as `CHAT_SERVER_DISCONNECTED`.

```lua
payload: isInitialMessage?: bool
```

### ChatServerReconnected

Fires as `CHAT_SERVER_RECONNECTED`.

No payload.

### ClearBossEmotes

Fires as `CLEAR_BOSS_EMOTES`.

No payload.

### DailyResetInstanceWelcome

Fires as `DAILY_RESET_INSTANCE_WELCOME`.

```lua
payload: mapname: cstring, timeLeft: number
```

### InstanceResetWarning

Fires as `INSTANCE_RESET_WARNING`.

```lua
payload: warningMessage: cstring, timeLeft: number
```

### LanguageListChanged

Fires as `LANGUAGE_LIST_CHANGED`.

No payload.

### NotifyChatSuppressed

Fires as `NOTIFY_CHAT_SUPPRESSED`.

No payload.

### QuestBossEmote

Fires as `QUEST_BOSS_EMOTE`.

```lua
payload: text: cstring, playerName: cstring, displayTime: number, enableBossEmoteWarningSound: bool
```

### RaidBossEmote

Fires as `RAID_BOSS_EMOTE`.

```lua
payload: text: cstring, playerName: cstring, displayTime: number, enableBossEmoteWarningSound: bool
```

### RaidBossWhisper

Fires as `RAID_BOSS_WHISPER`.

```lua
payload: text: cstring, playerName: cstring, displayTime: number, enableBossEmoteWarningSound: bool
```

### RaidInstanceWelcome

Fires as `RAID_INSTANCE_WELCOME`.

```lua
payload: mapname: cstring, timeLeft: number, locked: number, extended: number
```

### UpdateChatColor

Fires as `UPDATE_CHAT_COLOR`.

```lua
payload: name: cstring, r: number, g: number, b: number
```

### UpdateChatColorNameByClass

Fires as `UPDATE_CHAT_COLOR_NAME_BY_CLASS`.

```lua
payload: name: cstring, colorNameByClass: bool
```

### UpdateChatWindows

Fires as `UPDATE_CHAT_WINDOWS`.

No payload.

### UpdateFloatingChatWindows

Fires as `UPDATE_FLOATING_CHAT_WINDOWS`.

No payload.
