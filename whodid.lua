local lib = register("whodid")

lib:hook("commanded", nil,
function(perform)
	local detail = lib.detail

	perform("playermessage", "Place or destroy a tile to find out who did it")
	perform("getpoints", "who did it", "")
end
)

lib:hook("marked", nil,
function(perform)
	local detail = lib.detail

	local x, z, y = split(detail["who did it"], ",")
	
	perform("whodid", x, z, y)
end
)

lib.help('build', 'whodid', 'shows who did actions at a location', '/whodid')

