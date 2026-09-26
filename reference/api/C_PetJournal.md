# C_PetJournal

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`25` functions - `15` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearHoveredBattlePet

```lua
C_PetJournal.ClearHoveredBattlePet()
```

### ClearSearchFilter

```lua
C_PetJournal.ClearSearchFilter()
```

### DismissSummonedPet

```lua
C_PetJournal.DismissSummonedPet(petID: WOWGUID)
```

### GetDisplayIDByIndex

```lua
C_PetJournal.GetDisplayIDByIndex(speciesID: number, index: luaIndex) -> displayID?: number
```

### GetDisplayProbabilityByIndex

```lua
C_PetJournal.GetDisplayProbabilityByIndex(speciesID: number, index: luaIndex) -> displayProbability?: number
```

### GetNonBattlePetLinkByIndex

```lua
C_PetJournal.GetNonBattlePetLinkByIndex(index: luaIndex) -> link: cstring
```

### GetNumDisplays

```lua
C_PetJournal.GetNumDisplays(speciesID: number) -> numDisplays?: number
```

### GetNumPetsInJournal

```lua
C_PetJournal.GetNumPetsInJournal(creatureID: number) -> maxAllowed: number, numPets: number
```

### GetOwnedPetIDs

```lua
C_PetJournal.GetOwnedPetIDs() -> ownedPetIDs: table
```

### GetPetAbilityInfo

```lua
C_PetJournal.GetPetAbilityInfo(abilityID: number) -> name: string, icon: fileID, petType: number
```

### GetPetAbilityListTable

```lua
C_PetJournal.GetPetAbilityListTable(speciesID: number) -> info: table
```

### GetPetInfoTableByPetID

```lua
C_PetJournal.GetPetInfoTableByPetID(petID: WOWGUID) -> info: PetJournalPetInfo
```

### GetPetInfoTableBySpeciesID

```lua
C_PetJournal.GetPetInfoTableBySpeciesID(speciesID: number) -> petInfo: PetJournalPetInfo
```

### GetPetLoadOutInfo

```lua
C_PetJournal.GetPetLoadOutInfo(slot: luaIndex) -> petID?: WOWGUID, ability1ID: number, ability2ID: number, ability3ID: number, locked: bool
```

### GetPetSummonInfo

```lua
C_PetJournal.GetPetSummonInfo(battlePetGUID: WOWGUID) -> isSummonable: bool, error: PetJournalError, errorText: cstring
```

### GetSearchFilter

```lua
C_PetJournal.GetSearchFilter() -> filterText: cstring
```

### HasFavoritePets

```lua
C_PetJournal.HasFavoritePets() -> hasFavorites: bool
```

### IsCurrentlySummoned

```lua
C_PetJournal.IsCurrentlySummoned(petID: WOWGUID) -> isSummoned: bool
```

### IsUsingDefaultFilters

```lua
C_PetJournal.IsUsingDefaultFilters() -> isUsingDefaultFilters: bool
```

### PetIsSummonable

```lua
C_PetJournal.PetIsSummonable(battlePetGUID: WOWGUID) -> isSummonable: bool
```

### PetUsesRandomDisplay

```lua
C_PetJournal.PetUsesRandomDisplay(speciesID: number) -> usesRandomDisplay?: bool
```

### SetDefaultFilters

```lua
C_PetJournal.SetDefaultFilters()
```

### SetHoveredBattlePet

```lua
C_PetJournal.SetHoveredBattlePet(battlePetGUID: WOWGUID)
```

### SetSearchFilter

```lua
C_PetJournal.SetSearchFilter(filterText: cstring)
```

### SpellTargetBattlePet

```lua
C_PetJournal.SpellTargetBattlePet(battlePetGUID: WOWGUID)
```

## Events

### BattlepetForceNameDeclension

Fires as `BATTLEPET_FORCE_NAME_DECLENSION`.

```lua
payload: name: cstring, battlePetGUID: WOWGUID
```

### CompanionLearned

Fires as `COMPANION_LEARNED`.

No payload.

### CompanionUnlearned

Fires as `COMPANION_UNLEARNED`.

No payload.

### CompanionUpdate

Fires as `COMPANION_UPDATE`.

```lua
payload: companionType?: cstring
```

### NewPetAdded

Fires as `NEW_PET_ADDED`.

```lua
payload: battlePetGUID: WOWGUID
```

### PetJournalAutoSlottedPet

Fires as `PET_JOURNAL_AUTO_SLOTTED_PET`.

```lua
payload: slotIndex: number, battlePetGUID: WOWGUID
```

### PetJournalCageFailed

Fires as `PET_JOURNAL_CAGE_FAILED`.

No payload.

### PetJournalListUpdate

Fires as `PET_JOURNAL_LIST_UPDATE`.

No payload.

### PetJournalNewBattleSlot

Fires as `PET_JOURNAL_NEW_BATTLE_SLOT`.

No payload.

### PetJournalPetDeleted

Fires as `PET_JOURNAL_PET_DELETED`.

```lua
payload: battlePetGUID: WOWGUID
```

### PetJournalPetRestored

Fires as `PET_JOURNAL_PET_RESTORED`.

```lua
payload: battlePetGUID: WOWGUID
```

### PetJournalPetRevoked

Fires as `PET_JOURNAL_PET_REVOKED`.

```lua
payload: battlePetGUID: WOWGUID
```

### PetJournalPetsHealed

Fires as `PET_JOURNAL_PETS_HEALED`.

No payload.

### PetJournalTrapLevelSet

Fires as `PET_JOURNAL_TRAP_LEVEL_SET`.

```lua
payload: trapLevel: number
```

### UpdateSummonpetsAction

Fires as `UPDATE_SUMMONPETS_ACTION`.

No payload.
