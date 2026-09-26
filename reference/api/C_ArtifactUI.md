# C_ArtifactUI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`62` functions - `10` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddPower

```lua
C_ArtifactUI.AddPower(powerID: number) -> success: bool
```

### ApplyCursorRelicToSlot

```lua
C_ArtifactUI.ApplyCursorRelicToSlot(relicSlotIndex: luaIndex)
```

### CanApplyArtifactRelic

```lua
C_ArtifactUI.CanApplyArtifactRelic(relicItemID: number, onlyUnlocked: bool) -> canApply: bool
```

### CanApplyCursorRelicToSlot

```lua
C_ArtifactUI.CanApplyCursorRelicToSlot(relicSlotIndex: luaIndex) -> canApply: bool
```

### CanApplyRelicItemIDToEquippedArtifactSlot

```lua
C_ArtifactUI.CanApplyRelicItemIDToEquippedArtifactSlot(relicItemID: number, relicSlotIndex: luaIndex) -> canApply: bool
```

### CanApplyRelicItemIDToSlot

```lua
C_ArtifactUI.CanApplyRelicItemIDToSlot(relicItemID: number, relicSlotIndex: luaIndex) -> canApply: bool
```

### CheckRespecNPC

```lua
C_ArtifactUI.CheckRespecNPC() -> canRespec: bool
```

### Clear

```lua
C_ArtifactUI.Clear()
```

### ClearForgeCamera

```lua
C_ArtifactUI.ClearForgeCamera()
```

### ConfirmRespec

```lua
C_ArtifactUI.ConfirmRespec()
```

### DoesEquippedArtifactHaveAnyRelicsSlotted

```lua
C_ArtifactUI.DoesEquippedArtifactHaveAnyRelicsSlotted() -> hasAnyRelicsSlotted: bool
```

### GetAppearanceInfo

```lua
C_ArtifactUI.GetAppearanceInfo(appearanceSetIndex: number, appearanceIndex: number) -> artifactAppearanceID: number, appearanceName: string, displayIndex: number, unlocked: bool, failureDescription?: string, uiCameraID: number, altHandCameraID?: number, swatchColorR: number, swatchColorG: number, swatchColorB: number, modelOpacity: number, modelSaturation: number, obtainable: bool
```

### GetAppearanceInfoByID

```lua
C_ArtifactUI.GetAppearanceInfoByID(artifactAppearanceID: number) -> artifactAppearanceSetID: number, artifactAppearanceID: number, appearanceName: string, displayIndex: number, unlocked: bool, failureDescription?: string, uiCameraID: number, altHandCameraID?: number, swatchColorR: number, swatchColorG: number, swatchColorB: number, modelOpacity: number, modelSaturation: number, obtainable: bool
```

### GetAppearanceSetInfo

```lua
C_ArtifactUI.GetAppearanceSetInfo(appearanceSetIndex: number) -> artifactAppearanceSetID: number, appearanceSetName: string, appearanceSetDescription: string, numAppearances: number
```

### GetArtifactArtInfo

```lua
C_ArtifactUI.GetArtifactArtInfo() -> artifactArtInfo: ArtifactArtInfo
```

### GetArtifactInfo

```lua
C_ArtifactUI.GetArtifactInfo() -> itemID: number, altItemID?: number, name: string, icon: fileID, xp: number, pointsSpent: number, quality: number, artifactAppearanceID: number, appearanceModID: number, itemAppearanceID?: number, altItemAppearanceID?: number, altOnTop: bool, tier: ArtifactTiers
```

### GetArtifactItemID

```lua
C_ArtifactUI.GetArtifactItemID() -> itemID: number
```

### GetArtifactTier

```lua
C_ArtifactUI.GetArtifactTier() -> tier?: ArtifactTiers
```

### GetArtifactXPRewardTargetInfo

```lua
C_ArtifactUI.GetArtifactXPRewardTargetInfo(artifactCategoryID: number) -> name: string, icon: fileID
```

### GetCostForPointAtRank

```lua
C_ArtifactUI.GetCostForPointAtRank(rank: number, tier: ArtifactTiers) -> cost: number
```

### GetEquippedArtifactArtInfo

