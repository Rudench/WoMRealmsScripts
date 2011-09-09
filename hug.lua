-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved. 
-- Contributed by: kevinsweijen - modified triddin\moujave. 
local lib = register ("hug")

lib:hook("commanded",
function()
	local detail = lib.detail

	if detail.parameter == "" then
		return false, "Syntax: /hug USER"
	end

	if detail.parameter == '1' then
		userdata('nohug', '')
		return false, 'Bring on the love!'
	end
	if detail.parameter == '0' then
		userdata('nohug', os.time())
		return false, 'No hugs for you!'
	end

	if string.lower(detail.parameter) == '<wm>' then
		username = '<WM>'
		return
	end

	username, userLevel, adminLevel, clanId, isOnline, mapFile = exists(detail.parameter)
	if not username then
		return false, "I cant find your huggle bear " ..detail.parameter
	end

	if not isOnline then
		return false, "Cant find that person to hug!"
	end
end,
function(perform)
	local detail = lib.detail
	if username == detail.username then
		perform("playermessage", "Awww, are you lonely?")
		perform("mapchange", "other", "lonely", "");
		return
	end

	if username == "<WM>" then
		perform("playermessage", "You know &5<WM>&e loves you &d<3")
		return
	end
	
	local deny = userdata('nohug', nil, username)
	if deny and deny ~= '' then
		perform("playermessage", "HUG DENIED!")
		perform("mapchange", "other", "lonely", "");
		return
	end

	perform("playermessage", "Shnuggling " .. username)
	perform("directtoplayer", username)
	perform("messageto", username, "- &dYou have been hugged by " .. detail.username .. "!")
end
)

lib.help('general', 'hug', 'Shows your eternal love to another player, or use 0 to deny or 1 to allow hugs', '/hug USER|0|1')
