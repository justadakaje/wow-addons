# C_HouseEditor

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`10` functions - `3` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ActivateHouseEditorMode

```lua
C_HouseEditor.ActivateHouseEditorMode(editMode: HouseEditorMode) -> result: HousingResult
```

### EnterHouseEditor

```lua
C_HouseEditor.EnterHouseEditor() -> result: HousingResult
```

### GetActiveHouseEditorMode

```lua
C_HouseEditor.GetActiveHouseEditorMode() -> editMode: HouseEditorMode
```

### GetHouseEditorAvailability

```lua
C_HouseEditor.GetHouseEditorAvailability() -> result: HousingResult
```

### GetHouseEditorModeAvailability

```lua
C_HouseEditor.GetHouseEditorModeAvailability(editMode: HouseEditorMode) -> result: HousingResult
```

### GetHouseEditorPlayerType

```lua
C_HouseEditor.GetHouseEditorPlayerType() -> playerType: HouseEditorPlayerType
```

### IsHouseEditorActive

```lua
C_HouseEditor.IsHouseEditorActive() -> isEditorActive: bool
```

### IsHouseEditorModeActive

```lua
C_HouseEditor.IsHouseEditorModeActive(editMode: HouseEditorMode) -> isModeActive: bool
```

### IsHouseEditorStatusAvailable

```lua
C_HouseEditor.IsHouseEditorStatusAvailable() -> editorStatusAvailable: bool
```

### LeaveHouseEditor

```lua
C_HouseEditor.LeaveHouseEditor()
```

## Events

### HouseEditorAvailabilityChanged

Fires as `HOUSE_EDITOR_AVAILABILITY_CHANGED`.

No payload.

### HouseEditorModeChanged

Fires as `HOUSE_EDITOR_MODE_CHANGED`.

```lua
payload: currentEditMode: HouseEditorMode
```

### HouseEditorModeChangeFailure

Fires as `HOUSE_EDITOR_MODE_CHANGE_FAILURE`.

```lua
payload: result: HousingResult
```
