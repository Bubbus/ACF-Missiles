
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

CreateConVar('sbox_max_acf_grenade', 20)




function ENT:Initialize()
	
	self.BulletData = {}	
	self.SpecialDamage = true	--If true needs a special ACF_OnDamage function
	self.ShouldTrace = false
	
	self.Model = "models/missiles/aim54.mdl"
	self:SetModelEasy(self.Model)
	
	self.Inputs = Wire_CreateInputs( self, { "Detonate" } )
	self.Outputs = Wire_CreateOutputs( self, {} )
	
	self.ThinkDelay = 0.1
	
	self.TraceFilter = {self}
	--self.ACF_HEIgnore = true
	
end



local nullhit = {Damage = 0, Overkill = 1, Loss = 0, Kill = false}
function ENT:ACF_OnDamage( Entity , Energy , FrAera , Angle , Inflictor )
	self.ACF.Armour = 0.1
	local HitRes = ACF_PropDamage( Entity , Energy , FrAera , Angle , Inflictor )	--Calling the standard damage prop function
	if self.Detonated then return table.Copy(nullhit) end
	
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




function MakeACF_Grenade(Owner, Pos, Angle, Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10, Mdl)

	if not Owner:CheckLimit("_acf_grenade") then return false end
	

	local weapon = ACF.Weapons.Guns[Data1]

	local Bomb = ents.Create("acf_grenade")
	if not Bomb:IsValid() then return false end
	Bomb:SetAngles(Angle)
	Bomb:SetPos(Pos)
	Bomb:Spawn()
	Bomb:SetPlayer(Owner)
	Bomb:SetOwner(Owner)
	Bomb.Owner = Owner
	
	
	Mdl = Mdl or ACF.Weapons.Guns[Id].model
	
	Bomb.Id = Id
	Bomb:CreateBomb(Data1, Data2, Data3, Data4, Data5, Data6, Data7, Data8, Data9, Data10, Mdl)
	
	Owner:AddCount( "_acf_grenade", Bomb )
	Owner:AddCleanup( "acfmenu", Bomb )
	
	return Bomb
end
list.Set( "ACFCvars", "acf_grenade", {"id", "data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10", "mdl"} )
duplicator.RegisterEntityClass("acf_grenade", MakeACF_Grenade, "Pos", "Angle", "RoundId", "RoundType", "RoundPropellant", "RoundProjectile", "RoundData5", "RoundData6", "RoundData7", "RoundData8", "RoundData9", "RoundData10", "Model" )




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
	
	local PlayerData = bdata or 
	{
		Id 		= self.RoundId,
		Type 	= self.RoundType,
		PropLength = self.RoundPropellant,
		ProjLength = self.RoundProjectile,
		Data5 	= self.RoundData5,
		Data6 	= self.RoundData6,
		Data7 	= self.RoundData7,
		Data8 	= self.RoundData8,
		Data9 	= self.RoundData9,
		Data10 	= self.RoundData10
	}
	
	local guntable = ACF.Weapons.Guns
	local gun = guntable[self.RoundId] or {}
	self:ConfigBulletDataShortForm(PlayerData)
	
end




function ENT:SetModelEasy(mdl)
	local curMdl = self:GetModel()
	
	if not mdl or curMdl == mdl or not Model(mdl) then
		self.Model = self:GetModel()
		return 
	end
	
	mdl = Model(mdl)
	
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

	if not (bdata.IsShortForm or bdata.Data5) then error("acf_grenade requires short-form bullet-data but was given expanded bullet-data.") print(bdata) end
	
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

	//print("done")
	//pbn(bdata)
	
	self:ConfigBulletDataShortForm(bdata)
end




function ENT:ConfigBulletDataShortForm(bdata)
	bdata = ACF_ExpandBulletData(bdata)
	
	self.BulletData = bdata
	self.BulletData.Entity = self
	self.BulletData.Crate = self:EntIndex()
	self.BulletData.Owner = self.Owner
	
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




