local lib = register("chat")

lib:hook("commanded",
nil,
function (perform)
	local detail = lib.detail

	perform("mapchange", "other", "chat", "")
end)

lib.help('general', 'chat', 'change to a WoM chat realm', '/chat')

