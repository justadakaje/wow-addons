# C_ClassTalents

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`31` functions - `8` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanChangeTalents

```lua
C_ClassTalents.CanChangeTalents() -> canChange: bool, canAdd: bool, changeError?: string
```

### CanCreateNewConfig

```lua
C_ClassTalents.CanCreateNewConfig() -> canCreate: bool
```

### CanEditTalents

```lua
C_ClassTalents.CanEditTalents() -> canEdit: bool, changeError: cstring
```

### CommitConfig

```lua
C_ClassTalents.CommitConfig(savedConfigID?: number) -> success: bool
```

### DeleteConfig

```lua
C_ClassTalents.DeleteConfig(configID: number) -> success: bool
```

### GetActiveConfigID

```lua
C_ClassTalents.GetActiveConfigID() -> activeConfigID?: number
```

### GetActiveHeroTalentSpec

```lua
C_ClassTalents.GetActiveHeroTalentSpec() -> heroSpecID?: number
```

### GetConfigIDsBySpecID

```lua
C_ClassTalents.GetConfigIDsBySpecID(specID?: number) -> configIDs: table
```

### GetHasStarterBuild

```lua
C_ClassTalents.GetHasStarterBuild() -> hasStarterBuild: bool
```

### GetHeroTalentSpecsForClassSpec

```lua
C_ClassTalents.GetHeroTalentSpecsForClassSpec(configID?: number, classSpecID?: number) -> subTreeIDs?: table, requiredPlayerLevel?: number
```

### GetLastSelectedSavedConfigID

```lua
C_ClassTalents.GetLastSelectedSavedConfigID(specID: number) -> configID?: number
```

### GetNextStarterBuildPurchase

```lua
C_ClassTalents.GetNextStarterBuildPurchase() -> nodeID?: number, entryID?: number
```

### GetStarterBuildActive

```lua
C_ClassTalents.GetStarterBuildActive() -> isActive: bool
```

### GetTraitTreeForSpec

```lua
C_ClassTalents.GetTraitTreeForSpec(specID: number) -> treeID?: number
```

### HasUnspentHeroTalentPoints

```lua
C_ClassTalents.HasUnspentHeroTalentPoints() -> hasUnspentPoints: bool, numHeroPoints: number
```

### HasUnspentTalentPoints

```lua
C_ClassTalents.HasUnspentTalentPoints() -> hasUnspentPoints: bool, numClassPoints: number, numSpecPoints: number
```

### ImportLoadout

```lua
C_ClassTalents.ImportLoadout(configID: number, entries: table, name: string, importString?: string) -> success: bool, importError: cstring
```

### InitializeViewLoadout

```lua
C_ClassTalents.InitializeViewLoadout(specID: number, level: number)
```

### IsConfigPopulated

```lua
C_ClassTalents.IsConfigPopulated(configID: number) -> isPopulated: bool
```

### LoadConfig

```lua
C_ClassTalents.LoadConfig(configID: number, autoApply: bool) -> result: LoadConfigResult, changeError?: string, newLearnedNodeIDs: table
```

### RenameConfig

```lua
C_ClassTalents.RenameConfig(configID: number, name: string) -> success: bool
```

### RequestNewConfig

```lua
C_ClassTalents.RequestNewConfig(name: string) -> success: bool
```

### SaveConfig

```lua
C_ClassTalents.SaveConfig(configID: number) -> success: bool
```

### SetStarterBuildActive

```lua
C_ClassTalents.SetStarterBuildActive(active: bool) -> result: LoadConfigResult
```

### SetUsesSharedActionBars

```lua
C_ClassTalents.SetUsesSharedActionBars(configID: number, usesShared: bool)
```

### SwitchToLoadoutByIndex

```lua
C_ClassTalents.SwitchToLoadoutByIndex(loadoutIndex: number)
```

### SwitchToLoadoutByName

```lua
C_ClassTalents.SwitchToLoadoutByName(loadoutName: cstring)
```

### SwitchToSpecializationByIndex

```lua
C_ClassTalents.SwitchToSpecializationByIndex(specIndex: number)
```

### SwitchToSpecializationByName

```lua
C_ClassTalents.SwitchToSpecializationByName(specName: cstring)
```

### UpdateLastSelectedSavedConfigID

```lua
C_ClassTalents.UpdateLastSelectedSavedConfigID(specID: number, configID?: number)
```

### ViewLoadout

```lua
C_ClassTalents.ViewLoadout(entries: table, importString?: string) -> success: bool
```

## Events

### ActiveCombatConfigChanged

Fires as `ACTIVE_COMBAT_CONFIG_CHANGED`.

```lua
payload: configID: number
```

### ClassTalentsSwitchToLoadoutByIndex

Fires as `CLASS_TALENTS_SWITCH_TO_LOADOUT_BY_INDEX`.

```lua
payload: loadoutIndex: number
```

### ClassTalentsSwitchToLoadoutByName

Fires as `CLASS_TALENTS_SWITCH_TO_LOADOUT_BY_NAME`.

```lua
payload: loadoutName: cstring
```

### ClassTalentsSwitchToSpecializationByIndex

Fires as `CLASS_TALENTS_SWITCH_TO_SPECIALIZATION_BY_INDEX`.

```lua
payload: specIndex: number
```

### ClassTalentsSwitchToSpecializationByName

Fires as `CLASS_TALENTS_SWITCH_TO_SPECIALIZATION_BY_NAME`.

```lua
payload: specName: cstring
```

### SelectedLoadoutChanged

Fires as `SELECTED_LOADOUT_CHANGED`.

No payload.

### SpecializationChangeCastFailed

Fires as `SPECIALIZATION_CHANGE_CAST_FAILED`.

No payload.

### StarterBuildActivationFailed

Fires as `STARTER_BUILD_ACTIVATION_FAILED`.

No payload.
