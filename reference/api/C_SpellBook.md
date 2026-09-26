# C_SpellBook

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`51` functions - `19` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AbortSpellIntro

```lua
C_SpellBook.AbortSpellIntro(spellID: number)
```

### CastSpellBookItem

```lua
C_SpellBook.CastSpellBookItem(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank, targetSelf: bool)
```

### ContainsAnyDisenchantSpell

```lua
C_SpellBook.ContainsAnyDisenchantSpell() -> contains: bool
```

### FindBaseSpellByID

```lua
C_SpellBook.FindBaseSpellByID(spellID: number) -> baseSpellID?: number
```

### FindFlyoutSlotBySpellID

```lua
C_SpellBook.FindFlyoutSlotBySpellID(spellID: number) -> flyoutSlot: luaIndex
```

### FindSpellBookSlotForSpell

```lua
C_SpellBook.FindSpellBookSlotForSpell(spellIdentifier: SpellIdentifier, includeHidden: bool, includeFlyouts: bool, includeFutureSpells: bool, includeOffSpec: bool) -> spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank
```

### FindSpellOverrideByID

```lua
C_SpellBook.FindSpellOverrideByID(spellID: number) -> overrideSpellID?: number
```

### GetClassSkillLineInfo

```lua
C_SpellBook.GetClassSkillLineInfo() -> skillLineInfo: SpellBookSkillLineInfo
```

### GetCurrentLevelSpells

```lua
C_SpellBook.GetCurrentLevelSpells(level: number) -> spellIDs: table
```

### GetNumSpellBookSkillLines

```lua
C_SpellBook.GetNumSpellBookSkillLines() -> numSpellBookSkillLines: number
```

### GetSkillLineIndexByID

```lua
C_SpellBook.GetSkillLineIndexByID(skillLineID: number) -> skillIndex?: luaIndex
```

### GetSpellBookItemAutoCast

```lua
C_SpellBook.GetSpellBookItemAutoCast(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> autoCastAllowed: bool, autoCastEnabled: bool
```

### GetSpellBookItemCastCount

```lua
C_SpellBook.GetSpellBookItemCastCount(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> castCount: number
```

### GetSpellBookItemChargeDuration

```lua
C_SpellBook.GetSpellBookItemChargeDuration(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> duration: LuaDurationObject
```

### GetSpellBookItemCharges

```lua
C_SpellBook.GetSpellBookItemCharges(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> chargeInfo: SpellChargeInfo
```

### GetSpellBookItemCooldown

```lua
C_SpellBook.GetSpellBookItemCooldown(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> spellCooldownInfo: SpellCooldownInfo
```

### GetSpellBookItemCooldownDuration

```lua
C_SpellBook.GetSpellBookItemCooldownDuration(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank, ignoreGCD: bool) -> duration: LuaDurationObject
```

### GetSpellBookItemDescription

```lua
C_SpellBook.GetSpellBookItemDescription(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> description: string
```

### GetSpellBookItemInfo

```lua
C_SpellBook.GetSpellBookItemInfo(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> spellBookItemInfo: SpellBookItemInfo
```

### GetSpellBookItemLevelLearned

```lua
C_SpellBook.GetSpellBookItemLevelLearned(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> levelLearned: number
```

### GetSpellBookItemLink

```lua
C_SpellBook.GetSpellBookItemLink(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank, glyphID?: number) -> spellLink: string
```

### GetSpellBookItemLossOfControlCooldownDuration

```lua
C_SpellBook.GetSpellBookItemLossOfControlCooldownDuration(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> duration: LuaDurationObject
```

### GetSpellBookItemLossOfControlCooldownInfo

```lua
C_SpellBook.GetSpellBookItemLossOfControlCooldownInfo(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> lossOfControlInfo: SpellLossOfControlInfo
```

### GetSpellBookItemName

```lua
C_SpellBook.GetSpellBookItemName(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> name: string, subName: string
```

### GetSpellBookItemPowerCost

```lua
C_SpellBook.GetSpellBookItemPowerCost(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> powerCosts: table
```

### GetSpellBookItemSkillLineIndex

```lua
C_SpellBook.GetSpellBookItemSkillLineIndex(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> skillLineIndex?: luaIndex
```

### GetSpellBookItemTexture

```lua
C_SpellBook.GetSpellBookItemTexture(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> iconID: fileID
```

### GetSpellBookItemTradeSkillLink

```lua
C_SpellBook.GetSpellBookItemTradeSkillLink(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> spellLink: string
```

### GetSpellBookItemType

```lua
C_SpellBook.GetSpellBookItemType(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> itemType: SpellBookItemType, actionID: number, spellID?: number
```

### GetSpellBookSkillLineInfo

```lua
C_SpellBook.GetSpellBookSkillLineInfo(skillLineIndex: luaIndex) -> skillLineInfo: SpellBookSkillLineInfo
```

### HasPetSpells

```lua
C_SpellBook.HasPetSpells() -> numPetSpells: number, petNameToken: string
```

### IsAutoAttackSpellBookItem

```lua
C_SpellBook.IsAutoAttackSpellBookItem(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> isAutoAttack: bool
```

### IsClassTalentSpellBookItem

```lua
C_SpellBook.IsClassTalentSpellBookItem(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> isClassTalent: bool
```

### IsPvPTalentSpellBookItem

```lua
C_SpellBook.IsPvPTalentSpellBookItem(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> isPvPTalent: bool
```

### IsRangedAutoAttackSpellBookItem

