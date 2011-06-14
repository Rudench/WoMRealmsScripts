local function ping(perform)
	perform("playermessage", "pong, lagtest sponsored by WoM")
end

local lib = register("ping")
lib:hook("commanded", nil, ping)

lib.help('general', 'ping', 'will reply to you, so you can determine if you have lag', '/ping')
