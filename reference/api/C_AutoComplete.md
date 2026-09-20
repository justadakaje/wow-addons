# C_AutoComplete

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`4` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetAutoCompletePresenceID

```lua
C_AutoComplete.GetAutoCompletePresenceID(name: cstring) -> presenceID?: number
```

### GetAutoCompleteRealms

```lua
C_AutoComplete.GetAutoCompleteRealms() -> realms: table
```

### GetAutoCompleteResults

```lua
C_AutoComplete.GetAutoCompleteResults(name: cstring, numResults: number, cursorPosition: number, allowFullMatch: bool, includeFlags: number, excludeFlags: number) -> results: table
```

### IsRecognizedName

```lua
C_AutoComplete.IsRecognizedName(name: cstring, includeFlags: number, excludeFlags: number) -> isRecognizedName: bool
```
