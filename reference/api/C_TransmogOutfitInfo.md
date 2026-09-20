# C_TransmogOutfitInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`67` functions - `8` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddNewOutfit

```lua
C_TransmogOutfitInfo.AddNewOutfit(name: cstring, icon: fileID)
```

### CanPlayerTransmogSlot

```lua
C_TransmogOutfitInfo.CanPlayerTransmogSlot(slot: TransmogOutfitSlot) -> valid: bool
```

### ChangeDisplayedOutfit

```lua
C_TransmogOutfitInfo.ChangeDisplayedOutfit(outfitID: number, trigger: TransmogSituationTrigger, toggleLock: bool, allowRemoveOutfit: bool)
```

### ChangeToOutfit

```lua
C_TransmogOutfitInfo.ChangeToOutfit(playerFacingOutfitIndex: number, allowRemoveOutfit: bool)
```

### ChangeViewedOutfit

```lua
C_TransmogOutfitInfo.ChangeViewedOutfit(outfitID: number)
```

### ClearAllPendingSituations

```lua
C_TransmogOutfitInfo.ClearAllPendingSituations()
```

### ClearAllPendingTransmogs

```lua
C_TransmogOutfitInfo.ClearAllPendingTransmogs()
```

### ClearDisplayedOutfit

```lua
C_TransmogOutfitInfo.ClearDisplayedOutfit(trigger: TransmogSituationTrigger, toggleLock: bool)
```

### ClearOutfit

```lua
C_TransmogOutfitInfo.ClearOutfit()
```

### CommitAndApplyAllPending

```lua
C_TransmogOutfitInfo.CommitAndApplyAllPending(useAvailableDiscount: bool)
```

### CommitOutfitInfo

```lua
C_TransmogOutfitInfo.CommitOutfitInfo(outfitID: number, name: cstring, icon: fileID)
```

### CommitPendingSituations

```lua
C_TransmogOutfitInfo.CommitPendingSituations()
```

### GetActiveOutfitID

```lua
C_TransmogOutfitInfo.GetActiveOutfitID() -> outfitID: number
```

### GetAllSlotLocationInfo

```lua
C_TransmogOutfitInfo.GetAllSlotLocationInfo() -> appearanceSlotInfo: table, illusionSlotInfo: table
```

### GetAllTransmogOutfitOptionSheatheCategoryInfo

```lua
C_TransmogOutfitInfo.GetAllTransmogOutfitOptionSheatheCategoryInfo(imaID: number) -> categoryInfo: table
```

### GetCollectionInfoForSlotAndOption

```lua
C_TransmogOutfitInfo.GetCollectionInfoForSlotAndOption(slot: TransmogOutfitSlot, option: TransmogOutfitSlotOption, collectionType: TransmogCollectionType) -> collectionInfo: TransmogOutfitCollectionInfo
```

### GetCurrentlyViewedOutfitID

```lua
C_TransmogOutfitInfo.GetCurrentlyViewedOutfitID() -> outfitID: number
```

### GetEquippedSlotOptionFromTransmogSlot

```lua
C_TransmogOutfitInfo.GetEquippedSlotOptionFromTransmogSlot(slot: TransmogOutfitSlot) -> option: TransmogOutfitSlotOption
```

### GetIllusionDefaultIMAIDForCollectionType

```lua
C_TransmogOutfitInfo.GetIllusionDefaultIMAIDForCollectionType(collectionType: TransmogCollectionType) -> imaID: number
```

### GetItemModifiedAppearanceEffectiveCategory

```lua
C_TransmogOutfitInfo.GetItemModifiedAppearanceEffectiveCategory(imaID: number) -> categoryID: TransmogCollectionType
```

### GetLinkedSlotInfo

```lua
C_TransmogOutfitInfo.GetLinkedSlotInfo(slot: TransmogOutfitSlot) -> linkedSlotInfo: TransmogOutfitLinkedSlotInfo
```

### GetMaxNumberOfTotalOutfitsForSource

```lua
C_TransmogOutfitInfo.GetMaxNumberOfTotalOutfitsForSource(source: TransmogOutfitEntrySource) -> maxOutfitCount: number
```

### GetMaxNumberOfUsableOutfits

```lua
C_TransmogOutfitInfo.GetMaxNumberOfUsableOutfits() -> maxOutfitCount: number
```

### GetNextOutfitCost

```lua
C_TransmogOutfitInfo.GetNextOutfitCost() -> outfitCost: BigUInteger
```

### GetNumberOfOutfitsUnlockedForSource

