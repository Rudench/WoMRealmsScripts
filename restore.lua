local lib = register("restore")

lib:hook("commanded",
function()
	local detail = lib.detail

	if detail.mapFile == "maps/chat" and detail.userLevel < 5 and detail.adminLevel < 1 then
		return false, "You may not build, here, type &f/home"
	end

	local result, message = lib:perms("Owner", "Visitor", "Support")
	if result == false then return result, message end
end,
function(perform)
	local detail = lib.detail
	local map = detail.mapFile:sub(6)
	perform("mapcopy", '.checkpoint_'..map, 0,0,0, 1024,1024,1024);
	perform("mappaste", '.backup_'..map, 0, 0, 0)
	local mapType, mapOwner, mapExtra = lib.parseMap(detail.mapFile)
	local message = "Restoring "..mapType.." map "..mapOwner
	if mapExtra and mapExtra ~= "" then
		message = message.." world "..mapExtra
	end
	perform("playermessage", message)
end
)

lib.help('build', 'restore', 'restore your map from previous backup', '/restore')

