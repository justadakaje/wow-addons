# Build

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`12` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetBuildInfo

```lua
GetBuildInfo() -> buildVersion: cstring, buildNumber: cstring, buildDate: cstring, interfaceVersion: number, localizedVersion: cstring, buildInfo: string
```

### GetBuildOption

```lua
GetBuildOption(name: cstring) -> isSet?: bool
```

### Is64BitClient

```lua
Is64BitClient() -> is64Bit: bool
```

### IsBetaBuild

```lua
IsBetaBuild() -> isBetaBuild: bool
```

### IsDebugBuild

```lua
IsDebugBuild() -> isDebugBuild: bool
```

### IsLinuxClient

```lua
IsLinuxClient() -> isLinux: bool
```

### IsMacClient

```lua
IsMacClient() -> isMac: bool
```

### IsPublicBuild

```lua
IsPublicBuild() -> isPublicBuild: bool
```

### IsPublicTestClient

```lua
IsPublicTestClient() -> isPublicTestClient: bool
```

### IsTestBuild

```lua
IsTestBuild() -> isTestBuild: bool
```

### IsWindowsClient

```lua
IsWindowsClient() -> isWindows: bool
```

### SupportsClipCursor

```lua
SupportsClipCursor() -> supportsClipCursor: bool
```
