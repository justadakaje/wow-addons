# C_DyeColor

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`8` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetAllDyeColorCategories

```lua
C_DyeColor.GetAllDyeColorCategories() -> dyeColorCategoryIDs: table
```

### GetAllDyeColors

```lua
C_DyeColor.GetAllDyeColors(ownedColorsOnly: bool) -> dyeColorIDs: table
```

### GetDyeColorCategoryInfo

```lua
C_DyeColor.GetDyeColorCategoryInfo(dyeColorCategoryID: number) -> dyeColorCategoryInfo?: DyeColorCategoryDisplayInfo
```

### GetDyeColorInfo

```lua
C_DyeColor.GetDyeColorInfo(dyeColorID: number) -> dyeColorInfo?: DyeColorDisplayInfo
```

### GetDyeColorsForItem

```lua
C_DyeColor.GetDyeColorsForItem(itemLinkOrID: ItemInfo) -> dyeColorIDs: table
```

### GetDyeColorsForItemLocation

```lua
C_DyeColor.GetDyeColorsForItemLocation(itemLocation: ItemLocation) -> dyeColorIDs: table
```

### GetDyeColorsInCategory

```lua
C_DyeColor.GetDyeColorsInCategory(dyeColorCategory: number, ownedColorsOnly: bool) -> dyeColorIDs: table
```

### IsDyeColorOwned

```lua
C_DyeColor.IsDyeColorOwned(dyeColorID: number) -> isOwned: bool
```

## Events

### DyeColorCategoryUpdated

Fires as `DYE_COLOR_CATEGORY_UPDATED`.

```lua
payload: dyeColorCategoryID: number
```

### DyeColorUpdated

Fires as `DYE_COLOR_UPDATED`.

```lua
payload: dyeColorID: number
```
