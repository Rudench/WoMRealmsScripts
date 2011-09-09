-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("sphere")

lib:hook("commanded",
function()
	local detail = lib.detail

	if detail.mapFile == "maps/chat" and detail.userLevel < 5 and detail.adminLevel < 1 then
		return false, "You may not build, here, type &f/home"
	end

	local result, message = lib:perms()
	if result == false then return result, message end

	local tilename, extra1, extra2 = split(detail.parameter, ' ')
	tile = lib.tile(tilename)
	if tile == -1 then
		return false, "Unknown tile: " .. tilename
	end

	solid, perfect = 0, 0
	if extra1 == 'solid' or extra2 == 'solid' then
		solid = 1
	end

	if extra1 == 'perfect' or extra2 == 'perfect' then
		perfect = 1
	end
end,
function(perform)
	local detail = lib.detail
	local map = detail.mapFile:sub(5)

	perform("getpoints", "sphere point 1,sphere point 2", tile..":"..solid..":"..perfect..":"..map)
end
)

lib:hook("marked", nil,
function(perform)
	local detail = lib.detail
	local tile, solid, perfect, map = split(detail.data, ':')

	local x1, z1, y1 = numerate(split(detail["sphere point 1"], ","))
	local x2, z2, y2 = numerate(split(detail["sphere point 2"], ","))
	tile, solid, perfect = numerate(tile, solid, perfect)

	perform("mapcopy", '.checkpoint_'..map, 0,0,0, 1024,1024,1024);

	print("Spheroid from", x1, z1, y1, "to", x2, z2, y2, "in", tile, "perfect", perfect, "solid", solid);
	local x, z, y = spheroid(perform, x1, z1, y1, x2, z2, y2, tile, perfect ~= 0, solid == 0)

	perform("pbufpaste", x, z, y)
end
)

lib.help('build', 'sphere', 'draw a 3D spheroid between 2 points using tilename\nSpheroid size must be at least 3x3x3 as it is 3 dimensional.\nPlace the 2 markers at opposing corners of the bounding box.\nIf you want a solid spheroid, use &fsolid\nIf you want a sphere, use &fperfect', '/sphere TILENAME [solid] [perfect]')
local ceil = math.ceil

function spheroid(perform, x0, z0, y0, x1, z1, y1, tile, sphere, hollow)
	if x0 > x1 then
		x0, x1 = x1, x0
	end

	if z0 > z1 then
		z0, z1 = z1, z0
	end

	if y0 > y1 then
		y0, y1 = y1, y0
	end

	local w = x1 - x0
	local d = z1 - z0
	local h = y1 - y0

	print("Dimens:", w,d,h)

	if w == 0 or d == 0 or h == 0 then
		return
	end

	if sphere then
		local r = w
		if d < r then
			r = d
		end

		if h < r then
			r = h
		end

		w = r
		d = r
		h = r
	end

	local a = w / 2
	local b = d / 2
	local c = h / 2

	print("Hmm, radii", a, b, c)
	local aa, bb, cc = a * a, b * b, c * c

	local s = w * d

	pbufinit(w, d, h, 127)

	for k=-c, c do
		local kk = k * k

		for j=-b, b do
			local jj = j * j

			for i=-a, a do
				local ii = i * i

				local v = ii / aa + jj / bb + kk / cc
				if v < 1 then
					pbuf(ceil(a+i), ceil(b+j), ceil(c+k), tile);
				end
			end
		end
	end

	if hollow then
		for i = 1, w - 2 do
			for j = 1, d - 2 do
				for k = 1, h - 2 do
					if pbuf(i, j, k) == tile and not pbufadj(i, j, k, 127) then
						pbuf(i, j, k, 0)
					end
				end
			end
		end
	end

	return x0, z0, y0
end

