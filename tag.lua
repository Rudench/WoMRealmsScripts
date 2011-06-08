-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.

local lib = register("tag")
lib:hook("commanded", function()
	local customName = lib.detail.parameter
	if lib.detail.clanId < 1 and customName ~= "" then
		return false, 'You must be in a clan'
	end

	if customName ~= "" and exists(customName) then
		return false, 'A player exists with that name'
	end

	if string.len(customName) > 12 then
		return false, 'May only tag 12 characters'
	end

	if string.find(customName, '[^ -|]') then
		return false, 'Contains invalid character'
	end

end, function(perform)
	local customName = lib.detail.parameter
	if (customName ~= "") then
		customName = "<"..customName.."> "..lib.detail.username
		userdata("customName", customName)
		perform("playermessage", "Name: ".. customName);
		perform("playermessage", "Type /tag to disable");
	else
		userdata("customName", "")
		perform("playermessage", "Disabled custom tag");
	end
end)
