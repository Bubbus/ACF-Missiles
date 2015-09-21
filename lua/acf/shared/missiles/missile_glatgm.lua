
--define the class
ACF_defineGunClass("GLATGM", {
    type            = "missile",
	spread          = 1,
	name            = "Gun Launched Anti Tank Missile",
	desc            = "Missiles specialized for Anti tank operation. These missiles use Cannons, Howitzers and Mortars as launching platform and may only be wire or guided.",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 1,
	sound           = "acf_extra/airfx/rocket_fire.wav",
	soundDistance   = " ",
	soundNormal     = " ",
    effect          = "Rocket Motor",
    
    reloadmul       = 8,
    
    ammoBlacklist   = {"AP", "APHE", "FL", "SM"} -- Including FL would mean changing the way round classes work.
} )





-- The 9M117 Bastion is an 100mm GLATGM with better penetration than common used HEAT rounds
ACF_defineGun("9M117", { --id
	name = "9M117 Missile",
	desc = "PUT DESC HERE",
	model = "models/missiles/glatgm/9m117.mdl",
	gunclass = "GLATGM",
    rack = "100mmC",  -- Which rack to spawn this missile on?
	length = 46,		--Used for the physics calculations
	caliber = 10,
	weight = 23,    -- Don't scale down the weight though!
	year = 1970,
	round = {
		model		= "models/missiles/glatgm/9m117.mdl",
		rackmdl		= "models/missiles/glatgm/9m117f.mdl",
		maxlength	= 30,
		casing		= 0.3,				-- thickness of missile casing, cm
		armour		= 14,				-- effective armour thickness of casing, in mm
		propweight	= 1.2,				-- motor mass - motor casing
		thrust		= 2670,				-- average thrust - kg*in/s^2
		burnrate	= 200,				-- cm^3/s at average chamber pressure
		starterpct	= 0.2,				-- percentage of the propellant consumed in the starter motor.
		minspeed	= 7000,				-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.006,			-- drag coefficient of the missile
		finmul		= 0.012,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(8.5)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},
    
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Wire"},
    fuses       = {"Contact", "Timed"},
    
    racks       = {["100mmC"] = true, ["105mmHW"] = true, ["100mmSC"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
    
    seekcone    = 35,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 55,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 0.7,     -- multiplier for missile turn-rate.
    armdelay    = 0.4     -- minimum fuse arming delay
} )

-- The 9M112 Kobra is an 125mm GLATGM with better penetration than common used HEAT rounds
ACF_defineGun("9M112", { --id
	name = "9M112 Missile",
	desc = "PUT DESC HERE",
	model = "models/missiles/glatgm/9m112.mdl",
	gunclass = "GLATGM",
    rack = "120mmC",  -- Which rack to spawn this missile on?
	length = 46,		--Used for the physics calculations
	caliber = 12,
	weight = 24,    -- Don't scale down the weight though!
	year = 1970,
	round = {
		model		= "models/missiles/glatgm/9m112.mdl",
		rackmdl		= "models/missiles/glatgm/9m112f.mdl",
		maxlength	= 100,
		casing		= 0.3,				-- thickness of missile casing, cm
		armour		= 14,				-- effective armour thickness of casing, in mm
		propweight	= 1.2,				-- motor mass - motor casing
		thrust		= 4000,				-- average thrust - kg*in/s^2
		burnrate	= 200,				-- cm^3/s at average chamber pressure
		starterpct	= 0.2,				-- percentage of the propellant consumed in the starter motor.
		minspeed	= 7000,				-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.006,			-- drag coefficient of the missile
		finmul		= 0.012,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(8)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},
    
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Wire"},
    fuses       = {"Contact", "Timed"},
    
    racks       = {["120mmC"] = true, ["120mmM"] = true, ["120mmSC"] = true, ["122mmHW"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
    
    seekcone    = 35,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 55,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 0.7,     -- multiplier for missile turn-rate.
    armdelay    = 0.4     -- minimum fuse arming delay
} )

-- The MGM-51 Shillelagh is an 125mm GLATGM with better penetration than common used HEAT rounds
ACF_defineGun("MGM-51", { --id
	name = "MGM-51 Shillelagh",
	desc = "PUT DESC HERE",
	model = "models/missiles/glatgm/mgm51.mdl",
	gunclass = "GLATGM",
    rack = "150mmM",  -- Which rack to spawn this missile on?
	length = 46,		--Used for the physics calculations
	caliber = 15,
	weight = 23,    -- Don't scale down the weight though!
	year = 1970,
	round = {
		model		= "models/missiles/glatgm/mgm51.mdl",
		rackmdl		= "models/missiles/glatgm/mgm51.mdl",
		maxlength	= 30,
		casing		= 0.3,				-- thickness of missile casing, cm
		armour		= 14,				-- effective armour thickness of casing, in mm
		propweight	= 1.2,				-- motor mass - motor casing
		thrust		= 3200,				-- average thrust - kg*in/s^2
		burnrate	= 200,				-- cm^3/s at average chamber pressure
		starterpct	= 0.2,				-- percentage of the propellant consumed in the starter motor.
		minspeed	= 7000,				-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.006,			-- drag coefficient of the missile
		finmul		= 0.012,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(8.5)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},
    
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Wire"},
    fuses       = {"Contact", "Timed"},
    
    racks       = {["150mmM"] = true, ["155mmHW"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
    
    seekcone    = 35,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 55,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 0.7,     -- multiplier for missile turn-rate.
    armdelay    = 0.4     -- minimum fuse arming delay
} )