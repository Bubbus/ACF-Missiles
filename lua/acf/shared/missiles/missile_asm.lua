
--define the class
ACF_defineGunClass("ASM", {
    type            = "missile",
	spread          = 1,
	name            = "Air-To-Surface Missile",
	desc            = "Missiles specialized for air-to-surface operation. These missiles are heavier than air-to-air missiles and may only be wire or laser guided.",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 1,
	sound           = "acf_extra/airfx/rocket_fire2.wav",
	soundDistance   = " ",
	soundNormal     = " ",
    effect          = "Rocket Motor",
    
    reloadmul       = 8,
    
    ammoBlacklist   = {"AP", "APHE", "FL", "SM"} -- Including FL would mean changing the way round classes work.
} )





-- The BGM-71E, a wire guided missile with medium anti-tank effectiveness.
ACF_defineGun("BGM-71E ASM", { --id
	name = "BGM-71E Missile",
	desc = "The BGM-71E missile is a lightweight, wire guided anti-tank munition. It can be used in both air-to-surface and surface-to-surface combat, making it a decent alternative for ground vehicles.",
	model = "models/missiles/bgm_71e.mdl",
	gunclass = "ASM",
    rack = "1x BGM-71E",  -- Which rack to spawn this missile on?
	length = 46,		--Used for the physics calculations
	caliber = 13,
	weight = 23,    -- Don't scale down the weight though!
	year = 1970,
	round = {
		model		= "models/missiles/bgm_71e.mdl",
		rackmdl		= "models/missiles/bgm_71e.mdl",
		maxlength	= 25.5,
		casing		= 0.3,				-- thickness of missile casing, cm
		propweight	= 1.2,				-- motor mass - motor casing
		thrust		= 6000,				-- average thrust - kg*in/s^2
		burnrate	= 350,				-- cm^3/s at average chamber pressure
		starterpct	= 0.2,				-- percentage of the propellant consumed in the starter motor.
		minspeed	= 7000,				-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.006,			-- drag coefficient of the missile
		finmul		= 0.012,				-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(0.9)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},
    
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Wire"},
    fuses       = {"Contact", "Timed"},
    
    racks       = {["1x BGM-71E"] = true, ["2x BGM-71E"] = true, ["4x BGM-71E"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
    
    seekcone    = 35,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 55,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 0.7,     -- multiplier for missile turn-rate.
    armdelay    = 0.5     -- minimum fuse arming delay
} )


-- The AGM-114, a laser guided missile with high anti-tank effectiveness.
ACF_defineGun("AGM-114 ASM", { --id
	name = "AGM-114 Missile",
	desc = "The AGM-114 Hellfire is an air-to-surface missile first developed for anti-armor use, but later models were developed for precision strikes against other target types.",
	model = "models/missiles/agm_114.mdl",
	gunclass = "ASM",
    rack = "2x AGM-114",  -- Which rack to spawn this missile on?
	length = 66,
	caliber = 16,
	weight = 45,    -- Don't scale down the weight though!
    modeldiameter = 17.2 * 1.27, -- in cm
	year = 1984,
	round = {
		model		= "models/missiles/agm_114.mdl",
		rackmdl		= "models/missiles/agm_114.mdl",
		maxlength	= 27.5,
		casing		= 0.3,			-- thickness of missile casing, cm
		propweight	= 1,			-- motor mass - motor casing
		thrust		= 10000,			-- average thrust - kg*in/s^2
		burnrate	= 500,			-- cm^3/s at average chamber pressure
		starterpct	= 0.25,			-- percentage of the propellant consumed in the starter motor.
		minspeed	= 8000,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.002,		-- drag coefficient of the missile
		finmul		= 0.005,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(1.8)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},
    
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Laser"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),
    
    racks       = {["2x AGM-114"] = true, ["4x AGM-114"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
    
    seekcone    = 35,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 30,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 0.5,		-- multiplier for missile turn-rate.
    armdelay    = 1     -- minimum fuse arming delay
} )

-- DUMB ROCKETS!!!!!1111111 --

ACF_defineGun("RS82 ASR", { --id

	name		= "RS-82 Rocket",
	desc		= "A small, unguided rocket. small missile with good HE punch - have small amount of propellant.",
	model		= "models/missiles/rs82.mdl",
	caliber		= 8,
	gunclass	= "FFAR",
    rack        = "1xRK",  -- Which rack to spawn this missile on? 
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
		casing		= 0.2,	// thickness of missile casing, cm
		propweight	= 0.7,	// motor mass - motor casing
		thrust		= 10000,	// average thrust - kg*in/s^2
		burnrate	= 800,	// cm^3/s at average chamber pressure
		starterpct	= 0.15,
        minspeed	= 6000,			-- minimum speed beyond which the fins work at 100% efficiency
        dragcoef	= 0.004,		-- drag coefficient of the missile
		finmul		= 0.003,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(6.63)  	--  139 HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
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


ACF_defineGun("HVAR ASR", { --id

	name		= "HVAR Rocket",
	desc		= "A medium, unguided rocket. similar he-filler as RS-82 rocket but it carry more propellant",
	model		= "models/missiles/hvar.mdl",
	caliber		= 12,
	gunclass	= "FFAR",
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
		casing		= 0.2,	// thickness of missile casing, cm
		propweight	= 0.7,	// motor mass - motor casing
		thrust		= 12000,	// average thrust - kg*in/s^2
		burnrate	= 600,	// cm^3/s at average chamber pressure
		starterpct	= 0.15,
        minspeed	= 6000,			-- minimum speed beyond which the fins work at 100% efficiency
        dragcoef	= 0.004,		-- drag coefficient of the missile
		finmul		= 0.003,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(6.26)  	-- 215.9 HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
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
/*
ACF_defineGun("240mmDUMB", { --id placeholder for ~200mm rocket - mousetrap or t37 HE or Wfr. Gr. 21 or S-24... as for me s-24 is the best choice cause there were other "s" missiles we can include (s25 was something like russian hellfire)

	name		= "240mm Rocket",
	desc		= "A big, unguided rocket. Mostly used by late WW2/Vietnam era planes/helicopters.",
	model		= "models/missiles/hvar.mdl",
	caliber		= 24,
	gunclass	= "FFAR",
    rack        = "1xRK",  -- Which rack to spawn this missile on? 
    weight		= 235,
    length	    = 50,
	year		= 1933,
	rofmod		= 0.6,
	roundclass	= "Rocket",
	round		= 
	{
		model		= "models/missiles/hvar.mdl",
		rackmdl		= "models/missiles/hvar.mdl", 
		maxlength	= 25,
		casing		= 0.2,	// thickness of missile casing, cm
		propweight	= 0.7,	// motor mass - motor casing
		thrust		= 15000,	// average thrust - kg*in/s^2
		burnrate	= 400,	// cm^3/s at average chamber pressure
		starterpct	= 0.15,
        minspeed	= 6000,			-- minimum speed beyond which the fins work at 100% efficiency
        dragcoef	= 0.004,		-- drag coefficient of the missile
		finmul		= 0.003,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(0.1)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},
	
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = {"Contact", "Timed"},
    
    racks       = {["70mm7xPOD"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
    
    seekcone    = 35,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 55,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1,     -- multiplier for missile turn-rate.
    armdelay    = 0.3     -- minimum fuse arming delay
} )

ACF_defineGun("298mmDUMB", { --id placeholder for tinytim

	name		= "298mm Rocket",
	desc		= "A massive, unguided rocket. Mostly used by late WW2/Vietnam era planes/helicopters.",
	model		= "models/missiles/hvar.mdl",
	caliber		= 30,
	gunclass	= "FFAR",
    rack        = "1xRK",  -- Which rack to spawn this missile on? 
    weight		= 583,
    length	    = 58,
	year		= 1933,
	rofmod		= 0.6,
	roundclass	= "Rocket",
	round		= 
	{
		model		= "models/missiles/hvar.mdl",
		rackmdl		= "models/missiles/hvar.mdl",
		maxlength	= 25,
		casing		= 0.2,	// thickness of missile casing, cm
		propweight	= 0.7,	// motor mass - motor casing
		thrust		= 15000,	// average thrust - kg*in/s^2
		burnrate	= 400,	// cm^3/s at average chamber pressure
		starterpct	= 0.15,
        minspeed	= 6000,			-- minimum speed beyond which the fins work at 100% efficiency
        dragcoef	= 0.004,		-- drag coefficient of the missile
		finmul		= 0.003,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(0.1)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},
	
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = {"Contact", "Timed"},
    
    racks       = {["70mm7xPOD"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
    
    seekcone    = 35,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 55,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1,     -- multiplier for missile turn-rate.
    armdelay    = 0.3     -- minimum fuse arming delay
} )

//*/