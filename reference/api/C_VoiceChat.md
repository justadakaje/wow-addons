# C_VoiceChat

WoW: Forever 1.60.1 (build 70862) - Interface 16001

`82` functions - `51` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ActivateChannel

```lua
C_VoiceChat.ActivateChannel(channelID: VoiceChatID)
```

### ActivateChannelTranscription

```lua
C_VoiceChat.ActivateChannelTranscription(channelID: VoiceChatID)
```

### BeginLocalCapture

```lua
C_VoiceChat.BeginLocalCapture(listenToLocalUser: bool)
```

### CanAccessSettings

```lua
C_VoiceChat.CanAccessSettings() -> canAccess: bool
```

### CanPlayerUseVoiceChat

```lua
C_VoiceChat.CanPlayerUseVoiceChat() -> canUseVoiceChat: bool
```

### CreateChannel

```lua
C_VoiceChat.CreateChannel(channelDisplayName: cstring) -> status: VoiceChatStatusCode
```

### DeactivateChannel

```lua
C_VoiceChat.DeactivateChannel(channelID: VoiceChatID)
```

### DeactivateChannelTranscription

```lua
C_VoiceChat.DeactivateChannelTranscription(channelID: VoiceChatID)
```

### EndLocalCapture

```lua
C_VoiceChat.EndLocalCapture()
```

### GetActiveChannelID

```lua
C_VoiceChat.GetActiveChannelID() -> channelID?: VoiceChatID
```

### GetActiveChannelType

```lua
C_VoiceChat.GetActiveChannelType() -> channelType?: ChatChannelType
```

### GetActiveVoiceProviderID

```lua
C_VoiceChat.GetActiveVoiceProviderID() -> activeVoiceProviderID: VoiceProviderID
```

### GetAvailableInputDevices

```lua
C_VoiceChat.GetAvailableInputDevices() -> inputDevices?: table
```

### GetAvailableOutputDevices

```lua
C_VoiceChat.GetAvailableOutputDevices() -> outputDevices?: table
```

### GetChannel

```lua
C_VoiceChat.GetChannel(channelID: VoiceChatID) -> channel: VoiceChatChannel
```

### GetChannelForChannelType

```lua
C_VoiceChat.GetChannelForChannelType(channelType: ChatChannelType) -> channel: VoiceChatChannel
```

### GetChannelForCommunityStream

```lua
C_VoiceChat.GetChannelForCommunityStream(clubId: ClubId, streamId: ClubStreamId) -> channel: VoiceChatChannel
```

### GetCommunicationMode

```lua
C_VoiceChat.GetCommunicationMode() -> communicationMode?: CommunicationMode
```

### GetCurrentVoiceChatConnectionStatusCode

```lua
C_VoiceChat.GetCurrentVoiceChatConnectionStatusCode() -> statusCode?: VoiceChatStatusCode
```

### GetInputVolume

```lua
C_VoiceChat.GetInputVolume() -> volume?: number
```

### GetJoinClubVoiceChannelError

```lua
C_VoiceChat.GetJoinClubVoiceChannelError(clubId: ClubId) -> errorReason?: VoiceChannelErrorReason
```

### GetLocalPlayerActiveChannelMemberInfo

```lua
C_VoiceChat.GetLocalPlayerActiveChannelMemberInfo() -> memberInfo?: VoiceChatMember
```

### GetLocalPlayerMemberID

```lua
C_VoiceChat.GetLocalPlayerMemberID(channelID: VoiceChatID) -> memberID?: VoiceChatID
```

### GetMasterVolumeScale

```lua
C_VoiceChat.GetMasterVolumeScale() -> scale: number
```

### GetMemberGUID

```lua
C_VoiceChat.GetMemberGUID(memberID: VoiceChatID, channelID: VoiceChatID) -> memberGUID: WOWGUID
```

### GetMemberID

```lua
C_VoiceChat.GetMemberID(channelID: VoiceChatID, memberGUID: WOWGUID) -> memberID?: VoiceChatID
```

### GetMemberInfo

```lua
C_VoiceChat.GetMemberInfo(memberID: VoiceChatID, channelID: VoiceChatID) -> memberInfo?: VoiceChatMember
```

### GetMemberName

```lua
C_VoiceChat.GetMemberName(memberID: VoiceChatID, channelID: VoiceChatID) -> memberName?: string
```

