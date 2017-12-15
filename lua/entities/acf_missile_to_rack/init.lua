-- init.lua

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include('shared.lua')




function ENT:Initialize()
    
    self.CacheRackSpawn = true
      
end




function ENT:Think()
	
    if self.CacheRackSpawn then
    
        local pos = self:GetPos()
        local ang = self:GetAngles()
    
        self:Remove()
        
        
        local rackId = self.RackID
        
        if not (rackId and ACF.Weapons.Rack[rackId]) then
            local GunClass = ACF.Weapons.Guns[self.Id]
            
            if not GunClass then 
                error("Couldn't spawn the missile rack: can't find the gun-class '" + tostring(self.Id) + "'.")
            end
            
            if not GunClass.rack then
                error("Couldn't spawn the missile rack: '" + tostring(self.Id) + "' doesn't have a preferred missile rack.")
            end
            
            rackId = GunClass.rack
        end
        
        
        MakeACF_Rack(self.Owner, pos, ang, rackId)
        
    end
    
end




function ENT:UpdateTransmitState()

	return TRANSMIT_NEVER

end




function MakeACF_MissileToRack(owner, pos, ang, id, rackid)
    
    if not owner:CheckLimit("_acf_gun") then return false end
	
	local converter = ents.Create("acf_missile_to_rack")
	
	if not converter:IsValid() then return false end
	converter:SetAngles(ang)
	converter:SetPos(pos)

    converter.Id = id
    converter.Owner = owner
    converter.RackID = rackid
    
	converter:Spawn()
    
    -- Requires physics so acfmenu doesn't break.  Otherwise this could be a point entity.
    converter:SetModel("models/props_junk/popcan01a.mdl")
    converter:PhysicsInit( SOLID_VPHYSICS )      	
    converter:SetMoveType( MOVETYPE_VPHYSICS )     	
	converter:SetSolid( SOLID_VPHYSICS )
    
    return converter
    
end




list.Set( "ACFCvars", "acf_missile_to_rack", {"id", "data9"} )
duplicator.RegisterEntityClass("acf_missile_to_rack", MakeACF_MissileToRack, "Pos", "Angle", "Id" )
