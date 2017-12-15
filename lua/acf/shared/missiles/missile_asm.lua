
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
	rofmod = 0.8,
	round = {
		model		= "models/missiles/bgm_71e.mdl",
		rackmdl		= "models/missiles/bgm_71e.mdl",
		maxlength	= 30,
		casing		= 0.1,				-- thickness of missile casing, cm
		armour		= 6,				-- effective armour thickness of casing, in mm
		propweight	= 1.2,				-- motor mass - motor casing
		thrust		= 10000,				-- average thrust - kg*in/s^2
		burnrate	= 200,				-- cm^3/s at average chamber pressure
		starterpct	= 0.2,				-- percentage of the propellant consumed in the starter motor.
		minspeed	= 2000,				-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.005,			-- drag coefficient while falling
                dragcoefflight  = 0.06,                 -- drag coefficient during flight
		finmul		= 0.05,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(8.8)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Wire"},
    fuses       = {"Contact", "Timed"},

    racks       = {["1x BGM-71E"] = true, ["2x BGM-71E"] = true, ["4x BGM-71E"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    agility     = 0.25,     -- multiplier for missile turn-rate.
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
		maxlength	= 45,
		casing		= 0.2,			-- thickness of missile casing, cm
		armour		= 7,			-- effective armour thickness of casing, in mm
		propweight	= 1,			-- motor mass - motor casing
		thrust		= 18000,			-- average thrust - kg*in/s^2
		burnrate	= 180,			-- cm^3/s at average chamber pressure
		starterpct	= 0.25,			-- percentage of the propellant consumed in the starter motor.
		minspeed	= 8000,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.003,		-- drag coefficient while falling
                dragcoefflight  = 0.03,                 -- drag coefficient during flight
		finmul		= 0.1,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(6.5)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Laser"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),

    racks       = {["2x AGM-114"] = true, ["4x AGM-114"] = true, ["1xRK"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

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
	caliber = 13,
	weight = 12,    -- Don't scale down the weight though!
	year = 1969,
	rofmod = 0.75,
	round = {
		model		= "models/missiles/at3.mdl",
		rackmdl		= "models/missiles/at3.mdl",
		maxlength	= 30,
		casing		= 0.1,				-- thickness of missile casing, cm
		armour		= 5,				-- effective armour thickness of casing, in mm
		propweight	= 1,				-- motor mass - motor casing
		thrust		= 4000,				-- average thrust - kg*in/s^2
		burnrate	= 130,				-- cm^3/s at average chamber pressure
		starterpct	= 0.05,				-- percentage of the propellant consumed in the starter motor.
		minspeed	= 2000,				-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.005,			-- drag coefficient while falling
                dragcoefflight  = 0.05,                 -- drag coefficient during flight
		finmul		= 0.05,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(8)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Wire"},
    fuses       = {"Contact", "Timed"},

    racks       = {["1xAT3RKS"] = true, ["1xAT3RK"] = true, ["1xRK_small"] = true, ["3xRK"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

	skinindex   = {HEAT = 0, HE = 1},

    agility     = 0.3,     -- multiplier for missile turn-rate.
    armdelay    = 0.6     -- minimum fuse arming delay
} )

-- The 9M120 Ataka, a laser guided missile with high anti-tank effectiveness.
ACF_defineGun("Ataka ASM", { --id
	name = "9M120 Ataka Missile",
	desc = "The 9M120 Ataka is a high-speed anti tank missile used by soviet helicopters and ground vehicles, can be armed with HE and HEAT warheads",
	model = "models/missiles/9m120.mdl",
	gunclass = "ASM",
    rack = "1x Ataka",  -- Which rack to spawn this missile on?
	length = 85,
	caliber = 13,
	weight = 65,    -- Don't scale down the weight though!
    modeldiameter = 17.2 * 1.27, -- in cm
	year = 1984,
	rofmod = 0.8,
	round = {
		model		= "models/missiles/9m120.mdl",
		rackmdl		= "models/missiles/9m120.mdl",
		maxlength	= 50,
		casing		= 0.1,			-- thickness of missile casing, cm
		armour		= 5,			-- effective armour thickness of casing, in mm
		propweight	= 1.8,			-- motor mass - motor casing
		thrust		= 30000,			-- average thrust - kg*in/s^2
		burnrate	= 250,			-- cm^3/s at average chamber pressure
		starterpct	= 0.25,			-- percentage of the propellant consumed in the starter motor.
		minspeed	= 5000,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.003,		-- drag coefficient while falling
                dragcoefflight  = 0.05,                 -- drag coefficient during flight
		finmul		= 0.05,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(6.6)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Laser"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),

    racks       = {["1x Ataka"] = true, ["1xRK"] = true, ["2xRK"] = true, ["3xRK"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    viewcone    = 30,   -- getting outside this cone will break the lock.  Divided by 2.

    agility     = 0.15,		-- multiplier for missile turn-rate.
    armdelay    = 0.5     -- minimum fuse arming delay
} )

-- The AGM-45 shrike, a vietnam war-era antiradiation missile built off the AIM-7 airframe.
ACF_defineGun("AGM-45 ASM", { --id
	name = "AGM-45 Shrike Missile",
	desc = "The body of an AIM-7 sparrow, an air-to-ground seeker kit, and a far larger warhead than its ancestor.\nWith its homing radar seeker option, thicker skin, and long range, it is a great weapon for long-range, precision standoff attack versus squishy things, like those pesky sam sites.",
	model = "models/missiles/aim120.mdl",
	gunclass = "ASM",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 1000,
	caliber = 12,
	weight = 150,    -- Don't scale down the weight though!
    modeldiameter = 7.1 * 2.54, -- in cm
	year = 1969,
	rofmod = 0.6,
	round = {
		model		= "models/missiles/aim120.mdl",
		rackmdl		= "models/missiles/aim120.mdl",
		maxlength	= 120,
		casing		= 0.15,			-- thickness of missile casing, cm
		armour		= 10,			-- effective armour thickness of casing, in mm
		propweight	= 3,			-- motor mass - motor casing
		thrust		= 800,		-- average thrust - kg*in/s^2
		burnrate	= 300,			-- cm^3/s at average chamber pressure
		starterpct	= 0.05,			-- percentage of the propellant consumed in the starter motor.
		minspeed	= 4000,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.001,		-- drag coefficient while falling
                dragcoefflight  = 0,                 -- drag coefficient during flight
		finmul		= 0.2,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(0.5)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Radar", "Laser"},
    fuses       = {"Contact", "Timed"}, 

    racks       = {["1xRK"] = true, ["2xRK"] = true, ["3xRK"] = true, ["4xRK"] = true, ["6xUARRK"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

	seekcone = 5,		--why do you need a big seeker cone if yuo're firing vs a SAM site?
	viewcone = 10,		--I don't think a fucking SAM site should have to dodge much >_>
	
    agility     = 0.08,		-- multiplier for missile turn-rate.
    armdelay    = 0.3     -- minimum fuse arming delay
} )

--Sidearm, a lightweight anti-radar missile used by helicopters in the 80s
ACF_defineGun("AGM-122 ASM", { --id
	name = "AGM-122 Sidearm Missile",
        desc = "A refurbished early-model AIM-9, for attacking ground targets.  Less well-known than the bigger Shrike, it provides easy-to-use blind-fire anti-SAM performance for helicopters and light aircraft, with far heavier a punch than its ancestor.",
	model = "models/missiles/aim9.mdl",
	gunclass = "ASM",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 205,
	caliber = 12.7, -- Aim-9 is listed as 9 as of 6/30/2017, why?  Wiki lists it as a 5" rocket!
	weight = 88.5,    -- Don't scale down the weight though!
	rofmod = 0.3,
	year = 1986,
	round = {
		model		= "models/missiles/aim9.mdl",
		rackmdl		= "models/missiles/aim9.mdl",
		maxlength	= 70,
		casing		= 0.1,	        -- thickness of missile casing, cm
		armour		= 8,			-- effective armour thickness of casing, in mm
		propweight	= 4,	        -- motor mass - motor casing
		thrust		= 4500,	    -- average thrust - kg*in/s^2		--was 100000
		burnrate	= 1400,	        -- cm^3/s at average chamber pressure	--was 350
		starterpct	= 0.4,          -- percentage of the propellant consumed in the starter motor.	--was 0.2
		minspeed	= 6000,		-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.001,		-- drag coefficient while falling
                dragcoefflight  = 0.001,                 -- drag coefficient during flight
		finmul		= 0.03			-- fin multiplier (mostly used for unpropelled guidance)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Radar"},
    fuses       = {"Contact"},

	racks       = {["1xRK"] = true,  ["2xRK"] = true, ["3xRK"] = true, ["4xRK"] = true, ["1xRK_small"] = true},   -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'

    seekcone    = 10,   -- getting inside this cone will get you locked.  Divided by 2 ('seekcone = 40' means 80 degrees total.)	--was 25
    viewcone    = 20,   -- getting outside this cone will break the lock.  Divided by 2.

    agility     = 0.3,  -- multiplier for missile turn-rate.
    armdelay    = 0.2     -- minimum fuse arming delay		--was 0.4
} )

-- The 9M17P, a very long range, very powerful but very slow antitank missile
ACF_defineGun("AT-2 ASM", { --id
	name = "AT-2 Missile",
	desc = "The 9M17P is a VERY powerful long-range antitank missile, which sacrifices flight speed for killing power.\nIt is an excellent long-range missile for heavy antitank work, and its size gives it good multipurpose capability.",
	model = "models/missiles/at2.mdl",
	gunclass = "ASM",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 55,		--Used for the physics calculations
	caliber = 16, 
	weight = 27,    -- Don't scale down the weight though!
	year = 1969,
	rofmod = 0.9,
	round = {
		model		= "models/missiles/at2.mdl",
		rackmdl		= "models/missiles/at2.mdl",
		maxlength	= 55,
		casing		= 0.1,				-- thickness of missile casing, cm
		armour		= 5,				-- effective armour thickness of casing, in mm
		propweight	= 1,				-- motor mass - motor casing
		thrust		= 1100,				-- average thrust - kg*in/s^2
		burnrate	= 50,				-- cm^3/s at average chamber pressure
		starterpct	= 0.2,				-- percentage of the propellant consumed in the starter motor.
		minspeed	= 500,				-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0.001,			-- drag coefficient while falling
                dragcoefflight  = 0.01,                 -- drag coefficient during flight
		finmul		= 0.1,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(5.5)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Laser", "Wire"},
    fuses       = {"Contact", "Timed"},
	viewcone    = 90,   -- getting outside this cone will break the lock.  Divided by 2.
    racks       = {["1xRK"] = true, ["2xRK"] = true, ["3xRK"] = true, ["4xRK"] = true, ["2x AGM-114"] = true, ["4x AGM-114"] = true, ["1xRK_small"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
    agility     = 0.2,     -- multiplier for missile turn-rate.
    armdelay    = 1     -- minimum fuse arming delay
} )

-- The AGM-119, a heavy antiship missile
--[[
ACF_defineGun("AGM-119 ASM", { --id
	name = "AGM-119 Penguin Missile",
	desc = "An antiship missile, capable of delivering a massive punch versus ships or fixed targets.\nAlthough maneuverable and dangerous, it is very heavy and large, with only its laser-guided variant being able to engage moving targets.",
	model = "models/props/missiles/agm119_s.mdl",
	gunclass = "ASM",
    rack = "1xRK",  -- Which rack to spawn this missile on?
	length = 1000,
	caliber = 30,
	weight = 380,    -- Don't scale down the weight though!
    modeldiameter = 28, -- in cm
	year = 1972,
	round = {
		model		= "models/props/missiles/agm119_s.mdl",
		rackmdl		= "models/props/missiles/agm119_s.mdl",
		maxlength	= 50,
		casing		= 0.3,			-- thickness of missile casing, cm
		armour		= 25,			-- effective armour thickness of casing, in mm
		propweight	= 3,			-- motor mass - motor casing
		thrust		= 725,		-- average thrust - kg*in/s^2
		burnrate	= 50,			-- cm^3/s at average chamber pressure
		starterpct	= 0.2,			-- percentage of the propellant consumed in the starter motor.
		minspeed	= 250,			-- minimum speed beyond which the fins work at 100% efficiency
		dragcoef	= 0,		-- drag coefficient while falling
                dragcoefflight  = 0.005,                 -- drag coefficient during flight
		finmul		= 0.2,			-- fin multiplier (mostly used for unpropelled guidance)
        penmul      = math.sqrt(0.25)  	-- HEAT velocity multiplier. Squared relation to penetration (math.sqrt(2) means 2x pen)
	},

    ent         = "acf_missile_to_rack", -- A workaround ent which spawns an appropriate rack for the missile.
    guidance    = {"Dumb", "Laser", "Radar"},
    fuses       = ACF_GetAllFuseNamesExcept( {"Radio"} ),

    racks       = {["1xRK"] = true, ["2xRK"] = true},    -- a whitelist for racks that this missile can load into.  can also be a 'function(bulletData, rackEntity) return boolean end'
	seekcone = 1,
	viewcone = 1,		--I don't think a fucking SAM site should have to dodge much >_>

	agility     = 0.1,		-- multiplier for missile turn-rate.
    armdelay    = 0.3     -- minimum fuse arming delay
} )
]]--
