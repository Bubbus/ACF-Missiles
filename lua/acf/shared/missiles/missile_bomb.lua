
--define the class
ACF_defineGunClass("BOMB", {
    type            = "missile",  -- i know i know
	spread          = 1,
	name            = "Bomb",
	desc            = "Free-falling bombs.  These are slower than missiles, but are more powerful and more manouverable when guided.",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 1,
	sound           = "acf_extra/tankfx/clunk.wav",
	soundDistance   = " ",
	soundNormal     = " ",
    
    reloadmul       = 8,
    
    ammoBlacklist   = {"AP", "APHE", "FL"} -- Including FL would mean changing the way round classes work.
} )



-- The original XCF bombs are copy-pasted below, but need to be put into the format seen in missile_aam.lua



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
		maxlength	= 60,
		casing		= 0.5,	        -- thickness of missile casing, cm
		propweight	= 0,	        -- motor mass - motor casing
		thrust		= 1,	    -- average thrust - kg*in/s^2
		burnrate	= 1,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.01,          -- percentage of the propellant consumed in the starter motor.
		minspeed	= 1,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.002,		-- drag coefficient of the missile
		finmul		= 0.003			-- fin multiplier (mostly used for unpropelled guidance)
	},
   
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),
    
	racks       = {["1xRK"] = true,  ["2xRK"] = true,  ["3xRK"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
  
	
    seekcone    = 40,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 60,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1     -- multiplier for missile turn-rate.
} )


