# C_UnitAuras

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`37` functions - `6` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddAuraSound

```lua
C_UnitAuras.AddAuraSound(trigger: UnitAuraSoundTrigger, sound: UnitAuraSoundInfo) -> auraSoundID?: number
```

### AddBlockedAura

```lua
C_UnitAuras.AddBlockedAura(unit: UnitTokenRestrictedForAddOns, auraInstanceID: number)
```

### AddPrivateAuraAnchor

```lua
C_UnitAuras.AddPrivateAuraAnchor(args: AddPrivateAuraAnchorArgs) -> anchorID?: number
```

### AuraIsBigDefensive

```lua
C_UnitAuras.AuraIsBigDefensive(spellID: SpellIdentifier) -> isBigDefensive: bool
```

### AuraIsPrivate

```lua
C_UnitAuras.AuraIsPrivate(spellID: SpellIdentifier) -> isPrivate: bool
```

### CancelAuraByInstanceID

```lua
C_UnitAuras.CancelAuraByInstanceID(unit: UnitTokenRestrictedForAddOns, auraInstanceID: number)
```

### ClearBlockedAuras

```lua
C_UnitAuras.ClearBlockedAuras(unit: UnitTokenRestrictedForAddOns)
```

### DoesAuraHaveExpirationTime

```lua
C_UnitAuras.DoesAuraHaveExpirationTime(auraInstanceUnit: UnitToken, auraInstanceID: number) -> hasExpirationTime: bool
```

### GetAuraApplicationDisplayCount

```lua
C_UnitAuras.GetAuraApplicationDisplayCount(auraInstanceUnit: UnitToken, auraInstanceID: number, minDisplayCount: number, maxDisplayCount?: number) -> count: string
```

### GetAuraBaseDuration

```lua
C_UnitAuras.GetAuraBaseDuration(auraInstanceUnit: UnitToken, auraInstanceID: number, spellID?: SpellIdentifier) -> newDuration?: number
```

### GetAuraCasterGUID

```lua
C_UnitAuras.GetAuraCasterGUID(auraInstanceUnit: UnitToken, auraInstanceID: number) -> casterGUID?: WOWGUID
```

### GetAuraDataByAuraInstanceID

```lua
C_UnitAuras.GetAuraDataByAuraInstanceID(unit: UnitTokenRestrictedForAddOns, auraInstanceID: number) -> aura?: AuraData
```

### GetAuraDataByIndex

```lua
C_UnitAuras.GetAuraDataByIndex(unit: UnitTokenRestrictedForAddOns, index: luaIndex, filter?: AuraFilters) -> aura?: AuraData
```

### GetAuraDataBySlot

```lua
C_UnitAuras.GetAuraDataBySlot(unit: UnitTokenRestrictedForAddOns, slot: number) -> aura?: AuraData
```

### GetAuraDataBySpellName

```lua
C_UnitAuras.GetAuraDataBySpellName(unit: UnitTokenRestrictedForAddOns, spellName: cstring, filter?: AuraFilters) -> aura?: AuraData
```

### GetAuraDispelTypeColor

```lua
C_UnitAuras.GetAuraDispelTypeColor(auraInstanceUnit: UnitToken, auraInstanceID: number, curve: LuaColorCurveObject) -> dispelTypeColor: colorRGBA
```

### GetAuraDuration

```lua
C_UnitAuras.GetAuraDuration(auraInstanceUnit: UnitToken, auraInstanceID: number) -> duration: LuaDurationObject
```

### GetAuraSlots

```lua
C_UnitAuras.GetAuraSlots(unit: UnitTokenRestrictedForAddOns, filter?: AuraFilters, maxSlots?: number, continuationToken?: number) -> outContinuationToken?: number, slots: number
```

### GetBuffDataByIndex

```lua
C_UnitAuras.GetBuffDataByIndex(unit: UnitTokenRestrictedForAddOns, index: luaIndex, filter?: AuraFilters) -> aura?: AuraData
```

### GetCooldownAuraBySpellID

```lua
C_UnitAuras.GetCooldownAuraBySpellID(spellID: SpellIdentifier) -> cooldownSpellID?: number
```

