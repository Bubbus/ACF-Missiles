AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


DEFINE_BASECLASS("acf_grenade")


if SERVER then
	concommand.Add("makeMissile", function(ply, args)
		local missile = ents.Create("ent_cre_missile")
		missile:SetPos(ply:GetShootPos() + ply:GetAimVector() * 50)
		missile:SetAngles(ply:GetAimVector():Angle())
		missile.Owner = ply
		
		local BulletData = {}
		BulletData["Colour"]		= Color(255, 255, 255)
        BulletData["Data10"]		= "0.00"
        BulletData["Data5"]		= "312.49"
        BulletData["Data6"]		= "48.830002"
        BulletData["Data7"]		= "0"
        BulletData["Data8"]		= "0"
        BulletData["Data9"]		= "0"
        BulletData["Id"]		= "40mmAAM"
        BulletData["ProjLength"]		= "31.99"
        BulletData["PropLength"]		= "0.01"
        BulletData["Type"]		= "HE"
		BulletData.IsShortForm = true
		
        missile.Launcher = ply
        
		missile:SetBulletData(BulletData)
		missile:SetGuidance(ACF.Guidance.Radar())
        missile:SetFuse(ACF.Fuse.Timed())
		
		missile:Spawn()
        missile:Launch()
	end)
end




function ENT:Initialize()

	self.BaseClass.Initialize(self)

	if !IsValid(self.Entity.Owner) then
		self.Owner = player.GetAll()[1]
	end

	self.Entity:SetOwner(self.Entity.Owner)
	-- self:SetModelEasy( "models/missiles/aim9.mdl" )
	-- self.Entity:PhysicsInit( SOLID_VPHYSICS )
	-- self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	-- self.Entity:SetSolid( SOLID_VPHYSICS )

	local Mass = 74.48
	self.PhysObj = self.Entity:GetPhysicsObject()
	self.PhysObj:SetMass( Mass )
	self.PhysObj:EnableGravity( false )
	self.PhysObj:EnableMotion( false )
	--util.SpriteTrail(self.Entity, 0, Color(255,255,255,255), false, 8, 128, 3, 1/16, "trails/smoke.vmt")

	self:ConfigureFlight()
	
	--self:Launch()
end




function ENT:SetBulletData(bdata)

    self.BaseClass.SetBulletData(self, bdata)
    
    local gun = list.Get("ACFEnts").Guns[bdata.Id]
    
    self:SetModelEasy( gun.round.model or gun.model or "models/missiles/aim9.mdl" )
    
    self:ParseBulletData(bdata)
	
end




function ENT:ParseBulletData(bdata)
    
    local guidance  = bdata.Data7
    local fuse      = bdata.Data8
    
    if guidance then        
        xpcall( -- we're eating arbitrary user input, so let's not fuck up if they fuck up
                function()
                    guidance = self:CreateConfigurable(guidance, ACF.Guidance)
                    if guidance then self:SetGuidance(guidance) end
                end,
                
                ErrorNoHalt
              )
    end
    
    if fuse then
        xpcall( -- we're eating arbitrary user input, so let's not fuck up if they fuck up
                function()
                    fuse = self:CreateConfigurable(fuse, ACF.Fuse)
                    if fuse then self:SetFuse(fuse) end
                end,
                
                ErrorNoHalt
              )        
    end
    
end




local Cast = 
{
    number = function(str) return tonumber(str) end,
    string = function(str) return str end,
    boolean = function(str) return tobool(str) end
}

