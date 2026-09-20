# C_ClientScene

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`1` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### IsSceneTypeActive

```lua
C_ClientScene.IsSceneTypeActive(desiredSceneType?: ClientSceneType) -> isPlaying: bool
```

## Events

### ClientSceneClosed

Fires as `CLIENT_SCENE_CLOSED`.

No payload.

### ClientSceneOpened

Fires as `CLIENT_SCENE_OPENED`.

```lua
payload: sceneType: ClientSceneType
```
