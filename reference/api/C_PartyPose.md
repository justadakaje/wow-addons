# C_PartyPose

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`4` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ExtraAction

```lua
C_PartyPose.ExtraAction(partyPoseID: number)
```

### GetPartyPoseInfoByID

```lua
C_PartyPose.GetPartyPoseInfoByID(mapID: number) -> info: PartyPoseInfo
```

### GetPartyPoseInfoByMapID

```lua
C_PartyPose.GetPartyPoseInfoByMapID(mapID: number) -> info: PartyPoseInfo
```

### HasExtraAction

```lua
C_PartyPose.HasExtraAction(partyPoseID: number) -> hasExtraAction: bool
```

## Events

### ShowPartyPoseUI

Fires as `SHOW_PARTY_POSE_UI`.

```lua
payload: mapID: number, won: bool
```
