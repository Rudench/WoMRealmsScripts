-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("unignore")
lib:hook("commanded",
function ()
	local detail = lib.detail
	unignoree = exists(detail.parameter)
	if not unignoree then
		return false, "Unknown player "..detail.parameter
	end
end,
function (perform)
	perform("unignore", unignoree);
	perform("playermessage", "You have unignored " .. unignoree)
end)
lib.help('general', 'unignore', 'Stop ignoring an annoying player', '/unignore NAME')
