# C_MountJournal

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`50` functions - `4` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ApplyMountEquipment

```lua
C_MountJournal.ApplyMountEquipment(itemLocation: ItemLocation) -> canContinue: bool
```

### AreMountEquipmentEffectsSuppressed

```lua
C_MountJournal.AreMountEquipmentEffectsSuppressed() -> areEffectsSuppressed: bool
```

### ClearFanfare

```lua
C_MountJournal.ClearFanfare(mountID: number)
```

### ClearRecentFanfares

```lua
C_MountJournal.ClearRecentFanfares()
```

### Dismiss

```lua
C_MountJournal.Dismiss()
```

### GetAllCreatureDisplayIDsForMountID

```lua
C_MountJournal.GetAllCreatureDisplayIDsForMountID(mountID: number) -> creatureDisplayIDs: table
```

### GetAppliedMountEquipmentID

```lua
C_MountJournal.GetAppliedMountEquipmentID() -> itemID?: number
```

### GetCollectedDragonridingMounts

```lua
C_MountJournal.GetCollectedDragonridingMounts() -> mountIDs: table
```

### GetCollectedFilterSetting

```lua
C_MountJournal.GetCollectedFilterSetting(filterIndex: luaIndex) -> isChecked: bool
```

### GetDisplayedMountAllCreatureDisplayInfo

```lua
C_MountJournal.GetDisplayedMountAllCreatureDisplayInfo(mountIndex: luaIndex) -> allDisplayInfo: table
```

### GetDisplayedMountID

```lua
C_MountJournal.GetDisplayedMountID(displayIndex: luaIndex) -> mountID: number
```

### GetDisplayedMountInfo

```lua
C_MountJournal.GetDisplayedMountInfo(displayIndex: luaIndex) -> name: cstring, spellID: number, icon: fileID, isActive: bool, isUsable: bool, sourceType: number, isFavorite: bool, isFactionSpecific: bool, faction?: PvPFaction, shouldHideOnChar: bool, isCollected: bool, mountID: number, isSteadyFlight: bool
```

### GetDisplayedMountInfoExtra

```lua
C_MountJournal.GetDisplayedMountInfoExtra(mountIndex: luaIndex) -> creatureDisplayInfoID?: number, description: cstring, source: cstring, isSelfMount: bool, mountTypeID: number, uiModelSceneID: number, animID: number, spellVisualKitID: number, disablePlayerMountPreview: bool
```

### GetDynamicFlightModeSpellID

```lua
C_MountJournal.GetDynamicFlightModeSpellID() -> spellID: number
```

### GetIsFavorite

```lua
C_MountJournal.GetIsFavorite(mountIndex: luaIndex) -> isFavorite: bool, canSetFavorite: bool
```

### GetMountAllCreatureDisplayInfoByID

```lua
C_MountJournal.GetMountAllCreatureDisplayInfoByID(mountID: number) -> allDisplayInfo: table
```

### GetMountEquipmentUnlockLevel

```lua
C_MountJournal.GetMountEquipmentUnlockLevel() -> level: number
```

### GetMountFromItem

```lua
C_MountJournal.GetMountFromItem(itemID: number) -> mountID?: number
```

### GetMountFromSpell

```lua
C_MountJournal.GetMountFromSpell(spellID: SpellIdentifier) -> mountID?: number
```

### GetMountIDs

```lua
C_MountJournal.GetMountIDs() -> mountIDs: table
```

### GetMountInfoByID

```lua
C_MountJournal.GetMountInfoByID(mountID: number) -> name: cstring, spellID: number, icon: fileID, isActive: bool, isUsable: bool, sourceType: number, isFavorite: bool, isFactionSpecific: bool, faction?: PvPFaction, shouldHideOnChar: bool, isCollected: bool, mountID: number, isSteadyFlight: bool
```

### GetMountInfoExtraByID

```lua
C_MountJournal.GetMountInfoExtraByID(mountID: number) -> creatureDisplayInfoID?: number, description: cstring, source: cstring, isSelfMount: bool, mountTypeID: number, uiModelSceneID: number, animID: number, spellVisualKitID: number, disablePlayerMountPreview: bool
```