--TODO: move to global file.
function ENT:CreateConfigurable(str, configurables)

    -- we're parsing a string of the form "NAME:CMD=VAL:CMD=VAL"... potentially.

    local parts = {}
    -- split parts delimited by ':'
    for part in string.gmatch(str, "[^:]+") do parts[#parts+1] = part end
    
    pbn(parts)
    
    if #parts <= 0 then return end
    
    
    local name = table.remove(parts, 1)
    if name and name ~= "" then
        
        -- base table for configurable object
        local class = configurables[name]
        if not class then return end
        
        
        local args = {}
        
        for _, arg in pairs(parts) do
            -- get CMD from 'CMD=VAL'
            local cmd = string.match(arg, "^[^=]+")
            if not cmd then continue end
            
            -- get VAL from 'CMD=VAL'
            local val = string.match(arg, "[^=]+$")
            if not val then continue end
            
            args[string.lower(cmd)] = val
        end
        
        
        -- construct new instance of configurable object
        local instance = class()
        if not instance.Configurable then return instance end
        
        
        -- loop through config, match up with args and set values accordingly
        for _, config in pairs(instance.Configurable) do
        
            local cmdName = config.CommandName
            
            if not cmdName then continue
            else cmdName = string.lower(cmdName) end
            
            local arg = args[cmdName]
            if not arg then continue end
            
            local type = config.Type
            
            print(cmdName, arg, type)
            
            if Cast[type] then 
                instance[config.Name] = Cast[type](arg)
            end
        
        end
        
        pbn(instance)
        
        return instance
        
    end

end




function ENT:CalcFlight()

    if self.MissileDetonated then return end

	local Ent = self.Entity
	local Pos = self.CurPos
	local Dir = self.CurDir

	local LastPos = self.LastPos
	local LastVel = self.LastVel
	local Speed = LastVel:Length()
	local Flight = self.FlightTime

    local Time = CurTime()
    local DeltaTime = Time - self.LastThink
    self.LastThink = Time
	Flight = Flight + DeltaTime

	if Speed == 0 then
		LastVel = Dir
		Speed = 1
	end


	--Guidance calculations
	local Guidance = self.Guidance:GetGuidance(self)
	local TargetPos = Guidance.TargetPos

	if TargetPos then
		local Dist = Pos:Distance(TargetPos)
		local TargetVel = (Guidance.TargetVel or Vector(0,0,0)) / DeltaTime * 0.03
		local DirRaw = TargetPos - Pos
		local DirRawNorm = DirRaw:GetNormalized()
		local SpeedMul = math.min((Speed / DeltaTime / self.MinimumSpeed) ^ 3,1)
		--print(SpeedMul)

		--Target position projection
		local LockOffset = (((TargetVel - LastVel) / Speed + Vector(0,0,DeltaTime * self.Gravity / 1000)) * Dist) or NewDir
		local ProjOffset = LockOffset - LockOffset:Dot(DirRawNorm) * DirRawNorm
		local DirProj = TargetPos + ProjOffset - Pos
		local DirProjNorm = DirProj:GetNormalized()

		--TODO:		[x] Add a second rotation that smoothes the oscillations out
		--			[x] Prevent the missile from correcting so far that the target falls out of the FOV
		--			[ ] Add fins to allow steering without a motor
		--			[x] Make rotations depend on velocity

		local VelAxis = LastVel:Cross(DirProj)
		local VelAxisNorm = VelAxis:GetNormalized()
		local AngDiff = math.deg(math.asin(VelAxis:Length() / (Dist * Speed)))

		if AngDiff > 0 then
			--Target facing
			local Ang = Dir:Angle()
			Ang:RotateAroundAxis( VelAxisNorm, math.Clamp(AngDiff * SpeedMul,-1,1) )
			local NewDir = Ang:Forward()

			--Velocity stabilisation
			local DirAxis = NewDir:Cross(DirRawNorm)
			local RawDotSimple = NewDir.x * DirRawNorm.x + NewDir.y * DirRawNorm.y + NewDir.z * DirRawNorm.z
			local RawAng = math.deg(math.acos(RawDotSimple))		--Since both vectors are normalised, calculating the dot product should be faster this way
			Ang:RotateAroundAxis( DirAxis, math.Clamp(RawAng * SpeedMul,-1,1) * (self.MinimumSpeed / 2000))
			NewDir = Ang:Forward()

			--FOV check
			local TotalDotSimple = NewDir.x * DirRawNorm.x + NewDir.y * DirRawNorm.y + NewDir.z * DirRawNorm.z
			local TotalAng = math.deg(math.acos(TotalDotSimple))
			if TotalAng <= Guidance.ViewCone then
				Dir = NewDir
			end
		end

	else
		local DirAng = Dir:Angle()
		local VelNorm = LastVel:GetNormalized()
		local AimDiff = Dir - VelNorm
		local DiffLength = AimDiff:Length()
		if DiffLength >= 0.01 then
			local Torque = DiffLength * self.TorqueMul
			local AngVelDiff = Torque / self.Inertia * DeltaTime
			local DiffAxis = AimDiff:Cross(Dir):GetNormalized()
			self.RotAxis = self.RotAxis + DiffAxis * AngVelDiff
		end

		self.RotAxis = self.RotAxis * 0.99
        DirAng:RotateAroundAxis(self.RotAxis, self.RotAxis:Length())
		Dir = DirAng:Forward()
	end

	
	
	--Motor cutout
	if Time > self.CutoutTime then
		if self.Motor ~= 0 then
			self.Entity:StopParticles()
			self.Motor = 0
		end
	end

	--Physics calculations
	local Vel = LastVel + (Dir * self.Motor - Vector(0,0,self.Gravity)) * ACF.VelScale * DeltaTime ^ 2
	local SpeedSq = Vel:LengthSqr()
	local Drag = Vel:GetNormalized() * (self.DragCoef * SpeedSq) / ACF.DragDiv * ACF.VelScale
	Vel = Vel - Drag
	local EndPos = Pos + Vel

	--Hit detection
	local tracedata={}
	tracedata.start = Pos
	tracedata.endpos = EndPos
	tracedata.filter = self.Filter
	local trace = util.TraceLine(tracedata)

	if trace.Hit then		
		self:DoFlight(trace.HitPos)
        self.LastVel = Vel
		self:Detonate()
		return
	end



	--print("Vel = "..math.Round(Vel:Length() / DeltaTime))
    
    if self.Fuse:GetDetonate(self, self.Guidance) then
	
		local DetonatePos = EndPos--Guidance.EndPos
		if DetonatePos then
			self:DoFlight(DetonatePos)
		end
		--print("FUSE DET")
        self.LastVel = Vel
		self:Detonate()
		return
		
	end
    
	self.LastVel = Vel
	self.LastPos = Pos
	self.CurPos = EndPos
	self.CurDir = Dir
	self.FlightTime = Flight
	
	debugoverlay.Line(EndPos, EndPos + Vel:GetNormalized() * 50, 10, Color(0, 255, 0))
	debugoverlay.Line(EndPos, EndPos + Dir:GetNormalized()  * 50, 10, Color(0, 0, 255))
	
	self:DoFlight()
end




function ENT:SetGuidance(guidance)

	self.Guidance = guidance
	guidance:Configure(self)

    return guidance
    
end




function ENT:SetFuse(fuse)

	self.Fuse = fuse
    fuse:Configure(self, self.Guidance or self:SetGuidance(ACF.Guidance.Dumb()))

    return fuse

end




function ENT:Launch()

	if not self.Guidance then
		self:SetGuidance(ACF.Guidance.Dumb())
	end
    
    if not self.Fuse then
        self:SetFuse(ACF.Fuse.Contact())
    end

    self.Guidance:Configure(self)
    self.Fuse:Configure(self, self.Guidance)
    
	self.Launched = true
	self.ThinkDelay = 1 / 66
	self.Filter = self.Filter or {self}
    
    self:SetParent(nil)
    
    self:ConfigureFlight()
    
	local phys = self:GetPhysicsObject()
	phys:EnableMotion(false)
	
	if self.Motor > 0 or self.MotorLength > 0.1 then
		self.CacheParticleEffect = CurTime() + 0.01
	end
	
    self:LaunchEffect()
    
	self:Think()
end




function ENT:LaunchEffect()

    local guns = list.Get("ACFEnts").Guns
    local class = guns[self.BulletData.Id]
    
    if class then
        if class.sound then
            self:EmitSound(class.sound, 500, 100)
        else
            local classes = list.Get("ACFClasses").GunClass
            class = classes[class.gunclass]
            
            if class then
                local sound = class.round and class.round.sound or class.sound
                if sound then self:EmitSound(sound, 500, 100) end
            end
        end
    end
    
end




function ENT:ConfigureFlight()

    local Time = CurTime()
	self.MotorLength = 0.5
	self.Gravity = GetConVar("sv_gravity"):GetFloat()
	self.DragCoef = 0.0018
	self.Motor = 10000
	self.MinimumSpeed = 10000
	self.FlightTime = 0
	self.FinMultiplier = 1
	self.CutoutTime = Time + self.MotorLength
	self.CurPos = self.BulletData.Pos --self:GetPos()
	self.CurDir = self.BulletData.Flight:GetNormalized() --self:GetForward()
	self.LastPos = self.CurPos
    self.Hit = false
	self.FirstThink = true
    
    local Mass = 74.48
    local Length = 118
	local Width = 5
	self.Inertia = 0.08333 * Mass * (3.1416 * (Width / 2) ^ 2 + Length) -- cylinder, non-roll axes
	self.TorqueMul = Length * 25	--Kinda cheated here because it was unrealistic
	self.RotAxis = Vector(0,0,0)
    
end




function ENT:DoFlight(ToPos, ToDir)
	--if !IsValid(self.Entity) or self.MissileDetonated then return end

	local setPos = ToPos or self.CurPos
	local setDir = ToDir or self.CurDir
    
	self:SetPos(setPos)
	self:SetAngles(setDir:Angle())
    
    self.BulletData.Pos = setPos
    --self.BulletData.Flight = self.LastVel
end




function ENT:Detonate()

	self.BulletData.Flight = self.BulletData.MuzzleVel and (self.LastVel:GetNormalized() * self.BulletData.MuzzleVel) or self.LastVel
    
    self.MissileDetonated = true    -- careful not to conflict with base class's self.Detonated

	self.BaseClass.Detonate(self)

end




function ENT:Think()
	local Time = CurTime()

	if self.Launched then
	
		if self.Hit then
			self:Detonate()
			return false
		end

		if self.FirstThink == true then
			self.FirstThink = false
			self.LastThink = CurTime()
			self.LastVel = self.Launcher:GetVelocity() / 66

		end
		self:CalcFlight()
		
        if self.CacheParticleEffect and self.CacheParticleEffect <= CurTime() then
            ParticleEffectAttach( "Rocket Motor", PATTACH_POINT_FOLLOW, self, self:LookupAttachment("exhaust") or 0 )
            self.CacheParticleEffect = nil
        end
        
	end
	
	return self.BaseClass.Think(self)
end




function ENT:PhysicsCollide()
	if self.Launched then self:Detonate() end
end




hook.Add("CanDrive", "ent_cre_missile_CanDrive", function(ply, ent) 
    if ent:GetClass() == "ent_cre_missile" then return false end
end)