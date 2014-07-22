local _, Inomena = ...

Inomena.RegisterEvent('MERCHANT_SHOW', function()
	if(CanMerchantRepair()) then
		RepairAllItems(CanGuildBankRepair() and GetGuildBankWithdrawMoney() >= GetRepairAllCost())
	end
end)

Inomena.RegisterEvent('PLAYER_REGEN_ENABLED', function()
	UIErrorsFrame:AddMessage('- Combat', 1, 1, 1)
end)

Inomena.RegisterEvent('PLAYER_REGEN_DISABLED', function()
	UIErrorsFrame:AddMessage('+ Combat', 1, 1, 1)
end)

Inomena.RegisterEvent('ADDON_LOADED', function(addon)
	if(addon == 'Blizzard_AchievementUI') then
		AchievementFrame_SetFilter(3)
	elseif(addon == 'Blizzard_GuildUI') then
		GuildFrame:HookScript('OnShow', function()
			GuildFrameTab2:Click()
		end)
	end
end)

Inomena.RegisterEvent('REPLACE_ENCHANT', function()
	if(TradeSkillFrame and TradeSkillFrame:IsShown()) then
		ReplaceEnchant()
		StaticPopup_Hide('REPLACE_ENCHANT')
	end
end)

Inomena.RegisterEvent('PARTY_INVITE_REQUEST', function(name, l, f, g)
	if(QueueStatusMinimapButton:IsShown()) then return end
	if(l or f or g) then return end

	for index = 1, select(2, GetNumGuildMembers()) do
		if(GetGuildRosterInfo(index) == name) then
			return AcceptGroup()
		end
	end

	for index = 1, select(2, BNGetNumFriends()) do
		if(string.match(select(5, BNGetFriendInfo(index)), name)) then
			return AcceptGroup()
		end
	end

	for index = 1, GetNumFriends() do
		if(GetFriendInfo(index) == name) then
			return AcceptGroup()
		end
	end
end)

Inomena.RegisterEvent('PARTY_LEADER_CHANGED', function()
	if(StaticPopup_Visible('PARTY_INVITE')) then
		StaticPopup_Hide('PARTY_INVITE')
	end
end)

local soundFile = [=[Sound\Interface\ReadyCheck.wav]=]
Inomena.RegisterEvent('UPDATE_BATTLEFIELD_STATUS', function()
	if(StaticPopup_Visible('CONFIRM_BATTLEFIELD_ENTRY')) then
		PlaySoundFile(soundFile, 'Master')
	end
end)

Inomena.RegisterEvent('LFG_PROPOSAL_SHOW', function()
	PlaySoundFile(soundFile, 'Master')
end)

ReadyCheckListenerFrame:SetScript('OnShow', function()
	PlaySoundFile(soundFile, 'Master')
end)

Inomena.RegisterEvent('PARTY_INVITE_REQUEST', function()
	PlaySoundFile(soundFile, 'Master')
end)

Inomena.RegisterEvent('CHAT_MSG_RAID_BOSS_WHISPER', function(msg, name)
	if(name == UnitName('player') and msg == 'You are next in line!') then
		PlaySoundFile(soundFile, 'Master')
	end
end)

Inomena.RegisterEvent('CINEMATIC_START', function(boolean)
	SetCVar('Sound_EnableMusic', 1)
	SetCVar('Sound_EnableAmbience', 1)
	SetCVar('Sound_EnableSFX', 1)
end)

Inomena.RegisterEvent('CINEMATIC_STOP', function()
	SetCVar('Sound_EnableMusic', 0)
	SetCVar('Sound_EnableAmbience', 0)
	SetCVar('Sound_EnableSFX', 0)
end)

StaticPopupDialogs.PARTY_INVITE.hideOnEscape = 0
StaticPopupDialogs.CONFIRM_SUMMON.hideOnEscape = 0

SLASH_TICKETGM1 = '/gm'
SlashCmdList.TICKETGM = ToggleHelpFrame

VehicleSeatIndicator:UnregisterAllEvents()
VehicleSeatIndicator:Hide()

UIErrorsFrame:UnregisterEvent('UI_ERROR_MESSAGE')
