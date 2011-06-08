-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local abs = math.abs
local floor = math.floor
local lib = register("count")

lib:hook("commanded",
function()
	local detail = lib.detail

	tile = -1
	if detail.parameter ~= "" then
		tile = lib.tile(detail.parameter)
		if tile == -1 then
			return false, "Unknown tile"
		end
	end

	if detail.mapFile == "maps/chat" and detail.userLevel < 5 and detail.adminLevel < 1 then
		tile = -1
	end

	local result, message = lib:perms("Advanced", "Visitor", "Artist")
	if result == false then
		tile = -1
	end

end,
function(perform)
	local detail = lib.detail

	perform("getpoints", "point A,point B", tile)
end
)

lib:hook("marked", nil,
function(perform)
	local detail = lib.detail

	local x1, z1, y1 = split(detail["point A"], ",")
	local x2, z2, y2 = split(detail["point B"], ",")
	local dx, dy, dz = abs(x2-x1)+1, abs(y2-y1)+1, abs(z2-z1)+1
	local v = dx * dy * dz
	local cx, cy, cz = floor((x1+x2)/2), floor((y1+y2)/2), floor((z1+z2)/2)

	perform("playermessage", string.format("Points &b%d,%d,%d &e-> &b%d,%d,%d\nCenter &3%d,%d,%d &eDeltas &3%d,%d,%d&e, Volume &3%d", x1,z1,y1, x2,z2,y2, cx,cz,cy, dx,dz,dy, v));

	local tile = detail.data
	if tile ~= -1 then
		perform("placetile", cx, cz, cy, tile);
	end
end
)

lib.help('build', 'count', 'count the distance between 2 points', '/count [CENTERTILE]')

