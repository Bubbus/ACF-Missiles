include("gitrc.lua")


function ACF_Missiles_VersionCheck()

    -- make sure version checker only runs for people who've installed the mod.
    if file.Exists("ACFMissiles_VCheck.txt", "GAME") then
        GitRC.CheckVersion("Bubbus", "ACF-Missiles", function(data)
            if not data.uptodate then
                chat.AddText(Color(255,0,0), "A newer version of ACF Missiles is available! (last updated ", Color(255, 128, 0), os.date("%d/%m/%Y", data.committime) , Color(255, 0, 0), ")")
                chat.AddText(Color(255,0,0), "Get the latest version at ", Color(255, 128, 0), "https://github.com/Bubbus/ACF-Missiles")
            else
                chat.AddText(Color(0,255,64), "ACF Missiles ", Color(0, 192, 42), "is up to date!")
            end
        end)
    end

end


hook.Add( "CreateMove", "acfm_versioncheck", function(move)
    
    if move:GetButtons() == 0 then return end
    
    hook.Remove("CreateMove", "acfm_versioncheck")
    
    timer.Simple(1, ACF_Missiles_VersionCheck)
    
end )