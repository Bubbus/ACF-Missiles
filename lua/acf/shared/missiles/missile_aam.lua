
--define the class
ACF_defineGunClass("AAM", {
    type            = "missile",
	spread          = 1,
	name            = "Air-To-Air Missile",
	desc            = "Missiles specialized for air-to-air flight.  These missiles have limited range, but are agile and can be radar-guided.",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 1,
	sound           = "acf_extra/airfx/rocket_fire2.wav",
	soundDistance   = " ",
	soundNormal     = " ",
    
    ammoBlacklist   = {"AP", "APHE", "FL"} -- Including FL would mean changing the way round classes work.
} )



-- BALANCE RATIONALE (open to discussion during development):
-- AAMs should be feasible in air-to-air combat but less feasible from the ground.
-- They will usually be launched from fast-moving aircraft.  Typical dogfighting distances are smaller than typical SAM engagement distances.
-- AAMs will have less time to adjust course before meeting their target due to decresed engagement range, and may be launched off-course due to flight.

-- With this in mind:
--      AAMs should be more powerful than SAMs of equivalent caliber.
--      AAMs should have weaker motors than SAMs of equivalent caliber.
--      AAMs should have less propellant than SAMs of equivalent caliber.
--      AAMs should be more manouverable than SAMs of equivalent caliber.
--      AAMs should be more agile than SAMs of equivalent caliber.
--      AAMs should have larger viewcones than SAMs of equivalent caliber.




-- Not based on any real missile - this is for smaller aircraft.
-- Balance the round in line with the 40mm pod rocket.
ACF_defineGun("40mmAAM", { --id
	name = "40mm Air-to-air Missile",
	desc = "Someone glued a radar dish to a firework.  It's puny, short-range and goes pop instead of boom. It's also fast and agile, like the tiny aircraft you'll be putting this on.",
	model = "models/missiles/70mmffar.mdl",
	gunclass = "AAM",
    rack = "4xRK",  -- Which rack to spawn this missile on?
	length = 45,
	caliber = 4.0,
	weight = 35,    -- Don't scale down the weight though!
	year = 1953,
	round = {
		model		= "models/missiles/70mmffar.mdl",
		rackmdl		= "models/missiles/70mmffar.mdl",
		maxlength	= 32,
		casing		= 0.2,	        -- thickness of missile casing, cm
		propweight	= 1,	        -- motor mass - motor casing
		thrust		= 8000,	    -- average thrust - kg*in/s^2
		burnrate	= 450,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.15,          -- percentage of the propellant consumed in the starter motor.
		minspeed	= 8000,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.002,		-- drag coefficient of the missile
		finmul		= 0.003			-- fin multiplier (mostly used for unpropelled guidance)
	},
   
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = ACF_GetAllGuidanceNames(),
    fuses       = ACF_GetAllFuseNames(),
    
    seekcone    = 40,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 60,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1     -- multiplier for missile turn-rate.
} )




-- The sidewinder analogue. we have to scale it down because acf is scaled down.
-- Balance the round in line with the 70mm pod rocket.
ACF_defineGun("70mmAAM", { --id
	name = "70mm Air-to-air Missile",
	desc = "The gold standard in airborne jousting sticks: decent agility, decent boom.  Lock on and rock on.",
	model = "models/missiles/aim9.mdl",
	gunclass = "AAM",
    rack = "2xRK",  -- Which rack to spawn this missile on?
	length = 85,	-- Total length of the missile
	caliber = 7.0,	-- Diameter of the missile
	weight = 85,    -- Don't scale down the weight though!
	year = 1953,
	round = {
		model		= "models/missiles/aim9.mdl",
		rackmdl		= "models/missiles/aim9.mdl",
		maxlength	= 26*1.75,
		casing		= 0.2,	        -- thickness of missile casing, cm
		propweight	= 1.75,	        -- motor mass - motor casing
		thrust		= 12000,	    -- average thrust - kg*in/s^2
		burnrate	= 630,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.2,          -- percentage of the propellant consumed in the starter motor.
		minspeed	= 10000,		-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.0025,		-- drag coefficient of the missile
		finmul		= 0.005			-- fin multiplier (mostly used for unpropelled guidance)
	},
    
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = ACF_GetAllGuidanceNames(),
    fuses       = ACF_GetAllFuseNames(),
    
    seekcone    = 35,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 55,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 0.9     -- multiplier for missile turn-rate.
} )




-- The phoenix analogue. we have to scale it down because acf is scaled down.  It's also short-range due to AAM guidelines.
-- Balance the round in line with the 70mm pod rocket.
ACF_defineGun("120mmAAM", { --id
	name = "120mm Air-to-air Missile",
	desc = "The big guy of the skies - you're not getting any closer to a nuclear dogfight than this.",
	model = "models/missiles/aim120.mdl",
	gunclass = "AAM",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 150,
	caliber = 12.0,
	weight = 200,
	year = 1974,
    modeldiameter = 7.1 * 2.54, -- in cm
	round = {
		model		= "models/missiles/aim120.mdl",
		rackmdl		= "models/missiles/aim120.mdl",
		maxlength	= 32*1.75,
		casing		= 0.4,	        -- thickness of missile casing, cm
		propweight	= 3.5,	        -- motor mass - motor casing
		thrust		= 15000,	    -- average thrust - kg*in/s^2
		burnrate	= 450,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.15,          -- percentage of the propellant consumed in the starter motor.
		minspeed	= 10000,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.004,		-- drag coefficient of the missile
		finmul		= 0.005			-- fin multiplier (mostly used for unpropelled guidance)
	},
    
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = ACF_GetAllGuidanceNames(),
    fuses       = ACF_GetAllFuseNames(),
    
    seekcone    = 30,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 45,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 0.75     -- multiplier for missile turn-rate.
} )