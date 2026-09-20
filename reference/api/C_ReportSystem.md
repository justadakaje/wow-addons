# C_ReportSystem

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`12` functions - `2` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### CanReportPlayer

```lua
C_ReportSystem.CanReportPlayer(playerLocation: PlayerLocation) -> canReport: bool
```

### CanReportPlayerForLanguage

```lua
C_ReportSystem.CanReportPlayerForLanguage(playerLocation: PlayerLocation) -> canReport: bool
```

### GetMajorCategoriesForReportType

```lua
C_ReportSystem.GetMajorCategoriesForReportType(reportType: ReportType) -> majorCategories: table
```

### GetMajorCategoryString

```lua
C_ReportSystem.GetMajorCategoryString(majorCategory: ReportMajorCategory) -> majorCategoryString: cstring
```

### GetMinorCategoriesForReportTypeAndMajorCategory

```lua
C_ReportSystem.GetMinorCategoriesForReportTypeAndMajorCategory(reportType: ReportType, majorCategory: ReportMajorCategory) -> minorCategories: table
```

### GetMinorCategoryString

```lua
C_ReportSystem.GetMinorCategoryString(minorCategory: ReportMinorCategory) -> minorCategoryString: cstring
```

### ReportServerLag

```lua
C_ReportSystem.ReportServerLag()
```

### ReportStuckInCombat

```lua
C_ReportSystem.ReportStuckInCombat()
```

### RequiresScreenshotForReportType

```lua
C_ReportSystem.RequiresScreenshotForReportType(reportType: ReportType, majorCategory: ReportMajorCategory) -> requiresScreenshot: bool
```

### SendReport

```lua
C_ReportSystem.SendReport(reportInfo: ReportInfo, playerLocation?: PlayerLocation)
```

### SetScreenshotPreviewTexture

```lua
C_ReportSystem.SetScreenshotPreviewTexture(textureObject: SimpleTexture)
```

### TakeReportScreenshot

```lua
C_ReportSystem.TakeReportScreenshot()
```

## Events

### ReportPlayerResult

Fires as `REPORT_PLAYER_RESULT`.

```lua
payload: result: SendReportResult, reportType: ReportType
```

### ReportScreenshotReady

Fires as `REPORT_SCREENSHOT_READY`.

No payload.
