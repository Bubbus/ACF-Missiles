
ACF_DefineRadarClass("OMNI", {
	name = "Spherical Radar",
	desc = "A missile radar with full 360-degree detection but a limited range.",
} )

-- TODO all models change here into spherical radars


ACF_DefineRadar("SmallOMNI", {
	name 		= "Small Spherical Radar",
	ent			= "acf_missileradar",
	desc 		= "A lightweight omni-directional radar with a smaller range.",
	model		= "models/radar/radar_sml.mdl",
	class 		= "OMNI",
	weight 		= 450,
	range 		= 9000 -- range in inches.
} )


ACF_DefineRadar("MediumOMNI", {
	name 		= "Medium Spherical Radar",
	ent			= "acf_missileradar",
	desc 		= "A omni-directional radar with a regular range.",
	model		= "models/radar/radar_mid.mdl", -- medium one is for now scalled big one - will be changed
	class 		= "OMNI",
	weight 		= 900,
	range 		= 12000 -- range in inches.
} )


ACF_DefineRadar("LargeOMNI", {
	name 		= "Large Spherical Radar",
	ent			= "acf_missileradar",
	desc 		= "A heavy omni-directional radar with a large range.",
	model		= "models/radar/radar_big.mdl",
	class 		= "OMNI",
	weight 		= 1200,
	range 		= 15000 -- range in inches.
} )