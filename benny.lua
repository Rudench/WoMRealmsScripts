-- Copyright 2011, Norganna's AddOns Pty Ltd. All rights reserved.
-- Contributed by: thatbennyguy.
local function benny(perform)
    perform("playermessage", "thatbennyguy is the best, and you ALL know it! JK mou is :3");
end

local lib = register("benny")
lib:hook("commanded", nil, benny)

lib.help('general', 'benny', 'details on how to obtain the REAL truth', '/benny')

local handsome = register("handsome")
handsome:hook("commanded", nil, benny)