function ENT:Detonate()
	
	if self.Detonated then return end
	
	self.Detonated = true
	
	local bdata = self.BulletData
	local phys = self:GetPhysicsObject()
	local pos = self:GetPos()
	
	
	local up = self:GetUp()
	
	local phyvel = phys and phys:GetVelocity() or Vector(0, 0, 1000)
	bdata.Flight = Vector(0, 0, math.max(bdata.MuzzleVel * 39.37, 10000))--phyvel
	bdata.Pos = pos + bdata.Flight:GetNormalized() * 3
	bdata.Owner = self.Owner
	bdata.NoOcc = self
	
	//pbn(bdata)
	
	--print(tostring(bdata.RoundMass), tostring(bdata.ProjMass))
	
	bdata.RoundMass = bdata.RoundMass or bdata.ProjMass
	bdata.ProjMass = bdata.ProjMass or bdata.RoundMass 
	
	bdata.HandlesOwnIteration = nil
	
	--print(tostring(bdata.RoundMass), tostring(bdata.ProjMass))
	--print(bdata.Crate, Entity(bdata.Crate))
	
	
	ACF_BulletLaunch(bdata)
	--pbn(bdata)
	
	timer.Simple(1, function() if IsValid(self) then self:Remove() end end)
	
	--self:SetCollisionGroup( COLLISION_GROUP_IN_VEHICLE )
	--print("solid")
	self:SetSolid(SOLID_NONE)
	self:SetPos(Vector(0,0,0))
	phys:EnableMotion(false)
	
	self:DoReplicatedPropHit(bdata)
	
	--ACF.RoundTypes[bdata.Type]["endflight"]( bdata.Index, bdata, pos, up )
	--ACF_BulletClient( bdata.Index, bdata, "Update", 1, pos )
	-- end)
	--ACFGrenades[#ACFGrenades+1] = bdata
	
	bdata.SimPos = pos
	bdata.SimFlight = phyvel
	
	//ACF.RoundTypes[bdata.Type]["endeffect"]( nil, bdata)

end




function ENT:DoReplicatedPropHit(Bullet)

	local FlightRes = { Entity = self, HitNormal = Bullet.Flight, HitPos = Bullet.Pos, HitGroup = HITGROUP_GENERIC }
	local Index = Bullet.Index
	
	ACF_BulletPropImpact = ACF.RoundTypes[Bullet.Type]["propimpact"]		
	local Retry = ACF_BulletPropImpact( Index, Bullet, FlightRes.Entity , FlightRes.HitNormal , FlightRes.HitPos , FlightRes.HitGroup )				--If we hit stuff then send the resolution to the damage function	
	
	if Retry == "Penetrated" then		--If we should do the same trace again, then do so
		--print("a")
		if Bullet.OnPenetrated then Bullet.OnPenetrated(Index, Bullet, FlightRes) end
		ACF_BulletClient( Index, Bullet, "Update" , 2 , FlightRes.HitPos  )
		ACF_CalcBulletFlight( Index, Bullet, true )
	elseif Retry == "Ricochet"  then
		--print("b")
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




--local undonked = true
function ENT:OnTraceContact(trace)
	/*
	if undonked then
		print("donk!")
		printByName(trace)
		undonked = false
	end
	//*/
end



function ENT:SetShouldTrace(bool)
	self.ShouldTrace = bool and true
	--print(self.ShouldTrace)
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
	-- self:SetNetworkedString("RoundId", self.RoundId)
	-- self:SetNetworkedString("RoundType", self.RoundType)
	-- self:SetNetworkedFloat("FillerVol", self.RoundData5)
	
	-- local col = self.BulletData.Colour or Color(255, 255, 255)
	-- self:SetNetworkedVector( "TracerColour",  Vector(col.r, col.g, col.b))
	
	ACF_MakeCrateForBullet(self, self.BulletData)
	
end