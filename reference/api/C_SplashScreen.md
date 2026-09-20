# C_SplashScreen

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`5` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AcknowledgeSplash

```lua
C_SplashScreen.AcknowledgeSplash()
```

### CanViewSplashScreen

```lua
C_SplashScreen.CanViewSplashScreen() -> canView: bool
```

### RequestLatestSplashScreen

```lua
C_SplashScreen.RequestLatestSplashScreen(fromGameMenu: bool)
```

### SendSplashScreenActionLaunchedTelem

```lua
C_SplashScreen.SendSplashScreenActionLaunchedTelem()
```

### SendSplashScreenCloseTelem

```lua
C_SplashScreen.SendSplashScreenCloseTelem()
```

## Events

### OpenSplashScreen

Fires as `OPEN_SPLASH_SCREEN`.

```lua
payload: info?: SplashScreenInfo
```
