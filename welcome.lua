-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("welcome")

lib:hook("loggedin",
function()
	print("Got login event for", lib.detail.username)
	if lib.detail.banned and lib.detail.banned > 0 then
		print("Normal Ban:", lib.detail.banned);
		return false, "You are banned"
	end

	local ipban = tonumber(globaldata("ipban-"..lib.detail.ip));
	if (ipban and ipban > os.time()) then
		print("IP Ban:", ipban);
		return false, "You are banned"
	end
end,
function(perform)
	local detail = lib.detail
	addnote(detail.username, 'login', 'ip=' .. detail.ip)

	--                        ----------------------------------------------------------------
	perform("playermessage", "Welcome to the server, " .. detail.username .. "!")
	perform("playermessage", "With WoM: Realms, where you are owner of your own map.")
	perform("playermessage", "You control and have total freedom of your realm")
	perform("playermessage", "How popular it becomes depends on how well you run it.")
	perform("playermessage", "To go to your realm now, type &f/home");
	perform("playermessage", "To return to the chat realm, type &f/chat");
	perform("playermessage", "To start, type &f/help");

end
)

