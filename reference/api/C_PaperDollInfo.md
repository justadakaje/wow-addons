# C_PaperDollInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`21` functions - `23` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AmmoNeeded

```lua
C_PaperDollInfo.AmmoNeeded() -> ammoNeeded: bool
```

### CanAutoEquipCursorItem

```lua
C_PaperDollInfo.CanAutoEquipCursorItem() -> canAutoEquip: bool
```

### CancelTemporaryEnchantment

```lua
C_PaperDollInfo.CancelTemporaryEnchantment(slot: LuaInventorySlot)
```

### CursorCanGoInSlot

```lua
C_PaperDollInfo.CursorCanGoInSlot(slotIndex: luaIndex) -> canOccupySlot: bool
```

### GetArmorEffectiveness

```lua
C_PaperDollInfo.GetArmorEffectiveness(armor: number, attackerLevel: number) -> effectiveness: number
```

### GetArmorEffectivenessAgainstTarget

```lua
C_PaperDollInfo.GetArmorEffectivenessAgainstTarget(armor: number) -> effectiveness?: number
```

### GetInspectAzeriteItemEmpoweredChoices

```lua
C_PaperDollInfo.GetInspectAzeriteItemEmpoweredChoices(unit: UnitToken, equipmentSlotIndex: luaIndex) -> azeritePowerIDs: table
```

### GetInspectGuildInfo

```lua
C_PaperDollInfo.GetInspectGuildInfo(unitString: string) -> achievementPoints: number, numMembers: number, guildName: string, realmName: string
```

### GetInspectItemLevel

```lua
C_PaperDollInfo.GetInspectItemLevel(unit: UnitToken) -> equippedItemLevel: number
```

### GetInspectRatedBGBlitzData

```lua
C_PaperDollInfo.GetInspectRatedBGBlitzData() -> ratedBGBlitzData: InspectPVPData
```

### GetInspectRatedBGData

```lua
C_PaperDollInfo.GetInspectRatedBGData() -> ratedBGData: InspectRatedBGData
```

### GetInspectRatedSoloShuffleData

```lua
C_PaperDollInfo.GetInspectRatedSoloShuffleData() -> ratedSoloShuffleData: InspectPVPData
```

### GetInventorySlotInfo

```lua
C_PaperDollInfo.GetInventorySlotInfo(slotName: cstring) -> invSlot: number, slotTexture: fileID, checkRelic: bool
```

### GetInventorySlotInfoForInvSlot

```lua
C_PaperDollInfo.GetInventorySlotInfoForInvSlot(invSlotValue: number) -> invSlot: number, slotTexture: fileID, checkRelic: bool, slotName: cstring
```

### GetMinItemLevel

```lua
C_PaperDollInfo.GetMinItemLevel() -> minItemLevel?: number
```

### GetStaggerPercentage

```lua
C_PaperDollInfo.GetStaggerPercentage(unit: UnitToken) -> stagger: number, staggerAgainstTarget?: number
```

### GetTemporaryEnchantmentInfo

```lua
C_PaperDollInfo.GetTemporaryEnchantmentInfo(slot: LuaInventorySlot) -> enchantInfo: TemporaryItemEnchantInfo
```

### IsInventorySlotEnabled

```lua
C_PaperDollInfo.IsInventorySlotEnabled(slotName: stringView) -> isEnabled: bool
```

### IsRangedSlotShown

```lua
C_PaperDollInfo.IsRangedSlotShown() -> isShown: bool
```

### OffhandHasShield

```lua
C_PaperDollInfo.OffhandHasShield() -> offhandHasShield: bool
```

### OffhandHasWeapon

```lua
C_PaperDollInfo.OffhandHasWeapon() -> offhandHasWeapon: bool
```

## Events

### AvoidanceUpdate

Fires as `AVOIDANCE_UPDATE`.

No payload.

### CharacterPointsChanged

Fires as `CHARACTER_POINTS_CHANGED`.

```lua
payload: change: number
```

### CharacterUpgradeSpellTierSet

Fires as `CHARACTER_UPGRADE_SPELL_TIER_SET`.

```lua
payload: tierIndex: number
```

### CombatRatingUpdate

Fires as `COMBAT_RATING_UPDATE`.

No payload.

### DisableXpGain

Fires as `DISABLE_XP_GAIN`.

No payload.

### EnableXpGain

Fires as `ENABLE_XP_GAIN`.

No payload.

### EquipBindConfirm

Fires as `EQUIP_BIND_CONFIRM`.

```lua
payload: slot: number, itemLocation: ItemLocation
```

### InspectHonorUpdate

Fires as `INSPECT_HONOR_UPDATE`.

No payload.

### InspectReady

Fires as `INSPECT_READY`.

```lua
payload: inspecteeGUID: WOWGUID
```

### LifestealUpdate

Fires as `LIFESTEAL_UPDATE`.

No payload.

### MasteryUpdate

Fires as `MASTERY_UPDATE`.

No payload.

### PetStatsUpdate

Fires as `PET_STATS_UPDATE`.

No payload.

### PlayerAvgItemLevelUpdate

Fires as `PLAYER_AVG_ITEM_LEVEL_UPDATE`.

No payload.

### PlayerEquipmentChanged

Fires as `PLAYER_EQUIPMENT_CHANGED`.

```lua
payload: equipmentSlot: number, hasCurrent: bool
```

### ProfessionEquipmentChanged

Fires as `PROFESSION_EQUIPMENT_CHANGED`.

```lua
payload: skillLineID: number, isTool: bool
```

### PvpPowerUpdate

Fires as `PVP_POWER_UPDATE`.

No payload.

### SpeedUpdate

Fires as `SPEED_UPDATE`.

No payload.

### SpellPowerChanged

Fires as `SPELL_POWER_CHANGED`.

No payload.

### SturdinessUpdate

Fires as `STURDINESS_UPDATE`.

No payload.

### UpdateFaction

Fires as `UPDATE_FACTION`.

No payload.

### UpdateInventoryAlerts

Fires as `UPDATE_INVENTORY_ALERTS`.

No payload.

### UpdateInventoryDurability

Fires as `UPDATE_INVENTORY_DURABILITY`.

No payload.

### WeaponSlotChanged

Fires as `WEAPON_SLOT_CHANGED`.

No payload.