```lua
C_TransmogOutfitInfo.GetNumberOfOutfitsUnlockedForSource(source: TransmogOutfitEntrySource) -> unlockedOutfitCount: number
```

### GetOptionsForSlot

```lua
C_TransmogOutfitInfo.GetOptionsForSlot(slot: TransmogOutfitSlot) -> options: table, artifactOptions?: table
```

### GetOutfitInfo

```lua
C_TransmogOutfitInfo.GetOutfitInfo(outfitID: number) -> outfitInfo: TransmogOutfitEntryInfo
```

### GetOutfitInfoByName

```lua
C_TransmogOutfitInfo.GetOutfitInfoByName(name: cstring) -> outfitInfo: TransmogOutfitEntryInfo
```

### GetOutfitInfoByPlayerFacingIndex

```lua
C_TransmogOutfitInfo.GetOutfitInfoByPlayerFacingIndex(playerFacingOutfitIndex: number) -> outfitInfo: TransmogOutfitEntryInfo
```

### GetOutfitsInfo

```lua
C_TransmogOutfitInfo.GetOutfitsInfo() -> outfitsInfo: table
```

### GetOutfitSituation

```lua
C_TransmogOutfitInfo.GetOutfitSituation(option: TransmogSituationOption) -> value: bool
```

### GetOutfitSituationsEnabled

```lua
C_TransmogOutfitInfo.GetOutfitSituationsEnabled() -> enabled: bool
```

### GetPendingTransmogCost

```lua
C_TransmogOutfitInfo.GetPendingTransmogCost() -> cost: BigUInteger, modifierFlags: number
```

### GetSecondarySlotState

```lua
C_TransmogOutfitInfo.GetSecondarySlotState(slot: TransmogOutfitSlot) -> state: bool
```

### GetSetSourcesForSlot

```lua
C_TransmogOutfitInfo.GetSetSourcesForSlot(transmogSetID: number, slot: TransmogOutfitSlot) -> sources: table
```

### GetSlotGroupInfo

```lua
C_TransmogOutfitInfo.GetSlotGroupInfo() -> slotGroups: table
```

### GetSourceIDsForSlot

```lua
C_TransmogOutfitInfo.GetSourceIDsForSlot(transmogSetID: number, slot: TransmogOutfitSlot) -> sources: table
```

### GetTransmogOutfitSlotForInventoryType

```lua
C_TransmogOutfitInfo.GetTransmogOutfitSlotForInventoryType(inventoryType: luaIndex) -> slot: TransmogOutfitSlot
```

### GetTransmogOutfitSlotFromInventorySlot

```lua
C_TransmogOutfitInfo.GetTransmogOutfitSlotFromInventorySlot(inventorySlot: InventorySlots) -> slot: TransmogOutfitSlot
```

### GetUISituationCategoriesAndOptions

```lua
C_TransmogOutfitInfo.GetUISituationCategoriesAndOptions() -> categoryData: table
```

### GetUnassignedAtlasForSlot

```lua
C_TransmogOutfitInfo.GetUnassignedAtlasForSlot(slot: TransmogOutfitSlot) -> atlas: textureAtlas
```

### GetUnassignedDisplayAtlasForSlot

```lua
C_TransmogOutfitInfo.GetUnassignedDisplayAtlasForSlot(slot: TransmogOutfitSlot) -> atlas: textureAtlas
```

### GetViewedOutfitSlotInfo

```lua
C_TransmogOutfitInfo.GetViewedOutfitSlotInfo(slot: TransmogOutfitSlot, type: TransmogType, option: TransmogOutfitSlotOption) -> slotInfo: ViewedTransmogOutfitSlotInfo
```

### HasPendingOutfitSituations

```lua
C_TransmogOutfitInfo.HasPendingOutfitSituations() -> hasPending: bool
```

### HasPendingOutfitTransmogs

```lua
C_TransmogOutfitInfo.HasPendingOutfitTransmogs() -> hasPending: bool
```

### InTransmogEvent

```lua
C_TransmogOutfitInfo.InTransmogEvent() -> inTransmogEvent: bool
```

### IsEquippedGearOutfitDisplayed

```lua
C_TransmogOutfitInfo.IsEquippedGearOutfitDisplayed() -> isDisplayed: bool
```

### IsEquippedGearOutfitLocked

```lua
C_TransmogOutfitInfo.IsEquippedGearOutfitLocked() -> isLocked: bool
```

### IsLockedOutfit

```lua
C_TransmogOutfitInfo.IsLockedOutfit(outfitID: number) -> isLocked: bool
```

