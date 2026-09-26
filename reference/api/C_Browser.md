# C_Browser

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`1` functions - `7` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CloseFullscreenBrowser

```lua
C_Browser.CloseFullscreenBrowser()
```

## Events

### FullscreenBrowserSpinnerHide

Fires as `FULLSCREEN_BROWSER_SPINNER_HIDE`.

No payload.

### FullscreenBrowserSpinnerShow

Fires as `FULLSCREEN_BROWSER_SPINNER_SHOW`.

No payload.

### SimpleBrowserPopup

Fires as `SIMPLE_BROWSER_POPUP`.

```lua
payload: url: string
```

### SimpleBrowserSocialCallbackInvoked

Fires as `SIMPLE_BROWSER_SOCIAL_CALLBACK_INVOKED`.

```lua
payload: url: string
```

### SimpleBrowserWebError

Fires as `SIMPLE_BROWSER_WEB_ERROR`.

```lua
payload: errorCode: number
```

### SimpleBrowserWebProxyFailed

Fires as `SIMPLE_BROWSER_WEB_PROXY_FAILED`.

No payload.

### SimpleCheckoutClosed

Fires as `SIMPLE_CHECKOUT_CLOSED`.

No payload.
