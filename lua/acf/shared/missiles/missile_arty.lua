	
--define the class
ACF_defineGunClass("ARTY", {
    type            = "missile",
	spread          = 1,
	name            = "Artillery Rockets",
	desc            = "Artillery rockets provide massive HE delivery over a broad area, with arcing ballistic trajectories and limited guidance. Best equipped with a seeker head, fired up at an angle, then guided toward a stationary target.",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 1,
	sound           = "acf_extra/airfx/rocket_fire2.wav",
	soundDistance   = " ",
	soundNormal     = " ",
    effect          = "Rocket Motor",

    ammoBlacklist   = {"AP", "APHE", "FL", "SM"} -- Including FL would mean changing the way round classes work.
} )


ACF_defineGun("Type 63 RA", { --id

	name		= "Type 63 Rocket",
	desc		= "A common artillery rocket in the third world, able to be launched from a variety of platforms with a painful whallop and a very arced trajectory.\nContrary to appearances and assumptions, does not in fact werf nebel.",
	model		= "models/missiles/glatgm/mgm51.mdl",
	caliber		= 10.7,
	gunclass	= "ARTY",
    rack        = "1xRK_small",  -- Which rack to spawn this missile on?
    weight		= 80,
    length	    = 80,
	year		= 1960,
	rofmod		= 0.6,
	roundclass	= "Rocket",
	round		=
	{
		model		= "models/missiles/glatgm/mgm51.mdl",
		rackmdl		= "models/missiles/glatgm/mgm51.mdl",
		maxlength	= 50,
		casing		= 0.1,			-- thickness of missile casing, cm
		armour		= 8,			-- effective armour thickness of casing, in mm
		propweight	= 0.7,			-- motor mass - motor casing
		thrust		= 2400,		-- average thrust - kg*in/s^2
		burnrate	= 400,			-- cm^3/s at average chamber pressure
		starterpct	= 0.1,
        minspeed	= 200,			-- minimum speed beyond which the fins work at 100% efficiency
        dragcoef	= 0.002,		-- drag coefficient while falling
        dragcoefflight  = 0.001,                 -- drag coefficient during flight
		finmul		= 0.02,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(2)  	--  139 HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Laser"},
    fuses       = {"Contact", "Timed", "Optical", "Cluster"},

	racks       = {["1xRK_small"] = true, ["1xRK"] = true, ["2xRK"] = true, ["3xRK"] = true, ["4xRK"] = true, ["6xUARRK"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
	viewcone	= 180, -- cone radius, 180 = full 360 tracking
	agility		= 0.08,


    armdelay    = 2     -- minimum fuse arming delay
} )



ACF_defineGun("SAKR-10 RA", { --id

	name		= "SAKR-10 Rocket",
	desc		= "A short-range but formidable artillery rocket, based upon the Grad.  Well suited to the backs of trucks.",
	model		= "models/missiles/9m31.mdl",
	caliber		= 12.2,
	gunclass	= "ARTY",
    rack        = "1xRK",  -- Which rack to spawn this missile on?
    weight		= 160,
    length	    = 320, --320
	year		= 1980,
	rofmod		= 0.75,
	roundclass	= "Rocket",
	round		=
	{
		model		= "models/missiles/9m31.mdl",
		rackmdl		= "models/missiles/9m31.mdl",
		maxlength	= 140,
		casing		= 0.1,			-- thickness of missile casing, cm
		armour		= 12,			-- effective armour thickness of casing, in mm
		propweight	= 1.2,			-- motor mass - motor casing
		thrust		= 1300,		-- average thrust - kg*in/s^2
		burnrate	= 120,			-- cm^3/s at average chamber pressure
		starterpct	= 0.1,
        minspeed	= 300,			-- minimum speed beyond which the fins work at 100% efficiency
        dragcoef	= 0.002,		-- drag coefficient while falling
        dragcoefflight  = 0.010,                 -- drag coefficient during flight
		finmul		= 0.03,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(1.1)  	--  139 HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Laser"},
    fuses       = {"Contact", "Timed", "Optical", "Cluster"},

	racks       = {["1xRK"] = true, ["2xRK"] = true, ["3xRK"] = true, ["4xRK"] = true, ["6xUARRK"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
	
	agility		= 0.07,
	viewcone	= 180,

    armdelay    = 3     -- minimum fuse arming delay
} )



ACF_defineGun("SS-40 RA", { --id

	name		= "SS-40 Rocket",
	desc		= "A large, heavy, guided artillery rocket for taking out stationary or dug-in targets.  Slow to load, slow to fire, slow to guide, and slow to arrive.",
	model		= "models/missiles/aim120.mdl",
	caliber		= 18.0,
	gunclass	= "ARTY",
    rack        = "1xRK",  -- Which rack to spawn this missile on?
    weight		= 320,
    length	    = 420,
	year		= 1983,
	rofmod		= 1.1,
	roundclass	= "Rocket",
	round		=
	{
		model		= "models/missiles/aim120.mdl",
		rackmdl		= "models/missiles/aim120.mdl",
		maxlength	= 115,
		casing		= 0.1,			-- thickness of missile casing, cm
		armour		= 12,			-- effective armour thickness of casing, in mm
		propweight	= 4.0,			-- motor mass - motor casing
		thrust		= 850,		-- average thrust - kg*in/s^2
		burnrate	= 200,			-- cm^3/s at average chamber pressure
		starterpct	= 0.075,
        minspeed	= 300,			-- minimum speed beyond which the fins work at 100% efficiency
        dragcoef	= 0.002,		-- drag coefficient while falling
        dragcoefflight  = 0.009,                 -- drag coefficient during flight
		finmul		= 0.05,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(2)  	--  139 HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Laser"},
    fuses       = {"Contact", "Timed", "Optical", "Cluster"},

	racks       = {["1xRK"] = true, ["2xRK"] = true, ["3xRK"] = true, ["4xRK"] = true, ["6xUARRK"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
	
	agility		= 0.03,
	viewcone	= 180, 

    armdelay    = 4     -- minimum fuse arming delay
} )
