
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

CreateConVar('sbox_max_acf_explosive', 20)




function ENT:Initialize()
    
	self.BulletData = self.BulletData or {}	
	self.SpecialDamage = true	--If true needs a special ACF_OnDamage function
	self.ShouldTrace = false
	
	self.Inputs = Wire_CreateInputs( self, { "Detonate" } )
	self.Outputs = Wire_CreateOutputs( self, {} )
	
	self.ThinkDelay = 0.1
	
	self.TraceFilter = {self}

end



local nullhit = {Damage = 0, Overkill = 1, Loss = 0, Kill = false}
function ENT:ACF_OnDamage( Entity , Energy , FrAera , Angle , Inflictor )
	self.ACF.Armour = 0.1
	local HitRes = ACF_PropDamage( Entity , Energy , FrAera , Angle , Inflictor )	--Calling the standard damage prop function
	if self.Detonated or self.DisableDamage then return table.Copy(nullhit) end
	
	local CanDo = hook.Run("ACF_AmmoExplode", self, self.BulletData )
	if CanDo == false then return table.Copy(nullhit) end
	
	HitRes.Kill = false
	self:Detonate()
	
	return table.Copy(nullhit) --This function needs to return HitRes
end




function ENT:TriggerInput( inp, value )
	if inp == "Detonate" and value ~= 0 then
		self:Detonate()
	end
end




function MakeACF_Explosive(Owner, Pos, Angle, Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10, Mdl)

	if not Owner:CheckLimit("_acf_explosive") then return false end
	

	local weapon = ACF.Weapons.Guns[Data1]

	local Bomb = ents.Create("acf_explosive")
	if not Bomb:IsValid() then return false end
	Bomb:SetAngles(Angle)
	Bomb:SetPos(Pos)
	Bomb:Spawn()
	Bomb:SetPlayer(Owner)
	
	if CPPI then
		Bomb:CPPISetOwner(Owner)
	end
	
	Bomb.Owner = Owner
	
	
	Mdl = Mdl or ACF.Weapons.Guns[Id].model
	
	Bomb.Id = Id
	Bomb:CreateBomb(Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10, Mdl)
	
	Owner:AddCount( "_acf_explosive", Bomb )
	Owner:AddCleanup( "acfmenu", Bomb )
	
	return Bomb
end
list.Set( "ACFCvars", "acf_explosive", {"id", "data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10", "mdl"} )
duplicator.RegisterEntityClass("acf_explosive", MakeACF_Explosive, "Pos", "Angle", "RoundId", "RoundType", "RoundPropellant", "RoundProjectile", "RoundData5", "RoundData6", "RoundData7", "RoundData8", "RoundData9", "RoundData10", "Model" )




function ENT:CreateBomb(Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10, Mdl, bdata)

	self:SetModelEasy(Mdl)
	--Data 1 to 4 are should always be Round ID, Round Type, Propellant lenght, Projectile lenght
	self.RoundId 	= Data1		--Weapon this round loads into, ie 140mmC, 105mmH ...
	self.RoundType 	= Data2		--Type of round, IE AP, HE, HEAT ...
	self.RoundPropellant = Data3--Lenght of propellant
	self.RoundProjectile = Data4--Lenght of the projectile
	self.RoundData5 = ( Data5 or 0 )
	self.RoundData6 = ( Data6 or 0 )
	self.RoundData7 = ( Data7 or 0 )
	self.RoundData8 = ( Data8 or 0 )
	self.RoundData9 = ( Data9 or 0 )
	self.RoundData10 = ( Data10 or 0 )
	
	local PlayerData = bdata or ACFM_CompactBulletData(self)
	
	local guntable = ACF.Weapons.Guns
	local gun = guntable[self.RoundId] or {}
	self:ConfigBulletDataShortForm(PlayerData)
	
end




function ENT:SetModelEasy(mdl)
	local curMdl = self:GetModel()
	
	if not mdl or curMdl == mdl then
		self.Model = self:GetModel()
		return 
	end
	
	self:SetModel( mdl )
	self.Model = mdl
	
	self:PhysicsInit( SOLID_VPHYSICS )      	
	self:SetMoveType( MOVETYPE_VPHYSICS )     	
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )
	
	local phys = self.Entity:GetPhysicsObject()  	
	if (IsValid(phys)) then  		
		phys:Wake()
		phys:EnableMotion(true)
		phys:SetMass( 10 ) 
	end 
end




function ENT:SetBulletData(bdata)

	if not (bdata.IsShortForm or bdata.Data5) then error("acf_explosive requires short-form bullet-data but was given expanded bullet-data.") end
	
    bdata = ACFM_CompactBulletData(bdata)
    
	self:CreateBomb(
		bdata.Data1 or bdata.Id,
		bdata.Type or bdata.Data2,
		bdata.PropLength or bdata.Data3,
		bdata.ProjLength or bdata.Data4,
		bdata.Data5, 
		bdata.Data6, 
		bdata.Data7, 
		bdata.Data8, 
		bdata.Data9, 
		bdata.Data10, 
		nil,
		bdata)
	
	self:ConfigBulletDataShortForm(bdata)