### GetMemberVolume

```lua
C_VoiceChat.GetMemberVolume(playerLocation: PlayerLocation) -> volume?: number
```

### GetOutputVolume

```lua
C_VoiceChat.GetOutputVolume() -> volume?: number
```

### GetProcesses

```lua
C_VoiceChat.GetProcesses() -> processes: table
```

### GetPTTButtonPressedState

```lua
C_VoiceChat.GetPTTButtonPressedState() -> isPressed?: bool
```

### GetPushToTalkBinding

```lua
C_VoiceChat.GetPushToTalkBinding() -> keys?: table
```

### GetRemoteTtsVoices

```lua
C_VoiceChat.GetRemoteTtsVoices() -> ttsVoices: table
```

### GetTtsVoices

```lua
C_VoiceChat.GetTtsVoices() -> ttsVoices: table
```

### GetVADSensitivity

```lua
C_VoiceChat.GetVADSensitivity() -> sensitivity?: number
```

### IsChannelJoinPending

```lua
C_VoiceChat.IsChannelJoinPending(channelType: ChatChannelType, clubId?: ClubId, streamId?: ClubStreamId) -> isPending: bool
```

### IsDeafened

```lua
C_VoiceChat.IsDeafened() -> isDeafened?: bool
```

### IsEnabled

```lua
C_VoiceChat.IsEnabled() -> isEnabled: bool
```

### IsLoggedIn

```lua
C_VoiceChat.IsLoggedIn() -> isLoggedIn: bool
```

### IsMemberLocalPlayer

```lua
C_VoiceChat.IsMemberLocalPlayer(memberID: VoiceChatID, channelID: VoiceChatID) -> isLocalPlayer: bool
```

### IsMemberMuted

```lua
C_VoiceChat.IsMemberMuted(playerLocation: PlayerLocation) -> mutedForMe?: bool
```

### IsMemberMutedForAll

```lua
C_VoiceChat.IsMemberMutedForAll(memberID: VoiceChatID, channelID: VoiceChatID) -> mutedForAll?: bool
```

### IsMemberSilenced

```lua
C_VoiceChat.IsMemberSilenced(memberID: VoiceChatID, channelID: VoiceChatID) -> silenced?: bool
```

### IsMuted

```lua
C_VoiceChat.IsMuted() -> isMuted?: bool
```

### IsParentalDisabled

```lua
C_VoiceChat.IsParentalDisabled() -> isParentalDisabled: bool
```

### IsParentalMuted

```lua
C_VoiceChat.IsParentalMuted() -> isParentalMuted: bool
```

### IsPlayerUsingVoice

```lua
C_VoiceChat.IsPlayerUsingVoice(playerLocation: PlayerLocation) -> isUsingVoice: bool
```

### IsSilenced

```lua
C_VoiceChat.IsSilenced() -> isSilenced?: bool
```

### IsSpeakForMeActive

```lua
C_VoiceChat.IsSpeakForMeActive() -> isActive: bool
```

### IsSpeakForMeAllowed

```lua
C_VoiceChat.IsSpeakForMeAllowed() -> isAllowed: bool
```

### IsTranscribing

```lua
C_VoiceChat.IsTranscribing() -> isTranscribing: bool
```

### IsTranscriptionAllowed

```lua
C_VoiceChat.IsTranscriptionAllowed() -> isAllowed: bool
```

### IsVoiceChatConnected

```lua
C_VoiceChat.IsVoiceChatConnected() -> connected: bool
```

### LeaveChannel

```lua
C_VoiceChat.LeaveChannel(channelID: VoiceChatID)
```

### Login

```lua
C_VoiceChat.Login(channelType?: ChatChannelType) -> status: VoiceChatStatusCode
```

### Logout

```lua
C_VoiceChat.Logout() -> status: VoiceChatStatusCode
```

### MarkChannelsDiscovered

```lua
C_VoiceChat.MarkChannelsDiscovered()
```

### RequestJoinAndActivateCommunityStreamChannel

```lua
C_VoiceChat.RequestJoinAndActivateCommunityStreamChannel(clubId: ClubId, streamId: ClubStreamId)
```

### RequestJoinChannelByChannelType

```lua
C_VoiceChat.RequestJoinChannelByChannelType(channelType: ChatChannelType, autoActivate?: bool)
```

