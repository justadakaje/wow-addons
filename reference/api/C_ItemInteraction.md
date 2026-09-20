# C_ItemInteraction

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`10` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ClearPendingItem

```lua
C_ItemInteraction.ClearPendingItem()
```

### CloseUI

```lua
C_ItemInteraction.CloseUI()
```

### GetChargeInfo

```lua
C_ItemInteraction.GetChargeInfo() -> chargeInfo: ItemInteractionChargeInfo
```

### GetItemConversionCurrencyCost

```lua
C_ItemInteraction.GetItemConversionCurrencyCost(item: ItemLocation) -> conversionCost: ConversionCurrencyCost
```

### GetItemInteractionInfo

```lua
C_ItemInteraction.GetItemInteractionInfo() -> info?: ItemInteractionFrameInfo
```

### GetItemInteractionSpellId

```lua
C_ItemInteraction.GetItemInteractionSpellId() -> spellId: number
```

### InitializeFrame

```lua
C_ItemInteraction.InitializeFrame()
```

### PerformItemInteraction

```lua
C_ItemInteraction.PerformItemInteraction()
```

### Reset

```lua
C_ItemInteraction.Reset()
```

### SetPendingItem

```lua
C_ItemInteraction.SetPendingItem(item?: ItemLocation) -> success: bool
```

## Events

### ItemInteractionChargeInfoUpdated

Fires as `ITEM_INTERACTION_CHARGE_INFO_UPDATED`.

No payload.

### ItemInteractionItemSelectionUpdated

Fires as `ITEM_INTERACTION_ITEM_SELECTION_UPDATED`.

```lua
payload: itemLocation?: ItemLocation
```
