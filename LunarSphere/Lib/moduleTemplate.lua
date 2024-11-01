-- /***********************************************
--  Lunar Template Module
--  *********************
--
--  Author	: Moongaze (Twisting Nether)
--  Description	: Stores the default templates in LunarSphere.
--                These are automatically removed from memory
--                after LunarSphere loads...
--
--  ***********************************************/

-- /***********************************************
--  * Module Setup
--  *********************

-- Create our Lunar object if it's not made
Lunar = Lunar or {};

-- Create our Template module
Lunar.Template = {};

Lunar.Template.version = 1.52;

-- Create our template database
Lunar.Template.template = {};

function mergeSettings(destination, ...)
	local source;

	for i = 1, select("#", ...) do
		source = select(i, ...);
		for k, v in pairs(source) do 
			destination[k] = v;
		end
	end

	return destination;
end

GetNumSpellTabs = GetNumSpellTabs
if C_SpellBook.GetNumSpellBookSkillLines then
	GetNumSpellTabs = C_SpellBook.GetNumSpellBookSkillLines
end

GetSpellTabInfo = GetSpellTabInfo
if C_SpellBook.GetSpellBookSkillLineInfo then
	GetSpellTabInfo = C_SpellBook.GetSpellBookSkillLineInfo
end

local GetSpellBookItemName = GetSpellBookItemName
if C_SpellBook.GetSpellBookItemName then
	GetSpellBookItemName = C_SpellBook.GetSpellBookItemName
end

local GetSpellInfo = GetSpellInfo
if C_Spell.GetSpellInfo then
	GetSpellInfo = Lunar.API:Deconfabulate(C_Spell.GetSpellInfo)
end

local BOOKTYPE_SPELL = BOOKTYPE_SPELL
if Enum.SpellBookSpellBank.Player then
	BOOKTYPE_SPELL = Enum.SpellBookSpellBank.Player
end

local defaultSphereTemplateSettings =
{
	["submenuCompression"] = Lunar.Sphere.defaultSettings.submenuCompression,
	["showSphereEditGlow"] = Lunar.Sphere.defaultSettings.showSphereEditGlow,
	["buttonOffset"] = Lunar.Sphere.defaultSettings.buttonOffset,
	["buttonSpacing"] = Lunar.Sphere.defaultSettings.buttonSpacing,
	["showOuter"] = Lunar.Sphere.defaultSettings.showOuter,
	["showInner"] = Lunar.Sphere.defaultSettings.showInner,
	["sphereTextType"] = Lunar.Sphere.defaultSettings.sphereTextType,
	["subMenuButtonDistance"] = Lunar.Sphere.defaultSettings.subMenuButtonDistance,
	["outerGaugeAnimate"] = Lunar.Sphere.defaultSettings.outerGaugeAnimate,
	["sphereTextEnd"] = Lunar.Sphere.defaultSettings.sphereTextEnd,
	["sphereScale"] = Lunar.Sphere.defaultSettings.sphereScale,
	["buttonDistance"] = Lunar.Sphere.defaultSettings.buttonDistance,
	["outerGaugeType"] = Lunar.Sphere.defaultSettings.outerGaugeType,
	["showAssignedCounts"] = Lunar.Sphere.defaultSettings.showAssignedCounts,
	["innerGaugeType"] = Lunar.Sphere.defaultSettings.innerGaugeType,
	["menuButtonDistance"] = Lunar.Sphere.defaultSettings.menuButtonDistance,
	["innerGaugeAnimate"] = Lunar.Sphere.defaultSettings.innerGaugeAnimate,
	["xOfs"] = Lunar.Sphere.defaultSettings.xOfs,
	["yOfs"] = Lunar.Sphere.defaultSettings.yOfs,
	["relativePoint"] = Lunar.Sphere.defaultSettings.relativePoint,
};

local defaultSkinTemplateSettings =
{
	["showSphereShine"] = Lunar.Sphere.defaultSettings.showSphereShine,
	["innerMarkSize"] = Lunar.Sphere.defaultSettings.innerMarkSize,
	["showOuterGaugeShine"] = Lunar.Sphere.defaultSettings.showOuterGaugeShine,
	["tooltipBorder"] = Lunar.Sphere.defaultSettings.tooltipBorder,
	["buttonColor"] = Lunar.Sphere.defaultSettings.buttonColor,
	["sphereColor"] =  Lunar.Sphere.defaultSettings.sphereColor,
	["vividMana"] = Lunar.Sphere.defaultSettings.vividMana,
	["buttonSkin"] = Lunar.Sphere.defaultSettings.buttonSkin,
	["vividManaRange"] = Lunar.Sphere.defaultSettings.vividManaRange,
	["vividButtons"] = Lunar.Sphere.defaultSettings.vividButtons;
	["gaugeBorderColor"] = Lunar.Sphere.defaultSettings.gaugeBorderColor,
	["gaugeBorder"] = Lunar.Sphere.defaultSettings.gaugeBorder,
	["showInnerGaugeShine"] = Lunar.Sphere.defaultSettings.showInnerGaugeShine,
	["outerMarkDark"] = Lunar.Sphere.defaultSettings.outerMarkDark,
	["gaugeFill"] = Lunar.Sphere.defaultSettings.gaugeFill,
	["outerGaugeColor"] = Lunar.Sphere.defaultSettings.outerGaugeColor,
	["customSphereColor"] = Lunar.Sphere.defaultSettings.customSphereColor,
	["vividRange"] = Lunar.Sphere.defaultSettings.vividRange,
	["menuButtonColor"] = Lunar.Sphere.defaultSettings.menuButtonColor,
	["innerGaugeColor"] = Lunar.Sphere.defaultSettings.innerGaugeColor,
	["innerMarkDark"] = Lunar.Sphere.defaultSettings.innerMarkDark,
	["gaugeColor"] = Lunar.Sphere.defaultSettings.gaugeColor,
	["tooltipBackground"] = Lunar.Sphere.defaultSettings.tooltipBackground,
	["skinAllTooltips"] = Lunar.Sphere.defaultSettings.skinAllTooltips,
	["outerMarkSize"] = Lunar.Sphere.defaultSettings.outerMarkSize,
	["sphereSkin"] = Lunar.Sphere.defaultSettings.sphereSkin,
	["showButtonShine"] = Lunar.Sphere.defaultSettings.showButtonShine,
};

--[[
Lunar.Locale = {
	["TEMPLATE_DEATHKNIGHT"] = "LS Unholy Templar",
	["TEMPLATE_DRUID"] = "LS Shapeshifter",
	["TEMPLATE_HUNTER"] = "LS Beastmaster",
	["TEMPLATE_MAGE"] = "LS Elementialist",
	["TEMPLATE_PALADIN"] = "LS Crusader",
	["TEMPLATE_PRIEST"] = "LS Vindicator",
	["TEMPLATE_ROGUE"] = "LS Rapscallion",
	["TEMPLATE_SHAMAN"] = "LS Angakok",
	["TEMPLATE_WARLOCK"] = "LS Demon-summoner",
	["TEMPLATE_WARRIOR"] = "LS Spartan",
	["TEMPLATE_DEFAULT"] = "LS Generic setup",
}
--]]
-- Generic template for all classes
Lunar.Template.template[1] = 
{
	["listData"] = Lunar.Locale["TEMPLATE_DEFAULT"] .. ":::ANY:::10101:::",
	["sphere"] = defaultSphereTemplateSettings,
	["skin"] = defaultSkinTemplateSettings,
	["buttonData"] = {
		nil, -- [1]
		nil, -- [2]
		nil, -- [3]
		{
			["buttonTypeData"] = "021011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iHoney Bread||002||iRefreshing Spring Water||003|| ||00X|| ",
			["showCount"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Food_11||002||Interface\\Icons\\INV_Drink_07||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [4]
		{
			["buttonTypeData"] = "031041000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Potion_131||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||i ||002||i ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [5]
		{
			["buttonTypeData"] = "080001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||i ||002||iitem:6948||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Foot_Centaur||002||Interface\\Icons\\INV_Misc_Rune_01||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [6]
		{
			["buttonTypeData"] = "131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||t/use 14||002|| ||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_QuestionMark||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [7]
		{
			["buttonTypeData"] = "130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_QuestionMark||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||t/use 13||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [8]
		["mainButtonCount"] = 10,
	},
};

Lunar.Template.template[2] = 
{
	["listData"] = Lunar.Locale["TEMPLATE_MAGE"] .. ":::MAGE:::10101:::",
	["sphere"] = defaultSphereTemplateSettings,
	["skin"] = mergeSettings({}, defaultSkinTemplateSettings, {
		["sphereSkin"] = 18,
	}),
	["buttonData"] = {
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["isMenu"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_Burnout||002|| ||003|| ||00X|| ",
		}, -- [1]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["isMenu"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_BlueFlameBolt||002|| ||003|| ||00X|| ",
		}, -- [2]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["isMenu"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Arcane_Arcane01||002|| ||003|| ||00X|| ",
		}, -- [3]
		{
			["buttonTypeData"] = "002045000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002||i ||003|| ||00X|| ||011||s ||012||s ||013|| ||01X|| ||021||s ||022||s ||023|| ||02X|| ||031||s ||032||s ||033|| ||03X|| ||041||s ||042||s ||043|| ||04X|| ||051||s ||052||s ||053|| ||05X|| ||061||s ||062||s ||063|| ||06X|| ||071||s ||072||s ||073|| ||07X|| ||081||s ||082||s ||083|| ||08X|| ||091||s ||092||s ||093|| ||09X|| ||101||s ||102||s ||103|| ||10X|| ||111||s ||112||s ||113|| ||11X|| ||121||s ||122||s ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["isMenu"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Gem_Emerald_01||002|| ||003|| ||00X|| ",
		}, -- [4]
		{
			["actionTexture"] = "||001||Interface\\Icons\\INV_Drink_12||002||5504||003|| ||00X|| ",
			["buttonTypeData"] = "011001110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||i ||002||s ||003||i ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [5]
		{
			["actionData"] = "||001||i ||002||s ||003||i ||00X|| ",
			["buttonTypeData"] = "021001111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Food_18||002||587||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [6]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Mount_NightmareHorse||002||Interface\\Icons\\INV_Misc_Rune_01||003|| ||00X|| ",
			["buttonTypeData"] = "081001082000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||i ||002||iitem:6948||003||i ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [7]
		{
			["actionData"] = "||001||t/use 13||002||t/use 14||003|| ||00X|| ",
			["buttonTypeData"] = "130131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_QuestionMark||002||Interface\\Icons\\INV_Misc_QuestionMark||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [8]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Arcane_PortalShattrath||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["isMenu"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
		}, -- [9]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["isMenu"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Shaman_WaterShield||002|| ||003|| ||00X|| ",
		}, -- [10]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||133||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [11]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sFire Blast||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||2136||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [12]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sFlamestrike||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_SelfDestruct||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [13]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_Fireball02||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [14]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_SoulBurn||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [15]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_Excorcism_02||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [16]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_SealOfFire||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [17]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Head_Dragon_01||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [18]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||24530||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [19]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||44457||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [20]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||44614||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [21]
		nil, -- [22]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sFrostbolt||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_FrostBolt02||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [23]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sFrost Nova||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_FrostNova||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [24]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_ColdHearted||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [25]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_IceStorm||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [26]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_Glacier||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [27]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_Frost||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [28]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_WizardMark||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [29]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_SummonWaterElemental_2||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [30]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_FrostBlast||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [31]
		[35] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sArcane Missiles||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_StarFall||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[36] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sArcane Explosion||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_WispSplode||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[37] = {
			["buttonTypeData"] = "001001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Polymorph||002||Interface\\Icons\\Spell_Magic_PolymorphPig||003||Interface\\Icons\\Ability_Hunter_Pet_Turtle||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sPolymorph||002||s ||003||s ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[38] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_IceShock||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[39] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||12042||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[40] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Arcane_Blast||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[41] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Slow||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[42] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Mage_Invisibility||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[43] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||55342||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[44] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Arcane_Arcane02||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[45] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||44425||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[47] = {
			["buttonTypeData"] = "043033035000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Potion_70||002||Interface\\Icons\\INV_Potion_50||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionData"] = "||001||iMinor Mana Potion||002||iLesser Healing Potion||003||i ||00X|| ",
			["showCount"] = true,
		},
		[48] = {
			["buttonTypeData"] = "045001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iitem:5514||002||s ||003|| ||00X|| ",
			["child"] = true,
			["showCount"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Gem_Emerald_01||002||759||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[49] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["showCount"] = true,
			["actionTexture"] = "||001||43987||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[50] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["showCount"] = true,
			["actionTexture"] = "||001||42955||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[50] = nil,
		[51] = nil,
		[52] = nil,
		[53] = nil,
		[119] = {
			["buttonTypeData"] = "001001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\7302:::168||002||Interface\\Icons\\Ability_Mage_MoltenArmor||003||Interface\\Icons\\Spell_MageArmor||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002||s ||003||s ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[121] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sDampen Magic||002||sAmplify Magic||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_AbolishMagic||002||Interface\\Icons\\Spell_Holy_FlashHeal||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[123] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_DetectLesserInvisibility||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[125] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sRemove Lesser Curse||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_RemoveCurse||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[127] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sSlow Fall||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Magic_FeatherFall||002|| ||003|| ||00X|| ",
			["showCount"] = true,
		},
		[108] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\3567:::3562||002||Interface\\Icons\\11417:::11416||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[110] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\3566:::3565||002||Interface\\Icons\\11420:::11419||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[112] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Arcane_TeleportShattrath||002||Interface\\Icons\\Spell_Arcane_PortalShattrath||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[113] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Arcane_TeleportDalaran||002||Interface\\Icons\\Spell_Arcane_PortalDalaran||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[120] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_MagicalSentry||002||Interface\\Icons\\Spell_Holy_ArcaneIntellect||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sArcane Intellect||002||s ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[122] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_FireArmor||002||Interface\\Icons\\Spell_Frost_FrostWard||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[124] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Ice_Lament||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[126] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Purge||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[107] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\3563:::3561||002||Interface\\Icons\\11418:::10059||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[109] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\32272:::32271||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[111] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\49359:::49358||002||Interface\\Icons\\49360:::49361||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[128] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Arcane_Blink||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		["mainButtonCount"] = 10,
	},
};

Lunar.Template.template[3] = 
{
	["listData"] = Lunar.Locale["TEMPLATE_DRUID"] .. ":::DRUID:::10101:::",
	["sphere"] = defaultSphereTemplateSettings,
	["skin"] = mergeSettings({}, defaultSkinTemplateSettings, {
		["vividButtons"] = true,
		["outerGaugeColor"] = {
			0.1372549019607843, -- [1]
			1, -- [2]
			0, -- [3]
		},
		["sphereSkin"] = 16,
	}),
	["buttonData"] = {
		{
			["isMenu"] = true,
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Brilliance||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [1]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["isMenu"] = true,
			["useStances"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Druid_PredatoryInstincts||002|| ||003|| ||00X|| ||011||Interface\\Icons\\Ability_Druid_PredatoryInstincts||012|| ||013|| ||01X|| ||021||Interface\\Icons\\Ability_Druid_PredatoryInstincts||022|| ||023|| ||02X|| ||031||Interface\\Icons\\Ability_Druid_PredatoryInstincts||032|| ||033|| ||03X|| ||041||Interface\\Icons\\Ability_Druid_PredatoryInstincts||042|| ||043|| ||04X|| ||051||Interface\\Icons\\Ability_Druid_PredatoryInstincts||052|| ||053|| ||05X|| ||061||Interface\\Icons\\Ability_Druid_PredatoryInstincts||062|| ||063|| ||06X|| ||071||Interface\\Icons\\Ability_Druid_PredatoryInstincts||072|| ||073|| ||07X|| ||081||Interface\\Icons\\Ability_Druid_PredatoryInstincts||082|| ||083|| ||08X|| ",
		}, -- [2]
		{
			["isMenu"] = true,
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Druid_HealingInstincts||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [3]
		{
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["buttonTypeData"] = "021011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Food_62||002||Interface\\Icons\\INV_Drink_12||003|| ||00X|| ",
			["actionData"] = "||001||iWinter Veil Cookie||002||iSweet Nectar||003|| ||00X|| ",
			["showCount"] = true,
		}, -- [4]
		{
			["buttonTypeData"] = "031041000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iGreater Healing Potion||002||iMana Potion||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Potion_52||002||Interface\\Icons\\INV_Potion_72||003|| ||00X|| ",
			["showCount"] = true,
		}, -- [5]
		{
			["buttonTypeData"] = "080001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionData"] = "||001||i ||002||iitem:6948||003||sTeleport: Moonglade||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Foot_Centaur||002||Interface\\Icons\\INV_Misc_Rune_01||003||Interface\\Icons\\Spell_Arcane_TeleportMoonglade||00X|| ",
		}, -- [6]
		{
			["buttonTypeData"] = "131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_QuestionMark||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||t/use 14||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [7]
		{
			["buttonTypeData"] = "130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||t/use 13||002|| ||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_QuestionMark||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [8]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["isMenu"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Regeneration||002|| ||003|| ||00X|| ",
		}, -- [9]
		{
			["isMenu"] = true,
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_HealingTouch||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [10]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_AbolishMagic||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [11]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_StarFall||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [12]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_StrangleVines||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [13]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||770||002||16857||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [14]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Sleep||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [15]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_InsectSwarm||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [16]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Arcane_StarFire||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [17]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Hunter_BeastSoothe||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [18]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Cyclone||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [19]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Druid_ForceofNature||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [20]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_EarthBind||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [21]
		nil, -- [22]
		{
			["buttonTypeData"] = "000000000001000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Druid_DemoralizingRoar||012|| ||013|| ||01X|| ||031||Interface\\Icons\\Ability_Druid_Rake||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||031||s ||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [23]
		{
			["buttonTypeData"] = "000000000001000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||031||s ||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Physical_Taunt||012|| ||013|| ||01X|| ||031||Interface\\Icons\\Ability_GhoulFrenzy||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [24]
		{
			["buttonTypeData"] = "000000000001000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Druid_DemoralizingRoar||012|| ||013|| ||01X|| ||031||Interface\\Icons\\Spell_Shadow_VampiricAura||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||031||s ||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [25]
		{
			["buttonTypeData"] = "000000000001000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Druid_Enrage||012|| ||013|| ||01X|| ||031||Interface\\Icons\\Ability_Druid_Disembowel||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||031||s ||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [26]
		{
			["buttonTypeData"] = "000000000001000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Druid_Bash||012|| ||013|| ||01X|| ||031||Interface\\Icons\\Ability_Mount_JungleTiger||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||031||s ||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [27]
		{
			["buttonTypeData"] = "000000000001000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||031||s ||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\INV_Misc_MonsterClaw_03||012|| ||013|| ||01X|| ||031||Interface\\Icons\\Ability_Druid_Dash||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [28]
		{
			["buttonTypeData"] = "000000000001000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||031||s ||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Hunter_Pet_Bear||012|| ||013|| ||01X|| ||031||Interface\\Icons\\Ability_Druid_Cower||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [29]
		{
			["buttonTypeData"] = "000000000001000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||031||s ||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Druid_ChallangingRoar||012|| ||013|| ||01X|| ||031||Interface\\Icons\\Ability_Druid_FerociousBite||032|| ||033|| ||03X|| ||051|| ||052|| ||053|| ||05X|| ||001|| ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [30]
		{
			["buttonTypeData"] = "000000000001000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_BullRush||012|| ||013|| ||01X|| ||031||Interface\\Icons\\Ability_Druid_Ravage||032|| ||033|| ||03X|| ",
			["child"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||031||s ||032|| ||033|| ||03X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [31]
		{
			["buttonTypeData"] = "000000000001000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||33878||012|| ||013|| ||01X|| ||031||Interface\\Icons\\Ability_Druid_SupriseAttack||032|| ||033|| ||03X|| ",
			["child"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||031||s ||032|| ||033|| ||03X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [32]
		{
			["buttonTypeData"] = "000000000001000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||031||s ||032|| ||033|| ||03X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Druid_Lacerate||012|| ||013|| ||01X|| ||031||Interface\\Icons\\Ability_Druid_Mangle||032|| ||033|| ||03X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [33]
		nil, -- [34]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Racial_Bearform||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [35]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Druid_AquaticForm||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [36]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Druid_CatForm||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [37]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Druid_TravelForm||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [38]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Druid_FlightForm||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [39]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Druid_TreeofLife||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [40]
		[113] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Druid_Dash||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[115] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||17007||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[119] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_HealingTouch||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[121] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_ResistNature||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[123] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Reincarnation||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[125] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Tranquility||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[127] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Herb_Felblossom||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[108] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Thorns||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[110] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_CrystalBall||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[112] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Ambush||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[114] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Tracking||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[116] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_RavenForm||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[120] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Rejuvenation||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[122] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_NullifyPoison||002||Interface\\Icons\\Spell_Nature_NullifyPoison_02||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[124] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_RemoveCurse||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[126] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Lightning||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[107] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Regeneration||002||Interface\\Icons\\Spell_Nature_GiftoftheWild||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[109] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_NaturesWrath||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[111] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_StoneClawTotem||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[128] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Relics_IdolofRejuvenation||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		["mainButtonCount"] = 10,
	},
};

Lunar.Template.template[4] = {
	["listData"] = Lunar.Locale["TEMPLATE_WARLOCK"] .. ":::WARLOCK:::10101:::",
	["sphere"] = defaultSphereTemplateSettings,
	["skin"] = mergeSettings({}, defaultSkinTemplateSettings, {
		
		["sphereColor"] = {
			0.7450980392156863, -- [1]
			0.7450980392156863, -- [2]
			0.7450980392156863, -- [3]
		},
		["sphereSkin"] = 12,
	}),
	["buttonData"] = {
		{
			["isMenu"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_Immolation||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [1]
		{
			["isMenu"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Haunting||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [2]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_CurseOfMannoroth||002|| ||003|| ||00X|| ",
			["isMenu"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [3]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_RagingScream||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["isMenu"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
		}, -- [4]
		{
			["isMenu"] = true,
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Stone_04||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [5]
		{
			["buttonTypeData"] = "081001082000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||i ||002||iitem:6948||003||i ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Mount_NightmareHorse||002||Interface\\Icons\\INV_Misc_Rune_01||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [6]
		{
			["actionTexture"] = "||001||Interface\\Icons\\INV_Potion_49||002|| ||003|| ||00X|| ",
			["showCount"] = true,
			["buttonTypeData"] = "031041035000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iMinor Healing Potion||002||i ||003||i ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [7]
		{
			["buttonTypeData"] = "021011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iSpice Bread||002||iRefreshing Spring Water||003|| ||00X|| ",
			["showCount"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Food_95_Grainbread||002||Interface\\Icons\\INV_Drink_07||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [8]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Metamorphosis||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["isMenu"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
		}, -- [9]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_SummonImp||002|| ||003|| ||00X|| ",
			["isMenu"] = true,
		}, -- [10]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sImmolate||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_Immolation||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [11]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sShadow Bolt||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_ShadowBolt||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [12]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sCorruption||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_AbominationExplosion||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [13]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_SoulBurn||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [14]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Cripple||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [15]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Requiem||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [16]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_Fireball||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [17]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_DeathCoil||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [18]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_Fireball02||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [19]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Shadowfury||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [20]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_Burnout||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [21]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_SeedOfDestruction||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [22]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Haunting||002||17877||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sDrain Soul||002||s ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [23]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_LifeDrain||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sHealth Funnel||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [24]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_LifeDrain02||002||Interface\\Icons\\Spell_Shadow_SiphonMana||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [25]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_RainOfFire||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [26]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_Incinerate||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [27]
		nil, -- [28]
		nil, -- [29]
		nil, -- [30]
		nil, -- [31]
		nil, -- [32]
		nil, -- [33]
		nil, -- [34]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_CurseOfMannoroth||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sCurse of Weakness||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [35]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sCurse of Agony||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_CurseOfSargeras||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [36]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_UnholyStrength||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [37]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_CurseOfTounges||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [38]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||18223||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [39]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_ChillTouch||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [40]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_CurseOfAchimonde||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [41]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_AuraOfDarkness||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [42]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||18288||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [43]
		nil, -- [44]
		nil, -- [45]
		nil, -- [46]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\706:::687||002||Interface\\Icons\\Spell_Shadow_FelArmour||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [47]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_BurningSpirit||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sLife Tap||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [48]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Possession||002||Interface\\Icons\\Spell_Shadow_DeathScream||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sFear||002||s ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [49]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_DemonBreath||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [50]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Twilight||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [51]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Metamorphosis||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [52]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_DetectLesserInvisibility||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [53]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_AntiShadow||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [54]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Arcane_Arcane01||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [55]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\18540||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [56]
		nil, -- [57]
		nil, -- [58]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iLSHealthStone1||002||sCreate Healthstone(Rank 1)||003|| ||00X|| ",
			["child"] = true,
			["showCount"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Stone_04||002||Interface\\Icons\\INV_Stone_04||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [59]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iLSHealthStone2||002||sCreate Healthstone(Rank 2)||003|| ||00X|| ",
			["child"] = true,
			["showCount"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Stone_04||002||Interface\\Icons\\INV_Stone_04||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [60]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iLSHealthStone3||002||sCreate Healthstone(Rank 3)||003|| ||00X|| ",
			["child"] = true,
			["showCount"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Stone_04||002||Interface\\Icons\\INV_Stone_04||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [61]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iLSHealthStone4||002||sCreate Healthstone(Rank 4)||003|| ||00X|| ",
			["child"] = true,
			["showCount"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Stone_04||002||Interface\\Icons\\INV_Stone_04||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [62]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iLSHealthStone5||002||sCreate Healthstone(Rank 5)||003|| ||00X|| ",
			["child"] = true,
			["showCount"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Stone_04||002||Interface\\Icons\\INV_Stone_04||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [63]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iLSHealthStone6||002||sCreate Healthstone(Rank 6)||003|| ||00X|| ",
			["child"] = true,
			["showCount"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Stone_04||002||Interface\\Icons\\INV_Stone_04||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [64]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_SoulGem||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [65]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Ammo_FireTar||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [66]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Gem_Sapphire_01||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [67]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Shadesofdarkness||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [68]
		nil, -- [69]
		nil, -- [70]
		nil, -- [71]
		nil, -- [72]
		nil, -- [73]
		nil, -- [74]
		nil, -- [75]
		nil, -- [76]
		nil, -- [77]
		nil, -- [78]
		nil, -- [79]
		nil, -- [80]
		nil, -- [81]
		nil, -- [82]
		nil, -- [83]
		nil, -- [84]
		nil, -- [85]
		nil, -- [86]
		nil, -- [87]
		nil, -- [88]
		nil, -- [89]
		nil, -- [90]
		nil, -- [91]
		nil, -- [92]
		nil, -- [93]
		nil, -- [94]
		nil, -- [95]
		nil, -- [96]
		nil, -- [97]
		nil, -- [98]
		nil, -- [99]
		nil, -- [100]
		nil, -- [101]
		nil, -- [102]
		nil, -- [103]
		nil, -- [104]
		nil, -- [105]
		nil, -- [106]
		{
			["buttonTypeData"] = "140000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s1||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_GhoulFrenzy||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [107]
		{
			["buttonTypeData"] = "141000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s2||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Tracking||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [108]
		{
			["buttonTypeData"] = "142000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s3||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_TimeStop||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [109]
		{
			["buttonTypeData"] = "143000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s4||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_FireBolt||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [110]
		{
			["buttonTypeData"] = "144000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s5||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_WispSplode||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [111]
		{
			["buttonTypeData"] = "145000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s6||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_WispSplode||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [112]
		{
			["buttonTypeData"] = "146000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s7||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [113]
		{
			["buttonTypeData"] = "147000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s8||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Racial_BloodRage||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [114]
		{
			["buttonTypeData"] = "148000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s9||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Defend||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [115]
		{
			["buttonTypeData"] = "149000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s10||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Seal||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [116]
		nil, -- [117]
		nil, -- [118]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sSummon Imp(Summon)||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_SummonImp||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [119]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sSummon Voidwalker(Summon)||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_SummonVoidWalker||002|| ||003|| ||00X|| ",
			["showCount"] = true,
		}, -- [120]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_SummonSuccubus||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [121]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_SummonFelHunter||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [122]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_SummonInfernal||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [123]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_SummonFelGuard||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [124]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_EvilEye||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [125]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_EnslaveDemon||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [126]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||18708||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [127]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||18788||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [128]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_DarkRitual||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [129]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_GatherShadows||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [130]
		[0] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iitem:6265||002|| ||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Gem_Amethyst_02||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
		},
		["mainButtonCount"] = 10,
	},
};

Lunar.Template.template[5] = {
	["listData"] = Lunar.Locale["TEMPLATE_WARRIOR"] .. ":::WARRIOR:::10101:::",
	["sphere"] = defaultSphereTemplateSettings,
	["skin"] = mergeSettings({}, defaultSkinTemplateSettings, {
		["vividButtons"] = true,
		["innerGaugeColor"] = {
			1, -- [1]
			0, -- [2]
			0, -- [3]
		},
		["sphereSkin"] = 19,
	}),
	["buttonData"] = {
		{
			["isMenu"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonTypeData"] = "000000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_MeleeDamage||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [1]
		{
			["buttonTypeData"] = "000000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_OffensiveStance||012|| ||013|| ||01X|| ||021||Interface\\Icons\\Ability_Warrior_DefensiveStance||022|| ||023|| ||02X|| ||031||Interface\\Icons\\Ability_Racial_Avatar||032|| ||033|| ||03X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["useStances"] = true,
			["isMenu"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
		}, -- [2]
		{
			["buttonTypeData"] = "000000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["isMenu"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_DualWieldSpecialization||012|| ||013|| ||01X|| ",
		}, -- [3]
		{
			["showCount"] = true,
			["buttonTypeData"] = "000000000071000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001|| ||002|| ||003|| ||00X|| ||011||iitem: ||012|| ||013|| ||01X|| ",
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ||011||Interface\\Icons\\INV_Misc_Bandage_02||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [4]
		{
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ||011||Interface\\Icons\\INV_Potion_131||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["buttonTypeData"] = "000000000031061000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001|| ||002|| ||003|| ||00X|| ||011||iitem: ||012||iitem: ||013|| ||01X|| ",
			["showCount"] = true,
		}, -- [5]
		{
			["buttonTypeData"] = "000000000081001082000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001|| ||002|| ||003|| ||00X|| ||011||i ||012||iitem:6948||013||i ||01X|| ",
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ||011||Interface\\Icons\\Ability_Mount_NightmareHorse||012||Interface\\Icons\\INV_Misc_Rune_01||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [6]
		{
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["buttonTypeData"] = "000000000021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001|| ||002|| ||003|| ||00X|| ||011||iitem: ||012|| ||013|| ||01X|| ",
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ||011||Interface\\Icons\\INV_Misc_Food_18||012|| ||013|| ||01X|| ",
			["showCount"] = true,
		}, -- [7]
		{
			["actionData"] = "||001|| ||002|| ||003|| ||00X|| ||011||t/use 13||012||t/use 14||013|| ||01X|| ",
			["buttonTypeData"] = "000000000130131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ||011||Interface\\Icons\\INV_Misc_QuestionMark||012||Interface\\Icons\\INV_Misc_QuestionMark||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [8]
		{
			["buttonTypeData"] = "000000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_BullRush||012|| ||013|| ||01X|| ",
			["isMenu"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [9]
		{
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_BattleShout||012|| ||013|| ||01X|| ",
			["buttonTypeData"] = "000000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["isMenu"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [10]
		{
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||sHeroic Strike||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Rogue_Ambush||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [11]
		{
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||12798||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [12]
		{
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_Sunder||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [13]
		{
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_Cleave||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [14]
		{
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_ThunderBolt||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [15]
		{
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_DecisiveStrike||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [16]
		{
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||23881||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [17]
		{
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_SavageBlow||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [18]
		{
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\INV_Shield_05||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [19]
		{
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\INV_Sword_11||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [20]
		nil, -- [21]
		nil, -- [22]
		{
			["buttonTypeData"] = "000000000001000000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||sCharge||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_Charge||012|| ||013|| ||01X|| ||021||Interface\\Icons\\Ability_Gouge||022|| ||023|| ||02X|| ||031||Interface\\Icons\\Ability_ShockWave||032|| ||033|| ||03X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [23]
		{
			["buttonTypeData"] = "000000000001000000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Gouge||012|| ||013|| ||01X|| ||021||Interface\\Icons\\Spell_Nature_ThunderClap||022|| ||023|| ||02X|| ||031||Interface\\Icons\\INV_Sword_48||032|| ||033|| ||03X|| ",
			["child"] = true,
			["actionData"] = "||011||sRend||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [24]
		{
			["buttonTypeData"] = "000000000001000000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Spell_Nature_ThunderClap||012|| ||013|| ||01X|| ||021||355||022|| ||023|| ||02X|| ||031||12328||032|| ||033|| ||03X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [25]
		{
			["buttonTypeData"] = "000000000001000000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_ShockWave||012|| ||013|| ||01X|| ||021||Interface\\Icons\\Ability_Warrior_ShieldBash||022|| ||023|| ||02X|| ||031||Interface\\Icons\\Ability_Rogue_Sprint||032|| ||033|| ||03X|| ",
			["child"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [26]
		{
			["buttonTypeData"] = "000000000001000000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_MeleeDamage||012|| ||013|| ||01X|| ||021||6572||022|| ||023|| ||02X|| ||031||Interface\\Icons\\Spell_Nature_AncestralGuardian||032|| ||033|| ||03X|| ",
			["child"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [27]
		{
			["buttonTypeData"] = "000000000001000000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_ShieldBash||012|| ||013|| ||01X|| ||021||2565||022|| ||023|| ||02X|| ||031||Interface\\Icons\\Ability_Whirlwind||032|| ||033|| ||03X|| ",
			["child"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [28]
		{
			["buttonTypeData"] = "000000000001000000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_PunishingBlow||012|| ||013|| ||01X|| ||021||Interface\\Icons\\Ability_Warrior_Disarm||022|| ||023|| ||02X|| ||031||Interface\\Icons\\INV_Gauntlets_04||032|| ||033|| ||03X|| ",
			["child"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [29]
		{
			["buttonTypeData"] = "000000000001000000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_Challange||012|| ||013|| ||01X|| ||021||Interface\\Icons\\Ability_Warrior_ShieldWall||022|| ||023|| ||02X|| ||031||Interface\\Icons\\Ability_CriticalStrike||032|| ||033|| ||03X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [30]
		{
			["buttonTypeData"] = "000000000001000000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\INV_Sword_48||012|| ||013|| ||01X|| ||021||Interface\\Icons\\Ability_Warrior_ShieldReflection||022|| ||023|| ||02X|| ||031||Interface\\Icons\\Ability_Warrior_Devastate||032|| ||033|| ||03X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [31]
		{
			["buttonTypeData"] = "000000000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ",
			["child"] = true,
			["actionTexture"] = "||011||12328||012|| ||013|| ||01X|| ||021||Interface\\Icons\\Ability_Warrior_VictoryRush||022|| ||023|| ||02X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [32]
		{
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_Devastate||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [33]
		{
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_ShieldReflection||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [34]
		{
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_OffensiveStance||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionData"] = "||011||sBattle Stance||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [35]
		{
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_DefensiveStance||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [36]
		{
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||2458||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [37]
		[121] = {
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||011||12292||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[110] = {
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_BullRush||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[122] = {
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||12975||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[119] = {
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||sBattle Shout||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_BattleShout||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[108] = {
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||12323||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[123] = {
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_Rampage||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[124] = {
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_RallyingCry||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[120] = {
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Racial_BloodRage||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[109] = {
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_GolemThunderClap||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		["mainButtonCount"] = 10,
		[107] = {
			["buttonTypeData"] = "000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||011||s ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||011||Interface\\Icons\\Ability_Warrior_WarCry||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
	},
};

Lunar.Template.template[6] = {
	["listData"] = Lunar.Locale["TEMPLATE_HUNTER"] .. ":::HUNTER:::10101:::",
	["sphere"] = defaultSphereTemplateSettings,
	["skin"] = mergeSettings({}, defaultSkinTemplateSettings, {
		["showSphereShine"] = false,
		["sphereSkin"] = 15,
	}),
	["buttonData"] = {
		{
			["isMenu"] = true,
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_RavenForm||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [1]
		{
			["isMenu"] = true,
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_MeleeDamage||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [2]
		{
			["isMenu"] = true,
			["buttonTypeData"] = "002001000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Weapon_Bow_12||002||Interface\\Icons\\Ability_Hunter_SniperShot||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [3]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_ChainsOfIce||002|| ||003|| ||00X|| ",
			["isMenu"] = true,
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [4]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Druid_PredatoryInstincts||002|| ||003|| ||00X|| ",
			["menuOpen"] = true,
			["isMenu"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
		}, -- [5]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Mount_NightmareHorse||002||Interface\\Icons\\INV_Misc_Rune_01||003|| ||00X|| ",
			["buttonTypeData"] = "081001082000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||i ||002||iitem:6948||003||i ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [6]
		{
			["actionData"] = "||001||iLesser Healing Potion||002||i ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["buttonTypeData"] = "031041000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Potion_50||002|| ||003|| ||00X|| ",
			["showCount"] = true,
		}, -- [7]
		{
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["buttonTypeData"] = "021011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iRed-speckled Mushroom||002||iRefreshing Spring Water||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Mushroom_11||002||Interface\\Icons\\INV_Drink_07||003|| ||00X|| ",
		}, -- [8]
		{
			["isMenu"] = true,
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_SpiritWolf||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [9]
		{
			["isMenu"] = true,
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Tracking||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [10]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Hunter_AspectOfTheMonkey||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sAspect of the Monkey||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [11]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_RavenForm||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sAspect of the Hawk||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [12]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\ability_mount_jungletiger||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [13]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\ability_mount_pinktiger||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [14]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\ability_mount_whitetiger||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [15]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\spell_nature_protectionformnature||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [16]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\ability_hunter_aspectoftheviper||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [17]
		nil, -- [18]
		nil, -- [19]
		nil, -- [20]
		nil, -- [21]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\ability_trueshot||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [22]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_MeleeDamage||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sRaptor Strike||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [23]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_Trip||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sWing Clip||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [24]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Druid_Cower||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sScare Beast||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [25]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\ability_hunter_swiftstrike||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [26]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\ability_rogue_feint||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [27]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\ability_rogue_feigndeath||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [28]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\ability_warrior_challange||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [29]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\ability_hunter_misdirection||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [30]
		nil, -- [31]
		nil, -- [32]
		nil, -- [33]
		nil, -- [34]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_ImpalingBolt||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sArcane Shot||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [35]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Hunter_Quickshot||002||Interface\\Icons\\inv_spear_02||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sSerpent Sting||002||s ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [36]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\ability_hunter_criticalshot||002||Interface\\Icons\\ability_hunter_aimedshot||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [37]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_Stun||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sConcussive Shot||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [38]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sDistracting Shot||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Arcane_Blink||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [39]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\ability_upgrademoonglaive||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [40]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\ability_hunter_runningshot||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [41]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\inv_spear_07||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [42]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\ability_marksmanship||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [43]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\spell_nature_drowsy||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [44]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\ability_hunter_steadyshot||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [45]
		nil, -- [46]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\spell_fire_flameshock||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [47]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\spell_frost_chainsofice||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [48]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\spell_frost_freezingbreath||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [49]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\spell_fire_selfdestruct||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [50]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\ability_hunter_snaketrap||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [51]
		nil, -- [52]
		nil, -- [53]
		nil, -- [54]
		nil, -- [55]
		nil, -- [56]
		nil, -- [57]
		nil, -- [58]
		{
			["buttonTypeData"] = "140000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||p1||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [59]
		{
			["buttonTypeData"] = "141000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||p2||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [60]
		{
			["buttonTypeData"] = "142000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||p3||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [61]
		{
			["buttonTypeData"] = "143000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||p4||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [62]
		{
			["buttonTypeData"] = "144000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||p5||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [63]
		{
			["buttonTypeData"] = "145000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||p6||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [64]
		{
			["buttonTypeData"] = "146000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||p7||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [65]
		{
			["buttonTypeData"] = "147000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||p8||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [66]
		{
			["buttonTypeData"] = "148000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||p9||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [67]
		{
			["buttonTypeData"] = "149000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||p10||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [68]
		[107] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Hunter_BeastCall||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sCall Pet||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[108] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_SpiritWolf||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sDismiss Pet||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[109] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Hunter_BeastTraining||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sFeed Pet||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[110] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Hunter_BeastSoothe||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sRevive Pet||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[111] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_EyeOfTheOwl||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sEyes of the Beast||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[112] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sMend Pet||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Hunter_MendPet||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[113] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Hunter_BeastTaming||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sTame Beast||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[114] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Hunter_BeastCall02||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sBeast Training||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[115] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\ability_physical_taunt||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[116] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\ability_druid_ferociousbite||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[117] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\ability_hunter_killcommand||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[119] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Tracking||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sTrack Beasts||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[120] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_PrayerOfHealing||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sTrack Humanoids||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[121] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\spell_shadow_darksummoning||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[122] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\ability_stealth||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[123] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\spell_frost_summonwaterelemental||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[124] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\spell_shadow_summonfelhunter||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[125] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||19882||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[126] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\inv_misc_head_dragon_01||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[130] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Hunter_EagleEye||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sEagle Eye||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[129] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\spell_fire_flare||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		["mainButtonCount"] = 10,
	},
};

Lunar.Template.template[7] = {
	["listData"] = Lunar.Locale["TEMPLATE_PRIEST"] .. ":::PRIEST:::10101:::",
	["sphere"] = defaultSphereTemplateSettings,
	["skin"] = mergeSettings({}, defaultSkinTemplateSettings, {
		["showSphereShine"] = false,
		["sphereSkin"] = 13,
	}),
	["buttonData"] = {
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Shadowform||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [1]
		{
			["actionData"] = "||001||sShadowfiend||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Shadowfiend||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [2]
		{
			["isMenu"] = true,
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_Heal02||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [3]
		{
			["isMenu"] = true,
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_ShadowWordPain||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
		}, -- [4]
		{
			["buttonTypeData"] = "041031000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iSuper Mana Potion||002||iSuper Healing Potion||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Potion_137||002||Interface\\Icons\\INV_Potion_131||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [5]
		{
			["buttonTypeData"] = "081001082000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Mount_CockatriceMountElite_Purple||002||Interface\\Icons\\INV_Misc_Rune_01||003||Interface\\Icons\\Ability_Mount_Wyvern_01||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionData"] = "||001||s35027||002||iitem:6948||003||s32244||00X|| ",
		}, -- [6]
		{
			["actionTexture"] = "||001||Interface\\Icons\\INV_Drink_Waterskin_12||002||Interface\\Icons\\INV_Misc_Food_45||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["buttonTypeData"] = "011021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iPurified Draenic Water||002||iUnderspore Pod||003|| ||00X|| ",
		}, -- [7]
		{
			["isMenu"] = true,
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_WordFortitude||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
		}, -- [8]
		{
			["isMenu"] = true,
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_UnholyFrenzy||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [9]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_Resurrection||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionData"] = "||001||sResurrection||002|| ||003|| ||00X|| ",
		}, -- [10]
		[105] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sCure Disease||002||sAbolish Disease||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_NullifyDisease||002||Interface\\Icons\\Spell_Nature_NullifyDisease||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[35] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_LesserHeal||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[36] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_Heal02||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sHeal||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[37] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_FlashHeal||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sFlash Heal||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[38] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_GreaterHeal||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sGreater Heal||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[39] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_Renew||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sRenew||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[40] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_BlindingHeal||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sBinding Heal||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[41] = {
			["buttonPadding"] = 0,
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_CircleOfRenewal||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sCircle of Healing||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[42] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sPrayer of Healing||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_PrayerOfHealing02||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[43] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_Restoration||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[44] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_PrayerOfMendingtga||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sPrayer of Mending||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[45] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sHymn of Hope||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SymbolOfHope||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[46] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_Penance||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[53] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_ShadowWordPain||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sShadow Word: Pain||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[107] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sPsychic Scream||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_PsychicScream||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[54] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sDevouring Plague||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_BlackPlague||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[109] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sMind Control||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_ShadowWordDominate||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[47] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sSmite||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_HolySmite||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[55] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_Stoicism||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[95] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_WordFortitude||002||Interface\\Icons\\Spell_Holy_PrayerOfFortitude||003|| ||00X|| ",
			["child"] = true,
			["showCount"] = true,
			["actionData"] = "||001||sPower Word: Fortitude||002||sPrayer of Fortitude||003|| ||00X|| ",
			["buttonSettings"] = "1210000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[111] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_ImpPhaseShift||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[48] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sHoly Fire||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SearingLight||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[56] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_MindShear||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[97] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_DivineSpirit||002||Interface\\Icons\\Spell_Holy_PrayerofSpirit||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[113] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sMind Soothe||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_MindSooth||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[49] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sMind Blast||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_UnholyFrenzy||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[57] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sHoly Nova||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_HolyNova||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[108] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sFade||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Magic_LesserInvisibilty||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[99] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sInner Fire||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_InnerFire||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[115] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Dispersion||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[110] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Slow||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sShackle Undead||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[50] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_ManaBurn||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sMana Burn||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[116] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SummonLightwell||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[114] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_WindWalkOn||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[112] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_DivineHymn||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[101] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_Excorcism||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sFear Ward||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[117] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sLevitate||002|| ||003|| ||00X|| ",
			["child"] = true,
			["showCount"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_LayOnHands||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[51] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_SiphonMana||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[118] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_MindVision||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sMind Vision||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[106] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sDispel Magic||002||sMass Dispel||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_DispelMagic||002||Interface\\Icons\\Spell_Arcane_MassDispel||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[104] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_GuardianSpirit||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[103] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_PainSupression||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[102] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_PowerInfusion||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[52] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_DemonicFortitude||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sShadow Word: Death||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[0] = {
			["buttonTypeData"] = "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001|| ||002|| ||003|| ||00X|| ",
			["actionTexture"] = "||001|| ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
		},
		[100] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sPower Word: Shield||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_PowerWordShield||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[96] = {
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sShadow Protection||002||sPrayer of Shadow Protection||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_AntiShadow||002||Interface\\Icons\\Spell_Holy_PrayerofShadowProtection||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		[98] = {
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_UnsummonBuilding||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		},
		["mainButtonCount"] = 10,
	},
};

Lunar.Template.template[8] = {
	["listData"] = Lunar.Locale["TEMPLATE_PALADIN"] .. ":::PALADIN:::10101:::",
	["sphere"] = defaultSphereTemplateSettings,
	["skin"] = mergeSettings({}, defaultSkinTemplateSettings, {
		["showSphereShine"] = false,
		["sphereSkin"] = 11,
	}),
	["buttonData"] = {
		{
			["buttonTypeData"] = "130131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionData"] = "||001||t/use 13||002||t/use 14||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_QuestionMark||002||Interface\\Icons\\INV_Misc_QuestionMark||003|| ||00X|| ",
		}, -- [1]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_RighteousFury||002|| ||003|| ||00X|| ",
			["isMenu"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [2]
		{
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_ThunderBolt||002|| ||003|| ||00X|| ",
			["isMenu"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [3]
		{
			["isMenu"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_HolyBolt||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [4]
		{
			["buttonTypeData"] = "031041000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iLesser Healing Potion||002||iMinor Mana Potion||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Potion_50||002||Interface\\Icons\\INV_Potion_70||003|| ||00X|| ",
			["showCount"] = true,
		}, -- [5]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Mount_NightmareHorse||002||Interface\\Icons\\INV_Misc_Rune_01||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["buttonTypeData"] = "081001082000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||i ||002||iitem:6948||003||i ||00X|| ",
		}, -- [6]
		{
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["buttonTypeData"] = "021011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iHaunch of Meat||002||iIce Cold Milk||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Food_18||002||Interface\\Icons\\INV_Drink_Milk_01||003|| ||00X|| ",
			["showCount"] = true,
		}, -- [7]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_DevotionAura||002|| ||003|| ||00X|| ",
			["isMenu"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [8]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_FistOfJustice||002|| ||003|| ||00X|| ",
			["isMenu"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [9]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SealOfProtection||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["isMenu"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [10]
		{
			["empty"] = true,
		}, -- [11]
		{
			["empty"] = true,
		}, -- [12]
		{
			["empty"] = true,
		}, -- [13]
		{
			["empty"] = true,
		}, -- [14]
		{
			["empty"] = true,
		}, -- [15]
		{
			["empty"] = true,
		}, -- [16]
		{
			["empty"] = true,
		}, -- [17]
		{
			["empty"] = true,
		}, -- [18]
		{
			["empty"] = true,
		}, -- [19]
		{
			["empty"] = true,
		}, -- [20]
		{
			["empty"] = true,
		}, -- [21]
		{
			["empty"] = true,
		}, -- [22]
		{
			["buttonTypeData"] = "001001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_RighteousFury||002||Interface\\Icons\\Ability_Paladin_JudgementBlue||003||Interface\\Icons\\Ability_Paladin_JudgementRed||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sJudgement of Light||002||s ||003||s ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [23]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sHammer of Justice||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SealOfMight||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [24]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_ThunderClap||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [25]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_AvengersShield||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [26]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_InnerFire||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [27]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_Excorcism_02||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [28]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SearingLight||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [29]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_Excorcism||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [30]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_CrusaderStrike||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [31]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Paladin_DivineStorm||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [32]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Paladin_HammeroftheRighteous||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [33]
		{
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Paladin_ShieldofVengeance||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [34]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sSeal of Righteousness||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_ThunderBolt||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [35]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SealOfWrath||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [36]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Warrior_InnerRage||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [37]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_HealingAura||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [38]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_RighteousnessAura||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [39]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SealOfVengeance||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [40]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SealOfBlood||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [41]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [42]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Shoulder_37||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [43]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SealOfFury||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [44]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_PrayerOfHealing||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [45]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_TurnUndead||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [46]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_HolyBolt||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sHoly Light||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [47]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_LayOnHands||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sLay on Hands||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [48]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_FlashHeal||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [49]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SearingLight||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [50]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_TimeStop||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [51]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Paladin_BeaconofLight||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [52]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Paladin_BlessedMending||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [53]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [54]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [55]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_Resurrection||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [56]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sPurify||002||s ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_Purify||002||Interface\\Icons\\Spell_Holy_Renew||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [57]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SenseUndead||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [58]
		{
			["empty"] = true,
		}, -- [59]
		{
			["empty"] = true,
		}, -- [60]
		{
			["empty"] = true,
		}, -- [61]
		{
			["empty"] = true,
		}, -- [62]
		{
			["empty"] = true,
		}, -- [63]
		{
			["empty"] = true,
		}, -- [64]
		{
			["empty"] = true,
		}, -- [65]
		{
			["empty"] = true,
		}, -- [66]
		{
			["empty"] = true,
		}, -- [67]
		{
			["empty"] = true,
		}, -- [68]
		{
			["empty"] = true,
		}, -- [69]
		{
			["empty"] = true,
		}, -- [70]
		{
			["empty"] = true,
		}, -- [71]
		{
			["empty"] = true,
		}, -- [72]
		{
			["empty"] = true,
		}, -- [73]
		{
			["empty"] = true,
		}, -- [74]
		{
			["empty"] = true,
		}, -- [75]
		{
			["empty"] = true,
		}, -- [76]
		{
			["empty"] = true,
		}, -- [77]
		{
			["empty"] = true,
		}, -- [78]
		{
			["empty"] = true,
		}, -- [79]
		{
			["empty"] = true,
		}, -- [80]
		{
			["empty"] = true,
		}, -- [81]
		{
			["empty"] = true,
		}, -- [82]
		{
			["empty"] = true,
		}, -- [83]
		{
			["empty"] = true,
		}, -- [84]
		{
			["empty"] = true,
		}, -- [85]
		{
			["empty"] = true,
		}, -- [86]
		{
			["empty"] = true,
		}, -- [87]
		{
			["empty"] = true,
		}, -- [88]
		{
			["empty"] = true,
		}, -- [89]
		{
			["empty"] = true,
		}, -- [90]
		{
			["empty"] = true,
		}, -- [91]
		{
			["empty"] = true,
		}, -- [92]
		{
			["empty"] = true,
		}, -- [93]
		{
			["empty"] = true,
		}, -- [94]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_DevotionAura||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sDevotion Aura||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [95]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sRetribution Aura||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_AuraOfLight||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [96]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_MindSooth||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [97]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_SealOfKings||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [98]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_WizardMark||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [99]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_SealOfFire||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [100]
		{
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_CrusaderAura||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [101]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [102]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [103]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [104]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [105]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [106]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_FistOfJustice||002||Interface\\Icons\\Spell_Holy_GreaterBlessingofKings||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sBlessing of Might||002||s ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [107]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SealOfWisdom||002||Interface\\Icons\\Spell_Holy_GreaterBlessingofWisdom||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sBlessing of Wisdom||002||s ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [108]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Magic_MageArmor||002||Interface\\Icons\\Spell_Magic_GreaterBlessingofKings||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [109]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_LightningShield||002||Interface\\Icons\\Spell_Holy_GreaterBlessingofSanctuary||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [110]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [111]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_BlessingOfProtection||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [112]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_AvengineWrath||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [113]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_Heal||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [114]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_DivineIllumination||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [115]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [116]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [117]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [118]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SealOfProtection||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sHand of Protection||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [119]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SealOfValor||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [120]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_SealOfSalvation||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [121]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||6940||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [122]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_Restoration||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sDivine Protection||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [123]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Holy_DivineIntervention||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [124]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [125]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [126]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [127]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [128]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [129]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [130]
		[0] = {
			["empty"] = true,
		},
		["mainButtonCount"] = 10,
	},
};

Lunar.Template.template[9] = {
	["listData"] = Lunar.Locale["TEMPLATE_SHAMAN"] .. ":::SHAMAN:::10101:::",
	["sphere"] = defaultSphereTemplateSettings,
	["skin"] = mergeSettings({}, defaultSkinTemplateSettings, {
		["showSphereShine"] = false,
		["sphereSkin"] = 14,
	}),
	["buttonData"] = {
		{
			["buttonTypeData"] = "031041000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Potion_131||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||i ||002||i ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [1]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Lightning||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["isMenu"] = true,
		}, -- [2]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_MagicImmunity||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["isMenu"] = true,
		}, -- [3]
		{
			["buttonTypeData"] = "002003004002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002||s ||003||s ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["isMenu"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_RockBiter||002|| ||003|| ||00X|| ",
		}, -- [4]
		{
			["buttonTypeData"] = "021011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Food_11||002||Interface\\Icons\\INV_Drink_07||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionData"] = "||001||iTough Hunk of Bread||002||iRefreshing Spring Water||003|| ||00X|| ",
		}, -- [5]
		{
			["actionData"] = "||001||i ||002||iitem:6948||003||i ||00X|| ",
			["buttonTypeData"] = "081001082000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Mount_NightmareHorse||002||Interface\\Icons\\INV_Misc_Rune_01||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [6]
		{
			["buttonTypeData"] = "002003004002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Elemental_Primal_Air||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionData"] = "||001||s ||002||s ||003||s ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["isMenu"] = true,
		}, -- [7]
		{
			["buttonTypeData"] = "002003004002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002||s ||003||s ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["isMenu"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Acid_01||002|| ||003|| ||00X|| ",
		}, -- [8]
		{
			["buttonTypeData"] = "002003004002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002||s ||003||s ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["isMenu"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Elemental_Primal_Fire||002|| ||003|| ||00X|| ",
		}, -- [9]
		{
			["buttonTypeData"] = "002003004002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Elemental_Primal_Earth||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionData"] = "||001||s ||002||s ||003||s ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["isMenu"] = true,
		}, -- [10]
		{
			["empty"] = true,
		}, -- [11]
		{
			["empty"] = true,
		}, -- [12]
		{
			["empty"] = true,
		}, -- [13]
		{
			["empty"] = true,
		}, -- [14]
		{
			["empty"] = true,
		}, -- [15]
		{
			["empty"] = true,
		}, -- [16]
		{
			["empty"] = true,
		}, -- [17]
		{
			["empty"] = true,
		}, -- [18]
		{
			["empty"] = true,
		}, -- [19]
		{
			["empty"] = true,
		}, -- [20]
		{
			["empty"] = true,
		}, -- [21]
		{
			["empty"] = true,
		}, -- [22]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sLightning Bolt||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Lightning||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [23]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_EarthShock||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [24]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_FlameShock||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [25]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||57994||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [26]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_FrostShock||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [27]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_ChainLightning||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [28]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_PlayingWithFire||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [29]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shaman_ThunderStorm||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [30]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shaman_LavaBurst||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [31]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Shaman_Stormstrike||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [32]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shaman_FeralSpirit||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [33]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shaman_Hex||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [34]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sHealing Wave||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_MagicImmunity||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [35]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_HealingWaveLesser||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [36]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_HealingWaveGreater||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [37]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Druid_Typhoon||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [38]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\2825:::32182||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [39]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_unused||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [40]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Purge||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [41]
		{
			["buttonTypeData"] = "001001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_NullifyPoison||002||Interface\\Icons\\Spell_Shaman_SpectralTransformation||003||Interface\\Icons\\Spell_Nature_RemoveDisease||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002||s ||003||s ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [42]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_DemonBreath||002||Interface\\Icons\\Spell_Frost_WindWalkOn||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [43]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_FarSight||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [44]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_AstralRecal||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [45]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Regenerate||002||Interface\\Icons\\Spell_Nature_Reincarnation||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [46]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_RockBiter||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [47]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_FlameTounge||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [48]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_FrostBrand||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [49]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shaman_EarthlivingWeapon||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [50]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||8232||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [51]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_LightningShield||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [52]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Shaman_WaterShield||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [53]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_SkinofEarth||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [54]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_Frostbolt||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [55]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_RavenForm||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [56]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_WispHeal||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [57]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_ShamanRage||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [58]
		{
			["empty"] = true,
		}, -- [59]
		{
			["empty"] = true,
		}, -- [60]
		{
			["empty"] = true,
		}, -- [61]
		{
			["empty"] = true,
		}, -- [62]
		{
			["empty"] = true,
		}, -- [63]
		{
			["empty"] = true,
		}, -- [64]
		{
			["empty"] = true,
		}, -- [65]
		{
			["empty"] = true,
		}, -- [66]
		{
			["empty"] = true,
		}, -- [67]
		{
			["empty"] = true,
		}, -- [68]
		{
			["empty"] = true,
		}, -- [69]
		{
			["empty"] = true,
		}, -- [70]
		{
			["empty"] = true,
		}, -- [71]
		{
			["empty"] = true,
		}, -- [72]
		{
			["empty"] = true,
		}, -- [73]
		{
			["empty"] = true,
		}, -- [74]
		{
			["empty"] = true,
		}, -- [75]
		{
			["empty"] = true,
		}, -- [76]
		{
			["empty"] = true,
		}, -- [77]
		{
			["empty"] = true,
		}, -- [78]
		{
			["empty"] = true,
		}, -- [79]
		{
			["empty"] = true,
		}, -- [80]
		{
			["empty"] = true,
		}, -- [81]
		{
			["empty"] = true,
		}, -- [82]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_GroundingTotem||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [83]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_NatureResistanceTotem||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [84]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_Windfury||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [85]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_RemoveCurse||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [86]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_SlowingTotem||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [87]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [88]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [89]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [90]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [91]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [92]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [93]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [94]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Spear_04||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [95]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_PoisonCleansingTotem||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [96]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_ManaRegenTotem||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [97]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_FireResistanceTotem_01||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [98]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_DiseaseCleansingTotem||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [99]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_SummonWaterElemental||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [100]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [101]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [102]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [103]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [104]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [105]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [106]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_SearingTotem||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [107]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_SealOfFire||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [108]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_FrostResistanceTotem_01||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [109]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_SelfDestruct||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [110]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_GuardianWard||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [111]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_TotemOfWrath||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [112]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Fire_Elemental_Totem||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [113]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [114]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [115]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [116]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [117]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [118]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_StoneSkinTotem||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [119]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_StrengthOfEarthTotem02||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [120]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_StoneClawTotem||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [121]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_EarthBindTotem||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [122]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_TremorTotem||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [123]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_EarthElemental_Totem||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [124]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [125]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [126]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [127]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [128]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [129]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [130]
		[0] = {
			["empty"] = true,
		},
		["mainButtonCount"] = 10,
	},
};

Lunar.Template.template[10] = {
	["listData"] = Lunar.Locale["TEMPLATE_DEATHKNIGHT"] .. ":::DEATHKNIGHT:::10101:::",
	["sphere"] = defaultSphereTemplateSettings,
	["skin"] = mergeSettings({}, defaultSkinTemplateSettings, {
		["showSphereShine"] = false,
		["sphereSkin"] = 20,
	}),
	["buttonData"] = {
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["isMenu"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Deathknight_BloodPresence||002|| ||003|| ||00X|| ",
		}, -- [1]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["menuOpen"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["isMenu"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_ChainsOfIce||002|| ||003|| ||00X|| ",
		}, -- [2]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_Strangulate||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["isMenu"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [3]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_EmpowerRuneBlade||002|| ||003|| ||00X|| ",
			["isMenu"] = true,
		}, -- [4]
		{
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["buttonTypeData"] = "031021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Potion_54||002||Interface\\Icons\\INV_Mushroom_03||003|| ||00X|| ",
			["actionData"] = "||001||iMajor Healing Potion||002||iBlack Mushroom||003|| ||00X|| ",
		}, -- [5]
		{
			["buttonTypeData"] = "081001082000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s48778||002||sDeath Gate||003||iitem: ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_SummonDeathCharger||002||Interface\\Icons\\Spell_Arcane_TeleportUnderCity||003|| ||00X|| ",
		}, -- [6]
		{
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Statue_04||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||t/use 13||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [7]
		{
			["actionTexture"] = "||001||Interface\\Icons\\INV_Crown_15||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||t/use 14||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [8]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_ArmyOfTheDead||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012||s ||013|| ||01X|| ||021||s ||022||s ||023|| ||02X|| ||031||s ||032||s ||033|| ||03X|| ||041||s ||042||s ||043|| ||04X|| ||051||s ||052||s ||053|| ||05X|| ||061||s ||062||s ||063|| ||06X|| ||071||s ||072||s ||073|| ||07X|| ||081||s ||082||s ||083|| ||08X|| ||091||s ||092||s ||093|| ||09X|| ||101||s ||102||s ||103|| ||10X|| ||111||s ||112||s ||113|| ||11X|| ||121||s ||122||s ||123|| ||12X|| ",
			["isMenu"] = true,
		}, -- [9]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012||s ||013|| ||01X|| ||021||s ||022||s ||023|| ||02X|| ||031||s ||032||s ||033|| ||03X|| ||041||s ||042||s ||043|| ||04X|| ||051||s ||052||s ||053|| ||05X|| ||061||s ||062||s ||063|| ||06X|| ||071||s ||072||s ||073|| ||07X|| ||081||s ||082||s ||083|| ||08X|| ||091||s ||092||s ||093|| ||09X|| ||101||s ||102||s ||103|| ||10X|| ||111||s ||112||s ||113|| ||11X|| ||121||s ||122||s ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_IceBoundFortitude||002|| ||003|| ||00X|| ",
			["isMenu"] = true,
		}, -- [10]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||48266||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [11]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||48263||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [12]
		{
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||48265||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [13]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [14]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [15]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [16]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [17]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [18]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [19]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [20]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [21]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [22]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_MindFreeze||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sMind Freeze||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [23]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sChains of Ice||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_ChainsOfIce||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [24]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_SoulLeech_3||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [25]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_ShamanRage||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [26]
		{
			["actionTexture"] = "||001||Interface\\Icons\\INV_Staff_15||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [27]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [28]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [29]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [30]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [31]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [32]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [33]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [34]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sDeath Grip||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_Strangulate||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [35]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sDeath Coil||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_DeathCoil||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [36]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Creature_Disease_02||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [37]
		{
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_DeathAndDecay||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [38]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Contagion||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [39]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Hunter_RapidKilling||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [40]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sPestilence||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_PlagueCloud||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [41]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_BloodTap||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [42]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_RuneTap||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [43]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [44]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [45]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [46]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_EmpowerRuneBlade||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sPlague Strike||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [47]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sIcy Touch||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_IceTouch||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [48]
		{
			["actionData"] = "||001||sBlood Strike||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Deathknight_DeathStrike||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [49]
		{
			["actionData"] = "||001||sDeath Strike||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_Butcher2||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [50]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Frost_ArcticWinds||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sHowling Blast||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [51]
		{
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Weapon_Shortblade_40||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [52]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_ScourgeStrike||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [53]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_EmpowerRuneBlade2||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [54]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_DarkConviction||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [55]
		{
			["actionData"] = "||001||sBlood Boil||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_BloodBoil||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [56]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Deathknight_ClassIcon||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [57]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [58]
		{
			["empty"] = true,
		}, -- [59]
		{
			["empty"] = true,
		}, -- [60]
		{
			["empty"] = true,
		}, -- [61]
		{
			["empty"] = true,
		}, -- [62]
		{
			["empty"] = true,
		}, -- [63]
		{
			["empty"] = true,
		}, -- [64]
		{
			["empty"] = true,
		}, -- [65]
		{
			["empty"] = true,
		}, -- [66]
		{
			["empty"] = true,
		}, -- [67]
		{
			["empty"] = true,
		}, -- [68]
		{
			["empty"] = true,
		}, -- [69]
		{
			["empty"] = true,
		}, -- [70]
		{
			["empty"] = true,
		}, -- [71]
		{
			["empty"] = true,
		}, -- [72]
		{
			["empty"] = true,
		}, -- [73]
		{
			["empty"] = true,
		}, -- [74]
		{
			["empty"] = true,
		}, -- [75]
		{
			["empty"] = true,
		}, -- [76]
		{
			["empty"] = true,
		}, -- [77]
		{
			["empty"] = true,
		}, -- [78]
		{
			["empty"] = true,
		}, -- [79]
		{
			["empty"] = true,
		}, -- [80]
		{
			["empty"] = true,
		}, -- [81]
		{
			["empty"] = true,
		}, -- [82]
		{
			["empty"] = true,
		}, -- [83]
		{
			["empty"] = true,
		}, -- [84]
		{
			["empty"] = true,
		}, -- [85]
		{
			["empty"] = true,
		}, -- [86]
		{
			["empty"] = true,
		}, -- [87]
		{
			["empty"] = true,
		}, -- [88]
		{
			["empty"] = true,
		}, -- [89]
		{
			["empty"] = true,
		}, -- [90]
		{
			["empty"] = true,
		}, -- [91]
		{
			["empty"] = true,
		}, -- [92]
		{
			["empty"] = true,
		}, -- [93]
		{
			["empty"] = true,
		}, -- [94]
		{
			["empty"] = true,
		}, -- [95]
		{
			["empty"] = true,
		}, -- [96]
		{
			["empty"] = true,
		}, -- [97]
		{
			["empty"] = true,
		}, -- [98]
		{
			["empty"] = true,
		}, -- [99]
		{
			["empty"] = true,
		}, -- [100]
		{
			["empty"] = true,
		}, -- [101]
		{
			["empty"] = true,
		}, -- [102]
		{
			["empty"] = true,
		}, -- [103]
		{
			["empty"] = true,
		}, -- [104]
		{
			["empty"] = true,
		}, -- [105]
		{
			["empty"] = true,
		}, -- [106]
		{
			["buttonTypeData"] = "001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002||s ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||46584||002||52143||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [107]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Hunter_Pet_Bat||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [108]
		{
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Sword_07||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [109]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_ArmyOfTheDead||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [110]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_DeathPact||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [111]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [112]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [113]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [114]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [115]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [116]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [117]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [118]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_RaiseDead||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [119]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Armor_Helm_Plate_Naxxramas_RaidWarrior_C_01||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||sUnbreakable Armor||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [120]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_PathOfFrost||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [121]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_IceBoundFortitude||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [122]
		{
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Horn_02||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [123]
		{
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||48707||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [124]
		{
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_AntiMagicZone||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [125]
		{
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Chest_Leather_13||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [126]
		{
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_DeathKnight_BladedArmor||002|| ||003|| ||00X|| ",
			["child"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [127]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_LifeDrain||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [128]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_SoulLeech_2||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [129]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Sword_62||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [130]
		[0] = {
			["empty"] = true,
		},
		["mainButtonCount"] = 10,
	},
};

Lunar.Template.template[11] = {
	["listData"] = Lunar.Locale["TEMPLATE_ROGUE"] .. ":::ROGUE:::10101:::",
	["sphere"] = defaultSphereTemplateSettings,
	["skin"] = mergeSettings({}, defaultSkinTemplateSettings, {
		["showSphereShine"] = false,
		["sphereSkin"] = 17,
	}),
	["buttonData"] = {
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_RitualOfSacrifice||002|| ||003|| ||00X|| ",
			["isMenu"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [1]
		{
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_Eviscerate||002|| ||003|| ||00X|| ",
			["isMenu"] = true,
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [2]
		{
			["isMenu"] = true,
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Stealth||002|| ||003|| ||00X|| ||011|| ||012|| ||013|| ||01X|| ",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012||s ||013|| ||01X|| ||021||s ||022||s ||023|| ||02X|| ||031||s ||032||s ||033|| ||03X|| ||041||s ||042||s ||043|| ||04X|| ||051||s ||052||s ||053|| ||05X|| ||061||s ||062||s ||063|| ||06X|| ||071||s ||072||s ||073|| ||07X|| ||081||s ||082||s ||083|| ||08X|| ||091||s ||092||s ||093|| ||09X|| ||101||s ||102||s ||103|| ||10X|| ||111||s ||112||s ||113|| ||11X|| ||121||s ||122||s ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [3]
		{
			["buttonTypeData"] = "051000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Drink_Milk_05||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||i ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [4]
		{
			["buttonTypeData"] = "031021000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||i ||002||iCandy Corn||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Potion_131||002||Interface\\Icons\\INV_Misc_Food_30||003|| ||00X|| ",
		}, -- [5]
		{
			["buttonTypeData"] = "081001082000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Mount_NightmareHorse||002||Interface\\Icons\\INV_Misc_Rune_01||003|| ||00X|| ",
			["actionData"] = "||001||i ||002||iitem:6948||003||i ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [6]
		{
			["buttonTypeData"] = "131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_QuestionMark||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||t/use 14||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [7]
		{
			["buttonTypeData"] = "130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||t/use 13||002|| ||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_QuestionMark||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [8]
		{
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["isMenu"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Creature_Poison_06||002|| ||003|| ||00X|| ||011|| ||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [9]
		{
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_ShadowWard||002|| ||003|| ||00X|| ",
			["buttonTypeData"] = "002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000002000000",
			["isMenu"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ||011||s ||012|| ||013|| ||01X|| ||021||s ||022|| ||023|| ||02X|| ||031||s ||032|| ||033|| ||03X|| ||041||s ||042|| ||043|| ||04X|| ||051||s ||052|| ||053|| ||05X|| ||061||s ||062|| ||063|| ||06X|| ||071||s ||072|| ||073|| ||07X|| ||081||s ||082|| ||083|| ||08X|| ||091||s ||092|| ||093|| ||09X|| ||101||s ||102|| ||103|| ||10X|| ||111||s ||112|| ||113|| ||11X|| ||121||s ||122|| ||123|| ||12X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [10]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sSinister Strike||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_RitualOfSacrifice||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [11]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sBackstab||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_BackStab||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [12]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sGouge||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Gouge||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [13]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Warrior_Challange||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [14]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Curse||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [15]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_ShadowStrikes||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [16]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_LifeDrain||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [17]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_ThrowingKnife_04||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [18]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_FanofKnives||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [19]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [20]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [21]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [22]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sEviscerate||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_Eviscerate||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [23]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_SliceDice||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [24]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Warrior_Riposte||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [25]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_Rupture||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [26]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_KidneyShot||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [27]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_Disembowel||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [28]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_ThrowingKnife_06||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [29]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_MindSteal||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [30]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Kick||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [31]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_Feint||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [32]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_Dismantle||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [33]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_Distract||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [34]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||sStealth||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Stealth||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [35]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Sap||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [36]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_Garrote||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [37]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_Ambush||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [38]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_CheapShot||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [39]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_Possession||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [40]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_ShadowDance||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [41]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Bag_11||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [42]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_GrimWard||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [43]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_MoonKey||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [44]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [45]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [46]
		{
			["empty"] = true,
		}, -- [47]
		{
			["empty"] = true,
		}, -- [48]
		{
			["empty"] = true,
		}, -- [49]
		{
			["empty"] = true,
		}, -- [50]
		{
			["empty"] = true,
		}, -- [51]
		{
			["empty"] = true,
		}, -- [52]
		{
			["empty"] = true,
		}, -- [53]
		{
			["empty"] = true,
		}, -- [54]
		{
			["empty"] = true,
		}, -- [55]
		{
			["empty"] = true,
		}, -- [56]
		{
			["empty"] = true,
		}, -- [57]
		{
			["empty"] = true,
		}, -- [58]
		{
			["empty"] = true,
		}, -- [59]
		{
			["empty"] = true,
		}, -- [60]
		{
			["empty"] = true,
		}, -- [61]
		{
			["empty"] = true,
		}, -- [62]
		{
			["empty"] = true,
		}, -- [63]
		{
			["empty"] = true,
		}, -- [64]
		{
			["empty"] = true,
		}, -- [65]
		{
			["empty"] = true,
		}, -- [66]
		{
			["empty"] = true,
		}, -- [67]
		{
			["empty"] = true,
		}, -- [68]
		{
			["empty"] = true,
		}, -- [69]
		{
			["empty"] = true,
		}, -- [70]
		{
			["empty"] = true,
		}, -- [71]
		{
			["empty"] = true,
		}, -- [72]
		{
			["empty"] = true,
		}, -- [73]
		{
			["empty"] = true,
		}, -- [74]
		{
			["empty"] = true,
		}, -- [75]
		{
			["empty"] = true,
		}, -- [76]
		{
			["empty"] = true,
		}, -- [77]
		{
			["empty"] = true,
		}, -- [78]
		{
			["empty"] = true,
		}, -- [79]
		{
			["empty"] = true,
		}, -- [80]
		{
			["empty"] = true,
		}, -- [81]
		{
			["empty"] = true,
		}, -- [82]
		{
			["empty"] = true,
		}, -- [83]
		{
			["empty"] = true,
		}, -- [84]
		{
			["empty"] = true,
		}, -- [85]
		{
			["empty"] = true,
		}, -- [86]
		{
			["empty"] = true,
		}, -- [87]
		{
			["empty"] = true,
		}, -- [88]
		{
			["empty"] = true,
		}, -- [89]
		{
			["empty"] = true,
		}, -- [90]
		{
			["empty"] = true,
		}, -- [91]
		{
			["empty"] = true,
		}, -- [92]
		{
			["empty"] = true,
		}, -- [93]
		{
			["empty"] = true,
		}, -- [94]
		{
			["empty"] = true,
		}, -- [95]
		{
			["empty"] = true,
		}, -- [96]
		{
			["empty"] = true,
		}, -- [97]
		{
			["empty"] = true,
		}, -- [98]
		{
			["empty"] = true,
		}, -- [99]
		{
			["empty"] = true,
		}, -- [100]
		{
			["empty"] = true,
		}, -- [101]
		{
			["empty"] = true,
		}, -- [102]
		{
			["empty"] = true,
		}, -- [103]
		{
			["empty"] = true,
		}, -- [104]
		{
			["empty"] = true,
		}, -- [105]
		{
			["empty"] = true,
		}, -- [106]
		{
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["buttonTypeData"] = "120121000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iitem:3775||002||iitem:3775||003|| ||00X|| ||011|| ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_PoisonSting||002||Interface\\Icons\\Ability_PoisonSting||003|| ||00X|| ||011|| ||012|| ||013|| ||01X|| ",
			["showCount"] = true,
		}, -- [107]
		{
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["buttonTypeData"] = "056057000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Poisons||002|| ||003|| ||00X|| ||011|| ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionData"] = "||001||i ||002||i ||003|| ||00X|| ||011|| ||012|| ||013|| ||01X|| ",
		}, -- [108]
		{
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["buttonTypeData"] = "120121000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iitem:5237||002||iitem:5237||003|| ||00X|| ||011|| ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_NullifyDisease||002||Interface\\Icons\\Spell_Nature_NullifyDisease||003|| ||00X|| ||011|| ||012|| ||013|| ||01X|| ",
			["showCount"] = true,
		}, -- [109]
		{
			["buttonTypeData"] = "054055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||i ||002||i ||003|| ||00X|| ||011|| ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_DualWeild||002|| ||003|| ||00X|| ||011|| ||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [110]
		{
			["buttonTypeData"] = "058059000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||i ||002||i ||003|| ||00X|| ||011|| ||012|| ||013|| ||01X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Herb_16||002|| ||003|| ||00X|| ||011|| ||012|| ||013|| ||01X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [111]
		{
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
			["buttonTypeData"] = "052053000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||i ||002||i ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Nature_SlowPoison||002|| ||003|| ||00X|| ",
		}, -- [112]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [113]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [114]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [115]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [116]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [117]
		{
			["child"] = true,
			["empty"] = true,
		}, -- [118]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_ShadowWard||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [119]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_Sprint||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [120]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Vanish||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [121]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Ice_Lament||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [122]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Warrior_PunishingBlow||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [123]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_AntiShadow||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [124]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_ShadowWordDominate||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [125]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_Shadowstep||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [126]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_HungerforBlood||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [127]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_MurderSpree||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [128]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Spell_Shadow_NetherCloak||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [129]
		{
			["buttonTypeData"] = "001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\Ability_Rogue_TricksOftheTrade||002|| ||003|| ||00X|| ",
			["child"] = true,
			["actionData"] = "||001||s ||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [130]
		[0] = {
			["empty"] = true,
		},
		["mainButtonCount"] = 10,
	},
};

Lunar.Template.template[12] =
{
	["listData"] = Lunar.Locale["TEMPLATE_MONK"] .. ":::MONK:::10101:::",
	["sphere"] = defaultSphereTemplateSettings,
	["skin"] = mergeSettings({}, defaultSkinTemplateSettings, {
		["showSphereShine"] = false,
		["sphereSkin"] = 23,
	}),
	["buttonData"] = {
		nil, -- [1]
		nil, -- [2]
		nil, -- [3]
		{
			["buttonTypeData"] = "021011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iHoney Bread||002||iRefreshing Spring Water||003|| ||00X|| ",
			["showCount"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Food_11||002||Interface\\Icons\\INV_Drink_07||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [4]
		{
			["buttonTypeData"] = "031041000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Potion_131||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||i ||002||i ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [5]
		{
			["buttonTypeData"] = "080001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||i ||002||iitem:6948||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Foot_Centaur||002||Interface\\Icons\\INV_Misc_Rune_01||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [6]
		{
			["buttonTypeData"] = "131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||t/use 14||002|| ||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_QuestionMark||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [7]
		{
			["buttonTypeData"] = "130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_QuestionMark||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||t/use 13||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [8]
		["mainButtonCount"] = 10,
	},
};

Lunar.Template.template[13] =
{
	["listData"] = Lunar.Locale["TEMPLATE_DEMONHUNTER"] .. ":::DEMONHUNTER:::10101:::",
	["sphere"] = defaultSphereTemplateSettings,
	["skin"] = mergeSettings({}, defaultSkinTemplateSettings, {
		["showSphereShine"] = false,
		["sphereSkin"] = 24,
	}),
	["buttonData"] =  {
		nil, -- [1]
		nil, -- [2]
		nil, -- [3]
		{
			["buttonTypeData"] = "021011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iHoney Bread||002||iRefreshing Spring Water||003|| ||00X|| ",
			["showCount"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Food_11||002||Interface\\Icons\\INV_Drink_07||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [4]
		{
			["buttonTypeData"] = "031041000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Potion_131||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||i ||002||i ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [5]
		{
			["buttonTypeData"] = "080001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||i ||002||iitem:6948||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Foot_Centaur||002||Interface\\Icons\\INV_Misc_Rune_01||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [6]
		{
			["buttonTypeData"] = "131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||t/use 14||002|| ||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_QuestionMark||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [7]
		{
			["buttonTypeData"] = "130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_QuestionMark||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||t/use 13||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [8]
		["mainButtonCount"] = 10,
	},
};

Lunar.Template.template[14] =
{
	["listData"] = Lunar.Locale["TEMPLATE_EVOKER"] .. ":::EVOKER:::10101:::",
	["sphere"] = defaultSphereTemplateSettings,
	["skin"] = mergeSettings({}, defaultSkinTemplateSettings, {
		["showSphereShine"] = false,
		["sphereSkin"] = 25,
	}),
	["buttonData"] =  {
		nil, -- [1]
		nil, -- [2]
		nil, -- [3]
		{
			["buttonTypeData"] = "021011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||iHoney Bread||002||iRefreshing Spring Water||003|| ||00X|| ",
			["showCount"] = true,
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Food_11||002||Interface\\Icons\\INV_Drink_07||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [4]
		{
			["buttonTypeData"] = "031041000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Potion_131||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||i ||002||i ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [5]
		{
			["buttonTypeData"] = "080001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||i ||002||iitem:6948||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_Foot_Centaur||002||Interface\\Icons\\INV_Misc_Rune_01||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [6]
		{
			["buttonTypeData"] = "131000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionData"] = "||001||t/use 14||002|| ||003|| ||00X|| ",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_QuestionMark||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [7]
		{
			["buttonTypeData"] = "130000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
			["actionTexture"] = "||001||Interface\\Icons\\INV_Misc_QuestionMark||002|| ||003|| ||00X|| ",
			["actionData"] = "||001||t/use 13||002|| ||003|| ||00X|| ",
			["buttonSettings"] = "1110000111000011100001110000111000011100001110000111000011100001110000111000011100001110000",
		}, -- [8]
		["mainButtonCount"] = 10,
	},
};

function Lunar.Template:LoadTemplateData()

	local data = LunarSphereSettings.loadTemplate;
	local db = LunarSphereSettings;
	local searchDB = Lunar.Template;
	local xDB;
	local i, j;
	local templateName, templateClass = string.match(data, "(.*):::(.*):::(.*):::(.*)")
	local templateSearch = templateName .. ":::" .. templateClass;

	local oldRelativePoint = LunarSphereSettings.relativePoint;
	local oldXOfs = LunarSphereSettings.xOfs;
	local oldYOfs = LunarSphereSettings.yOfs;

	for j = 1, 3 do 
		if (searchDB) and (searchDB.template) then
			for i = 1, table.getn(searchDB.template) do 
				if (string.find(searchDB.template[i].listData, templateSearch, 0, true)) then -- == data) then
					xDB = searchDB.template[i];
					break;
				end	
			end
		end
		if (xDB) then
			break;
		elseif (j == 1) then
			searchDB = LunarSphereImport;
		else
			searchDB = LunarSphereExport;
		end
	end

	if (xDB) then

		searchDB = xDB;

		-- Load the pieces we need
		local _, _, data = string.match(data, "(.*):::(.*):::(.*):::(.*)");

		-- First up, the button data
		if (string.sub(data, 1, 1) == "1") and (searchDB.buttonData) then
			LunarSphereSettings.buttonData = LunarSphereSettings.buttonData or {};
			db = LunarSphereSettings.buttonData;
			xDB = searchDB.buttonData;
			local keybindBackup;
			for i = 0, 130 do 

				if db[i] then
					keybindBackup = db[i].keybindData;
				end

				if (xDB[i]) then
					db[i] = Lunar.API:CopyTable(xDB[i]);
				else
					db[i] = {empty = true};	
				end	
				db[i].keybindData = keybindBackup;
			end
			LunarSphereSettings.mainButtonCount = xDB.mainButtonCount;
		end

		-- Next up, the keybind data
		if (string.sub(data, 2, 2) == "1") and (searchDB.keybinds) then
			LunarSphereSettings.buttonData = LunarSphereSettings.buttonData or {};
			db = LunarSphereSettings.buttonData;
			xDB = searchDB.keybinds;
			if (db) then
				for i = 0, 130 do 
					if (db[i]) and (db[i].keybindData) then
						db[i].keybindData = nil;
					end
					if (xDB[i]) then
						db[i].keybindData = xDB[i];
					end
				end
			end
		end

		-- After that, the sphere data
		if (string.sub(data, 3, 3) == "1") and (searchDB.sphere) then
			xDB = searchDB.sphere;
			db = LunarSphereSettings;
			if (db) then
				local key, value;
				for key, value in pairs(xDB) do
					if (type(value) == "table") then
						db[key] = Lunar.API:CopyTable(value);
					else
						db[key] = value;
					end
				end
			end

			-- Keep the sphere where it was...
			LunarSphereSettings.relativePoint = oldRelativePoint;
			LunarSphereSettings.xOfs = oldXOfs;
			LunarSphereSettings.yOfs = oldYOfs;

		end

		-- Then, the reagent list data
		if (string.sub(data, 4, 4) == "1") and (searchDB.reagents) then
			LunarSphereSettings.reagentList = Lunar.API:CopyTable(searchDB.reagents);
			for i = 1, table.getn(LunarSphereSettings.reagentList) do
				LunarSphereSettings.reagentList[i].name = GetItemInfo(tonumber(LunarSphereSettings.reagentList[i].itemID));
			end
		end

		-- Lastly, the skin data
		if (string.sub(data, 5, 5) == "1") and (searchDB.skin) then
			xDB = searchDB.skin;
			db = LunarSphereSettings;
			if (db) then
				local key, value;
				for key, value in pairs(xDB) do
					if (type(value) == "table") then
						if (key == "gaugeColor") then
							local colorID, colorData
							for colorID, colorData in pairs(value) do
								db[key][colorID] = Lunar.API:CopyTable(colorData);
							end
						else
							db[key] = Lunar.API:CopyTable(value);
						end
					else
						db[key] = value;
					end
				end
			end
		end

	end

end

function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dump(v) .. ','
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
 end

function Lunar.Template:ParseTemplateData()

	if (LunarSphereSettings.editingTemplates == true) then
		return;
	end

	-- Load the pieces we need
	local _, anyType, data = string.match(LunarSphereSettings.loadTemplate, "(.*):::(.*):::(.*):::");

	-- First up, the button data
	if (string.sub(data, 1, 1) == "1") then

		-- Healthstone localization. This is needed so we can load up the healthstones properly for the Warlock default template. Russian doesn't exist yet...
		local healthStone;
		local locale = GetLocale();
		
		if (locale == "enUS") then
			healthStone = {
				[1] = "Minor Healthstone",
				[2] = "Lesser Healthstone",
				[3] = "Healthstone",
				[4] = "Greater Healthstone",
				[5] = "Major Healthstone",
				[6] = "Master Healthstone",
			};
		elseif (locale == "deDE") then
			healthStone = {
				[1] = "Schwacher Gesundheitsstein",
				[2] = "Geringer Gesundheitsstein",
				[3] = "Gesundheitsstein",
				[4] = "Großer Gesundheitsstein",
				[5] = "Erheblicher Gesundheitsstein",
				[6] = "Meisterlicher Gesundheitsstein",
			};
		elseif (locale == "esES") then
			healthStone = {
				[1] = "Piedra de salud menor",
				[2] = "Piedra de salud inferior",
				[3] = "Piedra de salud",
				[4] = "Piedra de salud superior",
				[5] = "Piedra de salud sublime",
				[6] = "Piedra de salud maestra",
			};
		elseif (locale == "frFR") then
			healthStone = {
				[1] = "Pierre de soins mineure",
				[2] = "Pierre de soins inférieure",
				[3] = "Pierre de soins",
				[4] = "Pierre de soins supérieure",
				[5] = "Pierre de soins majeure",
				[6] = "Pierre de soins magistrale",
			};
		elseif (locale == "koKR") then
			healthStone = {
				[1] = "최하급 생명석",
				[2] = "상급 생명석",
				[3] = "중급 생명석",
				[4] = "상급 생명석",
				[5] = "최상급 생명석",
				[6] = "일급 생명석",
			};
		elseif (locale == "zhCN")then
			healthStone = {
				[1] = "初级治疗石",
				[2] = "次级治疗石",
				[3] = "治疗石",
				[4] = "强效治疗石",
				[5] = "特效治疗石",
				[6] = "极效治疗石",
			};
		elseif (locale == "zhTW") then
			healthStone = {
				[1] = "初級治療石",
				[2] = "次級治療石",
				[3] = "治療石",
				[4] = "強效治療石",
				[5] = "極效治療石",
				[6] = "極強效治療石",
			};
		else
			healthStone = {
				[1] = "Minor Healthstone",
				[2] = "Lesser Healthstone",
				[3] = "Healthstone",
				[4] = "Greater Healthstone",
				[5] = "Major Healthstone",
				[6] = "Master Healthstone",
			};
		end

		local emptyButtonString = string.rep("000", 39);

		-- Obtain the total number of spells the player knows
		local totalSpells = Lunar.API:CountTotalSpells()

		local clickType, stance, buttonID, isNotLearned, isOutOfMana, canBeUsed, companionCheck;
		local buttonType, cursorType, objectName, objectTexture, objectRank, newName, i, multiSpell, key, value, newIcon, rankFound;
		local db = LunarSphereSettings.buttonData;
		local spellID; --, newTemplateStyle;

		local playerClass = select(2, UnitClass("player"));

		-- Run through each button
		for buttonID = 0, 130 do 
			if (db[buttonID] and not db[buttonID].empty) then

				-- Check each click action in each stance
				healthStoneFound = false;
				for clickType = 1, 3 do 
					for stance = 0, 12 do 

--						newTemplateStyle = false;
						spellID = nil;
						companionCheck = nil;

						-- Grab the click action and check the cursor type. If it is
						-- a spell, we need to check if the spell exists by scanning
						-- the spell book and seeing if the texture exists. If it
						-- does exist, we will grab the name of the spell from the
						-- spell book (for localization issues) as well as set
						-- the rank properly.
						buttonType, cursorType, objectName, objectTexture = Lunar.Button:GetButtonData(buttonID, stance, clickType);

						-- Fix issues with warriors and generic template loading. They have no stance 0, since they are always in stance
						-- 1 or more. So, all 0 stances in the generic template are moved to stance 1 and stance 0 is wiped;
						if ((playerClass == "WARRIOR") and (anyType == "ANY") and (stance == 0)) then
							Lunar.Button:SetButtonData(buttonID, 1, clickType, buttonType, cursorType, objectName, objectTexture);
							Lunar.Button:SetButtonData(buttonID, 0, clickType, 0, "", "", " ");
							cursorType = nil;
						end

						-- Proceed if not a menu... and not a pet action button type
						if (buttonType ~= 2) and (buttonType and ((buttonType < 80) or ((buttonType >= 110) and (buttonType < 132)) or (buttonType >= 150))) then

							if (cursorType == "spell") then

								-- We might have rank data ...
								objectRank = nil;
								if (string.find(objectName, "%(")) then

									-- Grab the rank data and separate the name
									spellID, objectRank = string.match(objectName, "(.*)%((.*)%)");
									if (string.find(spellID, "s%d")) then
										spellID = string.sub(spellID, 2);
										newTemplateStyle = true;
										spellID, objectRank = string.match(spellID, "(.*)%((.*)%)");
									else
										spellID = nil;
									end

									-- If we have a number in the rank, pull it because we're going to
									-- be using it. If there is no number, it might be a polymorph
									-- or something else, so we will just assume the rank is 1
									if (string.find(objectRank, "%d")) then
										objectRank = tonumber(string.match(objectRank, "(%d+)"));
									else
										objectRank = 1;
									end



								else
									if (string.find(objectName, "s%d")) then
										spellID = tonumber(string.sub(objectName, 2));
										newTemplateStyle = true;
									elseif (tostring(tonumber(objectName)) == objectName) then
										spellID = tonumber(objectName);
										newTemplateStyle = true;
									end
										
								end

								-- Two ways to proceed. If the texture data is just a number (spell ID) or several
								-- numbers (for multiple spell IDs, usually used for an alliance OR horde spell, such
								-- as the various mage portals), we will check for that spell to see if the player has
								-- it. Otherwise, we check the texture.
								objectTexture = objectTexture or ("");

								-- special parse for spell mounts
								local isCompanion;
								if (tostring(tonumber(objectName)) == objectName) then
									_, _, objectTexture = GetSpellInfo(tonumber(objectName));
									newName = objectName;
									isCompanion = true;
								end

								multiSpell = string.find(objectTexture, ":::")
								if multiSpell or (tostring(tonumber(objectTexture)) == objectTexture) or spellID then
									
									-- If we have multiple spells, we need to check each spell and see if we find one
									-- This will generate a few tables and will be collected before LS finished with
									-- its loading. Otherwise, just look at the spell ID

									if (multiSpell) then
										objectTexture = string.match(objectTexture, "Icons\\(.*)");
										multiSpell = { strsplit(":::", objectTexture) }
										for key, value in pairs(multiSpell) do
											if (value) then
												if GetSpellInfo(value) then
													newName, rankFound, newIcon = GetSpellInfo(GetSpellInfo(value));
													canBeUsed, isOutOfMana = IsUsableSpell(value);
													if (not (canBeUsed and isOutOfMana)) then
														isNotLearned = true;
														newName = nil;
														break;
													end
												end
												if (newName) then
													objectTexture = newIcon;
													break;
												end
											end
										end
									else
										if (spellID) then
											newName, rankFound, objectTexture = GetSpellInfo(GetSpellInfo(spellID));
											canBeUsed = C_SpellBook.GetSpellBookItemInfo(newName or (""));
--											canBeUsed, isOutOfMana = IsUsableSpell(tonumber(spellID));
											if (not newName) then
												companionCheck = true;
											elseif (not canBeUsed) then
												isNotLearned = true;
												newName = nil;
											else
												rankFound = 0;
												for i = 1, totalSpells do
													scanName, scanRank = GetSpellBookItemName(i, BOOKTYPE_SPELL);
													scanTexture = string.lower(C_Spell.GetSpellTexture(i, BOOKTYPE_SPELL) or (""));

													if (scanName == newName and scanTexture == objectTexture) then
														rankFound = rankFound + 1;
														if not (objectRank) then
															newName = scanName;
														end
														if (objectRank == rankFound) or (scanName == GetSpellInfo(759)) then
															newName = scanName .. "(" .. scanRank .. ")";
															break;
														end
													end

													if (scanTexture ~= objectTexture) and (rankFound > 0) then
														if not (objectRank) or (objectRank and (objectRank <= rankFound)) then
															newName, rankFound = GetSpellBookItemName(i - 1, BOOKTYPE_SPELL);
														end
														break;
													end

												end
											end
--Here
											-- If no spell was found, check if it was a spell mount
											-- (Spell mounts are saved with just the spell ID for the name)
											if not newName and companionCheck then
												local mountIDs = C_MountJournal.GetMountIDs()
												for key, value in pairs(mountIDs) do	
													scanName, spellID, scanTexture = C_MountJournal.GetMountInfoByID(value);
													scanTexture = string.lower(scanTexture);
													if (scanName == spellID) then
														newName = spellID;
														break;
													end
												end
											end

											-- If no spell was found, check if it was a companion pet
											if not newName and companionCheck then
												numPets, numOwned = C_PetJournal.GetNumPets()
 												for i = 1, numPets do 
													_, _, _, _, _, _, _, scanName, scanTexture = C_PetJournal.GetPetInfoByIndex(index)
													_, _, scanName = GetCompanionInfo("critter", i);
													scanTexture = string.lower(scanTexture);
													if (scanName == spellID) then
														newName = spellID;
														break;
													end
												end
											end
										else
											newName, rankFound, objectTexture = GetSpellInfo(GetSpellInfo(tonumber(objectTexture)));
										end	
									end
											
								elseif not isCompanion then
									
									-- Search every spell in player's spellbook. If the texture matches our
									-- spell texture that we're searching for, save the data...
									rankFound = 0;
									newName = nil;

									objectTexture = string.lower(objectTexture or (""));
									for i = 1, totalSpells do
										scanName, scanRank = GetSpellBookItemName(i, BOOKTYPE_SPELL);

										scanTexture = string.lower(C_Spell.GetSpellTexture(i, BOOKTYPE_SPELL) or (""));

										if (scanTexture == objectTexture) then
											rankFound = rankFound + 1;
											if not (objectRank) then
												newName = scanName;
											end
											if (objectRank == rankFound) or (scanName == GetSpellInfo(759)) then
												newName = scanName .. "(" .. scanRank .. ")";
												break;
											end
										end

										if (scanTexture ~= objectTexture) and (rankFound > 0) then
											if not (objectRank) or (objectRank and (objectRank <= rankFound)) then
												newName, rankFound = GetSpellBookItemName(i - 1, BOOKTYPE_SPELL);
												isNotLearned = (C_SpellBook.GetSpellBookItemInfo(i - 1, BOOKTYPE_SPELL) == "FUTURESPELL");
												if (isNotLearned) then
													newName = nil;
													break;
												end
											end
											break;
										end
									end
								
									-- If no spell was found, check if it was a spell mount
									-- (Spell mounts are saved with just the spell ID for the name)
									if Lunar.API:IsVersionRetail() and not newName and not isNotLearned then
										local mountIDs = C_MountJournal.GetMountIDs()
										for key, value in pairs(mountIDs) do	
											scanName, spellID, scanTexture = C_MountJournal.GetMountInfoByID(value);
											scanTexture = string.lower(scanTexture);
											if (scanTexture == objectTexture) then
												newName = scanName;
												break;
											end
										end
									end

									-- If no spell was found, check if it was a companion pet
									if Lunar.API:IsVersionRetail() and not newName and not isNotLearned then
										for i = 1, GetNumCompanions("critter") do 
											_, _, scanName, scanTexture = GetCompanionInfo("critter", i);
											scanTexture = string.lower(scanTexture);
											if (scanTexture == objectTexture) then
												newName = scanName;
												break;
											end
										end
									end
								end

								-- if we found a valid spell, add it. Otherwise, wipe it from this button
								if (newName) then
									-- Hack for mage gems
--									if (newName == GetSpellInfo(759)) then
--										newName = newName .. "(" .. rankFound .. ")";
--									end
									Lunar.Button:SetButtonData(buttonID, stance, clickType, buttonType, cursorType, newName, objectTexture);
								else
									Lunar.Button:SetButtonType(buttonID, stance, clickType, 0);
									if (healthStoneFound == true) then
										Lunar.Button:SetButtonType(buttonID, stance, 1, 0);
										healthStoneFound = false;
									end
								end

							-- Check the items to see if they are warlock healthstones for the default template
							elseif (cursorType == "item") then
								if string.find(objectName, "LSHealthStone") then
									Lunar.Button:SetButtonData(buttonID, stance, clickType, buttonType, cursorType, healthStone[tonumber(string.match(objectName, "(%d+)"))], objectTexture);
									healthStoneFound = true;
								end
							end
						end
					end
				end

				if (db[buttonID].buttonTypeData == emptyButtonString) then
					db[buttonID].empty = true;				
				end
			end
		end
	end
end

function OnLoadCheckMixin(self)
	if BackdropTemplateMixin then -- if this is NOT a Classic type frame, add the backdrop mixin
		Mixin(self, BackdropTemplateMixin)
	end
end

function LunarOnLoadSetBackdrop(self, backdrop)
	OnLoadCheckMixin(self)
	self:SetBackdrop(backdrop)
end

BACKDROP_LUNARWINDOW = {
	bgFile = "Interface\\AddOns\\LunarSphere\\art\\Window-Background",
	edgeFile = "Interface\\Addons\\LunarSphere\\art\\Window-Border",
	tile = true,
	tileEdge = true,
	tileSize = 128,
	edgeSize = 16,
	insets = { left = 5, right = 5, top = 5, bottom = 5 }
}

BACKDROP_LUNARCONTAINER = {
	edgeFile = "Interface\\Addons\\LunarSphere\\art\\Window-Border",
	edgeSize = 16
}

BACKDROP_LUNARVERTICALSLIDER = {
	bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
	edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
	tile = true,
	tileSize = 8,
	edgeSize = 8,
	insets = { left = 3, right = 3, top = 6, bottom = 6 }
}