### RestoreActiveVoiceProvider

```lua
C_VoiceChat.RestoreActiveVoiceProvider() -> changed: bool
```

### SetActiveVoiceProvider

```lua
C_VoiceChat.SetActiveVoiceProvider(voiceProviderID: VoiceProviderID) -> success: bool
```

### SetCommunicationMode

```lua
C_VoiceChat.SetCommunicationMode(communicationMode: CommunicationMode)
```

### SetDeafened

```lua
C_VoiceChat.SetDeafened(isDeafened: bool)
```

### SetInputDevice

```lua
C_VoiceChat.SetInputDevice(deviceID: string)
```

### SetInputVolume

```lua
C_VoiceChat.SetInputVolume(volume: number)
```

### SetMasterVolumeScale

```lua
C_VoiceChat.SetMasterVolumeScale(scale: number)
```

### SetMemberMuted

```lua
C_VoiceChat.SetMemberMuted(playerLocation: PlayerLocation, muted: bool)
```

### SetMemberVolume

```lua
C_VoiceChat.SetMemberVolume(playerLocation: PlayerLocation, volume: number)
```

### SetMuted

```lua
C_VoiceChat.SetMuted(isMuted: bool)
```

### SetOutputDevice

```lua
C_VoiceChat.SetOutputDevice(deviceID: string)
```

### SetOutputVolume

```lua
C_VoiceChat.SetOutputVolume(volume: number)
```

### SetPortraitTexture

```lua
C_VoiceChat.SetPortraitTexture(textureObject: SimpleTexture, memberID: VoiceChatID, channelID: VoiceChatID)
```

### SetPushToTalkBinding

```lua
C_VoiceChat.SetPushToTalkBinding(keys: table)
```

### SetVADSensitivity

```lua
C_VoiceChat.SetVADSensitivity(sensitivity: number)
```

### ShouldDiscoverChannels

```lua
C_VoiceChat.ShouldDiscoverChannels() -> shouldDiscoverChannels: bool
```

### SpeakRemoteTextSample

```lua
C_VoiceChat.SpeakRemoteTextSample(text: string)
```

### SpeakText

```lua
C_VoiceChat.SpeakText(voiceID: number, text: cstring, rate: number, volume: number, overlap: bool)
```

### StopSpeakingText

```lua
C_VoiceChat.StopSpeakingText()
```

### ToggleDeafened

```lua
C_VoiceChat.ToggleDeafened()
```

### ToggleMemberMuted

```lua
C_VoiceChat.ToggleMemberMuted(playerLocation: PlayerLocation)
```

### ToggleMuted

```lua
C_VoiceChat.ToggleMuted()
```

## Events

### VoiceChatActiveInputDeviceUpdated

Fires as `VOICE_CHAT_ACTIVE_INPUT_DEVICE_UPDATED`.

No payload.

### VoiceChatActiveOutputDeviceUpdated

Fires as `VOICE_CHAT_ACTIVE_OUTPUT_DEVICE_UPDATED`.

No payload.

### VoiceChatActiveVoiceProviderChanged

Fires as `VOICE_CHAT_ACTIVE_VOICE_PROVIDER_CHANGED`.

```lua
payload: voiceProviderID: VoiceProviderID
```

### VoiceChatAudioCaptureEnergy

Fires as `VOICE_CHAT_AUDIO_CAPTURE_ENERGY`.

```lua
payload: isSpeaking: bool, energy: number
```

### VoiceChatAudioCaptureStarted

Fires as `VOICE_CHAT_AUDIO_CAPTURE_STARTED`.

No payload.

### VoiceChatAudioCaptureStopped

Fires as `VOICE_CHAT_AUDIO_CAPTURE_STOPPED`.

No payload.

### VoiceChatChannelActivated

Fires as `VOICE_CHAT_CHANNEL_ACTIVATED`.

```lua
payload: channelID: VoiceChatID
```

### VoiceChatChannelDeactivated

Fires as `VOICE_CHAT_CHANNEL_DEACTIVATED`.

```lua
payload: channelID: VoiceChatID
```

### VoiceChatChannelDisplayNameChanged

Fires as `VOICE_CHAT_CHANNEL_DISPLAY_NAME_CHANGED`.

```lua
payload: channelID: VoiceChatID, channelDisplayName: cstring
```

