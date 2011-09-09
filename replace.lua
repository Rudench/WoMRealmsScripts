-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.

local lib = register("replace")

lib:hook("commanded",
function()
	local detail = lib.detail

	if detail.mapFile == "maps/chat" and detail.userLevel < 5 and detail.adminLevel < 1 then
		return false, "You may not build, here, type &f/home"
	end

	local result, message = lib:perms()
	if result == false then return result, message end

	local find, replace = split(detail.parameter, " ")

	local findTile = lib.tile(find)
	if findTile == -1 then return false, "Unknown tile: " .. find end

	local replaceTile = lib.tile(replace)
	if replaceTile == -1 then return false, "Unknown tile: " .. replace end
end,
function(perform)
	local detail = lib.detail
	local find, replace = split(detail.parameter, " ")
	local findTile = lib.tile(find)
	local replaceTile = lib.tile(replace)
	map = detail.mapFile:sub(5)

	perform("getpoints", "replace bound 1,replace bound 2", findTile..":"..replaceTile..":"..map)
end
)

lib:hook("marked", nil,
function(perform)
	local detail = lib.detail

	local x1, z1, y1 = split(detail["replace bound 1"], ",")
	local x2, z2, y2 = split(detail["replace bound 2"], ",")

	local find, replace, map = split(detail.data, ':');

	perform("mapcopy", '.checkpoint_'..map, 0,0,0, 1024,1024,1024);
	perform("fill", x1, z1, y1, x2, z2, y2, replace, find)
end
)

lib.help('build', 'replace', 'replace the same tiles with a different tile in the selected region between two points', '/replace TILENAME TILENAME')
