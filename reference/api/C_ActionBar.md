# C_ActionBar

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`72` functions - `15` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### EnableActionRangeCheck

```lua
C_ActionBar.EnableActionRangeCheck(actionID: luaIndex, enable: bool)
```

### FindAssistedCombatActionButtons

```lua
C_ActionBar.FindAssistedCombatActionButtons(setToSearch: ActionBarSet) -> slots: table
```

### FindFlyoutActionButtons

```lua
C_ActionBar.FindFlyoutActionButtons(flyoutID: number, setToSearch: ActionBarSet) -> slots: table
```

### FindPetActionButtons

```lua
C_ActionBar.FindPetActionButtons(petActionID: number, setToSearch: ActionBarSet) -> slots: table
```

### FindSpellActionButtons

```lua
C_ActionBar.FindSpellActionButtons(spellID: SpellIdentifier, setToSearch: ActionBarSet) -> slots: table
```

### ForceUpdateAction

```lua
C_ActionBar.ForceUpdateAction(slotID: luaIndex, suppressEvents: bool)
```

### GetActionAutocast

```lua
C_ActionBar.GetActionAutocast(actionID: luaIndex) -> autocastAllowed: bool, autocastEnabled: bool
```

### GetActionBarPage

```lua
C_ActionBar.GetActionBarPage() -> currentPage: luaIndex
```

### GetActionChargeDuration

```lua
C_ActionBar.GetActionChargeDuration(actionID: luaIndex) -> duration: LuaDurationObject
```

### GetActionCharges

```lua
C_ActionBar.GetActionCharges(actionID: luaIndex) -> chargeInfo: SpellChargeInfo
```

### GetActionCooldown

```lua
C_ActionBar.GetActionCooldown(actionID: luaIndex) -> cooldownInfo: SpellCooldownInfo
```

### GetActionCooldownDuration

```lua
C_ActionBar.GetActionCooldownDuration(actionID: luaIndex, ignoreGCD: bool) -> duration: LuaDurationObject
```

### GetActionDisplayCount

```lua
C_ActionBar.GetActionDisplayCount(actionID: luaIndex, maxDisplayCount: number, replacementString: cstring) -> displayCount: string
```

### GetActionLossOfControlCooldownDuration

```lua
C_ActionBar.GetActionLossOfControlCooldownDuration(actionID: luaIndex) -> duration: LuaDurationObject
```

### GetActionLossOfControlCooldownInfo

```lua
C_ActionBar.GetActionLossOfControlCooldownInfo(actionID: luaIndex) -> lossOfControlInfo: SpellLossOfControlInfo
```

### GetActionText

```lua
C_ActionBar.GetActionText(actionID: luaIndex) -> text: string
```

### GetActionTexture

```lua
C_ActionBar.GetActionTexture(actionID: luaIndex) -> textureFileID: fileID
```

### GetActionUseCount

```lua
C_ActionBar.GetActionUseCount(actionID: luaIndex) -> count: number
```

### GetBonusBarIndex

```lua
C_ActionBar.GetBonusBarIndex() -> bonusBarIndex: luaIndex
```

### GetBonusBarIndexForSlot

```lua
C_ActionBar.GetBonusBarIndexForSlot(slotID: luaIndex) -> bonusBarIndex?: luaIndex
```

### GetBonusBarOffset

```lua
C_ActionBar.GetBonusBarOffset() -> bonusBarOffset: number
```

### GetExtraBarIndex

```lua
C_ActionBar.GetExtraBarIndex() -> extraBarIndex: luaIndex
```

### GetItemActionOnEquipSpellID

```lua
C_ActionBar.GetItemActionOnEquipSpellID(actionID: luaIndex) -> onEquipSpellID?: number
```

### GetMultiCastBarIndex

```lua
C_ActionBar.GetMultiCastBarIndex() -> multiCastBarIndex: luaIndex
```

### GetOverrideBarIndex

```lua
C_ActionBar.GetOverrideBarIndex() -> overrideBarIndex: luaIndex
```

### GetOverrideBarSkin

```lua
C_ActionBar.GetOverrideBarSkin() -> textureFileID?: fileID
```

### GetPetActionPetBarIndices

```lua
C_ActionBar.GetPetActionPetBarIndices(petActionID: number, setToSearch: ActionBarSet) -> slots: table
```

### GetProfessionQuality