### VoiceChatChannelJoined

Fires as `VOICE_CHAT_CHANNEL_JOINED`.

```lua
payload: status: VoiceChatStatusCode, channelID: VoiceChatID, channelType: ChatChannelType, clubId?: ClubId, streamId?: ClubStreamId
```

### VoiceChatChannelMemberActiveStateChanged

Fires as `VOICE_CHAT_CHANNEL_MEMBER_ACTIVE_STATE_CHANGED`.

```lua
payload: memberID: VoiceChatID, channelID: VoiceChatID, isActive: bool
```

### VoiceChatChannelMemberAdded

Fires as `VOICE_CHAT_CHANNEL_MEMBER_ADDED`.

```lua
payload: memberID: VoiceChatID, channelID: VoiceChatID
```

### VoiceChatChannelMemberEnergyChanged

Fires as `VOICE_CHAT_CHANNEL_MEMBER_ENERGY_CHANGED`.

```lua
payload: memberID: VoiceChatID, channelID: VoiceChatID, speakingEnergy: number
```

### VoiceChatChannelMemberGuidUpdated

Fires as `VOICE_CHAT_CHANNEL_MEMBER_GUID_UPDATED`.

```lua
payload: memberID: VoiceChatID, channelID: VoiceChatID
```

### VoiceChatChannelMemberMuteForAllChanged

Fires as `VOICE_CHAT_CHANNEL_MEMBER_MUTE_FOR_ALL_CHANGED`.

```lua
payload: memberID: VoiceChatID, channelID: VoiceChatID, isMutedForAll: bool
```

### VoiceChatChannelMemberMuteForMeChanged

Fires as `VOICE_CHAT_CHANNEL_MEMBER_MUTE_FOR_ME_CHANGED`.

```lua
payload: memberID: VoiceChatID, channelID: VoiceChatID, isMutedForMe: bool
```

### VoiceChatChannelMemberRemoved

Fires as `VOICE_CHAT_CHANNEL_MEMBER_REMOVED`.

```lua
payload: memberID: VoiceChatID, channelID: VoiceChatID
```

### VoiceChatChannelMemberSilencedChanged

Fires as `VOICE_CHAT_CHANNEL_MEMBER_SILENCED_CHANGED`.

```lua
payload: memberID: VoiceChatID, channelID: VoiceChatID, isSilenced: bool
```

### VoiceChatChannelMemberSpeakingStateChanged

Fires as `VOICE_CHAT_CHANNEL_MEMBER_SPEAKING_STATE_CHANGED`.

```lua
payload: memberID: VoiceChatID, channelID: VoiceChatID, isSpeaking: bool
```

### VoiceChatChannelMemberSttMessage

Fires as `VOICE_CHAT_CHANNEL_MEMBER_STT_MESSAGE`.

```lua
payload: memberID: VoiceChatID, channelID: VoiceChatID, message: string, language: string
```

### VoiceChatChannelMemberVolumeChanged

Fires as `VOICE_CHAT_CHANNEL_MEMBER_VOLUME_CHANGED`.

```lua
payload: memberID: VoiceChatID, channelID: VoiceChatID, volume: number
```

### VoiceChatChannelMuteStateChanged

Fires as `VOICE_CHAT_CHANNEL_MUTE_STATE_CHANGED`.

```lua
payload: channelID: VoiceChatID, isMuted: bool
```

### VoiceChatChannelPttChanged

Fires as `VOICE_CHAT_CHANNEL_PTT_CHANGED`.

```lua
payload: channelID: VoiceChatID, pushToTalkSetting: cstring
```

### VoiceChatChannelRemoved

Fires as `VOICE_CHAT_CHANNEL_REMOVED`.

```lua
payload: channelID: VoiceChatID
```

### VoiceChatChannelTranscribingChanged

Fires as `VOICE_CHAT_CHANNEL_TRANSCRIBING_CHANGED`.

```lua
payload: channelID: VoiceChatID, isTranscribing: bool
```

### VoiceChatChannelTransmitChanged

Fires as `VOICE_CHAT_CHANNEL_TRANSMIT_CHANGED`.

```lua
payload: channelID: VoiceChatID, isTransmitting: bool
```

### VoiceChatChannelVolumeChanged

Fires as `VOICE_CHAT_CHANNEL_VOLUME_CHANGED`.

