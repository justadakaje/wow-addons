# Console

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`10` functions - `7` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CalculateStringEditDistance

```lua
CalculateStringEditDistance(firstString: stringView, secondString: stringView) -> distance: number
```

### ConsoleEcho

```lua
ConsoleEcho(command: cstring, addToHistory: bool, prefix?: cstring) -> result: bool
```

### ConsoleExec

```lua
ConsoleExec(command: cstring, addToHistory: bool) -> result: bool
```

### ConsoleGetAllCommands

```lua
ConsoleGetAllCommands() -> commands: table
```

### ConsoleGetColorFromType

```lua
ConsoleGetColorFromType(colorType: ConsoleColorType) -> color: colorRGB
```

### ConsoleGetFontHeight

```lua
ConsoleGetFontHeight() -> fontHeightInPixels: number
```

### ConsoleIsActive

```lua
ConsoleIsActive() -> consoleIsActive: bool
```

### ConsolePrintAllMatchingCommands

```lua
ConsolePrintAllMatchingCommands(partialCommandText: cstring)
```

### ConsoleSetFontHeight

```lua
ConsoleSetFontHeight(fontHeightInPixels: number)
```

### SetConsoleKey

```lua
SetConsoleKey(keystring: cstring)
```

## Events

### ConsoleClear

Fires as `CONSOLE_CLEAR`.

No payload.

### ConsoleColorsChanged

Fires as `CONSOLE_COLORS_CHANGED`.

No payload.

### ConsoleFontSizeChanged

Fires as `CONSOLE_FONT_SIZE_CHANGED`.

No payload.

### ConsoleLog

Fires as `CONSOLE_LOG`.

```lua
payload: message: cstring
```

### ConsoleMessage

Fires as `CONSOLE_MESSAGE`.

```lua
payload: message: cstring, colorType: number
```

### CvarUpdate

Fires as `CVAR_UPDATE`.

```lua
payload: eventName: cstring, value: cstring
```

### ToggleConsole

Fires as `TOGGLE_CONSOLE`.

```lua
payload: showConsole?: bool
```
