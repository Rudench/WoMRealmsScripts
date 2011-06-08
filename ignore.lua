-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("ignore")
lib:hook("commanded",
function ()
	local detail = lib.detail
	ignoree = exists(detail.parameter)
	if ignoree == detail.username then
		return false, "You can't ignore yourself"
	end
	if not ignoree then
		return false, "Unknown player "..detail.parameter
	end
end,
function (perform)
	perform("ignore", ignoree);
	perform("playermessage", "You have ignored " .. ignoree)
end)
lib.help('general', 'ignore', 'Ignore an annoying player', '/ignore NAME')
