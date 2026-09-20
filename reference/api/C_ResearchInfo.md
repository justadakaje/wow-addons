# C_ResearchInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`1` functions - `8` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetDigSitesForMap

```lua
C_ResearchInfo.GetDigSitesForMap(uiMapID: number) -> digSites: table
```

## Events

### ArchaeologyClosed

Fires as `ARCHAEOLOGY_CLOSED`.

No payload.

### ArchaeologyFindComplete

Fires as `ARCHAEOLOGY_FIND_COMPLETE`.

```lua
payload: numFindsCompleted: number, totalFinds: number, researchBranchID: number
```

### ArchaeologySurveyCast

Fires as `ARCHAEOLOGY_SURVEY_CAST`.

```lua
payload: numFindsCompleted: number, totalFinds: number, researchBranchID: number, successfulFind: number
```

### ArchaeologyToggle

Fires as `ARCHAEOLOGY_TOGGLE`.

No payload.

### ArtifactDigsiteComplete

Fires as `ARTIFACT_DIGSITE_COMPLETE`.

```lua
payload: researchBranchID: number
```

### ResearchArtifactComplete

Fires as `RESEARCH_ARTIFACT_COMPLETE`.

```lua
payload: name: cstring
```

### ResearchArtifactDigSiteUpdated

Fires as `RESEARCH_ARTIFACT_DIG_SITE_UPDATED`.

No payload.

### ResearchArtifactUpdate

Fires as `RESEARCH_ARTIFACT_UPDATE`.

No payload.
