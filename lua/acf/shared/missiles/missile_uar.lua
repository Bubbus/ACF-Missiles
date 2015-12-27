
--define the class
ACF_defineGunClass("UAR", {
    type            = "missile",
	spread          = 1,
	name            = "Unguided Aerial Rockets",
	desc            = "Rockets which fit in racks. Usefull in rocket artillery. Slower fire-rate than FFAR but bigger 'boom'",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 0.5,
	sound           = "acf_extra/airfx/rocket_fire2.wav",
	soundDistance   = " ",
	soundNormal     = " ",
    effect          = "Rocket Motor",

    ammoBlacklist   = {"AP", "APHE", "FL"} -- Including FL would mean changing the way round classes work.
} )




ACF_defineGun("RS82 ASR", { --id

	name		= "RS-82 Rocket",
	desc		= "A small, unguided rocket. small missile with good HE punch - have small amount of propellant.",
	model		= "models/missiles/rs82.mdl",
	caliber		= 8,
	gunclass	= "UAR",
    rack        = "1xRK_small",  -- Which rack to spawn this missile on?
    weight		= 5,
    length	    = 40,
	year		= 1933,
	rofmod		= 0.6,
	roundclass	= "Rocket",
	round		=
	{
		model		= "models/missiles/rs82.mdl",
		rackmdl		= "models/missiles/rs82.mdl",
		maxlength	= 25,
		casing		= 0.2,			-- thickness of missile casing, cm
		armour		= 8,			-- effective armour thickness of casing, in mm
		propweight	= 0.7,			-- motor mass - motor casing
		thrust		= 15000,		-- average thrust - kg*in/s^2
		burnrate	= 800,			-- cm^3/s at average chamber pressure
		starterpct	= 0.15,
        minspeed	= 6000,			-- minimum speed beyond which the fins work at 100% efficiency
        dragcoef	= 0.004,		-- drag coefficient while falling
        dragcoefflight  = 0.025,                 -- drag coefficient during flight
		finmul		= 0.008,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(6.63)  	--  139 HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = {"Contact", "Timed"},

    racks       = {["1xRK_small"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    armdelay    = 0.3     -- minimum fuse arming delay
} )


ACF_defineGun("HVAR ASR", { --id

	name		= "HVAR Rocket",
	desc		= "A medium, unguided rocket. similar he-filler as RS-82 rocket but it carry more propellant",
	model		= "models/missiles/hvar.mdl",
	caliber		= 12,
	gunclass	= "UAR",
    rack        = "1xRK",  -- Which rack to spawn this missile on?
    weight		= 63,
    length	    = 44,
	year		= 1933,
	rofmod		= 0.5,
	roundclass	= "Rocket",
	round		=
	{
		model		= "models/missiles/hvar.mdl",
		rackmdl		= "models/missiles/hvar.mdl",
		maxlength	= 25,
		casing		= 0.2,			-- thickness of missile casing, cm
		armour		= 12,			-- effective armour thickness of casing, in mm
		propweight	= 0.7,			-- motor mass - motor casing
		thrust		= 25000,		-- average thrust - kg*in/s^2
		burnrate	= 600,			-- cm^3/s at average chamber pressure
		starterpct	= 0.15,
        minspeed	= 6000,			-- minimum speed beyond which the fins work at 100% efficiency
        dragcoef	= 0.003,		-- drag coefficient while falling
        dragcoefflight  = 0.02,                 -- drag coefficient during flight
		finmul		= 0.01,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(6.26)  	-- 215.9 HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = {"Contact", "Timed"},

    racks       = {["1xRK"] = true, ["3xUARRK"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    armdelay    = 0.3     -- minimum fuse arming delay
} )

ACF_defineGun("S-24 ASR", { --id

	name		= "S-24 Rocket",
	desc		= "A big, unguided rocket. Mostly used by late WW2/Vietnam era planes/helicopters.",
	model		= "models/missiles/s24.mdl",
	caliber		= 24,
	gunclass	= "UAR",
    rack        = "1xRK",  -- Which rack to spawn this missile on?
    weight		= 235,
    length	    = 25,
	year		= 1960,
	rofmod		= 0.6,
	roundclass	= "Rocket",
	round		=
	{
		model		= "models/missiles/s24.mdl",
		rackmdl		= "models/missiles/s24.mdl",
		maxlength	= 40,
		casing		= 0.5,			-- thickness of missile casing, cm
		armour		= 18,			-- effective armour thickness of casing, in mm
		propweight	= 15,			-- motor mass - motor casing
		thrust		= 15000,		-- average thrust - kg*in/s^2
		burnrate	= 1400,			-- cm^3/s at average chamber pressure
		starterpct	= 0.15,
        minspeed	= 7000,			-- minimum speed beyond which the fins work at 100% efficiency
        dragcoef	= 0.004,		-- drag coefficient while falling
        dragcoefflight  = 0.015,                 -- drag coefficient during flight
		finmul		= 0.015,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(5)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = {"Contact", "Timed"},

    racks       = {["1xRK"] = true, ["6xUARRK"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

	skinindex   = {HEAT = 0, HE = 1},
    armdelay    = 0.3     -- minimum fuse arming delay
} )

--[[
ACF_defineGun("RW61 ASR", { --id

	name		= "Raketwerfer-61",
	desc		= "Sturmtiger main weapon - 360mm missile - it gives thrust just for first second and gives boom comparable to 500kg bomb.",
	model		= "models/missiles/RW61M.mdl",
	caliber		= 38,
	gunclass	= "UAR",
    rack        = "380mmRW61",  -- Which rack to spawn this missile on?
    weight		= 1500,
    length	    = 38,
	year		= 1960,
	rofmod		= 0.6,
	roundclass	= "Rocket",
	round		=
	{
		model		= "models/missiles/RW61M.mdl",
		rackmdl		= "models/missiles/RW61M.mdl",
		maxlength	= 140,
		casing		= 2.0,	        -- thickness of missile casing, cm
		armour		= 24,			-- effective armour thickness of casing, in mm
		propweight	= 5,	        -- motor mass - motor casing
		thrust		= 5000,	    	-- average thrust - kg*in/s^2
		burnrate	= 10000,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.015,        -- percentage of the propellant consumed in the starter motor.
		minspeed	= 1,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.002,		-- drag coefficient of the missile
		finmul		= 0.0001,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(2)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = {"Contact", "Timed"},

    racks       = {["380mmRW61"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    seekcone    = 35,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 55,   -- getting outside this cone will break the lock.  Divided by 2.

    agility     = 1,     -- multiplier for missile turn-rate.
    armdelay    = 0.3     -- minimum fuse arming delay
} )

ACF_defineGun("298mmDUMB", { --id placeholder for tinytim

	name		= "298mm Rocket",
	desc		= "A massive, unguided rocket. Mostly used by late WW2/Vietnam era planes/helicopters.",
	model		= "models/missiles/tinytim.mdl",
	caliber		= 30,
	gunclass	= "UAR",
    rack        = "1xRK",  -- Which rack to spawn this missile on?
    weight		= 583,
    length	    = 58,
	year		= 1933,
	rofmod		= 0.6,
	roundclass	= "Rocket",
	round		=
	{
		model		= "models/missiles/tinytim.mdl",
		rackmdl		= "models/missiles/tinytim.mdl",
		maxlength	= 60,
		casing		= 0.2,			-- thickness of missile casing, cm
		armour		= 24,			-- effective armour thickness of casing, in mm
		propweight	= 0.7,			-- motor mass - motor casing
		thrust		= 15000,		-- average thrust - kg*in/s^2
		burnrate	= 400,			-- cm^3/s at average chamber pressure
		starterpct	= 0.15,
        minspeed	= 6000,			-- minimum speed beyond which the fins work at 100% efficiency
        dragcoef	= 0.004,		-- drag coefficient of the missile
		finmul		= 0.003,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(0.1)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = {"Contact", "Timed"},

    racks       = {["1xRK"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    seekcone    = 35,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 55,   -- getting outside this cone will break the lock.  Divided by 2.

    agility     = 1,     -- multiplier for missile turn-rate.
    armdelay    = 0.3     -- minimum fuse arming delay
} )

]]
