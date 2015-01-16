function ACFMissiles_MenuSlider(config, controlGroup, combo, conCmd)

    local slider = vgui.Create( "DNumSlider" )
        slider.Label:SetText(config.DisplayName or "")
        slider.Label:SetDark(true)
        slider:SetMin( config.Min )
        slider:SetMax( config.Max )
        slider:SetValue( config.Min )
        slider:SetDecimals( 2 )
        --slider:Dock(FILL)
        --slider:DockMargin(6,0,0,0)
        slider.Configurable = config
        
        slider.GetConfigValue = function( slider )
            return math.Round(slider:GetValue(), 3)
        end
        
        slider.OnValueChanged = function( slider, val )
            ACFMissiles_SetCommand(combo, controlGroup, conCmd)
        end
        
        controlGroup[#controlGroup+1] = slider
        
    return slider

end



function ACFMissiles_SetCommand(combo, controlGroup, conCmd)

    if not controlGroup then
        local name = combo:GetValue()
        RunConsoleCommand( conCmd, tostring(name) )
    else
        local name = combo:GetValue()
        local kvString = ""
        
        if #controlGroup > 0 then
            local i = 1
            repeat
                local control = controlGroup[i]
                kvString = kvString .. ":" .. control.Configurable.CommandName .. "=" .. tostring(control:GetConfigValue())
                i = i+1
            until i > #controlGroup
        end
        
        RunConsoleCommand( conCmd, tostring(name) .. tostring(kvString) )
    end

end



-- function ACFMissiles_RemoveMenuSlider(Name)
    -- if acfmenupanel["CData"][Name] then
        -- acfmenupanel["CData"][Name]:Remove()
        -- acfmenupanel["CData"][Name] = nil
    -- end
    
    -- if acfmenupanel["CData"][Name.."_label"] then
        -- acfmenupanel["CData"][Name.."_label"]:Remove()
        -- acfmenupanel["CData"][Name.."_label"] = nil
    -- end
    
    -- if acfmenupanel["CData"][Name.."_text"] then
        -- acfmenupanel["CData"][Name.."_text"]:Remove()
        -- acfmenupanel["CData"][Name.."_text"] = nil
    -- end
-- end




ACFMissiles_ConfigurationFactory = 
{
    number =    function(config, controlGroup, combo, conCmd) 
                    return ACFMissiles_MenuSlider(config, controlGroup, combo, conCmd)
                end
}



function ACFMissiles_CreateMenuConfiguration(tbl, combo, conCmd, existingPanel)
    
    local panel = existingPanel or vgui.Create("DScrollPanel")
    
    panel:Clear()
    
    if not tbl.Configurable or #tbl.Configurable < 1 then 
        panel:SetTall(0)
        return panel 
    end
    
    local controlGroup = {}
    
    local height = 0
    
    for _, config in pairs(tbl.Configurable) do
        local control = ACFMissiles_ConfigurationFactory[config.Type](config, controlGroup, combo, conCmd)
        control:SetPos(6, height)
        
        panel:Add(control)
        
        control:SetWide(panel:GetWide() - 6)   
        
        height = height + control:GetTall()
    end
    
    panel:SetTall(height + 2)
    
    combo.ControlGroup = controlGroup
    
    return panel
    
end


function ACFMissiles_RemoveMenuConfiguration()
    ErrorNoHalt("TODO: ACFMissiles_RemoveMenuConfiguration")
end