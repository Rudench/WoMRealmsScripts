
local function client(perform)
	perform("playermessage", "Fly, Speed, Noclip are part of the WoM Game Client. To get the client, visit http://womjr.com/Game_Client");
end

local lib = register("client")
lib:hook("commanded", nil, client)

lib.help('general', 'client', 'details on how to obtain the WoM Game Client', '/client')

local fly = register("fly")
fly:hook("commanded", nil, client)
