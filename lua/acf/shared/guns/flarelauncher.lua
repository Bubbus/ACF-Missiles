--define the class
ACF_defineGunClass("FGL", {
	spread = 1.5,
	name = "Flare Launcher",
	desc = "Flare Launchers can fire flares much more rapidly than other launchers, but can't load any other ammo types.",
	muzzleflash = "40mm_muzzleflash_noscale",
	rofmod = 0.66,
	sound = "weapons/acf_gun/grenadelauncher.wav",
	soundDistance = " ",
	soundNormal = " "
} )

--add a gun to the class
ACF_defineGun("40mmFGL", { --id
	name = "40mm Flare Launcher",
	desc = "Put on an all-American fireworks show with this flare launcher: high fire rate, low distraction rate.  Fill the air with flare.",
	model = "models/missiles/blackjellypod.mdl",
	gunclass = "FGL",
	canparent = true,
	caliber = 4.0,
	weight = 75,
	magsize = 12,
	magreload = 8,
	year = 1970,
	round = {
		maxlength = 9,
		propweight = 0.007
	}
} )
