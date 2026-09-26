# C_TaxiMap

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`3` functions - `3` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetAllTaxiNodes

```lua
C_TaxiMap.GetAllTaxiNodes(uiMapID: number) -> taxiNodes: table
```

### GetTaxiNodesForMap

```lua
C_TaxiMap.GetTaxiNodesForMap(uiMapID: number) -> mapTaxiNodes: table
```

### ShouldMapShowTaxiNodes

```lua
C_TaxiMap.ShouldMapShowTaxiNodes(uiMapID: number) -> shouldShowNodes: bool
```

## Events

### TaximapClosed

Fires as `TAXIMAP_CLOSED`.

No payload.

### TaximapOpened

Fires as `TAXIMAP_OPENED`.

```lua
payload: system: number
```

### TaxiNodeStatusChanged

Fires as `TAXI_NODE_STATUS_CHANGED`.

No payload.
