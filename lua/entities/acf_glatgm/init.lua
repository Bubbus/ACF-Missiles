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
	
	timer.Simple(0.1,function() ParticleEffectAttach("Rocket_Smoke_Trail",4, self,1)  end)
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:EnableGravity( false )
	self.PhysObj:EnableMotion( false )
	self.KillTime = CurTime()+20
	self.Time = CurTime()

	for k, v in pairs( ents.FindInSphere( self.Guidance:GetPos(), 250 )   ) do
		if v:GetClass() == "acf_opticalcomputer" and v:CPPIGetOwner() == self.Owner then
			self.Guidance = v
			self.Optic = true
		end
	end

end


















function ENT:Think()
	if(IsValid(self)) then
			if self.KillTime<CurTime() then
				self:Detonate()
			end
			local TimeNew = CurTime()
			self:SetPos(self:LocalToWorld(Vector((1800.2)*(TimeNew - self.Time),0,0)))
			local d = Vector(0,0,0)
			local dir = AngleRand()*0.01
			if IsValid(self.Guidance) and self.Guidance:GetPos():Distance(self:GetPos())<self.Distance then
				local di = self.Guidance:WorldToLocalAngles((self:GetPos() - self.Guidance:GetPos()):Angle())
				if di.p<5 and di.p>-5 and di.y<5 and di.y>-5 then
					local glpos = self.Guidance:GetPos()
					if !self.Optic then
						glpos = self.Guidance:GetAttachment(1).Pos
					end

					local tr = util.QuickTrace( glpos+self.Guidance:GetForward()*20, self.Guidance:GetForward()*99999, {self.Guidance,self}) 
					d = (self:GetPos() - tr.HitPos)
					dir = self:WorldToLocalAngles(d:Angle())*0.005
				end
			end
			local Dist = d:Length()/39.37/1000
		

			self:SetAngles(self:LocalToWorldAngles(-dir+Angle(0,0,math.Round(math.random(-15,15)))+(AngleRand()*(Dist)*0.05)))
			local tr = util.QuickTrace( self:GetPos(), self:GetForward()*100, {self,self.Entity}) 
			
			self.Time = TimeNew
			if(tr.Hit)then
				self:Detonate()
			end

		self:NextThink( CurTime() + 0.0001 )
		return true
	end
end


function ENT:OnRemove()

	self:Detonate()

end


function ENT:Detonate()
	local Radius = (self.BulletData.FillerMass)*10
	local Flash = EffectData()
	Flash:SetOrigin( self:GetPos() )
	Flash:SetNormal( self:GetForward() )
	Flash:SetRadius( math.max( Radius, 100 ) )
	util.Effect( "shaped_charge", Flash )
	local Radius = (self.BulletData.FillerMass)^0.33*8*39.37
	local Flash = EffectData()
	Flash:SetOrigin( self:GetPos() )
	Flash:SetNormal( self:GetForward() )
	Flash:SetRadius( math.max( Radius, 1 ) )
	
	
	
	
	util.Effect( "ACF_Scaled_Explosion", Flash )
	btdat = {}
	
	btdat["Accel"]	= Vector(0,0,-600)
	btdat["BoomPower"]		= self.BulletData.BoomPower
	btdat["Caliber"]	= self.BulletData.Caliber
	btdat["Crate"]	= self.BulletData.Crate
	btdat["DragCoef"]	= self.BulletData.DragCoef
	btdat["FillerMass"]		= self.BulletData.FillerMass
	btdat["Filter"]	= self
	btdat["Flight"]	= self.BulletData.Flight
	btdat["FlightTime"]		= 0
	btdat["FrAera"]	= self.BulletData.FrAera
	btdat["FuseLength"]		= 0
	btdat["Gun"]		= self
	btdat["Id"]		= self.BulletData.Id
	btdat["KETransfert"]		= self.BulletData.KETransfert
	btdat["LimitVel"]	= 700
	btdat["MuzzleVel"]		= self.BulletData.MuzzleVel*20
	btdat["Owner"]	= self.BulletData.Owner
	btdat["PenAera"]	= self.BulletData.PenAera
	btdat["Pos"]		= self.BulletData.Pos
	btdat["ProjLength"]		= self.BulletData.ProjLength
	btdat["ProjMass"]	= self.BulletData.ProjMass
	btdat["PropLength"]		= self.BulletData.PropLength
	btdat["PropMass"]	= self.BulletData.PropMass
	btdat["Ricochet"]	= self.BulletData.Ricochet
	btdat["RoundVolume"]		= self.BulletData.RoundVolume
	btdat["ShovePower"]		= self.BulletData.ShovePower
	btdat["Tracer"]	= 0
	
	


	btdat["SlugMass"]	= self.BulletData.SlugMass
	btdat["SlugCaliber"]		= self.BulletData.SlugCaliber
	btdat["SlugDragCoef"]		= self.BulletData.SlugDragCoef
	btdat["SlugMV"]	= self.BulletData.SlugMV
	btdat["SlugPenAera"]		= self.BulletData.SlugPenAera
	btdat["SlugRicochet"]		= self.BulletData.SlugRicochet
	btdat["ConeVol"] = self.BulletData.SlugMass*1000/7.9
	btdat["CasingMass"] = btdat.ProjMass + btdat.FillerMass + (btdat.ConeVol*1000/7.9)
	btdat["BoomFillerMass"] = btdat.FillerMass
	
	
	btdat["Flight"] = self:GetForward():GetNormalized() * btdat["MuzzleVel"] * 39.37
	btdat["Type"]		= "HEAT" 
	
	self.FakeCrate = ents.Create("acf_fakecrate2")


	self.FakeCrate:RegisterTo(btdat)
		
	btdat["Crate"] = self.FakeCrate:EntIndex()
	btdat.Pos = self:GetPos()
	self.CreateShell = ACF.RoundTypes[btdat.Type].create
	self:CreateShell( btdat )
	
	
	
	
	
	self:Remove()





end