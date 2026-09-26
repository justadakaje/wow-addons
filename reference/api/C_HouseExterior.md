# C_HouseExterior

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`20` functions - `12` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CancelActiveExteriorEditing

```lua
C_HouseExterior.CancelActiveExteriorEditing()
```

### GetCoreFixtureOptionsInfo

```lua
C_HouseExterior.GetCoreFixtureOptionsInfo(coreFixtureType: HousingFixtureType) -> coreFixtureOptionsInfo?: HousingCoreFixtureInfo
```

### GetCurrentHouseExteriorSize

```lua
C_HouseExterior.GetCurrentHouseExteriorSize() -> houseExteriorSize?: HousingFixtureSize
```

### GetCurrentHouseExteriorType

```lua
C_HouseExterior.GetCurrentHouseExteriorType() -> houseExteriorTypeID?: number, houseExteriorTypeName?: cstring
```

### GetHouseExteriorSizeOptions

```lua
C_HouseExterior.GetHouseExteriorSizeOptions() -> options?: HouseExteriorSizeOptionsInfo
```

### GetHouseExteriorTypeOptions

```lua
C_HouseExterior.GetHouseExteriorTypeOptions() -> options?: HouseExteriorTypeOptionsInfo
```

### GetSelectedFixturePointInfo

```lua
C_HouseExterior.GetSelectedFixturePointInfo() -> fixturePointInfo?: HousingFixturePointInfo
```

### HasHoveredFixture

```lua
C_HouseExterior.HasHoveredFixture() -> anyHoveredFixture: bool
```

### HasSelectedFixturePoint

```lua
C_HouseExterior.HasSelectedFixturePoint() -> anySelectedFixturePoint: bool
```

### IsAnyDecorAttachedToCoreFixture

```lua
C_HouseExterior.IsAnyDecorAttachedToCoreFixture(coreFixtureType: HousingFixtureType) -> anyAttachedDecor: bool
```

### IsAnyDecorAttachedToDoor

```lua
C_HouseExterior.IsAnyDecorAttachedToDoor() -> anyAttachedDecor: bool
```

### IsAnyDecorAttachedToHouseExterior

```lua
C_HouseExterior.IsAnyDecorAttachedToHouseExterior() -> anyAttachedDecor: bool
```

### IsAnyDecorAttachedToSelectedFixturePoint

```lua
C_HouseExterior.IsAnyDecorAttachedToSelectedFixturePoint() -> anyAttachedDecor: bool
```

### IsExteriorDecorHidden

```lua
C_HouseExterior.IsExteriorDecorHidden() -> decorHidden: bool
```

### RemoveFixtureFromSelectedPoint

```lua
C_HouseExterior.RemoveFixtureFromSelectedPoint(attachedDecorAction: HousingFixtureDecorAction)
```

### SelectCoreFixtureOption

```lua
C_HouseExterior.SelectCoreFixtureOption(fixtureID: number, attachedDecorAction: HousingFixtureDecorAction)
```

### SelectFixtureOption

```lua
C_HouseExterior.SelectFixtureOption(fixtureID: number, attachedDecorAction: HousingFixtureDecorAction)
```

### SetExteriorDecorHidden

```lua
C_HouseExterior.SetExteriorDecorHidden(decorHidden: bool)
```

### SetHouseExteriorSize

```lua
C_HouseExterior.SetHouseExteriorSize(size: HousingFixtureSize, attachedDecorAction: HousingFixtureDecorAction)
```

### SetHouseExteriorType

```lua
C_HouseExterior.SetHouseExteriorType(houseExteriorTypeID: number, attachedDecorAction: HousingFixtureDecorAction)
```

## Events

### HouseExteriorDecorHiddenChanged

Fires as `HOUSE_EXTERIOR_DECOR_HIDDEN_CHANGED`.

```lua
payload: isDecorHidden: bool
```

### HouseExteriorTypeUnlocked

Fires as `HOUSE_EXTERIOR_TYPE_UNLOCKED`.

```lua
payload: fixtureID: number
```

### HousingCoreFixtureChanged

Fires as `HOUSING_CORE_FIXTURE_CHANGED`.

```lua
payload: coreFixtureType: HousingFixtureType
```

### HousingFixtureHoverChanged

Fires as `HOUSING_FIXTURE_HOVER_CHANGED`.

```lua
payload: anyHovered: bool
```

### HousingFixturePointFrameAdded

Fires as `HOUSING_FIXTURE_POINT_FRAME_ADDED`.

```lua
payload: pointFrame: HousingFixturePointFrame
```

### HousingFixturePointFrameReleased

Fires as `HOUSING_FIXTURE_POINT_FRAME_RELEASED`.

```lua
payload: pointFrame: HousingFixturePointFrame
```

### HousingFixturePointFramesReleased

Fires as `HOUSING_FIXTURE_POINT_FRAMES_RELEASED`.

No payload.

### HousingFixturePointSelectionChanged

Fires as `HOUSING_FIXTURE_POINT_SELECTION_CHANGED`.

```lua
payload: hasSelection: bool
```

### HousingFixtureUnlocked

Fires as `HOUSING_FIXTURE_UNLOCKED`.

```lua
payload: fixtureID: number
```

### HousingSetExteriorHouseSizeResponse

Fires as `HOUSING_SET_EXTERIOR_HOUSE_SIZE_RESPONSE`.

```lua
payload: result: HousingResult
```

### HousingSetExteriorHouseTypeResponse

Fires as `HOUSING_SET_EXTERIOR_HOUSE_TYPE_RESPONSE`.

```lua
payload: result: HousingResult
```

### HousingSetFixtureResponse

Fires as `HOUSING_SET_FIXTURE_RESPONSE`.

```lua
payload: result: HousingResult
```
