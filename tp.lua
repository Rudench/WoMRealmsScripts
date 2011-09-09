-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("tp")

lib:hook("commanded",
function ()
	local detail = lib.detail
	if detail.parameter == '<WM>' then
		return false, "Cant touch this....."
	end
	username = exists(detail.parameter)

	if not username then
		return false, "Unknown player "..detail.parameter
	end
end,
function (perform)
	local detail = lib.detail

	perform("movetoplayer", username)
end)

lib.help('general', 'tp', 'teleport to a player in WoM Realm', '/tp USER')
