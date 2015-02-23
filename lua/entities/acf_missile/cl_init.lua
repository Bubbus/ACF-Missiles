include("shared.lua")





function ENT:Initialize()
	--self.Entity:SetModel( "models/missiles/aim9.mdl" )

	-- local trail = EffectData()
	-- trail:SetScale( 50 )
	-- trail:SetMagnitude( 3 )
	-- trail:SetEntity( self.Entity )
	-- util.Effect( "cre_rpg_trail", trail )
end



function ENT:Draw()
	self.Entity:DrawModel() 
end