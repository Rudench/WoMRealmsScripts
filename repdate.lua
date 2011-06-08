local function repdate(perform)

	local remain
	local now = os.time()
	local min = math.floor((now / 60) % 60)
	if min < 5 then
	    remain = 5 - min
	else
	    remain = 65 - min
	end

	perform("playermessage", "Reputation update runs at &cfive &eminutes past every hour.");
	perform("playermessage", "Next update is in &f"..remain.." minutes");
	perform("playermessage", "- &cPlease be patient.");
end

local lib = register("repdate")
lib:hook("commanded", nil, repdate)

lib.help('general', 'repdate', 'Informs the user of Reputation Update', '/repdate')
