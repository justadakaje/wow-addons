# C_Spell

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`70` functions - `6` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CancelAutoRepeatSpell

```lua
C_Spell.CancelAutoRepeatSpell() -> wasCancelled: bool
```

### CancelItemTempEnchantment

```lua
C_Spell.CancelItemTempEnchantment(weaponSlot: WeaponSlot, enchantmentType: ItemEnchantType)
```

### CancelSpellByID

```lua
C_Spell.CancelSpellByID(spellID: number)
```

### DoesSpellExist

```lua
C_Spell.DoesSpellExist(spellIdentifier: SpellIdentifier) -> spellExists: bool
```

### EnableSpellRangeCheck

```lua
C_Spell.EnableSpellRangeCheck(spellIdentifier: SpellIdentifier, enable: bool)
```

### GetAuraStatChanges

```lua
C_Spell.GetAuraStatChanges(spellID: number) -> healthChange: number, powerTypeChanges: table
```

### GetBaseSpell

```lua
C_Spell.GetBaseSpell(spellIdentifier: SpellIdentifier, spec: number) -> baseSpellID: number
```

### GetDeadlyDebuffInfo

```lua
C_Spell.GetDeadlyDebuffInfo(spellIdentifier: SpellIdentifier) -> deadlyDebuffInfo: DeadlyDebuffInfo
```

### GetItemModifiedAppearancesApplied

```lua
C_Spell.GetItemModifiedAppearancesApplied(spellID: number) -> itemModifiedAppearanceIDs: table
```

### GetLastCategoryCooldownSource

```lua
C_Spell.GetLastCategoryCooldownSource(spellCategory: number) -> spellID?: number, itemID?: number
```

### GetMawPowerLinkBySpellID

```lua
C_Spell.GetMawPowerLinkBySpellID(spellID: SpellIdentifier) -> link: cstring
```

### GetMawPowerRarityInfoBySpellID

```lua
C_Spell.GetMawPowerRarityInfoBySpellID(spellID: SpellIdentifier) -> rarityID: number, rarityBorderAtlas: textureAtlas
```

### GetOverrideSpell

```lua
C_Spell.GetOverrideSpell(spellIdentifier: SpellIdentifier, spec: number, onlyKnown: bool, ignoreOverrideSpellID: number) -> overrideSpellID: number
```

### GetSchoolString

```lua
C_Spell.GetSchoolString(schoolMask: number) -> result: cstring
```

### GetSpellAutoCast

```lua
C_Spell.GetSpellAutoCast(spellIdentifier: SpellIdentifier) -> autoCastAllowed: bool, autoCastEnabled: bool
```

### GetSpellCastCount

```lua
C_Spell.GetSpellCastCount(spellIdentifier: SpellIdentifier) -> castCount: number
```

### GetSpellChargeDuration

```lua
C_Spell.GetSpellChargeDuration(spellIdentifier: SpellIdentifier) -> duration: LuaDurationObject
```

### GetSpellCharges

```lua
C_Spell.GetSpellCharges(spellIdentifier: SpellIdentifier) -> chargeInfo: SpellChargeInfo
```

### GetSpellCooldown

```lua
C_Spell.GetSpellCooldown(spellIdentifier: SpellIdentifier) -> spellCooldownInfo: SpellCooldownInfo
```

### GetSpellCooldownDuration

```lua
C_Spell.GetSpellCooldownDuration(spellIdentifier: SpellIdentifier, ignoreGCD: bool) -> duration: LuaDurationObject
```

### GetSpellDescription

```lua
C_Spell.GetSpellDescription(spellIdentifier: SpellIdentifier) -> description: string
```

### GetSpellDescriptionForItemLocation

```lua
C_Spell.GetSpellDescriptionForItemLocation(spellIdentifier: SpellIdentifier, itemLocation: ItemLocation) -> description: string
```

### GetSpellDisplayCount

```lua
C_Spell.GetSpellDisplayCount(spellIdentifier: SpellIdentifier, maxDisplayCount: number, replacementString: cstring) -> displayCount: string
```

### GetSpellIDForSpellIdentifier

