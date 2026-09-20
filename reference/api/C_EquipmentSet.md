# C_EquipmentSet

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`23` functions - `4` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AssignSpecToEquipmentSet

```lua
C_EquipmentSet.AssignSpecToEquipmentSet(equipmentSetID: number, specIndex: luaIndex)
```

### CanUseEquipmentSets

```lua
C_EquipmentSet.CanUseEquipmentSets() -> canUseEquipmentSets: bool
```

### ClearIgnoredSlotsForSave

```lua
C_EquipmentSet.ClearIgnoredSlotsForSave()
```

### CreateEquipmentSet

```lua
C_EquipmentSet.CreateEquipmentSet(equipmentSetName: cstring, icon?: cstring)
```

### DeleteEquipmentSet

```lua
C_EquipmentSet.DeleteEquipmentSet(equipmentSetID: number)
```

### EquipmentSetContainsLockedItems

```lua
C_EquipmentSet.EquipmentSetContainsLockedItems(equipmentSetID: number) -> hasLockedItems: bool
```

### GetEquipmentSetAssignedSpec

```lua
C_EquipmentSet.GetEquipmentSetAssignedSpec(equipmentSetID: number) -> specIndex: luaIndex
```

### GetEquipmentSetForSpec

```lua
C_EquipmentSet.GetEquipmentSetForSpec(specIndex: luaIndex) -> equipmentSetID: number
```

### GetEquipmentSetID

```lua
C_EquipmentSet.GetEquipmentSetID(equipmentSetName: cstring) -> equipmentSetID: number
```

### GetEquipmentSetIDs

```lua
C_EquipmentSet.GetEquipmentSetIDs() -> equipmentSetIDs: table
```

### GetEquipmentSetInfo

```lua
C_EquipmentSet.GetEquipmentSetInfo(equipmentSetID: number) -> name: string, iconFileID: number, setID: number, isEquipped: bool, numItems: number, numEquipped: number, numInInventory: number, numLost: number, numIgnored: number
```

### GetIgnoredSlots

```lua
C_EquipmentSet.GetIgnoredSlots(equipmentSetID: number) -> slotIgnored: table
```

### GetItemIDs

```lua
C_EquipmentSet.GetItemIDs(equipmentSetID: number) -> itemIDs: table
```

### GetItemLocations

```lua
C_EquipmentSet.GetItemLocations(equipmentSetID: number) -> locations: table
```

### GetNumEquipmentSets

```lua
C_EquipmentSet.GetNumEquipmentSets() -> numEquipmentSets: number
```

### IgnoreSlotForSave

```lua
C_EquipmentSet.IgnoreSlotForSave(slot: luaIndex)
```

### IsSlotIgnoredForSave

```lua
C_EquipmentSet.IsSlotIgnoredForSave(slot: luaIndex) -> isSlotIgnored: bool
```

### ModifyEquipmentSet

```lua
C_EquipmentSet.ModifyEquipmentSet(equipmentSetID: number, newName: cstring, newIcon?: cstring)
```

### PickupEquipmentSet

```lua
C_EquipmentSet.PickupEquipmentSet(equipmentSetID: number)
```

### SaveEquipmentSet

```lua
C_EquipmentSet.SaveEquipmentSet(equipmentSetID: number, icon?: cstring)
```

### UnassignEquipmentSetSpec

```lua
C_EquipmentSet.UnassignEquipmentSetSpec(equipmentSetID: number)
```

### UnignoreSlotForSave

```lua
C_EquipmentSet.UnignoreSlotForSave(slot: luaIndex)
```

### UseEquipmentSet

```lua
C_EquipmentSet.UseEquipmentSet(equipmentSetID: number) -> setWasEquipped: bool
```

## Events

### EquipmentSetsChanged

Fires as `EQUIPMENT_SETS_CHANGED`.

No payload.

### EquipmentSwapFinished

Fires as `EQUIPMENT_SWAP_FINISHED`.

```lua
payload: result: bool, setID?: number
```

### EquipmentSwapPending

Fires as `EQUIPMENT_SWAP_PENDING`.

No payload.

### TransmogCustomSetsChanged

Fires as `TRANSMOG_CUSTOM_SETS_CHANGED`.

No payload.
