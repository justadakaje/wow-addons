# SpecializationShared

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`5` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetSpecializationInfoForClassID

```lua
GetSpecializationInfoForClassID(classID: number, index: luaIndex, gender?: UnitSex) -> id: number, name: cstring, description: string, icon: fileID, role: cstring, recommended: bool, allowedForBoost: bool, masterySpell1?: number, masterySpell2?: number
```

### GetSpecializationInfoForSpecID

```lua
GetSpecializationInfoForSpecID(specID: number, gender?: UnitSex) -> id: number, name: cstring, description: string, icon: fileID, role: cstring, recommended: bool, allowedForBoost: bool, masterySpell1?: number, masterySpell2?: number
```

### GetSpecializationNameForSpecID

```lua
GetSpecializationNameForSpecID(specID: number, gender?: UnitSex) -> name?: cstring
```

### GetSpecializationSystem

```lua
GetSpecializationSystem() -> system: SpecializationSystem
```

### HasLootSpecializations

```lua
HasLootSpecializations() -> hasLootSpecializations: bool
```
