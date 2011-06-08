-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.

local lib = register("spleef")

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
		return false, "Can't use spleef in chat"
	end

	if (detail.parameter == "set") then
		return lib:perms("Admin", "Laborer", "Support")
	elseif (detail.parameter == "remove") then
		return lib:perms("Admin", "Laborer", "Support")
	elseif (detail.parameter == "recopy") then
		return lib:perms("Admin", "Laborer", "Support")
	elseif (detail.parameter == "reset") then
		return lib:perms("None", "Visitor", "Laborer")
	elseif (detail.parameter == "start") then
		return lib:perms("None", "Visitor", "Laborer")
	else
		return false, "Unknown options: " .. detail.parameter .. " - For options type /help spleef"
	end
end,
function(perform)
	local detail = lib.detail

	if (detail.parameter == "set") then
		perform("getpoints", "spleef bound1,spleef bound2", detail.parameter)
	elseif (detail.parameter == "remove") then
		perform("arearemove", "spleef")
	elseif (detail.parameter == "recopy") then
		perform("areacopy", "spleef")
	elseif (detail.parameter == "reset") then
		perform("areapaste", "spleef")
	elseif (detail.parameter == "start") then
		if not games[detail.username] then
			perform("realmchat", "New spleef game starting")
			perform("realmchat", start)
			games[detail.username] = { start = os.time(), counter = 0 }
		end
	end
end
)

lib:hook("marked", nil,
function(perform)
	local detail = lib.detail

	local x1, z1, y1 = split(detail["spleef bound1"], ",")
	local x2, z2, y2 = split(detail["spleef bound2"], ",")

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

	if detail.data == "set" then
		perform("areainit", "spleef", x1, z1, y1, dx, dz, dy)
	else
		perform("playermessage", "Failed marking, unknown option: " .. detail.data)
	end
end
)

lib:hook("placed",
function()
	local detail = lib.detail

	if detail.mapArea == "spleef" then
		local result, message = lib:perms("None", "Visitor", "Laborer")
		if result == false then
			return result, message
		end
		return true
	end
end
)

lib.help('build', 'spleef', 'Set up or manage a spleef area\nOptions: set, remove, recopy, start, reset', '/spleef OPTION')