### IsSlotWeaponSlot

```lua
C_TransmogOutfitInfo.IsSlotWeaponSlot(slot: TransmogOutfitSlot) -> isWeaponSlot: bool
```

### IsTransmogEnabled

```lua
C_TransmogOutfitInfo.IsTransmogEnabled() -> enabled: bool
```

### IsUsableDiscountAvailable

```lua
C_TransmogOutfitInfo.IsUsableDiscountAvailable() -> isAvailable: bool
```

### IsValidTransmogOutfitName

```lua
C_TransmogOutfitInfo.IsValidTransmogOutfitName(name: cstring) -> isApproved: bool
```

### PickupOutfit

```lua
C_TransmogOutfitInfo.PickupOutfit(outfitID: number)
```

### ResetOutfitSituations

```lua
C_TransmogOutfitInfo.ResetOutfitSituations()
```

### RevertPendingTransmog

```lua
C_TransmogOutfitInfo.RevertPendingTransmog(slot: TransmogOutfitSlot, type: TransmogType, option: TransmogOutfitSlotOption)
```

### SetOutfitSituationsEnabled

```lua
C_TransmogOutfitInfo.SetOutfitSituationsEnabled(enabled: bool)
```

### SetOutfitToCustomSet

```lua
C_TransmogOutfitInfo.SetOutfitToCustomSet(transmogCustomSetID: number)
```

### SetOutfitToOutfit

```lua
C_TransmogOutfitInfo.SetOutfitToOutfit(outfitID: number)
```

### SetOutfitToSet

```lua
C_TransmogOutfitInfo.SetOutfitToSet(transmogSetID: number)
```

### SetPendingTransmog

```lua
C_TransmogOutfitInfo.SetPendingTransmog(slot: TransmogOutfitSlot, type: TransmogType, option: TransmogOutfitSlotOption, transmogID: number, displayType: TransmogOutfitDisplayType)
```

### SetPendingTransmogSheatheCategory

```lua
C_TransmogOutfitInfo.SetPendingTransmogSheatheCategory(slot: TransmogOutfitSlot, option: TransmogOutfitSlotOption, category: TransmogOutfitSlotOptionSheatheCategory)
```

### SetSecondarySlotState

```lua
C_TransmogOutfitInfo.SetSecondarySlotState(slot: TransmogOutfitSlot, state: bool)
```

### SetViewedOptionForSlot

```lua
C_TransmogOutfitInfo.SetViewedOptionForSlot(slot: TransmogOutfitSlot, option: TransmogOutfitSlotOption)
```

### SlotHasSecondary

```lua
C_TransmogOutfitInfo.SlotHasSecondary(slot: TransmogOutfitSlot) -> hasSecondary: bool
```

### TransmogEventActive

```lua
C_TransmogOutfitInfo.TransmogEventActive() -> transmogEventActive: bool
```

### UpdatePendingSituation

```lua
C_TransmogOutfitInfo.UpdatePendingSituation(option: TransmogSituationOption, value: bool)
```

## Events

### TransmogDisplayedOutfitChanged

Fires as `TRANSMOG_DISPLAYED_OUTFIT_CHANGED`.

No payload.

### TransmogOutfitsChanged

Fires as `TRANSMOG_OUTFITS_CHANGED`.

```lua
payload: newOutfitID?: number
```

### ViewedTransmogOutfitChanged

Fires as `VIEWED_TRANSMOG_OUTFIT_CHANGED`.

No payload.

### ViewedTransmogOutfitSecondarySlotsChanged

Fires as `VIEWED_TRANSMOG_OUTFIT_SECONDARY_SLOTS_CHANGED`.

No payload.

### ViewedTransmogOutfitSituationsChanged

Fires as `VIEWED_TRANSMOG_OUTFIT_SITUATIONS_CHANGED`.

No payload.

### ViewedTransmogOutfitSlotOptionChanged

Fires as `VIEWED_TRANSMOG_OUTFIT_SLOT_OPTION_CHANGED`.

```lua
payload: slot: TransmogOutfitSlot, option: TransmogOutfitSlotOption
```

### ViewedTransmogOutfitSlotRefresh

Fires as `VIEWED_TRANSMOG_OUTFIT_SLOT_REFRESH`.

No payload.

### ViewedTransmogOutfitSlotSaveSuccess

Fires as `VIEWED_TRANSMOG_OUTFIT_SLOT_SAVE_SUCCESS`.

```lua
payload: slot: TransmogOutfitSlot, type: TransmogType, option: TransmogOutfitSlotOption
```
