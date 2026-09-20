# C_Traits

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`53` functions - `15` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanEditConfig

```lua
C_Traits.CanEditConfig(configID: number) -> canEdit: bool, errorMessage: cstring
```

### CanPurchaseRank

```lua
C_Traits.CanPurchaseRank(configID: number, nodeID: number, nodeEntryID: number) -> canPurchase: bool
```

### CanRefundRank

```lua
C_Traits.CanRefundRank(configID: number, nodeID: number) -> canRefund: bool
```

### CascadeRepurchaseRanks

```lua
C_Traits.CascadeRepurchaseRanks(configID: number, nodeID: number, entryID?: number) -> success: bool
```

### ClearCascadeRepurchaseHistory

```lua
C_Traits.ClearCascadeRepurchaseHistory(configID: number)
```

### CloseTraitSystemInteraction

```lua
C_Traits.CloseTraitSystemInteraction()
```

### CommitConfig

```lua
C_Traits.CommitConfig(configID: number) -> success: bool
```

### ConfigHasStagedChanges

```lua
C_Traits.ConfigHasStagedChanges(configID: number) -> hasChanges: bool
```

### GenerateImportString

```lua
C_Traits.GenerateImportString(configID: number) -> importString: string
```

### GenerateInspectImportString

```lua
C_Traits.GenerateInspectImportString(target: cstring) -> importString: string
```

### GetConditionInfo

```lua
C_Traits.GetConditionInfo(configID: number, condID: number) -> condInfo: TraitCondInfo
```

### GetConfigIDBySystemID

```lua
C_Traits.GetConfigIDBySystemID(systemID: number) -> configID: number
```

### GetConfigIDByTreeID

```lua
C_Traits.GetConfigIDByTreeID(treeID: number) -> configID: number
```

### GetConfigInfo

```lua
C_Traits.GetConfigInfo(configID: number) -> configInfo: TraitConfigInfo
```

### GetConfigsByType

```lua
C_Traits.GetConfigsByType(configType: TraitConfigType) -> configIDs: table
```

### GetConfigVariationID

```lua
C_Traits.GetConfigVariationID(systemID: number) -> variationID: number
```

### GetDefinitionInfo

```lua
C_Traits.GetDefinitionInfo(definitionID: number) -> definitionInfo: TraitDefinitionInfo
```

### GetEntryInfo

```lua
C_Traits.GetEntryInfo(configID: number, entryID: number) -> entryInfo: TraitEntryInfo
```

### GetGroupCurrencyInfo

```lua
C_Traits.GetGroupCurrencyInfo(configID: number, groupIDs: table) -> groupCurrencyInfos: table
```

### GetGroupDisplayInfoByTreeID

```lua
C_Traits.GetGroupDisplayInfoByTreeID(treeID: number) -> displayInfos: table
```

### GetIncreasedTraitData

```lua
C_Traits.GetIncreasedTraitData(nodeID: number, entryID: number) -> itemName: table
```

### GetLoadoutSerializationVersion

```lua
C_Traits.GetLoadoutSerializationVersion() -> serializationVersion: number
```

### GetMaxAvailableTraitCurrency

```lua
C_Traits.GetMaxAvailableTraitCurrency(traitCurrencyID: number, limitBySourcedMax: bool) -> maxAvailable: number
```

### GetNodeCost

```lua
C_Traits.GetNodeCost(configID: number, nodeID: number) -> costs: table
```

### GetNodeInfo

```lua
C_Traits.GetNodeInfo(configID: number, nodeID: number) -> nodeInfo: TraitNodeInfo
```

### GetStagedChanges

```lua
C_Traits.GetStagedChanges(configID: number) -> nodeIDsWithPurchases: table, nodeIDsWithRefunds: table, nodeIDsWithSelectionSwaps: table
```

### GetStagedChangesCost

```lua
C_Traits.GetStagedChangesCost(configID: number) -> costs: table
```

### GetSubTreeInfo

```lua
C_Traits.GetSubTreeInfo(configID: number, subTreeID: number) -> subTreeInfo: TraitSubTreeInfo
```

### GetSystemIDByTreeID

```lua
C_Traits.GetSystemIDByTreeID(treeID: number) -> systemID: number
```

### GetTraitCurrencyForAchievement

```lua
C_Traits.GetTraitCurrencyForAchievement(traitCurrencyID: number, achievementID: number) -> amount: number
```

### GetTraitCurrencyInfo

```lua
C_Traits.GetTraitCurrencyInfo(traitCurrencyID: number) -> flags: number, type: number, currencyTypesID?: number, icon?: number
```

### GetTraitDescription

```lua
C_Traits.GetTraitDescription(entryID: number, rank: number) -> description: string
```

### GetTraitSystemFlags

```lua
C_Traits.GetTraitSystemFlags(configID: number) -> flags: number
```

