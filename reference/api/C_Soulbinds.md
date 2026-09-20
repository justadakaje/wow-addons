# C_Soulbinds

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`39` functions - `13` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ActivateSoulbind

```lua
C_Soulbinds.ActivateSoulbind(soulbindID: number)
```

### CanActivateSoulbind

```lua
C_Soulbinds.CanActivateSoulbind(soulbindID: number) -> result: bool, errorDescription?: cstring
```

### CanModifySoulbind

```lua
C_Soulbinds.CanModifySoulbind() -> result: bool
```

### CanResetConduitsInSoulbind

```lua
C_Soulbinds.CanResetConduitsInSoulbind(soulbindID: number) -> result: bool, errorDescription?: cstring
```

### CanSwitchActiveSoulbindTreeBranch

```lua
C_Soulbinds.CanSwitchActiveSoulbindTreeBranch() -> result: bool
```

### CloseUI

```lua
C_Soulbinds.CloseUI()
```

### CommitPendingConduitsInSoulbind

```lua
C_Soulbinds.CommitPendingConduitsInSoulbind(soulbindID: number)
```

### FindNodeIDActuallyInstalled

```lua
C_Soulbinds.FindNodeIDActuallyInstalled(soulbindID: number, conduitID: number) -> nodeID: number
```

### FindNodeIDAppearingInstalled

```lua
C_Soulbinds.FindNodeIDAppearingInstalled(soulbindID: number, conduitID: number) -> nodeID: number
```

### FindNodeIDPendingInstall

```lua
C_Soulbinds.FindNodeIDPendingInstall(soulbindID: number, conduitID: number) -> nodeID: number
```

### FindNodeIDPendingUninstall

```lua
C_Soulbinds.FindNodeIDPendingUninstall(soulbindID: number, conduitID: number) -> nodeID: number
```

### GetActiveSoulbindID

```lua
C_Soulbinds.GetActiveSoulbindID() -> soulbindID: number
```

### GetConduitCollection

```lua
C_Soulbinds.GetConduitCollection(conduitType: SoulbindConduitType) -> collectionData: table
```

### GetConduitCollectionCount

```lua
C_Soulbinds.GetConduitCollectionCount() -> count: number
```

### GetConduitCollectionData

```lua
C_Soulbinds.GetConduitCollectionData(conduitID: number) -> collectionData?: ConduitCollectionData
```

### GetConduitCollectionDataAtCursor

```lua
C_Soulbinds.GetConduitCollectionDataAtCursor() -> collectionData?: ConduitCollectionData
```

### GetConduitCollectionDataByVirtualID

```lua
C_Soulbinds.GetConduitCollectionDataByVirtualID(virtualID: number) -> collectionData?: ConduitCollectionData
```

### GetConduitDisplayed

```lua
C_Soulbinds.GetConduitDisplayed(nodeID: number) -> conduitID: number
```

### GetConduitHyperlink

```lua
C_Soulbinds.GetConduitHyperlink(conduitID: number, rank: number) -> link: cstring
```

### GetConduitIDPendingInstall

```lua
C_Soulbinds.GetConduitIDPendingInstall(nodeID: number) -> conduitID: number
```

### GetConduitQuality

```lua
C_Soulbinds.GetConduitQuality(conduitID: number, rank: number) -> quality: number
```

### GetConduitRank

```lua
C_Soulbinds.GetConduitRank(conduitID: number) -> conduitRank: number
```

### GetConduitSpellID

```lua
C_Soulbinds.GetConduitSpellID(conduitID: number, conduitRank: number) -> spellID: number
```

### GetInstalledConduitID

```lua
C_Soulbinds.GetInstalledConduitID(nodeID: number) -> conduitID: number
```

### GetNode

```lua
C_Soulbinds.GetNode(nodeID: number) -> node: SoulbindNode
```

### GetSoulbindData

