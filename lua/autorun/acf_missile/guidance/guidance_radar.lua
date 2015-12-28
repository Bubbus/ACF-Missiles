
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
this.SeekCone = 20

-- Cone to retain targets within.
this.ViewCone = 25

-- Targets this close to the front are good enough.
this.SeekTolerance = math.cos( math.rad( 2 ) )

-- This instance must wait this long between target seeks.
this.SeekDelay = 100000 -- The re-seek cycle is expensive, let's disable it until we figure out some optimization.

-- Delay between re-seeks if an entity is provided via wiremod.
this.WireSeekDelay = 0.1

-- Entity class whitelist
-- thanks to Sestze for the listing.
this.DefaultFilter = 
{
    prop_physics                = true,
    gmod_wheel                  = true,
    gmod_hoverball              = true,
    gmod_wire_expression2       = true,
    gmod_wire_thruster          = true,
    gmod_thruster               = true,
    gmod_wire_light             = true,
    gmod_light                  = true,
    gmod_emitter                = true,
    gmod_button                 = true,
    phys_magnet                 = true,
    prop_vehicle_jeep           = true,
    prop_vehicle_airboat        = true,
    prop_vehicle_prisoner_pod   = true,
    acf_engine                  = true,
    acf_ammo                    = true,
    acf_gun                     = true,
    acf_gearbox                 = true
}


this.desc = "This guidance package detects a target-position infront of itself, and guides the munition towards it."



function this:Init()
	self.LastSeek = CurTime() - self.SeekDelay - 0.000001
    self.Filter = self.DefaultFilter
	self.LastTargetPos = Vector()
end




function this:Configure(missile)
    
    self:super():Configure(missile)
    
    self.ViewCone = ACF_GetGunValue(missile.BulletData, "viewcone") or this.ViewCone
	self.ViewConeCos = math.cos(math.rad(self.ViewCone))
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




--TODO: still a bit messy, refactor this so we can check if a flare exits the viewcone too.
function this:GetGuidance(missile)
	
	self:PreGuidance(missile)
	
	local override = self:ApplyOverride(missile)
	if override then return override end
	
	local ret = self:CheckTarget(missile)
	if ret then return ret end
	
	if not IsValid(self.Target) then 
		return {TargetPos = nil} 
	end

	local missilePos = missile:GetPos()
	local missileForward = missile:GetForward()
	local targetPhysObj = self.Target:GetPhysicsObject()
	local targetPos = self.Target:GetPos()
	if IsValid(targetPhysObj) then
		targetPos = util.LocalToWorld( self.Target, targetPhysObj:GetMassCenter(), nil )
	end

	local mfo       = missile:GetForward()
	local mdir      = (targetPos - missilePos):GetNormalized()
	local dot       = mfo.x * mdir.x + mfo.y * mdir.y + mfo.z * mdir.z
	

	if dot < self.ViewConeCos then
		self.Target = nil
		return {TargetPos = nil}
	else
        self.TargetPos = targetPos
		return {TargetPos = targetPos, ViewCone = self.ViewCone}
	end
	
end




function this:ApplyOverride(missile)

	if self.Override then
	
		local ret = self.Override:GetGuidanceOverride(missile, self)
		
		if ret then		
			ret.ViewCone = self.ViewCone
			ret.ViewConeRad = math.rad(self.ViewCone)
			return ret
		end
		
	end

end




function this:CheckTarget(missile)

	if not (self.Target or self.Override) then	
		local target = self:AcquireLock(missile)

		if IsValid(target) then 
			self.Target = target
		end
	end
	
end




function this:GetWireTarget(missile)
	
    local launcher = missile.Launcher
    local outputs = launcher.Outputs
    
    if not IsValid(self.InputSource) then 
		return nil
	end
    
    local outputs = self.InputSource.Outputs
    
    if not outputs then
        return nil
	end
    
    
    for k, name in pairs(self.InputNames) do
        
        local outTbl = outputs[name]
        
        if not (outTbl and outTbl.Value) then continue end
        
        local val = outTbl.Value
        
        if IsEntity(val) and IsValid(val) then 
            return val
        end
        
    end
    
end





function this:GetWhitelistedEntsInCone(missile)

    local missilePos = missile:GetPos()
	local missileForward = missile:GetForward()
	
	local found = ents.FindInCone(missilePos, missileForward, 50000, self.SeekCone)
	
	local foundAnim = {}
	local foundEnt
	
    local filter = self.Filter
	for i, foundEnt in pairs(found) do
		if IsValid(foundEnt) and self.Filter[foundEnt:GetClass()] then
			table.insert(foundAnim, foundEnt)
		end
	end
    
    return foundAnim
    
end




function this:HasLOSVisibility(ent, missile)

	local traceArgs = 
	{
		start = missile:GetPos(),
		endpos = ent:GetPos(),
		mask = MASK_SOLID_BRUSHONLY,
		filter = {missile, ent}
	}
	
	local res = util.TraceLine(traceArgs)
	
	--debugoverlay.Line( missile:GetPos(), ent:GetPos(), 15, Color(res.Hit and 255 or 0, res.Hit and 0 or 255, 0), true )
	
	return not res.Hit

end




-- Return the first entity found within the seek-tolerance, or the entity within the seek-cone closest to the seek-tolerance.
function this:AcquireLock(missile)

	local curTime = CurTime()
    
    if self.LastSeek + self.WireSeekDelay <= curTime then 
    
        local wireEnt = self:GetWireTarget(missile)
        
        if wireEnt then
            --print("wiremod provided", wireEnt)
            return wireEnt
        end
        
    end
    
	if self.LastSeek + self.SeekDelay > curTime then 
        --print("tried seeking within timeout period")
        return nil 
    end
	self.LastSeek = curTime

	-- Part 1: get all whitelisted entities in seek-cone.
	local found = self:GetWhitelistedEntsInCone(missile)
    
	
	-- Part 2: get a good seek target
	local foundCt = #found
	if foundCt < 2 then 
        --print("shortcircuited and found", found[1])
        return found[1] 
    end
	
    local missilePos = missile:GetPos()
	local missileForward = missile:GetForward()
    
	local mostCentralEnt 
	
	local i = 0
	while not mostCentralEnt and i < foundCt do
		i = i + 1
		local ent = found[i]
		if self:HasLOSVisibility(ent, missile) then
			mostCentralEnt = ent
		end
	end
	
	if not mostCentralEnt then return nil end
	
	local mostCentralPos = mostCentralEnt:GetPos()
	local highestDot = (mostCentralEnt:GetPos() - missilePos):GetNormalized():Dot(missileForward)
	local currentEnt
	local currentDot
	
	while i < foundCt do
		i = i + 1
		
		currentEnt = found[i]
		currentDot = (currentEnt:GetPos() - missilePos):GetNormalized():Dot(missileForward)
		
		if currentDot > highestDot and self:HasLOSVisibility(currentEnt, missile) then
			mostCentralEnt = currentEnt
			highestDot = currentDot
			
			if currentDot >= self.SeekTolerance then 
                --print("found", mostCentralEnt, "in tolerance")
                return currentEnt 
            end
		end
	end
    
    --print("iterated and found", mostCentralEnt)
    
	return mostCentralEnt
end



function this:GetDisplayConfig()
	return 
	{
		["Seeking"] = math.Round(self.SeekCone * 2, 1) .. " deg",
		["Tracking"] = math.Round(self.ViewCone * 2, 1) .. " deg"
	}
end
