
local lib = register("cont")

lib:hook("commanded",
function ()
	local detail = lib.detail

	if detail.mapFile == "maps/chat" and detail.userLevel < 5 and detail.adminLevel < 1 then
		return false, "You may not build, here, type &f/home"
	end

	local result, message = lib:perms("Advanced", "Visitor", "Artist")
	if result == false then return result, message end

	if detail.parameter == "" then
		detail.parameter = "0"
	end

	if ( detail.parameter ~= "0" and detail.parameter ~= "1" ) then
		return false, "Unknown parameter '" .. detail.parameter .. "' for continuous mode"
	end
end,
function(perform)
	local detail = lib.detail

	local cont = "off" if detail.parameter == "1" then cont = "on" end

	perform("getpointscontinous", cont)
end
)

lib.help('build', 'cont', 'set building commands to run continuously', '/cont [0|1]');

