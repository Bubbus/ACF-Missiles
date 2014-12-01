include("shared.lua")





function ENT:Initialize()
	self.Entity:SetModel( "models/missiles/aim9.mdl" )

	local trail = EffectData()
	trail:SetScale( 50 )
	trail:SetMagnitude( 3 )
	trail:SetEntity( self.Entity )
	util.Effect( "cre_rpg_trail", trail )
end



function ENT:Draw()
	self.Entity:DrawModel() 
end



function ENT:OnRemove()
	if GetConVarNumber("shellshock_enabled") <= 0 then return end

	local ply = LocalPlayer()
	local Pos = self:GetPos()

	if !IsValid(ply) then return end

	local ShootPos = ply:GetShootPos()

	if (ShootPos - Pos):Length() < 300 then
		TriggerShellshockFx( 2 )
	end
end