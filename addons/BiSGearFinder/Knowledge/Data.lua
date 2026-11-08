-- BiSGearFinder -- Knowledge Base
-- Curated matrix of high-value BoE Best-in-Slot (BiS) equipment, pre-raid BiS armor/weapons,
-- and twink tournament gear for World of Warcraft Classic Era and WoW: Forever.
-- Every item ID verified against authoritative WoW database records (QuestieDB / Wowhead Classic).

local ADDON, ns = ...

ns.Knowledge = ns.Knowledge or {}

---------------------------------------------------------------------------
-- Curated BoE BiS Matrix
---------------------------------------------------------------------------
local BIS_DATABASE = {
    -- ====================================================================
    -- Pre-Raid BiS Crafted & BoE Drops (The Golden Tier)
    -- ====================================================================
    [14551] = {
        name      = "Edgemaster's Handguards",
        slot      = "INVTYPE_HANDS",
        armorType = "MAIL",
        reqLevel  = 44,
        tier      = "PRE_RAID_BIS",
        classes   = { "WARRIOR", "SHAMAN", "HUNTER" },
        roles     = { "DPS" },
        source    = "WORLD_DROP",
        note      = "+7 Axe/Dagger/Sword Skill -- Mandatory #1 Fury Warrior BiS throughout Classic",
    },
    [12640] = {
        name      = "Lionheart Helm",
        slot      = "INVTYPE_HEAD",
        armorType = "PLATE",
        reqLevel  = 56,
        tier      = "PRE_RAID_BIS",
        classes   = { "WARRIOR", "PALADIN" },
        roles     = { "DPS" },
        source    = "CRAFTED_BLACKSMITHING",
        note      = "2% Hit, 2% Crit -- Undisputed #1 Warrior DPS Helm through Phase 5",
    },
    [15062] = {
        name      = "Devilsaur Leggings",
        slot      = "INVTYPE_LEGS",
        armorType = "LEATHER",
        reqLevel  = 55,
        tier      = "PRE_RAID_BIS",
        classes   = { "ROGUE", "WARRIOR", "HUNTER", "DRUID" },
        roles     = { "DPS" },
        source    = "CRAFTED_LEATHERWORKING",
        note      = "1% Hit, 46 AP (Set: +2% Hit) -- Top pre-raid melee DPS legs",
    },
    [15063] = {
        name      = "Devilsaur Gauntlets",
        slot      = "INVTYPE_HANDS",
        armorType = "LEATHER",
        reqLevel  = 53,
        tier      = "PRE_RAID_BIS",
        classes   = { "ROGUE", "WARRIOR", "HUNTER", "DRUID" },
        roles     = { "DPS" },
        source    = "CRAFTED_LEATHERWORKING",
        note      = "1% Crit, 28 AP (Set: +2% Hit) -- Top pre-raid melee DPS gloves",
    },
    [18510] = {
        name      = "Hide of the Wild",
        slot      = "INVTYPE_CLOAK",
        armorType = "CLOTH",
        reqLevel  = 57,
        tier      = "PRE_RAID_BIS",
        classes   = { "PRIEST", "DRUID", "PALADIN", "SHAMAN" },
        roles     = { "HEALER" },
        source    = "CRAFTED_LEATHERWORKING",
        note      = "+42 Healing, 10 Int/Stam -- #1 Pre-Raid healing cloak in the game",
    },
    [15050] = {
        name      = "Black Dragonscale Breastplate",
        slot      = "INVTYPE_CHEST",
        armorType = "MAIL",
        reqLevel  = 53,
        tier      = "PRE_RAID_BIS",
        classes   = { "HUNTER", "SHAMAN" },
        roles     = { "DPS" },
        source    = "CRAFTED_LEATHERWORKING",
        note      = "50 AP, 12 Fire Res (Set: +1% Hit, 28 AP) -- Pre-raid BiS Hunter/Enhancement chest",
    },
    [15051] = {
        name      = "Black Dragonscale Shoulders",
        slot      = "INVTYPE_SHOULDER",
        armorType = "MAIL",
        reqLevel  = 53,
        tier      = "PRE_RAID_BIS",
        classes   = { "HUNTER", "SHAMAN" },
        roles     = { "DPS" },
        source    = "CRAFTED_LEATHERWORKING",
        note      = "40 AP (Set: +1% Hit, 28 AP) -- Pre-raid BiS Hunter/Enhancement shoulders",
    },
    [15052] = {
        name      = "Black Dragonscale Leggings",
        slot      = "INVTYPE_LEGS",
        armorType = "MAIL",
        reqLevel  = 55,
        tier      = "PRE_RAID_BIS",
        classes   = { "HUNTER", "SHAMAN" },
        roles     = { "DPS" },
        source    = "CRAFTED_LEATHERWORKING",
        note      = "54 AP, 13 Fire Res (Set: +1% Hit, 28 AP) -- Pre-raid BiS Hunter legs",
    },
    [15060] = {
        name      = "Black Dragonscale Boots",
        slot      = "INVTYPE_FEET",
        armorType = "MAIL",
        reqLevel  = 54,
        tier      = "PRE_RAID_BIS",
        classes   = { "HUNTER", "SHAMAN" },
        roles     = { "DPS" },
        source    = "CRAFTED_LEATHERWORKING",
        note      = "1% Hit, 28 AP -- 4-piece set bonus activator for physical mail",
    },
    [14136] = {
        name      = "Robe of Winter Night",
        slot      = "INVTYPE_CHEST",
        armorType = "CLOTH",
        reqLevel  = 52,
        tier      = "PRE_RAID_BIS",
        classes   = { "MAGE", "WARLOCK", "PRIEST" },
        roles     = { "CASTER" },
        source    = "CRAFTED_TAILORING",
        note      = "+40 Frost/Shadow Damage -- Top pre-raid caster robe before Bloodvine",
    },
    [12639] = {
        name      = "Stronghold Gauntlets",
        slot      = "INVTYPE_HANDS",
        armorType = "PLATE",
        reqLevel  = 57,
        tier      = "PRE_RAID_BIS",
        classes   = { "WARRIOR", "PALADIN" },
        roles     = { "TANK" },
        source    = "CRAFTED_BLACKSMITHING",
        note      = "1% Crit, 1% Parry, Immune to Disarm -- Pre-raid BiS Protection tank gloves",
    },
    [11926] = {
        name      = "Deathdealer Breastplate",
        slot      = "INVTYPE_CHEST",
        armorType = "MAIL",
        reqLevel  = 52,
        tier      = "PRE_RAID_BIS",
        classes   = { "WARRIOR", "HUNTER", "SHAMAN" },
        roles     = { "DPS" },
        source    = "CRAFTED_BLACKSMITHING",
        note      = "2% Crit, 8 Strength -- High-impact physical crit mail chest",
    },
    [14616] = {
        name      = "Bloodmail Boots",
        slot      = "INVTYPE_FEET",
        armorType = "MAIL",
        reqLevel  = 56,
        tier      = "PRE_RAID_BIS",
        classes   = { "HUNTER", "SHAMAN", "WARRIOR" },
        roles     = { "DPS" },
        source    = "DUNGEON_DROP",
        note      = "1% Hit, 9 Str, 9 Agi, 10 Stam -- Rare Scholomance BoE mail hit boots",
    },

    -- ====================================================================
    -- High-Value Epic World Drops (Market Anchors & Power Items)
    -- ====================================================================
    [2244] = {
        name      = "Krol Blade",
        slot      = "INVTYPE_WEAPON",
        armorType = "SWORD",
        reqLevel  = 51,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "ROGUE", "WARRIOR" },
        roles     = { "DPS" },
        source    = "WORLD_DROP",
        note      = "2.80 Speed, 1% Crit, +7 Str -- Premier pre-raid 1H sword for Rogues and Fury Warriors",
    },
    [871] = {
        name      = "Flurry Axe",
        slot      = "INVTYPE_WEAPON",
        armorType = "AXE",
        reqLevel  = 42,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "SHAMAN", "WARRIOR" },
        roles     = { "DPS" },
        source    = "WORLD_DROP",
        note      = "1.50 Speed, Extra Attack Proc -- Legendary offhand for Enhancement Shamans & Fury Warriors",
    },
    [942] = {
        name      = "Freezing Band",
        slot      = "INVTYPE_FINGER",
        armorType = "RING",
        reqLevel  = 47,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "MAGE" },
        roles     = { "CASTER" },
        source    = "WORLD_DROP",
        note      = "+21 Frost Spell Damage, 1% Freeze Proc -- BiS Frost Mage ring into raiding",
    },
    [873] = {
        name      = "Staff of Jordan",
        slot      = "INVTYPE_2HWEAPON",
        armorType = "STAFF",
        reqLevel  = 35,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "MAGE", "WARLOCK", "PRIEST", "DRUID" },
        roles     = { "CASTER", "HEALER" },
        source    = "WORLD_DROP",
        note      = "+26 Spell Damage/Healing -- Definitive leveling & bracket caster staff",
    },
    [943] = {
        name      = "Warden Staff",
        slot      = "INVTYPE_2HWEAPON",
        armorType = "STAFF",
        reqLevel  = 43,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "DRUID" },
        roles     = { "TANK" },
        source    = "WORLD_DROP",
        note      = "+260 Armor, 10 Defense, 11 Stamina -- Undisputed #1 Feral Bear Tank staff all of Classic",
    },
    [14554] = {
        name      = "Cloudkeeper Legplates",
        slot      = "INVTYPE_LEGS",
        armorType = "PLATE",
        reqLevel  = 55,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "WARRIOR", "PALADIN" },
        roles     = { "DPS" },
        source    = "WORLD_DROP",
        note      = "On-Use: +100 AP for 30s -- Top-tier burst plate legs for Fury Warriors",
    },
    [14555] = {
        name      = "Alcor's Sunrazor",
        slot      = "INVTYPE_WEAPON",
        armorType = "DAGGER",
        reqLevel  = 58,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "WARRIOR", "ROGUE" },
        roles     = { "TANK", "DPS" },
        source    = "WORLD_DROP",
        note      = "1.30 Speed, Flame Proc -- Highest threat generation dagger for Protection Tanks",
    },
    [1168] = {
        name      = "Skullflame Shield",
        slot      = "INVTYPE_SHIELD",
        armorType = "SHIELD",
        reqLevel  = 54,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "PALADIN", "WARRIOR" },
        roles     = { "TANK" },
        source    = "WORLD_DROP",
        note      = "AoE Fire & Life Drain Procs -- Gold-standard farming shield for AoE Paladins & Warriors",
    },
    [1728] = {
        name      = "Teebu's Blazing Longsword",
        slot      = "INVTYPE_WEAPON",
        armorType = "SWORD",
        reqLevel  = 60,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "WARRIOR", "ROGUE" },
        roles     = { "TANK", "DPS" },
        source    = "WORLD_DROP",
        note      = "2.90 Speed, Fiery Blast Proc, Glowing Model -- Legendary prestige weapon",
    },
    [2243] = {
        name      = "Hand of Edward the Odd",
        slot      = "INVTYPE_WEAPON",
        armorType = "MACE",
        reqLevel  = 57,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "SHAMAN", "PALADIN", "DRUID", "PRIEST" },
        roles     = { "HEALER", "CASTER" },
        source    = "WORLD_DROP",
        note      = "Proc: Next spell cast within 4s is instant -- High-utility hybrid caster mace",
    },
    [1980] = {
        name      = "Underworld Band",
        slot      = "INVTYPE_FINGER",
        armorType = "RING",
        reqLevel  = 27,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "WARLOCK", "PRIEST" },
        roles     = { "CASTER" },
        source    = "WORLD_DROP",
        note      = "+14 Shadow Spell Damage -- Premium leveling & twink ring for Warlocks/Spriests",
    },
    [2164] = {
        name      = "Gut Ripper",
        slot      = "INVTYPE_WEAPON",
        armorType = "DAGGER",
        reqLevel  = 40,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "ROGUE" },
        roles     = { "DPS" },
        source    = "WORLD_DROP",
        note      = "1.80 Speed, Bleed Damage Proc -- Strong mid-level Rogue dagger",
    },
    [1982] = {
        name      = "Nightblade",
        slot      = "INVTYPE_WEAPON",
        armorType = "DAGGER",
        reqLevel  = 39,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "ROGUE" },
        roles     = { "DPS" },
        source    = "WORLD_DROP",
        note      = "1.80 Speed, Armor Reduction Proc -- Level 39 bracket twink / leveling dagger",
    },
    [2825] = {
        name      = "Bow of Searing Arrows",
        slot      = "INVTYPE_RANGED",
        armorType = "BOW",
        reqLevel  = 37,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "HUNTER", "WARRIOR", "ROGUE" },
        roles     = { "DPS" },
        source    = "WORLD_DROP",
        note      = "2.70 Speed, Fire Damage Proc -- Level 39 twink & leveling Hunter bow",
    },
    [14552] = {
        name      = "Stockade Pauldrons",
        slot      = "INVTYPE_SHOULDER",
        armorType = "MAIL",
        reqLevel  = 50,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "WARRIOR", "PALADIN" },
        roles     = { "TANK" },
        source    = "WORLD_DROP",
        note      = "10 Defense, 300 Armor -- Heavy defensive mail shoulders for leveling tanks",
    },
    [2245] = {
        name      = "Helm of Narv",
        slot      = "INVTYPE_HEAD",
        armorType = "MAIL",
        reqLevel  = 52,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "SHAMAN", "PALADIN" },
        roles     = { "HEALER" },
        source    = "WORLD_DROP",
        note      = "+29 Healing, 13 Int, 13 Spirit -- High-value hybrid mail healing helm",
    },
    [14558] = {
        name      = "Lady Maye's Pendant",
        slot      = "INVTYPE_NECK",
        armorType = "NECK",
        reqLevel  = 55,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "MAGE", "WARLOCK", "PRIEST", "DRUID", "PALADIN", "SHAMAN" },
        roles     = { "CASTER", "HEALER" },
        source    = "WORLD_DROP",
        note      = "+18 Spell Damage/Healing, 10 Int -- Rare caster neck drop before raid BiS",
    },
    [13102] = {
        name      = "Cassandra's Grace",
        slot      = "INVTYPE_HEAD",
        armorType = "CLOTH",
        reqLevel  = 42,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "PRIEST", "MAGE", "WARLOCK", "DRUID" },
        roles     = { "HEALER", "CASTER" },
        source    = "WORLD_DROP",
        note      = "+29 Healing, MP5 -- Leveling & bracket healing cloth helm",
    },
    [13385] = {
        name      = "Tome of Knowledge",
        slot      = "INVTYPE_HOLDABLE",
        armorType = "OFFHAND",
        reqLevel  = 55,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "PALADIN", "PRIEST", "MAGE", "WARLOCK", "DRUID", "SHAMAN" },
        roles     = { "HEALER", "CASTER" },
        source    = "WORLD_DROP",
        note      = "+8 All Stats, 100 Armor -- Versatile defensive hybrid caster offhand",
    },
    [870] = {
        name      = "Fiery War Axe",
        slot      = "INVTYPE_2HWEAPON",
        armorType = "AXE",
        reqLevel  = 35,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "WARRIOR", "PALADIN" },
        roles     = { "DPS" },
        source    = "WORLD_DROP",
        note      = "2.90 Speed, Fire Strike Proc -- Iconic mid-level leveling axe",
    },
    [812] = {
        name      = "Glowing Brightwood Staff",
        slot      = "INVTYPE_2HWEAPON",
        armorType = "STAFF",
        reqLevel  = 49,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "DRUID", "MAGE", "PRIEST", "WARLOCK", "SHAMAN" },
        roles     = { "CASTER", "HEALER" },
        source    = "WORLD_DROP",
        note      = "15 Stam, 15 Int, 15 Nature Res -- Classic durable caster staff",
    },
    [13047] = {
        name      = "Twig of the World Tree",
        slot      = "INVTYPE_WEAPON",
        armorType = "MACE",
        reqLevel  = 53,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "DRUID", "PALADIN", "SHAMAN", "PRIEST" },
        roles     = { "HEALER", "DPS" },
        source    = "WORLD_DROP",
        note      = "2.40 Speed, Root & Nature Damage Proc",
    },
    [14557] = {
        name      = "The Lion Horn of Stormwind",
        slot      = "INVTYPE_TRINKET",
        armorType = "TRINKET",
        reqLevel  = 58,
        tier      = "EPIC_WORLD_DROP",
        classes   = { "WARRIOR", "PALADIN" },
        roles     = { "TANK" },
        source    = "WORLD_DROP",
        note      = "Proc: +250 Armor to party for 30s -- Collector & utility tank trinket",
    },

    -- ====================================================================
    -- Bracket Twink BiS Equipment (High Scarcity / High Margin)
    -- ====================================================================
    [1935] = {
        name      = "Assassin's Blade",
        slot      = "INVTYPE_WEAPON",
        armorType = "DAGGER",
        reqLevel  = 19,
        tier      = "TWINK_19",
        classes   = { "ROGUE" },
        roles     = { "DPS" },
        source    = "WORLD_DROP",
        note      = "1.90 Speed, Bleed Damage Proc -- #1 Level 19 Twink Rogue Dagger in WoW",
    },
    [1482] = {
        name      = "Shadowfang",
        slot      = "INVTYPE_WEAPON",
        armorType = "SWORD",
        reqLevel  = 19,
        tier      = "TWINK_19",
        classes   = { "ROGUE", "WARRIOR", "PALADIN" },
        roles     = { "DPS" },
        source    = "DUNGEON_DROP",
        note      = "2.70 Speed, Shadow Damage Proc -- Holy grail level 19 Twink 1H sword (SFK drop)",
    },
    [1121] = {
        name      = "Feet of the Lynx",
        slot      = "INVTYPE_FEET",
        armorType = "LEATHER",
        reqLevel  = 19,
        tier      = "TWINK_19",
        classes   = { "ROGUE", "DRUID", "HUNTER" },
        roles     = { "DPS" },
        source    = "WORLD_DROP",
        note      = "8 Agility, 3 Strength -- Absolute #1 Level 19 Twink physical DPS boots",
    },
    [10413] = {
        name      = "Gloves of the Fang",
        slot      = "INVTYPE_HANDS",
        armorType = "LEATHER",
        reqLevel  = 19,
        tier      = "TWINK_19",
        classes   = { "ROGUE", "DRUID", "HUNTER", "SHAMAN" },
        roles     = { "DPS" },
        source    = "DUNGEON_DROP",
        note      = "4 Agi, 4 Str, 4 Stam -- Top-bracket level 19 leather gloves (WC BoE)",
    },
    [16901] = {
        name      = "Mindthrust Bracers",
        slot      = "INVTYPE_WRIST",
        armorType = "CLOTH",
        reqLevel  = 19,
        tier      = "TWINK_19",
        classes   = { "MAGE", "PRIEST", "WARLOCK" },
        roles     = { "CASTER", "HEALER" },
        source    = "WORLD_DROP",
        note      = "9 Intellect -- #1 Level 19 Twink Caster bracers",
    },
    [9425] = {
        name      = "Pendulum of Doom",
        slot      = "INVTYPE_2HWEAPON",
        armorType = "AXE",
        reqLevel  = 39,
        tier      = "TWINK_39",
        classes   = { "WARRIOR", "PALADIN", "SHAMAN" },
        roles     = { "DPS" },
        source    = "DUNGEON_DROP",
        note      = "4.00 Ultra-Slow Speed, Heavy Damage Proc -- Highest value level 39 twink weapon in Classic",
    },
    [13122] = {
        name      = "Dark Phantom Cape",
        slot      = "INVTYPE_CLOAK",
        armorType = "CLOTH",
        reqLevel  = 37,
        tier      = "TWINK_39",
        classes   = { "ROGUE", "HUNTER", "DRUID" },
        roles     = { "DPS" },
        source    = "WORLD_DROP",
        note      = "15 Agility -- #1 Level 39 Twink physical DPS cloak",
    },
}

