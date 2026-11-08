# C_BehavioralMessaging

WoW: Forever 1.60.1 (build 70862) - Interface 16001

`1` functions - `1` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### SendNotificationReceipt

```lua
C_BehavioralMessaging.SendNotificationReceipt(dbId: NotificationDbId, openTimeSeconds: number, readTimeSeconds: number)
```

## Events

### BehavioralNotification

Fires as `BEHAVIORAL_NOTIFICATION`.

```lua
payload: notificationType: string, dbId: NotificationDbId
```
