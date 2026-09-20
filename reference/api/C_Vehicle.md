# C_Vehicle

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`0` functions - `10` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Events

### PlayerGainsVehicleData

Fires as `PLAYER_GAINS_VEHICLE_DATA`.

```lua
payload: unitTarget: UnitTokenVariant, vehicleUIIndicatorID: number
```

### PlayerLosesVehicleData

Fires as `PLAYER_LOSES_VEHICLE_DATA`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitEnteredVehicle

Fires as `UNIT_ENTERED_VEHICLE`.

```lua
payload: unitTarget: UnitTokenVariant, showVehicleFrame: bool, isControlSeat: bool, vehicleUIIndicatorID: number, vehicleGUID: WOWGUID, mayChooseExit: bool, hasPitch: bool
```

### UnitEnteringVehicle

Fires as `UNIT_ENTERING_VEHICLE`.

```lua
payload: unitTarget: UnitTokenVariant, showVehicleFrame: bool, isControlSeat: bool, vehicleUIIndicatorID: number, vehicleGUID: WOWGUID, mayChooseExit: bool, hasPitch: bool
```

### UnitExitedVehicle

Fires as `UNIT_EXITED_VEHICLE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### UnitExitingVehicle

Fires as `UNIT_EXITING_VEHICLE`.

```lua
payload: unitTarget: UnitTokenVariant
```

### VehicleAngleShow

Fires as `VEHICLE_ANGLE_SHOW`.

```lua
payload: shouldShow?: number
```

### VehiclePassengersChanged

Fires as `VEHICLE_PASSENGERS_CHANGED`.

No payload.

### VehiclePowerShow

Fires as `VEHICLE_POWER_SHOW`.

```lua
payload: shouldShow?: number
```

### VehicleUpdate

Fires as `VEHICLE_UPDATE`.

No payload.
