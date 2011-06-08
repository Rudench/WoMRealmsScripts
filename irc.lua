-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.

local function irc(perform)
	perform("playermessage", "WoM IRC - For help and general chat\n- &fGoto: &chttp://womjr.com/irc\n- &fIRC Rules: &chttp://womjr.com/irc_rules.");
end

local lib = register("irc")
lib:hook("commanded", nil, irc)

lib.help('general', 'irc', 'Internet Relay Chat (IRC) is a form of real-time Internet text messaging (chat) or synchronous conferencing.', '/irc')
