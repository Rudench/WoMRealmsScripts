-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("global")

lib:hook("commanded",
function ()
	local detail = lib.detail

	if detail.parameter == "" then
		detail.parameter = "on"
	end

	if ( detail.parameter ~= "on" and detail.parameter ~= "off" ) then
		return false, "Unknown parameter '" .. detail.parameter .. "' for /global."
	end
end,
function(perform)
	local detail = lib.detail

	local nospam = "0"
	if detail.parameter == "off" then
		perform("playermessage", "Unsubscribed from global channel");
		nospam = "1"
	else
		perform("playermessage", "Subscribed to global channel");
	end

	userdata("nospam", nospam)
end
)

lib.help('build', 'global', 'set whether to recieve global chat channel\nThe chat realm is by default visible even when you are not in the chat realm.\nYou may disable this by typing /global off', '/global off  /global on');