```lua
C_ArtifactUI.GetEquippedArtifactArtInfo() -> artifactArtInfo: ArtifactArtInfo
```

### GetEquippedArtifactInfo

```lua
C_ArtifactUI.GetEquippedArtifactInfo() -> itemID: number, altItemID?: number, name: string, icon: fileID, xp: number, pointsSpent: number, quality: number, artifactAppearanceID: number, appearanceModID: number, itemAppearanceID?: number, altItemAppearanceID?: number, altOnTop: bool, tier: ArtifactTiers
```

### GetEquippedArtifactItemID

```lua
C_ArtifactUI.GetEquippedArtifactItemID() -> itemID: number
```

### GetEquippedArtifactNumRelicSlots

```lua
C_ArtifactUI.GetEquippedArtifactNumRelicSlots(onlyUnlocked: bool) -> numRelicSlots: number
```

### GetEquippedArtifactRelicInfo

```lua
C_ArtifactUI.GetEquippedArtifactRelicInfo(relicSlotIndex: luaIndex) -> name: string, icon: fileID, slotTypeName: cstring, link: string
```

### GetEquippedRelicLockedReason

```lua
C_ArtifactUI.GetEquippedRelicLockedReason(relicSlotIndex: luaIndex) -> lockedReason?: string
```

### GetForgeRotation

```lua
C_ArtifactUI.GetForgeRotation() -> forgeRotationX: number, forgeRotationY: number, forgeRotationZ: number
```

### GetItemLevelIncreaseProvidedByRelic

```lua
C_ArtifactUI.GetItemLevelIncreaseProvidedByRelic(itemLinkOrID: ItemInfo) -> itemIevelIncrease: number
```

### GetMetaPowerInfo

```lua
C_ArtifactUI.GetMetaPowerInfo() -> spellID: number, powerCost: number, currentRank: number
```

### GetNumAppearanceSets

```lua
C_ArtifactUI.GetNumAppearanceSets() -> numAppearanceSets: number
```

### GetNumObtainedArtifacts

```lua
C_ArtifactUI.GetNumObtainedArtifacts() -> numObtainedArtifacts: number
```

### GetNumRelicSlots

```lua
C_ArtifactUI.GetNumRelicSlots(onlyUnlocked: bool) -> numRelicSlots: number
```

### GetPointsRemaining

```lua
C_ArtifactUI.GetPointsRemaining() -> pointsRemaining: number
```

### GetPowerHyperlink

```lua
C_ArtifactUI.GetPowerHyperlink(powerID: number) -> link: cstring
```

### GetPowerInfo

```lua
C_ArtifactUI.GetPowerInfo(powerID: number) -> powerInfo: ArtifactPowerInfo
```

### GetPowerLinks

```lua
C_ArtifactUI.GetPowerLinks(powerID: number) -> linkingPowerID: table
```

### GetPowers

```lua
C_ArtifactUI.GetPowers() -> powerID: table
```

### GetPowersAffectedByRelic

```lua
C_ArtifactUI.GetPowersAffectedByRelic(relicSlotIndex: luaIndex) -> powerIDs: number
```

### GetPowersAffectedByRelicItemLink

```lua
C_ArtifactUI.GetPowersAffectedByRelicItemLink(relicItemInfo: ItemInfo) -> powerIDs: number
```

### GetPreviewAppearance

```lua
C_ArtifactUI.GetPreviewAppearance() -> artifactAppearanceID?: number
```

### GetRelicInfo

```lua
C_ArtifactUI.GetRelicInfo(relicSlotIndex: luaIndex) -> name: string, icon: fileID, slotTypeName: cstring, link: string
```

### GetRelicInfoByItemID

```lua
C_ArtifactUI.GetRelicInfoByItemID(itemID: number) -> name: string, icon: fileID, slotTypeName: cstring, link: string
```

### GetRelicLockedReason

```lua
C_ArtifactUI.GetRelicLockedReason(relicSlotIndex: luaIndex) -> lockedReason?: string
```

### GetRelicSlotType

```lua
C_ArtifactUI.GetRelicSlotType(relicSlotIndex: luaIndex) -> slotTypeName: cstring
```

### GetRespecArtifactArtInfo

```lua
C_ArtifactUI.GetRespecArtifactArtInfo() -> artifactArtInfo: ArtifactArtInfo
```

