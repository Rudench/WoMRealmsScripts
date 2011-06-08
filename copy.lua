-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("copy")

lib:hook("commanded",
function()
	local detail = lib.detail

	if detail.mapFile == "maps/chat" and detail.userLevel < 5 and detail.adminLevel < 1 then
		return false, "You may not build, here, type &f/home"
	end

	local result, message = lib:perms("Advanced", "Visitor", "Artist")
	if result == false then return result, message end

	if detail.parameter == "" then
		return false, "You must specify a Region Name"
	end
end,
function(perform)
	local detail = lib.detail

	perform("getpoints", "copy bound1,copy bound2", detail.parameter)
end
)

lib:hook("marked", nil,
function(perform)
	local detail = lib.detail

	local x1, z1, y1 = split(detail["copy bound1"], ",")
	local x2, z2, y2 = split(detail["copy bound2"], ",")

	x1 = math.floor(x1)
	z1 = math.floor(z1)
	y1 = math.floor(y1)
	x2 = math.floor(x2)
	z2 = math.floor(z2)
	y2 = math.floor(y2)

	if x1 > x2 then x1 , x2 = x2 , x1 end
	if z1 > z2 then z1 , z2 = z2 , z1 end
	if y1 > y2 then y1 , y2 = y2 , y1 end

	local dx = ( x2 - x1 ) + 1
	local dz = ( z2 - z1 ) + 1
	local dy = ( y2 - y1 ) + 1

	perform("mapcopy", detail.data, x1, z1, y1, dx, dz, dy)
end
)

lib.help('build', 'copy', 'copy a cuboid to a named region', '/copy MYREGIONNAME')
