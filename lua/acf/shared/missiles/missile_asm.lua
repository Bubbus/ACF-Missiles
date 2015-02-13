
--define the class
ACF_defineGunClass("ASM", {
    type            = "missile",
	spread          = 1,
	name            = "Air-To-Surface Missile",
	desc            = "Missiles specialized for air-to-ground flight.  These missiles are heavier than Air-to-Air missiles and may only be wire-guided.",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 1,
	sound           = "acf_extra/airfx/rocket_fire2.wav",
	soundDistance   = " ",
	soundNormal     = " ",
    effect          = "Rocket Motor",
    
    reloadmul       = 8,
    
    ammoBlacklist   = {"AP", "APHE", "FL", "SM"} -- Including FL would mean changing the way round classes work.
} )





-- The BGM-71E, a wire guided missile with medium anti-tank effectiveness.
ACF_defineGun("BGM-71E ASM", { --id
	name = "BGM-71E Missile",
	desc = "A light-weight anti-tank missile capable of air-to-surface aswell as surface-to-surface use.\n\nThis round can only fire one missile before having to reload.",
	model = "models/missiles/bgm_71e.mdl",
	gunclass = "ASM",
    rack = "1x BGM-71E",  -- Which rack to spawn this missile on?
	length = 46,
	caliber = 5.9,
	weight = 22.9,    -- Don't scale down the weight though!
	year = 1970,
	round = {
		model		= "models/missiles/bgm_71e.mdl",
		rackmdl		= "models/missiles/bgm_71e.mdl",
		maxlength	= 150,
		casing		= 0.3,	        -- thickness of missile casing, cm
		propweight	= 1,	        -- motor mass - motor casing
		thrust		= 5000,	    	-- average thrust - kg*in/s^2
		burnrate	= 450,	        -- cm^3/s at average chamber pressure
		starterpct	= 0.25,         -- percentage of the propellant consumed in the starter motor.
		minspeed	= 3000,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.004,		-- drag coefficient of the missile
		finmul		= 0.01, 		-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(2)  -- HEAT velocity multiplier.  Squared relation to penetration (math.sqrt(2) means double pen)
	},
    
    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = ACF_GetAllGuidanceNamesExcept({"Radar"}),
    fuses       = ACF_GetAllFuseNames(),
    
    racks       = {["1x BGM-71E"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
    
    seekcone    = 35,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)
    viewcone    = 55,   -- getting outside this cone will break the lock.  Divided by 2. 
    
    agility     = 1     -- multiplier for missile turn-rate.
} )


