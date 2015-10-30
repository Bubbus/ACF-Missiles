
--define the class
ACF_defineGunClass("SAM", {
    type            = "missile",  -- i know i know
	spread          = 1,
	name            = "Surface-To-Air Missile",
	desc            = "Missiles specialized for surface-to-air operation.  These missiles have limited power but are very fast.",
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
	desc = "The FIM-92 Stinger is a portable, short-range, infrared homing surface-to-air missile (SAM). Fast and agile, but best used at short ranges. Due to its low weight, it can also be mounted on both ground vehicles and helicopters.",
	model = "models/missiles/fim_92.mdl",
	gunclass = "SAM",
    rack = "1x FIM-92",  -- Which rack to spawn this missile on?
	length = 66,
	caliber = 5.9,
	weight = 80,--15.1,    -- Don't scale down the weight though!
    modeldiameter = 6.6, -- in cm
	year = 1978,

	round = {
		model		= "models/missiles/fim_92.mdl",
		rackmdl		= "models/missiles/fim_92_folded.mdl",
		maxlength	= 45,
		casing		= 0.2,	        -- thickness of missile casing, cm
		armour		= 5,			-- effective armour thickness of casing, in mm
		propweight	= 1,	        -- motor mass - motor casing
		thrust		= 120000,	    -- average thrust - kg*in/s^2
		burnrate	= 300,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.2,         	-- percentage of the propellant consumed in the starter motor.
		minspeed	= 15000,		-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.008,		-- drag coefficient while falling
                dragcoefflight  = 0.08,                 -- drag coefficient during flight
		finmul		= 0.004			-- fin multiplier (mostly used for unpropelled guidance)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Radar"},
    fuses       = ACF_GetAllFuseNames(),

	racks       = {["1x FIM-92"] = true,  ["2x FIM-92"] = true,  ["4x FIM-92"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    seekcone    = 35,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 55,   -- getting outside this cone will break the lock.  Divided by 2.

    agility     = 2,     -- multiplier for missile turn-rate.
    armdelay    = 0.3     -- minimum fuse arming delay
} )

-- The 9M31 Strela-1, a bulky, slow medium-range anti-air missile.
ACF_defineGun("Strela-1 SAM", { --id
	name = "9M31 Strela-1",
	desc = "The 9M31 Strela-1 is a medium-range, infrared homing surface-to-air missile (SAM). Slower than the FIM-92, but delivers a bigger payload. Because of its bulky launch platform, it is best launched from ground vehicles or stationary units.",
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
		maxlength	= 42,
		casing		= 0.2,	        -- thickness of missile casing, cm
		armour		= 8,			-- effective armour thickness of casing, in mm
		propweight	= 1.4,	        -- motor mass - motor casing
		thrust		= 60000,	    -- average thrust - kg*in/s^2
		burnrate	= 330,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.2,         	-- percentage of the propellant consumed in the starter motor.
		minspeed	= 12000,		-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.006,		-- drag coefficient while falling
                dragcoefflight  = 0.06,                 -- drag coefficient during flight
		finmul		= 0.006			-- fin multiplier (mostly used for unpropelled guidance)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Radar"},
    fuses       = ACF_GetAllFuseNames(),

	racks       = {["1x Strela-1"] = true,  ["2x Strela-1"] = true,  ["4x Strela-1"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    seekcone    = 30,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 50,   -- getting outside this cone will break the lock.  Divided by 2.

    agility     = 1.5,     -- multiplier for missile turn-rate.
    armdelay    = 0.5     -- minimum fuse arming delay
} )
