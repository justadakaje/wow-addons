# C_Secrets

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`27` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanCompareUnitTokens

```lua
C_Secrets.CanCompareUnitTokens(unit1: UnitToken, unit2: UnitToken) -> isUnitComparisonPermitted: bool
```

### GetPowerTypeSecrecy

```lua
C_Secrets.GetPowerTypeSecrecy(powerType: PowerType) -> secrecy: SecrecyLevel
```

### GetSpellAuraSecrecy

```lua
C_Secrets.GetSpellAuraSecrecy(spellIdentifier: SpellIdentifier) -> secrecy: SecrecyLevel
```

### GetSpellCastSecrecy

```lua
C_Secrets.GetSpellCastSecrecy(spellIdentifier: SpellIdentifier) -> secrecy: SecrecyLevel
```

### GetSpellCooldownSecrecy

```lua
C_Secrets.GetSpellCooldownSecrecy(spellIdentifier: SpellIdentifier) -> secrecy: SecrecyLevel
```

### HasSecretRestrictions

```lua
C_Secrets.HasSecretRestrictions() -> hasSecretRestrictions: bool
```

### ShouldActionCooldownBeSecret

```lua
C_Secrets.ShouldActionCooldownBeSecret(actionID: luaIndex) -> isCooldownSecret: bool
```

### ShouldAurasBeSecret

```lua
C_Secrets.ShouldAurasBeSecret() -> hasSecretAuras: bool
```

### ShouldCooldownsBeSecret

```lua
C_Secrets.ShouldCooldownsBeSecret() -> hasSecretCooldowns: bool
```

### ShouldSpellAuraBeSecret

```lua
C_Secrets.ShouldSpellAuraBeSecret(spellIdentifier: SpellIdentifier) -> isAuraSecret: bool
```

### ShouldSpellBookItemCooldownBeSecret

```lua
C_Secrets.ShouldSpellBookItemCooldownBeSecret(spellBookItemSlotIndex: luaIndex, spellBookItemSpellBank: SpellBookSpellBank) -> isCooldownSecret: bool
```

### ShouldSpellCooldownBeSecret

```lua
C_Secrets.ShouldSpellCooldownBeSecret(spellIdentifier: SpellIdentifier) -> isCooldownSecret: bool
```

### ShouldTotemSlotBeSecret

```lua
C_Secrets.ShouldTotemSlotBeSecret(slot: luaIndex) -> isTotemSecret: bool
```

### ShouldTotemSpellBeSecret

```lua
C_Secrets.ShouldTotemSpellBeSecret(spellID: number) -> isTotemSecret: bool
```

### ShouldUnitAuraIndexBeSecret

```lua
C_Secrets.ShouldUnitAuraIndexBeSecret(unit: UnitToken, index: luaIndex, filter?: AuraFilters) -> isAuraSecret: bool
```

### ShouldUnitAuraInstanceBeSecret

```lua
C_Secrets.ShouldUnitAuraInstanceBeSecret(unit: UnitToken, auraInstanceID: number) -> isAuraSecret: bool
```

### ShouldUnitAuraSlotBeSecret

```lua
C_Secrets.ShouldUnitAuraSlotBeSecret(unit: UnitToken, slot: number) -> isAuraSecret: bool
```

### ShouldUnitComparisonBeSecret

```lua
C_Secrets.ShouldUnitComparisonBeSecret(unit1: UnitToken, unit2: UnitToken) -> isUnitComparisonSecret: bool
```

### ShouldUnitHealthMaxBeSecret

```lua
C_Secrets.ShouldUnitHealthMaxBeSecret(unit: UnitToken) -> isUnitHealthMaxSecret: bool
```

### ShouldUnitIdentityBeSecret

```lua
C_Secrets.ShouldUnitIdentityBeSecret(unit: UnitToken) -> isUnitIdentitySecret: bool
```

### ShouldUnitPowerBeSecret

```lua
C_Secrets.ShouldUnitPowerBeSecret(unit: UnitToken, powerType?: PowerType) -> isUnitPowerSecret: bool
```

### ShouldUnitPowerMaxBeSecret

```lua
C_Secrets.ShouldUnitPowerMaxBeSecret(unit: UnitToken, powerType?: PowerType) -> isUnitPowerMaxSecret: bool
```

### ShouldUnitSpellCastBeSecret

```lua
C_Secrets.ShouldUnitSpellCastBeSecret(unit: UnitToken, spellIdentifier: SpellIdentifier) -> isSpellCastSecret: bool
```

### ShouldUnitSpellCastingBeSecret

```lua
C_Secrets.ShouldUnitSpellCastingBeSecret(unit: UnitToken) -> isSpellCastingSecret: bool
```

### ShouldUnitStatsBeSecret

```lua
C_Secrets.ShouldUnitStatsBeSecret() -> hasSecretStats: bool
```

### ShouldUnitThreatStateBeSecret

```lua
C_Secrets.ShouldUnitThreatStateBeSecret(unit: UnitToken, mobUnit?: UnitToken) -> isUnitThreatSecret: bool
```

### ShouldUnitThreatValuesBeSecret

```lua
C_Secrets.ShouldUnitThreatValuesBeSecret(unit: UnitToken, mobUnit: UnitToken) -> isUnitThreatSecret: bool
```
