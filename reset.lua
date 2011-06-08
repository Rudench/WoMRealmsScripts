-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.

local lib = register("reset")

lib:hook("commanded",
function ()
	local detail = lib.detail
	local result, message = lib:perms("Owner", "Visitor", "Support")
	if result == false then return result, message end

	if not detail.parameter or detail.parameter ~= "YES" then
		return false, "This wipes your realm. To confirm: &f/reset &cYES"
	end
end,
function(perform)
	local map = lib.detail.mapFile:sub(5)
	perform("mapcopy", '.checkpoint_'..map, 0,0,0, 1024,1024,1024);
	perform("mapreset")
end
)

