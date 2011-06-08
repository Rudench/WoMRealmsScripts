
local lib = register("paste")

lib:hook("commanded",
function()
	local detail = lib.detail

	if detail.mapFile == "maps/chat" and detail.userLevel < 5 and detail.adminLevel < 1 then
		return false, "You may not build, here, type &f/home"
	end

	local result, message = lib:perms("Advanced", "Visitor", "Artist")
	if result == false then return result, message end

	if detail.parameter == "" then
		return false, "You must specify a Region Name"
	end
end,
function(perform)
	local detail = lib.detail
	local map = detail.mapFile:sub(5)

	perform("getpoints", "paste from", detail.parameter..":"..map)
	print("MapFile =", detail.mapFile)

end
)

lib:hook("marked", nil,
function(perform)
	local detail = lib.detail
	local region, map = split(detail.data, ':')

	local x, z, y = split(detail["paste from"], ",")

	perform("mapcopy", '.checkpoint_'..map, 0,0,0, 1024,1024,1024);
	perform("mappaste", region, x, z, y)
end
)

lib.help('build', 'paste', 'paste a cuboid to a named region\ndirection: north|south|east|west|cw|ccw|90deg|180deg\nor a matrix define eg: zyX (swap z-x, invert x)', '/paste MYREGIONAME [DIRECTION]')

