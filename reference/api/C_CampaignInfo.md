# C_CampaignInfo

WoW: Forever 1.60.1 (build 69913) - Interface 16001

`10` functions - `0` events

> Generated from the live client by `scripts/extract-api.js`. Do not edit.

## Functions

### GetAvailableCampaigns

```lua
C_CampaignInfo.GetAvailableCampaigns() -> campaignIDs: table
```

### GetCampaignChapterInfo

```lua
C_CampaignInfo.GetCampaignChapterInfo(campaignChapterID: number) -> campaignChapterInfo?: CampaignChapterInfo
```

### GetCampaignID

```lua
C_CampaignInfo.GetCampaignID(questID: number) -> campaignID: number
```

### GetCampaignInfo

```lua
C_CampaignInfo.GetCampaignInfo(campaignID: number) -> campaignInfo?: CampaignInfo
```

### GetChapterIDs

```lua
C_CampaignInfo.GetChapterIDs(campaignID: number) -> chapterIDs?: table
```

### GetCurrentChapterID

```lua
C_CampaignInfo.GetCurrentChapterID(campaignID: number) -> currentChapterID?: number
```

### GetFailureReason

```lua
C_CampaignInfo.GetFailureReason(campaignID: number) -> failureReason?: CampaignFailureReason
```

### GetState

```lua
C_CampaignInfo.GetState(campaignID: number) -> state: CampaignState
```

### IsCampaignQuest

```lua
C_CampaignInfo.IsCampaignQuest(questID: number) -> isCampaignQuest: bool
```

### SortAsNormalQuest

```lua
C_CampaignInfo.SortAsNormalQuest(campaignID: number) -> sortAsNormalQuest: bool
```
