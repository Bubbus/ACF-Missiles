include("gitrc.lua")


function ACF_Missiles_VersionCheck()

    GitRC.CheckVersion("Bubbus", "ACF-Missiles", function(data)
        if not data.uptodate then
            chat.AddText(Color(255,0,0), "A newer version of ACF Missiles is available! (last updated ", Color(255, 128, 0), os.date("%d/%m/%Y", data.committime) , Color(255, 0, 0), ")")
            chat.AddText(Color(255,0,0), "Get the latest version at ", Color(255, 128, 0), "https://github.com/Bubbus/ACF-Missiles")
        end
	end)

end


hook.Add( "CreateMove", "acfm_versioncheck", function(move)
    
    if move:GetButtons() == 0 then return end
    
    hook.Remove("CreateMove", "acfm_versioncheck")
    
    timer.Simple(1, ACF_Missiles_VersionCheck)
    
end )