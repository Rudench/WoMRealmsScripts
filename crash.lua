
local lib = register("crash")
lib:hook("commanded", nil, function(perform)
	perform("playermessage", "This should crash you &f");
end)
