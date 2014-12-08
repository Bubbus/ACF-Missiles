--define the class
ACF_defineGunClass("RK", {
	spread = 1,
	name = "Munitions Rack",
	desc = "A lightweight rack for rockets and bombs which is vulnerable to shots and explosions..",
	muzzleflash = "40mm_muzzleflash_noscale",
	rofmod = 1,
	sound = "acf_extra/airfx/rocket_fire2.wav",
	soundDistance = " ",
	soundNormal = " "
} )

--add a gun to the class
ACF_defineGun("1xRK", {
	name = "Single Munitions Rack",
	desc = "A lightweight rack for rockets and bombs which is vulnerable to shots and explosions.",
	model		= "models/missiles/rack_single.mdl",
	gunclass = "RK",
	caliber = 3,
	weight = 100,
	rofmod = 2.2,
	year = 1915,
    magsize = 1,
	sound = "acf_extra/airfx/rocket_fire2.wav",
	round = {
		maxlength = 45,
		propweight = 0.29
	},
    mountpoints = 
	{
		["missile1"] = {["offset"] = Vector(0, 0, 3),	["scaledir"] = Vector(0, 0, -1)}
	}
} )

ACF_defineGun("2xRK", {
	name = "Dual Munitions Rack",
	desc = "A lightweight rack for rockets and bombs which is vulnerable to shots and explosions.",
	model		= "models/missiles/rack_double.mdl",
	gunclass = "RK",
	caliber = 3,
	weight = 150,
	year = 1915,
    magsize = 2,
	sound = "acf_extra/airfx/rocket_fire2.wav",
	round = {
		maxlength = 63,
		propweight = 0.6,
	},
    mountpoints = 
	{
		["missile1"] = {["offset"] = Vector(4, -1.5, -1.7),	["scaledir"] = Vector(0, -1, 0)},
		["missile2"] = {["offset"] = Vector(4, 1.5, -1.7),	["scaledir"] = Vector(0, 1, 0)}
	}
} )

ACF_defineGun("4xRK", {
	name = "Quad Munitions Rack",
	desc = "A lightweight rack for rockets and bombs which is vulnerable to shots and explosions.",
	model		= "models/missiles/rack_quad.mdl",
	gunclass = "RK",
	caliber = 3,
	weight = 200,
	year = 1936,
    magsize = 4,
	round = {
		maxlength = 76,
		propweight = 2
	},
    mountpoints = 
	{
		["missile1"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,1,0)},
		["missile2"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,-1,0)},
		["missile3"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,-1)},
		["missile4"] = {["offset"] = Vector(0,0,0), ["scaledir"] = Vector(0,0,-1)}
	}
} )

ACF_defineGun("40mm7xRK", {
	name = "7x FFAR Pod (40mm)",
	desc = "A lightweight pod for small rockets which is vulnerable to shots and explosions.",
	model		= "models/missiles/launcher7_40mm.mdl",
	gunclass = "RK",
	caliber = 3,
	weight = 200,
	year = 1940,
    magsize = 7,
	round = {
		maxlength = 93,
		propweight = 4.5
	},
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

ACF_defineGun("70mm7xRK", {
	name = "7x FFAR Pod (70mm)",
	desc = "A lightweight pod for rockets which is vulnerable to shots and explosions.",
	model		= "models/missiles/launcher7_70mm.mdl",
	gunclass = "RK",
	caliber = 3,
	weight = 200,
	year = 1940,
    magsize = 7,
	round = {
		maxlength = 93,
		propweight = 4.5
	},
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