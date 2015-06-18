
ACFM_Flares = {}

ACFM_FlareUID = 0

function ACFM_RegisterFlare(bdata)

	bdata.FlareUID = ACFM_FlareUID
	ACFM_Flares[bdata.Index] = ACFM_FlareUID
	
	print("Registered", bdata.Index, "as flare #", ACFM_FlareUID)
	
	ACFM_FlareUID = ACFM_FlareUID + 1

end




function ACFM_UnregisterFlare(bdata)

	ACFM_Flares[bdata.Index] = nil
	
	print("Unregistered", bdata.Index, "as flare")

end




--TODO: this causes O(n^2) performance during missile iteration, which will be horrible with things like 100 missiles and 100 flares etc. optimize or limit flare launch rate.
function ACFM_GetFlaresInCone(pos, dir, degs)

	local ret = {}
	local minDot = math.cos( math.rad(degs) )
	local bullets = ACF.Bullet
	
	for idx, uid in pairs(ACFM_Flares) do
		
		local flare = bullets[idx]
		
		if not (flare and flare.FlareUID and flare.FlareUID == uid) then continue end
		
		local flareDir = flare.Pos - pos
		flareDir:Normalize()
		
		local dot = dir:Dot(flareDir)
		
		if (dot >= minDot) then
			print("Found flare #", uid, "in cone")
			ret[#ret+1] = flare
		end
		
	end

	return ret
	
end