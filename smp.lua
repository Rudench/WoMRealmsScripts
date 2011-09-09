local function smp(perform)
	perform("playermessage", "WoM SMP\n- &fcurrently open for surveyor+ or premium\n- &fyou &cneed &fto buy minecraft beta to be able to connect\n- &cIP = smp.womjr.com")
end

local lib = register("smp")
lib:hook("commanded", nil, smp)

lib.help('general', 'smp', 'displays information on how to join WoM SMP', '/smp')