### GetMountLink

```lua
C_MountJournal.GetMountLink(spellID: number) -> mountCreatureDisplayInfoLink?: string
```

### GetMountUsabilityByID

```lua
C_MountJournal.GetMountUsabilityByID(mountID: number, checkIndoors: bool) -> isUsable: bool, useError?: cstring
```

### GetNumDisplayedMounts

```lua
C_MountJournal.GetNumDisplayedMounts() -> numMounts: number
```

### GetNumMounts

```lua
C_MountJournal.GetNumMounts() -> numMounts: number
```

### GetNumMountsNeedingFanfare

```lua
C_MountJournal.GetNumMountsNeedingFanfare() -> numMountsNeedingFanfare: number
```

### HasDisplayableMount

```lua
C_MountJournal.HasDisplayableMount() -> hasMount: bool
```

### IsDragonridingUnlocked

```lua
C_MountJournal.IsDragonridingUnlocked() -> isUnlocked: bool
```

### IsItemMountEquipment

```lua
C_MountJournal.IsItemMountEquipment(itemLocation: ItemLocation) -> isMountEquipment: bool
```

### IsMountEquipmentApplied

```lua
C_MountJournal.IsMountEquipmentApplied() -> isApplied: bool
```

### IsSourceChecked

```lua
C_MountJournal.IsSourceChecked(filterIndex: luaIndex) -> isChecked: bool
```

### IsTypeChecked

```lua
C_MountJournal.IsTypeChecked(filterIndex: luaIndex) -> isChecked: bool
```

### IsUsingDefaultFilters

```lua
C_MountJournal.IsUsingDefaultFilters() -> isUsingDefaultFilters: bool
```

### IsValidSourceFilter

```lua
C_MountJournal.IsValidSourceFilter(filterIndex: luaIndex) -> isValid: bool
```

### IsValidTypeFilter

```lua
C_MountJournal.IsValidTypeFilter(filterIndex: luaIndex) -> isValid: bool
```

### MountEquipmentAvailable

```lua
C_MountJournal.MountEquipmentAvailable() -> isMountEquipmentAvailable: bool
```

### NeedsFanfare

```lua
C_MountJournal.NeedsFanfare(mountID: number) -> needsFanfare: bool
```

### Pickup

```lua
C_MountJournal.Pickup(displayIndex: luaIndex)
```

### PickupDynamicFlightMode

```lua
C_MountJournal.PickupDynamicFlightMode()
```

### SetAllSourceFilters

```lua
C_MountJournal.SetAllSourceFilters(isChecked: bool)
```

### SetAllTypeFilters

```lua
C_MountJournal.SetAllTypeFilters(isChecked: bool)
```

### SetCollectedFilterSetting

```lua
C_MountJournal.SetCollectedFilterSetting(filterIndex: luaIndex, isChecked: bool)
```

### SetDefaultFilters

```lua
C_MountJournal.SetDefaultFilters()
```

### SetIsFavorite

```lua
C_MountJournal.SetIsFavorite(mountIndex: luaIndex, isFavorite: bool)
```

### SetSearch

```lua
C_MountJournal.SetSearch(searchValue: cstring)
```

### SetSourceFilter

```lua
C_MountJournal.SetSourceFilter(filterIndex: luaIndex, isChecked: bool)
```

### SetTypeFilter

```lua
C_MountJournal.SetTypeFilter(filterIndex: luaIndex, isChecked: bool)
```

### SummonByID

```lua
C_MountJournal.SummonByID(mountID: number)
```

### SwapDynamicFlightMode

```lua
C_MountJournal.SwapDynamicFlightMode()
```

## Events

### MountEquipmentApplyResult

Fires as `MOUNT_EQUIPMENT_APPLY_RESULT`.

```lua
payload: success: bool
```

### MountJournalSearchUpdated

Fires as `MOUNT_JOURNAL_SEARCH_UPDATED`.

No payload.

### MountJournalUsabilityChanged

Fires as `MOUNT_JOURNAL_USABILITY_CHANGED`.

No payload.

### NewMountAdded

Fires as `NEW_MOUNT_ADDED`.

```lua
payload: mountID: number
```
