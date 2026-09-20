# C_GossipInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`20` functions - `7` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CloseGossip

```lua
C_GossipInfo.CloseGossip()
```

### ForceGossip

```lua
C_GossipInfo.ForceGossip() -> forceGossip: bool
```

### GetActiveQuests

```lua
C_GossipInfo.GetActiveQuests() -> info: table
```

### GetAvailableQuests

```lua
C_GossipInfo.GetAvailableQuests() -> info: table
```

### GetCompletedOptionDescriptionString

```lua
C_GossipInfo.GetCompletedOptionDescriptionString() -> description?: string
```

### GetCustomGossipDescriptionString

```lua
C_GossipInfo.GetCustomGossipDescriptionString() -> description?: string
```

### GetFriendshipReputation

```lua
C_GossipInfo.GetFriendshipReputation(friendshipFactionID: number) -> reputationInfo: FriendshipReputationInfo
```

### GetFriendshipReputationRanks

```lua
C_GossipInfo.GetFriendshipReputationRanks(friendshipFactionID: number) -> rankInfo: FriendshipReputationRankInfo
```

### GetNumActiveQuests

```lua
C_GossipInfo.GetNumActiveQuests() -> numQuests: number
```

### GetNumAvailableQuests

```lua
C_GossipInfo.GetNumAvailableQuests() -> numQuests: number
```

### GetOptions

```lua
C_GossipInfo.GetOptions() -> info: table
```

### GetOptionUIWidgetSetsAndTypesByOptionID

```lua
C_GossipInfo.GetOptionUIWidgetSetsAndTypesByOptionID(gossipOptionID: number) -> gossipOptionUIWidgetSetsAndTypes?: table
```

### GetPoiForUiMapID

```lua
C_GossipInfo.GetPoiForUiMapID(uiMapID: number) -> gossipPoiID?: number
```

### GetPoiInfo

```lua
C_GossipInfo.GetPoiInfo(uiMapID: number, gossipPoiID: number) -> gossipPoiInfo?: GossipPoiInfo
```

### GetText

```lua
C_GossipInfo.GetText() -> gossipText: cstring
```

### RefreshOptions

```lua
C_GossipInfo.RefreshOptions()
```

### SelectActiveQuest

```lua
C_GossipInfo.SelectActiveQuest(optionID: number)
```

### SelectAvailableQuest

```lua
C_GossipInfo.SelectAvailableQuest(optionID: number)
```

### SelectOption

```lua
C_GossipInfo.SelectOption(optionID: number, text?: cstring, confirmed?: bool)
```

### SelectOptionByIndex

```lua
C_GossipInfo.SelectOptionByIndex(optionID: number, text?: cstring, confirmed?: bool)
```

## Events

### DynamicGossipPoiUpdated

Fires as `DYNAMIC_GOSSIP_POI_UPDATED`.

No payload.

### GossipClosed

Fires as `GOSSIP_CLOSED`.

```lua
payload: interactionIsContinuing: bool
```

### GossipConfirm

Fires as `GOSSIP_CONFIRM`.

```lua
payload: gossipID: number, text: string, cost: WOWMONEY
```

### GossipConfirmCancel

Fires as `GOSSIP_CONFIRM_CANCEL`.

No payload.

### GossipEnterCode

Fires as `GOSSIP_ENTER_CODE`.

```lua
payload: gossipID: number
```

### GossipOptionsRefreshed

Fires as `GOSSIP_OPTIONS_REFRESHED`.

No payload.

### GossipShow

Fires as `GOSSIP_SHOW`.

```lua
payload: uiTextureKit?: textureKit
```
