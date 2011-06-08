
local lib = register("uac")

lib:hook("messaged",
function()
	local detail = lib.detail
	detail.userLevel = math.floor(detail.userLevel)

	if detail.message == "" then
		return false, "Can not send empty message"
	end

	if (detail.msgType == "ctalk" and detail.clanId < 1) then
		return false, "Must be in a clan to use this channel"
	end

	if (detail.msgType == "talk" or detail.msgType == "act") and (detail.username == detail.mapOwner or detail.userMapLevel > 0) then
		return
	end

	local silenced = detail.silenced
	if silenced > 0 then
		return false, "You are silenced. Deal with it!"
	end

	if (detail.msgType == "wmsg" or detail.msgType == "wsay" or detail.msgType == "wtalk" or detail.msgType == "bcast") and detail.adminLevel < 1 then
		return false, "You are not allowed to use this channel"
	end
end
)

lib:hook("placed",
function()
	local detail = lib.detail

--	if detail.mapFile == "maps/chat" and detail.userLevel < 5 and detail.adminLevel < 1 then
	if detail.mapFile == "maps/chat" and detail.adminLevel < 2 and detail.username ~= detail.mapOwner then
		return false, "You can't build on chat realm, type &f/home"
	end
	if string.sub(detail.mapFile, 1, 12) == "maps/museum+" then
		local allowed = lib:perms("Build", "Visitor", "Architect")
		if allowed == false then
			return false, "This is a museum"
		end
	end

	return lib:perms("Build", "Visitor", "Surveyor")
end
)

