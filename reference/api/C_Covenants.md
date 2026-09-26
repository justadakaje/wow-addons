# C_Covenants

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`3` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetActiveCovenantID

```lua
C_Covenants.GetActiveCovenantID() -> covenantID: number
```

### GetCovenantData

```lua
C_Covenants.GetCovenantData(covenantID: number) -> data?: CovenantData
```

### GetCovenantIDs

```lua
C_Covenants.GetCovenantIDs() -> covenantID: table
```

## Events

### CovenantChosen

Fires as `COVENANT_CHOSEN`.

```lua
payload: covenantID: number
```
