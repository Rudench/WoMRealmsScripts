local tinsert = table.insert

local lib = register("helpful")

local tips = {
      -- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
	'To find out all the helpful commands, type &f/help',
	'If you ever want to get back to chat, type &f/chat',
	'You can start building on your own realm now, use &f/home',
	'Registering is easy and allows bigger realms, type &f/member',
	'To see what all the colors are about, just use &f/ranks',
	'As a realm owner you have a lot of tools: &f/help build',
	'To allow people to build in your realm, see: &f/help grant',
	'Wonder how everyone else is zipping around? &f/client',
	'Want to go to someones realm? Try out &f/realm &cNAME',
	'You can rate realms using &f/like &eand &f/dislike',
	'Build things to gain reputation, and improve your rank',
	'You gain more reputation for building on high rank realms',
	'Sick of these handy tips? Time to &f/member'
}

local sent = {}
local cleanupCounter = 0


function commas (num)
  assert (type (num) == "number" or
          type (num) == "string")
  
  local result = ""

  local sign, before, after = string.match (tostring (num), "^([%+%-]?)(%d*)(%.?.*)$")

  while string.len (before) > 3 do
    result = "," .. string.sub (before, -3, -1) .. result
    before = string.sub (before, 1, -4)
  end

  return sign .. before .. result .. after
end



function checkTip(perform)
	local detail = lib.detail
	
	local now
	local user = detail.username

	if not sent[user] then
		now = os.time()

		sent[user] = {}
		sent[user].counter = 0;
		sent[user].curTip = 0;
		sent[user].lastRep = 0;
		sent[user].silenced = false;
		sent[user].restricted = false;
		sent[user].lastTip = now - 10;
		return;
	end

	if detail.womClient and detail.womClient ~= "" then
		local amSilenced = (detail.silenced ~= 0)
		local amRestricted = (detail.restricted ~= 0)

		if sent[user].lastRep ~= detail.repPoints or sent[user].silenced ~= amSilenced or sent[user].restricted ~= amRestricted then
			sent[user].lastRep = detail.repPoints
			sent[user].silenced = amSilenced
			sent[user].restricted = amRestricted

			print("Sending rep points to", user)
			local message = "Rep: ".. commas(detail.repPoints)
			if amSilenced then
				message = message .. " &cSILENCED"
			end
			if amRestricted then
				message = message .. " &cRESTRICTED"
			end
			perform("playermessage", "^detail.user="..message)
		end
	end

	if sent[user].counter < 20 then
		sent[user].counter = sent[user].counter + 1
		return
	end

	now = os.time()
	local lastTip = sent[user].lastTip

	if now - lastTip < 30 then
		return
	end

	sent[user].lastTip = now
	sent[user].counter = 0

	if detail.userLevel == 0 then
		local tip = sent[user].curTip + 1
		if tip < 1 or tip > #tips then
			tip = 1
		end
			
		perform("playermessage", tips[tip])
		print("Sending tip number", tip, "/", #tips, "to", user, "=", tips[tip])
		sent[user].curTip = tip
	end

	cleanupCounter = cleanupCounter + 1
	if cleanupCounter > 10000 then
		local now = os.time()
		local clean = {}
		for user, detail in pairs(sent) do
			if now - detail.lastTip > 300 then
				tinsert(clean, user)
			end
		end

		for pos, user in ipairs(clean) do
			sent[user] = nil
		end
		cleanupCounter = 0
	end
end

lib:hook("processing", nil, checkTip);


local whodid = register("womid")

whodid:hook("commanded",
nil,
function(perform)
	perform("womclient", whodid.detail.parameter)
	local user = whodid.detail.username
	sent[user].lastRep = 0
end
)

