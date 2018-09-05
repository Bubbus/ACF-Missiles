	
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

    ammoBlacklist   = {"AP", "APHE", "FL", "SM"} -- Including FL would mean changing the way round classes work.
} )




ACF_defineGun("RS82 ASR", { --id

	name		= "RS-82 Rocket",
	desc		= "A small, unguided rocket, often used in multiple-launch artillery as well as for attacking pinpoint ground targets.  It has a small amount of propellant, limiting its range, but is compact and light.",
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
        dragcoef	= 0.002,		-- drag coefficient while falling
        dragcoefflight  = 0.025,                 -- drag coefficient during flight
		finmul		= 0.008,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(6.63)  	--  139 HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = {"Contact", "Timed"},

    racks       = {["1xRK_small"] = true, ["2xRK"] = true, ["3xRK"] = true, ["4xRK"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    armdelay    = 0.3     -- minimum fuse arming delay
} )


ACF_defineGun("HVAR ASR", { --id

	name		= "HVAR Rocket",
	desc		= "A medium, unguided rocket. More bang than the RS82, at the cost of size and weight.",
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
        minspeed	= 5000,			-- minimum speed beyond which the fins work at 100% efficiency
        dragcoef	= 0.002,		-- drag coefficient while falling
        dragcoefflight  = 0.02,                 -- drag coefficient during flight
		finmul		= 0.01,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(6.25)  	-- 215.9 HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = {"Contact", "Timed"},

    racks       = {["1xRK"] = true, ["1xRK_small"] = true, ["3xUARRK"] = true, ["2xRK"] = true, ["3xRK"] = true, ["4xRK"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    armdelay    = 0.3     -- minimum fuse arming delay
} )

ACF_defineGun("SPG-9 ASR", { --id

	name		= "SPG-9 Rocket",
	desc		= "A recoilless rocket launcher similar to an RPG or Grom.  The main charge ignites in the tube, while a rocket accelerates a small antitank grenade to the target, giving it a high initial velocity, smaller launch signature, and flatter trajectory than a conventional round but less accuracy.  A useful alternative to guided missiles, it is also quite capable as lightweight HE-slinging artillery for air-drop and expeditionary forces.",
	model		= "models/munitions/round_100mm_mortar_shot.mdl",
	caliber		= 7.3,
	gunclass	= "UAR",
    rack        = "1x SPG9",  -- Which rack to spawn this missile on?
    weight		= 40,
    length	    = 20,
	year		= 1962,
	rofmod		= 0.75,
	roundclass	= "Rocket",
	round		=
	{
		model		= "models/missiles/glatgm/9m112f.mdl",
		rackmdl		= "models/munitions/round_100mm_mortar_shot.mdl",
		maxlength	= 63,
		casing		= 0.08,			-- thickness of missile casing, cm
		armour		= 10,			-- effective armour thickness of casing, in mm
		propweight	= 0.5,			-- motor mass - motor casing
		thrust		= 120000,		-- average thrust - kg*in/s^2 very high but only burns a brief moment, most of which is in the tube
		burnrate	= 1200,			-- cm^3/s at average chamber pressure
		starterpct	= 0.72,
        minspeed	= 900,			-- minimum speed beyond which the fins work at 100% efficiency
        dragcoefflight  = 0.05,                 -- drag coefficient during flight
        dragcoef	= 0.001,		-- drag coefficient while falling
		finmul		= 0.02,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(4.1)  	-- 215.9 HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = {"Contact", "Optical"},

    racks       = {["1x SPG9"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    armdelay    = 0.05     -- minimum fuse arming delay, very short since we have a high muzzle velocity
} )

ACF_defineGun("S-24 ASR", { --id

	name		= "S-24 Rocket",
	desc		= "A big, unguided rocket. Mostly used by late cold war era attack planes and helicopters.",
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
		casing		= 0.3,			-- thickness of missile casing, cm
		armour		= 18,			-- effective armour thickness of casing, in mm
		propweight	= 15,			-- motor mass - motor casing
		thrust		= 9000,		-- average thrust - kg*in/s^2
		burnrate	= 1000,			-- cm^3/s at average chamber pressure
		starterpct	= 0.15,
        minspeed	= 10000,			-- minimum speed beyond which the fins work at 100% efficiency
        dragcoef	= 0.001,		-- drag coefficient while falling
        dragcoefflight  = 0.01,                 -- drag coefficient during flight
		finmul		= 0.02,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(5)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = {"Contact", "Timed"},

    racks       = {["1xRK"] = true, ["3xRK"] = true, ["2xRK"] = true, ["6xUARRK"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

	skinindex   = {HEAT = 0, HE = 1},
    armdelay    = 0.3     -- minimum fuse arming delay
} )

ACF_defineGun("Zuni ASR", { --id
	name		= "Zuni Rocket",
	desc		= "A heavy 5in air to surface unguided rocket, able to provide heavy suppressive fire in a single pass.",
	model		= "models/ghosteh/zuni.mdl",
	caliber		= 12.7,
	gunclass	= "UAR",
	rack		= "127mm4xPOD",
	weight		= 120,
	length		= 80,
	year		= 1957,
	rofmod		= 0.5,
	roundclass	= "Rocket",
	round		=
	{
		model		= "models/ghosteh/zuni.mdl",
		rackmdl		= "models/ghosteh/zuni_folded.mdl",
		maxlength	= 60,
		casing		= 0.2,
		armor		= 12,
		propweight	= 0.7,
		thrust		= 24000,
		burnrate	= 1000,
		starterpct	= 0.2,
		minspeed	= 8000,
		dragcoef	= 0.0001,
		dragcoefflight = 0.001,
		finmul		= 0.0001,
		penmul		= math.sqrt(2)
	},
	ent			= "acf_missile_to_rack",
	guidance	= {"Dumb"},
	fuses		= {"Contact", "Timed", "Optical", "Radio"},
	racks		= {["1xRK"] = true, ["2xRK"] = true, ["3xRK"] = true, ["4xRK"] = true, ["127mm4xPOD"] = true},
	armdelay	= 0.1

})


ACF_defineGun("RW61 ASR", { --id

	name		= "Raketwerfer-61",
	desc		= "A heavy, demolition-oriented rocket-assisted mortar, devastating against field works but takes a very, VERY long time to load.\n\n\nDon't miss.",
	model		= "models/missiles/RW61M.mdl",
	caliber		= 38,
	gunclass	= "UAR",
    rack        = "380mmRW61",  -- Which rack to spawn this missile on?
    weight		= 1500,
    length	    = 38,
	year		= 1960,
	rofmod		= 0.9,
	roundclass	= "Rocket",
	round		=
	{
		model		= "models/missiles/RW61M.mdl",
		rackmdl		= "models/missiles/RW61M.mdl",
		maxlength	= 60,
		casing		= 2.0,	        -- thickness of missile casing, cm
		armour		= 24,			-- effective armour thickness of casing, in mm
		propweight	= 5,	        -- motor mass - motor casing
		thrust		= 5000,	    	-- average thrust - kg*in/s^2
		burnrate	= 5000,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.01,        -- percentage of the propellant consumed in the starter motor.
		minspeed	= 1,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0,		-- drag coefficient of the missile
		finmul		= 0.001,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(2)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = {"Contact", "Optical"},

    racks       = {["380mmRW61"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    seekcone    = 35,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 55,   -- getting outside this cone will break the lock.  Divided by 2.

    agility     = 1,     -- multiplier for missile turn-rate.
    armdelay    = 0.5     -- minimum fuse arming delay
} )

--[[
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




--models/missiles/9m120_rk1.mdl
