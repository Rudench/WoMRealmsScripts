-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("motd")

lib:hook("mapchange",
function()
	local d = lib.detail
	filename = lib.getMapFilename(d.newtype, d.newname, d.newextra)
	if filename then
		if d.newtype == 'user' and d.newname ~= d.username then
			local lock = mapdata("locked", nil, filename)
			if lock ~= nil and tonumber(lock) == 1 and d.adminLevel < 2 then
				local maplevel = mapaccess(filename)
				if not maplevel or maplevel < 1 then
					return false, "The destination world is locked"
				end
			end
		end
	end
end,
function(perform)
	local d = lib.detail
	if filename then
		local motd = mapdata("motd", nil, filename)
		if motd and motd ~= "" then
			motd = "Welcome: "..motd
			local lines = lib.wrap(motd, 55)
			for pos, line in ipairs(lines) do
				perform("playermessage", "- &3"..line)
			end
		end
	end
end)

