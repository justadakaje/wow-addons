-- .luacheckrc -- Luacheck configuration for World of Warcraft addons monorepo
-- Targets Lua 5.1 (PUC-Rio Lua 5.1 runtime used by World of Warcraft)

std = "lua51"
max_line_length = false
self = false
unused_args = false
unused_secondaries = false

-- Files to exclude from checking (vendored third-party libraries and dependencies)
exclude_files = {
    "**/libs/**",
    "**/node_modules/**",
    "**/.git/**",
    "dist/**",
}

-- Global variables that are safe to read across WoW addons
read_globals = {
    -- Lua 5.1 & WoW standard library extensions
    "_G",
    "wipe",
    "tinsert",
    "tremove",
    "tContains",
    "CopyTable",
    "fastrandom",
    "strsplit",
    "strjoin",
    "format",
    "strtrim",
    "strsub",
    "strlen",
    "strbyte",
    "strchar",
    "strfind",
    "strmatch",
    "gsub",
    "GetTime",
    "GetGameTime",
    "GetServerTime",
    "time",
    "date",
    "difftime",
    "hooksecurefunc",
    "bit",

    -- Input & Key states
    "IsShiftKeyDown",
    "IsAltKeyDown",
    "IsControlKeyDown",
    "IsMouseButtonDown",

    -- WoW UI Framework, Widgets & Mixins
    "UIParent",
    "WorldFrame",
    "DEFAULT_CHAT_FRAME",
    "UIErrorsFrame",
    "GameTooltip",
    "ItemRefTooltip",
    "GameTooltip_SetDefaultAnchor",
    "TooltipDataProcessor",
    "CreateFrame",
    "BackdropTemplateMixin",
    "StaticPopupDialogs",
    "StaticPopup_Show",
    "StaticPopup_Hide",
    "PlaySound",
    "PlaySoundFile",
    "SOUNDKIT",
    "ChatFrame1",
    "ChatFrame2",
    "NUM_CHAT_WINDOWS",
    "GetChatWindowInfo",
    "FCF_OpenNewWindow",
    "PanelTemplates_SetNumTabs",
    "PanelTemplates_SetTab",
    "PanelTemplates_UpdateTabs",
    "PanelTemplates_GetSelectedTab",
    "UIDropDownMenu_Initialize",
    "UIDropDownMenu_CreateInfo",
    "UIDropDownMenu_AddButton",
    "UIDropDownMenu_SetSelectedValue",
    "UIDropDownMenu_SetText",
    "UIDropDownMenu_SetWidth",
    "ToggleDropDownMenu",
    "CloseDropDownMenus",
    "MoneyInputFrame_SetAmount",
    "SearchBoxTemplate_OnTextChanged",
    "EventRegistry",
    "Settings",
    "InterfaceOptions_AddCategory",
    "InterfaceOptionsFrame_OpenToCategory",
    "RaidNotice_AddMessage",
    "RaidWarningFrame",
    "ChatTypeInfo",
    "ChatEdit_InsertLink",
    "GameFontNormal",
    "GameFontHighlight",
    "GameFontDisable",
    "GameFontGreen",
    "GameFontRed",

    -- Mail Frame & APIs
    "MailFrame",
    "InboxFrame",
    "SendMailFrame",
    "ClearSendMail",
    "AUCTION_HOUSE_MAIL_SUBJECT",
    "GetInboxNumItems",
    "GetInboxHeaderInfo",
    "GetInboxInvoiceInfo",
    "GetInboxItemLink",
    "TakeInboxItem",
    "TakeInboxMoney",
    "AutoLootMailItemAndMoney",

    -- Namespaces & Enums
    "Enum",
    "C_AddOns",
    "C_Item",
    "C_Timer",
    "C_AuctionHouse",
    "C_CurrencyInfo",
    "C_Container",
    "C_Spell",
    "C_Map",
    "C_GossipInfo",
    "C_MerchantFrame",
    "C_TradeSkillUI",
    "C_QuestLog",
    "ItemLocation",

    -- Auction House APIs & Frames
    "AuctionFrame",
    "AuctionHouseFrame",
    "AuctionFrameTab_OnClick",
    "AuctionFrame_Show",
    "AuctionFrame_Hide",
    "CanSendAuctionQuery",
    "QueryAuctionItems",
    "GetNumAuctionItems",
    "GetAuctionItemInfo",
    "GetAuctionItemLink",
    "GetAuctionItemTimeLeft",
    "PlaceAuctionBid",
    "CalculateAuctionDeposit",
    "PostAuction",
    "StartAuction",
    "CancelAuction",
    "GetAuctionSort",
    "SortAuctionItems",
    "SetSelectedAuctionItem",
    "GetSelectedAuctionItem",
    "IsAuctionSortReversed",
    "GetOwnerAuctionItems",
    "GetNumOwnerAuctionItems",

    -- Item & Inventory APIs
    "GetItemInfo",
    "GetItemInfoInstant",
    "GetItemCount",
    "GetItemQualityColor",
    "GetItemIcon",
    "GetContainerNumSlots",
    "GetContainerItemInfo",
    "GetContainerItemLink",
    "UseContainerItem",
    "PickupContainerItem",
    "GetInventoryItemLink",
    "GetInventoryItemID",
    "GetInventoryItemTexture",
    "OpenAllBags",
    "CloseAllBags",

    -- Merchant & Economy APIs
    "GetMoney",
    "GetCoinTextureString",
    "GetMerchantNumItems",
    "GetMerchantItemInfo",
    "GetMerchantItemLink",
    "BuyMerchantItem",

    -- Unit, Player & Guild APIs
    "UnitName",
    "UnitFullName",
    "UnitClass",
    "UnitFactionGroup",
    "UnitLevel",
    "UnitGUID",
    "UnitRace",
    "UnitSex",
    "GetGuildInfo",
    "GetRealmName",
    "GetNormalizedRealmName",
    "CheckInteractDistance",
    "GetTitleName",
    "GetNumTitles",
    "IsTitleKnown",
    "GetCurrentTitle",
    "GetProfessions",
    "GetProfessionInfo",
    "GetAchievementInfo",

    -- Client & Project Constants
    "WOW_PROJECT_ID",
    "WOW_PROJECT_MAINLINE",
    "WOW_PROJECT_CLASSIC",
    "WOW_PROJECT_BURNING_CRUSADE_CLASSIC",
    "WOW_PROJECT_WRATH_CLASSIC",

    -- Addon & System APIs
    "GetAddOnMetadata",
    "IsAddOnLoaded",
    "LoadAddOn",
    "EnableAddOn",
    "DisableAddOn",
    "UpdateAddOnMemoryUsage",
    "GetAddOnMemoryUsage",
    "debugprofilestop",
    "debugstack",
    "GetBuildInfo",
    "GetLocale",
    "GetCurrentRegion",
    "GetCVar",
    "SetCVar",

    -- Security / Taint primitives
    "canaccessvalue",
    "issecretvalue",

    -- Vendored library roots
    "LibStub",
    "CallbackHandler",
    "LibAHTab",
}