```lua
C_Soulbinds.GetSoulbindData(soulbindID: number) -> data: SoulbindData
```

### GetSpecsAssignedToSoulbind

```lua
C_Soulbinds.GetSpecsAssignedToSoulbind(soulbindID: number) -> specIDs: table
```

### GetTree

```lua
C_Soulbinds.GetTree(treeID: number) -> tree: SoulbindTree
```

### HasAnyInstalledConduitInSoulbind

```lua
C_Soulbinds.HasAnyInstalledConduitInSoulbind(soulbindID: number) -> result: bool
```

### HasAnyPendingConduits

```lua
C_Soulbinds.HasAnyPendingConduits() -> result: bool
```

### HasPendingConduitsInSoulbind

```lua
C_Soulbinds.HasPendingConduitsInSoulbind(soulbindID: number) -> result: bool
```

### IsConduitInstalled

```lua
C_Soulbinds.IsConduitInstalled(nodeID: number) -> result: bool
```

### IsConduitInstalledInSoulbind

```lua
C_Soulbinds.IsConduitInstalledInSoulbind(soulbindID: number, conduitID: number) -> result: bool
```

### IsItemConduitByItemInfo

```lua
C_Soulbinds.IsItemConduitByItemInfo(itemInfo: ItemInfo) -> result: bool
```

### IsNodePendingModify

```lua
C_Soulbinds.IsNodePendingModify(nodeID: number) -> result: bool
```

### IsUnselectedConduitPendingInSoulbind

```lua
C_Soulbinds.IsUnselectedConduitPendingInSoulbind(soulbindID: number) -> result: bool
```

### ModifyNode

```lua
C_Soulbinds.ModifyNode(nodeID: number, conduitID: number, type: SoulbindConduitTransactionType)
```

### SelectNode

```lua
C_Soulbinds.SelectNode(nodeID: number)
```

### UnmodifyNode

```lua
C_Soulbinds.UnmodifyNode(nodeID: number)
```

## Events

### SoulbindActivated

Fires as `SOULBIND_ACTIVATED`.

```lua
payload: soulbindID: number
```

### SoulbindConduitCollectionCleared

Fires as `SOULBIND_CONDUIT_COLLECTION_CLEARED`.

No payload.

### SoulbindConduitCollectionRemoved

Fires as `SOULBIND_CONDUIT_COLLECTION_REMOVED`.

```lua
payload: conduitID: number
```

### SoulbindConduitCollectionUpdated

Fires as `SOULBIND_CONDUIT_COLLECTION_UPDATED`.

```lua
payload: collectionData: ConduitCollectionData
```

### SoulbindConduitInstalled

Fires as `SOULBIND_CONDUIT_INSTALLED`.

```lua
payload: nodeID: number, data: SoulbindConduitData
```

### SoulbindConduitUninstalled

Fires as `SOULBIND_CONDUIT_UNINSTALLED`.

```lua
payload: nodeID: number, data: SoulbindConduitData
```

### SoulbindForgeInteractionEnded

Fires as `SOULBIND_FORGE_INTERACTION_ENDED`.

No payload.

### SoulbindForgeInteractionStarted

Fires as `SOULBIND_FORGE_INTERACTION_STARTED`.

No payload.

### SoulbindNodeLearned

Fires as `SOULBIND_NODE_LEARNED`.

```lua
payload: nodeID: number
```

### SoulbindNodeUnlearned

Fires as `SOULBIND_NODE_UNLEARNED`.

```lua
payload: nodeID: number
```

### SoulbindNodeUpdated

Fires as `SOULBIND_NODE_UPDATED`.

```lua
payload: nodeID: number
```

### SoulbindPathChanged

Fires as `SOULBIND_PATH_CHANGED`.

No payload.

### SoulbindPendingConduitChanged

Fires as `SOULBIND_PENDING_CONDUIT_CHANGED`.

```lua
payload: nodeID: number, conduitID: number
```
