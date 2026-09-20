# C_AzeriteEssence

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`21` functions - `8` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ActivateEssence

```lua
C_AzeriteEssence.ActivateEssence(essenceID: number, milestoneID: number)
```

### CanActivateEssence

```lua
C_AzeriteEssence.CanActivateEssence(essenceID: number, milestoneID: number) -> canActivate: bool
```

### CanDeactivateEssence

```lua
C_AzeriteEssence.CanDeactivateEssence(milestoneID: number) -> canDeactivate: bool
```

### CanOpenUI

```lua
C_AzeriteEssence.CanOpenUI() -> canOpen: bool
```

### ClearPendingActivationEssence

```lua
C_AzeriteEssence.ClearPendingActivationEssence()
```

### CloseForge

```lua
C_AzeriteEssence.CloseForge()
```

### GetEssenceHyperlink

```lua
C_AzeriteEssence.GetEssenceHyperlink(essenceID: number, rank: number) -> link: cstring
```

### GetEssenceInfo

```lua
C_AzeriteEssence.GetEssenceInfo(essenceID: number) -> info: AzeriteEssenceInfo
```

### GetEssences

```lua
C_AzeriteEssence.GetEssences() -> essences: table
```

### GetMilestoneEssence

```lua
C_AzeriteEssence.GetMilestoneEssence(milestoneID: number) -> essenceID: number
```

### GetMilestoneInfo

```lua
C_AzeriteEssence.GetMilestoneInfo(milestoneID: number) -> info: AzeriteMilestoneInfo
```

### GetMilestones

```lua
C_AzeriteEssence.GetMilestones() -> milestones: table
```

### GetMilestoneSpell

```lua
C_AzeriteEssence.GetMilestoneSpell(milestoneID: number) -> spellID: number
```

### GetNumUnlockedEssences

```lua
C_AzeriteEssence.GetNumUnlockedEssences() -> numUnlockedEssences: number
```

### GetNumUsableEssences

```lua
C_AzeriteEssence.GetNumUsableEssences() -> numUsableEssences: number
```

### GetPendingActivationEssence

```lua
C_AzeriteEssence.GetPendingActivationEssence() -> essenceID: number
```

### HasNeverActivatedAnyEssences

```lua
C_AzeriteEssence.HasNeverActivatedAnyEssences() -> hasNeverActivatedAnyEssences: bool
```

### HasPendingActivationEssence

```lua
C_AzeriteEssence.HasPendingActivationEssence() -> hasEssence: bool
```

### IsAtForge

```lua
C_AzeriteEssence.IsAtForge() -> isAtForge: bool
```

### SetPendingActivationEssence

```lua
C_AzeriteEssence.SetPendingActivationEssence(essenceID: number)
```

### UnlockMilestone

```lua
C_AzeriteEssence.UnlockMilestone(milestoneID: number)
```

## Events

### AzeriteEssenceActivated

Fires as `AZERITE_ESSENCE_ACTIVATED`.

```lua
payload: slot: AzeriteEssenceSlot, essenceID: number
```

### AzeriteEssenceActivationFailed

Fires as `AZERITE_ESSENCE_ACTIVATION_FAILED`.

```lua
payload: slot: AzeriteEssenceSlot, essenceID: number
```

### AzeriteEssenceChanged

Fires as `AZERITE_ESSENCE_CHANGED`.

```lua
payload: essenceID: number, newRank: number
```

### AzeriteEssenceForgeClose

Fires as `AZERITE_ESSENCE_FORGE_CLOSE`.

No payload.

### AzeriteEssenceForgeOpen

Fires as `AZERITE_ESSENCE_FORGE_OPEN`.

No payload.

### AzeriteEssenceMilestoneUnlocked

Fires as `AZERITE_ESSENCE_MILESTONE_UNLOCKED`.

```lua
payload: milestoneID: number
```

### AzeriteEssenceUpdate

Fires as `AZERITE_ESSENCE_UPDATE`.

No payload.

### PendingAzeriteEssenceChanged

Fires as `PENDING_AZERITE_ESSENCE_CHANGED`.

```lua
payload: essenceID?: number
```