### GetRespecArtifactInfo

```lua
C_ArtifactUI.GetRespecArtifactInfo() -> itemID: number, altItemID?: number, name: string, icon: fileID, xp: number, pointsSpent: number, quality: number, artifactAppearanceID: number, appearanceModID: number, itemAppearanceID?: number, altItemAppearanceID?: number, altOnTop: bool, tier: ArtifactTiers
```

### GetRespecCost

```lua
C_ArtifactUI.GetRespecCost() -> cost: number
```

### GetTotalPowerCost

```lua
C_ArtifactUI.GetTotalPowerCost(startingTrait: luaIndex, numTraits: number, artifactTier: ArtifactTiers) -> totalArtifactPowerCost: number
```

### GetTotalPurchasedRanks

```lua
C_ArtifactUI.GetTotalPurchasedRanks() -> totalPurchasedRanks: number
```

### IsArtifactDisabled

```lua
C_ArtifactUI.IsArtifactDisabled() -> artifactDisabled: bool
```

### IsArtifactItem

```lua
C_ArtifactUI.IsArtifactItem(itemLocation: ItemLocation) -> isArtifact: bool
```

### IsAtForge

```lua
C_ArtifactUI.IsAtForge() -> isAtForge: bool
```

### IsEquippedArtifactDisabled

```lua
C_ArtifactUI.IsEquippedArtifactDisabled() -> artifactDisabled: bool
```

### IsEquippedArtifactMaxed

```lua
C_ArtifactUI.IsEquippedArtifactMaxed() -> artifactMaxed: bool
```

### IsMaxedByRulesOrEffect

```lua
C_ArtifactUI.IsMaxedByRulesOrEffect() -> isEffectivelyMaxed: bool
```

### IsPowerKnown

```lua
C_ArtifactUI.IsPowerKnown(powerID: number) -> known: bool
```

### IsViewedArtifactEquipped

```lua
C_ArtifactUI.IsViewedArtifactEquipped() -> isViewedArtifactEquipped: bool
```

### SetAppearance

```lua
C_ArtifactUI.SetAppearance(artifactAppearanceID: number)
```

### SetForgeCamera

```lua
C_ArtifactUI.SetForgeCamera()
```

### SetForgeRotation

```lua
C_ArtifactUI.SetForgeRotation(forgeRotationX: number, forgeRotationY: number, forgeRotationZ: number)
```

### SetPreviewAppearance

```lua
C_ArtifactUI.SetPreviewAppearance(artifactAppearanceID: number)
```

### ShouldSuppressForgeRotation

```lua
C_ArtifactUI.ShouldSuppressForgeRotation() -> shouldSuppressForgeRotation: bool
```

## Events

### ArtifactClose

Fires as `ARTIFACT_CLOSE`.

No payload.

### ArtifactEndgameRefund

Fires as `ARTIFACT_ENDGAME_REFUND`.

```lua
payload: numRefundedPowers: number, refundedTier: ArtifactTiers, bagOrSlotIndex: luaIndex, slotIndex?: luaIndex
```

### ArtifactRelicForgeClose

Fires as `ARTIFACT_RELIC_FORGE_CLOSE`.

No payload.

### ArtifactRelicForgePreviewRelicChanged

Fires as `ARTIFACT_RELIC_FORGE_PREVIEW_RELIC_CHANGED`.

No payload.

### ArtifactRelicForgeUpdate

Fires as `ARTIFACT_RELIC_FORGE_UPDATE`.

No payload.

### ArtifactRelicInfoReceived

Fires as `ARTIFACT_RELIC_INFO_RECEIVED`.

No payload.

### ArtifactRespecPrompt

Fires as `ARTIFACT_RESPEC_PROMPT`.

No payload.

### ArtifactTierChanged

Fires as `ARTIFACT_TIER_CHANGED`.

```lua
payload: newTier: luaIndex, bagOrSlotIndex: luaIndex, slotIndex?: luaIndex
```

### ArtifactUpdate

Fires as `ARTIFACT_UPDATE`.

```lua
payload: newItem: bool
```

### ArtifactXpUpdate

Fires as `ARTIFACT_XP_UPDATE`.

No payload.
