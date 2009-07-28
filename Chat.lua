local function poof(obj)
	obj.Show = obj.Hide
	obj:Hide()
end

local function tellTarget(str)
	if(UnitIsPlayer('target') and UnitIsFriend('player', 'target')) then
		SendChatMessage(str, 'WHISPER', GetDefaultLanguage('player'), GetUnitName('target', 'true'):gsub('%s', '', 2))
	end
end

local function onSpacePressed(self)
	local text = string.lower(self:GetText())
	if(string.sub(text, 1, 1) == '/' and string.match(text, '^/tt $')) then
		if(UnitIsPlayer('target') and UnitIsFriend('player', 'target')) then
			self:Hide()
			self:SetAttribute('chatType', 'WHISPER')
			self:SetAttribute('tellTarget', GetUnitName('target', 'true'):gsub('%s', '', 2))
			ChatFrame_OpenChat('')
		end
	end
end

local function onMouseWheel(self, dir)
	if(dir > 0) then
		if(IsShiftKeyDown()) then
			self:ScrollToTop()
		elseif(IsControlKeyDown()) then
			self:ScrollUp(); self:ScrollUp(); self:ScrollUp()
		else
			self:ScrollUp()
		end
	elseif(dir < 0) then
		if(IsShiftKeyDown()) then
			self:ScrollToBottom()
		elseif(IsControlKeyDown()) then
			self:ScrollDown(); self:ScrollDown(); self:ScrollDown()
		else
			self:ScrollDown()
		end
	end
end

for i = 1, NUM_CHAT_WINDOWS do
	local frame = _G['ChatFrame'..i]
	frame:EnableMouseWheel()
	frame:SetScript('OnMouseWheel', onMouseWheel)

	poof(_G['ChatFrame'..i..'UpButton'])
	poof(_G['ChatFrame'..i..'DownButton'])
	poof(_G['ChatFrame'..i..'BottomButton'])
end

poof(ChatFrameMenuButton)

CHAT_TELL_ALERT_TIME = 0

local regions = {ChatFrameEditBox:GetRegions()}
poof(regions[6]); poof(regions[7]); poof(regions[8])
ChatFrameEditBox:SetPoint('BOTTOMLEFT', ChatFrame1, 'TOPLEFT', -5, 20)
ChatFrameEditBox:SetPoint('BOTTOMRIGHT', ChatFrame1, 'TOPRIGHT', -5, 20)
ChatFrameEditBox:SetAltArrowKeyMode(nil)

SLASH_TellTarget1 = '/tt'
SlashCmdList.TellTarget = tellTarget

hooksecurefunc('ChatEdit_OnSpacePressed', onSpacePressed)
