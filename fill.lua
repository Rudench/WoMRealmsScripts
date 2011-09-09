-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("fill")

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
	local map = detail.mapFile:sub(5)

	perform("getpoints", "fill bound 1,fill bound 2", lib.tile(detail.parameter)..":"..map)
end
)

lib:hook("marked", nil,
function(perform)
	local detail = lib.detail

	local x1, z1, y1 = split(detail["fill bound 1"], ",")
	local x2, z2, y2 = split(detail["fill bound 2"], ",")

	local tile, map = split(detail.data, ':');
	perform("mapcopy", '.checkpoint_'..map, 0,0,0, 1024,1024,1024);
	perform("fill", x1, z1, y1, x2, z2, y2, tile, nil)
end
)

lib.help('build', 'fill', 'fill a cuboid with a specified tile', '/fill TILENAME')

