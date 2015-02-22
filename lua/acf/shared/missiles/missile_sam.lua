
--define the class
ACF_defineGunClass("SAM", {
    type            = "missile",  -- i know i know
	spread          = 1,
	name            = "Surface-To-Air Missile",
	desc            = "Missiles specialized for ground-to-air flight.  These missiles have limited power but are agile and long-range.",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 1,
	sound           = "acf_extra/airfx/rocket_fire2.wav",
	soundDistance   = " ",
	soundNormal     = " ",
    effect          = "Rocket Motor",
    
    reloadmul       = 8,
    
    ammoBlacklist   = {"AP", "APHE", "FL", "HEAT"} -- Including FL would mean changing the way round classes work.
} )

-- The FIM-92, ----PUT SOME INFO HERE---- FOR NOW IT USE OLD RACKS - IT WILL HAVE SPECIAL RACKS AFTER I MADE THEM
ACF_defineGun("FIM-92C", { --id
	name = "FIM-92C Missile",
	desc = "The FIM-92 Stinger is a portable infrared homing surface-to-air missile (SAM), which can be adapted to fire from ground vehicles or helicopters (as an AAM)\n\nThis round can only fire one missile before having to reload.",
	model = "models/missiles/fim_92.mdl",
	gunclass = "SAM",
    rack = "2xRK",  -- Which rack to spawn this missile on?
	length = 66,
	caliber = 5.9,
	weight = 22.9,    -- Don't scale down the weight though!
    modeldiameter = 5.2 * 1.27, -- in cm
	year = 1970,
	round = {
		model		= "models/missiles/fim_92.mdl",
		rackmdl		= "models/missiles/fim_92.mdl",
		maxlength	= 163,
		casing		= 0.3,	        -- thickness of missile casing, cm
		propweight	= 1,	        -- motor mass - motor casing
		thrust		= 5000,	    	-- average thrust - kg*in/s^2
		burnrate	= 450,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.25,         -- percentage of the propellant consumed in the starter motor.
		minspeed	= 3000,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.004,		-- drag coefficient of the missile
		finmul		= 0.01			-- fin multiplier (mostly used for unpropelled guidance)
	},
    
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = ACF_GetAllGuidanceNamesExcept({"Wire"}),
    fuses       = ACF_GetAllFuseNames(),
    
	racks       = {["1xRK"] = true,  ["2xRK"] = true,  ["4xRK"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
   
    seekcone    = 35,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 55,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1     -- multiplier for missile turn-rate.
} )

