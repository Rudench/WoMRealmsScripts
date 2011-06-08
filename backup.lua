-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("backup")

lib:hook("commanded",
function()
	local detail = lib.detail

	local result, message = lib:perms("Owner", "Visitor", "Support")
	if result == false then return result, message end
end,
function(perform)
	local detail = lib.detail
	local map = detail.mapFile:sub(6)
	perform("mapcopy", '.backup_'..map, 0,0,0, 1024,1024,1024);
	local mapType, mapOwner, mapExtra = lib.parseMap(detail.mapFile)
	local message = "Backing up "..mapType.." map "..mapOwner
	if mapExtra and mapExtra ~= "" then
		message = message.." world "..mapExtra
	end
	perform("playermessage", message)
end
)

lib.help('build', 'backup', 'backup your map to a region named backup', '/backup')