```lua
payload: channelID: VoiceChatID, volume: number
```

### VoiceChatCommunicationModeChanged

Fires as `VOICE_CHAT_COMMUNICATION_MODE_CHANGED`.

```lua
payload: communicationMode: CommunicationMode
```

### VoiceChatConnectionSuccess

Fires as `VOICE_CHAT_CONNECTION_SUCCESS`.

No payload.

### VoiceChatDeafenedChanged

Fires as `VOICE_CHAT_DEAFENED_CHANGED`.

```lua
payload: isDeafened: bool
```

### VoiceChatDiscordSettingsUpdated

Fires as `VOICE_CHAT_DISCORD_SETTINGS_UPDATED`.

No payload.

### VoiceChatError

Fires as `VOICE_CHAT_ERROR`.

```lua
payload: platformCode: number, statusCode: VoiceChatStatusCode
```

### VoiceChatInputDevicesUpdated

Fires as `VOICE_CHAT_INPUT_DEVICES_UPDATED`.

No payload.

### VoiceChatLogin

Fires as `VOICE_CHAT_LOGIN`.

```lua
payload: status: VoiceChatStatusCode
```

### VoiceChatLogout

Fires as `VOICE_CHAT_LOGOUT`.

```lua
payload: status: VoiceChatStatusCode
```

### VoiceChatMutedChanged

Fires as `VOICE_CHAT_MUTED_CHANGED`.

```lua
payload: isMuted: bool
```

### VoiceChatOutputDevicesUpdated

Fires as `VOICE_CHAT_OUTPUT_DEVICES_UPDATED`.

No payload.

### VoiceChatPendingChannelJoinState

Fires as `VOICE_CHAT_PENDING_CHANNEL_JOIN_STATE`.

```lua
payload: channelType: ChatChannelType, clubId?: ClubId, streamId?: ClubStreamId, pendingJoin: bool
```

### VoiceChatPttButtonPressedStateChanged

Fires as `VOICE_CHAT_PTT_BUTTON_PRESSED_STATE_CHANGED`.

```lua
payload: isPressed: bool
```

### VoiceChatSilencedChanged

Fires as `VOICE_CHAT_SILENCED_CHANGED`.

```lua
payload: isSilenced: bool
```

### VoiceChatSpeakForMeActiveStatusUpdated

Fires as `VOICE_CHAT_SPEAK_FOR_ME_ACTIVE_STATUS_UPDATED`.

No payload.

### VoiceChatSpeakForMeFeatureStatusUpdated

Fires as `VOICE_CHAT_SPEAK_FOR_ME_FEATURE_STATUS_UPDATED`.

No payload.

### VoiceChatTtsPlaybackBookmark

Fires as `VOICE_CHAT_TTS_PLAYBACK_BOOKMARK`.

```lua
payload: utteranceID: number, bookmarkName: cstring
```

### VoiceChatTtsPlaybackFailed

Fires as `VOICE_CHAT_TTS_PLAYBACK_FAILED`.

```lua
payload: utteranceID: number, status: VoiceTtsStatusCode
```

### VoiceChatTtsPlaybackFinished

Fires as `VOICE_CHAT_TTS_PLAYBACK_FINISHED`.

```lua
payload: utteranceID: number
```

### VoiceChatTtsPlaybackStarted

Fires as `VOICE_CHAT_TTS_PLAYBACK_STARTED`.

```lua
payload: utteranceID: number
```

### VoiceChatTtsSpeakTextUpdate

Fires as `VOICE_CHAT_TTS_SPEAK_TEXT_UPDATE`.

```lua
payload: status: VoiceTtsStatusCode, utteranceID: number
```

### VoiceChatTtsVoicesUpdate

Fires as `VOICE_CHAT_TTS_VOICES_UPDATE`.

No payload.

### VoiceChatVadSettingsUpdated

Fires as `VOICE_CHAT_VAD_SETTINGS_UPDATED`.

No payload.

### VoiceChatVoiceProviderChanged

Fires as `VOICE_CHAT_VOICE_PROVIDER_CHANGED`.

```lua
payload: voiceProviderID: VoiceProviderID
```

### VoiceChatVoiceProvidersAvailableChanged

Fires as `VOICE_CHAT_VOICE_PROVIDERS_AVAILABLE_CHANGED`.

No payload.
