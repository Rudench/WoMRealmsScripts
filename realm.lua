-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("realm")

lib:hook("commanded",
function ()
	local detail = lib.detail

	if not detail.parameter or detail.parameter == "" then
		return false, "Must specify a realm username"
	end

	local player, extra = split(detail.parameter, " ")
	username = exists(player)

	if not username then
		return false, "Unknown player "..player
	end

	if extra and extra ~= "" then
		local mapexists = userhasmap(username, extra)
		if not mapexists then
			return false, "Supplied world is not valid for this user"
		end
	else
		extra = ""
	end
	mapextra = extra
end,
function (perform)
	local detail = lib.detail

	perform("mapchange", "user", username, mapextra)
end)

lib.help('general', 'realm', 'change to a users WoM Realm', '/realm USER [WORLD]')

local homelib = register("home")

homelib:hook("commanded",
function ()
	local detail = homelib.detail

	username = detail.username

	local extra = detail.parameter
	if extra and extra ~= "" then
		local mapexists = userhasmap(username, extra)
		if not mapexists then
			return false, "That world is not accessible"
		end
		mapextra = extra
	else
		mapextra = ""
	end
end,
function (perform)
	print("sending mapchange to user:", username, "extra:", mapextra)
	perform("mapchange", "user", username, mapextra)
end)

homelib.help('general', 'home', 'takes you home', '/home [WORLD]')

local mapslib = register("worlds")

mapslib:hook("commanded",
function ()
	local detail = mapslib.detail

	if not detail.parameter or detail.parameter == "" then
		userisme = true
		username = detail.username
		return
	end

	local player, extra = split(detail.parameter, " ")
	print("got", detail.parameter, player, extra)

	username = exists(player)
	userisme = (player == detail.username)

	if not username then
		return false, "Unknown player "..player
	end
end,
function (perform)
	local maps = { usermaps(username) }
	local message
	if userisme then
		message = "You have "
	else 
		message = username .. " has "
	end

	if #maps > 0 then
		perform("playermessage", message .. "the following extra worlds:\n" .. join(", ", unpack(maps)))
	else
		perform("playermessage", message .. "no extra worlds.")
	end
end)

mapslib.help('general', 'worlds', 'shows the worlds a user (or you) has', '/worlds [USERNAME]')


local contest = register("contest")

contest:hook("commanded",
function ()
	local detail = contest.detail

	if detail.parameter == "" then
		username = detail.username
	else
		username = exists(detail.parameter)
	end

	if not username then
		return false, "Cannot find that user"
	end

	if (username == detail.username) then
		userdata("mapSize+~contest", "128x128x64");
	end
end,
function (perform)
	perform("mapchange", "user", username, "~contest")
end)

contest.help('general', 'contest', 'enters contest world', '/contest [USERNAME]')


