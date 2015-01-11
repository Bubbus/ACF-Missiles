
local ClassName = "Wire"


ACF = ACF or {}
ACF.Guidance = ACF.Guidance or {}

local this = ACF.Guidance[ClassName] or inherit.NewSubOf(ACF.Guidance.Dumb)
ACF.Guidance[ClassName] = this

---



this.Name = ClassName

-- An entity with a Position wire-output
this.InputSource = nil

-- Length of the guidance wire
this.WireLength = 20000


this.desc = "This guidance package reads a target-position from the launcher and guides the munition towards it."

-- function this:Draw(ent, duration)
	-- local Guidance = self:GetGuidance(ent)
	-- debugoverlay.Cross( self.Pos, 12, duration or 0.017, Color(255, 128, 0), false)
-- end


function this:Init()
	
end



-- Use this to make sure you don't alter the shared default filter unintentionally
function this:GetSeekFilter(class)
    if self.Filter == self.DefaultFilter then
        self.Filter = table.Copy(self.DefaultFilter)
    end
    
    return self.Filter
end



function this:Configure(missile)

    local launcher = missile.Launcher
    local outputs = launcher.Outputs
    
    if outputs then
        
        -- If we have a Position output, we're in business.
        if outputs.Position and outputs.Position.Type == "VECTOR" then
        
            self.InputSource = launcher
            self.InputName = "Position"
            
        else
            -- To avoid ambiguity, only link if there's a single vector output.
            local foundOutput = nil
            
            for k, v in pairs(outputs) do
                if v.Type == "VECTOR" then
                    if foundOutput then
                        foundOutput = nil
                        break
                    else
                        foundOutput = k
                    end
                end
            end
            
            if foundOutput then
                self.InputSource = launcher
                self.InputName = foundOutput
            end
            
        end
        
    end

end




function this:GetGuidance(missile)
	
	if not IsValid(self.InputSource) then 
		return {} 
	end
	
    local outputs = self.InputSource.Outputs
    
    if not outputs then
        return {} 
	end
    
    local posOutput = outputs[self.InputName]
    local posVec = posOutput.Value
    
    if not posVec or posVec == Vector() then
        return {} 
    end
    
    self.TargetPos = posVec
	return {TargetPos = posVec}
	
end

