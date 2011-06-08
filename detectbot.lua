-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
local lib = register("detectbot");

local badWords = {}
badWords.restore = true
badWords.cuboid = true
badWords.sponge = true
badWords.goaway = true
badWords.abort = true
badWords.copy = true
badWords.paste = true
badWords.say = true
badWords.erase = true
badWords.backup = true

lib:hook("messaged",
function ()
end,
function (perform)
	local detail = lib.detail
	local i,j, firstWord = string.find(detail.message, "^%s*[^/]([^%s]+) ")

	if detail.msgType == 'wsay' or detail.msgType == 'bcast' then
		perform("adminmessage", detail.username.." using &5<WM>")
	elseif firstWord and badWords[firstWord] then
		perform("adminmessage", "WARNING: &cBot command detected from "..detail.username..":\n- "..detail.message)
	end
end)

