local addonName, addon = ...
DeathNote.SurvivalIDs = {
	[48707] =	  { class = "DEATHKNIGHT", priority = 1 },
	[48792] =	  { class = "DEATHKNIGHT", priority = 1 },
	[49028] =	  { class = "DEATHKNIGHT", priority = 1 },
	[49222] =   { class = "DEATHKNIGHT", priority = 1 },
	[50461] =	  { class = "DEATHKNIGHT", priority = 2 },
	[51052] =   { class = "DEATHKNIGHT", priority = 2 },
	[55233] =	  { class = "DEATHKNIGHT", priority = 1 },
	[77606] =   { class = "DEATHKNIGHT", priority = 1 },
	[81164] =   { class = "DEATHKNIGHT", priority = 1 },
	[114556] =  { class = "DEATHKNIGHT", priority = 1 },
	[119975] =  { class = "DEATHKNIGHT", priority = 1 },
	[194679] =  { class = "DEATHKNIGHT", priority = 1 },
	[207319] =  { class = "DEATHKNIGHT", priority = 1 },
	
	[196555] =	{ class = "DEMONHUNTER", priority = 1 },
	[198589] =	{ class = "DEMONHUNTER", priority = 1 },
	[196718] =	{ class = "DEMONHUNTER", priority = 2 },
	[191427] =	{ class = "DEMONHUNTER", priority = 1 },
	[187827] =	{ class = "DEMONHUNTER", priority = 1 },
	
	[22812] =  	{ class = "DRUID", priority = 2 },
	[22842] =  	{ class = "DRUID", priority = 2 },
	[33891] =  	{ class = "DRUID", priority = 2 },
	[61336] =  	{ class = "DRUID", priority = 2 },
	[62606] =   { class = "DRUID", priority = 2 },
	[102342] = 	{ class = "DRUID", priority = 1 },
	[102558] = 	{ class = "DRUID", priority = 2 },
	[106922] =  { class = "DRUID", priority = 2 },
	[145108] =  { class = "DRUID", priority = 1 },
	[145109] =  { class = "DRUID", priority = 1 },
	[145110] =  { class = "DRUID", priority = 1 },
	[200851] = 	{ class = "DRUID", priority = 2 },

	[19263]  =  { class = "HUNTER", priority = 1 },
	[109260] =  { class = "HUNTER", priority = 1 },
	[186265] =	{ class = "HUNTER", priority = 1 },
	
	[1463]  =   { class = "MAGE", priority = 1 },
	[30482] =   { class = "MAGE", priority = 1 },
	[45438] = 	{ class = "MAGE", priority = 1 },
	[55342] =   { class = "MAGE", priority = 1 },
	[108978] =  { class = "MAGE", priority = 1 },
	[110959] =  { class = "MAGE", priority = 1 },
	[11426] =   { class = "MAGE", priority = 1 },
	[115610] =  { class = "MAGE", priority = 1 },
	
	[115176] =	{ class = "MONK", priority = 2 },
	[115203] =	{ class = "MONK", priority = 2 },
	[115295] =  { class = "MONK", priority = 2 },
	[115308] =  { class = "MONK", priority = 2 },
	[116849] =	{ class = "MONK", priority = 1 },
	[122278] =	{ class = "MONK", priority = 2 },
	[122783] =	{ class = "MONK", priority = 2 },
	[126046] =  { class = "MONK", priority = 2 },

	[498] =   	{ class = "PALADIN", priority = 2 },
	[642] =   	{ class = "PALADIN", priority = 2 },
	[1022] =  	{ class = "PALADIN", priority = 1 },
	[6940] =  	{ class = "PALADIN", priority = 1 },
	[31850] = 	{ class = "PALADIN", priority = 2 },
	[86659] = 	{ class = "PALADIN", priority = 2 },
	[204018] =	{ class = "PALADIN", priority = 1 },
	[205191] =	{ class = "PALADIN", priority = 2 },

	[586] =     { class = "PRIEST", priority = 3 },
	[33206] = 	{ class = "PRIEST", priority = 1 },
	[47585] = 	{ class = "PRIEST", priority = 2 },
	[47788] = 	{ class = "PRIEST", priority = 1 },
	[81782] = 	{ class = "PRIEST", priority = 3 },

	[1966] =  	{ class = "ROGUE", priority = 1 },
	[5277] =  	{ class = "ROGUE", priority = 1 },
	[31224] = 	{ class = "ROGUE", priority = 1 },
	[45182] =   { class = "ROGUE", priority = 2 },
	[76577] =   { class = "ROGUE", priority = 2 },
	[199754] =	{ class = "ROGUE", priority = 1 },

	[87726] =   { class = "SHAMAN", priority = 2 },
	[98008] =  	{ class = "SHAMAN", priority = 2 },
	[108271] = 	{ class = "SHAMAN", priority = 1 },
	[114893] =  { class = "SHAMAN", priority = 3 },

	[6229] =    { class = "WARLOCK", priority = 1 },
	[108416] =  { class = "WARLOCK", priority = 2 },
	[104773] =	{ class = "WARLOCK", priority = 1 },
	[110913] =  { class = "WARLOCK", priority = 1 },
	
	[871] =   	{ class = "WARRIOR", priority = 2 },
	[2565] =  	{ class = "WARRIOR", priority = 2 },
	[12975] = 	{ class = "WARRIOR", priority = 2 },
	[23920] = 	{ class = "WARRIOR", priority = 2 },
	[29838] =   { class = "WARRIOR", priority = 2 },
	[55694] =   { class = "WARRIOR", priority = 2 },
	[97462] =   { class = "WARRIOR", priority = 3 },
	[97463] = 	{ class = "WARRIOR", priority = 3 },
	[112048] =  { class = "WARRIOR", priority = 2 },
	[114028] =  { class = "WARRIOR", priority = 2 },
	[114029] =  { class = "WARRIOR", priority = 2 },
	[114030] =  { class = "WARRIOR", priority = 2 },
	[118038] =	{ class = "WARRIOR", priority = 2 },
	[122973] =	{ class = "WARRIOR", priority = 1 },
	[184364] =	{ class = "WARRIOR", priority = 2 },
	[197690] =	{ class = "WARRIOR", priority = 2 },
	[213915] =	{ class = "WARRIOR", priority = 3 },

}
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or _G.RAID_CLASS_COLORS

DeathNote.SurvivalColors = { }
for class, color in pairs(RAID_CLASS_COLORS) do
	local class_color = RAID_CLASS_COLORS[class]
	local color = { r = class_color.r, g  = class_color.g, b = class_color.b, a = 0.2 }
	DeathNote.SurvivalColors[class] = color
end

function DeathNote:PruneSurvivalIDs()
	for spellID, data in pairs(DeathNote.SurvivalIDs) do
		if not C_Spell.DoesSpellExist(spellID) then
			DeathNote.SurvivalIDs[spellID] = nil
		end
	end
end
