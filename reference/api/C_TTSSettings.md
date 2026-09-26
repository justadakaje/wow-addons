# C_TTSSettings

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`19` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetChannelEnabled

```lua
C_TTSSettings.GetChannelEnabled(channelInfo: ChatChannelInfo) -> enabled: bool
```

### GetCharacterSettingsSaved

```lua
C_TTSSettings.GetCharacterSettingsSaved() -> settingsBeenSaved: bool
```

### GetChatTypeEnabled

```lua
C_TTSSettings.GetChatTypeEnabled(chatName: cstring) -> enabled: bool
```

### GetSetting

```lua
C_TTSSettings.GetSetting(setting: TtsBoolSetting) -> enabled: bool
```

### GetSpeechRate

```lua
C_TTSSettings.GetSpeechRate() -> rate: number
```

### GetSpeechVolume

```lua
C_TTSSettings.GetSpeechVolume() -> volume: number
```

### GetVoiceOptionID

```lua
C_TTSSettings.GetVoiceOptionID(voiceType: TtsVoiceType) -> voiceID: number
```

### GetVoiceOptionName

```lua
C_TTSSettings.GetVoiceOptionName(voiceType: TtsVoiceType) -> voiceName: cstring
```

### MarkCharacterSettingsSaved

```lua
C_TTSSettings.MarkCharacterSettingsSaved()
```

### SetChannelEnabled

```lua
C_TTSSettings.SetChannelEnabled(channelInfo: ChatChannelInfo, newVal: bool)
```

### SetChannelKeyEnabled

```lua
C_TTSSettings.SetChannelKeyEnabled(channelKey: string, newVal: bool)
```

### SetChatTypeEnabled

```lua
C_TTSSettings.SetChatTypeEnabled(chatName: cstring, newVal: bool)
```

### SetDefaultSettings

```lua
C_TTSSettings.SetDefaultSettings()
```

### SetSetting

```lua
C_TTSSettings.SetSetting(setting: TtsBoolSetting, newVal: bool)
```

### SetSpeechRate

```lua
C_TTSSettings.SetSpeechRate(newVal: number)
```

### SetSpeechVolume

```lua
C_TTSSettings.SetSpeechVolume(newVal: number)
```

### SetVoiceOption

```lua
C_TTSSettings.SetVoiceOption(voiceType: TtsVoiceType, voiceID: number)
```

### SetVoiceOptionName

```lua
C_TTSSettings.SetVoiceOptionName(voiceType: TtsVoiceType, voiceName: string)
```

### ShouldOverrideMessage

```lua
C_TTSSettings.ShouldOverrideMessage(language: number, messageText: string) -> overrideMessage: bool
```
