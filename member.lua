-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("member")

lib:hook("commanded",
nil,
function(perform)
	local email = lib.detail.parameter
	if not email or email == "" then
		perform("playermessage", "Hi, to upgrade to member, simply type:\n- &f/member &cEMAILADDRESS\nand proceed to http://womrealms.com")
		return
	end

	perform("playermessage", "Go to http://womrealms.com and enter the following code when you sign up using this email address:")
	perform("generatecode", email)
end
)

lib.help('general', 'member', 'become a member to use special commands', '/member')
