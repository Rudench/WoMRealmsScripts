
local lib = register("paint")

lib:hook("commanded",
function()
	local detail = lib.detail

	if detail.mapFile == "maps/chat" and detail.userLevel < 5 and detail.adminLevel < 1 then
		return false, "You may not build, here, type &f/home"
	end

	local result, message = lib:perms("Advanced", "Visitor", "Artist")
	if result == false then return result, message end

	if not detail.parameter then
		return false, "Please supply a tile name"
	end

	local tile = lib.tile(detail.parameter)
	if detail.parameter == 'active' then
		tile = 255
	end

	if tile == -1 then
		return false, "Unknown tile: "..detail.parameter
	end
end,
function(perform)
	local detail = lib.detail

	local tileName
	local tile = lib.tile(detail.parameter)
	if detail.parameter == 'active' then
		tile = 255
		tileName = "Currently active tile"
	else
		tileName = lib.tiles[tile]
	end

	local isOwner = false if detail.username == detail.mapOwner then isOwner = true end
	if (tile == 8 or tile == 10) and (not isOwner) and detail.userMapLevel < 10 then
		tile = tile + 1
	end

	perform("painttile", tileName, tile)
end
)

lib.help('build', 'paint', 'paint a specific tile wherever you place or delete\nUse either the desired tile name to paint the named tile or the special "active" keyword to use whatever tile you are holding in your hand', '/paint TILENAME')

