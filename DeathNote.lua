local addonName, addon = ...
local compat = addon.compat
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
DeathNote = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0", "AceConsole-3.0")
DeathNote.LDBO = LibStub("LibDataBroker-1.1"):NewDataObject(addonName)
DeathNote.LDBI = LibStub("LibDBIcon-1.0")
-- Bindings text
BINDING_HEADER_DEATH_NOTE = L["Death Note"]
BINDING_NAME_DEATH_NOTE_SHOW_TARGET_DEATH = L["Show target deaths"]

-- use a separate frome to avoid CBH/AceTimer overhead
DeathNote.cleu_parser = CreateFrame("Frame")
DeathNote.cleu_parser.OnEvent = function(self,event,...)
	return DeathNote[event] and DeathNote[event](DeathNote,event,...)
end
DeathNote.cleu_parser:SetScript("OnEvent", DeathNote.cleu_parser.OnEvent)

function DeathNote:OnInitialize()
	-- AceDB options
	self.db = LibStub("AceDB-3.0"):New("DeathNoteDB", self.OptionsDefaults)
	self.settings = self.db.profile
	
	-- Clean options -- TODO: remove this when implemented
	self.settings.others_death_time = 0

	-- Register options
	LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self.Options)
	local _
	_, self.optID = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, L["Death Note"])
	
	local function ChatCommand(msg)
		if (msg == "reset") then
			DeathNote:ResetData()
			DeathNote:UpdateLDB()
		else
			DeathNote:Show()
		end
	end
	
	-- Register slash commands
	self:RegisterChatCommand("deathnote", ChatCommand)
	self:RegisterChatCommand("dn", ChatCommand)

	-- Configure LDB object
	DeathNote.LDBO.type = "data source"
	DeathNote.LDBO.label = "|cFF8F8F8F" .. L["Death Note"] .. "|r"
	DeathNote.LDBO.text = "|cFF8F8F8F" .. L["Death Note"] .. "|r"
	DeathNote.LDBO.icon = [[Interface\AddOns\DeathNote\Textures\icon.tga]]
	DeathNote.LDBO.OnClick = function(self, button)
		if button == "LeftButton" then
			if IsShiftKeyDown() then
				DeathNote:CleanData(true)
				collectgarbage("collect")
				DeathNote:UpdateLDB()
			elseif IsControlKeyDown() then
				DeathNote:ResetData()
				DeathNote:UpdateLDB()
			else
				DeathNote:ShowUnit(GetUnitName("target",true))
			end
		elseif button == "RightButton" then
			Settings.OpenToCategory(DeathNote.optID)
		end
	end
	DeathNote.LDBO.OnTooltipShow = function(tooltip)
		tooltip:AddLine(L["Death Note"])
		tooltip:AddLine(L["MINIMAP_ICON_TOOLTIP"], 0.2, 1, 0.2, 1)
	end
	DeathNote.LDBI:Register(addonName, DeathNote.LDBO, DeathNote.settings.minimap)

	-- Take over the Blizzard death recap button
	OpenDeathRecapUI = function ()
		DeathNote:ShowUnit(GetUnitName("player",true))
	end

	self:DataCapture_Initialize()
	
	self:O_Initialize()
	
	self:UpdateLDB()
end

function DeathNote:OnEnable()
	self:PruneSurvivalIDs()
	self.cleu_parser:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("CHAT_MSG_SYSTEM")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_FLAGS_CHANGED")
	self:RegisterEvent("PLAYER_LEAVING_WORLD")
	self:RegisterEvent("CHANNEL_UI_UPDATE")
	self.db.RegisterCallback(self, "OnDatabaseShutdown")

	self:ScheduleRepeatingTimer("UpdateLDB", 5)

	if self.settings.debugging then
		self:Show()
	end

	self:InstallRecap()
end

function DeathNote:OnDisable()
	self.cleu_parser:UnregisterAllEvents()
	self:UnregisterAllEvents()
	self.db.UnregisterAllCallbacks(self)
	self:CancelAllTimers()
	self:UninstallRecap()
end

-- Replaces AceConsole:Print so that the addon name can be localized
function DeathNote:Print(...)
	local str = "|cff33ff99" .. L["Death Note"] .. "|r: "
	local count = select("#", ...)
	for i = 1, count do
		str = str .. tostring(select(i, ...))
		if i < count then
			str = str .. " "
		end
	end
	DEFAULT_CHAT_FRAME:AddMessage(str)
end

function DeathNote:Debug(...)
	if self.settings.debugging then
		self:Print(...)
	end
end

function DeathNote:UpdateLDB()
	self.LDBO.text = string.format(L["%i deaths"], #DeathNoteData.deaths)
end

-- Custom recap button for Classic clients
function DeathNote:InstallRecap()
	if not self.PlayerRecap then
		self.PlayerRecap = CreateFrame("Button", "DeathNotePlayerRecapButton", UIParent, "UIPanelButtonTemplate")
		self.PlayerRecap:SetSize(120,22)
		self.PlayerRecap:SetText(L["Death Note"])
		self.PlayerRecap:SetScript("OnClick", function()
			local name = GetUnitName("player",true)
			if name then
				DeathNote:ShowUnit(name)
			end
		end)
	end
	self:SecureHook("StaticPopup_Show", function(which)
		if not (which and which == "DEATH") then return end
		local dialog = StaticPopup_FindVisible("DEATH")
		if dialog then
			if DeathNote.PlayerRecap then
				DeathNote.PlayerRecap:ClearAllPoints()
				DeathNote.PlayerRecap:SetPoint("TOPRIGHT",dialog,"BOTTOMRIGHT",-2,-2)
				DeathNote.PlayerRecap:Show()
			end
		end
	end)
	self:SecureHook("StaticPopup_Hide", function(which)
		if not (which and which == "DEATH") then return end
		if DeathNote.PlayerRecap and DeathNote.PlayerRecap:IsVisible() then
			DeathNote.PlayerRecap:Hide()
		end
	end)
end

function DeathNote:UninstallRecap()
	if self:IsHooked("StaticPopup_Show") then
		self:Unhook("StaticPopup_Show")
	end
	if self:IsHooked("StaticPopup_Hide") then
		self:Unhook("StaticPopup_Hide")
	end
	if self.PlayerRecap and self.PlayerRecap:IsVisible() then
		self.PlayerRecap:Hide()
	end
end

------------------------------------------------------------------------------
-- Reports
------------------------------------------------------------------------------

function DeathNote:SendReport(channel, arg)
	local target
	if channel == "WHISPER" then
		target = GetUnitName("target",true)
		if not target then
			return
		end
	elseif channel == "CHANNEL" then
		target = arg
	end

	local func
	if self.settings.report.style == "COMBAT_LOG" then
		func = self.FormatReportCombatLog
	else
		func = self.FormatReportCompact
	end

	local msg = string.format(L["Death Note: Death report for %s at %s"], self.current_death.name, date("%X", self.current_death.timestamp))
	compat.SendChatMessage(msg, channel, nil, target)

	self.report_line_count = 0
	for i = self.dropdown_line, 1, -1 do
		if self.report_line_count >= self.settings.report.max_lines then
			self:Print(string.format(L["Limiting report to %i lines"], self.settings.report.max_lines))
			break
		end

		local entry = self.logframe:GetLineUserdata(i)

		func(self, entry, channel, target)
	end
	self.report_line_count = nil
end