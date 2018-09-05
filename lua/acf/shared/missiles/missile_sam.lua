--define the class
ACF_defineGunClass("SAM", {
    type            = "missile",  -- i know i know
	spread          = 1,
	name            = "Surface-To-Air Missile",
	desc            = "Missiles specialized for surface-to-air operation, and well suited to lower altitude operation against ground attack aircraft.",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 1,
	sound           = "acf_extra/airfx/rocket_fire2.wav",
	soundDistance   = " ",
	soundNormal     = " ",
    effect          = "Rocket Motor",

    reloadmul       = 8,

    ammoBlacklist   = {"AP", "APHE", "FL", "HEAT"} -- Including FL would mean changing the way round classes work.
} )

-- The FIM-92, a lightweight, medium-speed short-range anti-air missile.
ACF_defineGun("FIM-92 SAM", { --id
	name = "FIM-92 Missile",
	desc = "The FIM-92 Stinger is a lightweight and versatile close-range air defense missile.\nWith a seek cone of 15 degrees and a sharply limited range that makes it useless versus high-flying targets, it is best to aim before firing and choose shots carefully.",
	model = "models/missiles/fim_92.mdl",
	gunclass = "SAM",
    rack = "1x FIM-92",  -- Which rack to spawn this missile on?
	length = 66,
	caliber = 5.9,
	weight = 20,--15.1,    -- Don't scale down the weight though!
    modeldiameter = 6.6, -- in cm
	year = 1978,
	rofmod = 1.2,

	round = {
		model		= "models/missiles/fim_92.mdl",
		rackmdl		= "models/missiles/fim_92_folded.mdl",
		maxlength	= 100,
		casing		= 0.1,	        -- thickness of missile casing, cm
		armour		= 3,			-- effective armour thickness of casing, in mm
		propweight	= 1.5,	        -- motor mass - motor casing
		thrust		= 7000,	    -- average thrust - kg*in/s^2			--was 120000
		burnrate	= 1000,	        -- cm^3/s at average chamber pressure	
		starterpct	= 0.3,         	-- percentage of the propellant consumed in the starter motor.	--was 0.2
		minspeed	= 3000,		-- minimum speed beyond which the fins work at 100% efficiency	--was 15000
		dragcoef	= 0.001,		-- drag coefficient while falling
                dragcoefflight  = 0.0001,                 -- drag coefficient during flight
		finmul		= 0.02		-- fin multiplier (mostly used for unpropelled guidance)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Radar","Antimissile"},
    fuses       = {"Contact", "Radio"},

	racks       = {["1x FIM-92"] = true,  ["2x FIM-92"] = true,  ["4x FIM-92"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    seekcone    = 7.5,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)	--was 35
    viewcone    = 30,   -- getting outside this cone will break the lock.  Divided by 2.	--was 55

    agility     = 3.0,     -- multiplier for missile turn-rate.		--was 1
    armdelay    = 0.2     -- minimum fuse arming delay		-was 0.3
} )

-- The 9M31 Strela-1, a bulky, slow medium-range anti-air missile.
ACF_defineGun("Strela-1 SAM", { --id
	name = "9M31 Strela-1",
	desc = "The 9M31 Strela-1 is a medium-range homing SAM with a much bigger payload than the FIM-92. Bulk, it is best suited to ground vehicles or stationary units.\nWith its 20 degree seek cone, the strela is fast-reacting, while its missiles are surprisingly deadly and able to defend an acceptable area.",
	model = "models/missiles/9m31.mdl",
	gunclass = "SAM",
    rack = "1x Strela-1",  -- Which rack to spawn this missile on?
	length = 60,
	caliber = 8.0,
	weight = 150,--15.1,    -- Don't scale down the weight though!
    modeldiameter = 12, -- in cm
	year = 1960,

	round = {
		model		= "models/missiles/9m31.mdl",
		rackmdl		= "models/missiles/9m31f.mdl",
		maxlength	= 105,
		casing		= 0.05,	        -- thickness of missile casing, cm
		armour		= 5,			-- effective armour thickness of casing, in mm
		propweight	= 1,	        -- motor mass - motor casing
		thrust		= 4000,	    -- average thrust - kg*in/s^2		
		burnrate	= 400,	        -- cm^3/s at average chamber pressure	
		starterpct	= 0.1,         	-- percentage of the propellant consumed in the starter motor.
		minspeed	= 4000,		-- minimum speed beyond which the fins work at 100% efficiency	
		dragcoef	= 0.003,		-- drag coefficient while falling	
                dragcoefflight  = 0,                 -- drag coefficient during flight
		finmul		= 0.03				-- fin multiplier (mostly used for unpropelled guidance)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Radar","Antimissile"},
    fuses       = {"Contact", "Radio"},

	racks       = {["1x Strela-1"] = true,  ["2x Strela-1"] = true,  ["4x Strela-1"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    seekcone    = 20,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.) 
    viewcone    = 40,   -- getting outside this cone will break the lock.  Divided by 2.	

    agility     = 2,     -- multiplier for missile turn-rate.	
    armdelay    = 0.2     -- minimum fuse arming delay	
} )

-- The SIMBAD-RC is a 2-tube point-defense missile system taht's basicaly like 2 stingers shooting missiles 
--[[
ACF_defineGun("SIMBAD-RC SAM", { --id
	name = "SIMBAD Missile",
	desc = "A point defense antimissile system, built from an antiaircraft missile launcher.  It can only intercept missiles, but is VERY fast.",
	model = "models/missiles/fim_92_folded.mdl",
	gunclass = "SAM",
    rack = "2x FIM-92",  -- Which rack to spawn this missile on?
	length = 40,
	caliber = 5.9,
	weight = 200,--15.1,    -- Don't scale down the weight though!
    modeldiameter = 6.6, -- in cm
	year = 2010,

	round = {
		model		= "models/missiles/fim_92_folded.mdl",
		rackmdl		= "models/missiles/fim_92_folded.mdl",
		maxlength	= 150,
		casing		= 0.01,	        -- thickness of missile casing, cm
		armour		= 3,			-- effective armour thickness of casing, in mm
		propweight	= 1.5,	        -- motor mass - motor casing
		thrust		= 20000,	    -- average thrust - kg*in/s^2			--was 120000
		burnrate	= 500,	        -- cm^3/s at average chamber pressure	
		starterpct	= 0.25,         	-- percentage of the propellant consumed in the starter motor.	--was 0.2
		minspeed	= 2500,		-- minimum speed beyond which the fins work at 100% efficiency	--was 15000
		dragcoef	= 0.01,		-- drag coefficient while falling
                dragcoefflight  = 0,                 -- drag coefficient during flight
		finmul		= 0.02			-- fin multiplier (mostly used for unpropelled guidance)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Antimissile"},
    fuses       = {"Contact"},

	racks       = {["2x FIM-92"] = true,  ["4x FIM-92"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    seekcone    = 5,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)	--was 35
    viewcone    = 90,   -- getting outside this cone will break the lock.  Divided by 2.	--was 55

    agility     = 5,     -- multiplier for missile turn-rate.		--was 1
    armdelay    = 0.1     -- minimum fuse arming delay		-was 0.3
} )
]]--
