

include("acf/client/cl_acfmenu_missileui.lua")


function SetMissileGUIEnabled(panel, enabled)

    if enabled then
    
    
        -- Create guidance selection combobox + description label
    
        if not acfmenupanel.CData.GuidanceSelect then
            acfmenupanel.CData.GuidanceSelect = vgui.Create( "DComboBox", acfmenupanel.CustomDisplay )	--Every display and slider is placed in the Round table so it gets trashed when selecting a new round type
                acfmenupanel.CData.GuidanceSelect:SetSize(100, 30)
                
                for Key, Value in pairs( ACF.Guidance ) do
                    acfmenupanel.CData.GuidanceSelect:AddChoice( Key, Key )
                end
                
                acfmenupanel.CData.GuidanceSelect.OnSelect = function( index , value , data )
                    RunConsoleCommand( "acfmenu_data7", data )
                    
                    local guidance = ACF.Guidance[data]
                    if guidance and guidance.desc then
                        acfmenupanel:CPanelText("GuidanceDesc", guidance.desc .. "\n")
                    else
                        acfmenupanel:CPanelText("GuidanceDesc", "Missiles and bombs can be given a guidance package to steer them during flight.\n")
                    end
                end
                
                acfmenupanel.CData.GuidanceSelect:SetText("Munition Guidance")
                RunConsoleCommand( "acfmenu_data7", "" )
            acfmenupanel.CustomDisplay:AddItem( acfmenupanel.CData.GuidanceSelect )
            
            acfmenupanel:CPanelText("GuidanceDesc", "Missiles and bombs can be given a guidance package to steer them during flight.\n")
        else
            acfmenupanel.CData.GuidanceSelect:SetSize(100, 30)
            acfmenupanel.CData.GuidanceSelect:SetVisible(true)
        end
        
        
        -- Create fuse selection combobox + description label
        
        if not acfmenupanel.CData.FuseSelect then
            acfmenupanel.CData.FuseSelect = vgui.Create( "DComboBox", acfmenupanel.CustomDisplay )	--Every display and slider is placed in the Round table so it gets trashed when selecting a new round type
                acfmenupanel.CData.FuseSelect:SetSize(100, 30)
                
                for Key, Value in pairs( ACF.Fuse ) do
                    acfmenupanel.CData.FuseSelect:AddChoice( Key, Key )
                end
                
                acfmenupanel.CData.FuseSelect.OnSelect = function( index , value , data )
                    ACFMissiles_SetCommand(acfmenupanel.CData.FuseSelect, acfmenupanel.CData.FuseValue, "acfmenu_data8")
                    
                    local fuse = ACF.Fuse[data]
                    
                    if fuse and fuse.desc then
                        acfmenupanel:CPanelText("FuseDesc", fuse.desc .. "\n")
                        ACFMissiles_CreateMenuConfiguration("Fuse", fuse, acfmenupanel.CData.FuseSelect)
                    else
                        acfmenupanel:CPanelText("FuseDesc", "Missiles and bombs can be given a fuse to control when they detonate.\n")
                    end
                end
                
                acfmenupanel.CData.FuseSelect:SetText("Munition Fuse")
                
            acfmenupanel.CustomDisplay:AddItem( acfmenupanel.CData.FuseSelect )
            
            acfmenupanel:CPanelText("FuseDesc", "Missiles and bombs can be given a fuse to control when they detonate.\n")
            
            ACFMissiles_SetCommand(acfmenupanel.CData.FuseSelect, acfmenupanel.CData.FuseValue, "acfmenu_data8")
        else
            acfmenupanel.CData.FuseSelect:SetSize(100, 30)
            acfmenupanel.CData.FuseSelect:SetVisible(true)
        end
    
    
    else
    
        -- Delete everything!  Tried just making them invisible but they seem to break.
    
        if acfmenupanel.CData.GuidanceSelect then
            acfmenupanel.CData.GuidanceSelect:Remove()
            acfmenupanel.CData.GuidanceSelect = nil
        end
        
        if acfmenupanel.CData.GuidanceDesc_text then
            acfmenupanel.CData.GuidanceDesc_text:Remove()
            acfmenupanel.CData.GuidanceDesc_text = nil
        end
        
        
        if acfmenupanel.CData.FuseSelect then
            acfmenupanel.CData.FuseSelect:Remove()
            acfmenupanel.CData.FuseSelect = nil           
        end
        
        if acfmenupanel.CData.FuseDesc_text then
            acfmenupanel.CData.FuseDesc_text:Remove()
            acfmenupanel.CData.FuseDesc_text = nil
        end
        
    
        ACFMissiles_RemoveMenuConfiguration("Fuse")
    
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
            SetMissileGUIEnabled( acfmenupanel, (Classes.GunClass[class].type == "missile") )
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