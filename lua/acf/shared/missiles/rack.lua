--define the class
ACF_DefineRackClass("RK", {
	spread = 1,
	name = "Munitions Rack",
	desc = "A lightweight rack for rockets and bombs which is vulnerable to shots and explosions.",
	muzzleflash = "40mm_muzzleflash_noscale",
	rofmod = 1,
	sound = "acf_extra/airfx/rocket_fire2.wav",
	soundDistance = " ",
	soundNormal = " "
} )




--add a gun to the class
ACF_DefineRack("1xRK", {
	name = "Single Munitions Rack",
	desc = "A lightweight rack for rockets and bombs which is vulnerable to shots and explosions.",
	model		= "models/missiles/rack_single.mdl",
	gunclass = "RK",
	weight = 100,
	rofmod = 2.2,
	year = 1915,
    magsize = 1,
	sound = "acf_extra/airfx/rocket_fire2.wav",

    mountpoints = 
	{
		["missile1"] = {["offset"] = Vector(0, 0, 3),	["scaledir"] = Vector(0, 0, -1)}
	}
} )




ACF_DefineRack("2xRK", {
	name = "Dual Munitions Rack",
	desc = "A lightweight rack for rockets and bombs which is vulnerable to shots and explosions.",
	model		= "models/missiles/rack_double.mdl",
	gunclass = "RK",
	weight = 150,
	year = 1915,
    magsize = 2,
	sound = "acf_extra/airfx/rocket_fire2.wav",

    mountpoints = 
	{
		["missile1"] = {["offset"] = Vector(4, -1.5, -1.7),	["scaledir"] = Vector(0, -1, 0)},
		["missile2"] = {["offset"] = Vector(4, 1.5, -1.7),	["scaledir"] = Vector(0, 1, 0)}
	}
} )




ACF_DefineRack("4xRK", {
	name = "Quad Munitions Rack",
	desc = "A lightweight rack for rockets and bombs which is vulnerable to shots and explosions.",
	model		= "models/missiles/rack_quad.mdl",
	gunclass = "RK",
	weight = 200,
	year = 1936,
    magsize = 4,

    mountpoints = 
	{
		["missile1"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,1,0)},
		["missile2"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,-1,0)},
		["missile3"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,-1)},
		["missile4"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,-1)}
	}
} )

