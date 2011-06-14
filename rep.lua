local lib = register("rep")
local function rep(perform)
	perform("playermessage", "A guide on the amount of rep an action gives on a world. You may only have a maximum of 2500 actions per world per hour up to a maximum of 5000 per hour in total.\nPoints per action: 0&6*&e=&a1&ePPA,\n 1&6*&e=&a2&ePPA, 2&6*&e=&a5&ePPA, 3&6*&e=&a10&ePPA,\n 4&6*&e=&a20&ePPA, 5&6*&e=&a40&ePPA, 6&6*&e=&a60&ePPA,\nand  &f/project&e=&a75&ePPA, &f/contest&e=&a90&ePPA\n+10% of all rep gains on your worlds. +extra 50% clan bonus for building on clan worlds. +1% of all clan rep goes to clan leader.\nFreemium members get their points doubled and premium members get rep tripled.\nYou currently have: "..lib.detail.repPoints.." rep")
end
lib:hook("commanded", nil, rep)

lib.help('general', 'rep', 'Shows the amount of reputation points you get for each block', '/rep')
