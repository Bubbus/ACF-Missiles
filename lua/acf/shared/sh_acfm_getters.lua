



function ACF_GetGunValue(bdata, val)

    bdata = (type(bdata) == "table" and bdata.Id) or bdata

    local guns = list.Get("ACFEnts").Guns
    local class = guns[bdata]

    if class then
        local ret 
        
        if class.round then ret = class.round[val] end
        if ret == nil then ret = class[val] end
        
        if ret ~= nil then
            return ret
        else
            local classes = list.Get("ACFClasses").GunClass
            class = classes[class.gunclass]

            if class then
                return class[val]
            end
        end
    end
    
end





function ACF_GetRackValue(rdata, val)

    rdata = (type(rdata) == "table" and rdata.Id) or rdata

    local guns = ACF.Weapons.Rack
    local class = guns[rdata]

    if class then        
        if class[val] ~= nil then
            return class[val]
        else
            local classes = ACF.Classes.Rack
            class = classes[class.gunclass]

            if class then
                return class[val]
            end
        end
    end
    
end