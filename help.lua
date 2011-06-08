local lib = register("help")

lib:hook("commanded", nil,
function (perform)
	local help = lib.help()
	local detail = lib.detail

	if detail.parameter ~= "" then
		local commands = help[detail.parameter]
		if commands then
			local list = {}
			for command, details in pairs(commands) do
				table.insert(list, command)
			end

			if #list > 0 then
				perform("playermessage", "Available "..detail.parameter.." commands: (&f/help &cCOMMAND &efor more)\n- "..join(", ", unpack(list)))
			else
				perform("playermessage", "There are no "..detail.parameter.." commands available")
			end
			return
		end

		for section, commands in pairs(help) do
			local command = commands[detail.parameter]
			if command then
				local message, usage = unpack(command)
				if usage then
					perform("playermessage", "Usage: &f"..usage)
				end
				if message then
					perform("playermessage", "- &b"..message)
				end
				return
			end
		end
		perform("playermessage", "Command not found: "..detail.parameter)
	else
		perform("playermessage", "Welcome to WoM Realms. To view a list of available commands type one of:\n- &f/help general&e, &f/help moderate&e, or &f/help build\nImportant commands:\n- &f/home &eTakes you to your realm\n- &f/realm &cNAME &eTakes you to someone else's realm\n- &f/worlds &cNAME &eLists someone else's worlds\n- &f/chat &eBrings you back to chat realm, which allows global chat!");
	end
end
)
