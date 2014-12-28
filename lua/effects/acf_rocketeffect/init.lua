PrecacheParticleSystem( "Rocket Motor" )

local DEFAULTMODEL = "models/missiles/70mmffar.mdl"


function EFFECT:Init( data )

	//if not data.BulletData then error("No bulletdata attached to effect data!\n") return end

	self.CreateTime = SysTime()
	self.LastThink = self.CreateTime
	
	self:SetModel("models/missiles/aim54.mdl") 
	
end



local function findParticle(parent)
	local parts = ents.FindByClassAndParent("info_particle_system", parent)
	//PrintTable(parts)
	//for k, v in pairs(parts) do
		//if v:GetParent() == parent then return v end
	//end
	
	//return nil
	return parts[1]
end


function EFFECT:Config(Rocket)

	self.Rocket = Rocket
		
	Rocket.Effect = self.Entity
		
	local rkclass = ACF.Weapons.Guns[Rocket.Id]
		
	self:SetModel(rkclass and rkclass.round and rkclass.round.model or DEFAULTMODEL) 
	//print("rocketmodel", rkclass and rkclass.round and rkclass.round.model or DEFAULTMODEL)
		
	self:SetPos( Rocket.Pos )	--Moving the effect to the calculated position
	self:SetAngles( Rocket.Flight:Angle() )
	
	if not Rocket.Cutout then
		Rocket.Cutout = 1
	end
	
	//*
	if Rocket.Cutout and Rocket.Cutout > 0 then
		/*
		self.Trail = ents.Create( "info_particle_system" )
		self.Trail:SetPos(self.Entity:GetPos())
		self.Trail:SetAngles(Rocket.Flight:Angle())
		self.Trail:SetKeyValue( "effect_name", "Rocket Motor")
		self.Trail:SetKeyValue( "start_active", "1")
		self.Trail:Spawn()
		self.Trail:Activate()
		self.Trail:SetParent(self.Entity)
		self.Trail:Fire("SetParentAttachment", "exhaust", 0)
		//self:EmitSound("cannon/missilefire.wav",100,100) 	
		//*/
		//ParticleEffect( "Rocket Motor", self.Entity:GetPos(), Rocket.Flight:Angle(), self.Entity )
		local particle = ParticleEffectAttach( "Rocket Motor", PATTACH_POINT_FOLLOW, self.Entity, self.Entity:LookupAttachment("exhaust") or 0 )
		//print("particle = ", particle, self.Entity:LookupAttachment("exhaust"))
		//particle = findParticle(self.Entity)
		//print("particle = ", particle)
	end
	//*/
	
	self.FutureCutout = CurTime() + Rocket.Cutout

end




function EFFECT:Update(diffs)
	
	if not IsValid(self) then return false end
	
	local Rocket = self.Rocket
	if not Rocket then self:Remove() error("Tried to update effect without a Rocket table!") end
	
	local balls = XCF.Ballistics or error("Couldn't find the Ballistics library!")
	
	if not diffs.UpdateType then self:Remove() error("Received Rocket update with no UpdateType!") end
	local Hit = diffs.UpdateType
	
	if Hit == balls.HIT_END then		--Rocket has reached end of flight, remove old effect
		self:HitEnd()
	elseif Hit == balls.HIT_PENETRATE then		--Rocket penetrated, don't remove old effect
		self:HitPierce()
	elseif Hit == balls.HIT_RICOCHET then		--Rocket ricocheted, don't remove old effect
		self:HitRicochet()
	end	
	
end




//TODO: remove need for this function
local function copyForRoundFuncs(Rocket)
	local ret = table.Copy(Rocket)
	ret.SimPos = Rocket.Pos
	ret.SimFlight = Rocket.Flight
	ret.RoundMass = Rocket.ProjMass
	return ret
end


local function mergeCopiedRoundBack(Rocket, original)
	Rocket.SimPos = nil
	Rocket.SimFlight = nil
	Rocket.ProjMass = Rocket.RoundMass
	Rocket.RoundMass = nil
	
	table.Merge(original, Rocket)
end


function EFFECT:HitEnd()
	//print("hit end")
	if self.hasHitEnd then return end
	self.hasHitEnd = true
	
	if self.Trail then
		self.Trail:Fire("Kill", "", 0)
		self.Trail = nil
	end
	
	local Rocket = self.Rocket
	self:Remove()
	if Rocket then
		Rocket = copyForRoundFuncs(Rocket)
		ACF.RoundTypes[Rocket.Type]["endeffect"](self, Rocket)
		mergeCopiedRoundBack(Rocket, self.Rocket)
	end
end


function EFFECT:HitPierce()
	//print("hit pierce")
	local Rocket = self.Rocket
	if Rocket then
		Rocket = copyForRoundFuncs(Rocket)
		ACF.RoundTypes[Rocket.Type]["pierceeffect"](self, Rocket)
		mergeCopiedRoundBack(Rocket, self.Rocket)
	end
end


function EFFECT:HitRicochet()
	//print("hit rico")
	local Rocket = self.Rocket
	if Rocket then
		Rocket = copyForRoundFuncs(Rocket)
		ACF.RoundTypes[Rocket.Type]["ricocheteffect"](self, Rocket)
		mergeCopiedRoundBack(Rocket, self.Rocket)
	end
end




function EFFECT:Think()
	local systime = SysTime()
	//print("think: " .. tostring(self.Bullet.Type))
	if self.CreateTime < systime - 30 then	//TODO: check for bullet existence like below
		self:Remove()
		return false
	end
	
	self:ApplyMovement( self.Rocket )
	self.LastThink = systime
	return true
	
end 




function EFFECT:ApplyMovement( Rocket )

	self:SetPos( Rocket.Pos )									--Moving the effect to the calculated position
	self:SetAngles( Rocket.Flight:Angle() )
	
	if CurTime() > self.FutureCutout then 
		self.Entity:StopParticles()
		//self.Trail:Fire("Kill", "", 0)
		//self.Trail = nil
	end

end




function EFFECT:Render()  

	local Rocket = self.Rocket
	
	if (Rocket) then
		//self.Entity:SetModelScale( Rocket.Caliber * 0.1 , 0 )
		self.Entity:DrawModel()       // Draw the model. 
	end
	
end 