
--define the class
ACF_defineGunClass("BOMB", {
    type            = "missile",  -- i know i know
	spread          = 1,
	name            = "Bomb",
	desc            = "Free-falling bombs.  These are slower than missiles, but are more powerful and more manouverable when guided.",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 1,
	sound           = "acf_extra/airfx/rocket_fire2.wav",
	soundDistance   = " ",
	soundNormal     = " ",
    
    ammoBlacklist   = {"AP", "APHE"}
} )



-- The original XCF bombs are copy-pasted below, but need to be put into the format seen in missile_aam.lua

/*
ACF_defineGun("30cmB1", { --id
	name		= "30cm Bomb",
	ent			= "acf_rack",
	desc		= "An unguided large-capacity bomb, designed to inspire a fear of gravity into ceilings everywhere - from buildings to battleships.  HEAT warheads were outlawed after the first bomb test was found to have penetrated the target vehicle, the earth's surface, several circles of hell and Satan's morning coffee." .. bombdesc,
	model		= "models/missiles/rack_single.mdl",
	gunclass	= "R1",
	caliber		= 30,
	weight		= R1_MASS,
	magsize		= 1,
	year		= 1940, 
	roundclass	= "Bomb",
	rofmod		= 0.5,
	sound		= "phx/epicmetal_hard.wav",
	round		= 
	{
		id			= "30cmB1",
		model		= "models/missiles/gbu12.mdl",
		maxlength	= 45,
		--maxweight	= 500,
		propweight	= 0
	},
	blacklist	= nofunallowed,
	muzzleflash	= ""
} )




ACF_defineGun("20cmB1", { --id
	name		= "20cm Bomb",
	ent			= "acf_rack",
	desc		= "An unguided medium-capacity bomb.  Effective against everything which has wheels, and some things which don't.  Use these in a dogfight for instant man-points." .. bombdesc,
	model		= "models/missiles/rack_single.mdl",
	gunclass	= "R1",
	caliber		= 20,
	weight		= R1_MASS,
	magsize		= 1,
	year		= 1940,
	roundclass	= "Bomb",
	rofmod		= 0.5,
	sound		= "phx/epicmetal_hard.wav",
	round		= 
	{
		id			= "20cmB2",
		model		= "models/missiles/fab250.mdl",
		maxlength	= 35,
		--maxweight	= 250,
		propweight	= 0
	},
	blacklist	= nofunallowed,
	muzzleflash	= ""
} )




ACF_defineGun("12cmB1", { --id
	name		= "12cm Bomb",
	ent			= "acf_rack",
	desc		= "An unguided small-capacity bomb.  Which is large-capacity by usual standards.  Attach to plane, bring pain." .. bombdesc,
	model		= "models/missiles/rack_single.mdl",
	gunclass	= "R1",
	caliber		= 12,
	weight		= R1_MASS,
	magsize		= 1,
	year		= 1940,
	roundclass	= "Bomb",
	rofmod		= 0.5,
	sound		= "phx/epicmetal_hard.wav",
	round		= 
	{
		id			= "12cmB4",
		model		= "models/missiles/micro.mdl",
		maxlength	= 24,
		--maxweight	= 100,
		propweight	= 0
	},
	blacklist	= nonsmoke,
	muzzleflash	= ""
} )




ACF_defineGun("8cmB1", { --id
	name		= "8cm Bomb",
	ent			= "acf_rack",
	desc		= "A tiny, unguided bomb.  Use on fighter planes to deliver regards on an individual basis, or in carpet-bombers to write dirty words upon enemy nations." .. bombdesc,
	model		= "models/missiles/rack_double.mdl",
	gunclass	= "R1",
	caliber		= 1,
	weight		= R1_MASS,
	magsize		= 1,
	year		= 1940,
	roundclass	= "Bomb",
	rofmod		= 0.5,
	sound		= "phx/epicmetal_hard.wav",
	round		= 
	{
		id			= "8cmB4",
		model		= "models/missiles/micro.mdl",
		maxlength	= 16,
		--maxweight	= 50,
		propweight	= 0
	},
	muzzleflash	= ""
} )
//*/
