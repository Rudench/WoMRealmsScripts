-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.

local lib = register("reloadlua")

lib:hook("commanded",
function ()
	print("Received a reloadlua command")
end,
function(perform)
	perform("reloadlua")
end
)

