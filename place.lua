-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.

local lib = register("place")

lib:hook("commanded",
function()
	local detail = lib.detail

	if detail.mapFile == "maps/chat" and detail.userLevel < 5 and detail.adminLevel < 1 then
		return false, "You may not build, here, type &f/home"
	end

	local result, message = lib:perms()
	if result == false then return result, message end

	local tile = lib.tile(detail.parameter)
	if tile == -1 then
		return false, "Unknown tile: " .. detail.parameter
	end
end,
function(perform)
	local detail = lib.detail

	local tile = lib.tile(detail.parameter)
	print("/place tile", tile)
	perform("placetile", math.floor(detail.playerX / 32), math.floor(detail.playerZ / 32), math.floor(detail.playerY / 32) - 2, tile)
end
)

lib.help('build', 'place', 'place a tile at the current position', '/place TILENAME')
