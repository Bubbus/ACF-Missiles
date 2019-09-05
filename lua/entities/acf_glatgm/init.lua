AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize()

	if self.BulletData.Caliber == 12.0 then
	self:SetModel( "models/missiles/glatgm/9m112.mdl" )
	elseif self.BulletData.Caliber > 12.0 then
	self:SetModel( "models/missiles/glatgm/mgm51.mdl" )
	else
	self:SetModel( "models/missiles/glatgm/9m117.mdl" )
	self:SetModelScale(self.BulletData.Caliber*10/100,0)

	end
	self:SetMoveType(MOVETYPE_VPHYSICS);
	self:PhysicsInit(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);
	self:SetSolid(SOLID_VPHYSICS);
	self:SetCollisionGroup( COLLISION_GROUP_WORLD ) -- DISABLES collisions with players/props
	
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:EnableGravity( false )
	self.PhysObj:EnableMotion( false )
	
	timer.Simple(0.1,function()
		self:SetCollisionGroup( COLLISION_GROUP_NONE ) -- ENABLES collisions with players/props
		ParticleEffectAttach("Rocket Motor GLATGM",4, self,1)
		end )
	
	self.KillTime = CurTime()+20
	self.Time = CurTime()
	self.Filter = {self,self.Entity,self.Guidance}
	for k, v in pairs( ents.FindInSphere( self.Guidance:GetPos(), 250 )   ) do
		if v:GetClass() == "acf_opticalcomputer" and (not v.CPPIGetOwner or v:CPPIGetOwner() == self.Owner) then
			self.Guidance = v
			self.Optic = true
			break
		end
	end

	self.velocity = 5000 		--self.velocity of the missile per second
	self.secondsOffset = 0.5	--seconds of forward flight to aim towards, to affect the beam-riding simulation
	
	self.Sub = self.BulletData.Caliber<10 -- is it a small glatgm?
	if self.Sub then 
		self.velocity = 2500
		self.secondsOffset = 0.25
		self.SpiralAm = (10-self.BulletData.Caliber)*0.5 -- amount of artifical spiraling for <100 shells, caliber in acf is in cm
	end
	
	self.offsetLength = self.velocity * self.secondsOffset	--how far off the forward offset is for the targeting position
	
end


function ENT:Think()
	if(IsValid(self)) then
			
			if self.KillTime<CurTime() then
				self:Detonate()
			end
			local TimeNew = CurTime()
			
			local d = Vector(0,0,0)
			local dir = AngleRand()*0.01
			local Dist = 0.01--100/10000
			if IsValid(self.Guidance) and self.Guidance:GetPos():Distance(self:GetPos())<self.Distance then
				local di = self.Guidance:WorldToLocalAngles((self:GetPos() - self.Guidance:GetPos()):Angle())
				if di.p<15 and di.p>-15 and di.y<15 and di.y>-15 then
					local glpos = self.Guidance:GetPos()+self.Guidance:GetForward()
					if not self.Optic then
						glpos = self.Guidance:GetAttachment(1).Pos+self.Guidance:GetForward()*20
					end

					local tr = util.QuickTrace( glpos, self.Guidance:GetForward()*(self.Guidance:GetPos():Distance(self:GetPos())+self.offsetLength), {self.Guidance,self,self.Entity})
	--				local tr = util.QuickTrace( glpos, self.Guidance:GetForward()*99999, {self.Guidance,self,self.Entity}) --outdated
					d = ( tr.HitPos - self:GetPos())
					dir = self:WorldToLocalAngles(d:Angle())*0.02 --0.01 controls agility but is not scaled to timestep; bug poly
					 Dist = self.Guidance:GetPos():Distance(self:GetPos())/39.37/10000
				end
			end
			local Spiral = d:Length()/39370 or 0.5
			if self.Sub then
				Spiral = self.SpiralAm + (math.random(-self.SpiralAm*0.5,self.SpiralAm) )--Spaghett
			end
			local Inacc = math.random(-1,1)*Dist
			self:SetAngles(self:LocalToWorldAngles(dir+Angle(Inacc,-Inacc,5)))
			self:SetPos(self:LocalToWorld(Vector((self.velocity)*(TimeNew - self.Time),Spiral,0)))
			local tr = util.QuickTrace( self:GetPos()+self:GetForward()*-28, self:GetForward()*((self.velocity)*(TimeNew - self.Time)+300), self.Filter) 
			
			self.Time = TimeNew
			if(tr.Hit)then
				self:Detonate()
			end

		self:NextThink( CurTime() + 0.015 )
		return true
	end
end



function ENT:Detonate()
	if IsValid(self) and !self.Detonated then
		self.Detonated = true
		
		local Flash = EffectData()
		Flash:SetOrigin( self:GetPos() )
		Flash:SetNormal( self:GetForward() )
		Flash:SetRadius((self.BulletData.FillerMass)^0.33*8*39.37/5 )
		util.Effect( "ACF_Scaled_Explosion", Flash )
		
		btdat = table.Copy(self.BulletData)
		btdat["Type"]		= "HEAT" 
		btdat["Filter"]	= {self,self.Entity}
		btdat["FlightTime"]		= 0
		btdat["Gun"]		= self
		btdat["LimitVel"]	= 100
		btdat["Flight"] = self:GetForward():GetNormalized() * self.velocity -- initial vel from glatgm
		btdat.FuseLength = 0
		btdat.Pos = self:GetPos()
		
		--btdat.InitTime = SysTime()
		-- manual detonation
		btdat.Detonated = true
		btdat.InitTime = SysTime()
		btdat.Flight = btdat.Flight + btdat.Flight:GetNormalized() * btdat.SlugMV * 39.37
		btdat.FuseLength = 0.005 + 40/((btdat.Flight + btdat.Flight:GetNormalized() * btdat.SlugMV * 39.37):Length()*0.0254)
		btdat.DragCoef = btdat.SlugDragCoef
		btdat.ProjMass = btdat.SlugMass
		btdat.Caliber = btdat.SlugCaliber
		btdat.PenAera = btdat.SlugPenAera
		btdat.Ricochet = btdat.SlugRicochet
		
		
		self.FakeCrate = ents.Create("acf_fakecrate2")
		self.FakeCrate:RegisterTo(btdat)
		self:DeleteOnRemove(self.FakeCrate) 
		btdat["Crate"] = self.FakeCrate:EntIndex()
		
		self.CreateShell = ACF.RoundTypes[btdat.Type].create
		self:CreateShell( btdat )
		
		self:Remove()
		
		ACF_HE( btdat.Pos, -btdat.Flight:GetNormalized() , btdat.BoomFillerMass , btdat.CasingMass , btdat.Owner )

	end

end
