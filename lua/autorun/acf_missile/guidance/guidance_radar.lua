
local ClassName = "Radar"


ACF = ACF or {}
ACF.Guidance = ACF.Guidance or {}

local this = ACF.Guidance[ClassName] or inherit.NewSubOf(ACF.Guidance.Wire)
ACF.Guidance[ClassName] = this

---


this.Name = ClassName

--Currently acquired target.
this.Target = nil

-- Cone to acquire targets within.
this.SeekCone = 15

-- Cone to retain targets within.
this.ViewCone = 30

-- Targets this close to the front are good enough.
this.SeekTolerance = math.cos( math.rad( 1 ) )

-- This instance must wait this long between target seeks.
this.SeekDelay = 100000 -- The re-seek cycle is expensive, let's disable it until we figure out some optimization.

-- Delay between re-seeks if an entity is provided via wiremod.
this.WireSeekDelay = 0.1

-- Entities to ignore by default
this.DefaultFilter = 
{
    acf_missile 	    = true;
	debris				= true;
	player				= true
}


this.desc = "This guidance package detects a target in front of it when launched, and guides the munition towards it."

-- function this:Draw(ent, duration)
	-- local Guidance = self:GetGuidance(ent)
	-- debugoverlay.Cross( self.Pos, 12, duration or 0.017, Color(255, 128, 0), false)
-- end


function this:Init()
	self.LastSeek = CurTime() - self.SeekDelay - 0.000001
    self.Filter = self.DefaultFilter
	self.LastTargetPos = Vector()
end




function this:Configure(missile)
    
    self:super():Configure(missile)
    
    self.ViewCone = ACF_GetGunValue(missile.BulletData, "viewcone") or this.ViewCone
    self.SeekCone = ACF_GetGunValue(missile.BulletData, "seekcone") or this.SeekCone
    
end



-- Use this to make sure you don't alter the shared default filter unintentionally
function this:GetSeekFilter(class)
    if self.Filter == self.DefaultFilter then
        self.Filter = table.Copy(self.DefaultFilter)
    end
    
    return self.Filter
end




function this:GetNamedWireInputs(missile)

    local launcher = missile.Launcher
    local outputs = launcher.Outputs

    local names = {}
    
    
    if outputs.Target and outputs.Target.Type == "ENTITY" then
    
        names[#names+1] = "Target"
    
    end
    
    
    return names

end




function this:GetFallbackWireInputs()

    -- Can't scan for entity outputs: a lot of ents have self-outputs.
    return {}

end




function this:GetGuidance(missile)
	
	local ret = self:CheckTarget(missile)
	if ret then return ret end
	
	if not IsValid(self.Target) then 
		return {} 
	end

	local missilePos = missile:GetPos()
	local missileForward = missile:GetForward()
	local targetPhysObj = self.Target:GetPhysicsObject()
	local targetPos = self.Target:GetPos()
	if IsValid(targetPhysObj) then
		targetPos = util.LocalToWorld( self.Target, targetPhysObj:GetMassCenter(), nil )
	end

	local angleFrom = math.deg(math.acos((targetPos - missilePos):GetNormalized():Dot(missileForward)))
	
	if angleFrom > this.ViewCone then
		self.Target = nil
		self.TargetVel = Vector()
		self.LastTargetPos = Vector()
		return {}
	else
        self.TargetPos = targetPos
		local targetVel = targetPos - self.LastTargetPos
		self.LastTargetPos = targetPos

		if self.LastTargetPos == Vector() then targetVel = Vector() end

		return {TargetPos = targetPos, TargetVel = targetVel, ViewCone = self.ViewCone}
	end
	
end




function this:CheckTarget(missile)

	if not IsValid(self.Target) then	
		local target = self:AcquireLock(missile)
		
		if IsValid(target) then 
			while IsValid( target ) do
				local parent = target:GetParent()
				if IsValid(parent) then target = parent
				else break end
			end
			self.Target = target
			
			self.TargetVel = Vector()
			self.LastTargetPos = Vector()
		end
	end
	
end




function this:GetWireTarget(missile)
	
    local launcher = missile.Launcher
    local outputs = launcher.Outputs
    
    if not IsValid(self.InputSource) then 
		return {} 
	end
    
    local outputs = self.InputSource.Outputs
    
    if not outputs then
        return {} 
	end
    
    
    for k, name in pairs(self.InputNames) do
        
        local outTbl = outputs[name]
        
        if not (outTbl and outTbl.Value) then continue end
        
        local val = outTbl.Value
        
        if type(val) == "Entity" and IsValid(val) then 
            return val
        end
        
    end
    
end




-- Return the first entity found within the seek-tolerance, or the entity within the seek-cone closest to the seek-tolerance.
function this:AcquireLock(missile)

	local curTime = CurTime()
    
    if self.LastSeek + self.WireSeekDelay <= curTime then 
    
        local wireEnt = self:GetWireTarget(missile)
        
        if wireEnt then
            return wireEnt
        end
        
    end
    
	if self.LastSeek + self.SeekDelay > curTime then return nil end
	self.LastSeek = curTime

	-- Part 1: get all entities in seek-cone of type "anim"
	
	local missilePos = missile:GetPos()
	local missileForward = missile:GetForward()
	local found = ents.FindInCone(missilePos, missileForward, 50000, self.SeekCone)
	
	local foundAnim = {}
	local foundAnimIdx = 1
	local foundEnt
	
    local filter = self.Filter
	for i=1, #found do
		foundEnt = found[i]
		if IsValid(foundEnt:GetPhysicsObject()) and not self.Filter[foundEnt:GetClass()] then
			foundAnim[foundAnimIdx] = foundEnt
			foundAnimIdx = foundAnimIdx + 1
		end
	end
	
	found = foundAnim
	
	-- Part 2: get a good seek target
	
	local foundCt = #found
	if foundCt < 2 then return found[1] end
	
	local mostCentralEnt = found[1]
	local mostCentralPos = mostCentralEnt:GetPos()
	local highestDot = (mostCentralEnt:GetPos() - missilePos):GetNormalized():Dot(missileForward)
	local currentEnt
	local currentDot
	
	for i=2, foundCt do
		currentEnt = found[i]
		currentDot = (currentEnt:GetPos() - missilePos):GetNormalized():Dot(missileForward)
		
		if currentDot > highestDot then
			mostCentralEnt = currentEnt
			highestDot = currentDot
			
			if currentDot >= self.SeekTolerance then return currentEnt end
		end
	end
    
	return mostCentralEnt
end