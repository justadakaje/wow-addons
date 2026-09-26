# C_SettingsUtil

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`2` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### NotifySettingsLoaded

```lua
C_SettingsUtil.NotifySettingsLoaded()
```

### OpenSettingsPanel

```lua
C_SettingsUtil.OpenSettingsPanel(openToCategoryID?: number, scrollToElementName?: stringView)
```

## Events

### SettingsLoaded

Fires as `SETTINGS_LOADED`.

No payload.

### SettingsPanelOpen

Fires as `SETTINGS_PANEL_OPEN`.

```lua
payload: openToCategoryID?: number, scrollToElementName?: stringView
```
