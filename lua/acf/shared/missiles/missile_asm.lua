
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
    
    ammoBlacklist   = {"AP", "APHE", "FL"} -- Including FL would mean changing the way round classes work.
} )

