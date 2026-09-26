# C_SpecializationInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`31` functions - `10` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanPlayerUsePVPTalentUI

```lua
C_SpecializationInfo.CanPlayerUsePVPTalentUI() -> canUse: bool, failureReason: string
```

### CanPlayerUseTalentSpecUI

```lua
C_SpecializationInfo.CanPlayerUseTalentSpecUI() -> canUse: bool, failureReason: string
```

### CanPlayerUseTalentUI

```lua
C_SpecializationInfo.CanPlayerUseTalentUI() -> canUse: bool, failureReason: string
```

### GetActiveSpecGroup

```lua
C_SpecializationInfo.GetActiveSpecGroup(isInspect?: bool, isPet?: bool) -> groupIndex: luaIndex
```

### GetAllClassIDs

```lua
C_SpecializationInfo.GetAllClassIDs() -> allClassIDs: table
```

### GetAllSelectedPvpTalentIDs

```lua
C_SpecializationInfo.GetAllSelectedPvpTalentIDs() -> selectedPvpTalentIDs: table
```

### GetClassIDFromSpecID

```lua
C_SpecializationInfo.GetClassIDFromSpecID(specID: number) -> classID?: number
```

### GetCombatConfigIDForSpecGroup

```lua
C_SpecializationInfo.GetCombatConfigIDForSpecGroup(groupIndex: luaIndex) -> configID?: number
```

### GetInspectSelectedPvpTalent

```lua
C_SpecializationInfo.GetInspectSelectedPvpTalent(inspectedUnit: UnitToken, talentIndex: number) -> selectedTalentID?: number
```

### GetInspectSpecialization

```lua
C_SpecializationInfo.GetInspectSpecialization(unit: UnitToken) -> specializationID: number
```

### GetNumSpecializationsForClassID

```lua
C_SpecializationInfo.GetNumSpecializationsForClassID(classID: number) -> specCount: number
```

### GetPvpTalentAlertStatus

```lua
C_SpecializationInfo.GetPvpTalentAlertStatus() -> hasUnspentSlot: bool, hasNewTalent: bool
```

### GetPvpTalentInfo

```lua
C_SpecializationInfo.GetPvpTalentInfo(talentID: number) -> talentInfo?: PvpTalentInfo
```

### GetPvpTalentSlotInfo

```lua
C_SpecializationInfo.GetPvpTalentSlotInfo(talentIndex: number) -> slotInfo?: PvpTalentSlotInfo
```

### GetPvpTalentSlotUnlockLevel

```lua
C_SpecializationInfo.GetPvpTalentSlotUnlockLevel(talentIndex: number) -> requiredLevel?: number
```

### GetPvpTalentUnlockLevel

```lua
C_SpecializationInfo.GetPvpTalentUnlockLevel(talentID: number) -> requiredLevel?: number
```

### GetSpecialization

```lua
C_SpecializationInfo.GetSpecialization(isInspect?: bool, isPet?: bool, specGroupIndex?: luaIndex) -> specializationIndex: luaIndex
```

### GetSpecializationInfo

```lua
C_SpecializationInfo.GetSpecializationInfo(specializationIndex: luaIndex, isInspect: bool, isPet: bool, inspectTarget?: string, sex?: number, groupIndex?: luaIndex, classID?: number) -> specId: number, name?: string, description?: string, icon?: fileID, role?: string, primaryStat?: luaIndex, pointsSpent: number, background?: string, previewPointsSpent: number, isUnlocked: bool
```

### GetSpecializationMasterySpells

```lua
C_SpecializationInfo.GetSpecializationMasterySpells(specializationIndex: luaIndex, isInspect?: bool, isPet?: bool) -> spellIDs: table
```

### GetSpecIDs

```lua
C_SpecializationInfo.GetSpecIDs(specSetID: number) -> specIDs: table
```

### GetSpellsDisplay

```lua
C_SpecializationInfo.GetSpellsDisplay(specializationID: number) -> spellID: table
```

### GetTalentInfo

```lua
C_SpecializationInfo.GetTalentInfo(query: TalentInfoQuery) -> result?: TalentInfoResult
```

### HasPlayerEarnedATalentPoint

```lua
C_SpecializationInfo.HasPlayerEarnedATalentPoint() -> hasEarned: bool
```

### IsInitialized

```lua
C_SpecializationInfo.IsInitialized() -> isSpecializationDataInitialized: bool
```

### IsPvpTalentLocked

```lua
C_SpecializationInfo.IsPvpTalentLocked(talentID: number) -> locked: bool
```

### IsSpecSelectionEnabled

```lua
C_SpecializationInfo.IsSpecSelectionEnabled(classID: number) -> enabled: bool
```

### MatchesCurrentSpecSet

```lua
C_SpecializationInfo.MatchesCurrentSpecSet(specSetID: number) -> matches: bool
```

### SetActiveSpecGroup

```lua
C_SpecializationInfo.SetActiveSpecGroup(groupIndex: luaIndex)
```

### SetPetSpecialization

```lua
C_SpecializationInfo.SetPetSpecialization(specIndex: luaIndex, petNumber?: number)
```

### SetPvpTalentLocked

```lua
C_SpecializationInfo.SetPvpTalentLocked(talentID: number, locked: bool)
```

### SetSpecialization

```lua
C_SpecializationInfo.SetSpecialization(specIndex: luaIndex) -> success: bool
```

## Events

### ActiveTalentGroupChanged

Fires as `ACTIVE_TALENT_GROUP_CHANGED`.

```lua
payload: curr: number, prev: number
```

### ConfirmPetUnlearn

Fires as `CONFIRM_PET_UNLEARN`.

```lua
payload: cost: number
```

### ConfirmTalentWipe

Fires as `CONFIRM_TALENT_WIPE`.

```lua
payload: cost: number, respecType: number
```

### PetSpecializationChanged

Fires as `PET_SPECIALIZATION_CHANGED`.

No payload.

### PlayerLearnPvpTalentFailed

Fires as `PLAYER_LEARN_PVP_TALENT_FAILED`.

No payload.

### PlayerLearnTalentFailed

Fires as `PLAYER_LEARN_TALENT_FAILED`.

No payload.

### PlayerPvpTalentUpdate

Fires as `PLAYER_PVP_TALENT_UPDATE`.

No payload.

### PlayerTalentUpdate

Fires as `PLAYER_TALENT_UPDATE`.

No payload.

### SpecInvoluntarilyChanged

Fires as `SPEC_INVOLUNTARILY_CHANGED`.

```lua
payload: isPet: bool
```

### TalentsInvoluntarilyReset

Fires as `TALENTS_INVOLUNTARILY_RESET`.

```lua
payload: isPetTalents: bool
```
