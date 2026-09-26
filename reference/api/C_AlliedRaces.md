# C_AlliedRaces

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`2` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetAllRacialAbilitiesFromID

```lua
C_AlliedRaces.GetAllRacialAbilitiesFromID(raceID: number) -> allDisplayInfo: table
```

### GetRaceInfoByID

```lua
C_AlliedRaces.GetRaceInfoByID(raceID: number) -> info: AlliedRaceInfo
```

## Events

### AlliedRaceClose

Fires as `ALLIED_RACE_CLOSE`.

No payload.

### AlliedRaceOpen

Fires as `ALLIED_RACE_OPEN`.

```lua
payload: raceID: number
```
