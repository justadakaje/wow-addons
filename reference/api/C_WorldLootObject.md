# C_WorldLootObject

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`8` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### DoesSlotMatchInventoryType

```lua
C_WorldLootObject.DoesSlotMatchInventoryType(slot: number, inventoryType: InventoryType) -> matches: bool
```

### GetWorldLootObjectDistanceSquared

```lua
C_WorldLootObject.GetWorldLootObjectDistanceSquared(unitToken: UnitToken) -> distanceSquared?: number
```

### GetWorldLootObjectInfo

```lua
C_WorldLootObject.GetWorldLootObjectInfo(unitToken: UnitToken) -> info: WorldLootObjectInfo
```

### GetWorldLootObjectInfoByGUID

```lua
C_WorldLootObject.GetWorldLootObjectInfoByGUID(objectGUID: WOWGUID) -> info: WorldLootObjectInfo
```

### IsWorldLootObject

```lua
C_WorldLootObject.IsWorldLootObject(unitToken: UnitToken) -> isWorldLootObject: bool
```

### IsWorldLootObjectByGUID

```lua
C_WorldLootObject.IsWorldLootObjectByGUID(guid: WOWGUID) -> isWorldLootObject: bool
```

### IsWorldLootObjectInRange

```lua
C_WorldLootObject.IsWorldLootObjectInRange(unitToken: UnitToken) -> isWorldLootObjectInRange: bool
```

### OnWorldLootObjectClick

```lua
C_WorldLootObject.OnWorldLootObjectClick(unitToken: UnitToken, isLeftClick: bool)
```

## Events

### WorldLootObjectInfoUpdated

Fires as `WORLD_LOOT_OBJECT_INFO_UPDATED`.

```lua
payload: guid: WOWGUID
```
