# C_ModelInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`8` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddActiveModelScene

```lua
C_ModelInfo.AddActiveModelScene(modelSceneFrame: ModelSceneFrame, modelSceneID: number)
```

### AddActiveModelSceneActor

```lua
C_ModelInfo.AddActiveModelSceneActor(modelSceneFrameActor: ModelSceneFrameActor, modelSceneActorID: number)
```

### ClearActiveModelScene

```lua
C_ModelInfo.ClearActiveModelScene(modelSceneFrame: ModelSceneFrame)
```

### ClearActiveModelSceneActor

```lua
C_ModelInfo.ClearActiveModelSceneActor(modelSceneFrameActor: ModelSceneFrameActor)
```

### GetModelSceneActorDisplayInfoByID

```lua
C_ModelInfo.GetModelSceneActorDisplayInfoByID(modelActorDisplayID: number) -> actorDisplayInfo: UIModelSceneActorDisplayInfo
```

### GetModelSceneActorInfoByID

```lua
C_ModelInfo.GetModelSceneActorInfoByID(modelActorID: number) -> actorInfo: UIModelSceneActorInfo
```

### GetModelSceneCameraInfoByID

```lua
C_ModelInfo.GetModelSceneCameraInfoByID(modelSceneCameraID: number) -> modelSceneCameraInfo: UIModelSceneCameraInfo
```

### GetModelSceneInfoByID

```lua
C_ModelInfo.GetModelSceneInfoByID(modelSceneID: number) -> modelSceneType: ModelSceneType, modelCameraIDs: table, modelActorsIDs: table, flags: number
```

## Events

### UiModelSceneInfoUpdated

Fires as `UI_MODEL_SCENE_INFO_UPDATED`.

No payload.
