--define the class
ACF_defineGunClass("GBU", {
    type            = "missile",  -- i know i know
	spread          = 1,
	name            = "Guided Bomb Unit",
	desc            = "Guided Bomb Unit.  Same as general purpose bombs but you can control them.",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 0.1,
	sound           = "acf_extra/tankfx/clunk.wav",
	soundDistance   = " ",
	soundNormal     = " ",
	nothrust		= true,
    
    reloadmul       = 2,
    
    ammoBlacklist   = {"AP", "FL", "HEAT"} -- Including FL would mean changing the way round classes work.
} )



-- Balance the round in line with the 40mm pod rocket.
ACF_defineGun("116kgGBU", { --id
	name = "116kg Guided Weapon Mk 1 Walleye",
	desc = "The first of a family of precision-guided munitions. This “smart bomb” had no propulsion system, but it could be maneuvered via a television assisted guidance system during its glide from an aircraft to the target.",
	model = "models/bombs/gbu/agm62.mdl",
	gunclass = "GBU",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 50,
	caliber = 10.0,
	weight = 100,    -- Don't scale down the weight though!
	year = 1939,
    modeldiameter = 21.2 * 1.4, -- in cm
	round = {
		model		= "models/bombs/gbu/agm62.mdl",
		rackmdl		= "models/bombs/gbu/agm62.mdl",
		maxlength	= 75,
		casing		= 0.7,	        -- thickness of missile casing, cm
		armour		= 16,			-- effective armour thickness of casing, in mm
		propweight	= 0,	        -- motor mass - motor casing
		thrust		= 1,	    	-- average thrust - kg*in/s^2
		burnrate	= 1,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.005,        -- percentage of the propellant consumed in the starter motor.
		minspeed	= 1,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.002,		-- drag coefficient of the missile
		finmul		= 0.03,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(0.5)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},
   
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Laser"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),
    
	racks       = {["1xRK_small"] = true,  ["2xRK"] = true,  ["3xRK"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
 
    seekcone    = 40,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 60,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1,     -- multiplier for missile turn-rate.
    armdelay    = 1     -- minimum fuse arming delay
} )

ACF_defineGun("227kgGBU", { --id
	name = "227kg GBU-12 Paveway II",
	desc = "Based on the Mk 82 500-pound general-purpose bomb, but with the addition of a nose-mounted laser seeker and fins for guidance. ",
	model = "models/bombs/gbu/gbu12.mdl",
	gunclass = "GBU",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 5000,
	caliber = 12.5,
	weight = 250,    -- Don't scale down the weight though!
	year = 1976,
    modeldiameter = 16.3 * 1.9, -- in cm
	round = {
		model		= "models/bombs/gbu/gbu12.mdl",
		rackmdl		= "models/bombs/gbu/gbu12.mdl",
		maxlength	= 100,
		casing		= 1.5,	        -- thickness of missile casing, cm
		armour		= 20,			-- effective armour thickness of casing, in mm
		propweight	= 0,	        -- motor mass - motor casing
		thrust		= 1,	    	-- average thrust - kg*in/s^2
		burnrate	= 1,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.005,        -- percentage of the propellant consumed in the starter motor.
		minspeed	= 1,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.002,		-- drag coefficient of the missile
		finmul		= 0.02,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(0.4)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},
   
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Laser"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),
 
	racks       = {["1xRK"] = true,  ["2xRK"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

 
    seekcone    = 40,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 60,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1,     -- multiplier for missile turn-rate.
    armdelay    = 1     -- minimum fuse arming delay
} )

ACF_defineGun("454kgGBU", { --id
	name = "454kg GBU-16 Paveway II",
	desc = "Based on the Mk 83 general-purpose bomb, but with laser seeker and wings for guidance.",
	model = "models/bombs/gbu/gbu16.mdl",
	gunclass = "GBU",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 15000,
	caliber = 30.0,
	weight = 500,    -- Don't scale down the weight though!
	year = 1976,
    modeldiameter = 16.3 * 1.9, -- in cm
	round = {
		model		= "models/bombs/gbu/gbu16.mdl",
		rackmdl		= "models/bombs/gbu/gbu16.mdl",
		maxlength	= 200,
		casing		= 2.0,	        -- thickness of missile casing, cm
		armour		= 24,			-- effective armour thickness of casing, in mm
		propweight	= 0,	        -- motor mass - motor casing
		thrust		= 1,	    	-- average thrust - kg*in/s^2
		burnrate	= 1,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.005,        -- percentage of the propellant consumed in the starter motor.
		minspeed	= 1,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.002,		-- drag coefficient of the missile
		finmul		= 0.02,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(0.3)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},
   
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Laser"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),
 
	racks       = {["1xRK"] = true,  ["2xRK"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
 
    seekcone    = 40,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 60,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1,     -- multiplier for missile turn-rate.
    armdelay    = 1     -- minimum fuse arming delay
} )

ACF_defineGun("909kgGBU", { --id
	name = "909kg GBU-10 Paveway II",
	desc = "Based on the Mk 84 general-purpose bomb, but with laser seeker and wings for guidance.",
	model = "models/bombs/gbu/gbu10.mdl",
	gunclass = "GBU",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 30000,
	caliber = 30.0,
	weight = 1000,    -- Don't scale down the weight though! 
	year = 1976,
    modeldiameter = 16.3 * 4.5, -- in cm
	round = {
		model		= "models/bombs/gbu/gbu10_fold.mdl",
		rackmdl		= "models/bombs/gbu/gbu10.mdl",
		maxlength	= 400,
		casing		= 2.0,	        -- thickness of missile casing, cm
		armour		= 20,			-- effective armour thickness of casing, in mm
		propweight	= 0,	        -- motor mass - motor casing
		thrust		= 1,	    	-- average thrust - kg*in/s^2
		burnrate	= 1,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.005,        -- percentage of the propellant consumed in the starter motor.
		minspeed	= 1,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.002,		-- drag coefficient of the missile
		finmul		= 0.01,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(0.2)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},
   
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Laser"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),
 
	racks       = {["1xRK"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
 
    seekcone    = 40,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 60,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1,     -- multiplier for missile turn-rate.
    armdelay    = 1     -- minimum fuse arming delay
} )


