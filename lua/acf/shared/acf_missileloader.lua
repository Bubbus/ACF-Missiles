
-- This loads the files in the engine, gearbox, fuel, and gun folders!
-- Go edit those files instead of this one.
-- Thanks ferv <3


AddCSLuaFile()

ACF.Weapons.Rack = ACF.Weapons.Rack or {}
ACF.Classes.Rack = ACF.Classes.Rack or {}

local Racks =           ACF.Weapons.Rack
local RackClasses =     ACF.Classes.Rack


-- setup base classes
local gun_base = {
	ent = "acf_gun",
	type = "Guns"
}

local rack_base = {
	ent =   "acf_rack",
	type =  "Rack"
}



-- add gui stuff to base classes if this is client
if CLIENT then
	gun_base.guicreate = function( Panel, Table ) ACFGunGUICreate( Table ) end or nil
	gun_base.guiupdate = function() return end
end



function ACF_DefineRack( id, data )
	data.id = id
	table.Inherit( data, rack_base )
	Racks[ id ] = data
end


function ACF_DefineRackClass( id, data )
	data.id = id
	//table.Inherit( data, rack_base )
	RackClasses[ id ] = data
end



local Weapons = list.GetForEdit("ACFEnts")
local Classes = list.GetForEdit("ACFClasses")


-- some factory functions for defining ents
function ACF_defineGunClass( id, data )
	data.id = id
    
    Classes.GunClass[ id ] = data
	ACF.Classes.GunClass[ id ] = data
    
    if data.ammoBlacklist then
        for k, v in pairs(data.ammoBlacklist) do
            local ammobl = ACF.AmmoBlacklist[v]
            ammobl[#ammobl+1] = id
        end
    end
end




function ACF_defineGun( id, data )
	data.id = id
	data.round.id = id
	table.Inherit( data, gun_base )
    
	Weapons.Guns[ id ] = data
    ACF.Weapons.Guns[ id ] = data
end



-- Getters for guidance names, for use in missile definitions.


local function GetAllInTableExcept(tbl, list)

    for k, name in ipairs(list) do
        list[name] = k
        list[k] = nil
    end

    local ret = {}

    for name, _ in pairs(tbl) do
        if not list[name] then 
            ret[#ret+1] = name
        end
    end
    
    return ret
    
end



function ACF_GetAllGuidanceNames()

    local ret = {}

    for name, _ in pairs(ACF.Guidance) do
        ret[#ret+1] = name
    end
    
    return ret
    
end



function ACF_GetAllGuidanceNamesExcept(list)

    return GetAllInTableExcept(ACF.Guidance, list)
    
end




-- Getters for fuse names, for use in missile definitions.


function ACF_GetAllFuseNames()

    local ret = {}

    for name, _ in pairs(ACF.Fuse) do
        ret[#ret+1] = name
    end
    
    return ret
    
end



function ACF_GetAllFuseNamesExcept(list)

    return GetAllInTableExcept(ACF.Fuse, list)
    
end




aaa_IncludeShared("acf/shared/missiles")
aaa_IncludeShared("acf/shared/guns")



include("acf/shared/rounds/roundflare.lua")
ACF.RoundTypes = list.Get("ACFRoundTypes")
ACF.IdRounds = list.Get("ACFIdRounds")	--Lookup tables so i can get rounds classes from clientside with just an integer
