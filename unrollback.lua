
local lib = register("unrollback")

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
	local map = detail.mapFile:sub(5)
	perform("mapcopy", '.checkpoint_'..map, 0,0,0, 1024,1024,1024);
	perform("mappaste", '.uncheckpoint_'..map, 0, 0, 0)
end
)

lib.help('build', 'unrollback', 'unrollback your last rollback\nTo rollback your unrollback, use rollback.\nConfused? Good!', '/unrollback')