---------------------------------------------------------------------------
-- Query APIs
---------------------------------------------------------------------------

function ns.GetItemBiS(itemID)
    if not itemID then return nil end
    return BIS_DATABASE[itemID]
end

function ns.IsBiSItem(itemID)
    return BIS_DATABASE[itemID] ~= nil
end

function ns.GetAllBiSItems()
    return BIS_DATABASE
end

function ns.GetItemsByClass(classTarget)
    if not classTarget then return {} end
    classTarget = classTarget:upper()
    local matched = {}
    for itemID, info in pairs(BIS_DATABASE) do
        for _, c in ipairs(info.classes) do
            if c:upper() == classTarget then
                matched[#matched + 1] = itemID
                break
            end
        end
    end
    table.sort(matched)
    return matched
end

function ns.GetItemsByTier(tierTarget)
    if not tierTarget then return {} end
    tierTarget = tierTarget:upper()
    local matched = {}
    for itemID, info in pairs(BIS_DATABASE) do
        if info.tier:upper() == tierTarget then
            matched[#matched + 1] = itemID
        end
    end
    table.sort(matched)
    return matched
end

function ns.GetItemsBySlot(slotTarget)
    if not slotTarget then return {} end
    slotTarget = slotTarget:upper()
    local matched = {}
    for itemID, info in pairs(BIS_DATABASE) do
        if info.slot:upper() == slotTarget then
            matched[#matched + 1] = itemID
        end
    end
    table.sort(matched)
    return matched
end

ns.Knowledge.Database = BIS_DATABASE
