
local function rules(perform)
	perform("playermessage", "To view the rules, visit &fhttp://womrealms.com/");
	perform("playermessage", "- &5<WM>&e, the WoM Realm Master will assist you with any questions you may have.\n- If you get any instruction from &5<WM>&e, obey immediately.");
end

local lib = register("rules")
lib:hook("commanded", nil, rules)

lib.help('general', 'rules', 'Tells the user where to find the rules.', '/rules')
