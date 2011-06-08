local lib = register("like")
local function like(perform)
	if not lib.detail.mapOwner then
		return
	elseif lib.detail.username == lib.detail.mapOwner then
		perform("playermessage", "Cannot vote on your own realm")
		return
	end

	mapvote(1)
	perform("playermessage", "You have liked this realm")
end
lib:hook("commanded", nil, like)
lib.help('general', 'like', 'Vote for this realm', '/like')
register("love"):hook("commanded", nil, like)

local lib2 = register("dislike")
local function dislike(perform)
	if not lib2.detail.mapOwner then
		return
	elseif lib2.detail.username == lib2.detail.mapOwner then
		perform("playermessage", "Cannot vote on your own realm")
		return
	end

	mapvote(-1)
	perform("playermessage", "You have disliked this realm")
end
lib2:hook("commanded", nil, dislike)
register("unlike"):hook("commanded", nil, dislike)
register("nolike"):hook("commanded", nil, dislike)
register("hate"):hook("commanded", nil, dislike)
lib2.help('general', 'dislike', 'Vote against this realm', '/dislike')

