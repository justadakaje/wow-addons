# Expansion

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`23` functions - `3` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanUpgradeToCurrentExpansion

```lua
CanUpgradeToCurrentExpansion() -> canUpgradeExpansion: bool
```

### DoesCurrentLocaleSellExpansionLevels

```lua
DoesCurrentLocaleSellExpansionLevels() -> regionSellsExpansions: bool
```

### GetAccountExpansionLevel

```lua
GetAccountExpansionLevel() -> expansionLevel: number
```

### GetClientDisplayExpansionLevel

```lua
GetClientDisplayExpansionLevel() -> expansionLevel: number
```

### GetCurrentRegionName

```lua
GetCurrentRegionName() -> regionName: cstring
```

### GetExpansionDisplayInfo

```lua
GetExpansionDisplayInfo(expansionLevel: number, desiredReleaseType?: ReleaseType) -> info?: ExpansionDisplayInfo
```

### GetExpansionForLevel

```lua
GetExpansionForLevel(playerLevel: number) -> expansionLevel: number
```

### GetExpansionLevel

```lua
GetExpansionLevel() -> expansionLevel: number
```

### GetExpansionTrialInfo

```lua
GetExpansionTrialInfo() -> isExpansionTrialAccount: bool, expansionTrialRemainingSeconds?: time_t
```

### GetMaximumExpansionLevel

```lua
GetMaximumExpansionLevel() -> expansionLevel: number
```

### GetMaxLevelForExpansionLevel

```lua
GetMaxLevelForExpansionLevel(expansionLevel: number) -> maxLevel: number
```

### GetMaxLevelForLatestExpansion

```lua
GetMaxLevelForLatestExpansion() -> maxLevel: number
```

### GetMaxLevelForPlayerExpansion

```lua
GetMaxLevelForPlayerExpansion() -> maxLevel: number
```

### GetMinimumExpansionLevel

```lua
GetMinimumExpansionLevel() -> expansionLevel: number
```

### GetNumExpansions

```lua
GetNumExpansions() -> numExpansions: number
```

### GetServerExpansionLevel

```lua
GetServerExpansionLevel() -> serverExpansionLevel: number
```

### GetUpgradeExpansionLevel

```lua
GetUpgradeExpansionLevel() -> upgradeExpansionLevel: number
```

### IsDemonHunterAvailable

```lua
IsDemonHunterAvailable() -> available: bool
```

### IsExpansionTrial

```lua
IsExpansionTrial() -> isExpansionTrialAccount: bool
```

### IsTrialAccount

```lua
IsTrialAccount() -> isTrialAccount: bool
```

### IsVeteranTrialAccount

```lua
IsVeteranTrialAccount() -> isVeteranTrialAccount: bool
```

### SendSubscriptionInterstitialResponse

```lua
SendSubscriptionInterstitialResponse(response: SubscriptionInterstitialResponseType)
```

### ShouldShowExpansionUpgradeBanner

```lua
ShouldShowExpansionUpgradeBanner() -> showUpgradeBanner: bool
```

## Events

### MaxExpansionLevelUpdated

Fires as `MAX_EXPANSION_LEVEL_UPDATED`.

No payload.

### MinExpansionLevelUpdated

Fires as `MIN_EXPANSION_LEVEL_UPDATED`.

No payload.

### ShowSubscriptionInterstitial

Fires as `SHOW_SUBSCRIPTION_INTERSTITIAL`.

```lua
payload: type: SubscriptionInterstitialType
```
