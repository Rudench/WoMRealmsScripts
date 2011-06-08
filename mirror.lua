
local lib = register("mirror")

local games = {}

local start = 5

lib:hook("processing", nil, function(perform)
	local detail = lib.detail
	if games[detail.username] then
		local game = games[detail.username]
		local counter = os.time() - game.start
		if counter > game.counter and counter <= start then
			if counter == start then
				perform("realmchat", "Start!")
			else
				perform("realmchat", (start - counter))
			end
		end
		if counter >= start * 2 then
			games[detail.username] = nil
		else
			games[detail.username].counter = counter
		end
	end
end
)

lib:hook("commanded",
function()
	local detail = lib.detail
	if detail.mapFile == "maps/chat" then
		return false, "Can't use mirror in chat"
	end

	local cmd, param = split(detail.parameter, " ")
	if (cmd == "set") then
		local test = param
		local char = string.sub(test, 1,1)
		if char == "r" then
			test = string.sub(test, 2)
		end
		if test == "x" or test == "y" or test == "z" or test == "xy" or test == "xz" or test == "yz" or test == "xyz" then
			mode = param
		else
			return false, "Unknown mode for mirror: " .. param
		end

		return lib:perms("Admin", "Laborer", "Support")
	elseif (cmd == "remove") then
		return lib:perms("Admin", "Laborer", "Support")
	elseif (cmd == "mode") then
		local test = param
		local char = string.sub(test, 1,1)
		if char == "r" then
			test = string.sub(test, 2)
		end
		if test == "x" or test == "y" or test == "z" or test == "xy" or test == "xz" or test == "yz" or test == "xyz" then
			return lib:perms("Admin", "Laborer", "Support")
		end
		return false, "Unknown mode for mirror: " .. param
	else
		return false, "Unknown options: " .. cmd .. " - For options type /help mirror"
	end
end,
function(perform)
	local detail = lib.detail

	local cmd, param = split(detail.parameter, " ")
	if (cmd == "set") then
		perform("getpoints", "mirror bound1,mirror bound2", detail.parameter)
	elseif (cmd == "remove") then
		perform("arearemove", "mirror")
	elseif (cmd == "mode") then
		mapdata("mirrormode", param)
	end
end
)

lib:hook("marked", nil,
function(perform)
	local detail = lib.detail

	local x1, z1, y1 = split(detail["mirror bound1"], ",")
	local x2, z2, y2 = split(detail["mirror bound2"], ",")

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

	local cmd, mode = split(detail.data, " ")
	if cmd == "set" then
		perform("areainit", "mirror", x1, z1, y1, dx, dz, dy)
		mapdata("mirrormode", mode)
		mapdata("mirrorpos", x1..","..z1..","..y1..","..x2..","..z2..","..y2)
	else
		perform("playermessage", "Failed marking, unknown option: " .. detail.data)
	end
end
)

lib:hook("placed",
function()
	local detail = lib.detail

	if detail.mapArea == "mirror" then
		--print("Placed in mirror area");
		local result, message = lib:perms("Build", "Visitor", "Laborer")
		if result == false then
			return result, message
		end
	end
end,
function(perform)
	local detail = lib.detail

	if detail.mapArea == "mirror" then
		local tile = detail.tile
		if detail.mode == 0 then
			tile = 0
		end

		local x, z, y = -1, -1, -1
		local x1, z1, y1, x2, z2, y2 = numerate(split(mapdata("mirrorpos"), ","))
		local mode = mapdata("mirrormode")

		local reflective = false
		local char = string.sub(mode, 1,1)
		if char == "r" then
			mode = string.sub(mode, 2)
			reflective = true
		end

		if mode == "x" or mode == "xy" or mode == "xz" or mode == "xyz" then
			x = (x1 + x2) / 2
		end
		if mode == "y" or mode == "xy" or mode == "yz" or mode == "xyz" then
			z = (z1 + z2) / 2
		end
		if mode == "z" or mode == "xz" or mode == "yz" or mode == "xyz" then
			y = (y1 + y2) / 2
		end
		--print("Processing in mirror area: "..x..", "..z..", "..y..", mode = "..mode);

		local ax, ay, az = -1, -1, -1

		if x > -1 then
			if lib.detail.x > x then
				ax = x - (lib.detail.x - x)
			elseif lib.detail.x < x then
				ax = x + (x - lib.detail.x)
			end
		end
		if z > -1 then
			if lib.detail.z > z then
				az = z - (lib.detail.z - z)
			elseif lib.detail.z < z then
				az = z + (z - lib.detail.z)
			end
		end
		if y > -1 then
			if lib.detail.y > y then
				ay = y - (lib.detail.y - y)
			elseif lib.detail.y < y then
				ay = y + (y - lib.detail.y)
			end
		end

		--print("Mirror coordinates aer:  : "..ax..", "..az..", "..ay);
		if ax > -1 then
			perform("placetile", ax, lib.detail.z, lib.detail.y, tile)
			if reflective then
				perform("placetile", lib.detail.z, ax, lib.detail.y, tile)
			end
		end
		if az > -1 then
			perform("placetile", lib.detail.x, az, lib.detail.y, tile)
			if reflective then
				perform("placetile", az, lib.detail.x, lib.detail.y, tile)
			end
		end
		if ay > -1 then
			perform("placetile", lib.detail.x, lib.detail.z, ay, tile)
		end
		if ax > -1 and az > -1 then
			perform("placetile", ax, az, lib.detail.y, tile)
			if reflective then
				perform("placetile", az, ax, lib.detail.y, tile)
			end
		end
		if ax > -1 and ay > -1 then
			perform("placetile", ax, lib.detail.z, ay, tile)
			if reflective then
				perform("placetile", lib.detail.z, ax, ay, tile)
			end
		end
		if az > -1 and ay > -1 then
			perform("placetile", lib.detail.x, az, ay, tile)
			if reflective then
				perform("placetile", az, lib.detail.x, ay, tile)
			end
		end
		if ax > -1 and az > -1 and ay > -1 then
			perform("placetile", ax, az, ay, tile)
			if reflective then
				perform("placetile", az, ax, ay, tile)
			end
		end
		if reflective then
			perform("placetile", lib.detail.z, lib.detail.x, lib.detail.y, tile)
		end
	end
end
)

lib.help('build', 'mirror', 'Set up a mirror area and mirror mode:\n/mirror set [r][x][y][z]\n- &bKeep current area but change mode:\n/mirror mode [r][x][y][z]\n- &bRemove mirror area:\n/mirror remove\n- &cThe modes:\n  r = reflective (flips x<->y coords)\n  x = mirror across x axis midline,\n  y = mirror across y axis midline,\n  z = mirror across z axis midline.', '/mirror set yz')

