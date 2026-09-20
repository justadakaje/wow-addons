# C_WowEntitlementInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`0` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Events

### EntitlementDelivered

Fires as `ENTITLEMENT_DELIVERED`.

```lua
payload: entitlementType: WoWEntitlementType, textureID: number, name: string, payloadID?: number, showFancyToast: bool
```

### RafEntitlementDelivered

Fires as `RAF_ENTITLEMENT_DELIVERED`.

```lua
payload: entitlementType: WoWEntitlementType, textureID: number, name: string, payloadID?: number, showFancyToast: bool, rafVersion: RecruitAFriendRewardsVersion
```
