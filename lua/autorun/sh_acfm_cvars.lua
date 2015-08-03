
if CLIENT then

	-- Should missiles emit light while their motors are burning?  Looks nice but hits framerate.
	-- Set to 1 to enable, set to 0 to disable, set to another number to set minimum light-size.
	CreateClientConVar( "ACFM_MissileLights", 0 )
	
elseif SERVER then

	-- Should flares light players and NPCs on fire?  Does not affect godded players.
	-- Set to 1 to enable, set to 0 to disable.
	CreateClientConVar( "ACFM_FlaresIgnite", 0 )
	
end