# C_BattlePet

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`0` functions - `26` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Events

### PetBattleAbilityChanged

Fires as `PET_BATTLE_ABILITY_CHANGED`.

```lua
payload: owner: number, petIndex: number, abilityID: number
```

### PetBattleActionSelected

Fires as `PET_BATTLE_ACTION_SELECTED`.

No payload.

### PetBattleAuraApplied

Fires as `PET_BATTLE_AURA_APPLIED`.

```lua
payload: owner: number, petIndex: number, auraInstanceID: number
```

### PetBattleAuraCanceled

Fires as `PET_BATTLE_AURA_CANCELED`.

```lua
payload: owner: number, petIndex: number, auraInstanceID: number
```

### PetBattleAuraChanged

Fires as `PET_BATTLE_AURA_CHANGED`.

```lua
payload: owner: number, petIndex: number, auraInstanceID: number
```

### PetBattleCaptured

Fires as `PET_BATTLE_CAPTURED`.

```lua
payload: owner: number, petIndex: number
```

### PetBattleClose

Fires as `PET_BATTLE_CLOSE`.

No payload.

### PetBattleFinalRound

Fires as `PET_BATTLE_FINAL_ROUND`.

```lua
payload: owner: number
```

### PetBattleHealthChanged

Fires as `PET_BATTLE_HEALTH_CHANGED`.

```lua
payload: owner: number, petIndex: number, healthChange: number
```

### PetBattleLevelChanged

Fires as `PET_BATTLE_LEVEL_CHANGED`.

```lua
payload: owner: number, petIndex: number, newLevel: number
```

### PetBattleMaxHealthChanged

Fires as `PET_BATTLE_MAX_HEALTH_CHANGED`.

```lua
payload: owner: number, petIndex: number, healthChange: number
```

### PetBattleOpeningDone

Fires as `PET_BATTLE_OPENING_DONE`.

No payload.

### PetBattleOpeningStart

Fires as `PET_BATTLE_OPENING_START`.

No payload.

### PetBattleOver

Fires as `PET_BATTLE_OVER`.

No payload.

### PetBattleOverrideAbility

Fires as `PET_BATTLE_OVERRIDE_ABILITY`.

```lua
payload: abilityIndex: number
```

### PetBattlePetChanged

Fires as `PET_BATTLE_PET_CHANGED`.

```lua
payload: owner: number
```

### PetBattlePetRoundPlaybackComplete

Fires as `PET_BATTLE_PET_ROUND_PLAYBACK_COMPLETE`.

```lua
payload: roundNumber: number
```

### PetBattlePetRoundResults

Fires as `PET_BATTLE_PET_ROUND_RESULTS`.

```lua
payload: roundNumber: number
```

### PetBattlePetTypeChanged

Fires as `PET_BATTLE_PET_TYPE_CHANGED`.

```lua
payload: owner: number, petIndex: number, stateValue: number
```

### PetBattlePvpDuelRequestCancel

Fires as `PET_BATTLE_PVP_DUEL_REQUEST_CANCEL`.

No payload.

### PetBattlePvpDuelRequested

Fires as `PET_BATTLE_PVP_DUEL_REQUESTED`.

```lua
payload: fullName: cstring
```

### PetBattleQueueProposalAccepted

Fires as `PET_BATTLE_QUEUE_PROPOSAL_ACCEPTED`.

No payload.

### PetBattleQueueProposalDeclined

Fires as `PET_BATTLE_QUEUE_PROPOSAL_DECLINED`.

No payload.

### PetBattleQueueProposeMatch

Fires as `PET_BATTLE_QUEUE_PROPOSE_MATCH`.

No payload.

### PetBattleQueueStatus

Fires as `PET_BATTLE_QUEUE_STATUS`.

No payload.

### PetBattleXpChanged

Fires as `PET_BATTLE_XP_CHANGED`.

```lua
payload: owner: number, petIndex: number, xpChange: number
```
