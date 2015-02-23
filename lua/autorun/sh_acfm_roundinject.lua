



include("acf/shared/sh_acfm_getters.lua")




function ACFM_ModifyRoundDisplayFuncs()
    
    local roundTypes = list.GetForEdit("ACFRoundTypes")
    
    if not ACFM_RoundDisplayFuncs then
        
        ACFM_RoundDisplayFuncs = {}
    
        for k, v in pairs(roundTypes) do
            ACFM_RoundDisplayFuncs[k] = v.getDisplayData
        end

    end
    
    
    for k, v in pairs(roundTypes) do
        
        local oldDisplayData = ACFM_RoundDisplayFuncs[k]
    
        if oldDisplayData then
            v.getDisplayData = function(data)
            
                local guns = list.Get("ACFEnts").Guns
                local class = guns[data.Id]
                
                if not (class and class.gunclass) then
                    return oldDisplayData(data)
                end
                
                local classes = list.Get("ACFClasses").GunClass
                class = classes[class.gunclass]
                
                if not class.type or class.type ~= "missile" then
                    return oldDisplayData(data)
                end
            
                -- NOTE: if these replacements cause side-effects somehow, move to a masking-metatable approach
            
                local MuzzleVel = data.MuzzleVel
                local slugMV = data.SlugMV
                
                data.MuzzleVel = 0
                data.SlugMV = (slugMV or 0) * (ACF_GetGunValue(data.Id, "penmul") or 1)
                
                local ret = oldDisplayData(data)
                
                data.SlugMV = slugMV
                data.MuzzleVel = MuzzleVel
                
                return ret
            end
        end
    end
    
end




function ACFM_ModifyRoundBaseGunpowder()
    
    local oldGunpowder = ACFM_ModifiedRoundBaseGunpowder and oldGunpowder or ACF_RoundBaseGunpowder
    
    
    ACF_RoundBaseGunpowder = function(PlayerData, Data, ServerData, GUIData)
        
        PlayerData, Data, ServerData, GUIData = oldGunpowder(PlayerData, Data, ServerData, GUIData)
        
        Data.Id = PlayerData.Id
        
        return PlayerData, Data, ServerData, GUIData
        
    end
    
    
    ACFM_ModifiedRoundBaseGunpowder = true
    
end



timer.Simple(1, ACFM_ModifyRoundBaseGunpowder)
timer.Simple(1, ACFM_ModifyRoundDisplayFuncs)