```lua
C_SpellBook.IsRangedAutoAttackSpellBookItem(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> isRangedAutoAttack: bool
```

### IsSpellBookItemHarmful

```lua
C_SpellBook.IsSpellBookItemHarmful(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> isHarmful: bool
```

### IsSpellBookItemHelpful

```lua
C_SpellBook.IsSpellBookItemHelpful(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> isHelpful: bool
```

### IsSpellBookItemInRange

```lua
C_SpellBook.IsSpellBookItemInRange(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank, targetUnit?: UnitToken) -> inRange?: bool
```

### IsSpellBookItemLooseFlyoutMember

```lua
C_SpellBook.IsSpellBookItemLooseFlyoutMember(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> isFlyoutMember: bool
```

### IsSpellBookItemLowRank

```lua
C_SpellBook.IsSpellBookItemLowRank(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> isLowRank: bool
```

### IsSpellBookItemOffSpec

```lua
C_SpellBook.IsSpellBookItemOffSpec(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> isOffSpec: bool
```

### IsSpellBookItemPassive

```lua
C_SpellBook.IsSpellBookItemPassive(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> isPassive: bool
```

### IsSpellBookItemUsable

```lua
C_SpellBook.IsSpellBookItemUsable(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> isUsable: bool, insufficientPower: bool
```

### IsSpellInSpellBook

```lua
C_SpellBook.IsSpellInSpellBook(spellID: number, spellBank: SpellBookSpellBank, includeOverrides: bool) -> isInSpellBook: bool
```

### IsSpellKnown

```lua
C_SpellBook.IsSpellKnown(spellID: number, spellBank: SpellBookSpellBank) -> isKnown: bool
```

### IsSpellKnownOrInSpellBook

```lua
C_SpellBook.IsSpellKnownOrInSpellBook(spellID: number, spellBank: SpellBookSpellBank, includeOverrides: bool) -> isKnownOrInSpellBook: bool
```

### PickupSpellBookItem

```lua
C_SpellBook.PickupSpellBookItem(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank)
```

### SetBarSlotFromIntro

```lua
C_SpellBook.SetBarSlotFromIntro(spellID: number, slotIndex: luaIndex)
```

### SetSpellBookItemAutoCastEnabled

```lua
C_SpellBook.SetSpellBookItemAutoCastEnabled(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank, enabled: bool)
```

### SpellBookItemHasRange

```lua
C_SpellBook.SpellBookItemHasRange(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> hasRange: bool
```

### ToggleSpellBookItemAutoCast

```lua
C_SpellBook.ToggleSpellBookItemAutoCast(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank)
```

## Events

### CurrentSpellCastChanged

Fires as `CURRENT_SPELL_CAST_CHANGED`.

```lua
payload: cancelledCast: bool
```

### LearnedSpellInSkillLine

Fires as `LEARNED_SPELL_IN_SKILL_LINE`.

```lua
payload: spellID: number, skillLineIndex: luaIndex, isGuildPerkSpell: bool
```

### MaxSpellStartRecoveryOffsetChanged

Fires as `MAX_SPELL_START_RECOVERY_OFFSET_CHANGED`.

```lua
payload: clampedNewQueueWindowMs: number
```

### PlayerTotemUpdate

Fires as `PLAYER_TOTEM_UPDATE`.

```lua
payload: totemSlot: luaIndex
```

### SpellFlyoutUpdate

Fires as `SPELL_FLYOUT_UPDATE`.

```lua
payload: flyoutID?: number, spellID?: number, isLearned?: bool
```

### SpellPushedToActionbar

Fires as `SPELL_PUSHED_TO_ACTIONBAR`.

```lua
payload: spellID: number, slot: luaIndex, page: luaIndex
```

### SpellPushedToFlyoutOnActionbar

Fires as `SPELL_PUSHED_TO_FLYOUT_ON_ACTIONBAR`.

```lua
payload: spellID: number, flyoutSlot: luaIndex, flyoutPage: luaIndex
```

### SpellsChanged

Fires as `SPELLS_CHANGED`.

No payload.

### SpellUpdateCharges

Fires as `SPELL_UPDATE_CHARGES`.

No payload.

### SpellUpdateCooldown

Fires as `SPELL_UPDATE_COOLDOWN`.

```lua
payload: spellID?: number, baseSpellID?: number, category?: number, startRecoveryCategory?: number, itemID?: number
```

### SpellUpdateIcon

Fires as `SPELL_UPDATE_ICON`.

```lua
payload: spellID?: number
```

### SpellUpdateUsable

Fires as `SPELL_UPDATE_USABLE`.

No payload.

### SpellUpdateUses

Fires as `SPELL_UPDATE_USES`.

```lua
payload: spellID: number, baseSpellID?: number
```

### StartAutorepeatSpell

Fires as `START_AUTOREPEAT_SPELL`.

No payload.

### StopAutorepeatSpell

Fires as `STOP_AUTOREPEAT_SPELL`.

No payload.

### UpdateShapeshiftCooldown

Fires as `UPDATE_SHAPESHIFT_COOLDOWN`.

No payload.

### UpdateShapeshiftForm

Fires as `UPDATE_SHAPESHIFT_FORM`.

No payload.

### UpdateShapeshiftForms

Fires as `UPDATE_SHAPESHIFT_FORMS`.

No payload.

### UpdateShapeshiftUsable

Fires as `UPDATE_SHAPESHIFT_USABLE`.

No payload.
