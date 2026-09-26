# C_ProfSpecs

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`27` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanRefundPath

```lua
C_ProfSpecs.CanRefundPath(pathID: number, configID: number) -> canRefund: bool
```

### CanUnlockTab

```lua
C_ProfSpecs.CanUnlockTab(tabTreeID: number, configID: number) -> canUnlock: bool
```

### GetChildrenForPath

```lua
C_ProfSpecs.GetChildrenForPath(pathID: number) -> childIDs: table
```

### GetConfigIDForSkillLine

```lua
C_ProfSpecs.GetConfigIDForSkillLine(skillLineID: number) -> configID: number
```

### GetCurrencyInfoForSkillLine

```lua
C_ProfSpecs.GetCurrencyInfoForSkillLine(skillLineID: number) -> info: SpecializationCurrencyInfo
```

### GetDefaultSpecSkillLine

```lua
C_ProfSpecs.GetDefaultSpecSkillLine() -> defaultSpecSkillLine?: number
```

### GetDescriptionForPath

```lua
C_ProfSpecs.GetDescriptionForPath(pathID: number) -> description: string
```

### GetDescriptionForPerk

```lua
C_ProfSpecs.GetDescriptionForPerk(perkID: number) -> description: string
```

### GetEntryIDForPerk

```lua
C_ProfSpecs.GetEntryIDForPerk(perkID: number) -> entryID: number
```

### GetNewSpecReminderProfName

```lua
C_ProfSpecs.GetNewSpecReminderProfName() -> profName?: cstring
```

### GetPerksForPath

```lua
C_ProfSpecs.GetPerksForPath(pathID: number) -> perkInfos: table
```

### GetRootPathForTab

```lua
C_ProfSpecs.GetRootPathForTab(tabTreeID: number) -> rootPathID?: number
```

### GetSourceTextForPath

```lua
C_ProfSpecs.GetSourceTextForPath(pathID: number, configID: number) -> sourceText: cstring
```

### GetSpecTabIDsForSkillLine

```lua
C_ProfSpecs.GetSpecTabIDsForSkillLine(skillLineID: number) -> specTabIDs: table
```

### GetSpecTabInfo

```lua
C_ProfSpecs.GetSpecTabInfo() -> specTabInfo: SpecializationTabInfo
```

### GetSpendCurrencyForPath

```lua
C_ProfSpecs.GetSpendCurrencyForPath(pathID: number) -> currencyID?: number
```

### GetSpendEntryForPath

```lua
C_ProfSpecs.GetSpendEntryForPath(pathID: number) -> entryID: number
```

### GetStateForPath

```lua
C_ProfSpecs.GetStateForPath(pathID: number, configID: number) -> state: ProfessionsSpecPathState
```

### GetStateForPerk

```lua
C_ProfSpecs.GetStateForPerk(perkID: number, configID: number) -> state: ProfessionsSpecPerkState
```

### GetStateForTab

```lua
C_ProfSpecs.GetStateForTab(tabTreeID: number, configID: number) -> tabInfo: ProfessionsSpecTabState
```

### GetTabInfo

```lua
C_ProfSpecs.GetTabInfo(tabTreeID: number) -> tabInfo?: ProfTabInfo
```

### GetUnlockEntryForPath

```lua
C_ProfSpecs.GetUnlockEntryForPath(pathID: number) -> entryID: number
```

### GetUnlockRankForPerk

```lua
C_ProfSpecs.GetUnlockRankForPerk(perkID: number) -> unlockRank?: number
```

### ShouldShowPointsReminder

```lua
C_ProfSpecs.ShouldShowPointsReminder() -> showReminder: bool
```

### ShouldShowPointsReminderForSkillLine

```lua
C_ProfSpecs.ShouldShowPointsReminderForSkillLine(skillLineID: number) -> showReminder: bool
```

### ShouldShowSpecTab

```lua
C_ProfSpecs.ShouldShowSpecTab() -> showSpecTab: bool
```

### SkillLineHasSpecialization

```lua
C_ProfSpecs.SkillLineHasSpecialization(skillLineID: number) -> hasSpecialization: bool
```

## Events

### SkillLineSpecsRanksChanged

Fires as `SKILL_LINE_SPECS_RANKS_CHANGED`.

No payload.

### SkillLineSpecsUnlocked

Fires as `SKILL_LINE_SPECS_UNLOCKED`.

```lua
payload: skillLineID: number, tradeSkillID: number
```
