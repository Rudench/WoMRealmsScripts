
local lib = register("replaceall")

lib:hook("commanded",
function()
	local detail = lib.detail

	if detail.mapFile == "maps/chat" and detail.userLevel < 5 and detail.adminLevel < 1 then
		return false, "You may not build, here, type &f/home"
	end

	local result, message = lib:perms("Advanced", "Visitor", "Artist")
	if result == false then return result, message end

	local find, replace = split(detail.parameter, " ")

	local findTile = lib.tile(find)
	if findTile == -1 then return false, "Unknown tile: " .. find end

	local replaceTile = lib.tile(replace)
	if replaceTile == -1 then return false, "Unknown tile: " .. replace end
end,
function(perform)
	local detail = lib.detail

	local find, replace = split(detail.parameter, " ")

	map = detail.mapFile:sub(5)
	perform("mapcopy", '.checkpoint_'..map, 0,0,0, 1024,1024,1024);
	perform("fill", 0, 0, 0, detail.mapW - 1, detail.mapD - 1, detail.mapH - 1, lib.tile(replace), lib.tile(find))
end
)

lib.help('build', 'replaceall', 'replace all the same tiles with a different tile (e.g /replaceall dirt brick) would replace all dirt in you realm with bricks', '/replaceall TILENAME TILENAME')