```lua
C_ActionBar.GetProfessionQuality(actionID: luaIndex) -> quality?: number
```

### GetProfessionQualityInfo

```lua
C_ActionBar.GetProfessionQualityInfo(actionID: luaIndex) -> info?: CraftingQualityInfo
```

### GetSpell

```lua
C_ActionBar.GetSpell(actionID: luaIndex) -> spellID: number
```

### GetTempShapeshiftBarIndex

```lua
C_ActionBar.GetTempShapeshiftBarIndex() -> tempShapeshiftBarIndex: luaIndex
```

### GetVehicleBarIndex

```lua
C_ActionBar.GetVehicleBarIndex() -> vehicleBarIndex: luaIndex
```

### HasAction

```lua
C_ActionBar.HasAction(actionID: luaIndex) -> hasAction: bool
```

### HasAssistedCombatActionButtons

```lua
C_ActionBar.HasAssistedCombatActionButtons(setToSearch: ActionBarSet) -> hasButtons: bool
```

### HasBonusActionBar

```lua
C_ActionBar.HasBonusActionBar() -> hasBonusActionBar: bool
```

### HasExtraActionBar

```lua
C_ActionBar.HasExtraActionBar() -> hasExtraActionBar: bool
```

### HasFlyoutActionButtons

```lua
C_ActionBar.HasFlyoutActionButtons(flyoutID: number, setToSearch: ActionBarSet) -> hasFlyoutActionButtons: bool
```

### HasOverrideActionBar

```lua
C_ActionBar.HasOverrideActionBar() -> hasOverrideActionBar: bool
```

### HasPetActionButtons

```lua
C_ActionBar.HasPetActionButtons(petActionID: number, setToSearch: ActionBarSet) -> hasPetActionButtons: bool
```

### HasPetActionPetBarIndices

```lua
C_ActionBar.HasPetActionPetBarIndices(petActionID: number, setToSearch: ActionBarSet) -> hasPetActionPetBarIndices: bool
```

### HasRangeRequirements

```lua
C_ActionBar.HasRangeRequirements(actionID: luaIndex) -> hasRangeRequirements: bool
```

### HasSpellActionButtons

```lua
C_ActionBar.HasSpellActionButtons(spellID: SpellIdentifier, setToSearch: ActionBarSet) -> hasSpellActionButtons: bool
```

### HasTempShapeshiftActionBar

```lua
C_ActionBar.HasTempShapeshiftActionBar() -> hasTempShapeshiftActionBar: bool
```

### HasVehicleActionBar

```lua
C_ActionBar.HasVehicleActionBar() -> hasVehicleActionBar: bool
```

### IsActionInRange

```lua
C_ActionBar.IsActionInRange(actionID: luaIndex, target?: UnitToken) -> isInRange?: bool
```

### IsAssistedCombatAction

```lua
C_ActionBar.IsAssistedCombatAction(slotID: luaIndex) -> isAssistedCombatAction: bool
```

### IsAttackAction

```lua
C_ActionBar.IsAttackAction(actionID: luaIndex) -> isAttackAction: bool
```

### IsAutoCastPetAction

```lua
C_ActionBar.IsAutoCastPetAction(slotID: luaIndex) -> isAutoCastPetAction: bool
```

### IsAutoRepeatAction

```lua
C_ActionBar.IsAutoRepeatAction(actionID: luaIndex) -> isAutoRepeatAction: bool
```

### IsConsumableAction

```lua
C_ActionBar.IsConsumableAction(actionID: luaIndex) -> isConsumableAction: bool
```

### IsCurrentAction

```lua
C_ActionBar.IsCurrentAction(actionID: luaIndex) -> isCurrentAction: bool
```

### IsEnabledAutoCastPetAction

```lua
C_ActionBar.IsEnabledAutoCastPetAction(slotID: luaIndex) -> isEnabledAutoCastPetAction: bool
```

### IsEquippedAction

```lua
C_ActionBar.IsEquippedAction(actionID: luaIndex) -> isEquippedAction: bool
```

### IsEquippedGearOutfitAction

```lua
C_ActionBar.IsEquippedGearOutfitAction(slotID: luaIndex) -> isEquippedGearOutfitAction: bool
```

### IsHarmfulAction

```lua
C_ActionBar.IsHarmfulAction(actionID: luaIndex, useNeutral: bool) -> isHarmful: bool
```

### IsHelpfulAction

