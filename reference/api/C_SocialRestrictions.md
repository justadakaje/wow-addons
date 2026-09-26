# C_SocialRestrictions

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`9` functions - `3` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AcknowledgeRegionalChatDisabled

```lua
C_SocialRestrictions.AcknowledgeRegionalChatDisabled()
```

### CanReceiveChat

```lua
C_SocialRestrictions.CanReceiveChat() -> canReceiveChat: bool
```

### CanSendChat

```lua
C_SocialRestrictions.CanSendChat() -> canSendChat: bool
```

### IsChatDisabled

```lua
C_SocialRestrictions.IsChatDisabled() -> disabled: bool
```

### IsFriendsDisabled

```lua
C_SocialRestrictions.IsFriendsDisabled() -> disabled: bool
```

### IsMuted

```lua
C_SocialRestrictions.IsMuted() -> isMuted: bool
```

### IsSilenced

```lua
C_SocialRestrictions.IsSilenced() -> isSilenced: bool
```

### IsSquelched

```lua
C_SocialRestrictions.IsSquelched() -> isSquelched: bool
```

### SetChatDisabled

```lua
C_SocialRestrictions.SetChatDisabled(disabled: bool)
```

## Events

### AlertRegionalChatDisabled

Fires as `ALERT_REGIONAL_CHAT_DISABLED`.

No payload.

### ChatDisabledChanged

Fires as `CHAT_DISABLED_CHANGED`.

```lua
payload: disabled: bool
```

### ChatDisabledChangeFailed

Fires as `CHAT_DISABLED_CHANGE_FAILED`.

```lua
payload: disabled: bool
```