-- Global variables that addons may define / mutate
globals = {
    "SlashCmdList",
    "UISpecialFrames",

    -- GoldFinder globals
    "GoldFinder",
    "GoldFinderDB",

    -- Monorepo addon globals
    "BiSGearFinder",
    "BiSGearFinderDB",
    "AdventurerPlates",
    "AdventurerPlatesDB",
    "AdventurerPlatesPortrait",
    "AdventurerPlatesPortraitDB",
    "ForeverProbe",
    "ForeverProbeDB",
    "ForeverProbeEventsDB",
    "AddonSmokeTest",
}

-- Pattern ignores for dynamic WoW APIs and addon conventions
ignore = {
    -- Unused ADDON argument from `local ADDON, ns = ...`
    "211/ADDON",
    "212/ADDON",
    -- Unused dummy variables prefixed with underscore
    "211/_.*",
    "212/_.*",
    -- Unused loop index variables
    "213/.*",
    -- Dynamic WoW namespaces and constants
    "113/C_.*",
    "111/SLASH_.*",
    "113/SLASH_.*",
    "111/LE_.*",
    "113/LE_.*",
    "111/BINDING_.*",
    "113/BINDING_.*",
    -- Addon-specific dynamic globals
    "111/GoldFinder.*",
    "112/GoldFinder.*",
    "113/GoldFinder.*",
    "111/BiSGearFinder.*",
    "112/BiSGearFinder.*",
    "113/BiSGearFinder.*",
    "111/AdventurerPlates.*",
    "112/AdventurerPlates.*",
    "113/AdventurerPlates.*",
    "111/ForeverProbe.*",
    "112/ForeverProbe.*",
    "113/ForeverProbe.*",
}

-- Test files configuration (Busted)
files["**/tests/**"] = {
    std = "+busted",
    read_globals = {
        "spy",
        "stub",
        "mock",
        "assert",
    },
    ignore = {
        "121", -- setting read-only global variable
        "122", -- setting read-only field of global variable
    },
}
