# C_VoiceChat

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`79` functions - `47` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ActivateChannel

```lua
C_VoiceChat.ActivateChannel(channelID: number)
```

### ActivateChannelTranscription

```lua
C_VoiceChat.ActivateChannelTranscription(channelID: number)
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
C_VoiceChat.DeactivateChannel(channelID: number)
```

### DeactivateChannelTranscription

```lua
C_VoiceChat.DeactivateChannelTranscription(channelID: number)
```

### EndLocalCapture

```lua
C_VoiceChat.EndLocalCapture()
```

### GetActiveChannelID

```lua
C_VoiceChat.GetActiveChannelID() -> channelID?: number
```

### GetActiveChannelType

```lua
C_VoiceChat.GetActiveChannelType() -> channelType?: ChatChannelType
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
C_VoiceChat.GetChannel(channelID: number) -> channel: VoiceChatChannel
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
C_VoiceChat.GetLocalPlayerMemberID(channelID: number) -> memberID?: number
```

### GetMasterVolumeScale

```lua
C_VoiceChat.GetMasterVolumeScale() -> scale: number
```

### GetMemberGUID

```lua
C_VoiceChat.GetMemberGUID(memberID: number, channelID: number) -> memberGUID: WOWGUID
```

### GetMemberID

```lua
C_VoiceChat.GetMemberID(channelID: number, memberGUID: WOWGUID) -> memberID?: number
```

### GetMemberInfo

```lua
C_VoiceChat.GetMemberInfo(memberID: number, channelID: number) -> memberInfo?: VoiceChatMember
```

### GetMemberName

```lua
C_VoiceChat.GetMemberName(memberID: number, channelID: number) -> memberName?: string
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
C_VoiceChat.IsMemberLocalPlayer(memberID: number, channelID: number) -> isLocalPlayer: bool
```

### IsMemberMuted

```lua
C_VoiceChat.IsMemberMuted(playerLocation: PlayerLocation) -> mutedForMe?: bool
```

### IsMemberMutedForAll

```lua
C_VoiceChat.IsMemberMutedForAll(memberID: number, channelID: number) -> mutedForAll?: bool
```

### IsMemberSilenced

```lua
C_VoiceChat.IsMemberSilenced(memberID: number, channelID: number) -> silenced?: bool
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
C_VoiceChat.LeaveChannel(channelID: number)
```

### Login

```lua
C_VoiceChat.Login() -> status: VoiceChatStatusCode
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
C_VoiceChat.SetPortraitTexture(textureObject: SimpleTexture, memberID: number, channelID: number)
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
payload: channelID: number
```

### VoiceChatChannelDeactivated

Fires as `VOICE_CHAT_CHANNEL_DEACTIVATED`.

```lua
payload: channelID: number
```

### VoiceChatChannelDisplayNameChanged

Fires as `VOICE_CHAT_CHANNEL_DISPLAY_NAME_CHANGED`.

```lua
payload: channelID: number, channelDisplayName: cstring
```

### VoiceChatChannelJoined

Fires as `VOICE_CHAT_CHANNEL_JOINED`.

```lua
payload: status: VoiceChatStatusCode, channelID: number, channelType: ChatChannelType, clubId?: ClubId, streamId?: ClubStreamId
```

### VoiceChatChannelMemberActiveStateChanged

Fires as `VOICE_CHAT_CHANNEL_MEMBER_ACTIVE_STATE_CHANGED`.

```lua
payload: memberID: number, channelID: number, isActive: bool
```

### VoiceChatChannelMemberAdded

Fires as `VOICE_CHAT_CHANNEL_MEMBER_ADDED`.

```lua
payload: memberID: number, channelID: number
```

### VoiceChatChannelMemberEnergyChanged

Fires as `VOICE_CHAT_CHANNEL_MEMBER_ENERGY_CHANGED`.

```lua
payload: memberID: number, channelID: number, speakingEnergy: number
```

### VoiceChatChannelMemberGuidUpdated

Fires as `VOICE_CHAT_CHANNEL_MEMBER_GUID_UPDATED`.

```lua
payload: memberID: number, channelID: number
```

### VoiceChatChannelMemberMuteForAllChanged

Fires as `VOICE_CHAT_CHANNEL_MEMBER_MUTE_FOR_ALL_CHANGED`.

```lua
payload: memberID: number, channelID: number, isMutedForAll: bool
```

### VoiceChatChannelMemberMuteForMeChanged

Fires as `VOICE_CHAT_CHANNEL_MEMBER_MUTE_FOR_ME_CHANGED`.

```lua
payload: memberID: number, channelID: number, isMutedForMe: bool
```

### VoiceChatChannelMemberRemoved

Fires as `VOICE_CHAT_CHANNEL_MEMBER_REMOVED`.

```lua
payload: memberID: number, channelID: number
```

### VoiceChatChannelMemberSilencedChanged

Fires as `VOICE_CHAT_CHANNEL_MEMBER_SILENCED_CHANGED`.

```lua
payload: memberID: number, channelID: number, isSilenced: bool
```

### VoiceChatChannelMemberSpeakingStateChanged

Fires as `VOICE_CHAT_CHANNEL_MEMBER_SPEAKING_STATE_CHANGED`.

```lua
payload: memberID: number, channelID: number, isSpeaking: bool
```

### VoiceChatChannelMemberSttMessage

Fires as `VOICE_CHAT_CHANNEL_MEMBER_STT_MESSAGE`.

```lua
payload: memberID: number, channelID: number, message: string, language: string
```

### VoiceChatChannelMemberVolumeChanged

Fires as `VOICE_CHAT_CHANNEL_MEMBER_VOLUME_CHANGED`.

```lua
payload: memberID: number, channelID: number, volume: number
```

### VoiceChatChannelMuteStateChanged

Fires as `VOICE_CHAT_CHANNEL_MUTE_STATE_CHANGED`.

```lua
payload: channelID: number, isMuted: bool
```

### VoiceChatChannelPttChanged

Fires as `VOICE_CHAT_CHANNEL_PTT_CHANGED`.

```lua
payload: channelID: number, pushToTalkSetting: cstring
```

### VoiceChatChannelRemoved

Fires as `VOICE_CHAT_CHANNEL_REMOVED`.

```lua
payload: channelID: number
```

### VoiceChatChannelTranscribingChanged

Fires as `VOICE_CHAT_CHANNEL_TRANSCRIBING_CHANGED`.

```lua
payload: channelID: number, isTranscribing: bool
```

### VoiceChatChannelTransmitChanged

Fires as `VOICE_CHAT_CHANNEL_TRANSMIT_CHANGED`.

```lua
payload: channelID: number, isTransmitting: bool
```

### VoiceChatChannelVolumeChanged

Fires as `VOICE_CHAT_CHANNEL_VOLUME_CHANGED`.

```lua
payload: channelID: number, volume: number
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
