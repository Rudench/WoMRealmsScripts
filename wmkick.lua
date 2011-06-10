-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("wmkick")

lib:hook("commanded",
function()
	local detail = lib.detail

	if (detail.adminLevel < 1 ) then
		return false, "You are not allowed to use this command"
	end

	if not detail.parameter then
		return false, "Syntax: /wmkick USER REASON"
	end

	name, reason = split(detail.parameter, " ", 2)

	if not reason then
		return false, "Must supply a reason for the note"
	end

	username, destLevel = exists(name)
	if not username then
		return false, "Unknown user: "..name
	end

--	if destLevel >= 10 then
--		return false, "May not silence support"
--	end
end,
function(perform)
	local detail = lib.detail
        addnote(username, 'wmkick', 'who=' .. detail.username .. ";action=wmkicked;reason="..reason)
	perform("kickplayer", username)
	perform("adminmessage", detail.username.." wmkicked "..username.."\n - "..reason)
end
)

lib.help('support', 'wmkick', 'wmkick users', '/wmkick USER NOTE')

