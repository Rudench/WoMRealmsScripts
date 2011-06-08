-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.

local lib = register("reload")

lib:hook("commanded",
function ()
	local detail = lib.detail
	if detail.adminLevel < 1 then
		return false, "Only support may use that command"
	end
end,
function(perform)
	perform("mapreload")
end
)

