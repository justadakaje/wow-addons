# C_ColorUtil

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`7` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### ConvertHSLToHSV

```lua
C_ColorUtil.ConvertHSLToHSV(hslH: number, hslS: number, hslL: number) -> hsvH: number, hsvS: number, hsvV: number
```

### ConvertHSVToHSL

```lua
C_ColorUtil.ConvertHSVToHSL(hsvH: number, hsvS: number, hsvV: number) -> hslH: number, hslS: number, hslL: number
```

### ConvertHSVToRGB

```lua
C_ColorUtil.ConvertHSVToRGB(hsvH: number, hsvS: number, hsvV: number) -> rgbR: number, rgbG: number, rgbB: number
```

### ConvertRGBToHSV

```lua
C_ColorUtil.ConvertRGBToHSV(rgbR: number, rgbG: number, rgbB: number) -> hsvH: number, hsvS: number, hsvV: number
```

### GenerateTextColorCode

```lua
C_ColorUtil.GenerateTextColorCode(color: colorRGB) -> textColorCode: string
```

### WrapTextInColor

```lua
C_ColorUtil.WrapTextInColor(text: cstring, color: colorRGB) -> coloredText: string
```

### WrapTextInColorCode

```lua
C_ColorUtil.WrapTextInColorCode(text: cstring, textColorCode: cstring) -> coloredText: string
```
