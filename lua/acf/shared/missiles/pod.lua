--define the class
ACF_DefineRackClass("POD", {
	spread          = 0.5,
	name            = "Rocket Pod",
	desc            = "An accurate, lightweight rocket launcher which can explode if its armour is pierced.",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 2,
	sound           = "acf_extra/airfx/rocket_fire2.wav",
	soundDistance   = " ",
	soundNormal     = " "
} )




--add a gun to the class
ACF_DefineRack("40mm7xPOD", {
	name        = "7x FFAR Pod (40mm)",
	desc        = "A lightweight pod for small rockets which is vulnerable to shots and explosions.",
	model		= "models/missiles/launcher7_40mm.mdl",
	gunclass    = "POD",
	caliber     = 4,
	weight      = 200,
	year        = 1940,
    magsize     = 7,
    armour      = 10,

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
	caliber     = 7,
	weight      = 400,
	year        = 1940,
    magsize     = 7,
    armour      = 10,

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