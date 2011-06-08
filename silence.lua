-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("silence")

lib:hook("commanded",
function()
	local detail = lib.detail

	if (detail.adminLevel < 1 ) then
		return false, "You are not allowed to use this command"
	end

	if not detail.parameter then
		return false, "Syntax: /silence USER REASON"
	end

	name, reason = split(detail.parameter, " ", 2)

	if not reason then
		return false, "Must supply a reason for the note"
	end

	username, destLevel = exists(name)
	if not username then
		return false, "Unknown user: "..name
	end
end,
function(perform)
	local detail = lib.detail
	perform("adminmessage", detail.username.." silenced "..username.."\n - "..reason)
        addnote(username, 'silence', 'who=' .. detail.username .. ";action=silenced;reason="..reason)
	userdata("silence", os.time() + 300, username)
end
)

lib.help('support', 'silence', 'silence users', '/silence USER NOTE')
