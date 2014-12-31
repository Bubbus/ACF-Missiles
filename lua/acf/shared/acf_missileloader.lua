
-- This loads the files in the engine, gearbox, fuel, and gun folders!
-- Go edit those files instead of this one.
-- Thanks ferv <3


AddCSLuaFile()

ACF.Weapons.Rack = ACF.Weapons.Rack or {}
ACF.Classes.Rack = ACF.Classes.Rack or {}

local Racks =           ACF.Weapons.Rack
local RackClasses =     ACF.Classes.Rack


local rack_base = {
	ent =   "acf_rack",
	type =  "Rack"
}


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

    for name, _ in pairs(ACF.Guidance) do
        ret[#ret+1] = name
    end
    
    return ret
    
end



function ACF_GetAllFuseNamesExcept(list)

    return GetAllInTableExcept(ACF.Guidance, list)
    
end




aaa_IncludeShared("acf/shared/missiles")
