-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("test")

lib:hook("commanded",
function()
	print("Got", getuser("spreckle"))
end)

--[[

lib:hook("started",
function()
	print("Test plugin got startup message")
end
)

lib:hook("placed",
function()
	local detail = lib.detail

	local action = "placed"
	if detail.mode == 0 then
		action = "deleted"
	end

	print("Player", detail.username, action, "a block at coord", detail.x, detail.y, detail.z, "with", lib.tiles[detail.tile])
	print("Player Access: UserLevel:", detail.userLevel, "AccountLevel:", detail.userAccountLevel, "MapLevel", detail.userMapLevel, "MapOwner", detail.mapOwner)
end
)

lib:hook("commanded",
function()
	print("Got a test command with parameter:", lib.detail.parameter)
	--pixel(1,1,1,1)

end,
function(perform)
	perform("playermessage", "I see what you did thar.")
end
)
]]
