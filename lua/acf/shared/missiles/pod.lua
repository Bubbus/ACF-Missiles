--define the class
ACF_DefineRackClass("POD", {
	spread          = 0.5,
	name            = "Rocket Pod",
	desc            = "An accurate, lightweight rocket launcher which can explode if its armour is pierced.",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 2,
	sound           = "acf_extra/airfx/rocket_fire2.wav",
	soundDistance   = " ",
	soundNormal     = " ",
    
    hidemissile     = true,
    protectmissile  = true,
    armour          = 5,
    
    reloadmul       = 8,
} )





--add a gun to the class
ACF_DefineRack("40mm7xPOD", {
	name        = "7x FFAR Pod (40mm)",
	desc        = "A lightweight pod for small rockets which is vulnerable to shots and explosions.",
	model		= "models/missiles/launcher7_40mm.mdl",
	gunclass    = "POD",
	weight      = 200,
	year        = 1940,
    magsize     = 7,
    armour      = 10,
    caliber     = 4,
    
    hidemissile     = false,
    whitelistonly   = true,

    mountpoints = 
	{
		["missile1"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile2"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile3"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile4"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile5"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile6"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile7"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)}
	}
} )



ACF_DefineRack("70mm7xPOD", {
	name        = "7x FFAR Pod (70mm)",
	desc        = "A lightweight pod for rockets which is vulnerable to shots and explosions.",
	model		= "models/missiles/launcher7_70mm.mdl",
	gunclass    = "POD",
	weight      = 400,
	year        = 1940,
    magsize     = 7,
    armour      = 10,
    caliber     = 7,

    hidemissile     = false,
    whitelistonly   = true,
    
    mountpoints = 
	{
		["missile1"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile2"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile3"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile4"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile5"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile6"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile7"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)}
	}
} )



ACF_DefineRack("1x BGM-71E", {
	name = "BGM-71E Round",
	desc = "A single BGM-71E round.",
	model = "models/missiles/bgm_71e_round.mdl",
	gunclass = "POD",
	weight = 30,
	year = 1970,
    magsize = 1,
    caliber = 13,
    reloadmul = 0.01,

    whitelistonly   = true,
    
    mountpoints = 
	{
		["missile1"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)}
	}
} )



ACF_DefineRack("2x BGM-71E", {
	name = "BGM-71E 2x Rack",
	desc = "A BGM-71E rack designed to carry 2 rounds.",
	model = "models/missiles/bgm_71e_2xrk.mdl",
	gunclass = "POD",
	weight = 120,
	year = 1970,
    magsize = 2,
    caliber = 13,

    whitelistonly   = true,
    
    mountpoints = 
	{
		["missile1"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile2"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)}
	}
} )



ACF_DefineRack("4x BGM-71E", {
	name = "BGM-71E 4x Rack",
	desc = "A BGM-71E rack designed to carry 4 rounds.",
	model = "models/missiles/bgm_71e_4xrk.mdl",
	gunclass = "POD",
	weight = 180,
	year = 1970,
    magsize = 4,
    caliber = 13,

    whitelistonly   = true,
    
    mountpoints = 
	{
		["missile1"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile2"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile3"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)},
		["missile4"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,0)}
	}
} )
