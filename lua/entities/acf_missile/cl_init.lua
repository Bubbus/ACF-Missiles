include("shared.lua")





function ENT:Initialize()

end



function ENT:Draw()

	self:DrawModel() 
	
	if self:GetNWFloat("LightSize") and self:CanEmitLight() then	
		self:RenderMotorLight()
	end
	
end




function ENT:CanEmitLight()

	local minLightSize = GetConVar("ACFM_MissileLights"):GetFloat()
	
	if minLightSize == 0 then return false end
	if minLightSize == 1 then return true end
	
	local thisLightSize = self:GetNWFloat("LightSize")
	
	return minLightSize < thisLightSize

end




function ENT:RenderMotorLight()

	local dlight = DynamicLight( self:EntIndex() )

	if ( dlight ) then
		
		local size = self:GetNWFloat("LightSize") * 20
		local c = Color(255, 128, 48)

		dlight.Pos = self:GetPos() - self:GetForward() * 64
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = 7 + math.random() * 3
		dlight.Decay = size * 5
		dlight.Size = size * 0.66 + math.random() * (size * 0.33)
		dlight.DieTime = CurTime() + 1

	end

end