-- Balance the round in line with the 40mm pod rocket.
ACF_defineGun("100kgBOMB", { --id
	name = "100kg Free Falling Bomb",
	desc = "Old WW2 250lb bomb used by Soviet bombers to destroy enemies of the Motherland.",
	model = "models/bombs/fab100.mdl",
	gunclass = "BOMB",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 10,
	caliber = 10.0,
	weight = 100,    -- Don't scale down the weight though!
	year = 1939,
    modeldiameter = 21.2 * 1.4, -- in cm
	round = {
		model		= "models/bombs/fab100.mdl",
		rackmdl		= "models/bombs/fab100.mdl",
		maxlength	= 70,
		casing		= 0.5,	        -- thickness of missile casing, cm
		propweight	= 0,	        -- motor mass - motor casing
		thrust		= 1,	    -- average thrust - kg*in/s^2
		burnrate	= 1,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.005,          -- percentage of the propellant consumed in the starter motor.
		minspeed	= 1,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.002,		-- drag coefficient of the missile
		finmul		= 0.003			-- fin multiplier (mostly used for unpropelled guidance)
	},
   
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),
    
	racks       = {["1xRK"] = true,  ["2xRK"] = true,  ["3xRK"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
 
    seekcone    = 40,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 60,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1     -- multiplier for missile turn-rate.
} )

ACF_defineGun("250kgBOMB", { --id
	name = "250kg Free Falling Bomb",
	desc = "Heavy WW2 500lb bomb widely used as a tank buster.",
	model = "models/bombs/fab250.mdl",
	gunclass = "BOMB",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 25,
	caliber = 25.0,
	weight = 250,    -- Don't scale down the weight though!
	year = 1941,
    modeldiameter = 16.3 * 1.9, -- in cm
	round = {
		model		= "models/bombs/fab250.mdl",
		rackmdl		= "models/bombs/fab250.mdl",
		maxlength	= 110,
		casing		= 0.5,	        -- thickness of missile casing, cm
		propweight	= 0,	        -- motor mass - motor casing
		thrust		= 1,	    -- average thrust - kg*in/s^2
		burnrate	= 1,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.005,          -- percentage of the propellant consumed in the starter motor.
		minspeed	= 1,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.002,		-- drag coefficient of the missile
		finmul		= 0.002			-- fin multiplier (mostly used for unpropelled guidance)
	},
   
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),
 
	racks       = {["1xRK"] = true,  ["2xRK"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

 
    seekcone    = 40,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 60,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1     -- multiplier for missile turn-rate.
} )

ACF_defineGun("500kgBOMB", { --id
	name = "500kg Free Falling Bomb",
	desc = "1000lb bomb, found in the late heavy bombers of WW2.",
	model = "models/bombs/fab500.mdl",
	gunclass = "BOMB",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 50,
	caliber = 50.0,
	weight = 500,    -- Don't scale down the weight though!
	year = 1943,
    modeldiameter = 16.3 * 1.9, -- in cm
	round = {
		model		= "models/bombs/fab500.mdl",
		rackmdl		= "models/bombs/fab500.mdl",
		maxlength	= 175,
		casing		= 0.5,	        -- thickness of missile casing, cm
		propweight	= 0,	        -- motor mass - motor casing
		thrust		= 1,	    -- average thrust - kg*in/s^2
		burnrate	= 1,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.005,          -- percentage of the propellant consumed in the starter motor.
		minspeed	= 1,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.002,		-- drag coefficient of the missile
		finmul		= 0.002			-- fin multiplier (mostly used for unpropelled guidance)
	},
   
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),
 
	racks       = {["1xRK"] = true,  ["2xRK"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
 
    seekcone    = 40,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 60,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1     -- multiplier for missile turn-rate.
} )


/*
-- old missile_bomb file

--define the class
ACF_defineGunClass("BOMB", {
    type            = "missile",  -- i know i know
	spread          = 1,
	name            = "Bomb",
	desc            = "Free-falling bombs.  These are slower than missiles, but are more powerful and more manouverable when guided.",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 1,
	sound           = "acf_extra/airfx/rocket_fire2.wav",
	soundDistance   = " ",
	soundNormal     = " ",
    
    ammoBlacklist   = {"AP", "APHE", "FL"} -- Including FL would mean changing the way round classes work.
} )



-- The original XCF bombs are copy-pasted below, but need to be put into the format seen in missile_aam.lua

/*
ACF_defineGun("30cmB1", { --id
	name		= "30cm Bomb",
	ent			= "acf_rack",
	desc		= "An unguided large-capacity bomb, designed to inspire a fear of gravity into ceilings everywhere - from buildings to battleships.  HEAT warheads were outlawed after the first bomb test was found to have penetrated the target vehicle, the earth's surface, several circles of hell and Satan's morning coffee." .. bombdesc,
	model		= "models/missiles/rack_single.mdl",
	gunclass	= "R1",
	caliber		= 30,
	weight		= R1_MASS,
	magsize		= 1,
	year		= 1940, 
	roundclass	= "Bomb",
	rofmod		= 0.5,
	sound		= "phx/epicmetal_hard.wav",
	round		= 
	{
		id			= "30cmB1",
		model		= "models/missiles/gbu12.mdl",
		maxlength	= 45,
		--maxweight	= 500,
		propweight	= 0
	},
	blacklist	= nofunallowed,
	muzzleflash	= ""
} )




ACF_defineGun("20cmB1", { --id
	name		= "20cm Bomb",
	ent			= "acf_rack",
	desc		= "An unguided medium-capacity bomb.  Effective against everything which has wheels, and some things which don't.  Use these in a dogfight for instant man-points." .. bombdesc,
	model		= "models/missiles/rack_single.mdl",
	gunclass	= "R1",
	caliber		= 20,
	weight		= R1_MASS,
	magsize		= 1,
	year		= 1940,
	roundclass	= "Bomb",
	rofmod		= 0.5,
	sound		= "phx/epicmetal_hard.wav",
	round		= 
	{
		id			= "20cmB2",
		model		= "models/missiles/fab250.mdl",
		maxlength	= 35,
		--maxweight	= 250,
		propweight	= 0
	},
	blacklist	= nofunallowed,
	muzzleflash	= ""
} )




ACF_defineGun("12cmB1", { --id
	name		= "12cm Bomb",
	ent			= "acf_rack",
	desc		= "An unguided small-capacity bomb.  Which is large-capacity by usual standards.  Attach to plane, bring pain." .. bombdesc,
	model		= "models/missiles/rack_single.mdl",
	gunclass	= "R1",
	caliber		= 12,
	weight		= R1_MASS,
	magsize		= 1,
	year		= 1940,
	roundclass	= "Bomb",
	rofmod		= 0.5,
	sound		= "phx/epicmetal_hard.wav",
	round		= 
	{
		id			= "12cmB4",
		model		= "models/missiles/micro.mdl",
		maxlength	= 24,
		--maxweight	= 100,
		propweight	= 0
	},
	blacklist	= nonsmoke,
	muzzleflash	= ""
} )




ACF_defineGun("8cmB1", { --id
	name		= "8cm Bomb",
	ent			= "acf_rack",
	desc		= "A tiny, unguided bomb.  Use on fighter planes to deliver regards on an individual basis, or in carpet-bombers to write dirty words upon enemy nations." .. bombdesc,
	model		= "models/missiles/rack_double.mdl",
	gunclass	= "R1",
	caliber		= 1,
	weight		= R1_MASS,
	magsize		= 1,
	year		= 1940,
	roundclass	= "Bomb",
	rofmod		= 0.5,
	sound		= "phx/epicmetal_hard.wav",
	round		= 
	{
		id			= "8cmB4",
		model		= "models/missiles/micro.mdl",
		maxlength	= 16,
		--maxweight	= 50,
		propweight	= 0
	},
	muzzleflash	= ""
} )
//*/
