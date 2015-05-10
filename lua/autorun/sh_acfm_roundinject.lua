


AddCSLuaFile()
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




-- function ACFM_ModifyRoundGUIFuncs()
    
    -- local roundTypes = list.GetForEdit("ACFRoundTypes")
    
    -- if not ACFM_RoundGUIFuncs then
        
        -- ACFM_RoundGUIFuncs = {}
    
        -- for k, v in pairs(roundTypes) do
            -- ACFM_RoundGUIFuncs[k] = v.guiupdate
        -- end

    -- end
    
    
    -- for k, v in pairs(roundTypes) do
        
        -- local oldGuiUpdate = ACFM_RoundGUIFuncs[k]
    
        -- if oldGuiUpdate then
            -- v.guiupdate = function(Panel, Table)
            
                -- local ret = oldGuiUpdate(Panel, Table)
            
                -- local round = ACF_GetRoundFromCVars()
            
                -- local guns = list.Get("ACFEnts").Guns
                -- local class = guns[round.Id]
                
                -- if not (class and class.gunclass) then
                    -- print("no 1")
                    -- return ret
                -- end
                
                -- local classes = list.Get("ACFClasses").GunClass
                -- class = classes[class.gunclass]
                
                -- if not class.type or class.type ~= "missile" then
                    -- print("no 2")
                    -- return ret
                -- end
            
                
                
                -- local conv = v.convert( Panel, round )
                
                -- print("aeiou2", acfmenupanel["CData"]["SlugDisplay_text"])
                -- if acfmenupanel["CData"]["SlugDisplay_text"] then
                    -- local R50V, R50P    = ACF_PenRanging( 50, conv.DragCoef, conv.ProjMass, conv.PenAera, conv.LimitVel, 0 )
                    -- local R200V, R200P  = ACF_PenRanging( 200, conv.DragCoef, conv.ProjMass, conv.PenAera, conv.LimitVel, 0 )
                    -- local R100V, R100P = ACF_PenRanging( 100, conv.DragCoef, conv.ProjMass, conv.PenAera, conv.LimitVel, 0 )
                    -- acfmenupanel:CPanelText("SlugDisplay", "Penetrator Mass : "..(math.floor(conv.SlugMass*10000)/10).." g \n Penetrator Caliber : "..(math.floor(conv.SlugCaliber*100)/10).." mm \n Penetrator Velocity : "..math.floor(conv.SlugMV).." m/s \n Penetrator Maximum Penetration : "..math.floor(conv.MaxPen).." mm RHA\n\n300m pen: "..math.Round(R1P,0).."mm @ "..math.Round(R1V,0).." m\\s\n800m pen: "..math.Round(R2P,0).."mm @ "..math.Round(R2V,0).." m\\s\n\nThe range data is an approximation and may not be entirely accurate.")	--Proj muzzle penetration (Name, Desc)
                    -- --acfmenupanel:CPanelText("PenetrationDisplay", "Penetration at 100m/s: "..math.floor(R100P).." mm RHA")	--Proj muzzle penetration (Name, Desc)
                -- end
                
                -- print("aeiou3", acfmenupanel["CData"]["PenetrationRanging_text"])
                -- if acfmenupanel["CData"]["PenetrationRanging_text"] then
                    
                    -- acfmenupanel:CPanelText("PenetrationRanging", "\n50m/s pen: "..math.Round(R50P,0).."mm \n200m/s pen: "..math.Round(R200P,0).."mm \n\nThe range data is an approximation and may not be entirely accurate.")	--Proj muzzle penetration (Name, Desc)
                -- end
                
                
                -- return ret
            -- end
        -- end
    -- end
    
-- end




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

-- if CLIENT then
    -- timer.Simple(1, ACFM_ModifyRoundGUIFuncs)
-- end

