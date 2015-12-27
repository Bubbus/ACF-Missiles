
--define the class
ACF_defineGunClass("ASM", {
    type            = "missile",
	spread          = 1,
	name            = "Air-To-Surface Missile",
	desc            = "Missiles specialized for air-to-surface operation. These missiles are heavier than air-to-air missiles and may only be wire or laser guided.",
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
	desc = "The BGM-71E missile is a lightweight, wire guided anti-tank munition. It can be used in both air-to-surface and surface-to-surface combat, making it a decent alternative for ground vehicles.",
	model = "models/missiles/bgm_71e.mdl",
	gunclass = "ASM",
    rack = "1x BGM-71E",  -- Which rack to spawn this missile on?
	length = 46,		--Used for the physics calculations
	caliber = 13,
	weight = 23,    -- Don't scale down the weight though!
	year = 1970,
	round = {
		model		= "models/missiles/bgm_71e.mdl",
		rackmdl		= "models/missiles/bgm_71e.mdl",
		maxlength	= 30,
		casing		= 0.3,				-- thickness of missile casing, cm
		armour		= 14,				-- effective armour thickness of casing, in mm
		propweight	= 1.2,				-- motor mass - motor casing
		thrust		= 20000,				-- average thrust - kg*in/s^2
		burnrate	= 200,				-- cm^3/s at average chamber pressure
		starterpct	= 0.2,				-- percentage of the propellant consumed in the starter motor.
		minspeed	= 4000,				-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.006,			-- drag coefficient while falling
                dragcoefflight  = 0.06,                 -- drag coefficient during flight
		finmul		= 0.06,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(8.5)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Wire"},
    fuses       = {"Contact", "Timed"},

    racks       = {["1x BGM-71E"] = true, ["2x BGM-71E"] = true, ["4x BGM-71E"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    agility     = 0.2,     -- multiplier for missile turn-rate.
    armdelay    = 0.4     -- minimum fuse arming delay
} )


-- The AGM-114, a laser guided missile with high anti-tank effectiveness.
ACF_defineGun("AGM-114 ASM", { --id
	name = "AGM-114 Missile",
	desc = "The AGM-114 Hellfire is an air-to-surface missile first developed for anti-armor use, but later models were developed for precision strikes against other target types.",
	model = "models/missiles/agm_114.mdl",
	gunclass = "ASM",
    rack = "2x AGM-114",  -- Which rack to spawn this missile on?
	length = 66,
	caliber = 16,
	weight = 45,    -- Don't scale down the weight though!
    modeldiameter = 17.2 * 1.27, -- in cm
	year = 1984,
	round = {
		model		= "models/missiles/agm_114.mdl",
		rackmdl		= "models/missiles/agm_114.mdl",
		maxlength	= 35,
		casing		= 0.3,			-- thickness of missile casing, cm
		armour		= 10,			-- effective armour thickness of casing, in mm
		propweight	= 1,			-- motor mass - motor casing
		thrust		= 22000,			-- average thrust - kg*in/s^2
		burnrate	= 180,			-- cm^3/s at average chamber pressure
		starterpct	= 0.25,			-- percentage of the propellant consumed in the starter motor.
		minspeed	= 8000,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.003,		-- drag coefficient while falling
                dragcoefflight  = 0.05,                 -- drag coefficient during flight
		finmul		= 0.06,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(7)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Laser"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),

    racks       = {["2x AGM-114"] = true, ["4x AGM-114"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    viewcone    = 40,   -- getting outside this cone will break the lock.  Divided by 2.

    agility     = 0.4,		-- multiplier for missile turn-rate.
    armdelay    = 0.7     -- minimum fuse arming delay
} )

-- The AT-3, a short-range wire-guided missile with better anti-tank effectiveness than the BGM-71E but much slower.
ACF_defineGun("AT-3 ASM", { --id
	name = "AT-3 Missile",
	desc = "The AT-3 missile (9M14P) is a short-range wire-guided anti-tank munition. It can be mounted on both helicopters and ground vehicles. Due to its low weight and size, it is a good alternative to the BGM-71E, at the expense of range and speed.",
	model = "models/missiles/at3.mdl",
	gunclass = "ASM",
    rack = "1xAT3RK",  -- Which rack to spawn this missile on?
	length = 43,		--Used for the physics calculations
	caliber = 12.5,
	weight = 12,    -- Don't scale down the weight though!
	year = 1969,
	round = {
		model		= "models/missiles/at3.mdl",
		rackmdl		= "models/missiles/at3.mdl",
		maxlength	= 30,
		casing		= 0.3,				-- thickness of missile casing, cm
		armour		= 16,				-- effective armour thickness of casing, in mm
		propweight	= 1,				-- motor mass - motor casing
		thrust		= 7000,				-- average thrust - kg*in/s^2
		burnrate	= 160,				-- cm^3/s at average chamber pressure
		starterpct	= 0.15,				-- percentage of the propellant consumed in the starter motor.
		minspeed	= 2000,				-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.005,			-- drag coefficient while falling
                dragcoefflight  = 0.05,                 -- drag coefficient during flight
		finmul		= 0.04,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(8)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Wire"},
    fuses       = {"Contact", "Timed"},

    racks       = {["1xAT3RKS"] = true, ["1xAT3RK"] = true, ["1xRK_small"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

	skinindex   = {HEAT = 0, HE = 1},

    agility     = 0.15,     -- multiplier for missile turn-rate.
    armdelay    = 0.8     -- minimum fuse arming delay
} )

-- The 9M120 Ataka, a laser guided missile with high anti-tank effectiveness.
ACF_defineGun("Ataka ASM", { --id
	name = "9M120 Ataka Missile",
	desc = "The 9M120 Ataka is an anti tank missile used by soviet helicopters and ground vehicles, can be armed with HE and HEAT warheads",
	model = "models/missiles/9m120.mdl",
	gunclass = "ASM",
    rack = "1x Ataka",  -- Which rack to spawn this missile on?
	length = 85,
	caliber = 13,
	weight = 65,    -- Don't scale down the weight though!
    modeldiameter = 17.2 * 1.27, -- in cm
	year = 1984,
	round = {
		model		= "models/missiles/9m120.mdl",
		rackmdl		= "models/missiles/9m120.mdl",
		maxlength	= 50,
		casing		= 0.1,			-- thickness of missile casing, cm
		armour		= 10,			-- effective armour thickness of casing, in mm
		propweight	= 1.8,			-- motor mass - motor casing
		thrust		= 30000,			-- average thrust - kg*in/s^2
		burnrate	= 280,			-- cm^3/s at average chamber pressure
		starterpct	= 0.25,			-- percentage of the propellant consumed in the starter motor.
		minspeed	= 5000,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.004,		-- drag coefficient while falling
                dragcoefflight  = 0.06,                 -- drag coefficient during flight
		finmul		= 0.06,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(6)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Laser"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),

    racks       = {["1x Ataka"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    viewcone    = 28,   -- getting outside this cone will break the lock.  Divided by 2.

    agility     = 0.12,		-- multiplier for missile turn-rate.
    armdelay    = 0.7     -- minimum fuse arming delay
} )