```lua
C_Spell.GetSpellIDForSpellIdentifier(spellIdentifier: SpellIdentifier) -> spellID: number
```

### GetSpellInfo

```lua
C_Spell.GetSpellInfo(spellIdentifier: SpellIdentifier) -> spellInfo: SpellInfo
```

### GetSpellLevelLearned

```lua
C_Spell.GetSpellLevelLearned(spellIdentifier: SpellIdentifier) -> levelLearned: number
```

### GetSpellLink

```lua
C_Spell.GetSpellLink(spellIdentifier: SpellIdentifier, glyphID?: number) -> spellLink: string
```

### GetSpellLossOfControlCooldownDuration

```lua
C_Spell.GetSpellLossOfControlCooldownDuration(spellIdentifier: SpellIdentifier) -> duration: LuaDurationObject
```

### GetSpellLossOfControlCooldownInfo

```lua
C_Spell.GetSpellLossOfControlCooldownInfo(spellIdentifier: SpellIdentifier) -> lossOfControlInfo: SpellLossOfControlInfo
```

### GetSpellMaxCumulativeAuraApplications

```lua
C_Spell.GetSpellMaxCumulativeAuraApplications(spellID: SpellIdentifier) -> cumulativeAura: number
```

### GetSpellName

```lua
C_Spell.GetSpellName(spellIdentifier: SpellIdentifier) -> name: cstring
```

### GetSpellPowerCost

```lua
C_Spell.GetSpellPowerCost(spellIdentifier: SpellIdentifier) -> powerCosts: table
```

### GetSpellQueueWindow

```lua
C_Spell.GetSpellQueueWindow() -> result: number
```

### GetSpellSkillLineAbilityRank

```lua
C_Spell.GetSpellSkillLineAbilityRank(spellIdentifier: SpellIdentifier) -> rank: number
```

### GetSpellSubtext

```lua
C_Spell.GetSpellSubtext(spellIdentifier: SpellIdentifier) -> subtext: string
```

### GetSpellTexture

```lua
C_Spell.GetSpellTexture(spellIdentifier: SpellIdentifier) -> iconID: fileID, originalIconID: fileID, conditionalIconID?: fileID
```

### GetSpellTradeSkillLink

```lua
C_Spell.GetSpellTradeSkillLink(spellIdentifier: SpellIdentifier) -> spellLink: string
```

### GetTargetSpellID

```lua
C_Spell.GetTargetSpellID() -> spellID: number
```

### GetVisibilityInfo

```lua
C_Spell.GetVisibilityInfo(spellID: number, visibilityType: SpellAuraVisibilityType) -> hasCustom: bool, alwaysShowMine: bool, showForMySpec: bool
```

### IsActiveSpell

```lua
C_Spell.IsActiveSpell(spellIdentifier: SpellIdentifier, targetUnit?: UnitToken) -> isActiveSpell: bool
```

### IsAutoAttackSpell

```lua
C_Spell.IsAutoAttackSpell(spellIdentifier: SpellIdentifier) -> isAutoAttack: bool
```

### IsAutoRepeatSpell

```lua
C_Spell.IsAutoRepeatSpell(spellIdentifier: SpellIdentifier) -> isAutoRepeat: bool
```

### IsClassTalentSpell

```lua
C_Spell.IsClassTalentSpell(spellIdentifier: SpellIdentifier) -> isAutoRepeat: bool
```

### IsConsumableSpell

```lua
C_Spell.IsConsumableSpell(spellIdentifier: SpellIdentifier) -> consumable: bool
```

### IsCurrentSpell

```lua
C_Spell.IsCurrentSpell(spellIdentifier: SpellIdentifier) -> isCurrentSpell: bool
```

### IsExternalDefensive

```lua
C_Spell.IsExternalDefensive(spellID: number) -> isExternalDefensive: bool
```

### IsPressHoldReleaseSpell

```lua
C_Spell.IsPressHoldReleaseSpell(spellIdentifier: SpellIdentifier) -> isPressHoldRelease: bool
```

### IsPriorityAura

```lua
C_Spell.IsPriorityAura(spellID: number) -> isHighPriority: bool
```

### IsPvPTalentSpell

