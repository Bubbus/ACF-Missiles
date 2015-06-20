
ACFM_Flares = {}

ACFM_FlareUID = 0

function ACFM_RegisterFlare(bdata)

	bdata.FlareUID = ACFM_FlareUID
	ACFM_Flares[bdata.Index] = ACFM_FlareUID
	
	ACFM_FlareUID = ACFM_FlareUID + 1

end




function ACFM_UnregisterFlare(bdata)

	ACFM_Flares[bdata.Index] = nil

end




--TODO: this causes O(n^2) performance during missile iteration, which will be horrible with things like 100 missiles and 100 flares etc. optimize or limit flare launch rate.
-- TODO: do not apply sub-1 chance to distract guidance in ACFM_GetFlaresInCone.
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
			ret[#ret+1] = flare
		end
		
	end

	return ret
	
end



-- TODO: apply sub-1 chance to distract guidance in ACFM_GetAnyFlareInCone.  update function name accordingly.
function ACFM_GetAnyFlareInCone(pos, dir, degs)

	local minDot = math.cos( math.rad(degs) )
	local bullets = ACF.Bullet
	
	for idx, uid in pairs(ACFM_Flares) do
		
		local flare = bullets[idx]
		
		if not (flare and flare.FlareUID and flare.FlareUID == uid) then continue end
		
		local flareDir = flare.Pos - pos
		flareDir:Normalize()
		
		local dot = dir:Dot(flareDir)
		
		if (dot >= minDot) then
			return flare
		end
		
	end
	
end




function ACFM_ApplyCountermeasures(missile, guidance)

	if guidance.Override then return end
	
	for name, measure in pairs(ACF.Countermeasure) do
	
		if not measure.AppliesTo[guidance.Name] then return end
		
		local override = measure.ApplyAll(missile, guidance)
		
		if override then
			guidance.Override = override
			return
		end
	
	end

end