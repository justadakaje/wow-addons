# C_DeathInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`5` functions - `14` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetCorpseMapPosition

```lua
C_DeathInfo.GetCorpseMapPosition(uiMapID: number) -> position?: vector2
```

### GetDeathReleasePosition

```lua
C_DeathInfo.GetDeathReleasePosition(uiMapID: number) -> position?: vector2
```

### GetGraveyardsForMap

```lua
C_DeathInfo.GetGraveyardsForMap(uiMapID: number) -> graveyards: table
```

### GetSelfResurrectOptions

```lua
C_DeathInfo.GetSelfResurrectOptions() -> options: table
```

### UseSelfResurrectOption

```lua
C_DeathInfo.UseSelfResurrectOption(optionType: SelfResurrectOptionType, id: number)
```

## Events

### AreaSpiritHealerInRange

Fires as `AREA_SPIRIT_HEALER_IN_RANGE`.

No payload.

### AreaSpiritHealerOutOfRange

Fires as `AREA_SPIRIT_HEALER_OUT_OF_RANGE`.

No payload.

### CemeteryPreferenceUpdated

Fires as `CEMETERY_PREFERENCE_UPDATED`.

No payload.

### ConfirmXpLoss

Fires as `CONFIRM_XP_LOSS`.

No payload.

### CorpseInInstance

Fires as `CORPSE_IN_INSTANCE`.

No payload.

### CorpseInRange

Fires as `CORPSE_IN_RANGE`.

No payload.

### CorpseOutOfRange

Fires as `CORPSE_OUT_OF_RANGE`.

No payload.

### PlayerAlive

Fires as `PLAYER_ALIVE`.

No payload.

### PlayerDead

Fires as `PLAYER_DEAD`.

No payload.

### PlayerSkinned

Fires as `PLAYER_SKINNED`.

```lua
payload: hasFreeRepop: number
```

### PlayerUnghost

Fires as `PLAYER_UNGHOST`.

No payload.

### RequestCemeteryListResponse

Fires as `REQUEST_CEMETERY_LIST_RESPONSE`.

```lua
payload: isGossipTriggered: bool
```

### ResurrectRequest

Fires as `RESURRECT_REQUEST`.

```lua
payload: inviter: cstring
```

### SelfResSpellChanged

Fires as `SELF_RES_SPELL_CHANGED`.

No payload.
