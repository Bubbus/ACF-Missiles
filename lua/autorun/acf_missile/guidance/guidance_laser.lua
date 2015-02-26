
local ClassName = "Laser"


ACF = ACF or {}
ACF.Guidance = ACF.Guidance or {}

local this = ACF.Guidance[ClassName] or inherit.NewSubOf(ACF.Guidance.Wire)
ACF.Guidance[ClassName] = this

---



this.Name = ClassName

-- Cone to retain targets within.
this.ViewCone = 30

-- An entity with a Position wire-output
this.InputSource = nil

this.desc = "This guidance package reads a target-position from the launcher and guides the munition towards it."




function this:Init()
	
end




function this:Configure(missile)
    
    self:super():Configure(missile)
    
    self.ViewCone = ACF_GetGunValue(missile.BulletData, "seekcone") or this.ViewCone
    
end




function this:GetGuidance(missile)

    local posVec = self:GetWireTarget()
    
    if not posVec or posVec == Vector() then
        return {} 
    end
    
    
    local launcher = missile.Launcher

	if IsValid(launcher) then

		local mfo       = missile:GetForward()
		local mdir      = (posVec - missile:GetPos()):GetNormalized()
		local dot       = mfo.x * mdir.x + mfo.y * mdir.y + mfo.z * mdir.z
		local maxAng    = math.cos(math.rad(self.ViewCone))

		if dot < maxAng then return {} end
	end
	
    self.TargetPos = posVec
	return {TargetPos = posVec}
	
end

