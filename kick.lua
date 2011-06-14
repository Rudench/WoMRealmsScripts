-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
-- Contributed by: kevinsweijen.
local lib = register ("kick")

lib:hook("commanded",
function()
	local detail = lib.detail

	if detail.adminLevel < 1 then
		local result, message = lib:perms("Admin", "Visitor", "Support")
		if result == false then return result, message end
	end

	if detail.parameter == "" then
		return false, "Syntax: /kick USER REASON"
	end

	name, reason = split(detail.parameter, " ", 2)

	if not reason then
		return false, "Please supply a reason for the action"
	end

	username, userLevel, adminLevel, clanId, isOnline, mapFile = exists(name)
	if not username then
		return false, "Unknown user: "..name
	end

	if username == detail.username then
		return false, "Don't be silly!"
	end

	if not isOnline then
		return false, "That user is not online"
	end

	if mapFile ~= detail.mapFile then
		return false, "User is not on this map"
	end

	if adminLevel > 1 or userLevel >= 99 then
		return false, "You can not kick staff"
	end

	local userMapLevel = mapaccess(detail.mapFile, username)
	if userMapLevel and userMapLevel >= 10 then
		return false, "You can not kick the realm owner"
	end

	addnote(username, 'realmkick', 'who=' .. detail.username .. ";action=kicked;reason="..reason)
end,
function(perform)
	local detail = lib.detail
	perform("playermessage", "Kicking " .. username .. " from this realm")
	perform("mapchange", "other", "chat", "", username)
	perform("messageto", username, "You have been kicked from this realm")
	perform("adminmessage", detail.username.." booted "..username.."\n - "..reason)
end
)

lib.help('moderate', 'kick', 'kicks user from your world', '/kick USER REASON')
