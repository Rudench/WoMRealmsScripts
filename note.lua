local lib = register("note")

lib:hook("commanded",
function()
	local detail = lib.detail

	if (detail.adminLevel < 1 ) then
		return false, "You are not allowed to use this command"
	end

	if not detail.parameter then
		return false, "Syntax: /note USER NOTE"
	end

	name, note = split(detail.parameter, " ", 2)

	if not note or note == "" then
		return false, "Syntax: /note USER NOTE"
	end

	username, destLevel = exists(name)
	if not username then
		return false, "Unknown user: "..name
	end
end,
function(perform)
	local detail = lib.detail
        addnote(username, 'note', 'who=' .. detail.username .. ";note="..note)

	perform("playermessage", "Note applied to: "..username)
end
)

lib.help('support', 'note', 'add a note to a user', '/note USER NOTE')
