
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

-- The FIM-92, a lightweight and fast medium-range anti-air missile.
ACF_defineGun("FIM-92 SAM", { --id
	name = "FIM-92 Missile",
	desc = "The FIM-92 Stinger is a portable, infrared homing surface-to-air missile (SAM). Because of its weight, it can also be used from ground vehicles and helicopters.",
	model = "models/missiles/fim_92.mdl",
	gunclass = "SAM",
    rack = "1x FIM-92",  -- Which rack to spawn this missile on?
	length = 66,
	caliber = 5.9,
	weight = 101,--15.1,    -- Don't scale down the weight though!
    modeldiameter = 5.2 * 1.27, -- in cm
	year = 1978,
	round = {
		model		= "models/missiles/fim_92.mdl",
		rackmdl		= "models/missiles/fim_92_folded.mdl",
		maxlength	= 70,
		casing		= 0.3,	        -- thickness of missile casing, cm
		propweight	= 1,	        -- motor mass - motor casing
		thrust		= 15000,	    	-- average thrust - kg*in/s^2
		burnrate	= 500,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.2,         -- percentage of the propellant consumed in the starter motor.
		minspeed	= 10000,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.003,		-- drag coefficient of the missile
		finmul		= 0.005			-- fin multiplier (mostly used for unpropelled guidance)
	},
    
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = ACF_GetAllGuidanceNamesExcept({"Wire", "Laser"}),
    fuses       = ACF_GetAllFuseNames(),
    
	racks       = {["1x FIM-92"] = true,  ["2x FIM-92"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
   
    seekcone    = 35,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 55,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 2     -- multiplier for missile turn-rate.
} )

