

include("acf/client/cl_acfmenu_missileui.lua")


function SetMissileGUIEnabled(panel, enabled, gundata)

    if enabled then
    
        -- Create guidance selection combobox + description label
    
        if not acfmenupanel.CData.MissileSpacer then
            local spacer = vgui.Create("DPanel")
            spacer:SetSize(24, 24)
            spacer.Paint = function() end
            acfmenupanel.CData.MissileSpacer = spacer
            
            acfmenupanel.CustomDisplay:AddItem(spacer)
        end
    
        local default = "Dumb"   -- Dumb is the only acceptable default
        if not acfmenupanel.CData.GuidanceSelect then
            acfmenupanel.CData.GuidanceSelect = vgui.Create( "DComboBox", acfmenupanel.CustomDisplay )	--Every display and slider is placed in the Round table so it gets trashed when selecting a new round type
            acfmenupanel.CData.GuidanceSelect:SetSize(100, 30)        
            
            acfmenupanel.CData.GuidanceSelect.OnSelect = function( index , value , data )
                RunConsoleCommand( "acfmenu_data7", data )
                
                local guidance = ACF.Guidance[data]
                if guidance and guidance.desc then
                    acfmenupanel:CPanelText("GuidanceDesc", guidance.desc .. "\n")
                    
                    local configPanel = ACFMissiles_CreateMenuConfiguration(guidance, acfmenupanel.CData.GuidanceSelect, "acfmenu_data7", acfmenupanel.CData.GuidanceSelect.ConfigPanel)
                    acfmenupanel.CData.GuidanceSelect.ConfigPanel = configPanel
                else
                    acfmenupanel:CPanelText("GuidanceDesc", "Missiles and bombs can be given a guidance package to steer them during flight.\n")
                end
            end
                
            acfmenupanel.CustomDisplay:AddItem( acfmenupanel.CData.GuidanceSelect )
            
            acfmenupanel:CPanelText("GuidanceDesc", "Missiles and bombs can be given a guidance package to steer them during flight.\n")
            
            local configPanel = vgui.Create("DScrollPanel")
            acfmenupanel.CData.GuidanceSelect.ConfigPanel = configPanel
            acfmenupanel.CustomDisplay:AddItem( configPanel )
            
        else        
            --acfmenupanel.CData.GuidanceSelect:SetSize(100, 30)
            default = acfmenupanel.CData.GuidanceSelect:GetValue()
            acfmenupanel.CData.GuidanceSelect:SetVisible(true)
        end
        
        acfmenupanel.CData.GuidanceSelect:Clear()
        for Key, Value in pairs( gundata.guidance or {} ) do
            acfmenupanel.CData.GuidanceSelect:AddChoice( Value, Value, Value == default )
        end
        
        
        
        -- Create fuse selection combobox + description label
        
        default = "Contact"  -- Contact is the only acceptable default
        if not acfmenupanel.CData.FuseSelect then
            acfmenupanel.CData.FuseSelect = vgui.Create( "DComboBox", acfmenupanel.CustomDisplay )	--Every display and slider is placed in the Round table so it gets trashed when selecting a new round type
            acfmenupanel.CData.FuseSelect:SetSize(100, 30)
            
            acfmenupanel.CData.FuseSelect.OnSelect = function( index , value , data )
                ACFMissiles_SetCommand(acfmenupanel.CData.FuseSelect, acfmenupanel.CData.FuseValue, "acfmenu_data8")
                
                local fuse = ACF.Fuse[data]
                
                if fuse and fuse.desc then
                    acfmenupanel:CPanelText("FuseDesc", fuse.desc .. "\n")
                    
                    local configPanel = ACFMissiles_CreateMenuConfiguration(fuse, acfmenupanel.CData.FuseSelect, "acfmenu_data8", acfmenupanel.CData.FuseSelect.ConfigPanel)
                    acfmenupanel.CData.FuseSelect.ConfigPanel = configPanel
                else
                    acfmenupanel:CPanelText("FuseDesc", "Missiles and bombs can be given a fuse to control when they detonate.\n")
                end
            end
                
            acfmenupanel.CustomDisplay:AddItem( acfmenupanel.CData.FuseSelect )
            
            acfmenupanel:CPanelText("FuseDesc", "Missiles and bombs can be given a fuse to control when they detonate.\n")
            
            local configPanel = vgui.Create("DScrollPanel")
            configPanel:SetTall(0)
            acfmenupanel.CData.FuseSelect.ConfigPanel = configPanel
            acfmenupanel.CustomDisplay:AddItem( configPanel )
        else
            --acfmenupanel.CData.FuseSelect:SetSize(100, 30)
            default = acfmenupanel.CData.FuseSelect:GetValue()
            acfmenupanel.CData.FuseSelect:SetVisible(true)
        end
        
        acfmenupanel.CData.FuseSelect:Clear()
        for Key, Value in pairs( gundata.fuses or {} ) do
            acfmenupanel.CData.FuseSelect:AddChoice( Value, Value, Value == default ) -- Contact is the only acceptable default
        end
    
    else
    
        -- Delete everything!  Tried just making them invisible but they seem to break.
    
        if acfmenupanel.CData.MissileSpacer then
            acfmenupanel.CData.MissileSpacer:Remove()
            acfmenupanel.CData.MissileSpacer = nil
        end
    
    
        if acfmenupanel.CData.GuidanceSelect then
        
            if acfmenupanel.CData.GuidanceSelect.ConfigPanel then
                acfmenupanel.CData.GuidanceSelect.ConfigPanel:Remove()
                acfmenupanel.CData.GuidanceSelect.ConfigPanel = nil   
            end
        
            acfmenupanel.CData.GuidanceSelect:Remove()
            acfmenupanel.CData.GuidanceSelect = nil
        end
        
        if acfmenupanel.CData.GuidanceDesc_text then
            acfmenupanel.CData.GuidanceDesc_text:Remove()
            acfmenupanel.CData.GuidanceDesc_text = nil
        end
        
        
        if acfmenupanel.CData.FuseSelect then
            
            if acfmenupanel.CData.FuseSelect.ConfigPanel then
                acfmenupanel.CData.FuseSelect.ConfigPanel:Remove()
                acfmenupanel.CData.FuseSelect.ConfigPanel = nil   
            end
        
            acfmenupanel.CData.FuseSelect:Remove()
            acfmenupanel.CData.FuseSelect = nil           
        end
        
        if acfmenupanel.CData.FuseDesc_text then
            acfmenupanel.CData.FuseDesc_text:Remove()
            acfmenupanel.CData.FuseDesc_text = nil
        end
        
    
        --ACFMissiles_RemoveMenuConfiguration("Fuse")
    
    end
    
