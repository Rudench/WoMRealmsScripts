-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("project")

lib:hook("commanded",
nil,
function (perform)
	local detail = lib.detail

	perform("mapchange", "other", "project", "")
end)

lib.help('general', 'project', 'change to a WoM project realm', '/project')

