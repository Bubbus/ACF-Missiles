
local ClassName = "Radar"


ACF = ACF or {}
ACF.Guidance = ACF.Guidance or {}

local this = ACF.Guidance[ClassName] or inherit.NewSubOf(ACF.Guidance.Dumb)
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
this.SeekTolerance = 0.95

-- This instance must wait this long between target seeks.
this.SeekDelay = 0.2

-- Missiles may detonate at some point under this range - unless they're travelling so fast that they step right on through.
this.FuseRange = 300

-- Entities to ignore by default
this.DefaultFilter = 
{
    ent_cre_missile = true
}


-- function this:Draw(ent, duration)
	-- local Guidance = self:GetGuidance(ent)
	-- debugoverlay.Cross( self.Pos, 12, duration or 0.017, Color(255, 128, 0), false)
-- end


function this:Init()
	self.LastSeek = CurTime() - self.SeekDelay - 0.000001
    self.Filter = self.DefaultFilter
end



-- Use this to make sure you don't alter the shared default filter unintentionally
function this:GetSeekFilter(class)
    if self.Filter == self.DefaultFilter then
        self.Filter = table.Copy(self.DefaultFilter)
    end
    
    return self.Filter
end



function this:Configure(missile)

end




function this:GetGuidance(missile)
	
	local ret = self:CheckTarget(missile)
	if ret then return ret end
	
	if not IsValid(self.Target) then 
		return {} 
	end
	
	local missilePos = missile:GetPos()
	local missileForward = missile:GetForward()
	local targetPos = self.Target:GetPos()
	local angleFrom = math.deg(math.acos((targetPos - missilePos):GetNormalized():Dot(missileForward)))
	
	if angleFrom > this.ViewCone then
		if IsValid(self.Target) then print(missile, "lost lock", self.Target) end
		self.Target = nil
		return {}
	else
		return {TargetPos = targetPos}
	end
	
end




function this:CheckTarget(missile)

	if not IsValid(self.Target) then	
		self.Target = self:AcquireLock(missile)
		
		if IsValid(self.Target) then 
			print(missile, "acquired lock", self.Target)
		else
			print(missile, "could not lock")
		end
	end
	
end




-- Return the first entity found within the seek-tolerance, or the entity within the seek-cone closest to the seek-tolerance.
function this:AcquireLock(missile)

	local curTime = CurTime()
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