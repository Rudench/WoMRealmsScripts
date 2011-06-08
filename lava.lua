
local lib = register("lava")

lib:hook("commanded",
function()
	local detail = lib.detail

	if detail.mapFile == "maps/chat" and detail.userLevel < 5 and detail.adminLevel < 1 then
		return false, "You may not build, here, type &f/home"
	end

	local result, message = lib:perms("Advanced", "Visitor", "Artist")
	if result == false then return result, message end
end,
function(perform)
	local detail = lib.detail

	local isOwner = false if detail.username == detail.mapOwner then isOwner = true end

	local placeTile = "lava"
	if detail.parameter == "real" and (isOwner or detail.userMapLevel >= 10 or detail.userLevel >= 10) then
		placeTile = "reallava"
	end

	perform("painttile", placeTile, lib.tile(placeTile))
end
)

lib.help('build', 'lava', 'place a lava tile tile', '/lava')

