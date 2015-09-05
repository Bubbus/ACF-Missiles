
--define the class
ACF_defineGunClass("BOMB", {
    type            = "missile",  -- i know i know
	spread          = 1,
	name            = "Bomb",
	desc            = "Free-falling bombs.  These are slower than missiles, but are more powerful and more manouverable when guided.",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 0.1,
	sound           = "acf_extra/tankfx/clunk.wav",
	soundDistance   = " ",
	soundNormal     = " ",
    
    reloadmul       = 8,
    
    ammoBlacklist   = {"AP", "FL", "HEAT"} -- Including FL would mean changing the way round classes work.
} )




-- Balance the round in line with the 40mm pod rocket.
ACF_defineGun("50kgBOMB", { --id
	name = "50kg Free Falling Bomb",
	desc = "Old WW2 100lb bomb - it's more like a sock with explosive material inside.",
	model = "models/bombs/fab50.mdl",
	gunclass = "BOMB",
    rack = "3xRK",  -- Which rack to spawn this missile on?
	length = 5,
	caliber = 5.0,
	weight = 50,    -- Don't scale down the weight though!
	year = 1936,
    modeldiameter = 2.4 * 2.7, -- in cm
	round = {
		model		= "models/bombs/fab50.mdl",
		rackmdl		= "models/bombs/fab50.mdl",
		maxlength	= 50,
		casing		= 0.5,	        -- thickness of missile casing, cm
		armour		= 12,			-- effective armour thickness of casing, in mm
		propweight	= 0,	        -- motor mass - motor casing
		thrust		= 1,	    	-- average thrust - kg*in/s^2
		burnrate	= 1,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.01,         -- percentage of the propellant consumed in the starter motor.
		minspeed	= 1,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.002,		-- drag coefficient of the missile
		finmul		= 0.03,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(0.6),  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},
   
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),
    
	racks       = {["1xRK_small"] = true,  ["2xRK"] = true,  ["3xRK"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
  
	
    seekcone    = 40,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 60,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1,     -- multiplier for missile turn-rate.
    armdelay    = 1     -- minimum fuse arming delay
} )


-- Balance the round in line with the 40mm pod rocket.
ACF_defineGun("100kgBOMB", { --id
	name = "100kg Free Falling Bomb",
	desc = "Old WW2 250lb bomb used by Soviet bombers to destroy enemies of the Motherland.",
	model = "models/bombs/fab100.mdl",
	gunclass = "BOMB",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 50,
	caliber = 10.0,
	weight = 100,    -- Don't scale down the weight though!
	year = 1939,
    modeldiameter = 21.2 * 1.4, -- in cm
	round = {
		model		= "models/bombs/fab100.mdl",
		rackmdl		= "models/bombs/fab100.mdl",
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
    guidance    = {"Dumb"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),
    
	racks       = {["1xRK_small"] = true,  ["2xRK"] = true,  ["3xRK"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
 
    seekcone    = 40,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 60,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1,     -- multiplier for missile turn-rate.
    armdelay    = 1     -- minimum fuse arming delay
} )

ACF_defineGun("250kgBOMB", { --id
	name = "250kg Free Falling Bomb",
	desc = "Heavy WW2 500lb bomb widely used as a tank buster.",
	model = "models/bombs/fab250.mdl",
	gunclass = "BOMB",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 5000,
	caliber = 12.5,
	weight = 250,    -- Don't scale down the weight though!
	year = 1941,
    modeldiameter = 16.3 * 1.9, -- in cm
	round = {
		model		= "models/bombs/fab250.mdl",
		rackmdl		= "models/bombs/fab250.mdl",
		maxlength	= 125,
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
    guidance    = {"Dumb"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),
 
	racks       = {["1xRK"] = true,  ["2xRK"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

 
    seekcone    = 40,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 60,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1,     -- multiplier for missile turn-rate.
    armdelay    = 1     -- minimum fuse arming delay
} )

ACF_defineGun("500kgBOMB", { --id
	name = "500kg Free Falling Bomb",
	desc = "1000lb bomb, found in the late heavy bombers of WW2.",
	model = "models/bombs/fab500.mdl",
	gunclass = "BOMB",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 15000,
	caliber = 30.0,
	weight = 500,    -- Don't scale down the weight though!
	year = 1943,
    modeldiameter = 16.3 * 1.9, -- in cm
	round = {
		model		= "models/bombs/fab500.mdl",
		rackmdl		= "models/bombs/fab500.mdl",
		maxlength	= 250,
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
    guidance    = {"Dumb"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),
 
	racks       = {["1xRK"] = true,  ["2xRK"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
 
    seekcone    = 40,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 60,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1,     -- multiplier for missile turn-rate.
    armdelay    = 1     -- minimum fuse arming delay
} )

ACF_defineGun("1000kgBOMB", { --id
	name = "1000kg Free Falling Bomb",
	desc = "2000lb bomb, biggest projectile in acf - keep it for some slow big target.",
	model = "models/bombs/an_m66.mdl",
	gunclass = "BOMB",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 30000,
	caliber = 30.0,
	weight = 1000,    -- Don't scale down the weight though! 
	year = 1945,
    modeldiameter = 16.3 * 4.5, -- in cm
	round = {
		model		= "models/bombs/an_m66.mdl",
		rackmdl		= "models/bombs/an_m66.mdl",
		maxlength	= 500,
		casing		= 2.0,	        -- thickness of missile casing, cm
		armour		= 40,			-- effective armour thickness of casing, in mm
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
    guidance    = {"Dumb"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),
 
	racks       = {["1xRK"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
 
    seekcone    = 40,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 60,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1,     -- multiplier for missile turn-rate.
    armdelay    = 1     -- minimum fuse arming delay
} )


