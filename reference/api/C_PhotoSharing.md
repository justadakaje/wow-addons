# C_PhotoSharing

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`11` functions - `5` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### BeginAuthorizationFlow

```lua
C_PhotoSharing.BeginAuthorizationFlow()
```

### ClearAuthorization

```lua
C_PhotoSharing.ClearAuthorization()
```

### CompleteAuthorizationFlow

```lua
C_PhotoSharing.CompleteAuthorizationFlow(callbackURL: cstring)
```

### GetCropRatio

```lua
C_PhotoSharing.GetCropRatio() -> cropRatio: number
```

### GetPhotoSharingAuthURL

```lua
C_PhotoSharing.GetPhotoSharingAuthURL() -> authUrl: cstring
```

### GetStatus

```lua
C_PhotoSharing.GetStatus() -> status: PhotoSharingStatus
```

### IsAuthorized

```lua
C_PhotoSharing.IsAuthorized() -> authorized: bool
```

### IsEnabled

```lua
C_PhotoSharing.IsEnabled() -> enabled: bool
```

### SetScreenshotPreviewTexture

```lua
C_PhotoSharing.SetScreenshotPreviewTexture(textureObject: SimpleTexture)
```

### TakePhoto

```lua
C_PhotoSharing.TakePhoto()
```

### UploadPhotoToService

```lua
C_PhotoSharing.UploadPhotoToService(optionalTitle: cstring, optionalDescription: cstring)
```

## Events

### PhotoSharingAuthorizationNeeded

Fires as `PHOTO_SHARING_AUTHORIZATION_NEEDED`.

No payload.

### PhotoSharingAuthorizationUpdated

Fires as `PHOTO_SHARING_AUTHORIZATION_UPDATED`.

```lua
payload: showNotification: bool
```

### PhotoSharingPhotoUploadStatus

Fires as `PHOTO_SHARING_PHOTO_UPLOAD_STATUS`.

```lua
payload: uploadStatus: PhotoSharingUploadStatus
```

### PhotoSharingScreenshotReady

Fires as `PHOTO_SHARING_SCREENSHOT_READY`.

No payload.

### PhotoSharingThirdPartyAuthorizationNeeded

Fires as `PHOTO_SHARING_THIRD_PARTY_AUTHORIZATION_NEEDED`.

```lua
payload: authUrl: string
```
