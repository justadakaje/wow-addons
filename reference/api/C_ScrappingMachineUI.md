# C_ScrappingMachineUI

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`11` functions - `4` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CloseScrappingMachine

```lua
C_ScrappingMachineUI.CloseScrappingMachine()
```

### DropPendingScrapItemFromCursor

```lua
C_ScrappingMachineUI.DropPendingScrapItemFromCursor(index: number)
```

### GetCurrentPendingScrapItemLocationByIndex

```lua
C_ScrappingMachineUI.GetCurrentPendingScrapItemLocationByIndex(index: number) -> itemLoc: ItemLocation
```

### GetScrappingMachineName

```lua
C_ScrappingMachineUI.GetScrappingMachineName() -> name: string
```

### GetScrapSpellID

```lua
C_ScrappingMachineUI.GetScrapSpellID() -> spellID: number
```

### HasScrappableItems

```lua
C_ScrappingMachineUI.HasScrappableItems() -> hasScrappableItems: bool
```

### RemoveAllScrapItems

```lua
C_ScrappingMachineUI.RemoveAllScrapItems()
```

### RemoveCurrentScrappingItem

```lua
C_ScrappingMachineUI.RemoveCurrentScrappingItem()
```

### RemoveItemToScrap

```lua
C_ScrappingMachineUI.RemoveItemToScrap(index: number)
```

### ScrapItems

```lua
C_ScrappingMachineUI.ScrapItems()
```

### ValidateScrappingList

```lua
C_ScrappingMachineUI.ValidateScrappingList()
```

## Events

### ScrappingMachineItemAdded

Fires as `SCRAPPING_MACHINE_ITEM_ADDED`.

```lua
payload: index: number
```

### ScrappingMachineItemRemoved

Fires as `SCRAPPING_MACHINE_ITEM_REMOVED`.

```lua
payload: index: number
```

### ScrappingMachinePendingItemChanged

Fires as `SCRAPPING_MACHINE_PENDING_ITEM_CHANGED`.

No payload.

### ScrappingMachineScrappingFinished

Fires as `SCRAPPING_MACHINE_SCRAPPING_FINISHED`.

No payload.
