# C_GameRules

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`29` functions - `6` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AccountHasSDEnabled

```lua
C_GameRules.AccountHasSDEnabled() -> isSDEnabled: bool
```

### AutoConnectToGameModeRealm

```lua
C_GameRules.AutoConnectToGameModeRealm(gameModeRecordID: number)
```

### DoesGameModeHavePromo

```lua
C_GameRules.DoesGameModeHavePromo(gameModeRecordID: number) -> hasPromo: bool
```

### GetActiveGameMode

```lua
C_GameRules.GetActiveGameMode() -> gameMode: GameMode
```

### GetCurrentEventRealmQueues

```lua
C_GameRules.GetCurrentEventRealmQueues() -> eventRealmQueues: EventRealmQueues
```

### GetCurrentGameModeDisplayInfo

```lua
C_GameRules.GetCurrentGameModeDisplayInfo() -> info?: GameModeDisplayInfo
```

### GetCurrentGameModeRecordID

```lua
C_GameRules.GetCurrentGameModeRecordID() -> gameModeRecordID: number
```

### GetDisplayedGameModeRecordIDAtIndex

```lua
C_GameRules.GetDisplayedGameModeRecordIDAtIndex(displayIndex: luaIndex) -> gameModeRecordID: number
```

### GetGameModeDisplayInfoByRecordID

```lua
C_GameRules.GetGameModeDisplayInfoByRecordID(gameModeRecordID: number) -> info?: GameModeDisplayInfo
```

### GetGameModeGlueScreenName

```lua
C_GameRules.GetGameModeGlueScreenName() -> screenName: cstring
```

### GetGameModePromoGlobalString

```lua
C_GameRules.GetGameModePromoGlobalString(gameModeRecordID: number) -> promoGlobalString: cstring
```

### GetGameRuleAsFloat

```lua
C_GameRules.GetGameRuleAsFloat(gameRule: GameRule, decimalPlaces: number) -> value: number
```

### GetGameRuleAsFrameStrata

```lua
C_GameRules.GetGameRuleAsFrameStrata(gameRule: GameRule) -> frameStrata: cstring
```

### GetNumDisplayedGameModes

```lua
C_GameRules.GetNumDisplayedGameModes() -> numDisplayedGameModes: number
```

### IsCharacterlessLoginActive

```lua
C_GameRules.IsCharacterlessLoginActive() -> active: bool
```

### IsClassAllowedForGameMode

```lua
C_GameRules.IsClassAllowedForGameMode(classID: number) -> valid: bool
```

### IsGameModeEnabled

```lua
C_GameRules.IsGameModeEnabled(gameModeRecordID: number) -> enabled: bool
```

### IsGameRuleActive

```lua
C_GameRules.IsGameRuleActive(gameRule: GameRule) -> isActive: bool
```

### IsHardcoreActive

```lua
C_GameRules.IsHardcoreActive() -> active: bool
```

### IsMultiActionBarVisibilityForced

```lua
C_GameRules.IsMultiActionBarVisibilityForced() -> valid: bool
```

### IsPersonalResourceDisplayEnabled

```lua
C_GameRules.IsPersonalResourceDisplayEnabled() -> isPersonalResourceDisplayEnabled: bool
```

### IsPlunderstorm

```lua
C_GameRules.IsPlunderstorm() -> active: bool
```

### IsSDHDToggleEnabled

```lua
C_GameRules.IsSDHDToggleEnabled() -> isEnabled: bool
```

### IsSelfFoundAllowed

```lua
C_GameRules.IsSelfFoundAllowed() -> active: bool
```

### IsStandard

```lua
C_GameRules.IsStandard() -> active: bool
```

### IsWoWHack

```lua
C_GameRules.IsWoWHack() -> active: bool
```

### SelectClassicExperiencePreset

```lua
C_GameRules.SelectClassicExperiencePreset()
```

### SelectModernExperiencePreset

```lua
C_GameRules.SelectModernExperiencePreset()
```

### SetSDHDToggleValue

```lua
C_GameRules.SetSDHDToggleValue(setToSD: bool)
```

## Events

### ActiveGameModeUpdated

Fires as `ACTIVE_GAME_MODE_UPDATED`.

```lua
payload: gameMode: GameMode
```

### AvailableGameModesUpdated

Fires as `AVAILABLE_GAME_MODES_UPDATED`.

No payload.

### EventRealmQueuesUpdated

Fires as `EVENT_REALM_QUEUES_UPDATED`.

```lua
payload: eventRealmQueues: EventRealmQueues
```

### GameModeDisplayInfoUpdated

Fires as `GAME_MODE_DISPLAY_INFO_UPDATED`.

No payload.

### GameModeDisplayModeToggleDisabled

Fires as `GAME_MODE_DISPLAY_MODE_TOGGLE_DISABLED`.

```lua
payload: gameModeRecordID: number, disabled: bool
```

### GameRulesChanged

Fires as `GAME_RULES_CHANGED`.

No payload.