```lua
C_Spell.IsPvPTalentSpell(spellIdentifier: SpellIdentifier) -> isAutoRepeat: bool
```

### IsRangedAutoAttackSpell

```lua
C_Spell.IsRangedAutoAttackSpell(spellIdentifier: SpellIdentifier) -> isRangedAutoAttack: bool
```

### IsSelfBuff

```lua
C_Spell.IsSelfBuff(spellID: number) -> hasSelfEffectsOnly: bool
```

### IsSpellCrowdControl

```lua
C_Spell.IsSpellCrowdControl(spellIdentifier: SpellIdentifier) -> isCrowdControl: bool
```

### IsSpellDataCached

```lua
C_Spell.IsSpellDataCached(spellIdentifier: SpellIdentifier) -> isCached: bool
```

### IsSpellDisabled

```lua
C_Spell.IsSpellDisabled(spellIdentifier: SpellIdentifier) -> disabled: bool
```

### IsSpellHarmful

```lua
C_Spell.IsSpellHarmful(spellIdentifier: SpellIdentifier) -> isHarmful: bool
```

### IsSpellHelpful

```lua
C_Spell.IsSpellHelpful(spellIdentifier: SpellIdentifier) -> isHelpful: bool
```

### IsSpellImportant

```lua
C_Spell.IsSpellImportant(spellIdentifier: SpellIdentifier) -> isImportant: bool
```

### IsSpellInRange

```lua
C_Spell.IsSpellInRange(spellIdentifier: SpellIdentifier, targetUnit?: UnitToken) -> inRange?: bool
```

### IsSpellPassive

```lua
C_Spell.IsSpellPassive(spellIdentifier: SpellIdentifier) -> isPassive: bool
```

### IsSpellUsable

```lua
C_Spell.IsSpellUsable(spellIdentifier: SpellIdentifier) -> isUsable: bool, insufficientPower: bool
```

### PickupSpell

```lua
C_Spell.PickupSpell(spellIdentifier: SpellIdentifier)
```

### PlaceTargetingSpellAtCursor

```lua
C_Spell.PlaceTargetingSpellAtCursor()
```

### RequestLoadSpellData

```lua
C_Spell.RequestLoadSpellData(spellIdentifier: SpellIdentifier)
```

### SetSpellAutoCastEnabled

```lua
C_Spell.SetSpellAutoCastEnabled(spellIdentifier: SpellIdentifier, enabled: bool)
```

### SpellHasRange

```lua
C_Spell.SpellHasRange(spellIdentifier: SpellIdentifier) -> hasRange: bool
```

### TargetSpellChecksItemCondition

```lua
C_Spell.TargetSpellChecksItemCondition() -> result: bool
```

### TargetSpellIsEnchanting

```lua
C_Spell.TargetSpellIsEnchanting() -> isEnchanting: bool
```

### TargetSpellJumpsUpgradeTrack

```lua
C_Spell.TargetSpellJumpsUpgradeTrack() -> jumpsUpgradeTrack: bool
```

### TargetSpellReplacesBonusTree

```lua
C_Spell.TargetSpellReplacesBonusTree() -> result: bool
```

### ToggleSpellAutoCast

```lua
C_Spell.ToggleSpellAutoCast(spellIdentifier: SpellIdentifier)
```

## Events

### EnchantSpellCompleted

Fires as `ENCHANT_SPELL_COMPLETED`.

```lua
payload: successful: bool, enchantedItem?: ItemLocation
```

### EnchantSpellSelected

Fires as `ENCHANT_SPELL_SELECTED`.

No payload.

### SpellDataLoadResult

Fires as `SPELL_DATA_LOAD_RESULT`.

```lua
payload: spellID: number, success: bool
```

### SpellRangeCheckUpdate

Fires as `SPELL_RANGE_CHECK_UPDATE`.

```lua
payload: spellIdentifier: SpellIdentifier, isInRange: bool, checksRange: bool
```

### SpellTextUpdate

Fires as `SPELL_TEXT_UPDATE`.

```lua
payload: spellID: number
```

### UpdateSpellTargetItemContext

Fires as `UPDATE_SPELL_TARGET_ITEM_CONTEXT`.

No payload.
