
local ClassName = "Optical"


ACF = ACF or {}
ACF.Fuse = ACF.Fuse or {}

local this = ACF.Fuse[ClassName] or inherit.NewSubOf(ACF.Fuse.Contact)
ACF.Fuse[ClassName] = this

---



this.Name = ClassName


this.Distance = 2000


this.desc = "This fuse fires a beam directly ahead and detonates when the beam hits something close-by."


this.Configurable = 
{
    {
        name = "Distance",
        displayName = "Distance",
        cmdName = "Ds",
        
        min = 0,
        max = 10000
    }
}
-- function this:Draw(ent, duration)
	-- local Guidance = self:GetGuidance(ent)
	-- debugoverlay.Cross( self.Pos, 12, duration or 0.017, Color(255, 128, 0), false)
-- end


function this:Init()
	
end


function this:Configure(missile, guidance)

end


-- Do nothing, projectiles auto-detonate on contact anyway.
function this:GetDetonate(missile, guidance)
	
    local missilePos = missile:GetPos()
    
    local tracedata = 
    {
        start = missilePos,
        endpos = missilePos + missile:GetForward() * self.Distance,
        filter = missile.Filter or missile
    }
	local trace = util.TraceLine(tracedata)

	return trace.Hit
    
end


