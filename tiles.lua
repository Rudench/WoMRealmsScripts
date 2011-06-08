lib = register("tiles")

lib:hook("commanded", nil,
function (perform)
	perform("playermessage", "Tiles: "..join(" ", unpack(lib.tiles)));
end)

lib.help('build', 'tiles', 'show the avaliable tiles', '/tiles')