end




function ModifyACFMenu(panel)
    
    oldAmmoSelect = oldAmmoSelect or panel.AmmoSelect
   
    panel.AmmoSelect = function(panel, blacklist)
    
        oldAmmoSelect(panel, blacklist)
    
        acfmenupanel.CData.CaliberSelect.OnSelect = function( index , value , data )            
			acfmenupanel.AmmoData["Data"] = acfmenupanel.WeaponData["Guns"][data]["round"]
			acfmenupanel:UpdateAttribs()
			acfmenupanel:UpdateAttribs()	--Note : this is intentional
            
            local gunTbl = acfmenupanel.WeaponData["Guns"][data]
            local class = gunTbl.gunclass
            
            local Classes = list.Get("ACFClasses")
            timer.Simple(0.01, function() SetMissileGUIEnabled( acfmenupanel, (Classes.GunClass[class].type == "missile"), gunTbl ) end)
		end
        
        local data = acfmenupanel.CData.CaliberSelect:GetValue()
        if data then
            local gunTbl = acfmenupanel.WeaponData["Guns"][data]
            local class = gunTbl.gunclass
            
            local Classes = list.Get("ACFClasses")
            timer.Simple(0.01, function() SetMissileGUIEnabled( acfmenupanel, (Classes.GunClass[class].type == "missile"), gunTbl) end)
        end
        
    end
    
end




function FindACFMenuPanel()
    if acfmenupanel then
        ModifyACFMenu(acfmenupanel)
        timer.Remove("FindACFMenuPanel")
    end
end




timer.Create("FindACFMenuPanel", 0.1, 0, FindACFMenuPanel)