### GetTraitSystemWidgetSetID

```lua
C_Traits.GetTraitSystemWidgetSetID(configID: number) -> uiWidgetSetID: number
```

### GetTreeCurrencyInfo

```lua
C_Traits.GetTreeCurrencyInfo(configID: number, treeID: number, excludeStagedChanges: bool) -> treeCurrencyInfo: table
```

### GetTreeHash

```lua
C_Traits.GetTreeHash(treeID: number) -> result: table
```

### GetTreeInfo

```lua
C_Traits.GetTreeInfo(configID: number, treeID: number) -> treeInfo: TraitTreeInfo
```

### GetTreeNodes

```lua
C_Traits.GetTreeNodes(treeID: number) -> nodeIDs: table
```

### HasValidInspectData

```lua
C_Traits.HasValidInspectData() -> hasValidInspectData: bool
```

### IsReadyForCommit

```lua
C_Traits.IsReadyForCommit() -> isReadyForCommit: bool
```

### PurchaseAllRanks

```lua
C_Traits.PurchaseAllRanks(configID: number, nodeID: number, ignoreCost: bool) -> success: bool
```

### PurchaseRank

```lua
C_Traits.PurchaseRank(configID: number, nodeID: number) -> success: bool
```

### RefundAllRanks

```lua
C_Traits.RefundAllRanks(configID: number, nodeID: number) -> success: bool
```

### RefundRank

```lua
C_Traits.RefundRank(configID: number, nodeID: number, clearEdges?: bool) -> success: bool
```

### ResetTree

```lua
C_Traits.ResetTree(configID: number, treeID: number) -> success: bool
```

### ResetTreeByCurrency

```lua
C_Traits.ResetTreeByCurrency(configID: number, treeID: number, traitCurrencyID: number) -> success: bool
```

### RollbackConfig

```lua
C_Traits.RollbackConfig(configID: number) -> success: bool
```

### SetSelection

```lua
C_Traits.SetSelection(configID: number, nodeID: number, nodeEntryID?: number, clearEdges?: bool) -> success: bool
```

### StageConfig

```lua
C_Traits.StageConfig(configID: number) -> success: bool
```

### TalentTestUnlearnSpells

```lua
C_Traits.TalentTestUnlearnSpells()
```

### TryPurchaseAllRanks

```lua
C_Traits.TryPurchaseAllRanks(configID: number, nodeID: number) -> success: bool
```

### TryPurchaseToNode

```lua
C_Traits.TryPurchaseToNode(configID: number, nodeID: number) -> success: bool
```

### TryRefundToNode

```lua
C_Traits.TryRefundToNode(configID: number, nodeID: number, entryID: number) -> success: bool
```

## Events

### ConfigCommitFailed

Fires as `CONFIG_COMMIT_FAILED`.

```lua
payload: configID: number
```

### TraitCondInfoChanged

Fires as `TRAIT_COND_INFO_CHANGED`.

```lua
payload: condID: number
```

### TraitConfigCreated

Fires as `TRAIT_CONFIG_CREATED`.

```lua
payload: configInfo: TraitConfigInfo
```

### TraitConfigDeleted

Fires as `TRAIT_CONFIG_DELETED`.

```lua
payload: configID: number
```

### TraitConfigListUpdated

Fires as `TRAIT_CONFIG_LIST_UPDATED`.

No payload.

### TraitConfigUpdated

Fires as `TRAIT_CONFIG_UPDATED`.

```lua
payload: configID: number
```

### TraitNodeChanged

Fires as `TRAIT_NODE_CHANGED`.

```lua
payload: nodeID: number
```

### TraitNodeChangedPartial

Fires as `TRAIT_NODE_CHANGED_PARTIAL`.

```lua
payload: ID: number, info: TraitNodeInfoPartial
```

### TraitNodeEntryUpdated

Fires as `TRAIT_NODE_ENTRY_UPDATED`.

```lua
payload: nodeEntryID: number
```

### TraitSubTreeChanged

Fires as `TRAIT_SUB_TREE_CHANGED`.

```lua
payload: subTreeID: number
```

### TraitSystemInteractionStarted

Fires as `TRAIT_SYSTEM_INTERACTION_STARTED`.

```lua
payload: treeID: number
```

### TraitSystemNpcClosed

Fires as `TRAIT_SYSTEM_NPC_CLOSED`.

No payload.

### TraitTreeChanged

Fires as `TRAIT_TREE_CHANGED`.

```lua
payload: treeID: number
```

### TraitTreeCurrencyInfoUpdated

Fires as `TRAIT_TREE_CURRENCY_INFO_UPDATED`.

```lua
payload: treeID: number
```

### TryPurchaseToNodePartialSuccess

Fires as `TRY_PURCHASE_TO_NODE_PARTIAL_SUCCESS`.

```lua
payload: nodeFinishedOn: number
```
