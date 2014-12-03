
local ClassName = "Radio"


ACF = ACF or {}
ACF.Fuse = ACF.Fuse or {}

local this = ACF.Fuse[ClassName] or inherit.NewSubOf(ACF.Fuse.Contact)
ACF.Fuse[ClassName] = this

---



this.Name = ClassName

-- The entity to measure distance to.
this.Target = nil

-- the fuse may trigger at some point under this range - unless it's travelling so fast that it steps right on through.
this.Distance = 2000


-- function this:Draw(ent, duration)
	-- local Guidance = self:GetGuidance(ent)
	-- debugoverlay.Cross( self.Pos, 12, duration or 0.017, Color(255, 128, 0), false)
-- end


function this:Init()
	
end




function this:Configure(missile, guidance)

end




function this:GetDetonate(missile, guidance)
	
    local target = guidance.TargetPos or guidance:GetGuidance(missile).TargetPos
    
	if not target then return false end
	if missile:GetPos():Distance(target) > self.Distance then return false end
    
    return true
    
end

