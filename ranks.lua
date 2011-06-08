local function rank(perform)
		perform("playermessage",
"Ranks: &8Restricted &aVisitor &2Worker &9Builder &1Surveyor\n"..
"- &cDesigner &4Artist &bTechnician &3Architect &7Constructor\n"..
"- &6Engineer\n"..
"To rank up you need to get reputation. Building on realms with more stars gets you reputation faster. To have more stars on your realm, you need to get people to /like it. Likes from people with higher reputation are worth more. Once you have enough reputation you can upgrade your level. You can check your repuation and upgrade your rank via your control panel at &fwomrealms.com.")
end

register("rank"):hook("commanded", nil, rank)
register("colors"):hook("commanded", nil, rank)

local lib = register("ranks")
lib:hook("commanded", nil, rank)
lib.help('general', 'ranks', 'show the avaliable ranks and colors', '/ranks')


