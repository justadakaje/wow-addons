# FrameAPITooltip

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`9` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### AddFontStrings

```lua
AddFontStrings(leftFontString: SimpleFontString, rightFontString: SimpleFontString)
```

### ClearPadding

```lua
ClearPadding()
```

### GetLeftLine

```lua
GetLeftLine(line: luaIndex) -> leftFontString: SimpleFontString
```

### GetMinimumWidth

```lua
GetMinimumWidth() -> width: number, forced: bool
```

### GetPadding

```lua
GetPadding() -> right: number, bottom: number, left: number, top: number
```

### GetRightLine

```lua
GetRightLine(line: luaIndex) -> rightFontString: SimpleFontString
```

### SetMinimumWidth

```lua
SetMinimumWidth(width: number, force: bool)
```

### SetPadding

```lua
SetPadding(right: number, bottom: number, left?: number, top?: number)
```

### SetText

```lua
SetText(text: cstring, colorR: number, colorG: number, colorB: number, alpha: number, wrap: bool)
```
