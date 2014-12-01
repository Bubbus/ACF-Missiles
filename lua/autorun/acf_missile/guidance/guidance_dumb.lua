
local ClassName = "Dumb"


ACF = ACF or {}
ACF.Guidance = ACF.Guidance or {}

local this = ACF.Guidance[ClassName] or inherit.NewBaseClass()
ACF.Guidance[ClassName] = this

---



this.Name = ClassName


-- function this:Draw(ent, duration)
	-- local Guidance = self:GetGuidance(ent)
	-- debugoverlay.Cross( self.Pos, 12, duration or 0.017, Color(255, 128, 0), false)
-- end


function this:Init()
	
end


function this:Configure(missile)

end


function this:GetGuidance(missile)
	return {}
end


