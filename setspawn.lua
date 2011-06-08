-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.

local lib = register("setspawn")

lib:hook("commanded",
function ()
	local detail = lib.detail

	if detail.mapFile == "maps/chat" and detail.userLevel < 5 and detail.adminLevel < 1 then
		return false, "You may not build, here, type &f/home"
	end

	local result, message = lib:perms("Advanced", "Visitor", "Artist")
	if result == false then return result, message end
end,
function(perform)
	perform("playermessage", "Setting spawn to your exact location and orientation")
	perform("setspawn")
end
)

lib.help('moderate', 'setspawn', 'sets the spawn point for your realm to your current location', '/setspawn')

