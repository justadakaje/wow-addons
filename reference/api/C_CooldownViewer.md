# C_CooldownViewer

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`7` functions - `3` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetCooldownViewerCategorySet

```lua
C_CooldownViewer.GetCooldownViewerCategorySet(category: CooldownViewerCategory, allowUnlearned: bool) -> cooldownIDs: table
```

### GetCooldownViewerCooldownInfo

```lua
C_CooldownViewer.GetCooldownViewerCooldownInfo(cooldownID: number) -> cooldownInfo: CooldownViewerCooldown
```

### GetGroupBuffItems

```lua
C_CooldownViewer.GetGroupBuffItems() -> groupBuffItems: table
```

### GetLayoutData

```lua
C_CooldownViewer.GetLayoutData() -> data: cstring
```

### GetValidAlertTypes

```lua
C_CooldownViewer.GetValidAlertTypes(cooldownID: number) -> validAlertTypes: table
```

### IsCooldownViewerAvailable

```lua
C_CooldownViewer.IsCooldownViewerAvailable() -> isAvailable: bool, failureReason: string
```

### SetLayoutData

```lua
C_CooldownViewer.SetLayoutData(data: cstring)
```

## Events

### CooldownViewerDataLoaded

Fires as `COOLDOWN_VIEWER_DATA_LOADED`.

No payload.

### CooldownViewerSpellOverrideUpdated

Fires as `COOLDOWN_VIEWER_SPELL_OVERRIDE_UPDATED`.

```lua
payload: baseSpellID: number, overrideSpellID?: number
```

### CooldownViewerTableHotfixed

Fires as `COOLDOWN_VIEWER_TABLE_HOTFIXED`.

No payload.
