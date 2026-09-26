# C_EncodingUtil

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`10` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CompressString

```lua
C_EncodingUtil.CompressString(source: stringView, method: CompressionMethod, level: CompressionLevel) -> output: string
```

### DecodeBase64

```lua
C_EncodingUtil.DecodeBase64(source: stringView, variant: Base64Variant) -> output: string
```

### DecodeHex

```lua
C_EncodingUtil.DecodeHex(source: string) -> output: string
```

### DecompressString

```lua
C_EncodingUtil.DecompressString(source: stringView, method: CompressionMethod) -> output: string
```

### DeserializeCBOR

```lua
C_EncodingUtil.DeserializeCBOR(source: stringView) -> value?: LuaValueVariant
```

### DeserializeJSON

```lua
C_EncodingUtil.DeserializeJSON(source: string) -> value?: LuaValueVariant
```

### EncodeBase64

```lua
C_EncodingUtil.EncodeBase64(source: stringView, variant: Base64Variant) -> output: string
```

### EncodeHex

```lua
C_EncodingUtil.EncodeHex(source: stringView) -> output: string
```

### SerializeCBOR

```lua
C_EncodingUtil.SerializeCBOR(value?: LuaValueVariant, options?: CBORSerializationOptions) -> output: string
```

### SerializeJSON

```lua
C_EncodingUtil.SerializeJSON(value?: LuaValueVariant, options?: JSONSerializationOptions) -> output: string
```
