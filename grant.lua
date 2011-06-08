local lib = register("grant")

lib:hook("commanded",
function()
	local detail = lib.detail

	local result, message = lib:perms("Admin", "Visitor", "Support")
	if result == false then return result, message end

	if not detail.parameter then
		return false, "Syntax: /grant USER LEVEL"
	end

	name, level = split(detail.parameter, " ")
	if level == "none" or level == "no" then
		level = 0;
		levelName = "None"
	elseif level == "build" or level == "builder" then
		level = 1;
		levelName = "Builder"
	elseif level == "adv" or level == "advanced" then
		level = 2;
		levelName = "Advanced"
	elseif level == "admin" or level == "administrator" then
		level = 10;
		levelName = "Admin"
	elseif level == "restrict" or level == "restricted" then
		level = -1;
		levelName = "Restricted"
	else
		return false, "Unknown level"
	end

	username, destLevel = exists(name)
	print("got", username, destLevel, "for", name)
	if not username then
		return false, "Unknown user: "..name
	end
end,
function(perform)
	perform("playermessage", "Grant successful: "..username.." is "..levelName)
	perform("grant", username, level)
end
)

lib.help('moderate', 'grant', 'grant users to build in you realm\nLevels: restrict, none, build, advanced, admin', '/grant USER LEVEL')
