
local ClassName = "Contact"


ACF = ACF or {}
ACF.Fuse = ACF.Fuse or {}

local this = ACF.Fuse[ClassName] or inherit.NewBaseClass()
ACF.Fuse[ClassName] = this

---



this.Name = ClassName

this.desc = "This fuse triggers upon direct contact against solid surfaces."


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
	return false
end


