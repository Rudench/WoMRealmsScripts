-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("line")


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

	perform("getpoints", "line point 1,line point 2", lib.tile(detail.parameter)..":"..map)
end
)

lib:hook("marked", nil,
function(perform)
	local detail = lib.detail
	local tile, map = split(detail.data, ':')

	local x1, z1, y1 = numerate(split(detail["line point 1"], ","))
	local x2, z2, y2 = numerate(split(detail["line point 2"], ","))

	perform("mapcopy", '.checkpoint_'..map, 0,0,0, 1024,1024,1024);

	print("Line from", x1, z1, y1, "to", x2, z2, y2, "in", tile)
	drawLine(perform, x1, z1, y1, x2, z2, y2, tile)
end
)

lib.help('build', 'line', 'draw a 3D line between 2 points with the specified tile', '/line TILENAME')


local abs = math.abs

function drawLine(perform, x0, z0, y0, x1, z1, y1, tile)
	local swapz = (abs(z1-z0) > abs(x1-x0))
	if swapz then
		x0, x1, z0, z1 = z0, z1, x0, x1
	end

	local swapy = (abs(y1-y0) > abs(x1-x0))
	if swapy then
		x0, x1, y0, y1 = y0, y1, x0, x1
	end

	dx, dz, dy = abs(x1-x0), abs(z1-z0), abs(y1-y0)

	local drifty = dx/2
	local driftz = dx/2

	local sx, sz, sy = 1, 1, 1
	if (x0 > x1) then sx = -1 end
	if (z0 > z1) then sz = -1 end
	if (y0 > y1) then sy = -1 end

	local e1, e2
	local z, y = z0, y0

	for x = x0, x1, sx do
		local cx, cz, cy = x, z, y
		
		if swapy then
			cx, cy = cy, cx
		end
		if swapz then
			cx, cz = cz, cx
		end

		-- Plot point
		perform("placetile", cx, cz, cy, tile)

		drifty = drifty - dy
		driftz = driftz - dz

		if drifty < 0 then
			y = y + sy
			drifty = drifty + dx
		end

		if driftz < 0 then
			z = z + sz
			driftz = driftz + dx
		end
	end
end

