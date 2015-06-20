
local ClassName = "Flare"


ACF = ACF or {}
ACF.Countermeasure = ACF.Countermeasure or {}

local this = ACF.Countermeasure[ClassName] or inherit.NewBaseClass()
ACF.Countermeasure[ClassName] = this

---


this.AppliesTo = 
{
	Radar = true,
	Laser = true
}


this.Flare = nil



function this:Init()

end




function this:Configure(flare)

	self.Flare = flare

end




function this:GetGuidanceOverride(missile, guidance)

	if not self.Flare then return end
	
	local activeFlare = ACF.Bullet[self.Flare.Index]
	if not (activeFlare and activeFlare.FlareUID == self.Flare.FlareUID) then return end

	return {TargetPos = self.Flare.Pos, TargetVel = self.Flare.Vel}

end




-- 'static' function to iterate over all flares in flight and return one which affects the guidance.
-- TODO: apply sub-1 chance to distract guidance in ACFM_GetAnyFlareInCone.
function this.ApplyAll(missile, guidance)
	
	local cone = guidance.ViewCone
	
	if not cone or cone <= 0 then return end
	
	local pos = missile:GetPos()
	local dir = missile:GetForward()
	
	local flare = ACFM_GetAnyFlareInCone(pos, dir, cone)

	if not flare then return end
	
	local ret = this()
	ret:Configure(flare)
	
	return ret
	
end