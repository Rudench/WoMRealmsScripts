-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.

local emotes = {
'<3',
'</3',
'D:',
':D',
'>:D',
':3',
'XD',
'DX',
'-<@',
'-(>',
'@>-',
'<)-',
'Q_Q',
'^_^',
':P',
':)',
'(:',
':(',
'):',
'=)',
'(=',
';)',
'><>',
'><>-',
'>:3',
'o_O',
'O_O',
':l',
'>:|',
':@',
'O.e',
'O.O',
'=P',
'8D',
'-.-',
'x.x',
'^.^',
'>.<',
'>.>',
'<.<',
'b.d',
'._.',
'.-.',
}

local valid = {}
for i,emote in ipairs(emotes) do
	valid[emote] = true
end

local lib = register("emote")
lib:hook("commanded", function()
	local customName = lib.detail.parameter

	if customName == "" then
		return true
	end

	if valid[customName] then
		return true
	end

	return false, "That is not a valid emote"
end, function(perform)
	local customName = lib.detail.parameter
	if (customName ~= "") then
		customName = customName.." "..lib.detail.username
		userdata("customName", customName)
		perform("playermessage", "Emote: ".. customName);
		perform("playermessage", "Type /tag to disable");
	else
		perform("playermessage", "Possible emotes: " .. join(" ", unpack(emotes)));
	end
end)

lib.help('general', 'emote', 'Create an emotion at the front of your username example\n - &5=) moujave: &fWhatchu talking bout Willis? ', '/emote')
