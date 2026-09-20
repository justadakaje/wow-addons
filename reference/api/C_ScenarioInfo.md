# C_ScenarioInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`10` functions - `9` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetCriteriaInfo

```lua
C_ScenarioInfo.GetCriteriaInfo(criteriaIndex: number) -> scenarioCriteriaInfo: ScenarioCriteriaInfo
```

### GetCriteriaInfoByStep

```lua
C_ScenarioInfo.GetCriteriaInfoByStep(stepID: number, criteriaIndex: number) -> scenarioCriteriaInfo: ScenarioCriteriaInfo
```

### GetDisplayInfo

```lua
C_ScenarioInfo.GetDisplayInfo() -> info: ScenarioDisplayInfo
```

### GetJailersTowerTypeString

```lua
C_ScenarioInfo.GetJailersTowerTypeString(runType: JailersTowerType) -> typeString?: cstring
```

### GetScenarioIconInfo

```lua
C_ScenarioInfo.GetScenarioIconInfo(uiMapID: number) -> scenarioInfos: table
```

### GetScenarioInfo

```lua
C_ScenarioInfo.GetScenarioInfo() -> scenarioInfo: ScenarioInformation
```

### GetScenarioStepInfo

```lua
C_ScenarioInfo.GetScenarioStepInfo(scenarioStepID?: number) -> scenarioStepInfo: ScenarioStepInfo
```

### GetTieredEntranceActiveSpells

```lua
C_ScenarioInfo.GetTieredEntranceActiveSpells() -> spellIDs?: table
```

### GetUnitCriteriaProgressValues

```lua
C_ScenarioInfo.GetUnitCriteriaProgressValues(unit: UnitToken) -> actualValue: number, percentValue: number, percentValueString: string
```

### IsTieredEntranceScenario

```lua
C_ScenarioInfo.IsTieredEntranceScenario() -> isTieredEntrance: bool
```

## Events

### JailersTowerLevelUpdate

Fires as `JAILERS_TOWER_LEVEL_UPDATE`.

```lua
payload: level: number, type: JailersTowerType
```

### ScenarioBonusObjectiveComplete

Fires as `SCENARIO_BONUS_OBJECTIVE_COMPLETE`.

```lua
payload: bonusObjectiveID: number
```

### ScenarioBonusVisibilityUpdate

Fires as `SCENARIO_BONUS_VISIBILITY_UPDATE`.

No payload.

### ScenarioCompleted

Fires as `SCENARIO_COMPLETED`.

```lua
payload: questID?: number, xp?: number, money?: number
```

### ScenarioCriteriaShowStateUpdate

Fires as `SCENARIO_CRITERIA_SHOW_STATE_UPDATE`.

```lua
payload: show: bool
```

### ScenarioCriteriaUpdate

Fires as `SCENARIO_CRITERIA_UPDATE`.

```lua
payload: criteriaID: number
```

### ScenarioPoiUpdate

Fires as `SCENARIO_POI_UPDATE`.

No payload.

### ScenarioSpellUpdate

Fires as `SCENARIO_SPELL_UPDATE`.

No payload.

### ScenarioUpdate

Fires as `SCENARIO_UPDATE`.

```lua
payload: newStep?: bool
```