```lua
C_ActionBar.IsHelpfulAction(actionID: luaIndex, useNeutral: bool) -> isHelpful: bool
```

### IsInterruptAction

```lua
C_ActionBar.IsInterruptAction(slotID: luaIndex) -> isInterruptAction: bool
```

### IsItemAction

```lua
C_ActionBar.IsItemAction(actionID: luaIndex) -> isItemAction: bool
```

### IsMacroActionWithShowTooltip

```lua
C_ActionBar.IsMacroActionWithShowTooltip(actionID: luaIndex) -> isMacroActionWithShowTooltip: bool
```

### IsOnBarOrSpecialBar

```lua
C_ActionBar.IsOnBarOrSpecialBar(spellID: SpellIdentifier, setToSearch: ActionBarSet) -> isOnBarOrSpecialBar: bool
```

### IsPossessBarVisible

```lua
C_ActionBar.IsPossessBarVisible() -> isPossessBarVisible: bool
```

### IsStackableAction

```lua
C_ActionBar.IsStackableAction(actionID: luaIndex) -> isStackableAction: bool
```

### IsUsableAction

```lua
C_ActionBar.IsUsableAction(actionID: luaIndex) -> isUsable: bool, isLackingResources: bool
```

### PutActionInSlot

```lua
C_ActionBar.PutActionInSlot(slotID: luaIndex)
```

### RegisterActionUIButton

```lua
C_ActionBar.RegisterActionUIButton(checkboxFrame: SimpleCheckbox, actionID: luaIndex, cooldownFrame: CooldownFrame)
```

### SetActionBarPage

```lua
C_ActionBar.SetActionBarPage(pageIndex: luaIndex)
```

### ShouldOverrideBarShowHealthBar

```lua
C_ActionBar.ShouldOverrideBarShowHealthBar() -> showHealthBar: bool
```

### ShouldOverrideBarShowManaBar

```lua
C_ActionBar.ShouldOverrideBarShowManaBar() -> showManaBar: bool
```

### ShouldShowKeyring

```lua
C_ActionBar.ShouldShowKeyring() -> isKeyringEnabled: bool
```

### ToggleAutoCastPetAction

```lua
C_ActionBar.ToggleAutoCastPetAction(slotID: luaIndex)
```

### UnregisterActionUIButton

```lua
C_ActionBar.UnregisterActionUIButton(checkboxFrame: SimpleCheckbox)
```

### UsesActionText

```lua
C_ActionBar.UsesActionText(actionID: luaIndex) -> usesActionText: bool
```

## Events

### ActionbarHidegrid

Fires as `ACTIONBAR_HIDEGRID`.

No payload.

### ActionbarPageChanged

Fires as `ACTIONBAR_PAGE_CHANGED`.

No payload.

### ActionbarShowBottomleft

Fires as `ACTIONBAR_SHOW_BOTTOMLEFT`.

No payload.

### ActionbarShowgrid

Fires as `ACTIONBAR_SHOWGRID`.

No payload.

### ActionbarSlotChanged

Fires as `ACTIONBAR_SLOT_CHANGED`.

```lua
payload: slot: number
```

### ActionbarUpdateCooldown

Fires as `ACTIONBAR_UPDATE_COOLDOWN`.

No payload.

### ActionbarUpdateState

Fires as `ACTIONBAR_UPDATE_STATE`.

No payload.

### ActionbarUpdateUsable

Fires as `ACTIONBAR_UPDATE_USABLE`.

No payload.

### ActionRangeCheckUpdate

Fires as `ACTION_RANGE_CHECK_UPDATE`.

```lua
payload: slot: luaIndex, isInRange: bool, checksRange: bool
```

### ActionUsableChanged

Fires as `ACTION_USABLE_CHANGED`.

```lua
payload: changes: table
```

### PetBarUpdate

Fires as `PET_BAR_UPDATE`.

No payload.

### UpdateBonusActionbar

Fires as `UPDATE_BONUS_ACTIONBAR`.

No payload.

### UpdateExtraActionbar

Fires as `UPDATE_EXTRA_ACTIONBAR`.

No payload.

### UpdateMultiCastActionbar

Fires as `UPDATE_MULTI_CAST_ACTIONBAR`.

No payload.

### UpdateOverrideActionbar

Fires as `UPDATE_OVERRIDE_ACTIONBAR`.

No payload.