end




function ENT:ConfigBulletDataShortForm(bdata)
	bdata = ACFM_ExpandBulletData(bdata)
	
	self.BulletData = bdata
	self.BulletData.Entity = self
	self.BulletData.Crate = self:EntIndex()
	self.BulletData.Owner = self.BulletData.Owner or self.Owner
	
	local phys = self.Entity:GetPhysicsObject()  	
	if (IsValid(phys)) then  		
		phys:SetMass( bdata.ProjMass or bdata.RoundMass or bdata.Mass or 10 ) 
	end
	
	self:RefreshClientInfo()
end




local trace = {}

function ENT:TraceFunction()
	local pos = self:GetPos()
	trace.start = pos
	trace.endpos = pos + self:GetVelocity() * self.ThinkDelay
	trace.filter = self.TraceFilter

	local res = util.TraceEntity( trace, self ) 
	if res.Hit then
		self:OnTraceContact(res)
	end
end




function ENT:Think()
 	
	if self.ShouldTrace then
		self:TraceFunction()
	end
	
	self:NextThink(CurTime() + self.ThinkDelay)
	
	return true
		
end




function ENT:Detonate(overrideBData)
	
	if self.Detonated then return end
	
	self.Detonated = true
	
	local bdata = overrideBData or self.BulletData
    
	local phys = self:GetPhysicsObject()
	local pos = self:GetPos()
	
	local phyvel = 	phys and phys:GetVelocity() or Vector(0, 0, 1000)
	bdata.Flight = 	bdata.Flight or phyvel
	bdata.Owner = 	bdata.Owner or self.Owner
	bdata.Pos = 	pos + (self.DetonateOffset or bdata.Flight:GetNormalized())
	bdata.NoOcc = 	self
    bdata.Gun =     self
    
    debugoverlay.Line(bdata.Pos, bdata.Pos + bdata.Flight, 10, Color(255, 128, 0))
    
    if bdata.Filter then bdata.Filter[#bdata.Filter+1] = self
    else bdata.Filter = {self} end
	
	bdata.RoundMass = bdata.RoundMass or bdata.ProjMass
	bdata.ProjMass = bdata.ProjMass or bdata.RoundMass 
	
	bdata.HandlesOwnIteration = nil

	
	ACFM_BulletLaunch(bdata)
	timer.Simple(1, function() if IsValid(self) then self:Remove() end end)
	

	self:SetSolid(SOLID_NONE)
	phys:EnableMotion(false)
	
	self:DoReplicatedPropHit(bdata)
	
    self:SetNoDraw(true)

end




function ENT:DoReplicatedPropHit(Bullet)

	local FlightRes = { Entity = self, HitNormal = Bullet.Flight, HitPos = Bullet.Pos, HitGroup = HITGROUP_GENERIC }
	local Index = Bullet.Index
	
	ACF_BulletPropImpact = ACF.RoundTypes[Bullet.Type]["propimpact"]		
	local Retry = ACF_BulletPropImpact( Index, Bullet, FlightRes.Entity , FlightRes.HitNormal , FlightRes.HitPos , FlightRes.HitGroup )				--If we hit stuff then send the resolution to the damage function	
	
	if Retry == "Penetrated" then		--If we should do the same trace again, then do so
		--print("a")
        ACFM_ResetVelocity(Bullet)
        
		if Bullet.OnPenetrated then Bullet.OnPenetrated(Index, Bullet, FlightRes) end
		ACF_BulletClient( Index, Bullet, "Update" , 2 , FlightRes.HitPos  )
		ACF_CalcBulletFlight( Index, Bullet, true )
	elseif Retry == "Ricochet"  then
		--print("b")
        ACFM_ResetVelocity(Bullet)
        
		if Bullet.OnRicocheted then Bullet.OnRicocheted(Index, Bullet, FlightRes) end
		ACF_BulletClient( Index, Bullet, "Update" , 3 , FlightRes.HitPos  )
		ACF_CalcBulletFlight( Index, Bullet, true )
	else						--Else end the flight here
		--print("c")
		if Bullet.OnEndFlight then Bullet.OnEndFlight(Index, Bullet, FlightRes) end
		ACF_BulletClient( Index, Bullet, "Update" , 1 , FlightRes.HitPos  )
		ACF_BulletEndFlight = ACF.RoundTypes[Bullet.Type]["endflight"]
		ACF_BulletEndFlight( Index, Bullet, FlightRes.HitPos, FlightRes.HitNormal )	
	end
	
end




function ENT:OnTraceContact(trace)

end



function ENT:SetShouldTrace(bool)
	self.ShouldTrace = bool and true

	self:NextThink(CurTime())
end




function ENT:EnableClientInfo(bool)
	self.ClientInfo = bool
	self:SetNetworkedBool("VisInfo", bool)
	
	if bool then
		self:RefreshClientInfo()
	end
end



function ENT:RefreshClientInfo()

	ACFM_MakeCrateForBullet(self, self.BulletData)
	
end