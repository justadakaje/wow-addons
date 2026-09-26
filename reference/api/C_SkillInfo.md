# C_SkillInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`8` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AbandonSkill

```lua
C_SkillInfo.AbandonSkill(skillLineID: number)
```

### CollapseSkillHeader

```lua
C_SkillInfo.CollapseSkillHeader(index: luaIndex)
```

### ExpandSkillHeader

```lua
C_SkillInfo.ExpandSkillHeader(index: luaIndex)
```

### GetNumSkillLines

```lua
C_SkillInfo.GetNumSkillLines() -> numSkillLines: number
```

### GetSelectedSkill

```lua
C_SkillInfo.GetSelectedSkill() -> index: luaIndex
```

### GetSkillLineInfo

```lua
C_SkillInfo.GetSkillLineInfo(index: luaIndex) -> skillLineAttributes?: SkillLineAttributes
```

### GetSkillLineInfoByID

```lua
C_SkillInfo.GetSkillLineInfoByID(ID: number) -> skillLineAttributes?: SkillLineAttributes
```

### SetSelectedSkill

```lua
C_SkillInfo.SetSelectedSkill(index: luaIndex)
```

## Events

### SkillLinesChanged

Fires as `SKILL_LINES_CHANGED`.

No payload.
