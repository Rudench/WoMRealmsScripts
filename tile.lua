local lib = register("tile")

lib:hook("commanded", nil,
function(perform)
	local detail = lib.detail

	perform("playermessage", "Destroy a tile to find out it's name")
	perform("getpoints", "identifytile", "")
end
)

lib:hook("marked", nil,
function(perform)
	local detail = lib.detail

	local x, z, y = split(detail["identifytile"], ",")
	
	perform("tell", x, z, y)
end
)

lib.help('build', 'tile', 'tell the name of the tile at a location', '/tile')