### GetDebuffDataByIndex

```lua
C_UnitAuras.GetDebuffDataByIndex(unit: UnitTokenRestrictedForAddOns, index: luaIndex, filter?: AuraFilters) -> aura?: AuraData
```

### GetGroupBuffVisualAlerts

```lua
C_UnitAuras.GetGroupBuffVisualAlerts() -> visualAlerts: table
```

### GetHiddenGroupBuffs

```lua
C_UnitAuras.GetHiddenGroupBuffs() -> spellIDs: table
```

### GetPlayerAuraBySpellID

```lua
C_UnitAuras.GetPlayerAuraBySpellID(spellID: SpellIdentifier) -> aura?: AuraData
```

### GetRefreshExtendedDuration

```lua
C_UnitAuras.GetRefreshExtendedDuration(auraInstanceUnit: UnitToken, auraInstanceID: number, spellID?: SpellIdentifier) -> newDuration?: number
```

### GetUnitAuraBySpellID

```lua
C_UnitAuras.GetUnitAuraBySpellID(unit: UnitTokenRestrictedForAddOns, spellID: SpellIdentifier) -> aura?: AuraData
```

### GetUnitAuraInstanceIDs

```lua
C_UnitAuras.GetUnitAuraInstanceIDs(unit: UnitTokenRestrictedForAddOns, filter: AuraFilters, maxCount?: number, sortRule: UnitAuraSortRule, sortDirection: UnitAuraSortDirection) -> auraInstanceIDs: table
```

### GetUnitAuras

```lua
C_UnitAuras.GetUnitAuras(unit: UnitTokenRestrictedForAddOns, filter: AuraFilters, maxCount?: number, sortRule: UnitAuraSortRule, sortDirection: UnitAuraSortDirection) -> auras: table
```

### IsAuraFilteredOutByInstanceID

```lua
C_UnitAuras.IsAuraFilteredOutByInstanceID(unit: UnitTokenRestrictedForAddOns, auraInstanceID: number, filter: AuraFilters) -> isFiltered: bool
```

### RemoveAuraSound

```lua
C_UnitAuras.RemoveAuraSound(auraSoundID: number)
```

### RemovePrivateAuraAnchor

```lua
C_UnitAuras.RemovePrivateAuraAnchor(anchorID: number)
```

### ResetAuraDataProvider

```lua
C_UnitAuras.ResetAuraDataProvider()
```

### SetGroupBuffVisualAlerts

```lua
C_UnitAuras.SetGroupBuffVisualAlerts(visualAlerts: table)
```

### SetHiddenGroupBuffs

```lua
C_UnitAuras.SetHiddenGroupBuffs(spellIDs: table)
```

### SetPrivateWarningTextAnchor

```lua
C_UnitAuras.SetPrivateWarningTextAnchor(parent: SimpleFrame, anchor?: AnchorBinding)
```

### SwitchAuraDataProvider

```lua
C_UnitAuras.SwitchAuraDataProvider()
```

### WantsAlteredForm

```lua
C_UnitAuras.WantsAlteredForm(unit: UnitToken) -> wantsAlteredForm: bool
```

## Events

### AuraDataProviderSwitch

Fires as `AURA_DATA_PROVIDER_SWITCH`.

```lua
payload: useRealDataProvider: bool
```

### GroupBuffVisualAlertsChanged

Fires as `GROUP_BUFF_VISUAL_ALERTS_CHANGED`.

```lua
payload: visualAlerts: table
```

### HiddenGroupBuffsChanged

Fires as `HIDDEN_GROUP_BUFFS_CHANGED`.

```lua
payload: spellIDs: table
```

### UnitAura

Fires as `UNIT_AURA`.

```lua
payload: unitTarget: UnitTokenVariant, updateInfo: UnitAuraUpdateInfo
```

### UnitAuraBlocked

Fires as `UNIT_AURA_BLOCKED`.

```lua
payload: unitTarget: UnitTokenVariant, auraInstanceID: number
```

### UnitAuraBlockListCleared

Fires as `UNIT_AURA_BLOCK_LIST_CLEARED`.

```lua
payload: unitTarget: UnitTokenVariant
```
