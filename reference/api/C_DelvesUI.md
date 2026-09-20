# C_DelvesUI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`40` functions - `6` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetActiveDelveTier

```lua
C_DelvesUI.GetActiveDelveTier() -> tierInfo: TieredEntranceTierInfo
```

### GetCompanionInfoForActivePlayer

```lua
C_DelvesUI.GetCompanionInfoForActivePlayer() -> playerCompanionInfoID: number
```

### GetCreatureDisplayInfoForCompanion

```lua
C_DelvesUI.GetCreatureDisplayInfoForCompanion(companionID?: number) -> creatureDisplayInfoID: number
```

### GetCurioLink

```lua
C_DelvesUI.GetCurioLink(spellID: SpellIdentifier, rarity: CurioRarity) -> curioLink: cstring
```

### GetCurioNodeForCompanion

```lua
C_DelvesUI.GetCurioNodeForCompanion(curioType: CurioType, companionID?: number) -> nodeID: number
```

### GetCurioRarityByTraitCondAccountElementID

```lua
C_DelvesUI.GetCurioRarityByTraitCondAccountElementID(traitCondAccountElementID: number) -> rarity: CurioRarity
```

### GetCurrentDelvesSeasonNumber

```lua
C_DelvesUI.GetCurrentDelvesSeasonNumber() -> seasonNumber: number
```

### GetDelveEntranceBackgroundWidgetSetID

```lua
C_DelvesUI.GetDelveEntranceBackgroundWidgetSetID() -> backgroundWidgetSetID: number
```

### GetDelveEntranceDescriptionString

```lua
C_DelvesUI.GetDelveEntranceDescriptionString() -> description?: string
```

### GetDelveEntranceHeaderString

```lua
C_DelvesUI.GetDelveEntranceHeaderString() -> header?: string
```

### GetDelveEntranceMapID

```lua
C_DelvesUI.GetDelveEntranceMapID() -> mapID: number
```

### GetDelveEntranceTiers

```lua
C_DelvesUI.GetDelveEntranceTiers() -> levelInfo: table
```

### GetDelveEntranceTitleString

```lua
C_DelvesUI.GetDelveEntranceTitleString() -> title?: cstring
```

### GetDelvesAffixSpellsForSeason

```lua
C_DelvesUI.GetDelvesAffixSpellsForSeason() -> affixSpellIDs: table
```

### GetDelvesFactionForSeason

```lua
C_DelvesUI.GetDelvesFactionForSeason() -> factionID: number
```

### GetDelvesMinRequiredLevel

```lua
C_DelvesUI.GetDelvesMinRequiredLevel() -> minRequiredLevel?: number
```

### GetFactionForCompanion

```lua
C_DelvesUI.GetFactionForCompanion(companionID?: number) -> factionID: number
```

### GetFlavorNodeForCompanion

```lua
C_DelvesUI.GetFlavorNodeForCompanion(companionID?: number) -> nodeID: number
```

### GetFlavorNodeNameForCompanion

```lua
C_DelvesUI.GetFlavorNodeNameForCompanion(companionID?: number) -> name: cstring
```

### GetLockedTextForCompanion

```lua
C_DelvesUI.GetLockedTextForCompanion(companionID?: number) -> text: cstring
```

### GetModelSceneForCompanion

```lua
C_DelvesUI.GetModelSceneForCompanion(companionID?: number) -> modelSceneID: number
```

### GetPlayerCompanionPDEID

```lua
C_DelvesUI.GetPlayerCompanionPDEID(companionID?: number) -> pdeID: number
```

### GetRoleNodeForCompanion

```lua
C_DelvesUI.GetRoleNodeForCompanion(companionID?: number) -> nodeID: number
```

### GetRoleSubtreeForCompanion

```lua
C_DelvesUI.GetRoleSubtreeForCompanion(roleType: CompanionRoleType, companionID?: number) -> subTreeID: number
```

### GetTieredEntranceOptionalAffixTraitTreeID

```lua
C_DelvesUI.GetTieredEntranceOptionalAffixTraitTreeID() -> treeID?: number
```

### GetTieredEntrancePDEID

```lua
C_DelvesUI.GetTieredEntrancePDEID() -> pdeID: number
```

### GetTieredEntranceType

```lua
C_DelvesUI.GetTieredEntranceType() -> entranceType: TieredEntranceType
```

### GetTraitTreeForCompanion

```lua
C_DelvesUI.GetTraitTreeForCompanion(companionID?: number) -> treeID: number
```

### GetUnseenCuriosBySlotType

```lua
C_DelvesUI.GetUnseenCuriosBySlotType(slotType: CompanionConfigSlotTypes, ownedCurioNodeIDs: table) -> unseenCurioNodeIDs: table
```

### GetWorldTierDifficultyForActivePlayer

```lua
C_DelvesUI.GetWorldTierDifficultyForActivePlayer() -> difficulty: WorldTierDifficulty
```

### HasActiveDelve

```lua
C_DelvesUI.HasActiveDelve() -> result: bool
```

### HasActiveLair

```lua
C_DelvesUI.HasActiveLair() -> result: bool
```

### HasActiveLFGLair

```lua
C_DelvesUI.HasActiveLFGLair() -> result: bool
```

### IsDelveEntranceTierEnabled

```lua
C_DelvesUI.IsDelveEntranceTierEnabled(tier: number) -> isEnabled: bool, failureReason?: string
```

### IsEligibleForActiveDelveRewards

```lua
C_DelvesUI.IsEligibleForActiveDelveRewards(unit: UnitToken) -> result: bool
```

### IsInLair

```lua
C_DelvesUI.IsInLair() -> result: bool
```

### IsTraitTreeForCompanion

```lua
C_DelvesUI.IsTraitTreeForCompanion(traitTreeID: number) -> isForCompanion: bool
```

### RequestPartyEligibilityForDelveTiers

```lua
C_DelvesUI.RequestPartyEligibilityForDelveTiers(mapID: number)
```

### SaveSeenCuriosBySlotType

```lua
C_DelvesUI.SaveSeenCuriosBySlotType(slotType: CompanionConfigSlotTypes, ownedCurioNodeIDs: table)
```

### SelectDelveEntranceTier

```lua
C_DelvesUI.SelectDelveEntranceTier(tier: number)
```

## Events

### ActiveDelveDataUpdate

Fires as `ACTIVE_DELVE_DATA_UPDATE`.

No payload.

### DelveAssistAction

Fires as `DELVE_ASSIST_ACTION`.

```lua
payload: data: DelveAssistActionData
```

### DelvesAccountDataElementChanged

Fires as `DELVES_ACCOUNT_DATA_ELEMENT_CHANGED`.

No payload.

### PartyEligibilityForDelveTiersChanged

Fires as `PARTY_ELIGIBILITY_FOR_DELVE_TIERS_CHANGED`.

```lua
payload: playerName: string, maxEligibleLevel: number
```

### ShowDelvesCompanionConfigurationUI

Fires as `SHOW_DELVES_COMPANION_CONFIGURATION_UI`.

No payload.

### WalkInDataUpdate

Fires as `WALK_IN_DATA_UPDATE`.

No payload.
