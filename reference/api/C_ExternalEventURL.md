# C_ExternalEventURL

WoW: Forever 1.60.1 (build 70862) - Interface 16001

`4` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanShow

```lua
C_ExternalEventURL.CanShow() -> canShow: bool
```

### HasURL

```lua
C_ExternalEventURL.HasURL() -> hasURL: bool
```

### IsNew

```lua
C_ExternalEventURL.IsNew() -> isNew: bool
```

### LaunchURL

```lua
C_ExternalEventURL.LaunchURL()
```

## Events

### ExternalEventLaunchUrlResult

Fires as `EXTERNAL_EVENT_LAUNCH_URL_RESULT`.

```lua
payload: result: bool
```

### ExternalEventUrlChanged

Fires as `EXTERNAL_EVENT_URL_CHANGED`.

No payload.
