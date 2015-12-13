
ACF_DefineRadarClass("DIR", {
	name = "Directional Radar",
	desc = "A missile radar with unlimited range but a limited view cone.",
} )




ACF_DefineRadar("SmallDIR", {
	name 		= "Small Directional Radar",
	ent			= "acf_missileradar",
	desc 		= "A lightweight directional radar with a smaller view cone.",
	model		= "models/props_c17/light_decklight01_off.mdl",
	class 		= "DIR",
	weight 		= 300,
	viewcone 	= 30 -- half of the total cone.  'viewcone = 30' means 60 degs total viewcone.
} )


ACF_DefineRadar("MediumDIR", {
	name 		= "Medium Directional Radar",
	ent			= "acf_missileradar",
	desc 		= "A directional radar with a regular view cone.",
	model		= "models/props_rooftop/satellitedish02.mdl",
	class 		= "DIR",
	weight 		= 600,
	viewcone 	= 45 -- half of the total cone.  'viewcone = 30' means 60 degs total viewcone.
} )


ACF_DefineRadar("LargeDIR", {
	name 		= "Large Directional Radar",
	ent			= "acf_missileradar",
	desc 		= "A heavy directional radar with a large view cone.",
	model		= "models/props_lab/kennel_physics.mdl",
	class 		= "DIR",
	weight 		= 900,
	viewcone 	= 60 -- half of the total cone.  'viewcone = 30' means 60 degs total viewcone.
} )