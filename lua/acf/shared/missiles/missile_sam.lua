
--define the class
ACF_defineGunClass("SAM", {
	spread          = 1,
	name            = "Surface-To-Air Missile",
	desc            = "Missiles specialized for ground-to-air flight.  These missiles have limited power but are agile and long-range.",
	muzzleflash     = "40mm_muzzleflash_noscale",
	rofmod          = 1,
	sound           = "acf_extra/airfx/rocket_fire2.wav",
	soundDistance   = " ",
	soundNormal     = " ",
    
    ammoBlacklist   = {"AP", "APHE"}
} )

