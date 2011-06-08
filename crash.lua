-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("crash")
lib:hook("commanded", nil, function(perform)
	perform("playermessage", "This should crash you &f");
end)
