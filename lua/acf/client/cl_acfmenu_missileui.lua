function ACFMissiles_MenuSlider(Name, Desc, conCmd, combo, Min, Max)

    print(Min, Max)

	if not acfmenupanel["CData"][Name] then
		acfmenupanel["CData"][Name] = vgui.Create( "DNumSlider", acfmenupanel.CustomDisplay )
			acfmenupanel["CData"][Name].Label:SetSize( 0 ) --Note : this is intentional 
			--acfmenupanel["CData"][Name]:SetTall( 50 ) -- make the slider taller to fit the new label
			acfmenupanel["CData"][Name]:SetMin( Min )
			acfmenupanel["CData"][Name]:SetMax( Max )
			acfmenupanel["CData"][Name]:SetDecimals( 2 )
		acfmenupanel["CData"][Name.."_label"] = vgui.Create( "DLabel", acfmenupanel["CData"][Name]) -- recreating the label
			acfmenupanel["CData"][Name.."_label"]:SetPos( 0,0 )
			acfmenupanel["CData"][Name.."_label"]:SetText( Desc )
			acfmenupanel["CData"][Name.."_label"]:SizeToContents()
			acfmenupanel["CData"][Name.."_label"]:SetDark( true )
			acfmenupanel["CData"][Name].OnValueChanged = function( slider, val )
				ACFMissiles_SetCommand(combo, slider, conCmd)
			end
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"][Name] )
	end
	acfmenupanel["CData"][Name]:SetMin( Min ) 
	acfmenupanel["CData"][Name]:SetMax( Max )
	acfmenupanel["CData"][Name]:SetValue( Min )
	
	if not acfmenupanel["CData"][Name.."_text"] and Desc then
		acfmenupanel["CData"][Name.."_text"] = vgui.Create( "DLabel" )
			acfmenupanel["CData"][Name.."_text"]:SetText( Desc or "" )
			acfmenupanel["CData"][Name.."_text"]:SetDark( true )
			acfmenupanel["CData"][Name.."_text"]:SetTall( 20 )
		acfmenupanel.CustomDisplay:AddItem( acfmenupanel["CData"][Name.."_text"] )
	end
	acfmenupanel["CData"][Name.."_text"]:SetText( Desc )
	acfmenupanel["CData"][Name.."_text"]:SetSize( acfmenupanel.CustomDisplay:GetWide(), 10 )
	acfmenupanel["CData"][Name.."_text"]:SizeToContentsX()

end



function ACFMissiles_SetCommand(combo, slider, conCmd)

    if not slider then
        local name = combo:GetValue()
        RunConsoleCommand( conCmd, tostring(name) )
    else
        local name = combo:GetValue()
        local val = slider:GetValue()
        local value = math.Round(val, 3)
        RunConsoleCommand( conCmd, tostring(name) .. ":" .. tostring(value) )
    end

end



function ACFMissiles_RemoveMenuSlider(Name)
    if acfmenupanel["CData"][Name] then
        acfmenupanel["CData"][Name]:Remove()
        acfmenupanel["CData"][Name] = nil
    end
    
    if acfmenupanel["CData"][Name.."_label"] then
        acfmenupanel["CData"][Name.."_label"]:Remove()
        acfmenupanel["CData"][Name.."_label"] = nil
    end
    
    if acfmenupanel["CData"][Name.."_text"] then
        acfmenupanel["CData"][Name.."_text"]:Remove()
        acfmenupanel["CData"][Name.."_text"] = nil
    end
end



function ACFMissiles_CreateMenuConfiguration()
    ErrorNoHalt("TODO: ACFMissiles_CreateMenuConfiguration")
end


function ACFMissiles_RemoveMenuConfiguration()
    ErrorNoHalt("TODO: ACFMissiles_RemoveMenuConfiguration")
end