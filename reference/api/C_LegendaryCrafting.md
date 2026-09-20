# C_LegendaryCrafting

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`20` functions - `4` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CloseRuneforgeInteraction

```lua
C_LegendaryCrafting.CloseRuneforgeInteraction()
```

### CraftRuneforgeLegendary

```lua
C_LegendaryCrafting.CraftRuneforgeLegendary(description: RuneforgeLegendaryCraftDescription)
```

### GetRuneforgeItemPreviewInfo

```lua
C_LegendaryCrafting.GetRuneforgeItemPreviewInfo(baseItem: ItemLocation, runeforgePowerID?: number, modifiers?: table) -> info?: RuneforgeItemPreviewInfo
```

### GetRuneforgeLegendaryComponentInfo

```lua
C_LegendaryCrafting.GetRuneforgeLegendaryComponentInfo(runeforgeLegendary: ItemLocation) -> componentInfo: RuneforgeLegendaryComponentInfo
```

### GetRuneforgeLegendaryCost

```lua
C_LegendaryCrafting.GetRuneforgeLegendaryCost(baseItem: ItemLocation) -> cost: table
```

### GetRuneforgeLegendaryCraftSpellID

```lua
C_LegendaryCrafting.GetRuneforgeLegendaryCraftSpellID() -> spellID: number
```

### GetRuneforgeLegendaryCurrencies

```lua
C_LegendaryCrafting.GetRuneforgeLegendaryCurrencies() -> currencies: table
```

### GetRuneforgeLegendaryUpgradeCost

```lua
C_LegendaryCrafting.GetRuneforgeLegendaryUpgradeCost(runeforgeLegendary: ItemLocation, upgradeItem: ItemLocation) -> cost: table
```

### GetRuneforgeModifierInfo

```lua
C_LegendaryCrafting.GetRuneforgeModifierInfo(baseItem: ItemLocation, powerID?: number, addedModifierIndex: luaIndex, modifiers: table) -> name: string, description: table
```

### GetRuneforgeModifiers

```lua
C_LegendaryCrafting.GetRuneforgeModifiers() -> modifiedReagentItemIDs: table
```

### GetRuneforgePowerInfo

```lua
C_LegendaryCrafting.GetRuneforgePowerInfo(runeforgePowerID: number) -> power: RuneforgePower
```

### GetRuneforgePowers

```lua
C_LegendaryCrafting.GetRuneforgePowers(baseItem?: ItemLocation, filter?: RuneforgePowerFilter) -> primaryRuneforgePowerIDs: table, otherRuneforgePowerIDs: table
```

### GetRuneforgePowersByClassSpecAndCovenant

```lua
C_LegendaryCrafting.GetRuneforgePowersByClassSpecAndCovenant(classID?: number, specID?: number, covenantID?: number, filter?: RuneforgePowerFilter) -> runeforgePowerIDs: table
```

### GetRuneforgePowerSlots

```lua
C_LegendaryCrafting.GetRuneforgePowerSlots(runeforgePowerID: number) -> slotNames: table
```

### IsRuneforgeLegendary

```lua
C_LegendaryCrafting.IsRuneforgeLegendary(item: ItemLocation) -> isRuneforgeLegendary: bool
```

### IsRuneforgeLegendaryMaxLevel

```lua
C_LegendaryCrafting.IsRuneforgeLegendaryMaxLevel(runeforgeLegendary: ItemLocation) -> isMaxLevel: bool
```

### IsUpgradeItemValidForRuneforgeLegendary

```lua
C_LegendaryCrafting.IsUpgradeItemValidForRuneforgeLegendary(runeforgeLegendary: ItemLocation, upgradeItem: ItemLocation) -> isValid: bool
```

### IsValidRuneforgeBaseItem

```lua
C_LegendaryCrafting.IsValidRuneforgeBaseItem(baseItem: ItemLocation) -> isValid: bool
```

### MakeRuneforgeCraftDescription

```lua
C_LegendaryCrafting.MakeRuneforgeCraftDescription(baseItem: ItemLocation, runeforgePowerID: number, modifiers: table) -> description: RuneforgeLegendaryCraftDescription
```

### UpgradeRuneforgeLegendary

```lua
C_LegendaryCrafting.UpgradeRuneforgeLegendary(runeforgeLegendary: ItemLocation, upgradeItem: ItemLocation)
```

## Events

### NewRuneforgePowerAdded

Fires as `NEW_RUNEFORGE_POWER_ADDED`.

```lua
payload: powerID: number
```

### RuneforgeLegendaryCraftingClosed

Fires as `RUNEFORGE_LEGENDARY_CRAFTING_CLOSED`.

No payload.

### RuneforgeLegendaryCraftingOpened

Fires as `RUNEFORGE_LEGENDARY_CRAFTING_OPENED`.

```lua
payload: isUpgrade: bool
```

### RuneforgePowerInfoUpdated

Fires as `RUNEFORGE_POWER_INFO_UPDATED`.

```lua
payload: powerID: number
```
