
if CLIENT then
	-- Should missiles emit light while their motors are burning?  Looks nice but hits framerate.
	-- Set to 1 to enable, set to 0 to disable, set to another number to set minimum light-size.
	CreateClientConVar( "ACFM_MissileLights", 0 )
end