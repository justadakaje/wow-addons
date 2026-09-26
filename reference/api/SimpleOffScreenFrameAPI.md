# SimpleOffScreenFrameAPI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`8` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ApplySnapshot

```lua
ApplySnapshot(texture: SimpleTexture, snapshotID: number) -> success: bool
```

### Flush

```lua
Flush()
```

### GetMaxSnapshots

```lua
GetMaxSnapshots() -> maxSnapshots: number
```

### IsSnapshotValid

```lua
IsSnapshotValid(snapshotID: number) -> isValid: bool
```

### SetMaxSnapshots

```lua
SetMaxSnapshots(maxSnapshots: number)
```

### TakeSnapshot

```lua
TakeSnapshot() -> snapshotID?: number
```

### TestPrintToFile

```lua
TestPrintToFile(snapshotID: number, filename: cstring) -> success: bool
```

### UsesNPOT

```lua
UsesNPOT() -> usesNPOT?: bool
```
