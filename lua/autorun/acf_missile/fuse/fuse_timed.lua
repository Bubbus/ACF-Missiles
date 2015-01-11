
local ClassName = "Timed"


ACF = ACF or {}
ACF.Fuse = ACF.Fuse or {}

local this = ACF.Fuse[ClassName] or inherit.NewSubOf(ACF.Fuse.Contact)
ACF.Fuse[ClassName] = this

---



this.Name = ClassName

-- Time to explode, begins ticking after configuration.
this.Timer = 10


this.desc = "This fuse triggers upon direct contact, or when the timer ends."


-- function this:Draw(ent, duration)
	-- local Guidance = self:GetGuidance(ent)
	-- debugoverlay.Cross( self.Pos, 12, duration or 0.017, Color(255, 128, 0), false)
-- end


function this:Init()
	self.TimeStarted = nil
end


function this:Configure(missile, guidance)
    self.TimeStarted = CurTime()
end


function this:GetDetonate(missile, guidance)
	return self.TimeStarted + self.Timer <= CurTime()
end


