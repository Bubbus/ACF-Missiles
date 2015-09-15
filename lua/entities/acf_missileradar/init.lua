
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

CreateConVar('sbox_max_acf_missileradar', 6)




function ENT:Initialize()
	
	self.BaseClass.Initialize(self)
	
	self.Inputs = WireLib.CreateInputs( self, { "Active" } )
	self.Outputs = WireLib.CreateOutputs( self, {"Detected", "Position [ARRAY]", "Velocity [ARRAY]"} )
	
	self.ThinkDelay = 0.05
	self.StatusUpdateDelay = 0.5
	self.LastStatusUpdate = CurTime()
	
	self.LegalMass = self.Weight or 0
	
	self.Active = false
	
	self:CreateRadar((self.ACFName or "Missile Radar"), (self.ConeDegs or 0))
	
	self:EnableClientInfo(true)
	
end




function ENT:TriggerInput( inp, value )
	if inp == "Active" then
		self.Active = (value ~= 0)
	end
end




function MakeACF_MissileRadar(Owner, Pos, Angle, Id)

	if not Owner:CheckLimit("_acf_missileradar") then return false end

	local weapon = ACF.Weapons.Guns[Data1]

	local radar = ACF.Weapons.Radar[Id]
	
	if not radar then return false end
	
	local Radar = ents.Create("acf_missileradar")
	if not Radar:IsValid() then return false end
	Radar:SetAngles(Angle)
	Radar:SetPos(Pos)
	
	Radar.Model = radar.model
	Radar.Weight = radar.weight
	Radar.ACFName = radar.name
	Radar.ConeDegs = radar.viewcone
	Radar.Id = Id
	
	Radar:Spawn()
	Radar:SetPlayer(Owner)
	
	if CPPI then
		Radar:CPPISetOwner(Owner)
	end
	
	Radar.Owner = Owner
	
	Radar:SetModelEasy(radar.model)
	
	Owner:AddCount( "_acf_missileradar", Radar )
	Owner:AddCleanup( "acfmenu", Radar )
	
	return Radar
	
end
list.Set( "ACFCvars", "acf_missileradar", {"id"} )
duplicator.RegisterEntityClass("acf_missileradar", MakeACF_MissileRadar, "Pos", "Angle", "Id" )




function ENT:CreateRadar(Id, ConeDegs)
	
	self.ConeDegs = ConeDegs
	self.Id = Id
	
	self:RefreshClientInfo()
	
end




function ENT:RefreshClientInfo()

	self:SetNWFloat("ConeDegs", self.ConeDegs)
	self:SetNWString("Id", self.Id)
	self:SetNWString("Name", self.ACFName)

end




function ENT:SetModelEasy(mdl)

	local Rack = self
	
	Rack:SetModel( mdl )	
	Rack.Model = mdl
	
	Rack:PhysicsInit( SOLID_VPHYSICS )      	
	Rack:SetMoveType( MOVETYPE_VPHYSICS )     	
	Rack:SetSolid( SOLID_VPHYSICS )
	
	local phys = Rack:GetPhysicsObject()  	
	if (phys:IsValid()) then 
		phys:SetMass(Rack.Weight)
	end 	
	
end




function ENT:Think()
 	
	if self.Inputs.Active.Value ~= 0 and self:AllowedToScan() then
		self:ScanForMissiles()
	else
		self:ClearOutputs()
	end
	
	local curTime = CurTime()
	
	self:NextThink(curTime + self.ThinkDelay)
	
	if (self.LastStatusUpdate + self.StatusUpdateDelay < curTime) then
		self:UpdateStatus()
		self.LastStatusUpdate = curTime
	end
	
	return true
		
end




function ENT:UpdateStatus()

	local phys = self.Entity:GetPhysicsObject()  	
	if not IsValid(phys) then 
		self:SetNetworkedBool("Status", "Physics error, please respawn this") 
		return 
	end

	if phys:GetMass() < self.LegalMass then
		self:SetNetworkedBool("Status", "Illegal mass, should be " .. self.LegalMass .. " kg") 
		return 
	end
	
	if IsValid(self:GetParent()) then
		self:SetNetworkedBool("Status", "Deactivated: parenting is disallowed") 
		return 
	end
	
	if not self.Active then
		self:SetNetworkedBool("Status", "Inactive")
	elseif self.Outputs.Detected.Value > 0 then
		self:SetNetworkedBool("Status", self.Outputs.Detected.Value .. " objects detected!")
	else
		self:SetNetworkedBool("Status", "Active")
	end

end




function ENT:AllowedToScan()

	if not self.Active then return false end

	local phys = self.Entity:GetPhysicsObject()  	
	if not IsValid(phys) then print("invalid phys") return false end
	
	return ( phys:GetMass() == self.LegalMass ) and ( not IsValid(self:GetParent()) )

end




function ENT:ScanForMissiles()

	local missiles = ACFM_GetMissilesInCone(self:GetPos(), self:GetForward(), self.ConeDegs)
	
	local posArray = {}
	local velArray = {}
	
	local i = 0
	
	for k, missile in pairs(missiles) do
	
		--print("got missile", missile)
		i = i + 1
	
		posArray[i] = missile.CurPos
		velArray[i] = missile.LastVel
	
	end
	
	WireLib.TriggerOutput( self, "Detected", i )
	WireLib.TriggerOutput( self, "Position", posArray )
	WireLib.TriggerOutput( self, "Velocity", velArray )

end




function ENT:ClearOutputs()

	if #self.Outputs.Position.Value > 0 then
		WireLib.TriggerOutput( self, "Position", {} )
	end
	
	if #self.Outputs.Velocity.Value > 0 then
		WireLib.TriggerOutput( self, "Velocity", {} )
	end

end




function ENT:EnableClientInfo(bool)
	self.ClientInfo = bool
	self:SetNetworkedBool("VisInfo", bool)
	
	if bool then
		self:RefreshClientInfo()
	end
end

